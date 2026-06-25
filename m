Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9495BCDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 20:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcr7e-0005HV-95; Thu, 25 Jun 2026 16:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcr7d-0005H3-5c
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcr7c-00062O-08
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 16:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782420987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BE4o+rVLO3pnPI1/T+SuHah/7ntI2s8Q/xrUccHahmDWM74CWXCef5PMSp/2SAuDzJEkmh
 t710xLHShUI4zVRuEuXJWIM8NQO3TYb7asTvuql7KpUZ407m7RyZzYyUGisxGP4Wmlg+0D
 ONTjnfPseNBxjJeWW1gqndSLM9v/usY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-Veg9FvU1OYudK7NVHzkl0Q-1; Thu, 25 Jun 2026 16:56:26 -0400
X-MC-Unique: Veg9FvU1OYudK7NVHzkl0Q-1
X-Mimecast-MFC-AGG-ID: Veg9FvU1OYudK7NVHzkl0Q_1782420985
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso2073035e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782420985; x=1783025785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=jMXKsGDL95H0/gg8kBnVigWCiDDknU247NtlfWmBSzpiX1UHvo9+c/9nsUPXeIGZLr
 SSb1P4Mj2No9W63ZldS50uUaEsc71AFJKmsUknJawgoknAWbqsGDE14w/DyZRfmByeU+
 ScQVXUIw67mItXcL38Y33/NLiJOQz+XOndZCN4/nXCL7TMHSQqhCtg800iB1fW1o/zTU
 Zn8Dez4uR3LgYJZRjFQnjX72Beyz84ubKnMrmBISw7NIBOyJfX8OqbUSr7qIxZHcmpV3
 metXltZq+Ch4F/fvKRck00n79PD/A9k+hIVMS/SRVJsGEl5hvVbyl/nMpcBb+CETHJDY
 UeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420985; x=1783025785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BJG6EJZH7kBrDsLWL3mt2axVBeYSwsP2hAkfZ7qb7UiK7AcNGjLFu20r6sq8LEsB3P
 qbCOtTOHMT8+KxFzOVwOLrT83Q2uTvfRhUh4U73YwyWQt9n3XLrXNAg5RsyzVXN1Aoeo
 XBEAikqA8KOrSKP0QWGPeslMcJv8xUBr4v4V00X9a9a2rq4pIox49MHXhhfZuBsQmdad
 31n3Xq7J/568CiDI6ewqLn7EAZlYMwFDLAMiFTEcnsNTEWsSGzpJgbjnYMlSd6AU02f/
 hlOXMWmRpUNqLIoeVbKim1qDaKhnBP9pHqkQYnAXpaUIFGx7uI4+yH/ZgQPipfrhbk4n
 c+YQ==
X-Gm-Message-State: AOJu0YyrrsT56ZFWsUxnoC0akv3p0TBBSrIBkLTIryWKTnPXx8Os4Ioj
 ui9abFhU4sNbBLIQW7zQfl8soBSBqGJwRY1GTw5d+lPNL/uIvVTlEAgL5IDOBzGzW0mtCN+CoP0
 15Sel8msredKiusbc1gqR14wpJu4jkLc40XHI6TqfWKyTmM3GoNdflH5n
X-Gm-Gg: AfdE7clDV3ppEiAFiANT/QG9XNx2NX4lq3/YnCFDfMFkFlQpBjlup9UuufVfirbxzgN
 HshxxwaSQmBhE7+e6u1M0HJ7mYIsRkqjUz/5I+3u3VgtB44KOqgTDpWL8WKHhO+E+/M7U+ayt8g
 DfagH3bQqIbNVWEmfQA6+FmrVTfB4px62SEgdHt7k+Hbp7fyj0mNqtvYEbh9HAezUq814HrSrLW
 SuRqBdgkDBGDp2kJ22ksUj7usqppnEUnOMkHeaRlVZNb1fiIvrAhSn8rze1jaif6aRGZCIZfnwT
 Vd/MYuqOPqYnlin1brA061uWA9/qmnOXAeuZFkj8j940EbNl+4Y+ojdGfpS/O8S4cz0l1vIKNT9
 JjODNdqs8kK15rAy3OcCWsWi7GM+tIoD2n1z9++9UOdEhTk6yOZFcZHT6UEe1Yg/Sz+nMo5cj8U
 diDc6hxFXQcQeZ7vWk
X-Received: by 2002:a05:600c:c0d2:20b0:492:5855:1548 with SMTP id
 5b1f17b1804b1-492668933b1mr49117765e9.27.1782420984878; 
 Thu, 25 Jun 2026 13:56:24 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d2:20b0:492:5855:1548 with SMTP id
 5b1f17b1804b1-492668933b1mr49117665e9.27.1782420984591; 
 Thu, 25 Jun 2026 13:56:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926a6ff928sm6276185e9.1.2026.06.25.13.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:56:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH 0/3] i386/tdx: TDX cleanup and CPUID fixes
Date: Thu, 25 Jun 2026 22:56:22 +0200
Message-ID: <20260625205622.1676711-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512082108.621596-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Queued, thanks.

Paolo



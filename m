Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EA4C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9Xq-00020m-JU; Fri, 11 Jul 2025 04:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9Nh-0002DI-Oj
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua9Nf-00026y-BN
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752223517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gk3vGHDejppRiPXbD4y70hirt13MRsb3Dma+e41HoveYCGuX0Eg2KbXb4WxKJvy1/Fks7D
 aWQeMGz95h8rv2JpmXlveuNAx2E9IWSAHSTaoGB0EyPpICG4QzwwzO44Zx0PGyo22C4vGs
 Av3jGj7qa7NhYEc8PLobUgF2JMu+CBA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-ZiguOah5PWeWnQgK_sqZTg-1; Fri, 11 Jul 2025 04:45:15 -0400
X-MC-Unique: ZiguOah5PWeWnQgK_sqZTg-1
X-Mimecast-MFC-AGG-ID: ZiguOah5PWeWnQgK_sqZTg_1752223514
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ae1c79fb8a9so204044266b.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223514; x=1752828314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=AwiBa/bl2nWCX9iwsyEctv7KPMQYr/2eqENorq/hA6/QQnhl0P4NAPny80D8U4yZjv
 Z1hgvzxzufOB3d4yAdEpCDIUpobMlnHswcrlFHQ2gmIdPX9spXNJFqyhVY0++tts3qDD
 +urGlZiOlNF4o5eSZzTIlVwg9Pq3WltSTHfDoxKGcmlt2slgwVxDVwANqYIFtKNGWJAZ
 +KFVVtg5Sb8BLed1Z9Zai5leW9Yq6qxXZkRUh4EKkzde4XkYSiSFoKiYCwacS2jm1yRp
 kbrx3inrCdi2EgMWvBW+JTyKBD0DY2F2hszH447X4OCj40lW2vKDghQscRU3slu4zJ4Z
 otRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0590c8GSeb2LeHCHqJXsRj9rAvoD+8dpp+0q09sO1kWGntiCd0j5OykXI2T13OGnsQxdlPTpYa1Zp@nongnu.org
X-Gm-Message-State: AOJu0YwPrTajJGZE2bBxwo2Lq/SSlohL+IpNMRWOZmQoOdhX8U6nns42
 O/VLVK7re+lx3tr1Nz2X+fhX10krXsvW9u+1y7uqSXiMXS4HVBSUXWoYWQ1hEzEPYUnLGyisxLw
 Bo9Ol1Rf+UIi4C8aLYfhVKy03U1om50QUPhwX8xFh9ocCgArWVP35ajfx
X-Gm-Gg: ASbGnctdRa1HuwbQ6uWbC/cusB7HF/qN7o1UEzEZyWXqRZv44OTwOHTKfLQU+o4VG9v
 nltBLNzHcg6TAdpMIggUvOD7WFI8AucOlvluZt8ZiuSsCrgmN8iubnd61URTkKZ9T3sKB5tD9WV
 JYkJWbKaG1S+t7mZcZRsv5xde8wYqqldSB4jgSotZD/X+tSAfe2MVSx/frw3SisoOPQOIvv08LU
 Bqds6144CxMP8u9C3y8FC8ecUrEC4yDDzXPXlwZ2dLVlu8s8rwGYOuAmQoYOyZtAvq1GT3Q7imn
 Epcj/gTvZJpAZseUGHKEQAG0/cBrl9haa4BiNNuiRZ8QLmDMF3u1vaeKPXj0hVhEN9cmIQJQXQ=
 =
X-Received: by 2002:a17:907:cd07:b0:ae3:64ec:5eb0 with SMTP id
 a640c23a62f3a-ae6fbc55069mr243433966b.11.1752223514524; 
 Fri, 11 Jul 2025 01:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKhacqgtaAVSFAsIUT0fwfb5gTQFC880+fEsTr7024y7loKSRc/btQFGd6xMa+dazfoWvAWA==
X-Received: by 2002:a17:907:cd07:b0:ae3:64ec:5eb0 with SMTP id
 a640c23a62f3a-ae6fbc55069mr243431166b.11.1752223514117; 
 Fri, 11 Jul 2025 01:45:14 -0700 (PDT)
Received: from [10.35.88.123] (93-44-61-216.ip95.fastwebnet.it. [93.44.61.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e82645f2sm257700066b.89.2025.07.11.01.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 01:45:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] i386/tdx: Build TDX only for 64-bit target
Date: Fri, 11 Jul 2025 10:45:06 +0200
Message-ID: <20250711084506.458132-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625073310.2796298-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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



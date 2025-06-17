Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABBFC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 18:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRae9-0001sX-Va; Tue, 17 Jun 2025 14:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRae7-0001jb-GJ
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRae5-0002g3-IH
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 14:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750183372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ZDVgS7Ol08c/QUybwFZsWR+uvzqneB+tnpD9Hnq5qTwoaH6JUcn+SPXfiR2stMwQdyViUY
 AfMh9ZcNlRMC6cAunzj+E3E8j35Gg5plrNXWDTYAaTXPQDgaUmSti4HT+10Csqvy9PGsvZ
 G4lhze4wn7Cd7rtzavsN0AwLiKqev70=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-GswOMfNxOjmEsBE1rPWV-g-1; Tue, 17 Jun 2025 14:02:51 -0400
X-MC-Unique: GswOMfNxOjmEsBE1rPWV-g-1
X-Mimecast-MFC-AGG-ID: GswOMfNxOjmEsBE1rPWV-g_1750183370
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450cf229025so21416575e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 11:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750183370; x=1750788170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=QsNIjRMQHCqOYeasw17NJ+8IdqhEO316d38nwzeDmTJtOXetWG0El3bcALfMqqAajL
 8D+Ddip6vbkBOLscajgyPa1ug3OYU8Ox441gQHSN5LAtfnda897Hr/uj6kJ9vLHkhyuf
 GZet+VSFR8RZeokMNZyo0dvaUQYw8Km6kFCTA8zp2ihGDE/91I1PaEuy1fHdD2nZeJ3M
 nMOGHTs6R6L6L9Qo4tG+cv+I8RGM0TLTKrtYestM0YEw3Rn66xRHr9ESndCpdlHITYvO
 e1qALrFcRh+F+udMI9SUiqZvY0iikdj0CaleVZ4tPUbIgUqGbkWMiuVMmnFQUTUmFRl0
 qk2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCVG+3Yd+JX4bkrme/+12TJz+BgZ5xstDu+3DONkzTavqJQbdeyzohFCKKzF4WAZfscVuOG2nxqYCJ@nongnu.org
X-Gm-Message-State: AOJu0Yz0RaCHbbrTO+6GKT1lTtTOMda/vdJa4E4khyfYgjspxjZemkd2
 T/ysgCKjmXelamKtRIEANnN4gXPpXwroaQaWKPjWTQHY2ucnjkUGrQqpt8FObKtNTJ8uM9KRIBy
 MIfSL8PY7yiZh2s0EGk14C6rQVNra+vwr43OlOChkU5aySJ1luB3OK/M86AOh5AL6
X-Gm-Gg: ASbGncvryT2pFXFO5yVwSrFVyFqeSdSBlbn7Y9lwArkSd/iFeUX2d7noppvF5f0yaV+
 BiZt1rJ3wj+KENz6wdR1EUw4E4vR/zh7F3mv2hsyDvGx3mOsWdJAZV+xYIs0bgYhdx4SZsQTgVA
 zyfnMP03DRjkiYJri69qz75RWLiCOtv8OvNvQgyururKa2giCAeW+wwjloN6RiUt+koVKNBbEYB
 A0PJxP+lLJjwkQp4I8WKjXaRPOQSthdDOaXcZwZIHdzkT8+QjNV1nFy/343NwbPwT4gDG+K1lmM
 frcp871q878kXf5/L5sI+YUUHiU=
X-Received: by 2002:a05:600c:8b66:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-4533cb0c164mr113005555e9.24.1750183369956; 
 Tue, 17 Jun 2025 11:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJvvGHy6bUa89JG/xh9WOQXCnn15NAKpJHNNuBg/UBZVlX2a2CA0FXstDSJp36fnEdedloWQ==
X-Received: by 2002:a05:600c:8b66:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-4533cb0c164mr113005065e9.24.1750183369450; 
 Tue, 17 Jun 2025 11:02:49 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.88.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b2b113sm14644738f8f.75.2025.06.17.11.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 11:02:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] TDX: Fix and enhancement
Date: Tue, 17 Jun 2025 20:02:45 +0200
Message-ID: <20250617180245.270369-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603050305.1704586-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



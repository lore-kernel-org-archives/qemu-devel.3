Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B2510D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B8b-00030F-SV; Mon, 30 Mar 2026 07:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8V-0002qN-4V
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8S-0005uD-OR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4x2nEljhP4GBRpi+aWlvnI5jZW7bysIFD+mCf4NR8SU=;
 b=Zq9MYUxXKRphXL6UxsMRcsCyhpu0T8Ar2T/wHCRjDzPYQUnZE5HIBZOsCMuUEmfLJp6SSX
 fOdJjo8Ccjt19FAysGEVvHYz/3Gjo/EvflRHYBbHGvLkJky3SmqcXEFjvTBrxTHGykxFAM
 OxvY4PFlyXRaK22ICW708a2ztGuadms=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-jZDT2V4SN829-9ox_zGCQg-1; Mon, 30 Mar 2026 07:50:22 -0400
X-MC-Unique: jZDT2V4SN829-9ox_zGCQg-1
X-Mimecast-MFC-AGG-ID: jZDT2V4SN829-9ox_zGCQg_1774871421
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-486fe36cf73so33473365e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871420; x=1775476220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4x2nEljhP4GBRpi+aWlvnI5jZW7bysIFD+mCf4NR8SU=;
 b=OqxUgRmmoK726ycInFFXbuMTZpxFFH05PULCdvmezA2qcFP/x+4ygl0K6eYnlJOOpE
 8NuH2QblGdyYdwP93aFtX+nOXx8n1lsHnQuGaSvRCA7CbHLMqVOyEiGIrB8tlaR1VNSe
 5bQa52W2mNDuZ2zXLF3m2uZJ5ifs8uYtqshTRqsY//wXYXgvq4Y9yoj5L66AC9enFe+F
 GVtCBj4sUSq/zhW4YYVM46rf+Tg70yNgLBcKJFfx0f6HA8gu/CRh2MMuSSihEk8YVmtb
 sLhZv659KQVMxzwGSo41jw3WXRFb4DBFneEgAxc8ibPHJb3lWbYIIdCMnVhcmCLatKKK
 6fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871420; x=1775476220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4x2nEljhP4GBRpi+aWlvnI5jZW7bysIFD+mCf4NR8SU=;
 b=F9O4AkyA2rFOYH0qs/g0AOrdUOj2NRIaYjOOe3udOb7gWIwuGfkeloaYTEwrDkZ4FB
 b49Zqe3GtyX25U1CtjIErPJBnLT+FMvzjJmrD1RFhX7lFs+DzGOCDdPG8M0AWrZiJ2Lj
 Hh75XhPksu2nsFPUnLp0MvzfuqVpsiPmmygL23OOtTbAUH0ngwO1lfjH6OoSz2Ljy3i6
 7TLMiyzftZmr0sDsTY8yq+2TIS+d3yGpX/joHcPUxIF51NuZLeM4yaPj7VdsMlLwd1Qm
 eJbfmm6XcAj/Qx1zwz60AL8xSLrX1HU2gwXfaj0nPiBqF3+UE0EdX0AQOPkViLnfDtKO
 DvQA==
X-Gm-Message-State: AOJu0YwXLxksVbpMcmz2s6FMgCnTEceBHNQeQhYaoxKHb+uvQBxmO1Im
 nMvmuaKc+6CO5B+ZM5BqBoHyjRGqGP9XC6oCUVHAjjO0wjnY6YEUmzzYL39TRMXmHO3OV7LQtJ8
 OXodENFVmEGI4ackDkz7Ljq7+lenbg45B2nJm8mVYdT1sNOL1Up50Njp874l5nsZI+nTOOvKAfo
 HnaLnbXM+1YJXQmkf9UqWnAoSWso2ln7WWnfWf8x68
X-Gm-Gg: ATEYQzxh34w30dljNluty/lVKsjqvKsAc3el1JJ0ZSDRi512GTfgRxmKkwnF5QrMkP3
 DwQCr+4L3xksTUNO2pVlwQuLbIIITckEn/2AVqHG3kvEj5Tvf3zPIgRiAJK5pdqp2r68MJnJLN5
 VdnV6drS2VelyJdoN0iE389CsYKLgstuF4ZE/EMH48hpLACsYVx9zdDQufctD9Gi8wPJ1U/l9ur
 Ko5MNiLwTkhJk/S5lRt2X2KCpA2Ye1NiDIgV9NYfq1rKNiw24AOF2mwHH3EEvMjlDxvt/DAEzNT
 iWtisl2G1/AB8qazaZYbySJOOdbHgzV+so6Jys0AdBVqpGmOgqs+XyrTV9az7iccvTTgUzO6Xvw
 tL1cOoCKwrDMgK82K/1EGZnewkS8y1VOGXWsAJtc+WwElPQeHw1i21Il12AHvpRofObERJ6NyPs
 n38FpVmLBvrEzFSMKMKKw+q/wD
X-Received: by 2002:a05:600c:4e08:b0:485:363b:fafe with SMTP id
 5b1f17b1804b1-48727d5e971mr219190425e9.1.1774871420226; 
 Mon, 30 Mar 2026 04:50:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4e08:b0:485:363b:fafe with SMTP id
 5b1f17b1804b1-48727d5e971mr219189785e9.1.1774871419685; 
 Mon, 30 Mar 2026 04:50:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48730688605sm283026285e9.10.2026.03.30.04.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 01/12] meson.build: remove i386-softmmu WHPX support
Date: Mon, 30 Mar 2026 13:50:05 +0200
Message-ID: <20260330115017.256211-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

target/i386/emulate is pretty much incompatible
with i386-softmmu and fixing that doesn't look
worthwhile given the binary unification goals...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260327011152.4126-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d7c4095b395..407eef5b4ed 100644
--- a/meson.build
+++ b/meson.build
@@ -314,7 +314,7 @@ elif cpu == 'x86_64'
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_NITRO': ['x86_64-softmmu'],
     'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
-    'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_WHPX': ['x86_64-softmmu'],
     'CONFIG_MSHV': ['x86_64-softmmu'],
   }
 endif
-- 
2.53.0



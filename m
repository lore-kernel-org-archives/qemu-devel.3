Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AE3C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyM1-0000pI-UA; Fri, 31 May 2024 05:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyM0-0000ok-8S
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sCyLy-0006W1-NM
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717146913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0iCPw/aqWN8zcOT16VkOuLHlxKNp/9HKpMSxNCRXQc=;
 b=iAcOuSW8/bcXomIfxTiJ7Ye5zPDEzenmFhJ+ltTkFC5s8AgtFzOM/fYeiStLwmZQ271M/N
 fKrgQXfLgs6IVZZvQQPLZjLvFwsV1f1AWQ5Zbq6FlEJogM/4mpcjee28gPLWWq25l620wg
 AvrApmOT2PiPPt897p0ZERS9wsBjfVU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-T26x54MhNbKGb94oZ_tEnQ-1; Fri, 31 May 2024 05:15:11 -0400
X-MC-Unique: T26x54MhNbKGb94oZ_tEnQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a3d65737bso236371a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146910; x=1717751710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0iCPw/aqWN8zcOT16VkOuLHlxKNp/9HKpMSxNCRXQc=;
 b=o87s4NQNE440xPx42i9RtOvsd3v2JfrlpKuFgbCLJHG3muZevtL9l3QJpg19SAqpi5
 qrA209Zb61bW+Aj21biQdKLhRY2ryLJ9B9gpcBo5xRZNrrmiQRn3YIiZHEFpKzZiQ4cW
 r00R/N1Q813jfZKB2KC+p4JvPCv+0GQyfKNTlm2pfln/GrMROEIBWDCj9NSOzqaoi4BG
 9cW/cW+xLvskchHukTRi0VKUv8HRciYKGEXRRkrBrYkaDNAjNE7OtA1+sN9uo04+fzBj
 Gi97jJqP7l89ONeUTeFtNtrrhzgh1f9OzfPM9jcyA3QI8vDm6PGvpdx0w9KZwcGSgPby
 TXUg==
X-Gm-Message-State: AOJu0YykoZDFtrUhBBKAX7lDQy7TyGnz3CzNjUG/s0I5rhv2od6CdYAU
 BcFiORwKufrAGuij2zSQyOHSu/rBDQH17SECFkfIzNB/bsN6gR9f8Dqos5/9yact/YQ+EBcE/5z
 W95O8OFmDtOFfw/fhwHHO62gLadAILq0oX4YY3TO2EZG8RhP+CbiAAX0TU4OeQ387mpIPLr0ioJ
 EN9SZAfs8Hdze+dEi2k9KdsmgUN+m49rqFgmmQ
X-Received: by 2002:a50:d69b:0:b0:57a:1fef:619e with SMTP id
 4fb4d7f45d1cf-57a363fcc53mr831542a12.18.1717146910320; 
 Fri, 31 May 2024 02:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX43JL8KA55J2SbY7pzO+Tbo00RiKv/sIy6o64qXi0u/JC7e3+p3KGhybDaeT6/Poj61pWBQ==
X-Received: by 2002:a50:d69b:0:b0:57a:1fef:619e with SMTP id
 4fb4d7f45d1cf-57a363fcc53mr831524a12.18.1717146909857; 
 Fri, 31 May 2024 02:15:09 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bb8282sm763545a12.25.2024.05.31.02.15.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 02:15:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] host/i386: assume presence of SSE2
Date: Fri, 31 May 2024 11:14:55 +0200
Message-ID: <20240531091457.42200-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531091457.42200-1-pbonzini@redhat.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU now requires an x86-64-v2 host, which has SSE2.
Use it freely in buffer_is_zero.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h | 1 -
 util/bufferiszero.c              | 2 +-
 util/cpuinfo-i386.c              | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 81771733eaa..72f6fad61e5 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -14,7 +14,6 @@
 #define CPUINFO_POPCNT          (1u << 4)
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
-#define CPUINFO_SSE2            (1u << 7)
 #define CPUINFO_AVX1            (1u << 9)
 #define CPUINFO_AVX2            (1u << 10)
 #define CPUINFO_AVX512F         (1u << 11)
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 74864f7b782..6245976eca1 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -195,7 +195,7 @@ static unsigned best_accel(void)
         return 2;
     }
 #endif
-    return info & CPUINFO_SSE2 ? 1 : 0;
+    return 1;
 }
 
 #elif defined(__aarch64__) && defined(__ARM_NEON)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 90f92a42dc8..ca74ef04f54 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -34,7 +34,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 
-        info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
-- 
2.45.1



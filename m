Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49F8C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENuQ-00021c-VT; Tue, 04 Jun 2024 02:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuP-0001yG-8F
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuN-0007Fy-SF
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqRHhSmhqOho/JuUmdj0d/FeC7VO5aHrFPmub5RDLS4=;
 b=Rbezkeyobzv/6HzpBzKnt5aFcal+lzXjvz7vN3zSWRFFoUqMQFeaJp18Zj8XT8yej8Lh9U
 TKi7NjeaW/Aah+BFY5zQ8AcV5tcUP8f+ZlhcXV9TpNV7oW3eTDp5pIvhCBQKAzNzHG8maM
 N2FmNqZShkSm9l+bTZ0jJmDuKF/JnCc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-2qL_hYraOFi54CkWPV7QBg-1; Tue, 04 Jun 2024 02:44:33 -0400
X-MC-Unique: 2qL_hYraOFi54CkWPV7QBg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57a2ffddca3so1672431a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483471; x=1718088271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqRHhSmhqOho/JuUmdj0d/FeC7VO5aHrFPmub5RDLS4=;
 b=lete7xyYFnpkVF0BErb0QxnJYE7ZctZBSBRgpVAzf3ftzSPJFJ8xPKA1rDDF/E8ldN
 lYo9PuU50ar7C9zrbZI9zHUBqLLLJ5Ugly1jNBZqYKltp0E36BbM4ryflu8PzNFHc0Ix
 njnK5VDnLsAeFlhb0526ShF1w4IMcA1rh5p1pNywePEVozjrzHybyo8+yPwhvL7eAlrz
 iF3vzWhJyAP9zcWRvAYgHqvQNSA09eCTTEjWGCP7vs2lqi3KGEgktRM7oBawXqDFokyL
 FcvXOSNpYaJHHa+fFJ/nDB8SFLqp9CxcjKVquj7YPwGWOVmPBJrTsVHsEAoCVRhzimtE
 VZJw==
X-Gm-Message-State: AOJu0YzB9no2hNeQswaEWDB/7atQ9K7DVb8qgJwCAU0W3i6W0BbrtiOw
 nCBzM6bfOIGKspmpuCrzYhYwIvM22R5LEHD1DZmiXkXHcuwnsMoLCFRIUGxLqBFO4nARY2XAO6t
 Z1clfGi2keeFOn5bA6WxlfoWAs+yCScWRXCtZe1t0nsBUQ5CKXSb3I54xBC1EzbrxtfiwgVrnPJ
 FM6p/WL+t+mZF3fnHay+rHKMNhyrlst5jNH3+R
X-Received: by 2002:a50:9f41:0:b0:57a:2430:67eb with SMTP id
 4fb4d7f45d1cf-57a3644b40bmr7453367a12.28.1717483471490; 
 Mon, 03 Jun 2024 23:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGA0z2vvrlFgK78vmDfXqJwIIeaAq8LZ9Rzbnn9oHKA08nVRPptFoJ025pkNZAEbfFlZBTRw==
X-Received: by 2002:a50:9f41:0:b0:57a:2430:67eb with SMTP id
 4fb4d7f45d1cf-57a3644b40bmr7453360a12.28.1717483471097; 
 Mon, 03 Jun 2024 23:44:31 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a5dc1e2d6sm3753569a12.59.2024.06.03.23.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/45] host/i386: assume presence of SSSE3
Date: Tue,  4 Jun 2024 08:43:30 +0200
Message-ID: <20240604064409.957105-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

QEMU now requires an x86-64-v2 host, which has SSSE3 instructions
(notably, PSHUFB which is used by QEMU's AES implementation).
Do not bother checking it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/cpuinfo-i386.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index ca74ef04f54..6d474a6259a 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -38,8 +38,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
-        /* Our AES support requires PSHUFB as well. */
-        info |= ((c & bit_AES) && (c & bit_SSSE3) ? CPUINFO_AES : 0);
+        /* NOTE: our AES support requires SSSE3 (PSHUFB) as well. */
+        info |= (c & bit_AES) ? CPUINFO_AES : 0;
 
         /* For AVX features, we must check available and usable. */
         if ((c & bit_AVX) && (c & bit_OSXSAVE)) {
-- 
2.45.1



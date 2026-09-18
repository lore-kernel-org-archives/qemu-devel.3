Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D390C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Wwp-0000Tk-2S; Fri, 18 Sep 2026 07:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7Wwn-0000T9-7W
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7Wwl-0001fS-LO
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBaGuPoDATCVPFdrrPM5ytWeOyh4lWlPorysTKBYkuo=;
 b=cggX5IOYARo/Zg0pJR2udkyJ874QYauyxkFT6QU9WwUPyryCAn1ffvPI6A+V0Dj5y5s2Me
 1NKyQOD6uJilHJ7wlaZN67fVZi6xjarnRJP34OY59qXUa3gllfYheGixlyzaQgNqmTYxCJ
 r6COKrFd2DC4nyZ7tQ6PvIofEiMNe3w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-ZEKKeXxONwWV7BBeMmp9Sw-1; Fri, 18 Sep 2026 07:40:01 -0400
X-MC-Unique: ZEKKeXxONwWV7BBeMmp9Sw-1
X-Mimecast-MFC-AGG-ID: ZEKKeXxONwWV7BBeMmp9Sw_1789731601
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91049eac948so10366536d6.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731601; x=1790336401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PBaGuPoDATCVPFdrrPM5ytWeOyh4lWlPorysTKBYkuo=;
 b=ruoTRGkqzPqnYiVNjxbsMk6S4/qOgjahETkMvzi5XqUkEOaT8Ek+cpFAzqJzearC/U
 zgSu0vyMRJ9APgNhvHpRH5B/t+x5QVAjqzFMqze4KKmdGlzF4eT68MA/OaqdKdR4m8Ak
 nxujyZJ7/VOnUKzQpz8VuR1KKziEe6jaGnjECGMoMm9hslVVLYf/bQT3wnMe/p5pFahx
 2xKp6esCSPKo5eY0roryimkGYcr+Vqsid4/2xa3E+P00Xj8+8P8GQj4bCKeZ9jzf3HhH
 YKDOZ6FAfgYWZQnfvEeYJ7egaWbZE5rdN1yCMV0ouIER1LZ/vHyy/8qmd+7oADHyS4MB
 aiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731601; x=1790336401;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PBaGuPoDATCVPFdrrPM5ytWeOyh4lWlPorysTKBYkuo=;
 b=0dwLs1dvDVGtrKAWo3J/C5HA6cvn1VhQG7kmYHZkD06xUZnbn+hxlCQusMOKD158Xx
 Arx02cE7AnLq7r0Okzk6DTRi+LX1C6grFzoChjLbHaO55lkdkJgblisv6GjWtK6QNSN7
 domdJ9hQILLbVSGwVZQ0axNYpHTj396n69wn77bv1vziSOORMH95uQjdzzdxSMw/hFDc
 QlJrDA6yZB+nk2pWKrzK7WU2htOLUN++P2BjQDy+uZJdu7lLhMocclLsIPnQqlQ76bvQ
 gNmfFPuEyR/a1lzbxA4GYqSMyEqec1pMSnFdDBFYKiMaWDD7pezYR6c2111f/6JHVmHr
 b+tw==
X-Gm-Message-State: AFuF++kCpFnuCgEUpvENEB1N0Us3wGhUrvNgAKhNIP0aaTOpzbSUNbt5
 vB70zZ5x7jQVEeYKB+j7JICwxe1cS8x2Xf466vf+uJzpHNjvQ9TmogR7vnFxrpPH9nNk5GNDgBl
 kBxZNRappG5LgLrHsqKMQ8fSleC7CaMgGP8IrD5u461FZm58Ah+1zpPH36PkGLvbvJOIiT5pKyj
 0Yk1vki/IZHFjupL4K7kvM366o+7VfjcK0CGq6PGEI
X-Gm-Gg: AYBFou1xMnK6AEIJG7Ld4oQFsMTsXsB5QycfWzdP0jAJBEsVT4Z1Cke67O9PyR0s/Xe
 sYzE51szWsAmhSR0WibGeQqKUGGFTcZpvdxC7bDctRxQIp6uOMGgtCS2qhMXXGHBRF33jrgjG61
 pWAZpbQhBAOIRvYtBFgcOejfp5PT9YyOL8Os/cQvToNlDFv78++yIafxbuHI+DMzokRV2imvKMM
 28IbLcdn3/hIRK07vRAPbYxGi4jsp43alAzC9mPLu8W6y/GLf5bbZR4/q88qGjHbf0+U2UKwWxw
 R2xwyq2u+SC/dSTXIvz+a1ejU+Zbk2azg2K6RCouANQKzwzmc2TKahMjQjKJywGiXfvU
X-Received: by 2002:a05:6214:3b81:b0:910:39f5:3747 with SMTP id
 6a1803df08f44-91254b3a7e7mr32247876d6.2.1789731601221; 
 Fri, 18 Sep 2026 04:40:01 -0700 (PDT)
X-Received: by 2002:a05:6214:3b81:b0:910:39f5:3747 with SMTP id
 6a1803df08f44-91254b3a7e7mr32247496d6.2.1789731600685; 
 Fri, 18 Sep 2026 04:40:00 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9125800d789sm10562956d6.17.2026.09.18.04.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:39:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PULL 03/11] arm/mps: Remove 32bit define for MPS3_DDR_SIZE
Date: Fri, 18 Sep 2026 07:39:18 -0400
Message-ID: <20260918113926.831204-4-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918113926.831204-1-peterx@redhat.com>
References: <20260918113926.831204-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QEMU has switched to 64bit-only hosts for all system emulations.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260818172012.3052821-4-peterx@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/arm/mps2-tz.c | 9 ---------
 hw/arm/mps3r.c   | 8 --------
 2 files changed, 17 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 4e6744eddf..7f41a74df1 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -190,16 +190,7 @@ OBJECT_DECLARE_TYPE(MPS2TZMachineState, MPS2TZMachineClass, MPS2TZ_MACHINE)
 
 /* Slow 32Khz S32KCLK frequency in Hz */
 #define S32KCLK_FRQ (32 * 1000)
-
-/*
- * The MPS3 DDR is 2GiB, but on a 32-bit host QEMU doesn't permit
- * emulation of that much guest RAM, so artificially make it smaller.
- */
-#if HOST_LONG_BITS == 32
-#define MPS3_DDR_SIZE (1 * GiB)
-#else
 #define MPS3_DDR_SIZE (2 * GiB)
-#endif
 
 /* For cpu{0,1}_mpu_{ns,s}, means "leave at SSE's default value" */
 #define MPU_REGION_DEFAULT UINT32_MAX
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index eedb877e4b..4bd5d83d56 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -58,15 +58,7 @@ typedef struct RAMInfo {
     int flags;
 } RAMInfo;
 
-/*
- * The MPS3 DDR is 3GiB, but on a 32-bit host QEMU doesn't permit
- * emulation of that much guest RAM, so artificially make it smaller.
- */
-#if HOST_LONG_BITS == 32
-#define MPS3_DDR_SIZE (1 * GiB)
-#else
 #define MPS3_DDR_SIZE (3 * GiB)
-#endif
 
 /*
  * Flag values:
-- 
2.55.0



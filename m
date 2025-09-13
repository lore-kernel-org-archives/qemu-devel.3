Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3F5CAC58F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLKf-0005g5-Nq; Sat, 13 Sep 2025 04:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKe-0005fn-16
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKc-0004cV-3l
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWm914yPu/Z+1a+QMagwFJTO39uJw4aRXD1IlivLAnM=;
 b=bqYs64GPO++HxZlL8PSdIaOh249RkUgS/lnZ3yBXH2k9ySJ0EtFZ8dR/C/SECws3a/HSWO
 NoFK5e20D+Hi7hLntYtjEztfrPpuvOZ+K+9KFd34GPHI+IQ4k2V0l80ocI0lDNKDOB4CWG
 Ki3PQbgdaZc9oLiybsynM7F662aVDJo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-olBgyKM6MlCsKYtV30cC1w-1; Sat, 13 Sep 2025 04:09:59 -0400
X-MC-Unique: olBgyKM6MlCsKYtV30cC1w-1
X-Mimecast-MFC-AGG-ID: olBgyKM6MlCsKYtV30cC1w_1757750998
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3dabec38299so1607349f8f.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757750997; x=1758355797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWm914yPu/Z+1a+QMagwFJTO39uJw4aRXD1IlivLAnM=;
 b=E5EUveW/7CL7OgYyrla3CCkBlbK2r8DZVJ/eedxwMsOxUtlApToQi8oVpuDSb6ADbz
 Q16P59+h5w7H3170IWrACu00GPHDUsR3ddJfWTjGZSd0GVO755oZQlk+FCgjO72m4DTC
 lB2BbDlJrNF1WVPR3dvC5zMuN8vdoHAEvCm71QkREnItok3bF3qmM63EypgbxwDRmYGH
 9qPZju3q1E5Y7/iJc2WArnHK0YvEkaYhvsePkivRHcUJY/x4dCN0LaU2LVB5PkuKWLBg
 LJdmnzz0PV1JEdkp3fUAsHSndsyUT7gQbPUFMK5+j79JBZNQAMOzw8BTB3hZaD8YiOGb
 g6ug==
X-Gm-Message-State: AOJu0YytyHuenjdi97DYY7X7rNiNZXL93acVLjpUOUJf9bYCX9cngVfK
 fZ3ISyneRTMq3Cnm9yGDufPSLKXsMTnIXhpEbrFaXeiEr3NgpR70Qv1pjlSp7hLG8ApbV5t1c2D
 xB5UsP9ldrDCB3ijHG1U1ebgR0aabc9QBzLc4TH3SbP/A3VCddSALda2WLdUfJgbxuwYPkp3iqC
 ymlR4/gwojjgdAb6bOjQlfDNPvEMCyAbksG3D2vHRu
X-Gm-Gg: ASbGncue9N8VTY4aMHbCfH1qVod1mKbTZjmZyFDpEiFlvmJ6kBCztPahE+FQInm2fVe
 G8Mj/HljBI4pdZMu/cJCqnzcpD9lDCBg8VokQfJFL/ZmI8CrePt2PzpP5gmJBtZXStpz+W/evNL
 AoQwxszT7wNGb9eMSq+3USxYzWvXHZ2fFWyMJoLwK6088J97BMQ5OlSOA9akQzYLcX19TtFbrcg
 CEQVFy0pzk53fCtsBMfWXhx2GLi+2jcet86cUk+UoUkpAnm6fgE5mu1V4Xc8muHXebSJJ8x98Eu
 YQdC9LWvt4Zh7EwktZemBUr6s34Ob1PPTPilNx8I4GKJDubvS3887irYOdKMOnPK/CCtjoiFhpF
 qnWKlAVeQ4jLqdx88tQFyMqXnV7+S8P9y5jK84Y1wJPk=
X-Received: by 2002:a05:6000:144f:b0:3de:e787:5d5e with SMTP id
 ffacd0b85a97d-3e765a1a385mr5087006f8f.43.1757750996883; 
 Sat, 13 Sep 2025 01:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWsm8/EJ/2e70uq67lxWQjruKn8/omH62DVAGFEpbetoiKRTOCfSxK/V2G0P5RiORJABl04w==
X-Received: by 2002:a05:6000:144f:b0:3de:e787:5d5e with SMTP id
 ffacd0b85a97d-3e765a1a385mr5086978f8f.43.1757750996478; 
 Sat, 13 Sep 2025 01:09:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0372bbd3sm88554145e9.10.2025.09.13.01.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:09:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/61] user-exec: remove cpu_interrupt() stub
Date: Sat, 13 Sep 2025 10:08:46 +0200
Message-ID: <20250913080943.11710-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/user-exec.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 748bfab04a7..66c25fba7dd 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -46,11 +46,6 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
-void cpu_interrupt(CPUState *cpu, int mask)
-{
-    g_assert_not_reached();
-}
-
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
-- 
2.51.0



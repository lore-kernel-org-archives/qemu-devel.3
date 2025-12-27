Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011B0E8FDDC
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQwv-0001kz-Sd; Sat, 27 Dec 2025 04:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwU-00019v-Rk
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwQ-0007M4-KP
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9TptaX08wUl7FPReV+B8RM7uBdS9EZmZexlTsKMa84=;
 b=CyjNt19Rdm9axEx/FC5B3O1w36NA5Xpt2BDI5jQixY2KrgBdCnkJ1b/mi6N078zEpC4aXl
 N/5vR6iThATUY+ideMsEmajL21refaTvLQ0WCrYhtT6l4+/ks3QoaFvBj0ehe2KeUXOP9K
 C4heHho9HztP3eVy1AdSMDN08I9ZBSI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-VAT3ejKUNhul-OQhcrz9Ow-1; Sat, 27 Dec 2025 04:50:25 -0500
X-MC-Unique: VAT3ejKUNhul-OQhcrz9Ow-1
X-Mimecast-MFC-AGG-ID: VAT3ejKUNhul-OQhcrz9Ow_1766829024
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a49cso30843015e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829023; x=1767433823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9TptaX08wUl7FPReV+B8RM7uBdS9EZmZexlTsKMa84=;
 b=rv9AxCm4zZocQszUM8R5dLkXdBdVuTW5/6RL33tedxOgfAYH4NtZVP1KgKHxd30jiK
 k/1Nwz7a201opULVvzkU5Hyw438wKHMgFRrPGATvMrePLMatBduw8SrZJfuqJJHKHGaG
 o6dOyrrHna2MM18Eu9tQyTZNxqqtPftdZQKTtaqj7+tA6azmdL8IyNybS1EmViILQzeR
 zK/K9jrgg3d7XtgCrsQyU8p/9ri9g4AKSQrOab0urVfzmGHuyU97BpS9QqulGv8/YBmD
 HR+VbgqHDMeP0DlIwv4GgHFX7Qu8b66Enxtv4VRZNE3yQfYvkBQpT7DKcn5kIaA+eVf/
 aIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829023; x=1767433823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G9TptaX08wUl7FPReV+B8RM7uBdS9EZmZexlTsKMa84=;
 b=Upn2E5xT/BFm0ozqprEm3eqiCq8YyC06Tn2UTMjGM8CCVbHxomlMQ8/MxTJLfnYULZ
 y5ad6vasv7F3e4sEMbYNXjJsPev/8lU2zgx7sgHU99ZrPHkfdoPcVr2DFA5Ag9io4xbX
 QsR99oLwotTZ/ZrWVgewYxC679jMDVE/OLG0LqFqQc2YnkwFinIjmmKhF5Hhk5s8/eJl
 WfkUlZdHdPoRV4/xnIT9b7jC+80F1qSXawIII4F7lbTb4iWqY4EtWSTh6Zxh+ZA5nm7S
 NKWdkyCkmQFUUjmlmTQTQfoQ08yjzas2/C80kAsAkSSmxj/VmjU+gkB19lyxcYkQNaFj
 ZtHQ==
X-Gm-Message-State: AOJu0YwtT4mHOxFMUOKkhjW+FGLcki1RzNmPkLz1JEvGh/1m5FMoOWRx
 G7d7SiOIv+kUFTdnjMjkZAA/zJjrPLelhMt11OJ9IYyb5pQDrwSeg0QWB8r2hVi9GWa+fmh47A/
 qryaTK+wzTvKtRhm6dbZlgoSiuIuqgwSXjePs8K0eUFKqLB+wzP08BhnTniFxSUn3AsGH93S5jw
 79g4d1G5dVNq1TFLgGnRGF6pufqU9Y/XQWSRUL2XSX
X-Gm-Gg: AY/fxX6AWhk7S7hCcF1y1+xN2ZaXp23JvEHCgD4Yo8452mPfTtIkXZNmIbEoSjFe12q
 cw5ZhxfEh5fb7CVj9DPB6/GQs53BVeGGlMBObmrf0yzRhDccWs4fFCp+wJ12IyV3AWcxAJ58gh+
 1fZqoJFXZQSSEwFqifOEWcA68S7GAMKT58SO8LQMwWawXxsyw171zbneRu9bCqFiJoeFEggIwol
 USX3+GoFHTq00kcc95NysHXS8Cx3ATOCK5zNmgvWk6a0EBSXf0SW0uJxUO77UGiMGvgjVRUuSVQ
 xZBn5WbzLde3+cpT1W2lIaqbpxLRZE5reDbxzLcboWxdaFV+mfOtzfMMMV3NRzGXA0FlOd7b2ZF
 nfN7tHtRyU9ftuqglzg0NtNcpeYa9pFohISgJgu03R5hvhVynf9deUFU1CvCit+7y4Z80I96b/l
 l2+9+Iic6wI7j1Mmk=
X-Received: by 2002:a05:600c:1394:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-47d3ed097f8mr126744145e9.32.1766829023649; 
 Sat, 27 Dec 2025 01:50:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExz3/WdrcA0j1Ln8EV9m15w85gv09+f9qgZ0DTj0EeD0360mBRNYwpH95doEv8i8f/UmXjeA==
X-Received: by 2002:a05:600c:1394:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-47d3ed097f8mr126743925e9.32.1766829023266; 
 Sat, 27 Dec 2025 01:50:23 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08efsm50577615f8f.29.2025.12.27.01.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 125/153] target/i386/tcg: reuse gen_helper_fp_arith_ST0_FT0 for
 fcom STn and fcomp STn
Date: Sat, 27 Dec 2025 10:47:30 +0100
Message-ID: <20251227094759.35658-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Treat specially the undocumented ops, instead of treating specially the
two d8/0 opcodes that have undocumented variants: just call
gen_helper_fp_arith_ST0_FT0 for all opcodes in the d8/0 encoding.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4b77cff8ee7..32a371e2d99 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2777,7 +2777,7 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 break;
             }
             break;
-        case 0x00: case 0x01: case 0x04 ... 0x07: /* fxxx st, sti */
+        case 0x00 ... 0x07: /* fxxx st, sti */
             gen_helper_fmov_FT0_STN(tcg_env,
                                     tcg_constant_i32(opreg));
             gen_helper_fp_arith_ST0_FT0(op & 7);
@@ -2790,12 +2790,10 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 gen_helper_fpop(tcg_env);
             }
             break;
-        case 0x02: /* fcom */
         case 0x22: /* fcom2, undocumented op */
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
             gen_helper_fcom_ST0_FT0(tcg_env);
             break;
-        case 0x03: /* fcomp */
         case 0x23: /* fcomp3, undocumented op */
         case 0x32: /* fcomp5, undocumented op */
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7343FE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQwl-0001WW-PL; Sat, 27 Dec 2025 04:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwQ-00016Y-Rd
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwM-0007Lo-S9
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eKHoNurpS4l/QRtRAHMouDHzhO86MaAyXIj0ZA/L8fY=;
 b=Ubvs1sCBdRhk6ULhIb6ni948b4gWUMMMjmOWIWpI8yZWRSR8EJ4KZbUiQNHqD/x4ynXQHd
 HI17YH5mr1NoxMD070jMLNQ7nmUbevPZgMnfvyS+qVTfpT9RoAh0v/UbQBESkZTEeEZjBd
 LGGAUqt59WFbcnYU7vQ59zPQLMOm+g8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-xpbGBX83PNSVC88RrA1S8A-1; Sat, 27 Dec 2025 04:50:22 -0500
X-MC-Unique: xpbGBX83PNSVC88RrA1S8A-1
X-Mimecast-MFC-AGG-ID: xpbGBX83PNSVC88RrA1S8A_1766829021
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47a83800743so43410435e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829020; x=1767433820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKHoNurpS4l/QRtRAHMouDHzhO86MaAyXIj0ZA/L8fY=;
 b=Xz0cGFXyyYjcyozzt9sgpVhPKpy3WfwbtokxAkZ8hu2x6v4NpUPgXX46NA3LZcwend
 vzkCi98e1AIDu5M8U+QRpMh/gg9CzCsBcOk+HOScksweyekucskCajKb5nDqVq5qra+t
 w3d6nNweUyHmnjm5FvU7tQeMAjHQcrcG3cbrW08yj1XAhX2dy4hr5E6UgDjOOur8CcoQ
 GjqhYJKc/p7u3WmbthpYwf7h/S6SXJbrFFBZME7TWaMUefDlBXTUQCNzrd5NjipICTBD
 nSiGWdWDxnqKlX+l8zzfIF7JSIp1A7U9KQJHx4qHtuYf/S747q/7Wo8zdbRxkA128SBY
 01Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829020; x=1767433820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eKHoNurpS4l/QRtRAHMouDHzhO86MaAyXIj0ZA/L8fY=;
 b=iixf96WFxDnBXI/sn0OWQc3tC4Dj2TT6ZlAXQcipQSx3872Ra9rFxHGhYMWkLzY2Dm
 GepwYL4o6nSgM6lQAB6OVTrWeUta8vELI4D4ugUKpTmxIX6HMAYxRvl8LmHyb18mA7/P
 7IIlIosNCfPzs2uBm9LYGCgcc0s2RA+NyVj6WvhP9G/6QUz5mTttDeL1TAFxap0szMrw
 9p6DDKOzsTFcc1XqBiU7Lam6Q1JyVzia4Ffgc+32J1W0RzmDW8AUvu7GzLdWbUQuiQRc
 aTKcwH0g3mwlPA0AG970gif5CSQnE3m/kIWqjJ3SMWAndV21ONRjpp5h8tAqjXN4Y0oN
 pFWw==
X-Gm-Message-State: AOJu0YwL/ZEUnXzBQS29ZI/0mtOISPG+m9dZjttRYvU/kMbueN/lUcLI
 Py2ByupbaPAbg52nG8u/pUpOAaFdsBIAW5SLbSrI0vqjgsK+hDGw5CAS0ZMTlJcHAdxaVE8Vrsr
 q3sIsPKCaOgcvxMQB8xvWvtXM8pCU1aYmoU+eikDnXUKizrYi4VfAxc2gAQq9USNrIjVyMMrcl/
 7JUXVRnRqbH9yNuVKbkbeFYy4ZCh/2mtg8dI1PE+NH
X-Gm-Gg: AY/fxX5szP7dJYig69S/3DMEJNIZYcuk5O2mbcc1QL7WK7Ri9FznIsKvJkOOLakU6YE
 lPRTpBtkmRoKLesuRdJ46JPJOB4YeM/PvmZ1QQEHULsSyhW/LGJLIxxrZ18d/Uo6oXBiqlBT3Qg
 5AH1o53jQrV0b3QQsSgM0mT5f1C20BxdH+mmPrxFtO89CFn/apxZnD5QYyNkAwBOJyNwe+GLeAj
 AP4EIR84NWMHYZ5qTGhLfTZ0dnsXF+U1QwoEJplEJXnhjGJn+EZfXhCMlvnnPqU+wB/dPz94H8d
 XIv1DKWbakSYVTkOqQx7kMwKSp1K/azwIHJTxuETbDMC+/8dGS7CH2XYQzgT63ecl7YIWC79hEZ
 fIh8tRvQHoM9NBaxNCD3xiYTWS1qlflYejSwv1UnBnL1vHdfrChbEG5K+1UOW3MNLhb8MiXlbEK
 F1OMoD2350OnvPKa4=
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47d18bd57bemr249037195e9.9.1766829020450; 
 Sat, 27 Dec 2025 01:50:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0UOJDQ56WkO/Zma6fQ+LJoUeBM6HCk448YqLCW9pViD5zdrx+LvrB1QQhg99avziuORAzjA==
X-Received: by 2002:a05:600c:3508:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47d18bd57bemr249036995e9.9.1766829020048; 
 Sat, 27 Dec 2025 01:50:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d192e88f5sm428347115e9.0.2025.12.27.01.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 124/153] target/i386/tcg: move fcom/fcomp differentiation to
 gen_helper_fp_arith_ST0_FT0
Date: Sat, 27 Dec 2025 10:47:29 +0100
Message-ID: <20251227094759.35658-50-pbonzini@redhat.com>
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

There is only one call site for gen_helper_fp_arith_ST0_FT0(), therefore
there is no need to check the op1 == 3 in the caller.  Once this is done,
eliminate the goto to that call site.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 68f41b37423..4b77cff8ee7 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1485,6 +1485,7 @@ static void gen_helper_fp_arith_ST0_FT0(int op)
         break;
     case 3:
         gen_helper_fcom_ST0_FT0(tcg_env);
+        gen_helper_fpop(tcg_env);
         break;
     case 4:
         gen_helper_fsub_ST0_FT0(tcg_env);
@@ -2460,36 +2461,28 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                 s->mem_index, MO_LEUL);
             gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
-            goto fp_arith_ST0_FT0;
+            gen_helper_fp_arith_ST0_FT0(op & 7);
+            break;
 
         case 0x10 ... 0x17: /* fixxxl */
             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                 s->mem_index, MO_LEUL);
             gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-            goto fp_arith_ST0_FT0;
+            gen_helper_fp_arith_ST0_FT0(op & 7);
+            break;
 
         case 0x20 ... 0x27: /* fxxxl */
             tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
                                 s->mem_index, MO_LEUQ);
             gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
-            goto fp_arith_ST0_FT0;
+            gen_helper_fp_arith_ST0_FT0(op & 7);
+            break;
 
         case 0x30 ... 0x37: /* fixxx */
             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                 s->mem_index, MO_LESW);
             gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-            goto fp_arith_ST0_FT0;
-
-fp_arith_ST0_FT0:
-            {
-                int op1 = op & 7;
-
-                gen_helper_fp_arith_ST0_FT0(op1);
-                if (op1 == 3) {
-                    /* fcomp needs pop */
-                    gen_helper_fpop(tcg_env);
-                }
-            }
+            gen_helper_fp_arith_ST0_FT0(op & 7);
             break;
 
         case 0x08: /* flds */
-- 
2.52.0



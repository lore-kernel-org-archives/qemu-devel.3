Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CFECD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXCl-00061c-73; Mon, 25 May 2026 11:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXCk-00061M-1A
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:26:58 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXCi-00077a-HW
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:26:57 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65c21049dafso8679029d50.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722815; x=1780327615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03hmVRWj7I+Zszm+FXmA2sP9bk31WiL+ENhFvIsmx/g=;
 b=tGLm2l8z1eUgyaTJl0E3STIixqXXVp//rqSin8YIL5Tf4GxJWvMPzyZhLrMsZe4FfV
 Bm04RT8h4Tagb4oOAzxKHfV8SAq/tx1l59/6+MyBviUF3brCjbQ1+SFq2rc3mPmRCMRu
 4F/E2vTA7ciZ/uQAHt0BR8c9TLDfPHVEADt15eEQMt+nJvCD1Wkl+gizWntkfUo2OqSa
 6usgIiRxAKvU18jnvjKHVVIQWcUXc9ZE0pLdeWndGz7ghBV87Prl4KbXbQt0nmoXfY3e
 6tQrQYCApSSImndq0x7/DIKTVEqRqRnq50bywxcO1Eq898XfpzQoHEg9ks3K0f6Tljzb
 9sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722815; x=1780327615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=03hmVRWj7I+Zszm+FXmA2sP9bk31WiL+ENhFvIsmx/g=;
 b=A+ktdVgZKgQKd5kw9niMzZ1waMkzBg7AhWZPcUo1rjqN5gkympk1KnZ/6TfI5okrzC
 UN2bDGbOFkYNlrf/UMVf4pe61NSEu0ni86Jj6Wz39v+wDxiVt2vM4isxHMOzcncAacqo
 pJ0/EUrSfa+QewoVaCpLqVHbKTlJXkNoaKN39PBgZrLaSXg/b1OXgboQlhLP3/TL0zKK
 lb7+Yi+Z014dedRR2NV+s16AxwSbY3xAG7URUF/yZOb5TCXN0LS52B9s46g6VWfeNndf
 RtIkf6GfBvAY8+O2yhZrj7KFuIsHf7MHIKgl4OCmBE9033Te+srSOE7HFZL/IuHm8tdg
 chMg==
X-Gm-Message-State: AOJu0Yw85w9IF5k1jRci6irspNbstKOGvmghiHwWaX939O/A1b7NJwE2
 h19R2INKg2oAew/Rnpoe5fxGMEGNZiqQ8cnbR2vcqJb6KSVenNFghxSsRyDjsg==
X-Gm-Gg: Acq92OH39Lwch0BFZSBULAB94WLkCGyOsENzor0Tx9GhJ/UcvmgIzSPhTMFyvp95UaQ
 B2LCNV7xcQP9M2hnHX6pyby/HGYHAsKiiWAm1Qi/zEZC5QRP2tj7AOg1eV2PJR3q8vS9J7cZ+dm
 aL6LmZvyXbxl48/SU6IGG0XHhajxDcyyMLrzrn406KIWX502HdP2QQKXSj8GIXLwfwSb0ppIXZC
 rvuK0WZNwwODVpAaa8UbolcGVsi/pveYecJdYX4plHIdrUBpbqoQ7piT8dbUYjVQo9d2gIFhbjL
 xhNpIUfZZ0GpjgCTGLfBfwpBNu8tyCa615dVvc3bpBhBEE22LpoFIh3LSlXjzEg8AC173D8tvO0
 gIzEecf1T1w7aqAWgmUO4GQebiQsfiSNtXfrFn9LXuk5lKvQM28SC0S5feRTtM/aHfuzaG4s/4m
 b3+f0TW16OEHU+uSXoFlpVvPE6XyZxad6rwPkMeuIg/f9ZsNZ4rZNSPDA/aInm7JnN8yBYdoIM4
 mg=
X-Received: by 2002:a05:690e:12cd:b0:650:3952:3d3d with SMTP id
 956f58d0204a3-65ec98f74e8mr13921224d50.44.1779722815304; 
 Mon, 25 May 2026 08:26:55 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65ecfda36b2sm4668341d50.17.2026.05.25.08.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:26:53 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 3/3] target/sh4: sync fp_status when gdb writes FPSCR
Date: Mon, 25 May 2026 11:26:42 -0400
Message-ID: <20260525152642.4121729-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525152642.4121729-1-mattst88@gmail.com>
References: <20260525152642.4121729-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

sh4_cpu_gdb_write_register() wrote the incoming FPSCR value straight
into env->fpscr, leaving the derived env->fp_status (rounding mode and
flush-to-zero) stale, so a gdb-initiated FPSCR change did not take
effect for subsequent FP operations. Use cpu_load_fpscr() instead, the
same way the adjacent case already uses cpu_write_sr() for SR.

Cc: qemu-stable@nongnu.org
---
 target/sh4/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git ./target/sh4/gdbstub.c ./target/sh4/gdbstub.c
index 4f36e800d2..bdc8c1d164 100644
--- ./target/sh4/gdbstub.c
+++ ./target/sh4/gdbstub.c
@@ -113,7 +113,7 @@ int superh_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->fpul = ldl_p(mem_buf);
         break;
     case 24:
-        env->fpscr = ldl_p(mem_buf);
+        cpu_load_fpscr(env, ldl_p(mem_buf));
         break;
     case 25 ... 40:
         if (env->fpscr & FPSCR_FR) {
-- 
2.53.0



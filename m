Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489CDCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChX5-0005EH-7x; Fri, 02 Oct 2026 13:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChSB-00065C-U1
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:53:55 -0400
Received: from mail-dy2-x0d.google.com ([2607:f8b0:4864:36::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xChS8-0007oz-Rp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:53:51 -0400
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-34bcb929cceso2699044eec.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790963627; x=1791568427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XbMvtK8JbNTxbjYch33wuTiWl3YypTSLvZWi4QO5mug=;
 b=Y2APGmN3DrPB3p5oayi2l9aY+JQnBARSYveYhOrzdAuadHFNKeqiwzsXLz/SdqlMc5
 67iLFYP1WSkk95PsRS6g9Wee3/uhCz+o7TUBEMeRH1MZWyQws4CYs+G3nz73rrLaJsYJ
 EU1o0gjZaxwC0+gsAXmj4vjMN8VZ+H7B9zZ8StGMkDSW06GIlJ7Nk0lQcjCmgVy+3Ogf
 VxX6D/G/KQl30VHSYm/0Y1gEyKZt/TIhCuP8Q+A99oaa+M2JBjmlLWRRxZKPOZj48gXW
 DEAEszKWdmmPRCqH0yH6Jmz8MzDlxmyVyu8DTMNPRW6X6mEVXAqZGmWLkf7pu7qWJJ+F
 RwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790963627; x=1791568427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XbMvtK8JbNTxbjYch33wuTiWl3YypTSLvZWi4QO5mug=;
 b=eVLhaahEzNj5GcuIZ41hsfV+/EGXcw+Cln2wWROYirU2D/LVQEKyTEG3tVTGdP6Gbi
 n8Q8EtPamLe0OengGrE20P2Oco2w60RkZ5n6SXK4JSXX3OHtz3dkGSO3kjCF31RNM7vU
 m8vo5DPfW88n+gjvANFxsN4L5rk7VdjYmOqQQeIA4olkhp9c8CcIswU0NN+M+Tj45wur
 KWTZwrHdRjthjwH6DRlqrr/dPoZbCbqoZ/YR2AmSiZsGI9Ppkzs+F83NLertgXG5q03J
 GlRZAxvgpiGPgSiojZCoqzcyCOxFRW0tV9a3dswqqABdrDDWfWlEADeNzPTdusISf2TG
 tddw==
X-Gm-Message-State: AFq9FYLNhJtZ/su3ACWjqTyjvdnPc+gOfC3T4OAHtWGMXQ332PMHASIU
 MNfsCk4Ri/QDwghqKaWZY2cE0lsIdQgyIyXJ81Smje8PqlSl8stbQg/U2g/GHkuE+f0=
X-Gm-Gg: AYBFou001N5rwRGT66u78OtSWnJg4cWQCs+H7T9eaUQsv3KlPZ77OmoOoQfWQcAfz59
 4jh79C/Qd6mQQ2WZWPz3CNBqAB8XpASg3s588lxuZR1PjFqZv8GpO9cIj3WSVnuVb0bJJMG4xDz
 tLSeCOrMaPgopvCNQIQQ/OEJi59zIwu/cP9X5XSzDUlMWRv8XBfK1YHpNhkomISwuSGjqPeu3cl
 6B0H48JBZZZqnR4+S+85x4dnIwr1XF2IQ73/JvF7cd3z82kxvhGcvKnd9Fl+MWDV0m2Dz+KGXKw
 cBkrVtDQ8G+4aikCKuFJECxZns/ri+Wv75fQBSj+rdpLmh71P2iZMk2MrkLGQ985GohgVAfJvwh
 zt1uMGJ734jLhPnkoFsnzPxflkcB/4Eqvnz+GVpDD3Ay7r7w/NnIPfgx7i+oQ9Xn+fxXFnpNQC5
 7UAtRPyIx+Bk1f/pVT7jJYE21JsbbSTqncvtraPitCEU/c4EBu0PyTDIx6vo5Vn3wQjGaB7drPP
 ZopwNRPhsh9bM1KFo6QQm9OkcTz0no=
X-Received: by 2002:a05:7301:4b07:b0:34f:d831:7f71 with SMTP id
 5a478bee46e88-34fd8318127mr3095952eec.23.1790963626419; 
 Fri, 02 Oct 2026 10:53:46 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34f14f9f2afsm18027361eec.18.2026.10.02.10.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:53:45 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Rolnik <mrolnik@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Helge Deller <deller@gmx.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 23/27] target/riscv: use cpu_raise_excp_restore for
 exception exits
Date: Sat,  3 Oct 2026 01:50:31 +0800
Message-ID: <20261002175037.1747-24-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261002175037.1747-1-luoyonggang@gmail.com>
References: <20261002175037.1747-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Keep riscv_raise_exception() for PMU bookkeeping, but delegate exception
handling to cpu_raise_excp_restore(). It restores guest state when pc is
nonzero and falls back to a plain exception exit otherwise.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/tcg/op_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index b67c7718db4..ca4efadec50 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -47,8 +47,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                           riscv_cpu_get_trap_name(exception, false),
                           env->pc);
 
-    cs->exception_index = exception;
-    cpu_loop_exit_restore(cs, pc);
+    cpu_raise_excp_restore(cs, exception, pc);
 }
 
 void helper_raise_exception(CPURISCVState *env, uint32_t exception)
-- 
2.52.0.windows.1



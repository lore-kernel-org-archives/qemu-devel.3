Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205C4CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEeev-0005El-EW; Thu, 30 Oct 2025 22:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vEeet-0005Dq-HP
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:14:31 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vEeen-0005vd-Uu
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:14:29 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-430c17e29d9so7091535ab.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761876859; x=1762481659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDDzVpIEYFtan7kEC7miAi1QvrklbQFsgIlEd92Gf0I=;
 b=HnLC6u9z0ySf19D1FjwNAqDGAdwvWRHoCNJ822wQ623N4bJjd3qu9hG2FLodQn25Nh
 8pFQbnVGWTfOjCz5DOZmrOWq10I4WWKfcYKDfZ/PcqNEbmlkesXq1Fb0MSMS7MGdA0d0
 GsxLWo8fJvWLZvfUxe1pmbdxCRDucQ3SZLC7yblwbMORHUgxeCuGhWIBTzNjRmqlFDKl
 RBryVdwrMbFzXODCsPlDVkUrpNXxhgEH+9Fd2Xp+ISNYXYnJjRSSzaEtHDALVTDU3iPO
 oEKP6knZtJQpL8rr9IGBM2fib+rvStNjcDdLs7tC9W8FVV+rOl0sceyAKOEQu7RKrs5f
 zKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761876859; x=1762481659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDDzVpIEYFtan7kEC7miAi1QvrklbQFsgIlEd92Gf0I=;
 b=vKUijO2KnWD31Xu8BMUWT0XoPUHxd9QeIdf7A/pSmKombf0U3URxrKX9fZqcIqKtya
 kBd4RaQkB7SCRRAJOKsSi7mRTkDGHGtMQ0YdwNmJmOjm0SO0vt/mpnUU//xJDOKKf5Pg
 7Cl0MwtBGT2O0atnMiIsW+Jb+Hi+xjY74XNysG5zlYLUjDPHHx4KCwYRt1ya+Py9X1Dy
 dJG322bcuasrK6KoglQN5DQqC3+aanNcIte/+XM0G2ungg6irVgpCJfrNPmYCUlQXL2q
 sGFcQrKqGJcJZbLim1qcZLQMawKvPk4jsR0GB01geRdCSEBcopd39NIOpd7KjfPtxrHr
 E8RA==
X-Gm-Message-State: AOJu0Yz1WoMeWG685CePXj+NorSUKNp/49phdLMIISqpn4cvCbL7Babm
 +GKw/NmU86S7pWEGCk6vlp5ypvI+bXT4oYmJFYlzegnzfkGShZwrOMoRhso92QHRaaw=
X-Gm-Gg: ASbGncvWZ4YniV9vSZ6fBSsd4ziEg0ZEJesrIaGLnTsa4HibpaenA+xpD0xYLdolq1d
 k0oQ+AQzQ5pcki8J23D6jv79yKsf5ZozoGIv7obl44AckBqTpoyZbfRlVpWkXW/Zcz46w97hVwu
 y/OqBuL6hgHoJ6RxWy/7+jhOgdCC7jIwI0IKrOWYxgQkwqdipjV8mN4ngSdNC/YE5pYh7VGvkUo
 c+LsTun5xHMzqUXJQc/e90/5YyAvlCtBzWroHCChSxGrwc/Zfa0JRplY+x6WpTOXEXgEYTwuw41
 HNypkHORrfFeZ9eOhDErqp4orY51FaQ5nqJbgmTy/P/ENJLfu/6bl3WH9IymAbJnbdnzyprOExF
 Jop9r7VEcYCPCTCJ0etnNuDrTCBj7ZwFm5Lx66K2xCyIGKOzeGIM08vJeqrn5tnIgypixP2Vh4T
 iOOueubsEdButZSlLe4LmbvWKBAeRq0BGdlUI9kVniuE3MSJB4f9fuwYZEA2hPPgB5TQ==
X-Google-Smtp-Source: AGHT+IExN6uya5YAjveaT/1KOgGZbnkr9ZTmMk8mb1KdmLmmRM85vCiUDvlQ3tgfEDnxfV9liOwKmw==
X-Received: by 2002:a05:6e02:97:b0:430:d21d:7b24 with SMTP id
 e9e14a558f8ab-4330d235d0emr34303135ab.32.1761876858873; 
 Thu, 30 Oct 2025 19:14:18 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-43310274e21sm1631055ab.9.2025.10.30.19.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 19:14:18 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 2/2] Hexagon (target/hexagon) Implicit writes to USR don't
 force packet commit
Date: Thu, 30 Oct 2025 20:14:11 -0600
Message-ID: <20251031021411.111365-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031021411.111365-1-ltaylorsimpson@gmail.com>
References: <20251031021411.111365-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implicit writes to USR are only to specific fields of USR to indicate
side effects (e.g., saturation overflow, floating point status).
In these cases, we don't force a packet commit. This will allow more
packets to be short-circuited (avoid writing the results to temporaries).

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8fce219c0d..3da01c2b5e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -272,12 +272,7 @@ static void mark_implicit_reg_write(DisasContext *ctx, int attrib, int rnum)
 {
     uint16_t opcode = ctx->insn->opcode;
     if (GET_ATTRIB(opcode, attrib)) {
-        /*
-         * USR is used to set overflow and FP exceptions,
-         * so treat it as conditional
-         */
-        bool is_predicated = GET_ATTRIB(opcode, A_CONDEXEC) ||
-                             rnum == HEX_REG_USR;
+        bool is_predicated = GET_ATTRIB(opcode, A_CONDEXEC);
 
         /* LC0/LC1 is conditionally written by endloop instructions */
         if ((rnum == HEX_REG_LC0 || rnum == HEX_REG_LC1) &&
@@ -300,8 +295,6 @@ static void mark_implicit_reg_writes(DisasContext *ctx)
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_SA0, HEX_REG_SA0);
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_LC1, HEX_REG_LC1);
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_SA1, HEX_REG_SA1);
-    mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_USR, HEX_REG_USR);
-    mark_implicit_reg_write(ctx, A_FPOP, HEX_REG_USR);
 }
 
 static void mark_implicit_pred_write(DisasContext *ctx, int attrib, int pnum)
@@ -351,11 +344,6 @@ static bool need_commit(DisasContext *ctx)
         }
     }
 
-    /* Floating point instructions are hard-coded to use new_value */
-    if (check_for_attrib(pkt, A_FPOP)) {
-        return true;
-    }
-
     if (ctx->read_after_write || ctx->has_hvx_overlap) {
         return true;
     }
-- 
2.43.0



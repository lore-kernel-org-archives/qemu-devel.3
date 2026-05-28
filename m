Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DA1CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScFy-0005NG-Ii; Thu, 28 May 2026 11:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wSbyz-0001LO-MR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:45:13 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <314abh@gmail.com>) id 1wSbyt-0007kc-Ig
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:45:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-837b39eb078so8959684b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779979506; x=1780584306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GRFZxMW1/uepakyjETGNiaM+FXY8gaKdWbloOt0XkX8=;
 b=cSpOAdt+gYuY3SuN3BP2wK/k91EjyrMsozFbnUfI6CbjwlCaecd20XWJa2+lEO+6Yi
 bYDyGvkSHuFSwLLPK4pQxblauHpMyjfUH9uaoNkffbUHYduj/ApIRBmFJsnPFeKk6KsF
 YZXxfmUGT92A0WxFXGJQSNOmmp5TcgskJwoRnSh3P8Blf5SoksSeui5UgG3Lpeevm7fF
 lMx5/Qve+nhJC9W1zkgS4eXa3QjXkyAiO9/VwW+YXYUeP81oat/QzGAOa/fNIT3Ldnck
 CMBdBxytSSk81vuS2foV4hph2Pj6Gw2ErmyNdUBXBjbV6KbL0UaHeOCcP9SvX54hY4ms
 dKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779979506; x=1780584306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRFZxMW1/uepakyjETGNiaM+FXY8gaKdWbloOt0XkX8=;
 b=Ki09keaFBGmGS2BU/PNJzzM1XkkE+61AXYQ22ljwS8u2vZC1byH0NhzkUYoi/0EdNz
 znS9fpiS1+uxbysxQPpOReIOcvjNQeJq/4ydKK7vdJ8UJaFTPuHrpZG4G2rXExEOGS4J
 JlndXJZt9/2Ac+3x9Hff875YFLb1htGhLFg8bGn0J887XycluWEhiV/csmkp14RymK4I
 pI+aaug6kcCObzBvIE5S14SyRXAo5/42llUUw2+TIFIAVQltCuaaUe6aSoHZ2adIlg0T
 9/NJlXFc65ogUGsEXbrDdT4KgsSAVvmQPK7rlmF0H+vI+ZVY652fugE6wr+5UczFIaNg
 R4DA==
X-Gm-Message-State: AOJu0YwfukA5TSevljp8TymdNgifO4fzrGBYjMvFcXM3F4Zpxc5cCEB/
 0e3zqO+N+IDvvtLAOvmEsWH1stZC7zleYJ1Du1OxkInAJNQKUKmXspCshtSlww==
X-Gm-Gg: Acq92OGWV7HnFxa2cOQevBWPwshnBLwVeQAgZkTtjD9qpzzsMMpLADqZtNrjo5TIatJ
 l655hvx1w6J/mlHJ6qd2DW0lvGCRPtg2OjHnfkOrnPotl3ir2MK1Wi1CDHf6DNJ4U49yyZpei0U
 Rq/IjhDYj4K9h8O1SYTEpwgk2uUg2O/NXNMunE+lCl0Fymnr7S1ZYkxOHTrdL05iZViREYuFQLt
 06gMPV8bI4GspyJO4yJQvjWyGKkyxusnbuLbEP6LQ6wUiq31l52gC0qzyWEpntlIbvKR2lnVY/3
 KeNR8o5B/wVf5xRhWVQV4H9pWQuk1/iu9d9aphgRh1KBfPnIJ/14j/+1oQL1+yk3mO4GNUpdIP5
 JHGTLIoGRrcMmsnssWbz/kORsxxuJVBpXbcxrfzSkUKYZW4VVBcDlhenXRIiRP4Vu/x21AX+B5h
 Och8EJAlrL0ZCPj6wRz/Lh
X-Received: by 2002:a05:6a00:1ac8:b0:82a:65fa:cecf with SMTP id
 d2e1a72fcca58-8415f3b0abfmr25911526b3a.4.1779979505838; 
 Thu, 28 May 2026 07:45:05 -0700 (PDT)
Received: from arch ([112.133.246.27]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841e403bb3csm4024715b3a.32.2026.05.28.07.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 07:45:05 -0700 (PDT)
From: Abhigyan Kumar <314abh@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Abhigyan Kumar <314abh@gmail.com>
Subject: [PATCH] target/i386: Fix incorrect tcg generation for RCR & RCL
 instructions
Date: Thu, 28 May 2026 20:14:57 +0530
Message-ID: <20260528144457.682901-1-314abh@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=314abh@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 11:02:45 -0400
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

RCR and RCL instructions of a count of 9 is meaningless for 8-bit
operands. In gen_RCR and gen_RCL functions, gen_rotc_mod converts a
rotation of 9 to 0. But, the can_be_zero flag wasn't updated and hence
we skip the immediate if branch. This causes 0 to underflow into -1 at
tcg_gen_subi_tl(count, count, 1);

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3452
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
---
 target/i386/tcg/emit.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index ce636b6c5..a71af846d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3452,6 +3452,7 @@ static void gen_RCL(DisasContext *s, X86DecodedInsn *decode)
     low_count = tcg_temp_new();
 
     gen_rotc_mod(ot, count);
+    can_be_zero = (ot == MO_8 || ot == MO_16);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
@@ -3504,6 +3505,7 @@ static void gen_RCR(DisasContext *s, X86DecodedInsn *decode)
     high_count = tcg_temp_new();
 
     gen_rotc_mod(ot, count);
+    can_be_zero = (ot == MO_8 || ot == MO_16);
     have_1bit_cin = gen_eflags_adcox(s, decode, true, can_be_zero);
     if (can_be_zero) {
         zero_label = gen_new_label();
-- 
2.54.0



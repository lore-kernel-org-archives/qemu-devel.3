Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A2BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubd5s-0004yq-V0; Tue, 15 Jul 2025 06:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5j-0004mG-2L
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5g-0005oQ-HB
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:40:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so3475154f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752576050; x=1753180850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33DIjNfxt3jpmGezhMM72tos7S31Ok+R1GL9qFzuPjM=;
 b=SBvr4PA1LiDmUWBIMr/5vlucJDWBkou/5o1RChTUioQt+mPmIR/rzYF5wxRDM1dlEX
 WjJl9gLHFxufPrDMNUNNkcQoJ2vVrMkQ0HnjZLEXCRBWNTYcJ5fGACAsKJJl9AxltDI0
 XsF4zbL6KU1lmyVWEj/xqK8nuG7Mul+X3BSL5Qq4ZH2eiqy1DZq1cAsn+k0wo0b0Xbz9
 kiDP8sj+YELkOU8Q1PB25ZJ3WCnMxUTcgikoWwBR6ZGOBpoV4Df6eOT7TscbVsUQH+3+
 pJErP3iQXq9pKcAgBHpWn8birOOQubXoAB2mVe0WkZyPv3ioqFucRjb6l/8rQZzmDFBM
 lG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752576050; x=1753180850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33DIjNfxt3jpmGezhMM72tos7S31Ok+R1GL9qFzuPjM=;
 b=bCIVZqyMJ95ytZVf6WOIZnpiL42yMG5CRWVVaRi2NJWN2MNpvLRI+thNoKagKK04cA
 8StC7UCZ4RRjuoeS4upgXD7ShEQ4IsnZiZVV9MnXkg7UvRnFpsnDRipLE8/j/J0Vhyn2
 tua0jERGrUHY2OPdBi7IDEqAmaL4ROtuDB/iFhs/Gx0EgDD6fzDhi5HRLonyRcdP2hmd
 CgTMw/o7c5AOflpDidf2EKAxba/ggX87YDxLfeI6xGkhscRVBJHrc/SWLIHk8hdUru0a
 52Fga/IPm5mj5AaixYbxRYBHk9um89efj4Kv+l61gyuLiwl/r1r3ZyWq+80Ob3fp8vIm
 1KOQ==
X-Gm-Message-State: AOJu0YxxzNKvtTDc3RyR5b5xAaMrFYk3lZ19nSeNi8UJ/Lj//UXTsZdS
 OnqGUg+F7G/KlY50/Dl6Bb5i1O2Gqlaje+weCvm7bFaeKW4btla+xjMPKoi3cysysuSyP8mE48G
 cj1ZL
X-Gm-Gg: ASbGncvhijf4Im3HijPlAn40kVRJ/TtNKMHWFSYgMR9OOpY7jcan6OmGV1F05DULkw/
 eq/NfdAX5otYWJR6QckmRjpWSYmpo/QvMjicg+MHiryZZXvJdb8YcW42ZM0YcORZiY45wzEzyE9
 mlARUBmAVPoVZS+xJY85mkdq9r/gTAUUcOrZ0hFTCI/CKeiWvyWB+gZsEnO+laKqklG3hJLHwkJ
 Ct6SQAhKDEpD1Yexeii0mLy0e3OVWTzzVKv3iJ0vd4IyJ2zkHZj10NIK2xkq6KUm2iNEDwdZ9B4
 U3DOf8kEzm1KeZ2o/4mQPhKIRs3JHA3Erb+msWOmilj3h7Qjny2qKS0h/oLKmM3ddZwbCFnA71v
 uxtMXUCPPSHIwylc6M7PJxoGlymh5uIA3o6C/jyIF4fx2oCC1WigPwl6xgAttRN1ymysLJZ5z8p
 D7fA==
X-Google-Smtp-Source: AGHT+IGnAiMMp+bUKSXaw+u8X7WCT7Mo9gvli8jjQphE/YxKqtQSiExTqAOsbPNO0r9B4EG7PZcRlA==
X-Received: by 2002:a05:6000:4a0e:b0:3a4:f7ae:77c9 with SMTP id
 ffacd0b85a97d-3b609522273mr2350003f8f.5.1752576050169; 
 Tue, 15 Jul 2025 03:40:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1e4fsm14633613f8f.21.2025.07.15.03.40.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 03:40:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH-for-10.1 v5 6/7] accel/tcg: Implement get_[vcpu]_stats()
Date: Tue, 15 Jul 2025 12:40:14 +0200
Message-ID: <20250715104015.72663-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715104015.72663-1-philmd@linaro.org>
References: <20250715104015.72663-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index eaeb465dfd5..fc3f28e3532 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -236,6 +236,11 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
     }
 }
 
+static void tcg_get_stats(AccelState *as, GString *buf)
+{
+    tcg_dump_stats(as, buf);
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -243,6 +248,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = tcg_init_machine;
     ac->cpu_common_realize = tcg_exec_realizefn;
     ac->cpu_common_unrealize = tcg_exec_unrealizefn;
+    ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
-- 
2.49.0



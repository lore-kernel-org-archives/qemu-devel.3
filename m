Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E672D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoP-0006JW-Em; Tue, 13 Jan 2026 23:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoN-00062D-5e
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:51 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoL-00040F-Pf
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:50 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so78444915ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366128; x=1768970928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujtaD3rpMRG6C9bV6uOL1SwEhG44fFewsfi9z3ZrKzg=;
 b=WG0fNd4oyxhVGtUATZi4oLkmsyIEcHU4W0IvS/7O59eYc+PgQS1K/7JDmtJSSH2Vey
 CaWeHhjLk2mzIuE+AdMp44fH2Onb9rbcl3c9MlnxvH3KkYT2SPDJ69ah28relPElW1My
 usYIeJHZ7U4v+iuWHgseUlQlXiZpEEPpU2Yw23KfOE/o98AJiVvGW+JJxmduOvbI1Tck
 iU/MJ3cJp0KkasURR1YJt2FxLu0MCK5ywZMHGAv0lA3XHmTJWbjAtqS725R2jcOcJG6l
 /th6QzjNpQrBPJPLYPxxWaMkddWZRaIysCLAnrlIRD7sgKT5e1oPosqYinjeQPNsC5hq
 EM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366128; x=1768970928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ujtaD3rpMRG6C9bV6uOL1SwEhG44fFewsfi9z3ZrKzg=;
 b=PukrCFoNoGtaf0jGZ2BhOPKFDGA2PZXJJoPkDIG0rGGIWkOEcyQmJQ+cK8Ic67d6yD
 R/WQ6kw19u3eZiMhugc9U4vVSQpnDqvnbwf93s1IwOhiJhdGwUSMOk3xDAsC5TfKrrVb
 ap9qaz612DAIKhTx752cjiizVlTuk2/TWP0th5pc8+hBzE7/+eveEbcT/aoP5OXedjrm
 lWJK0mSj0Y1G5olSp55klLrTZzjPlJTB31aMZ3+JudBlX5XE0NXOF3mMX9tPft3sEDfw
 ROHmdGcYbLlB5reoY3RdJxZNhVEXwti720UVxbfFJMV9uvIgptjnjxyRXIf1hB61eJYb
 7+7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXnf+ARzfI9hkE5tUIria5xiyb3gOA7KoY6OQwe4+vDl4ZyYjgSHxA81jK0NDnNVq7mOjLkM+i0m6U@nongnu.org
X-Gm-Message-State: AOJu0Yx3Je3NxOjxbhRJVGn5Z93WrOEl/7bo4yymHmhBoXJuwKeN6k47
 ssZP0mfenKCyJE4rV5GKSQMrIRXoCmCyHwNIiChWpzHNEYh2ONv9mi03
X-Gm-Gg: AY/fxX4b75Bif2rFqmHet8ZlpMoZgC1Y0I4FqdKi9ElGmtM++lWmVEFIY7DSmrckIEz
 TG+l6MV1aiPZ8dos+UdDUE+RR9IcqxKF8gYb2cyiN25eVsoQruFvimbsZXDUFHq/foOJEibDLCF
 0OIVEc0ZMtdSGQZ2j10J6zFs0XPwdzGgZ2oIGQdI2wW1O00b+hcpChYk4ZUcN3bo5RiusXQ00oY
 ea98fAiEROv+twNkzqifq5oB+a6dztNIDlkIP370I0gArjZlnSFiGPxzOJhk/q8LOO9TuOQ8FdI
 GcChaW3Omgl3cxDPgLTLSGs3rBsxv2/O2p4OSLhibeNG2vj1Jxmxuc+makDHAHfY6fmg5mUKE1K
 Q15kkYYtGFN/VN5hm7QP23vJsrdEa3Rsi2bH94PEyqNscWJK1VjNPole7v9NvLtDcrZJ6gKkPhm
 pYALNagOW1Ip4f0c61/wSjV+SwfJ4cSfExvw2AglJnSK3B9z0w+ejBuLAD5Ww=
X-Received: by 2002:a17:902:ec83:b0:2a3:ec72:f462 with SMTP id
 d9443c01a7336-2a599dd2409mr15287415ad.25.1768366128502; 
 Tue, 13 Jan 2026 20:48:48 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 17/25] target/riscv/debug: Advertise icount trigger type
 in tinfo
Date: Wed, 14 Jan 2026 14:46:50 +1000
Message-ID: <20260114044701.1173347-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

icount triggers are supported so tinfo should advertise them.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 69e7037fac..605ed95b14 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -865,7 +865,9 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
     /* assume all triggers support the same types of triggers */
+    /* XXX: should we set 1 (version 1.0) in the version field? */
     return BIT(TRIGGER_TYPE_AD_MATCH) |
+           BIT(TRIGGER_TYPE_INST_CNT) |
            BIT(TRIGGER_TYPE_AD_MATCH6);
 }
 
-- 
2.51.0



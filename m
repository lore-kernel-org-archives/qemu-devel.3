Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAEFD31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfspD-00081y-8Z; Tue, 13 Jan 2026 23:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsp2-0007Im-9q
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:35 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsp0-0004DR-Ls
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a3e76d0f64so2558085ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366169; x=1768970969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kY0TVgsVm0GPorTwNSyfEoAVAqvdoi35N7aeXTAA74=;
 b=Rb3jc8qAkeUHUYvXd0YidPKFSUVZUG+gXqsc5zdMhl5WjcWtWYVyc6CQ3GSKMYYXY9
 KAneqoUgywBlbkkK9oFGLR9PrcrxDhGdS9fKeR+DgnARfIJR8mtWCf9rUIymvHIpRu82
 waV2RMJ2+TDl8Hko0l0JiwhQhznIAnNFq967i3KcExgVLOzOvPifno77NQOgzLo+cVsU
 l9CuQ6kIRFtyk9LAxnKNQ66MLXK7bgL924rH90/Lu8upOwIuj/3WAu43yL8V60s+8pz0
 CuseG6qP+OKGNa/DJXiKmEBq5rYBodWU2ZhVk3B+0AWwKPojJhEbhTAIY8D4utHfkcH8
 gV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366169; x=1768970969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kY0TVgsVm0GPorTwNSyfEoAVAqvdoi35N7aeXTAA74=;
 b=JssHwJe+QomPVSnhD3hlV2cL+whomHDFlDHsPtEAPAYt1nDmVBL9bmmCc0FDcx/Oah
 5IMIEfcoVIfSh6HbabqxVwHPFNCnQs+cVfLXV9DxC8b+oWjvUND+Tj/G1b+gsaoQhh1k
 QQZTwAXxWkx7woYa09d0wKiHbc7p2CG1WGMBKOc2DMdIO3GnWIhy5BBi8ZF9SbOxi+4d
 18xqicsqeQt+LW2V9wBoajCG1kcxWyBLVzBL4Gjf2vv44MwzlmuxbEyloFmF3A7y/uv9
 hkTvKJH6BFWKQWZCuxWmvUosf1QtdJKU3UX2RXB21CmtaJaaRV/Xmy8Kponja5zdzjPK
 bYtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4mzJ8T75myqywTQPjAGr/hvbhf/qccny6QCVf3k2LF+o4ZlnwTRVBI9ilEVbW0po84LWxvIoPBlvc@nongnu.org
X-Gm-Message-State: AOJu0YyjIucyc+vCn1M7f6eo9pLLxN27PWyPRVDZPQ28pSa9VUzWQo2R
 OTowhyxJ2JvdZQRSD5culXDjwuMbIva5rBXxsPqTwKrSx2/+vPT6IsCK
X-Gm-Gg: AY/fxX7AivFUnSJbiKcJTGz7AyntiCFcgZ9udg5/8ubB5x1O2ygTSciTSwpqGrpjWNL
 Q7yaZ7Wc6l4xpjd3lYaHfIfTmiwfFmOZAOJwB+epLCyVnHYUkubNZaxxIBfEobgzQhLtVstK9su
 lOSpHLx5HJ8tW3vihdGTnkkKKUuUjwTUfIKs7mYWX7BIylj1mnCBwLJqXitRgvWQebca3Io5wIW
 McoRlhHrj0G83AwJ7MkPKasMFggwulFzU0vdY4rRMXGwQqL79E3RHis6XGszqBLlCcbCjtsnfAM
 ULhhnSFxqSUoXoNC0RTOgUDbOpwmXz66/sqd2F4o+ipIh4N6MmBn2QZParyhfndvLkVFy7dLTyQ
 LoQ1hH+FpJeswrmsC01oScfOD1zux1HnTLBOODNnN2Eknz9HAgYPWt2yG32/6x4gbL/YM7sr5Dr
 Q4cykxTcZZnHhPZgYU4r/2X3DR+MMA/iLc1bCpfJ8d0C6bddDiSQe9hjQAG8bzrTU6CkD5mA==
X-Received: by 2002:a17:903:17c5:b0:299:bda7:ae45 with SMTP id
 d9443c01a7336-2a58b53655emr44501875ad.25.1768366169350; 
 Tue, 13 Jan 2026 20:49:29 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:49:29 -0800 (PST)
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
Subject: [RFC PATCH 25/25] target/riscv/debug: Fix minor comment typos
Date: Wed, 14 Jan 2026 14:46:58 +1000
Message-ID: <20260114044701.1173347-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index d7c171736f..32aa46262a 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -120,7 +120,7 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
         break;
     case TRIGGER_TYPE_NO_EXIST:
     case TRIGGER_TYPE_UNAVAIL:
-        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exist\n",
                       trigger_type);
         break;
     default:
@@ -895,7 +895,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
                       trigger_type);
         break;
     case TRIGGER_TYPE_NO_EXIST:
-        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exist\n",
                       trigger_type);
         break;
     default:
-- 
2.51.0



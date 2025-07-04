Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6CBC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLd-0001rG-UA; Fri, 04 Jul 2025 07:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLT-0001jX-JB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLR-0002TR-4N
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:43 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-234bfe37cccso9920435ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627559; x=1752232359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgqeX0mSl6R03zp1vleVuhsTxzUAqtSjxphovdOwj2I=;
 b=ZDQ4rS0wI3Mj1SDX1CYr+di0YUvXFgr17eSj98CIWywpns8Q2PvkkBp0LH3GqBMH1S
 +KmOB4emNGQFIcK+Vmy3g+khoKAa0Qpcs37yp5acn1OBCyKDPA/oERKyFrcpGsPY3zjp
 SegDddVcgkXJNGxv1HMqQHanjVNwmlD1Nm4f7/P3lPmY0D2De19uD3rzpl/CNV9rYyrc
 rKI9AANiwdwdQtsnitkZcW91Gg9G+O6K38bWlLRkEv6+zTQbGVGxk/uV9suQN2OPV97I
 Ww1u8GkbF/kIZJo522qOBnUhQXIzmfdo6LAlQ3jQL5YT4+xRLMdTRNLEF+EFhV8aoHZg
 gVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627559; x=1752232359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgqeX0mSl6R03zp1vleVuhsTxzUAqtSjxphovdOwj2I=;
 b=CqG2FIiK9q3KjS+Taa1XFm2gz72uDnQEyVb1/yOvYfoXSZAFopp7kVE4iWBBn+q9oy
 U8CKxHL0O3Gvufokl6zMBdvTSjnZgF78LkIBfuWOhF67hS5j3fiKzqWoQrDwxWO2WcwW
 bx5DCjIkZdSaDUlFKi2fFK4gvFL0o+9IKXwgO4LWm0JdGCcDq8BYnOOHtgDfNyEIWSoG
 3d9HDPiW+07hWuZ2IVxTOvTaSM0F/e3HkG6/AMZU8IsQhHpB1hUuqyGjpo73HLbVACOz
 sg0E6F7gEF0KxXD+ifjVe7dGeMw/kH/US4QmjexeLZhHqiZtutGYvm31EfSZCYbM8zMC
 O0lw==
X-Gm-Message-State: AOJu0YwhWBIvbhmV+qb6cQPsPALAGV6IxpfPxVuB2ObSlG9on9gQoK2G
 fbbTT4w4MxgGMPjO8+UujAvUyghUSnCWZgJ+hPNjSl+gqjy7REi4I2Jhj9T41A==
X-Gm-Gg: ASbGncvinZhgrFyVGzHngOFy7aS7/FXNaccwYyArN0jDJArYpwyMS29uTzp8+l2AD8m
 U2uKbgBNHnOOFBQ5wML0zXmUBY2IuVus1XFkXaCMmcuE5AlCOqB+aRXxtyv/cmoh8yjpCAcqNNF
 en/ve3+T4xDwLD2DLZRdGJaW0/SkIQqpC6mJyXqhhl1398WFgtVTiiy599S+3GPSwd7OjW7Mb1a
 UiHDVGWB9e131Dfj741VgGhDo83JkPnZ4tvfZuC6FlM9OP9ojPejo6dX/PBaj9l8pWnOM4HV4D5
 mv5Z8imbEInQA0eFg85kvqBhLMOSsX8+bCrDU9vEBbMySU/zddCKje/YVhqnSCV3blLO9qnBoCk
 sRMBSLEoEbFZd3wh5xrZfwXW6Tyb8HwRK7j4mB5D95d82iMZt77mrujZAybKEP6ufgLM=
X-Google-Smtp-Source: AGHT+IH6oDjl5klLbujOYGOkB1dxs9ZjKU3hV5XJ53ed1V1iZ1Oey5PyP/VrSJ0El7DvQ2c6EsggHw==
X-Received: by 2002:a17:902:f550:b0:235:129e:f640 with SMTP id
 d9443c01a7336-23c8613842amr36822345ad.38.1751627559229; 
 Fri, 04 Jul 2025 04:12:39 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/40] target/riscv: Fix VSTIP bit in sstc extension.
Date: Fri,  4 Jul 2025 21:11:30 +1000
Message-ID: <20250704111207.591994-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jim Shu <jim.shu@sifive.com>

VSTIP is only writable when both [mh]envcfg.STCE is enabled, or it will
revert it's defined behavior as if sstc extension is not implemented.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250519143518.11086-4-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index fb14972169..d8102943dd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3651,7 +3651,14 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
     if (riscv_cpu_cfg(env)->ext_sstc && (env->priv == PRV_M) &&
         get_field(env->menvcfg, MENVCFG_STCE)) {
         /* sstc extension forbids STIP & VSTIP to be writeable in mip */
-        mask = mask & ~(MIP_STIP | MIP_VSTIP);
+
+        /* STIP is not writable when menvcfg.STCE is enabled. */
+        mask = mask & ~MIP_STIP;
+
+        /* VSTIP is not writable when both [mh]envcfg.STCE are enabled. */
+        if (get_field(env->henvcfg, HENVCFG_STCE)) {
+            mask = mask & ~MIP_VSTIP;
+        }
     }
 
     if (mask) {
-- 
2.50.0



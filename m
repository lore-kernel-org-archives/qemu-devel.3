Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3173C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLu-00026J-GS; Fri, 04 Jul 2025 07:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLa-0001qK-R6; Fri, 04 Jul 2025 07:12:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLZ-0002cq-1F; Fri, 04 Jul 2025 07:12:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-236192f8770so5821835ad.0; 
 Fri, 04 Jul 2025 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627565; x=1752232365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6UGTgPYir33A0rgIBH+C4iVYyQtEZW7GZky2on9WjU=;
 b=QjYJCxhtVICYs5lG54LZAopHkXNbhHAOwVpfek4dMj3rwgo5nWxIaK9T8GQWX2wBfd
 2Of1BDi5+Muw7leP/WcejQJlCa0uYwZms5ASvS/WYAqgDVIHbjIz6ijrSs6c7PN0QYhk
 SJ5MG/0Fi+tQHm3Ny6+AYm6R2lqDi1+3MpkFFtu8/sOOst4JibLo4/KEh0uLMqVi//4D
 uP5ABFRFRtR0m+GQZ7LbRIEySMad5vTOEjv3LN2rHjnRuEtPgBC2uCeZeNZwjDh527gq
 I6HVKsgnbWQmJnoT+ga4oFQntt8Y5hlFdUCmwTbNorV9XtuDdVuqRbP9v4cyoTdlBESz
 riOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627565; x=1752232365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6UGTgPYir33A0rgIBH+C4iVYyQtEZW7GZky2on9WjU=;
 b=P8UOpSl3TGRltn2Kf3u6BZ8rA5s24Bht24ohoyAtchvVKfF8UIAPfObVA1PPT3Y98x
 P78BwOJg84UnN0u9q1iDqIRChL5sFZDXHI9Yp07BLQ9XM1kISeam4edzLhOvwP/5s4Yq
 lbEiQ+WlwneAikHOB/MOdPYkVLi3sat69wrAZUVrxWA46ai4ZsZnEskjHspCurBqmRn4
 ADbY0TVmtlv8GMvzMPn8HsFjIGNzVyCvCDXI/2J1I/kgLZwXmBe3pk2s7K8OMYHcpYTY
 KVbCE/3g/aAMcbf/n8dYQRjHORW9MSIMvmWm8QhT7eSMXb5AEw/hmQhDhncNlUhNfp5W
 5dCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKImpDQ6trDm3joNWynfe5HfSahSVOq9QF6rWxd/XlbQRSIB5xIj5ZHzVSEmaMjv/jbP3SW6G1omPwv9M=@nongnu.org
X-Gm-Message-State: AOJu0YxtPZ6UiqJkorukaW6GxalUs9SRqz24XK6VQ9mu1vTvMgTpJEUy
 I8Qm18bY9WH/6Yf4z+slF8+U0gjwgKkuFVuJDxjTCxbDBNopTqpgBOnJDZxopA==
X-Gm-Gg: ASbGnculzt6hglV4yzIJqpskNE+LSy0QxGP6w4iCjXUAhQ2PjqgLY/JH6O6t5cJnV03
 HSxIIzlcbkDOkgt4qwgGU0gpwA1jts/leUlee2DZEe48x0mDk67rPAWORPXK1otsdOPGjMzZ/4q
 uEJZHvHeixzsggi60AktH6ciJfUNbe1AlABjByIbneTHbROk2nSCToEZidZ0EHabfpjPjTwpFNl
 v0u2hey3/9W2oT56DEp6ZyRYa4EFdhNfOqnHsBRtNr7apexbNMpjaX404uXJaQQviMZK5/WWNNo
 KKra0sTU1ewaJLf5AEw0eX28HFTrC5YLbmK5mg2TBS3gJbe7KbexR2TVJb94JYjZABw1KCU9i5w
 9RKOPosPts/wNOAan+9jNDSSoKQ7KQKx/qG7RMJWEe4UxzWwF2RByoHaEQh34Zi/dibE=
X-Google-Smtp-Source: AGHT+IHs6p+BA2JJOIcVeEjWoz6p3TD+YAHGkfDpP0BUEy1TbBBo1sAF1L2jkKy+hDijgRZjyK22TA==
X-Received: by 2002:a17:903:11c8:b0:234:11e2:f41 with SMTP id
 d9443c01a7336-23c84ad0d7cmr39714455ad.6.1751627564972; 
 Fri, 04 Jul 2025 04:12:44 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/40] target/riscv/cpu.c: fix zama16b order in isa_edata_arr[]
Date: Fri,  4 Jul 2025 21:11:32 +1000
Message-ID: <20250704111207.591994-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Put it after zalrsc and before zawrs.

Cc: qemu-trivial@nongnu.org
Fixes: a60ce58fd9 ("target/riscv: Support Zama16b extension")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250522113344.823294-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..fe21e0fb44 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -127,8 +127,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
-    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
+    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
-- 
2.50.0



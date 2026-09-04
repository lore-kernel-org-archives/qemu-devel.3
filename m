Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8DEC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MMq-0000Mb-Ua; Fri, 04 Sep 2026 01:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMn-0008P8-VL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:33 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MMm-0001Sq-CH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:33 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso1056693a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499291; x=1789104091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0pef2g1uRhfRbIDzwGXwuR1il1zM+0FtwRR78VNneY=;
 b=sHIxUI3EL6P+D+gifEcuTahSlEGL9oiblw3slzkiKfmpN3SqBpqpEmWGD5MsoZ2QD4
 iyNJ/V33Ala4TaByKOPrL5uc/H/WI/QWNAtSxeQeZ9lejhlgudFz0t5S++yYoEWJo46m
 1IPycJgxZLmBFoldA0kufQ+bsKxuItCwY1bIBrEkKp8vlJelOAoHgsivWl4pb/ZSAc7Z
 5eXdHeOVTIfX8RYIb/Lwwx89X3WlLV1chrYhtUsmvBeeE49/UP8BiqXPZzLTQhO9K7jz
 JX0UoLPgXIrvfT1Idt/mZnTopRijfsMul1ipk177e94x/N+DeD07z5WfKAhwVVTdQd/X
 PX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499291; x=1789104091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0pef2g1uRhfRbIDzwGXwuR1il1zM+0FtwRR78VNneY=;
 b=bZNdALGDnMYRURuPyPmZtUSMd+Zz3KpZKw4WWc2UVpEBnrr4e84MtktKAgHUXaIoaY
 D6jUO8mph7u/2VX4x8tomIGX7je5fX90y2ZRARKSB+SVoGlxvuFC8mNwSft54qjkb0TP
 ovWqoOOYg7suSKZuWEm+4hKphm9dmsjz6PE9yCg/O1b77WLIYgf3ADJ9jZuDnZAyo5w/
 g38CP2itJZfw915+THEWGJMxVrCfdzQSG9mNIXnsSfdHuon+cOUgiCvqlJ76cdCWl/Z0
 PEPhychm9pd13iucLR/sSbbtEucU4cglv1V+9QePaOKyA115j8Zgz2VopenW9HOffP+Y
 xQyg==
X-Gm-Message-State: AFuF++ldWPOizKPQUE3lssS0nBJsgRip4t17x/Vmw4tKfvvtdOKl0tL8
 ntrhVFwhMT9dQqLJgvHasirbZsrcnj5Vi0GsG3nI1CwmBqlO/vCBoQk1TMrdXA==
X-Gm-Gg: AYBFou1bvTg07/0Q51p0QG9wQIQ6xEo/LQj7svE3nbhHnxDW/5aUh6F2Ux25NlcFPay
 YWbH/tbngKwRXihY+fJyDLaYa80+ikI5hDUI2kyiC0GEiF0Sr+ZkAR751Zp9fNHSaCQgjFpQHnS
 opEFK0tby6pwDaVb6zYKsyzi+XmGiQ4k2H/oDxMYzOnLodRAv8F8Hyu38ddfnMKQjAPybW0uh60
 8YVQZ/dLmoAkBz1vHbjAPjUm9ldOPCMMM0tOJgMB1Ry+CQL5nacSjtyqYHzidpbydJSxX8d4c5l
 5UBLSJozjwsUS4s3U7c9Nn57n2j3WEbP8/8GhAaTpcbrRf89AteV2CFVoV+Vh6yHSbFPUvKoydp
 VxxYBqShoDsnUGkYZP6k3FcHiAz8u+BJ9Cd4uwZJyoWjtQn46ku/+zMy++noK0uEUgchbQ+dhJL
 N0uokChqoU3ymWws7ZMClJ80ai+bFcZpw8McIPmPTwsofVWqzNBhyZu2yBXgohoioV7YCAC5MSu
 uv8/w==
X-Received: by 2002:a05:6a21:6b02:b0:3da:3492:83d0 with SMTP id
 adf61e73a8af0-3da3a173d6cmr5931185637.23.1788499291137; 
 Thu, 03 Sep 2026 22:21:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Abhigyan Kumar <314abh@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/47] target/riscv: prevent abrupt abortion on unassigned
 value write to tdata
Date: Fri,  4 Sep 2026 15:19:27 +1000
Message-ID: <20260904051943.799041-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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

From: Abhigyan Kumar <314abh@gmail.com>

tdata_csr_write is approachable by guest programs. In case of unassigned
values written to a tdata CSR in debug mode, the switch-case falls
through straight to default causing an immediate abort. The risc-v spec
says:

    All tdata registers follow write-any-read-legal semantics. If a debugger
    writes an unsupported configuration, the register will read back a value
    that is supported (which may simply be a disabled trigger). This means
    that a debugger must always read back values it writes to tdata
    registers, unless it already knows what is supported.

This fix correctly ensures that the WARL behaviour of tdata CSRs.

Fixes: a42bd001 ("target/riscv: debug: Determine the trigger type from
tdata1.type")
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260729230028.1797355-1-314abh@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 148201f3cb..e4d719a1da 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -951,7 +951,8 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
                       trigger_type);
         break;
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d is unassigned\n",
+                trigger_type);
     }
 }
 
-- 
2.55.0



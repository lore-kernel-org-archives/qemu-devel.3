Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB3FC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtiP-00074i-ON; Wed, 19 Aug 2026 23:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiO-00074Y-2A
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:16 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiM-0003oc-I2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:15 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2764515a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197513; x=1787802313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfg+S33mxYhTkp+vJzcce1d3QWdWhesMvM16KE705Pg=;
 b=GEKWLICNHxlAnq6SPDc7lbRKFYUJDJ6PrVPg+tr7KxvEOCUTDKfN7fCdmcKS+d5XI2
 iAa6WxHAIXj9jumqlDgH6vsiUDY/DVhUvepI1ScdWtseaYO7I+NLMwUWhxWxi1OIV8tX
 Rv6JA8zg3C8Ek/LIGWLe9IDAzMOfe1S/UQMaX0D8jzBgKnHdTRiKJBKeV4BDv9jzRIOO
 Waz/xqrCdZq4fw6ekmLfJHA6cqdFPb7o5wAn0WlHdo92EfEjt0mDhpx5QC8605LHx6+o
 zWNcnfCbZcqAl+aof8aj5oiyXu5PFxPreCjtaz1BDG6hxSSBa0Qill17i/4TkqR34KeA
 s9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197513; x=1787802313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfg+S33mxYhTkp+vJzcce1d3QWdWhesMvM16KE705Pg=;
 b=ITjlCvEE8cxMB6DlIJjDUfTYXBS3tA8ylfe4RWBnu/h5ybX/RMsWXZiXubov8albAs
 9xLKvIeTNrh3qZCquBLbtQN4l4OYHrp0B3FUwQq1ZK8saiqB61WA7jMN81HS9iymRXrh
 Vttyv6BBPfWNqmk4bW8lSl5icZaIwsVynw53nHjx9HaB7G3WjIxvYzW80llkNY0OxdBc
 Z9eRs36WvS1mXo/9XOOmTtfOmQwXcc9e4oD2r8/k9CGhoZKXevdNHalaasFoirb/yBQ0
 Qwjiw0v5QktC5ju8EguEaA6j2JGKN5lmdj1lFEQjfNi7lgPQriJBABV/WTznfg8wxzGA
 B7kg==
X-Gm-Message-State: AFuF++m74le/aStXSeETsBPU1i3wvP6EEmcnGEVS1+3w3uHiv25b1sI4
 Cai4xL/EE2RO9ieeUufB3ofuTkxuNIMoZMntnW/4PKvNumKNCaGY1QOOFlaRgw==
X-Gm-Gg: AR+sD112RbvyTIKPCRv5EfiLfyA9nPWiYTgoOl3t7BT1JW3uHQI/hW0hqGrkuUgt/mZ
 K/a3Kal8ggVpvFUlUorimiT3npqLcYDDr+I8sTIxtSIJ790Ww4cVP4frWvnzhT6jjBASUS1/8jR
 rz1G3J2WQnVWD8ttk68b/t1XtMFywv1uMnhI35v4J1DrZfqeznngiBrSogBvlbcBos+qpgSTXVV
 eFpw7/NFmJrTKJiFP1BXg6114nkrLR/zKgijnv9OWfAzCLXSa7SNyvwz/PghctFR21XcReQSecE
 MZWE5mh7jqMTfqIDo5a6dIRSgNNvfbj90x+8MXhM3as8rrRkEGg43MsWHH6kWyVMn6lBxWAa9ck
 vRnK99sKFln62G1YPjEnvzEKJy9Vc+dgumEywqqzYycf3SNWCmEEunvEj0PgQMXlXKhJU+vGyoR
 2Ae8x99Tb3213gyy6qOLvxSbDuqxsxEfaPasHEJSlrBqTVNFdzEu+GR2lEt9DwMabzluX6UyZbV
 oyVzyoNdZlc9eNuhrQ0dXshauBc
X-Received: by 2002:a17:90a:e7cb:b0:38e:6f90:eabd with SMTP id
 98e67ed59e1d1-39580aa5106mr17743204a91.5.1787197513245; 
 Wed, 19 Aug 2026 20:45:13 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>, Junze Cao <caojunze424@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/93] hw/riscv: k230: add a noc stub region in K230 board
Date: Thu, 20 Aug 2026 13:43:07 +1000
Message-ID: <20260820034430.1186695-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Tao Ding <dingtao0430@163.com>

The NOC address was accessed in the k230_unzip driver, but it is currently not in k230.
This commit uses create_unimplemented_device to preset the region.

Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Junze Cao <caojunze424@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260808062227.66961-8-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/k230.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 5163eaa7ef..558f30b97e 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -250,6 +250,9 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&s->decomp_gzip), i));
     }
 
+    /* Noc stub, the k230 decomp_gzip driver in uboot will access this region */
+    create_unimplemented_device("noc-stub", 0x91302000, 0x1000);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
-- 
2.54.0



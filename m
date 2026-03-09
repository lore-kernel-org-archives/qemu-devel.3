Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1263EEFCD77
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXIx-0006HC-7f; Mon, 09 Mar 2026 05:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzXIs-0006Fh-8G
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:53:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzXIq-0000gn-N3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:53:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48535a0ef86so9408495e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773050010; x=1773654810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gKNmKl0vacYZC/r9wSH3ugWYQ7msGR+dGPcMXTncvzM=;
 b=Tt/tcdUNIxEOVMkJaJ54+yvKTOEcPxXkd372sHpHyQQUenA1w31PGl8H9O0V8XuszN
 NdIHl/Ihz7T2hTSnIsJum8/X283VfOi4E2wzXDYa+qBFhF55ur6XpdJ04IVNMinmiuv6
 KHImQVL00IvfbFOLNpzhPqVRY8zFf9ope5imdYdjChJWtftSb8Hf6yPR9LLdkxhq9AQy
 k0JfqYIwtStcM2D/3qo4M3kaIcP9fYm8E7GDEei5zPjd6ekgME5NNLEsg6uA7IvSgqDZ
 TPnAkllB5+jXOdcTb9sh8StMsSWPEBfVqc7KZm14k5BzfhD0eeKJ0qrQe48CDhdlTHDr
 p7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773050010; x=1773654810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKNmKl0vacYZC/r9wSH3ugWYQ7msGR+dGPcMXTncvzM=;
 b=ddiW1inLZWFCiTSQ/ITQgadbtjAtdujtSbkDidYv52tDiOQycRF6aeY5m4/osSCoB6
 XhlimfwK5KIgdCFmSq+dHO+QrwIOj4yQsMBHH3817AAWL5vxBdawi/hIzXjKbH0PGb76
 o9icsEXvCWVgZaVc/ZfEIfUVlbSIuo7ooOo9Zp9gxvYK+DP+2VOYNLDVYILhkEv9dF9/
 Bd56h8HX5LlyBd8Rt4jIfqQAGDomiYeb7bziSsu/+ia2t0tp0lQ2LIa1DFi1TaLN7gNh
 uYaebiu73eGnrKLY0QG8bgsyKxAcYyJgfspgCqFVKR3zkth+d636IY7tNA4XS1Tl4XJw
 DbGw==
X-Gm-Message-State: AOJu0Yz0cDxoueuIc/88HntnPbSphJk2+S2tZZhYbuBReukx1H0ApTpw
 Kw4w6kYl3O7zeqfkL3frdh1FU7L9C20+orOZthoLnifjVbZ71rAJn20OGIH4yt2ECcEkq5kYb+I
 Rs+H9
X-Gm-Gg: ATEYQzwmiWhfBgUN/fBsW4OyK9edSYsnKyj570DoutIZSdPckl4Fq1WRW79mljkmytu
 N6xY6iG5knyg41Iek8A8KVl5KXXuz7Ugj6U4GUZ+as6s2NvIzugMM0TTrZeqyTOiY3HaHAa1fVY
 l6qqvW6cxyFKYwp7G1o27CUinVhm7ACNBWNghE5Hy5LgycNb/43pZNLRiG2SJOZ0+gpd8VNDwFQ
 f06qIrJrjVc7JwidyT7kLOA1C8Sl9958TbcP61Hl5AlDeGXVtI5gRirBpRiKKzG+HByQU6l3Z/4
 0IYiFxpFqI7xq/x3vhdzZZxgwBHnyjgMSHxCsPMNXkFVoV30ele3WRP/qo6gR+HgBAQICJpm79M
 KmPe78wcmcjcXL71WkBJtqdMe3Lx5K5HQ1h77En1Nu2Jn6b610XAnmzs5Gi6G1eQYNMioYBlw7C
 5U1d0c9juJXNhWrxJ4t2Z82VR/6e/g4n5YGUCxgNDDzn1FZfUkfGZtyuxFRt7sxautXHtv0xlRn
 Vs4f9BolJNGUiv1qcGmlT0++zcwHFg=
X-Received: by 2002:a05:6000:228a:b0:439:d7db:c526 with SMTP id
 ffacd0b85a97d-439da880c49mr18273944f8f.29.1773050009620; 
 Mon, 09 Mar 2026 02:53:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae35cf7sm24035860f8f.26.2026.03.09.02.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 02:53:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
Subject: [PATCH] hw/misc/riscv_cpc: Free CPU array in instance_finalize
Date: Mon,  9 Mar 2026 09:53:28 +0000
Message-ID: <20260309095328.1406779-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The TYPE_RISCV_CPC device allocates an array in its instance_init,
but does not free this, leading to leaks like this from QOM/QMP
introspection:

Direct leak of 512 byte in 1 object allocated from:
    #0  in calloc
    #1  in g_malloc0
    #2  in riscv_cpc_init /home/pm215/qemu/build/san/../../hw/misc/riscv_cpc.c:175:15
    #3  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #4  in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
    #5  in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
    #6  in qdev_device_help /home/pm215/qemu/build/san/../../system/qdev-monitor.c:313:17
    #7  in hmp_device_add /home/pm215/qemu/build/san/../../system/qdev-monitor.c:1005:9

Free the array in instance_finalize.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/riscv_cpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
index 231a419062..4bf2fd8db1 100644
--- a/hw/misc/riscv_cpc.c
+++ b/hw/misc/riscv_cpc.c
@@ -185,6 +185,13 @@ static void riscv_cpc_init(Object *obj)
     }
 }
 
+static void riscv_cpc_finalize(Object *obj)
+{
+    RISCVCPCState *s = RISCV_CPC(obj);
+
+    g_free(s->cpus);
+}
+
 static void riscv_cpc_realize(DeviceState *dev, Error **errp)
 {
     RISCVCPCState *s = RISCV_CPC(dev);
@@ -254,6 +261,7 @@ static const TypeInfo riscv_cpc_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(RISCVCPCState),
     .instance_init = riscv_cpc_init,
+    .instance_finalize = riscv_cpc_finalize,
     .class_init    = riscv_cpc_class_init,
 };
 
-- 
2.43.0



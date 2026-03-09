Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FC5F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzd0u-000750-8c; Mon, 09 Mar 2026 11:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzczW-0005RT-0v
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzczU-0000tf-Dc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so12037715e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071875; x=1773676675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FT88LR+eo72/LXYlYp0i0a+oKJzqOg43I+KETtJ6zlI=;
 b=iKHTeKiaqXVy/tFipIryo2XrGn+cN7LQG0HAXLRbh7ZNGqs1rp+0LtbhC8MfnZtL0B
 4TbaZgETeYDc1ffXUDK+BxC3azU8XmmIqBIiP22SOkooS/9ZsdAqwfVkgncD0ai5V9um
 E8b3RgGnJnvEgcQx32kKjpnxVrcvEZOu557I1nd9dJGCU3NusHbrSTwaYGNj/RmOyQpl
 4ydBmuPbACAWV8UyznODFfBQJxo1JcCJOvtwtYgA3d91cI7EPQFSKnDz2H1TyCLvcHgW
 e++rgTL5X3ig3Ku/yPktNIBT1njOB1VEqLYTOt/pXk4Ts3uNvUTTNSWgDxHaGAFC8+Y1
 xisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071875; x=1773676675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FT88LR+eo72/LXYlYp0i0a+oKJzqOg43I+KETtJ6zlI=;
 b=J4sRQr+TVGlzjGYJ1mn/GwZgsjK2soQEzs/GeR2JakvNX5adPkpShEltFcPP45avnV
 d+UwbqfsU+Q3WHuW1MtSE78VEpa/PuloSrGNYcaZaVnHcqEUqxQhUpoILtMmJzTBr8mb
 qdc/QDQhGMG6xYMo86jbGYgZK57cWmuou+JHzkuOgmSVify4Hm2Tkw/pZ1EfreHvkuRU
 mXFnpop1UBxHmYO8eQd8c+pL+5nFyhsmCxtKY//jQmsEKuRuAQqU2EVhGk41k2oAsRvq
 nHyLBXpP8QVZD1gYuXQN9fMj8zOZN5ZHvNKVFIpn6vyO8GNo0wx4Z8QQA+7K4YLpQJVh
 xMOg==
X-Gm-Message-State: AOJu0YwxyHvI55LJm3Ng5J0UV4QkeD5tHUVLrA7Ewx0DMT3we2zdjZvF
 HfI72GMF+z6XRmtc4BKWobhrLRk6/Mqf27wQaYoOEjiaDGXOoEx3tmwwlaxGlHLhUBeg3kEaVYn
 /hV61uFU=
X-Gm-Gg: ATEYQzzdQ5kRf6aOJDPDAqNr+cECJrU4Q65Tn9+VVyeY/6ASC59MXsDZifVcaIRLdWc
 DTnSbE58/MORYkuuIQpYiOkMrgd0hdokVsnPFk+3RLbjrPpqs0s6sXS9anMqNi7zeqYqAs9/4QB
 KpHSIVeE+Hkt5fIpgG8tjjg3QOK7rxB7lyzbbbpcBupKM3sAavuicKJ0ECqYVD4/fMTXOwrf2or
 Ujw4SGc9dufNhXOSo+lLNtx7fa/KeR7rtxM+nQPlklWFdni3Kms/dxdEDwnqmo6FyxFEbEa0Ybu
 XR+DxZqPsiEyu/04fJ0ngqsMzxHz261hUcDvhkFjqonSml1HWpjZQnXYbBWSoNdKdYFuh8MDxhk
 7X/Eh+8eHcepGUdQx1+/0RPEnZPLUAzLQcLaArkn2PjNa/9p6FOukH7kHlgHVGyzxRP/B5nVNmy
 q4+AwcZKfbInYIjnJ8qUaRRw2HoRdG7GE7l9X6ZGstDtSToBBJb1MrZ4WRrw90mhfANbt0Bh7s
X-Received: by 2002:a05:600c:64ce:b0:485:3ca4:4ef4 with SMTP id
 5b1f17b1804b1-4853ca451d9mr47071325e9.9.1773071874580; 
 Mon, 09 Mar 2026 08:57:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a9e6aesm799245e9.11.2026.03.09.08.57.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:57:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/49] hw/misc/riscv_cpc: Free CPU array in instance_finalize
Date: Mon,  9 Mar 2026 16:52:19 +0100
Message-ID: <20260309155219.62400-50-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260309095328.1406779-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/riscv_cpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
index 231a419062f..4bf2fd8db16 100644
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
2.53.0



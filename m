Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BE1C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7M8i-0006tW-5g; Thu, 17 Sep 2026 20:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M8d-0006rq-3H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:07:35 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7M8a-0004xu-Hy
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:07:34 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d91ede8035so1899005ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789690051; x=1790294851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oBMRBBSVYhuVagEH9MTyYgooh4obneZYFeG93/UBHbo=;
 b=rW7ccpA/QN4Nltt1nREMT98FSfbtUgQD9nvxSE4X5k52xFrL1g4ByTK/ut5arcP1sl
 Jh5FamRLS5ihaVn8FBJvulYX+JiVm7wL6UHn5K1rjRAqUav6uk2fpuVhbYOUIb7ZGDhe
 f/HvJJN8cGuGp8EvzR2o82AmmSfiT6wrDQg0YAY0NZNI8kEZjpvAqMw1sChkWjicJRVt
 D8iTXsKWaMd/EblK8wj1i5uDY5w+0gf4xvnMNyjSxDPRyeDYMK4losVrX6Mo6Odx0QOM
 M7DbuS0hrkmmrhSa0Lie3json8mNOARqJaBqXgBXZgsldmEJN6fwQZkl8O7RCwGnOI19
 7GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690051; x=1790294851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oBMRBBSVYhuVagEH9MTyYgooh4obneZYFeG93/UBHbo=;
 b=I4BwPtbKeRGozJjNMX7EwXMDuZmYBS8EPbbvfwy62IQbbswmX9TvqJfGlqaq58hrsN
 wcaiZkvtNlDeU1qp9rGEhfDiVMxA/7DYqIoZ9xK7sPeMaMOT2opmZ1Z/mXVvgVdydnwM
 xsT169p0Qll6LgZjepnZrOhcssX0qrnbF3rWCaO2Ywvzt8ORerRQJ87cZEOd7xh0U2hy
 ESlUWFatJO7UdDi8H4furg37l5WoindYUFMzKZMhX/nGCgjqmQWQwzm354bIKIJCDSDh
 /dCnHSiC7sZo25OTfZf1BRphNiGJSqfHf9FTpNzDLzs3LzI19FQkFhGaEBP+hGcRPIC+
 8ikg==
X-Gm-Message-State: AFuF++n7zT75QIm0RcT9uNIXk9iLXRSUpECYHwise68xl+aR07MQo9yN
 RXK7a1k8ig0y2gq5TJij633HyJXzotlXR8OAv+J1bXuueCbuR8ETLgelMFyU6P2RU60=
X-Gm-Gg: AYBFou2ID8cbPkh4UTsKewQIiSnDYKN52/KY6qpiSKqcZhsifIPt4e5/6udZtP9n6bb
 TFaHmoFd6dag6MJt9MFduzooNjXDPmFFn8CvFlP1qJXvq3AlYW4CzJ99J1b3KDNLvOZpu5Kydcm
 4eIzcXvshiInWR7QWGy4d5XIHE9oglv0TtACgetdZ9gCXnxeHfMUqhNugaNiPG/SqSmivAWF9MR
 4POkRWuPLJD0lz/GJkYznAsGV8qSG3kTU4mMD8I/YpmJ5oEju9GJFKK86cvgpKc6gypiv8LsO3O
 XWH6AJTPA2YYvh2jZNSwfgmQJvBjj/mpe+Cco+d9+AU3fPYQr8s8lYFt2g+0xbdIGEoKXKQYL02
 W0T4Rb9DdJLJti1fVrlM6oMphjUcRLtLze+6gAnR6nGJ3dEMMVtmlzAplTyBOS8JqKsd20dGE34
 bvNcnNJADfZgQPcifCY8F11LWQo6f54FnEDjYRHiaRPQHHA6Dot36oBa4Ymt2Z96KrYHtPkE+g7
 ELK+ZjzGA3F1bceFWZRU4dLBAiyd3KsglYmuUe+DiM=
X-Received: by 2002:a17:903:124c:b0:2dd:ad74:ac84 with SMTP id
 d9443c01a7336-2ddb1be0d9bmr15362295ad.31.1789690051200; 
 Thu, 17 Sep 2026 17:07:31 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33bf5b1d335sm20328212eec.28.2026.09.17.17.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:07:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <17746591750@163.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 8/8] hw/xtensa/virt: use unique QOM name
Date: Fri, 18 Sep 2026 08:06:39 +0800
Message-ID: <20260918000640.1001-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260918000640.1001-1-luoyonggang@gmail.com>
References: <20260918000640.1001-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Register the board as xtensa-virt so Xtensa virt no longer collides
with other virt-machine types in one process. Keep the -M / help /
migration name as virt via machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/xtensa/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 271f06e0953..dc5b255b9b1 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -118,10 +118,11 @@ static void xtensa_virt_init(MachineState *machine)
 static void xtensa_virt_machine_init(MachineClass *mc)
 {
     mc->desc = "virt machine (" XTENSA_DEFAULT_CPU_MODEL ")";
+    machine_class_set_name(mc, "virt");
     mc->init = xtensa_virt_init;
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_nic = "virtio-net-pci";
 }
 
-DEFINE_MACHINE("virt", xtensa_virt_machine_init)
+DEFINE_MACHINE("xtensa-virt", xtensa_virt_machine_init)
-- 
2.52.0.windows.1



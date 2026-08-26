Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F18FC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIaq-0007mb-MY; Wed, 26 Aug 2026 14:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIah-0007WK-6u
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:43:16 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIad-0002IQ-8Y
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:43:14 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so261487a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787769790; x=1788374590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=esiIQQ8j+uvEVKSy2+ZWdGzm2PcDAqeU44dys6a2Fmc=;
 b=LaHV+3ospoSnq2nPSuxnZN4wkZBxGzcDJzGalw3kA9oDC4eULJieufGH06Mahiw+YA
 0pLy14MJsPO3ZcCjkuJw3eb9XGPCvjVBE8bxK48udEHwLbveoTOhHDrzDq5QCPZanBKi
 J6gm203u2bv/RdhW8H6ENlIg3HrHPkFajvYtBGvmKCR/j0cFVp4GK3oJZUUF241UwC1F
 qw+lXEBrlyb1H+OOP0bbu1k+0YPz5vzrQbb5a2c16Bpj1sTd8r5/oxtYKNzJlBwZYxH8
 unzu8DKYNRU3VeeRbc3vq8W3lLwuAOb1FzO41jd4P/l7UBnY2maE5lQBZwXc0DARCWcq
 /lRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787769790; x=1788374590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=esiIQQ8j+uvEVKSy2+ZWdGzm2PcDAqeU44dys6a2Fmc=;
 b=Agun/vZF6sSyPH/FMf7k35Sx51EKSeK12OSkCnHHffRSvkDrD6N36ZqH3OOCM8M6xC
 Fnjtc1YcdsMNKnJZ0AgPH2lhV07eQfTfRy6xUUQw7gPqNNY5mJFNIJnc+guuDPUdD7fy
 sB8NjJUdGM54GNfdsj7fXFbMvu7egC1rD/l6MSsQ4Gq1F4LBZjmuZzmttdhL+IHFjAD7
 4sH9j/W/0XjfYnaiEuZbFErIdFwUCH3/vz5LiDHkTZ3O3y0EXkQWzcVkV/vWy9kbj1a2
 jfovnDNSN0O+c/SYYrSVxypjPNK/IdCpIFvqkPTZoetA2SW1tKoVCi3EvKby711KtYfF
 IW+w==
X-Gm-Message-State: AFuF++nUOGXWVJICgPvSzqedymC8Soot9xQFxc/oaiSw3FzzdZO3P47i
 mX044jkPNmv/YalMhr1Bd+IFTp3Muh22vqLN4Uf6s+r+1Z+ysVVVFhNiNMD60sqcrAs=
X-Gm-Gg: AR+sD12dPOxnW28DzxEUWPr17TOWmvUFkUTVqKXwtnL1xxAZ4VmlxRXl3sZ5InSbSA6
 g1wb8KhUqmIASPIUvhuFE+kxzL4A22Hq/gbEia7liV9/i0W2it8vohqUllv6OIp6kKMhtXA6/zT
 93gxy1P1RxoH9+iSyoWoFrl5vpHmVk4yAQJuojNieDwXS+lBEtTMlqxYFjebiavJglQ89FbtQMe
 wwfCHQydfrd/CvNLNOv8CaUcgPvt1w4rY9TjYyNgF4bq/AqYDptGAyMkAUYPN0ZV7SaYIOnxOjz
 4gRPXxM7+WK2gF22jnsIT3+nmTiVm7OqqvSP5bEiLg0xn8nWpJpBk1V5olW4SSrU9uUg5Zg6Npo
 vINGtOG7Dk24QR5qg/IWSLhFpRhgizECH/YWTVhLyhkUXo7cEhaJVqQk5MKCG9/Rn/LyfpONWVO
 UsvMb3ZWzRzG6m5chbS0uB0yE1kqp4fyVIIBs/A3igKQTUnFw8PIGdOyo3gmdtAsXLZ9vWgr40B
 RKN1P1OE+1t6ASPuzYa8g==
X-Received: by 2002:a17:90b:3811:b0:37e:1620:dabc with SMTP id
 98e67ed59e1d1-3969b7e33acmr1328049a91.0.1787769789662; 
 Wed, 26 Aug 2026 11:43:09 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-3283d60c291sm17681846eec.6.2026.08.26.11.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:43:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bibo Mao <maobibo@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alexander Bulekov <alxndr@bu.edu>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-arm@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v2 03/13] hw/arm/virt: register TYPE_TARGET_SPECIFIC on the
 abstract parent
Date: Thu, 27 Aug 2026 02:42:17 +0800
Message-ID: <20260826184229.1145-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260826184229.1145-1-luoyonggang@gmail.com>
References: <20260826184229.1145-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hide the ARM virt machine when the selected target is not ARM in a
combined qemu-system binary. Versioned virt types already implement
TYPE_TARGET_SPECIFIC; register it on the abstract parent as well.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index daba9af79f1..c2ace7706f1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4161,6 +4161,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_base_arm;
     mc->init = machvirt_init;
     /* Start with max_cpus set to 512, which is the maximum supported by KVM.
      * The value may be reduced later when we have more information about the
@@ -4431,6 +4432,7 @@ static const TypeInfo virt_machine_info = {
     .instance_finalize = virt_instance_finalize,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
+         { TYPE_TARGET_SPECIFIC },
          { }
     },
 };
-- 
2.52.0.windows.1



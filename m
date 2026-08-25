Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10081C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzDs-0004zI-Uz; Tue, 25 Aug 2026 18:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDH-00042c-HN
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:48 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDF-0001xD-Tu
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:47 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-395ea741d07so382696a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695304; x=1788300104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dhCTcoxWo5P8En8U5WBnLltAvsdfRdW+zmKjCvPnEtU=;
 b=xyduix5izdz50qfewikh2ed6NQ/zuoDVe7DU/C5JXddGrKG2pMSYBXGMBmqBynVaSw
 Efeq7AKU8dm63soYrdwzmfTOkyJVcZE1v8YTkAjNivMMO5xH3Mj/kVEG77CkdbyAKJBC
 N+XMTZEBvQI5Pf06fG+pj6FjQs69VLae7IczbqkHjeUt1j5lCHFlhKOzlfAdw+FTXHOe
 SsxAIGbWhhhfArB5uZeVH/sAWRsQXhnl2nKQJBqPyhJWvGG+mto00ExPFRgC7Rc2YRNH
 svwrGtMwhu/ZBKJX2k6RjodINRfaugeoyNTxl/emwHdFZ67dSCN7V4QeWDGhPUwGPqJl
 LmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695304; x=1788300104;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dhCTcoxWo5P8En8U5WBnLltAvsdfRdW+zmKjCvPnEtU=;
 b=Y+jfYRwk6B84n2Q9JukzWsqXAlmOmHL1rEefb/cvsO0n0XGNbgsyTZXa714J0hyFmU
 gzMDTM8I0Iq0Q34M0itxl6Asz289+ofNMmutWLJmlNVbdw9ivc+OG7yAjkievuFFKgHK
 EuHFH/pdIBAhuno2Yyjq19Da65420ASjyVinh5kTlRMVEGQwoW6ZIT7Wmn5I8TG0vG3V
 0yfFIdTQ9ATIadPJbQ9Zk2qdtrPFwcryGYOI69obX1yxI8hGsfINaL8Zq2c7PZ+qi0IP
 SGKxbZhP2X0u5e90yOpNgNc3b9pzhIbGXa3XxMkKi1zlNwGeWiFnGwRUV/94cKeq3WAQ
 wZdg==
X-Gm-Message-State: AFuF++mNSSobyDJCXAaVhvZiEkP2XTXGVtrR3ELtVfXvk0b0Kq3KYzNs
 +pVlZdXUdCddx4bq8x03lWxRB+Cd40HTSH3//3OM0z6HRxOLnCEthGgXq6+qhlsgkoA=
X-Gm-Gg: AR+sD10keN5jSywpz/iUjcicmdjatq9zY9mxHpv/kTZR6q1YPbk1Rg/0ip3XjsTqs/o
 Iptw8PB4mjOdWHCCwIpldPLlPievLO4H5RejuohopGkcF23w0Y36h+sAzm/BKIVfsiXGp53vDdv
 CnfSXo+KmScE8k2XDEgY2UER//dFMnZDkXxhB3+0ZXeK0yJIKlEi0dhE+7zSTQgFj/rg5Zh3Aww
 BwMLbRmcvwSGYShdUGxte0Y7dWOduI5bMm7QJaupVI3XuDeSR6MG2bnwYDjDHmKjOu1QCMAijFV
 1jKFo985EkxdNe/NE7rdnwE7aqG4QtQAsQPZIzRJNBaGJ8TBt858EIY0lx5iwlKTB8V8e/0UFAD
 MvhxhPL1fD5bFkqSoxDkrcC5yjmyok6HZr4PH0zFwSVI+T/MaWQFk5AP1uIzJ07zhzi7LqyMYgm
 YNQ5TmLYAZORUPJ26tIFCw6Fn+sftyAPWfyF8s5G0zmPLxm6l3bBKN5fuuBTLVROE9p2Jx1SqUe
 yJLrJrgnoM5sN8=
X-Received: by 2002:a17:90b:1d47:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-3966d8ab6e3mr4143621a91.13.1787695304520; 
 Tue, 25 Aug 2026 15:01:44 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:43 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 19/24] hw/arm/virt: Move virt_flash_create() to
 machvirt_init()
Date: Tue, 25 Aug 2026 16:00:56 -0600
Message-ID: <20260825220101.3443954-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1033.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

For confidential VMs we'll want to skip flash device creation.
Unfortunately, in virt_instance_init() the machine->cgs member has not
yet been initialized, so we cannot check whether confidential guest is
enabled. Move virt_flash_create() to machvirt_init(), where we can
access the machine->cgs member.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c300224f19e7..966577d6a66f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2861,6 +2861,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4350,8 +4352,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93056C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEx-0001aa-Kf; Thu, 03 Sep 2026 15:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEw-0001Zu-JL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:50 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEv-0004LM-0d
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:50 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so225902a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464207; x=1789069007; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1L228YeDnliJno5IJsBCLMujCzUwIWC4F+2ZyI1byow=;
 b=Qr8AxNsINyciuwRzhZdhqZOIvRS5CIYxgQzoeQOfpB5Qt59g9hnpRUdyRD22TNpdBk
 QWznTfMmz72GdXlj56uNlWkiPW6wXXhe5J6uPtHGM3/3YmEi1jtN4qyvmUIRUeoAlfxi
 HZbbob4PeteK4xM1V65ZwT8pQ1aba+pWvkUZmYkUn4qZZ2F19Td0iRvSTYpbwEDBwENi
 OhNLGdBXpokSj5iEMk3OrAYUYhvM24txagZW0UegFQKmswzxIDO/dm61FisaOV8Ak2NY
 S98g6D3Vt57nOHZ/fcNL0abQNVz2lC18f78MamCf+crBERykosYdfcQtGF6EuCapeqCQ
 ffTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464207; x=1789069007;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1L228YeDnliJno5IJsBCLMujCzUwIWC4F+2ZyI1byow=;
 b=cY7XAisChmdPnj0iNNuVs9se78OZypwRuaQUbrMEfsENhuPLRS1Eacl431bZDicTNE
 GB/i6XiWuT8240gp/cI5hPa2c393JjOcuXFEJKcAVH+ByVlX6WteeJpGZ6SG+aQ3tKUv
 cZzEZVD/NSwT37eyTmWEtD3vPRaM3Y11iqNyLSxWxjolY/sxNh2EiH/gNee5T+DO/09F
 OxyKu4X6NwFJGNlo4hMUnVwv8KRot3dFRMpucgmtmogrjBzNM6eZVS+bTTd2D1qLhHeC
 Bfst4FBRONBYgx1Fx83G759W47qZUqC4enIEeQUX2LarFSPJuKrxOcrwcCkoIK5F2LDw
 QPIA==
X-Gm-Message-State: AFuF++n5Bwl19Pk03FTWEyJuQc735cFHvnjOLkImAo3quejtQfTJbEDo
 wPuHdOBFWWBhQMkuDmoNJTTDi/bW8/d2ie6tkqQ4KL0U9jsrnvD8Q7O/7z5+Nif5tmk=
X-Gm-Gg: AYBFou1GXK9Bg8NScwi3+lzozPy1FEl8ALS3EkoewoZnsPq4vvTVzxfIdSt5TqIX22X
 sla0fR7K9resAFIm2eIYUHJoPG8E+upX2rIquv+6vuOuKlwNm1XrYzxDtd9ByZeH25ANdMDNv6p
 cVkR6Bx49CPXxBOWsEkv4TmJvJmTi5m1cv4vyipa76EWwaJy/JkWt6JgsLJgd6eb3fVK6soWFs1
 sfNaXG7+aJEVeCMqoej9TGkL9UGaB0FFpWW27l4N8Ct+zf1xyX6pznH0ALs+atxfGqLa44qqNID
 ibz37d7+oX1YEqUE2Z5uJe2AATVAl74yc4Lue1M96cJiEW0PfeIGB75mJpYjMtW9us1DSbxlUEf
 5d4Mw30E3qpCqT1tDPFCI/ndzoD/7JNJx2EE9H2pMiXHxqDSv46zjo+J5AS8/D07mVFG3w6rzFx
 B3z2yJ2jmJ2Fc7MPwuxF1KDNGYWFJBjfPvB8TPIKyf4pyqKeBUqJ6mZ3cWNbwoueXaPkqGiaK34
 nqhqrPd8NeHzqAFl6qxy6+ku1M=
X-Received: by 2002:a17:90b:4fcb:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-39b26100e5dmr1338301a91.4.1788464207294; 
 Thu, 03 Sep 2026 12:36:47 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:46 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 19/24] hw/arm/virt: Move virt_flash_create() to
 machvirt_init()
Date: Thu,  3 Sep 2026 13:36:06 -0600
Message-ID: <20260903193611.1058589-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1032.google.com
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
index 329c881eb91a..f3ece746916a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2911,6 +2911,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4435,8 +4437,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.43.0



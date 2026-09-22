Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2437AC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98TN-0003fe-HU; Tue, 22 Sep 2026 17:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98TL-0003XQ-1J
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:19 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x98TI-0000xy-PA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:56:18 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-142dce6e235so212733c88.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790114175; x=1790718975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fpd3U2UtiFM9ji3DP17/LWtV+Urf6yASDV45t5UQm5M=;
 b=WIoSsrlvUfUCb8wjpRhNTPRwvN37TyTiuFXTeuRWSnkCbTw8AJgcQyhSJeLvoA7ZSb
 drVozwWEaXkeVFJGq3tn4xeo2q8oiBiYD1Dv7Uw4xIfrR1oOoRSxseWnBjwEf9ISJ4Gd
 /5fUWK8Fo74L65IMdsVJflR9rfGSEBFesSfi7P2l30GJlU+6668f8dNF77HJXlvpNOh7
 /vgaogpTKfkHODf3Jyprge7nBovz+jQy4EYbwbGzxTNY6mLohfcGQsp2CenAlvw1b/cr
 kPSWyJxheARqxygjMeYjzKjdzQGU7AvXgVSF3aWfWpK5JDa8lqlsaRwumlWg8Z5+NLtt
 x++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790114175; x=1790718975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fpd3U2UtiFM9ji3DP17/LWtV+Urf6yASDV45t5UQm5M=;
 b=NwwyeuUBBdK/6HQcvUXyfdoWK0L8T5tJESbdlXG7i7GeVvPrYPDhIae6x4rnj5nYhd
 B2lNkrzRJaN5z2jVvEytMsr1RnX+e188QEfYa/CxQUXUfLN7padksdmrkw78zkzytv07
 hDUUf1pUjsJ9/OS6hSqKYEVp7zvpQWU2RG6m1Wb6/Kn7+w+cYJDmDyJOs+ipGWC9h0p5
 be4J0gNA8ovgrV0hS++0hMFgdDu+FSsMxOrXQwhc+A5g3Dxsx1aUubHiKD61WKhECyiV
 R6YV2u5kFVbN0000Wqpe182/umJpfj+N0T1zD6myoHdh4Ve5Sa9nCpeOUbwfrj3hmhdH
 zMKw==
X-Gm-Message-State: AFuF++lRvwxGVbDY28ErNhIsi7iOsJwJmR5uu9ezC34vgV2V0zpx1S4N
 /UQ8Y1WIh1/Cq8Ce1VmTPthbGT2H1LYjkwp/fIaMLufhdYCRyxvaJdPFBI/GD9KexvQ=
X-Gm-Gg: AYBFou0avrEwJz9z2J/N2CY9O1xIYjFTfeA4SmbktceD9zhxFMwpbCcryjNlG/YMH3Y
 m2SHtnvgrClyrOhwLyEDw1A+IS92v13lanOD/B+DS6XOBdia6gWJbEXJP2tFeq/8S8KMHNqPSHm
 twPsJ84jzy5of3UJGyv7OpSEC2TG/at/s6JSB5iKe+cIou+0Xf1Ka7IEeFzigdj2lMiP4dtfErz
 QK6qRzdPEC1tFImoEQegRVcqWVdb68A0lQuqtlGpAorfYAqeO7WvCfLQE0jJZlo28oTdUfIWKFy
 b1hgdqUcDScUXOVa3Ya+I1f1JzBQQBmM+yR8B9nahbTmWgIou4l+61Y2wk25wN5WRzBk1+AfLoL
 iON1+Hp4SzfIeWh3bpPvXy4auZRv97typRuGll4fmbjOD2M8ncnofV9i/YqjLRaRo/qvkhk68gO
 PHv/C0pKZZ4H3bgTycbzWJsUUZnMHNzPlps0wP/i5Knb2feu/A2ONKQ14FYVlsT45sKDd97GwWr
 YjLG6uoRfYKUG6alGAlBsBos+1um2w=
X-Received: by 2002:a05:7023:a85:b0:143:3da5:cada with SMTP id
 a92af1059eb24-144f9195780mr918184c88.37.1790114175240; 
 Tue, 22 Sep 2026 14:56:15 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-144f949e60dsm1001153c88.2.2026.09.22.14.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 14:56:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>,
 Markus Armbruster <armbru@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 5/9] hw/hexagon/virt: use unique QOM name
Date: Wed, 23 Sep 2026 05:55:28 +0800
Message-ID: <20260922215533.641-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260922215533.641-1-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Set TYPE_HEXAGON_VIRT_MACHINE to MACHINE_TYPE_NAME("hexagon-virt") so
Hexagon virt no longer collides with other virt-machine types in one
process. Keep the -M / help / migration name as virt via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 hw/hexagon/virt.c         | 1 +
 include/hw/hexagon/virt.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index 64d8366d27d..04591066bef 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -359,6 +359,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Hexagon Virtual Machine";
+    machine_class_set_name(mc, "virt");
     mc->init = virt_init;
     mc->default_cpu_type = HEXAGON_CPU_TYPE_NAME("v68");
     mc->default_ram_size = 4 * GiB;
diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
index 4ca2f1ef859..523c4858036 100644
--- a/include/hw/hexagon/virt.h
+++ b/include/hw/hexagon/virt.h
@@ -26,7 +26,7 @@ struct HexagonVirtMachineState {
 
 void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
 
-#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("hexagon-virt")
 OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE)
 
 #endif /* HW_HEXAGONVIRT_H */
-- 
2.52.0.windows.1



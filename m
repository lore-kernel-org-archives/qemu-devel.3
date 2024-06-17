Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0785BC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6We-0003p3-Pk; Mon, 17 Jun 2024 03:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6WZ-0003oL-Ae
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:33 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6WX-00025B-3l
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:30 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6f85f82ffeso85815966b.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608287; x=1719213087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1BUqr0x4kt4aFRFtfYLYMLx4wG1cR940xtgFYntRhc=;
 b=rYLXiZbAZnr8nNj8R9QCmoK5RW4E+o56x4X6wEt6mNJHYeG2VRAjvTYMwXpE9wxhVQ
 IXY6vWfgU2G4LSLPkkDDdYO17vB/AMItPTGVg8iumjwGzN0zQk0b1I1CpG31wi4DFjLy
 TGG4u6dnKHi2Fxvv8mmcu855SkT3SmwWIIx1BTpoYuvQm2DN42+yB0ZIYYFqExgj6UKs
 Lkqs2wcBgvTlFt6dVQcRpHyf68rX2vj+FKokDhr19f5zfAv1emHuK670cK85IfdvHH3K
 1IRzEtRpu73IF+g0qzfNwPiisB2ndKwLHTvIs0E8yme+J18qpJX9igL7p7cQwn5bmf02
 ED0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608287; x=1719213087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1BUqr0x4kt4aFRFtfYLYMLx4wG1cR940xtgFYntRhc=;
 b=llN++vOB2a7+4q5Wi6CwL2bPAcPgyxjUAvz9LryOwq1IBT+r8sHvKfDe+kr9jAtCRO
 Ahf9x3p5SRM9N1mXUgw9SeD03ZgN2vkg9DQSqzQ5JhQIFm0wbNNof1vTF3LrkXqdXgDh
 O3/eSTu+5MDQLePn+B2U70u62P9NZbZIWI27beFr5enc0VXwd7c6B9RnLfGNzMciHcRh
 ChecMQkXLd0rRcrPV8PBysshUcIqrLPJY66CwjtPByxQza71KAQ3HlnhNgZXPhuU1Ekb
 Nt0imuGIuu6qfMbiTOUnIAimX2iUxq5jXFuxdZbmG9ePxsdXDyLG8BorzDmqm2rL3V+b
 XSPA==
X-Gm-Message-State: AOJu0YxPqfdlnjojzSUX6MDSvktp3DETGTr30J7NhTyQq8eRBJAqfzGm
 tjzJWQOavjwETSnEMzDzz7bVsnrBVNpAL+aqvTjyXF8Yw9FVru6qnHMPZzx4FGDZPgkJb9p4VLG
 a6nw=
X-Google-Smtp-Source: AGHT+IEotawJ7bkSqaY5TFgE8YohWHNj2Fbpt3k/XRF3cfF+ysZU+eIRZ/6xe5B9QYbPtruOiiGqwA==
X-Received: by 2002:a17:906:5f9a:b0:a6f:4fc8:266b with SMTP id
 a640c23a62f3a-a6f60cefc59mr499552966b.3.1718608286855; 
 Mon, 17 Jun 2024 00:11:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56dd2dcesm484695466b.93.2024.06.17.00.11.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:11:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 01/23] hw/i386/pc: Deprecate 2.4 to 2.12 pc-i440fx machines
Date: Mon, 17 Jun 2024 09:10:56 +0200
Message-ID: <20240617071118.60464-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Similarly to the commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated",
deprecate the 2.4 to 2.12 machines.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/about/deprecated.rst | 4 ++--
 hw/i386/pc_piix.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index b62877e51c..66a5f43626 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -212,8 +212,8 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ebb51de380..02878060d0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -742,6 +742,7 @@ DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
     pc_i440fx_3_0_machine_options(m);
+    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
@@ -847,7 +848,6 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
 {
     pc_i440fx_2_4_machine_options(m);
     m->hw_version = "2.3.0";
-    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
     compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
 }
-- 
2.41.0



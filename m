Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00478C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag52-0000x6-NK; Thu, 15 Feb 2024 13:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4v-0000MT-UA
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:25 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4r-000355-Ei
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:20 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55ad2a47b7aso1692610a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020192; x=1708624992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOtZS61qj6Uu8AsLWZl4xcqn7jsQ1ZPqcbyAMS2h3AA=;
 b=zx6whR2BVHp1qJALYdthlMg7rsB3hlnSfCiE2PzXKdqQaK1Px8QnvsNvCg5XK7y2nn
 ZLCgJJ1xUtKvj6zSMX9z08rtjM+UQznPI1lRmEEXnF5F04c3TfkIRDFYviO5B0ARjt4t
 +CQNvYH3vfHqPeL96u4XinQpinnp8sKJv89+2YuPDII3PfBh+Jsp8sSAC2o5dm9D9HXq
 ujb27bbT9Bl6hKKv6AMYl0Z9XlpTObbrlzm+yJ1C8wsc2OYlqMXsF9s0w9OTlh7nQj+j
 1Ta8+BTxJZ4EgS+XellaRxrEDe573FViUO6uUdMBsZ0dpFhDbFgaQR41gTVxYpPGIduZ
 GvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020192; x=1708624992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOtZS61qj6Uu8AsLWZl4xcqn7jsQ1ZPqcbyAMS2h3AA=;
 b=oQ0fff9Qa+rLpcUIymP7VWD/AV6GcrbIbhwKkSTSn8jDyc0A9mqiMAHUMm71ivdxC4
 hvJgpn15IvuvCPdW+WGkfEjZxjNMTAhzQnIA5GEuv3Ek/Z1yUxksErXx9BRGCzxQ3Faz
 7tnF931rpjpgBovOGyAqvKitUBlfAO/AbUAxBywHKlK+LSB43M45rZLAgfjDbqFTSeQr
 G+7SyeehdPmy7voQsGKMPNwsHYaKmCNMdJWcY1qTp36YBb7WgvD3ojVbMVv4QBNspXLm
 JgmmiMXHGobsXRRhm1Om+zIqHNMvNkTwPqk+l94Q3qvnXNtpVEDYjjBOd2Oli/2zSUTt
 z9QQ==
X-Gm-Message-State: AOJu0YxhzQzGq3XuuTHhKZrf1Vavk8DLQzeXxy8yfG+82V8Vm3TbcR1W
 Gegh6HgLrL0jKnTi9dZuATjjpZYTSdNe7u5/W7YuBchtOmcK1HxwqH5j9IISn5CM4omT9VRe4oq
 4wEU=
X-Google-Smtp-Source: AGHT+IGwPSdP9G7q11Rjtw1v43RsDS6mKzGXwDo68m8lg0K8jolfufk2AP/Iru3f6qpVX09hJikWVQ==
X-Received: by 2002:aa7:c49a:0:b0:561:ec1a:95d1 with SMTP id
 m26-20020aa7c49a000000b00561ec1a95d1mr1903454edq.37.1708020192233; 
 Thu, 15 Feb 2024 10:03:12 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 cb18-20020a0564020b7200b0056289a2bee1sm770404edb.47.2024.02.15.10.03.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:03:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 47/56] hw/i386/q35: Use DEVICE() cast macro with PCIDevice
 object
Date: Thu, 15 Feb 2024 18:57:41 +0100
Message-ID: <20240215175752.82828-48-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

QDev API provides the DEVICE() macro to access the
'qdev' parent field of the PCIDevice structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213081201.78951-2-philmd@linaro.org>
---
 hw/i386/pc_q35.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a785bf7366..a81c86b255 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -297,8 +297,8 @@ static void pc_q35_init(MachineState *machine)
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
-        idebus[0] = qdev_get_child_bus(&ahci->qdev, "ide.0");
-        idebus[1] = qdev_get_child_bus(&ahci->qdev, "ide.1");
+        idebus[0] = qdev_get_child_bus(DEVICE(ahci), "ide.0");
+        idebus[1] = qdev_get_child_bus(DEVICE(ahci), "ide.1");
         g_assert(MAX_SATA_PORTS == ahci_get_num_ports(ahci));
         ide_drive_get(hd, ahci_get_num_ports(ahci));
         ahci_ide_create_devs(ahci, hd);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F38C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsP-0008QT-DT; Tue, 20 Feb 2024 03:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsK-0008Jg-ES
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:16 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsI-00089t-Rv
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:16 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-564d780d55fso181533a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419193; x=1709023993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ibal5kJU8cDAhCTBUG3CNnHg6SzZrp5LopRtcroEZos=;
 b=WUQuaAfAUhGXQTJvMQvm45nquw3m7ofKqzS725wKuojj5BWOsdqfbuM54vPXpHQvPG
 8PSEpRlSNIjWc34eWINWBF5Mi8eht1qUUTR/9TJum3lxe5mpvKdUTXrtK4jAvEUS9S/f
 z8VOHKmOPLNl40RZG/KYVt1fcYwk8K02R5JaKKlXglcASwbXBXLc+Ma69WayYoiipqe4
 FyUBfMD/aXlR/pMpFJtPrNYnRIVbI8NUEvle2/EC2p8kiPT/25htipdXjmaStUHIabuX
 SJHuf/TGg00NIFjqt2O6QVZCriYgUzyyunwXoqOzU6M1uaK3tg3sjwT1EksoFnZOSMS3
 EQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419193; x=1709023993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ibal5kJU8cDAhCTBUG3CNnHg6SzZrp5LopRtcroEZos=;
 b=vF+vi+fS5drkTCNVfohq3DfTKhveumxFrLU5I+SwCgoFoaqQnGNt1q2Ggcms/zmRRu
 yBurAoVcbxVwx+zOUIQ8/4ie3oBTfBwolX8wbDIyXUqicq78FluAkfdtM3xRaf+X4mg2
 3lD8OVWDzZz2pOhOFPNdNq6escLzZVCq6xQnyYSoh2eAcyvOGu+B5YJcNH6RA6yYvgjP
 HK5k7d6TJGlJyNG/fWk0U/f6IKajABsQ+ugwijr2SGELNIkBaYDkuZq1gJTtVJwcOx2N
 MmOqfNCFX/bdZGfNKWMTt4xsCHH1t3h+a7kExntpGIRApzHu9rAyB8mpEl7ivoXjTps+
 RTrA==
X-Gm-Message-State: AOJu0Ywj8URuR/34x7iWI4uDfcLXMqLG/R0jZyabzk49AjV7wfkhe2Pj
 MSfaaJBsoU0BnLxpuJdrbqrjhm9h7Gz7nsoOcU9ddknSMeiXNFmP50Kt1w9aqj8=
X-Google-Smtp-Source: AGHT+IGKrIgTriG0BwstuH6SgcnuLPqF2z//8LNow0szcvdnnCuYsdwmL6TQpxOfiPbwLcyO5AUsrg==
X-Received: by 2002:a17:906:40cb:b0:a3e:405c:d5d1 with SMTP id
 a11-20020a17090640cb00b00a3e405cd5d1mr4474359ejk.50.1708419193047; 
 Tue, 20 Feb 2024 00:53:13 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:12 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 05/21] loongson3: correct typos
Date: Tue, 20 Feb 2024 10:52:12 +0200
Message-Id: <62438f7dd20e0c31450372e5b09ef0a5a5f9b561.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/mips/loongson3_bootp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/loongson3_bootp.h b/hw/mips/loongson3_bootp.h
index d525ab745a..1b0dd3b591 100644
--- a/hw/mips/loongson3_bootp.h
+++ b/hw/mips/loongson3_bootp.h
@@ -25,7 +25,7 @@
 struct efi_memory_map_loongson {
     uint16_t vers;               /* version of efi_memory_map */
     uint32_t nr_map;             /* number of memory_maps */
-    uint32_t mem_freq;           /* memory frequence */
+    uint32_t mem_freq;           /* memory frequency */
     struct mem_map {
         uint32_t node_id;        /* node_id which memory attached to */
         uint32_t mem_type;       /* system memory, pci memory, pci io, etc. */
@@ -156,7 +156,7 @@ struct board_devices {
 
 struct loongson_special_attribute {
     uint16_t vers;               /* version of this special */
-    char special_name[64];       /* special_atribute_name */
+    char special_name[64];       /* special_attribute_name */
     uint32_t loongson_special_type; /* type of special device */
     /* for each device's resource */
     struct resource_loongson resource[MAX_RESOURCE_NUMBER];
-- 
γαῖα πυρί μιχθήτω



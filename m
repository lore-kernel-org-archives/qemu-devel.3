Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFC7C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racbi-0005Yz-L5; Thu, 15 Feb 2024 09:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racbe-0005Ww-CH
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:20:54 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racbc-0000Dy-DW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:20:54 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d11d17dddeso10669191fa.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708006849; x=1708611649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLvepa7gcmUSWKB1EKhqFyqI1EusKlbmBcij87F8F7E=;
 b=QqtJ+lZqk2Xhcu9yC88OaoqUcczOLiQenAiXnVxt/IHQnCyDYqjmHIe2zE5zNfd7LZ
 HhXxT9Nr8Y1Tiu0/qf4E3IMQygZ1Y+w9GCztTx7P35RTfyU9OeXo6fojqdBOyOqhlBDb
 o8lge0OU776UY9eTF0PpAsYG2FHk9HN1WirnistnJo+fzhkXAHY1ntojgIGPY/wphrbP
 ZHehF2D21XRiOrUsFUCgXcoPbxH3hSzsPdCuJd6UebsFNGcvLV1dsv5uX0eaadUvd1kC
 KqcpzhKez1hDx2BlC3R5Ofs4D8IhtxvIM0KCSjCMjhpvbhdXltY/YDPk1RHVTI5Zi+zm
 3S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006849; x=1708611649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLvepa7gcmUSWKB1EKhqFyqI1EusKlbmBcij87F8F7E=;
 b=tNvcYvMnvR2VFb4upzV+ndSBL/C5a2WOB3UyiHA0huBftrBMscqvLtyh2/7UbDSIdG
 lRtxPLptdeSuBpdmmjKQrgfty+wDS94/ws/iLnVa3QXJu0geP2BhL7tj48ezKoctntTG
 H7U1nqIRYY8vRPEMs2NvTCObNJEWgPZ5/aZXp582bBc2NHIHTqKy4aBGZUiPn0BgRQWf
 rd11DL3NiNULwxApPSkvun319RglF6V294dolRlsoBU2r8EHHmG+058mqZqhk7AXX7WY
 qlM434oXNCy+egeReX3nL57BeNWl/v6KHBsDS/gALwlgi7/eKe2NhJiREZ3wWiit4DiD
 +Bdg==
X-Gm-Message-State: AOJu0YxpjIDdsv6qk3v+qn3HtkIrszkn9chkZi9BAp3dyuOYP9EH9Fgx
 7aYWFNyAEuEb54zAiqieaCoWJd8ydjWrkcPJy3HpTlu7E2Jd4aszlMdik3fcu+h4h/iMK9ITuWY
 3u5k=
X-Google-Smtp-Source: AGHT+IHYEUm7AulymZdpVTj48jkAUwAJORdqCYy7sFA89JTpfclzWJG6O7qdsxMhmWM6peItH9Yd8A==
X-Received: by 2002:a2e:a548:0:b0:2d0:c996:7c99 with SMTP id
 e8-20020a2ea548000000b002d0c9967c99mr1604340ljn.51.1708006849401; 
 Thu, 15 Feb 2024 06:20:49 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 m40-20020a05600c3b2800b00411c9c0ede4sm2228137wms.7.2024.02.15.06.20.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 06:20:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] hw/i386: Move SGX files within the kvm/ directory
Date: Thu, 15 Feb 2024 15:20:34 +0100
Message-ID: <20240215142035.73331-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215142035.73331-1-philmd@linaro.org>
References: <20240215142035.73331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Per hw/i386/Kconfig:

  config SGX
      bool
      depends on KVM

So move SGX related files under kvm/ for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/{ => kvm}/sgx-epc.c  | 0
 hw/i386/{ => kvm}/sgx-stub.c | 0
 hw/i386/{ => kvm}/sgx.c      | 0
 hw/i386/kvm/meson.build      | 3 +++
 hw/i386/meson.build          | 2 --
 5 files changed, 3 insertions(+), 2 deletions(-)
 rename hw/i386/{ => kvm}/sgx-epc.c (100%)
 rename hw/i386/{ => kvm}/sgx-stub.c (100%)
 rename hw/i386/{ => kvm}/sgx.c (100%)

diff --git a/hw/i386/sgx-epc.c b/hw/i386/kvm/sgx-epc.c
similarity index 100%
rename from hw/i386/sgx-epc.c
rename to hw/i386/kvm/sgx-epc.c
diff --git a/hw/i386/sgx-stub.c b/hw/i386/kvm/sgx-stub.c
similarity index 100%
rename from hw/i386/sgx-stub.c
rename to hw/i386/kvm/sgx-stub.c
diff --git a/hw/i386/sgx.c b/hw/i386/kvm/sgx.c
similarity index 100%
rename from hw/i386/sgx.c
rename to hw/i386/kvm/sgx.c
diff --git a/hw/i386/kvm/meson.build b/hw/i386/kvm/meson.build
index a4a2e23c06..c9c7adea77 100644
--- a/hw/i386/kvm/meson.build
+++ b/hw/i386/kvm/meson.build
@@ -13,6 +13,9 @@ i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files(
   'xenstore_impl.c',
   ))
 
+i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
+                                if_false: files('sgx-stub.c'))
+
 i386_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
 
 xen_stubs_ss = ss.source_set()
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index b9c1ca39cb..d7318b83e4 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -17,8 +17,6 @@ i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
 i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
 i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
 i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
-i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
-                                if_false: files('sgx-stub.c'))
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
-- 
2.41.0



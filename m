Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD2ECCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 22:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEEJp-0008Iz-I6; Wed, 29 Oct 2025 18:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEJk-0008HF-Dx
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:06:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEJW-00010I-92
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:06:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so187261f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761775591; x=1762380391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veqF+B9YD9xJXRSdAxin3zDSMOZgaGpl8wg92/hv1GE=;
 b=lv41CniIY5WaGFrj6wwrnlIUKqJvHRLPc6gWfom/Xz4YsnI81S988uaSU7VHhRef2z
 FLdKFqUpxPUINjtp4BQadwxuYYVrdZ1yR6au7p3jQdZENbDulQPtEhVMyi00KAkThnMZ
 lpmW4pkdPbKuiN+0QeU2a2m/twvL3OMFv+D8r1y/AYMqI+e1YEcUYCke0UZIC9gq+Scx
 hWVNgiNIL4wAj+yqsynIHgV8x9aUaLmI7KJ71kqCaCI+0bqR7bW+x6ldDHf+//uXC39T
 Sir1Zu83q+fPeizVi1ciH0FPlZR6Lw714xYC4OBXoOIdvQtHmMjy2P9M+xogPIi+MMlu
 JvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761775591; x=1762380391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veqF+B9YD9xJXRSdAxin3zDSMOZgaGpl8wg92/hv1GE=;
 b=XhcR56AFJ1OMpieV8Q0RfhDqd42RwlpzHYQXXRqj0ZCF97nhBox+qex8DLdD+vqEuz
 M6UKhtHv64VplIPO/sipbTaS3lzQ0daDBP3d5iu4qS6GLCymib8MboVbqTboVXw/E9Sj
 y5LjWqYZvEsRQSl/LbEf3Z1P0bXJVYTgBPSjECfFUrA9VZMLliDg8iMqJB1HvbnngEk4
 04OTSTVNgnifGNW5rjCpjEWmjhy7NU+oXHcN4Tej37jrkcuEiv0LAPSpzqW17EabGbek
 YehEj79SgmSrL1SZsCLhLj7TU0MdPvFnU/ZFwXze+S2ubf51Rf8jhrXcCPIbBkVfwGIX
 oICQ==
X-Gm-Message-State: AOJu0YyQunh2H2Rs/vtay9vBTAUemFw6Hmef7tL5RnHLHhySrbE+qESA
 JtclIKdxVM+2YAyseBkmWvvyVg4gbYcPv/aNvpQi81Iy/xSpaOvgLhzmyySPRQfFEjb8eR/vAto
 WVHCNOio=
X-Gm-Gg: ASbGncscZHTTOY+lQPbc7dJJZZ4EImaVBeI3imw4M0gY5le925hPcnPMbCzwXJ62A6W
 DLjsKACxD2OaEh4UXsDC5hwgB3JYw/YVPB+ni6W5p1VsJ+sPb2RGqMJJayYidg80yf/690V1pm8
 HIq5DPEtO9yBKMWB+LA6mPqkP+NfrXO21icfl3B+AVYYVFzdkBOKVosKO9NC58dzr25zDNrQH2b
 dZXqKif4cI1AdxZNJxO89WHF/S50Ec6Ann0vKQUNjm/EjTkQf92sShTdp5D50fffrcbj9ifZweC
 x6DtjwbTwS1g8SsaCkrrXl2G9jYblfTLkAvc8b8xw4vThRvTbkeMd/CGSdQgSDDSWFpAbXWhndr
 fG1Dy1eQkvtNCq19KGERYfOvtFGAeehQZpgFYVRxl7Z15GM+HkS6tANBIY7Cz6dgjwoB1FkWpOF
 2chRCUcDjcJ+0EtU8mzBQRmPuRGdVvANzj3dveJ5B2sdF1CucFAA==
X-Google-Smtp-Source: AGHT+IEbKRW6Xhx6tz3v9V2jt9OndZxxOflhU3MXiHFeVDPJ7uhr8kvz/sZkbLcmAJ2UTLN6uW3IIw==
X-Received: by 2002:a05:6000:2506:b0:427:55e:9aa2 with SMTP id
 ffacd0b85a97d-429aef78924mr2786336f8f.9.1761775591538; 
 Wed, 29 Oct 2025 15:06:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de5f9sm28468361f8f.38.2025.10.29.15.06.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 15:06:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 22/23] hw/xen: Build only once
Date: Wed, 29 Oct 2025 22:39:59 +0100
Message-ID: <20251029214001.99824-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Now than hw/xen/ files don't use any target-specific code,
we can build all file units once, removing the need for the
xen_specific_ss[] source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20251022140114.72372-4-philmd@linaro.org>
---
 hw/xen/meson.build | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/xen/meson.build b/hw/xen/meson.build
index a1850e76988..dcd2b7e1df3 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -7,21 +7,16 @@ system_ss.add(when: ['CONFIG_XEN_BUS'], if_true: files(
   'xen_pvdev.c',
 ))
 
-system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
-  'xen-operations.c',
-),
-if_false: files(
-  'xen_stubs.c',
-))
-
-xen_specific_ss = ss.source_set()
-xen_specific_ss.add(files(
-  'xen-mapcache.c',
+xen_common_ss = ss.source_set()
+xen_common_ss.add(files(
   'xen-hvm-common.c',
+  'xen-mapcache.c',
+  'xen-operations.c',
   'xen-pvh-common.c',
 ))
+
 if have_xen_pci_passthrough
-  xen_specific_ss.add(files(
+  xen_common_ss.add(files(
     'xen-host-pci-device.c',
     'xen_pt.c',
     'xen_pt_config_init.c',
@@ -30,7 +25,8 @@ if have_xen_pci_passthrough
     'xen_pt_msi.c',
   ))
 else
-  xen_specific_ss.add(files('xen_pt_stub.c'))
+  xen_common_ss.add(files('xen_pt_stub.c'))
 endif
 
-specific_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_specific_ss)
+system_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_common_ss)
+system_ss.add(when: ['CONFIG_XEN', xen], if_false: files('xen_stubs.c'))
-- 
2.51.0



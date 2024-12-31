Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DBFE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSilN-0002K4-FE; Tue, 31 Dec 2024 15:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilM-0002Jm-2b
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:22:48 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilK-0000p2-GD
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:22:47 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so5248089f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676565; x=1736281365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhTqWfXfzThhBSQGIlzSaIlp49wauFvDxBkt6/SSna8=;
 b=inxzuC9JXvEIxPiAWIyj6bh292mi6eIpA9hiiHzEKwT/DjjBbN4QFkrhKdpY2YG05+
 MwtOebQu3kFKDZi5XQgAKUb6ITJnhLOHg5R0vNKUrbfpGqnO5pyEZLWK/m3ksk73e8Ji
 rLoZkMS42DYoX+kdicU4LaHBuW/aCKYaal6jAp2rQM9SXjPRUTbYxl8BfXUs36wFPbiB
 lsOnVUt5dVqK0j9uA783xKUG81THubUHuf8aCXuMMxVBGihuecBRVy4bMpyEhI+yzmmQ
 3Nx1qeoJ3vwjb++DRAfrxoLGkMuMQ4Y9wvNAoKKKfwUn/QCO4CoTMvfCvWTt7uXZqeBo
 +nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676565; x=1736281365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhTqWfXfzThhBSQGIlzSaIlp49wauFvDxBkt6/SSna8=;
 b=KXsUezpehFNzoiXZ2VUbOgbf1RavGGKcHMtLCA0LifjO52JVyt4wRM5OxC8559aP+4
 BCpqhDtqR5lgyU+YpWQZT5uFldY2EuXU0a4V/iKyOxVJRs7epMYoPkb2s2ny8d+73Z7t
 2g4T+0UK0o62bBa6BR6ShefC3ZLM0wQxmnbkYScExglhmLtO5VOWXHxHV6mmu2clkVTy
 jEKlMZ03Rh90xMEs+3svjYNdXqjp4jr+w66sMjZOxBGQrj35WDiA+tveNGUugDqra83j
 eFN1jTkNGCauFMWaWq9vv+x4mdRf9Mp+/+YFUAHn5WWfQQ35EX3tJfpWRaxQ+Af9MEcD
 D3LA==
X-Gm-Message-State: AOJu0YxH4eGxH12I6XrbNhDAIzFubk1yDhbcLDknKZ/muw0vU1A893wJ
 6iijtUDIPavpyC3jnzQD3d19eDwiczZfOvp961rGLwZq/EwSR7WAZ8QYbgrXGjdTAxHXK70Fflc
 Tvds=
X-Gm-Gg: ASbGncvMZKB7ziNhL+vPR/cPETZrLi5fZ9o2qfjZwGdKKF0jtU1gYj90deKW74VnlOm
 F2SgwhUv+80JR6VhdYc0KuHsfjGWjAA84SABgPZS7yVB8Aioj6zuA6Xo8O9WeiPZYSKRBEUKmfv
 1neGX1PEyA+OEeO0/uam0g+NzNmmx5KoRHQ+kU4n21xF6Rpr1um4M7wbXlQDXOsZ3USXgT2YMoK
 naQHmFJ0oUFgfwLCVRdvVBB4WVmwQxqRJOR+ceGpGFu5jMuaDAkNIWMBd9MUgU+/WptZD/1jMWy
 k4p6X0CVDDKTMAKfRsOLhx6IAV5T7mg=
X-Google-Smtp-Source: AGHT+IESRtCpCt8VMOy6/FrVrMJYjRoHZT8dq+4avN2+gTrZNdPAwYP/BXOQGXvAJuNBD2D5/fJSCw==
X-Received: by 2002:a05:6000:704:b0:385:fc00:f5d4 with SMTP id
 ffacd0b85a97d-38a221f9f79mr34675441f8f.29.1735676564888; 
 Tue, 31 Dec 2024 12:22:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43665cd9c29sm379714905e9.14.2024.12.31.12.22.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:22:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/29] hw/misc/ivshmem: Rename ivshmem to ivshmem-pci
Date: Tue, 31 Dec 2024 21:22:02 +0100
Message-ID: <20241231202228.28819-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Because now there is also an MMIO ivshmem device (ivshmem-flat.c), and
ivshmem.c is a PCI specific implementation, rename it to ivshmem-pci.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20241216141818.111255-5-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/{ivshmem.c => ivshmem-pci.c} | 0
 hw/misc/meson.build                  | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem-pci.c
similarity index 100%
rename from hw/misc/ivshmem.c
rename to hw/misc/ivshmem-pci.c
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 7a16ddb1dcc..55f493521be 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -38,7 +38,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 subdir('macio')
 
 # ivshmem devices
-system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
+system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem-pci.c'))
 system_ss.add(when: 'CONFIG_IVSHMEM_FLAT_DEVICE', if_true: files('ivshmem-flat.c'))
 
 system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'))
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA49C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucoRy-0000Be-1f; Fri, 18 Jul 2025 13:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnt5-0007hU-Uv; Fri, 18 Jul 2025 12:24:43 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnt4-00077N-0g; Fri, 18 Jul 2025 12:24:43 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-55502821bd2so2861485e87.2; 
 Fri, 18 Jul 2025 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752855879; x=1753460679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRHDBLUxey+b9W0XCfwAkBDbX0DcQai5/OanTm9BFeY=;
 b=Uy7cGeBYAvG36Yjll6+ZE6NJDChRIIGKvuz6jcWPi80DrM+zj+KZLb2hGxUoOnIDQ0
 mPgQ77nXjRzw6j1ei3cVacqFXJlbU4Qog3LH4gkzN5DhnP+NEUTyZ+5EbpNY3fJ0ZvRu
 RFDF6M3WHs/FJhimNw82mhXtktFWzrAaUPMpTzRVpodlEsTiKPTORdQd3J7UuGR6yL2j
 Z9foMDvSZu9nwehjat9I9MFkkPd9uaBOOtoFhv1v9OaLLIx2sulMmRz3yJ6enwiloNHd
 5ZaLXoRQFMBNzqxoVtOStoWzIWdNHbdQb5JdE9MNM+dFp94Pg5RhkcvrX1/t4h9Y5i5r
 FwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752855879; x=1753460679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRHDBLUxey+b9W0XCfwAkBDbX0DcQai5/OanTm9BFeY=;
 b=TIkdyyo23A6MItPdhqNd6LnYpj9cZ49p/eh7oJwZtUGbbX/mW08P6Pf71hHQ/kewOF
 +fZkT2PQZAMChz9K7GPTpp2dW/jIyLTVYVB3b3EDJf4qxbY2ZTDkFQ3Z7555Gn3ttu+p
 Z8ONw9OGmq0GFePmKuGeOcGY/NXZohmrIpjFxYiLtoIatP8TgATn+w901nXhHmw0osfz
 SF6oYNLO5yNUwdQbyWI6vLuDyOQQz/WClrmPMr7xPGlAFZUHTTwAMuALKiyWwc6UP4/C
 biUXCXPVdLjbjbeS3VL+cWe+2O9rddzr4+DUZvJ+HqYrjgpa3LCpLt7vjvQNVHSYTmiC
 9/bg==
X-Gm-Message-State: AOJu0Yxuh/43hv1f7DMkAbdAcHSzZGOivYKg/UaL429LXlTvR+WltXqT
 5h4OI8kDlF3Lv2H7mwFErNlVsz3nFWCCCixfHUIQE2LY03XnvKzPtofz0pOsMmahjD7zjA==
X-Gm-Gg: ASbGncu7MWQ8LZ8S6n7lHov4qQYueJK96ho62rYhorBlw8bz+l9E+wfPsiIQTokPAbG
 SuPAT1j/PXdg43w0jZ8diU3NgBl5Zy0Zja7mNJQ4ymV6CUGFZXIRd+TRv+e4VnyNHMsJw75Sz5w
 UaVOL+CCljlFwR3JP5lQRpbB8F92IQDsZYSckSaIOzqFweNE94LPT35mPxaEFPk/WLmbHPsXSuE
 sbKbJTIoxRD+p4IMjjh73EXbOqAdrMXINUvR/Ly5Lg4bc2/my6bcJMJmKMZSYLGbBZYONn4nd+I
 SuGDnN/bYqlJXfQiOk7ez6IkwLj9Yi09w1IwE2+nGu5OYl38cQ3FmFTkoXw35bLHH7o6fzeG7Ca
 +oQxBcCmtHw56/Yp2ZEYT6l+pkgbe1LzyxTtzRPnqi9komIW44Yt49dBeoTMreMejnCj3Qx0lRI
 y1KnE=
X-Google-Smtp-Source: AGHT+IEMj3QUFecwPdX0c/Ir5JNMOLt0+AlPfxRlTQdo9Bb7Igjad8o7Eus2XpVBkkf+d409iwhJhg==
X-Received: by 2002:a05:6512:b17:b0:553:2bb2:789c with SMTP id
 2adb3069b0e04-55a23f3f09dmr2616009e87.37.1752855879284; 
 Fri, 18 Jul 2025 09:24:39 -0700 (PDT)
Received: from localhost.localdomain (m91-129-102-83.cust.tele2.ee.
 [91.129.102.83]) by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-55a31dacd84sm310615e87.206.2025.07.18.09.24.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Jul 2025 09:24:38 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Vadim Chichikalyuk <chichikalyuk@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/4] hw: arm: acpi: add UART clock frequency to SPCR table
Date: Fri, 18 Jul 2025 19:20:44 +0300
Message-Id: <20250718162045.49012-4-chichikalyuk@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718162045.49012-1-chichikalyuk@gmail.com>
References: <20250718162045.49012-1-chichikalyuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=chichikalyuk@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On the ARM virt machine, there is currently no way to programmatically
discover the frequency of the UART reference clock solely through the use of
UEFI/ACPI (without the DTB). The SPCR table can include this information
as of revision 3.

Bump the revision to 3 and add the clock frequency of 24 MHz to the table.

Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>
---
 hw/arm/virt-acpi-build.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b01fc4f8ef..029cbb37f7 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -559,12 +559,13 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         .pci_function = 0,
         .pci_flags = 0,
         .pci_segment = 0,
+        .uart_clk_freq = 24000000, /* 24MHz */
     };
     /*
-     * Passing NULL as the SPCR Table for Revision 2 doesn't support
+     * Passing NULL as the SPCR Table for Revision 3 doesn't support
      * NameSpaceString.
      */
-    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id,
+    build_spcr(table_data, linker, &serial, 3, vms->oem_id, vms->oem_table_id,
                NULL);
 }
 
-- 
2.39.5 (Apple Git-154)



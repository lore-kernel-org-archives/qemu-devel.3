Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65612C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYnX-00010T-83; Thu, 01 May 2025 14:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmg-0007ul-JU
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:30 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYme-00084Q-Nd
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:22 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d8dcc7cd17so8171615ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124639; x=1746729439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ubkHzu7s1cOcOgdA3It0e7Y2rG2MJsOlgRmMsxMDKU=;
 b=coafaSM/Jjfkyj60O9BgH+ZYCFQnvYB+iogKCi0XTjKhQwQvWRyx+8pRZv9JyhzoTv
 Qt4RwHcFmD1TOrwoszCd66d0mrHJ/ZatYe20D5KpfMiJWQm3jUlNZAvyWWEzL3q86Len
 Nebl7VML2R5P1K9zvMGvjFz87jKK0M6ud/EAkhmNCCDyLmGzXr9WaBacKSskZxEVfwY+
 bcf3jQsiPTONkOkVOZ1j2VyOp8JqQxKgbuspB+31lBP4SxXWIyNB6uHo97tE4VCNQCBB
 E8PtNV1DLW+MdIzGMnNZ6AVUcrpBwQMsNItlnSJI1rOym/KW7Kgs7Hbd4RaOc8Tg1NYr
 UiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124639; x=1746729439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ubkHzu7s1cOcOgdA3It0e7Y2rG2MJsOlgRmMsxMDKU=;
 b=ZGD/dF/ZqG3aTnZZROFGG+hF0isagSg153DKJFT8lHbMVPeNK68biDBm6RMrRRJaOO
 Jlm98Msa2oUwnA1i27gSBVM2HyZ/cthx+pXcTnzHCrUsG/zWlfvBBMKc3HORHdF8snS3
 XoqDqpXbyUw9CC4FlzZ/zkKgdfe2Yz4s41a2JhePxUFCRHvBjKyVIgGzHsXieCDzIuvy
 OMJFfzxdJcBpB/kMkSkXgiNGhDj7H0vhM6Q0ChEvsC8POAXHW4P++oZQo7v5BH3EczLy
 zoV39v/8Pcy3s/MXp/ru87sc3dYpanuHzis2VOoCryGR+ofYSVbssX/AXp57uhJIpNQZ
 g+fQ==
X-Gm-Message-State: AOJu0YwbCqTp+Jf11Ck8opCoIipvHX6KSdN9sc9wp9sjZBfxOSBJTg/7
 bu5/rxrA4Ad3vqdR9W8Frz1p8Wo4CGDvxdiu2BO1kjMA9zUUO1ZW1cR93a/cA4gXuVkhPuDyTyy
 i
X-Gm-Gg: ASbGncsfLFuKEcKdkHimgGqBR5NXcSfpFwWZV29Gw+rdwMsRqh//O2sVgEIg20mnnq9
 XI8tQllQR2HNHJ5liPqAiKtLCQbHp3a0QMpEg/lIfIZTdxVLgGP4tNpzBMbuC4qAGiDW9XsVhcA
 yHPgmnC6rsS8Vqxd3vnJqeI9UzLr9EUTgZmUyS0Ce44Q88YVkxCm3NbJ+4BCEi0Wxia+yj6a0Gu
 T/adaSQXS7W6O4LH+3WRVi5AAc8NcpMG7Lz1NoVB4kkpPxYMhx5XDm73bqc21y+QGT3JiPqp3/K
 eg6e0Xq0shfEtPM8BCxGB/8EqbZDSuzad+RSqi6sURVT0ftUjJr7nFC6Zj4y0Lx/2inDXcsRg9J
 v/TYSJETRz+bHkye8kBmZ
X-Google-Smtp-Source: AGHT+IFOdoGpWuVGxaVEN955KpIz0gMabjEI9ruErNvWhy5jo1kXM1i9wT7BmQpwurGCvC2Q0EuJfQ==
X-Received: by 2002:a05:6e02:5a5:b0:3d2:af0b:6e2a with SMTP id
 e9e14a558f8ab-3d970ad6a68mr36486965ab.5.1746124639251; 
 Thu, 01 May 2025 11:37:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882fc9ac6sm304331173.75.2025.05.01.11.37.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:37:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 05/16] hw/intc/apic: Remove
 APICCommonState::legacy_instance_id field
Date: Thu,  1 May 2025 20:36:17 +0200
Message-ID: <20250501183628.87479-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-il1-x131.google.com
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

The APICCommonState::legacy_instance_id boolean was only set
in the pc_compat_2_6[] array, via the 'legacy-instance-id=on'
property. We removed all machines using that array, lets remove
that property, simplifying apic_common_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/apic_internal.h | 1 -
 hw/intc/apic_common.c           | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 429278da618..db6a9101530 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -188,7 +188,6 @@ struct APICCommonState {
     uint32_t vapic_control;
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
-    bool legacy_instance_id;
     uint32_t extended_log_dest;
 };
 
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 37a7a7019d3..1d259b97e63 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -294,9 +294,6 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
         info->enable_tpr_reporting(s, true);
     }
 
-    if (s->legacy_instance_id) {
-        instance_id = VMSTATE_INSTANCE_ID_ANY;
-    }
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common,
                                    s, -1, 0, NULL);
 
@@ -412,8 +409,6 @@ static const Property apic_properties_common[] = {
     DEFINE_PROP_UINT8("version", APICCommonState, version, 0x14),
     DEFINE_PROP_BIT("vapic", APICCommonState, vapic_control, VAPIC_ENABLE_BIT,
                     true),
-    DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_instance_id,
-                     false),
 };
 
 static void apic_common_get_id(Object *obj, Visitor *v, const char *name,
-- 
2.47.1



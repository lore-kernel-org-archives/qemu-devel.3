Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A1BF54ACD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pn-0000ms-9V; Tue, 24 Mar 2026 11:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pl-0000lX-3y
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pj-0005E9-FS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so4843460f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365086; x=1774969886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5wiSFi8wnswcXFlOefRmA6X45uTbRfHYHACuotQz0g4=;
 b=ADXAkpmlpcaBKSMRSbXCPkAc9YaKfPv3Q5Eu3p8Vl2y+vzaLhX+KyAZUq9ayhxCYk4
 dpz5NtojupISooDSpYGPrCHkUEXhlsic0IVmBOJ9M/Wd4FfOnlZNWcCFWPmflURAZKUQ
 0UG7BQ2Jms/qblpKY9Ty28Ybz39la+3paF1SI6UN8u81FBOk0REFjVLjDZd/yrvwDnGy
 duOQM8aKwsCzGQUmIXKinIqgdFLWxPpNH1J/K7D70jg+6j+NahDcfUoUznqOe/ftR10n
 3G2EfnPbB1s7O4LgYEi2IbQcx0dFgqahQetTv5zKvsu6DWHmU3ZQvamXTgY4gDxV08HI
 IfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365086; x=1774969886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5wiSFi8wnswcXFlOefRmA6X45uTbRfHYHACuotQz0g4=;
 b=VYwrr4IAnDg9ghZ4QIKaqUb6YuN/p4OTSUKT8RmR1GWoJWI4I2w3J4EIJCHFj+nvao
 LzMDZFranH4wvt196fVU2kn99PPPm1+ueD3I3ZIE2Zg6yVbOV74x1tPXZRCqwboAnAYB
 bDTyIoBpn8V1CVwJ1MZ2DmPHqBrfu/qCKSNo20uAIWONqiogF8XmltA1PoLcDwjN5e7K
 KXquUhM/qzIAnqf+f7vkyQYgIsA9qDYv8I15nk38wmvJt9kxKYp6eCnX1A/E3253Mckp
 pKLx/zLui4MRWudAk76B42BynxP4jgfZ7AZSE8HbfM1BBB26ZFyjU3peatUf04ZK2BBg
 zbwQ==
X-Gm-Message-State: AOJu0Yz0TYJfWnj16WZkR6fU+/3FjIAmZb/Up10174vyM49e38DjQ9x3
 RycQ7zEWtt77x5ppTAdt9W4EVREOzXjN9db5z/B8rh48kKn2wRNzWwGrMFIvGhlpC3+KB1jOayM
 4CrEJD/Y=
X-Gm-Gg: ATEYQzw9ieWoBk6vjGnVjYCDAERhnVldVOEjldhakATqXY5RbHSBfgSQRyPHGoIKwM+
 I5zaDz/iEfNkx06egwXNZOqJWempQoYGBzPksrd7A5VIvIasWE3cIV578yZAqU/On8987Eb1gIq
 Nawnj8iAS1PcWbKvCFnXR+gA0WKjIQ1/okX7FNPaE9A4UGTZi4FHiLGH6lM5Z/D28TikFr0wK7v
 DJ5HXMGhl64OLx7uADH2FzIMaCd69SIPCXDqXWNJTPkrLB8CVtB9gOhsElbV4Bm34igLrrQMx9k
 8E4vB0c8doN0Vcti2tYxpJkbCsLGFkcve5HLwkSRKxv3oQinO+vtd5jJ52ksLcDZ+TK4FFtLjGj
 cTpcXa4HbjJoA3PfHUyVREn2TBFYNJqUbbcDdUXEIo4jWnMj0pT2K5gGKHuz7kyjTfeEQ93rhtk
 vinLTg0UJPrzqDRAxvVOFy4KrYe2fbl8FZk2pQZsU0XazEFuR7RWkxOhizjmlpLBYAA3mTec+Xj
 kO/jrbcwsqM/d8iv0jmIsrsi5SOf+w=
X-Received: by 2002:a5d:5d13:0:b0:43b:4920:56bb with SMTP id
 ffacd0b85a97d-43b6427b750mr24419103f8f.52.1774365085799; 
 Tue, 24 Mar 2026 08:11:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] qdev: Add an OasMode property type
Date: Tue, 24 Mar 2026 15:11:09 +0000
Message-ID: <20260324151111.237411-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Introduce a new enum type property allowing to set an Output Address
Size. Values are auto, 32, 36, 40, 42, 44, 48, 52, and 56, where a
value of N specifies an N-bit OAS.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Message-id: 20260323182454.1416110-7-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/qdev-properties-system.c         | 13 +++++++++++
 include/hw/core/qdev-properties-system.h |  3 +++
 qapi/misc-arm.json                       | 28 ++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 4aca1d4326..a805ee2e1f 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -737,6 +737,19 @@ const PropertyInfo qdev_prop_ssidsize_mode = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- OasMode --- */
+
+QEMU_BUILD_BUG_ON(sizeof(OasMode) != sizeof(int));
+
+const PropertyInfo qdev_prop_oas_mode = {
+    .type = "OasMode",
+    .description = "oas mode: auto, 32, 36, 40, 42, 44, 48, 52, 56",
+    .enum_table = &OasMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
index 4708885164..2cbea16d61 100644
--- a/include/hw/core/qdev-properties-system.h
+++ b/include/hw/core/qdev-properties-system.h
@@ -15,6 +15,7 @@ extern const PropertyInfo qdev_prop_mig_mode;
 extern const PropertyInfo qdev_prop_granule_mode;
 extern const PropertyInfo qdev_prop_zero_page_detection;
 extern const PropertyInfo qdev_prop_ssidsize_mode;
+extern const PropertyInfo qdev_prop_oas_mode;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -64,6 +65,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
                        ZeroPageDetection)
 #define DEFINE_PROP_SSIDSIZE_MODE(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_ssidsize_mode, SsidSizeMode)
+#define DEFINE_PROP_OAS_MODE(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_oas_mode, OasMode)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index 416b4240e2..4dc66d00e5 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -61,3 +61,31 @@
   'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
             '10', '11', '12', '13', '14', '15', '16', '17', '18',
             '19', '20' ] } # order matters, see ssidsize_mode_to_value()
+
+##
+# @OasMode:
+#
+# SMMUv3 Output Address Size configuration mode.
+#
+# @auto: derive from host IOMMU capabilities
+#
+# @32: 32-bit output address size
+#
+# @36: 36-bit output address size
+#
+# @40: 40-bit output address size
+#
+# @42: 42-bit output address size
+#
+# @44: 44-bit output address size
+#
+# @48: 48-bit output address size
+#
+# @52: 52-bit output address size
+#
+# @56: 56-bit output address size
+#
+# Since: 11.0
+##
+{ 'enum': 'OasMode',
+  'data': [ 'auto', '32', '36', '40', '42', '44', '48', '52', '56' ] }
-- 
2.43.0



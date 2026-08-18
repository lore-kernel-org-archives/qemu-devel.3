Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECBBC5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUc-0002S3-U6; Tue, 18 Aug 2026 13:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUV-0002P0-Oz
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUQ-0001la-9C
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGsH+Bg4Lvr9fbuuBhJQKt2tKRQkcfPXQNlap3cmCls=;
 b=TDPNfeYTrBCCxscSiK2NmpClZYMkZbeeX9gwzVcUpeeWfLyOpCD1YWNMfczHOELeax3PcO
 HntTXYOs5bdoD/lguEvgH6u3sfIv0v3pJK9tFfT0hAZ6wZSu8BIrMY2EWpAHRgUEvD8HCo
 YiXllb7YKWfjCsle9UyJnkZlmwLIXLM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-mTp6HMv-MZ2wQUbKNzFkXQ-1; Tue, 18 Aug 2026 13:20:38 -0400
X-MC-Unique: mTp6HMv-MZ2wQUbKNzFkXQ-1
X-Mimecast-MFC-AGG-ID: mTp6HMv-MZ2wQUbKNzFkXQ_1787073637
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d7b3adda4so329441cf.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073637; x=1787678437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qGsH+Bg4Lvr9fbuuBhJQKt2tKRQkcfPXQNlap3cmCls=;
 b=LYPH6b2GnhhFP2M+HPXID3dLGdCOZ6C0oS4lTLy73VY3EohMC1aHwhJYV7lk2aqXxX
 rNa6mHUKNoqg03mIsZQZi6Rq/tbzbOG0xp8PQfKVaBjbRMPZmPVyZ3SVGAKlHsO69sA+
 Pyt4BpgflbMEDZaGGDPupvaCotvz1PI2KzJQKZzVeoPvV/yUXFMQ281ZS0C/0FT2zNd6
 8+izn6GZ92VFgmPATpyhR+MbRGxVZcS/y8IloKcbdRZHpXAyCXdVcwsfgInzf9W5jz+i
 EUpprEMZRwCRFJGzdsK4OtGrD2z1pU/7zNDZZurBY6BGkMZi972J/MrKaGtz7bQb9xG3
 l5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073637; x=1787678437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qGsH+Bg4Lvr9fbuuBhJQKt2tKRQkcfPXQNlap3cmCls=;
 b=ICGgbxWH6k3y4foTe2DEk0z1pO+eADlhu74Vz0NPIfUVIetsIJ7NVKG1joZXnY9nuj
 HXsXqu49hClzbtM9H/ZbWT/1IVkUf4k86gjKdlmnORNhcta+QCJvCv6f2tE/uUzq0lyR
 1P09CQCQ+ICAlqy3LWtVACnzXRbaNj8DfN/A4U2KcPRUBa6LyXYncLJX5WgvZohDP+RV
 LHxoXWIKTqYVClNXp2MwmI2R0ArcRrhLgL1i4wwY0DbRPkhSQXzgvFBfefT4/frwWzdp
 6xIxkMAfJ39lcwQKfO9uHuDZSFqmBAkvwmgO49NWldmxUjIen8C1y+LGxSgWCukORtN/
 V+wg==
X-Gm-Message-State: AOJu0YxcLyKAEYVh1GUgYyG01ktAqjGIE6kWPUKQMBI9gGlLN1HioN3o
 MhSvrHmOKEDedaJSQYJ/F01g2i2L6pLQD2VuTK/JmhKQ2EkH3k+4pLntUhEv3BsDKttsA3En5yr
 WHD42njl489PVX43q+Ni6+5kM9wXAAiSyO5wAq7Qmo4Oxi8qh9wI0wA5plD9CTYscxUC9+Ghbof
 NkDU81M5dWEMGqlIbhNiTQ/GjxEUZLfabSjGvpXg==
X-Gm-Gg: AR+sD10spWw3islJDy3IxTN79PQ0/JdqQaHMf0gNWrBn4SkgUxaFe+iY2V5tQPsYw6R
 vGU171py4X797uUt9YCjlJC3VtaiS5eT1iby9bPuL6nkx7FylvtZrq/fWIMWcIAExs9gL2x97nZ
 h1IKBvs1IFxqThQua9UvnC/unrG0yX2iZVoHYWYeDtbfVRIB1pDdfXNSSPi1Ho3L4+90YfIuaPa
 VMPZ+/DLrAEQKYMFpzWbzOv645tQO+rEJ+T+u9k2M7fNGGh6kUXgsl2+C6XsiYagmGp4iq0SWcE
 Lr8noLFs9MMJ3wdGsvboMm7Q9Scml1v3Sla1K2BnV9ZJUmPyf7178o//5CW5cule7G6E3y8gB5I
 eDxZ9sQgkEGE33I5P1h/AYcW8PrPew6tUKKd4nmzCmndFGi+M/BMYYGnX
X-Received: by 2002:a05:6214:4518:b0:8be:1620:a95a with SMTP id
 6a1803df08f44-90c4b3f113fmr110509066d6.27.1787073637419; 
 Tue, 18 Aug 2026 10:20:37 -0700 (PDT)
X-Received: by 2002:a05:6214:4518:b0:8be:1620:a95a with SMTP id
 6a1803df08f44-90c4b3f113fmr110507906d6.27.1787073636797; 
 Tue, 18 Aug 2026 10:20:36 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 7/9] arm/aspeed: Drop ASPEED_RAM_SIZE
Date: Tue, 18 Aug 2026 13:20:10 -0400
Message-ID: <20260818172012.3052821-8-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818172012.3052821-1-peterx@redhat.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

QEMU has switched to 64bit-only hosts for all system/user emulations.  It's
not needed anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/arm/aspeed.h           | 7 -------
 hw/arm/aspeed_ast2600_anacapa.c   | 2 +-
 hw/arm/aspeed_ast2600_bletchley.c | 2 +-
 hw/arm/aspeed_ast2600_catalina.c  | 2 +-
 hw/arm/aspeed_ast2600_fby35.c     | 2 +-
 hw/arm/aspeed_ast2600_fuji.c      | 2 +-
 hw/arm/aspeed_ast2600_gb200nvl.c  | 2 +-
 7 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index a00238ed74..7a012d87de 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -25,13 +25,6 @@ DECLARE_OBJ_CHECKERS(AspeedMachineState, AspeedMachineClass,
 #define ASPEED_MAC2_ON   (1 << 2)
 #define ASPEED_MAC3_ON   (1 << 3)
 
-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
-#if HOST_LONG_BITS == 32
-#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
-#else
-#define ASPEED_RAM_SIZE(sz) (sz)
-#endif
-
 struct AspeedMachineState {
     MachineState parent_obj;
 
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index 65d6b0faa2..45f7a25efd 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -18,7 +18,7 @@
 
 #define ANACAPA_BMC_HW_STRAP1 0x00002002
 #define ANACAPA_BMC_HW_STRAP2 0x00000000
-#define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+#define ANACAPA_BMC_RAM_SIZE (2 * GiB)
 
 /*
  * "Anacapa HPM (MB)" FRU data. Generated with frugen.
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index b7e84db143..8f9061c472 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -18,7 +18,7 @@
 /* Bletchley hardware value */
 #define BLETCHLEY_BMC_HW_STRAP1 0x00002000
 #define BLETCHLEY_BMC_HW_STRAP2 0x00000801
-#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+#define BLETCHLEY_BMC_RAM_SIZE (2 * GiB)
 
 static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
 {
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index f714c9d1b3..c328997668 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -20,7 +20,7 @@
 /* Catalina hardware value */
 #define CATALINA_BMC_HW_STRAP1 0x00002002
 #define CATALINA_BMC_HW_STRAP2 0x00000800
-#define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+#define CATALINA_BMC_RAM_SIZE (2 * GiB)
 
 #define TYPE_TMP75 TYPE_TMP105
 #define TYPE_TMP421 "tmp421"
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index f624427070..1d546b1f0a 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -17,7 +17,7 @@
 
 #define TYPE_LM75 TYPE_TMP105
 #define TYPE_TMP421 "tmp421"
-#define FBY35_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+#define FBY35_BMC_RAM_SIZE (2 * GiB)
 
 static const uint8_t fby35_nic_fruid[] = {
     0x01, 0x00, 0x00, 0x01, 0x0f, 0x20, 0x00, 0xcf, 0x01, 0x0e, 0x19, 0xd7,
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 37db252e27..cb987e2eff 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -22,7 +22,7 @@
 /* Fuji hardware value */
 #define FUJI_BMC_HW_STRAP1    0x00000000
 #define FUJI_BMC_HW_STRAP2    0x00000000
-#define FUJI_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
+#define FUJI_BMC_RAM_SIZE (2 * GiB)
 
 static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
                                  I2CBus **channels)
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index ad9a10110b..7abd934624 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -16,7 +16,7 @@
 /* GB200NVL hardware value */
 #define GB200NVL_BMC_HW_STRAP1 0x000000C0
 #define GB200NVL_BMC_HW_STRAP2 0x00000003
-#define GB200NVL_BMC_RAM_SIZE ASPEED_RAM_SIZE(1 * GiB)
+#define GB200NVL_BMC_RAM_SIZE (1 * GiB)
 
 static const uint8_t gb200nvl_bmc_fruid[] = {
     0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x1f,
-- 
2.54.0



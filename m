Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA9AC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7qT-0007Yn-A1; Wed, 15 Jan 2025 13:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7q6-0007DG-Sf
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7q4-0006iC-Oz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnd/UP08PD5Bozot/sSil++sem222YsXqqQSl4D4JTs=;
 b=SI5EL6QwQ7HMe8Ia7DLF6C8HUvEH7/t0z1F1j0KS2A/GtvN7dwSsGvHeKMRCk6HxF1FbNJ
 J1F976qd4o3ZtwpLfQ3zdxE5GhCIfCQX9gkVyLg4kwHuJXheX8ARp4cIQNEsvKdwT+9uq6
 pZjlHwJA8nH3I1g8poXttx5iW6ziA+U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-DVrzZK-4NDeElzzlS8q9sQ-1; Wed, 15 Jan 2025 13:09:58 -0500
X-MC-Unique: DVrzZK-4NDeElzzlS8q9sQ-1
X-Mimecast-MFC-AGG-ID: DVrzZK-4NDeElzzlS8q9sQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385fdff9db5so48181f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964597; x=1737569397;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnd/UP08PD5Bozot/sSil++sem222YsXqqQSl4D4JTs=;
 b=lYbm0Pk54zSSVST2hmWjwLYtsKnBFzXrF9N0CuxBdoaM+B2c3PxmY1+siTP2PZ2tWP
 3m0xxBtjJfG9DwhGycAppitkBS4R28//cFyH7Uu946XZYofsIi4qc8ZbERzEn8PdI39V
 bl5ihb0auamEns7eT0p1nIQOoXajHkc+uM+S06IpCm77ZAdBakqFtPBDH+27UEhG/T/z
 Y4gut89UinJ0Zi5Y+awf4wkhUHgWMeEYJKMaTWso2eqimVvJ5ITcViXYhjzRgAhj+LVp
 EPkRIqfQm5i0KiIZapk/epCv2uyo2A8eFdNyKxmwj/L35EqDzbCdYFgzbsDGDt8Ul6+L
 TSsw==
X-Gm-Message-State: AOJu0YzHG6r0govR/+JecWScTY0GMp7ZZB+HYAnCrcJH+Xob5fMSpDhS
 T9E2YXJWjOD1Vr1uH3iMF7KpL+SHTtRrGrJR3oCMpLu9C4OF+YhNkoCYIDCKQ0ycTOmNRElVN6P
 0Seb+0f/u1Wc+vBzS8Fr7Y6YK4Mm+HPVRH/1uoEfxRWnl4rIEQibGB2f8tMqNV2aUgNUTJfd/q5
 eTGYGV96jwWLpGwkkMTwdwNiMSlQl7pA==
X-Gm-Gg: ASbGncsvVhREdc+ueJLhQtufJTqADkzbUJO1yNjM86au08HFQQKN6hOCzfUjPx3YEk+
 jmGx8bbAp5nGWXj1FYCJ75w9QHlOTZVuuau9jm5AMHERXlNRMjQ1oTZBs0sR3c5a3j6WOaZ67cN
 kHJCI+bJ9AH3NV+SBeby+I1kb3DgYpHWs2xZPpurZkfPxj3OfXzv02Cw/+Rh9j6MCiUZ4XG9GDG
 UUszDd3zVZ80msCpPp6VWNSnx+e9enc0bMEAYkasQfcokBe2yJ/
X-Received: by 2002:a5d:598b:0:b0:385:ee40:2d75 with SMTP id
 ffacd0b85a97d-38a872da8b6mr23074652f8f.20.1736964596997; 
 Wed, 15 Jan 2025 10:09:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2Gmzsa6zc26hLIJ/h9xOEqxzz09Bhm9ECAtsf3HEErkO2FzQ6tWk79lW55oX1ZTQEVld4xg==
X-Received: by 2002:a5d:598b:0:b0:385:ee40:2d75 with SMTP id
 ffacd0b85a97d-38a872da8b6mr23074631f8f.20.1736964596557; 
 Wed, 15 Jan 2025 10:09:56 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c006sm18112587f8f.46.2025.01.15.10.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:55 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 27/48] acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
Message-ID: <239c3f7ed44d8b82a682a1c2e9e8c3355c10d321.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This is just duplicating ACPI_GHES_ERROR_SOURCE_COUNT, which
has a better name. So, drop the duplication.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <9012bf4c9630adf15a22af3c88fda8270916887b.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/ghes.h | 3 ++-
 hw/acpi/ghes.c         | 7 ++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 674f6958e9..59e3b8fb24 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -59,7 +59,8 @@ enum AcpiGhesNotifyType {
 enum {
     ACPI_HEST_SRC_ID_SEA = 0,
     /* future ids go here */
-    ACPI_HEST_SRC_ID_RESERVED,
+
+    ACPI_GHES_ERROR_SOURCE_COUNT
 };
 
 typedef struct AcpiGhesState {
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e9511d9b8f..dc217694de 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -34,9 +34,6 @@
 /* The max size in bytes for one error block */
 #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
 
-/* Now only support ARMv8 SEA notification type error source */
-#define ACPI_GHES_ERROR_SOURCE_COUNT        1
-
 /* Generic Hardware Error Source version 2 */
 #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
 
@@ -396,7 +393,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
-    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
+    assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
 
     acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                        NULL));
@@ -407,7 +404,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
 
     if (physical_address) {
 
-        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
+        if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
             start_addr += source_id * sizeof(uint64_t);
         }
 
-- 
MST



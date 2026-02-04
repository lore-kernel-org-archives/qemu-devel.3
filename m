Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E3FEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAb-0000Tc-5X; Wed, 04 Feb 2026 14:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAW-0008Ic-80
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAU-000802-F9
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k970/8IAuTxyxYQnCxpGZam99VQS84f+0lcT7yhaPYA=;
 b=fnEdQ35h+nX88SIllTZRhDNO+IvB0uT5cGhouedfSAGvLqVudxRA2oiqglIhM3PXn246mt
 4F5K70hr7IBTCzsDplzXqR/d/I3NJpTjs+4TcJX7TiDMaX+3cdF+70W37NieRVqbLirOgu
 ePYFXaIyz70/mie5l7i2gkie9J3AaJ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-qZEpGzN_PsegcaZ78mMfPA-1; Wed, 04 Feb 2026 14:04:00 -0500
X-MC-Unique: qZEpGzN_PsegcaZ78mMfPA-1
X-Mimecast-MFC-AGG-ID: qZEpGzN_PsegcaZ78mMfPA_1770231838
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48057c39931so1466295e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231838; x=1770836638; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k970/8IAuTxyxYQnCxpGZam99VQS84f+0lcT7yhaPYA=;
 b=Yzje8gxb9/IhHPQUGHIQXwDC2qLJVPEdHCcyhZdW+l7nXUqS0JydL4xD6tvebBFWfl
 O0DBLKaD86cAIJx94eZkkw8QsE1J/PHG79u7aJWh1wTmaKwcNj11hBkgQsYgImyg68l0
 OW6Eya/VSw2K9tppVvxJNirgCqPdCOwK1yeItY+5hVS4bea8OpmOU3HW2/jUUR9tkcRD
 Zpk1gYeNpXiF+3eJMC9sHfHi4tq8c8uEthNM3Yn812kD4F4cwlAnCCoqhW6ZT3ffTrS7
 1gtutqU+J/2ZWaMWUndhk+EOJPkqzPinqxp1onIGMJkMWZUsPcaEbmvqZVs/Ok7qNbE/
 FglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231838; x=1770836638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k970/8IAuTxyxYQnCxpGZam99VQS84f+0lcT7yhaPYA=;
 b=Qw9X+nYB6UzrZPCZN0oXYyVdnj50pqoqIf81NKT/jPmm/CQDukEazv7jHmpcGGVH4f
 nhZuMbWlc/ijyLtAx8WCKw5CqzpknHyi+qxQNU8eDgaAP2rOWEXd4jKKwhcgEggW8DhO
 9aXe6TkvRZvqo47DD2sukGDS7Oa2AsVUHYe1pE+0jYe7CIBaZJ+q5vBW3uryj7SQWCFN
 bHKhE3wCaH8qFvI5mBXxupMzBOMdBKMBC3wvMhYkQJV3GCKiLuzI1oIPRYIxM7h/p5wi
 ZcfZm+z3cj2A5bPBm+CA3SDxvWk3L57zd+dIvgMns5NutNeZjG7d7c06BivTS36ClnSb
 Y3Gg==
X-Gm-Message-State: AOJu0YyGH20VTDuXjcQUuB7NeFX889uE5zsxreZXRpDJBehDGqKvlCy7
 HZJXgIjoFHevyFmDH7I7FwAcAfNlzTb7asCktTN7FKfyN15Istd5tBYkUgOf6BOTx2ZCNtWhFzF
 ogjowo0iz9ndLoOFmWz/0agF/TkonAbaVyV2bH7qYlt5A48lYTYs/Gp5LqYXGi/y5mBXwj0dp98
 xb8i7rATJyH3Jw+eYmt1xT5I6LVQM0TxoZnw==
X-Gm-Gg: AZuq6aI78XIZA9EQM9cbt1I4OUyin3uaOLLixA8GO4o0cbHJ1UjPUvSELGr0AKvnS6s
 GA4nYEmqJJyvT+Qw9zbFxKjGgKbZh3DuSPgy+muV7Qk5kN0ohV3OomiE7JgW6SSKo0pj5QKeiOG
 l+4JDsgjLu2oLk8jEclftW1Vi6utLcv54J2E5zFqL49gJdEpQ2WuHjp2HSRVdMFOcRaJLU0DsOu
 l4gSBrldZxj1d6EEZbOknYkn+001Fu01SJQOPhBxHnpkaxB/VqFBP5w2u/WXAOtpwmPkdl4Lhdm
 cdXbl7llFhqyI81vdv4jo9ybJkxH4G2M+l3+6H3UKSCBqbbghX9rK+pSDdJ8Ej6EClL8rfgqBCc
 fnGwqzE0joRZac9W6Rle9VCTQgOS1eK3SuA==
X-Received: by 2002:a05:600c:1f16:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-4830e9897dcmr64074105e9.31.1770231837794; 
 Wed, 04 Feb 2026 11:03:57 -0800 (PST)
X-Received: by 2002:a05:600c:1f16:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-4830e9897dcmr64073585e9.31.1770231837220; 
 Wed, 04 Feb 2026 11:03:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f9esm7058054f8f.28.2026.02.04.11.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:56 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 29/51] acpi/ghes: Bail early on error from
 get_ghes_source_offsets()
Message-ID: <43eca99483f62e6d8610dbeee1e00ab94edb8962.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

In ghes_record_cper_errors(), get_ghes_source_offsets() can return
a error initialized by error_setg(). Without bailing on this error,
it can call into the second error_setg() due to the unexpected value
returned from the read acknowledgement register. The second error_setg()
can trigger assert(*errp == NULL) in its callee error_setv(), which
isn't expected.

Bail early in ghes_record_cper_errors() when error is received from
get_ghes_source_offsets() to avoid the unexpected behavior.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251201141803.2386129-5-gshan@redhat.com>
---
 hw/acpi/ghes.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 4e6903a8d3..d51d4bd466 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -444,7 +444,7 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
     *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
 }
 
-static void get_ghes_source_offsets(uint16_t source_id,
+static bool get_ghes_source_offsets(uint16_t source_id,
                                     uint64_t hest_addr,
                                     uint64_t *cper_addr,
                                     uint64_t *read_ack_start_addr,
@@ -475,7 +475,7 @@ static void get_ghes_source_offsets(uint16_t source_id,
         /* For now, we only know the size of GHESv2 table */
         if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
             error_setg(errp, "HEST: type %d not supported.", type);
-            return;
+            return false;
         }
 
         /* Compare CPER source ID at the GHESv2 structure */
@@ -489,7 +489,7 @@ static void get_ghes_source_offsets(uint16_t source_id,
     }
     if (i == num_sources) {
         error_setg(errp, "HEST: Source %d not found.", source_id);
-        return;
+        return false;
     }
 
     /* Navigate through table address pointers */
@@ -509,6 +509,8 @@ static void get_ghes_source_offsets(uint16_t source_id,
     cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
                              sizeof(*read_ack_start_addr));
     *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
+
+    return true;
 }
 
 NotifierList acpi_generic_error_notifiers =
@@ -527,9 +529,10 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     if (!ags->use_hest_addr) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
                              &cper_addr, &read_ack_register_addr);
-    } else {
-        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
-                                &cper_addr, &read_ack_register_addr, errp);
+    } else if (!get_ghes_source_offsets(source_id,
+                    le64_to_cpu(ags->hest_addr_le),
+                    &cper_addr, &read_ack_register_addr, errp)) {
+            return;
     }
 
     cpu_physical_memory_read(read_ack_register_addr,
-- 
MST



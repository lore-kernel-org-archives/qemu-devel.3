Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2122C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rH-0001mk-C6; Wed, 15 Jan 2025 13:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qP-0007cq-0y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qI-0006xI-3O
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8oi9KOXhifPD6YPugI1W0xaqab0w+uWNDdH+YVyo2Gs=;
 b=gVjaAdHgHmn2q8O/scAaitQnfkGp/CAv+fWWCeeahrJCjoeU+AUuVm9kTKyQDqws0ibkQs
 IZMT+i/3cklLMDed6exA902HVoqr7uqJTer+2MzetIjD/JvqFALZgnGbTxxVnl9NSBP3cs
 kFFWxMW1vKId+f+FQvj+CmB0uomNR2I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-pLIBgZOSNyytmsS-sjI28g-1; Wed, 15 Jan 2025 13:10:11 -0500
X-MC-Unique: pLIBgZOSNyytmsS-sjI28g-1
X-Mimecast-MFC-AGG-ID: pLIBgZOSNyytmsS-sjI28g
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d52591d6so39266f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964609; x=1737569409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oi9KOXhifPD6YPugI1W0xaqab0w+uWNDdH+YVyo2Gs=;
 b=lX/qsSkbN8h9fizyQVJH2bE/SR1rlR1kv9MvNWsV5tNWkSIugdk9E1M7YsyLJs3F93
 274NA9yK7HSJtloV4eVwckBrhJyLLcA0qMpkvj9Jphkd4ylA1PUmzYwZCH2HQqNVVdiL
 NpVWYBQa8vOKUu84P03hZAMR5Udlfsd5oCLpLawU/dfcsEqCZMJYsnUseakToqq/Omgw
 D8wGiByn/b5zV7MylOkDKsniHbUkqYpOR2npN3qd6OgUBxVWt5lIblCArzXKyaQm5PEn
 +e3uv8F+WdpW6IdKLxzjZvQwH0+z6asNVc0H4kR6q0HKMIpmkDKk72MBFDbBGckOoEOW
 eIjw==
X-Gm-Message-State: AOJu0Yxx+XK+6W7OPmCBEjkGgqu3LwPRGRJd9+8rPTCtt7plMUQNIN/B
 EJLuPq1IF/8C6UW7iaROQbRZ/VAFWNuuWZhDGd2nZkKK67+5r7UNreJ+X4ZHUHqeo4WedXtzoFl
 SpfmeBE8YAv9cuzswdn5OX6s8ArvgHyZmr4AoQm4N3v82ge4lzKv77TnezASrKPLTRvfboe5h0o
 7+dr9vhaWfaocBCyKbbwaUvg38uKMh2g==
X-Gm-Gg: ASbGnctMIZ+zZ5jVqYs5k7ZPqug2w3z3AC/CDPnpJziHOjFllQwa0Bv4EFgo0VaZM2S
 AzQ4sCXFdlbdBg7qcCtgtSnHD2vL6lbq5cpGKaFK/fOgaXzRG14cYVUe0ZLuDayLw/LN/4jO6MP
 wHI+IZQIwiARSgun3qF1vR7wNlDLcIh7ISigd3TVGJgcymi+nOxn3kRSXXp462bzJRZsFTG4bUv
 pkYf/ldfUcomwJ2ySP7w+7G6jAJewwG+lJwcZ52M2Uyk3bajQoD
X-Received: by 2002:adf:b64f:0:b0:38a:a117:3db0 with SMTP id
 ffacd0b85a97d-38aa11740b8mr10363952f8f.3.1736964609413; 
 Wed, 15 Jan 2025 10:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtqidKngIe8ln12aOwRXhBjLzkqIkk0b2gJgADIc4ycOVYg4NPYZvuzVVWNne93XB3swaplg==
X-Received: by 2002:adf:b64f:0:b0:38a:a117:3db0 with SMTP id
 ffacd0b85a97d-38aa11740b8mr10363924f8f.3.1736964609006; 
 Wed, 15 Jan 2025 10:10:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c75298adsm31808245e9.30.2025.01.15.10.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:08 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 31/48] acpi/ghes: Fix acpi_ghes_record_errors() argument
Message-ID: <5eb07a4ff067053b4d6bf55d2d614b65b00a476b.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Align the header file with the actual implementation of
this function, as the first argument is source ID and not
notification type.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Message-Id: <d55f2a6ede5a168e42a20a228b2c066cb4c60939.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/ghes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 20016c226d..50e3a25ea3 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
+int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
-- 
MST



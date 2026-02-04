Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D20EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAa-0000Ru-O5; Wed, 04 Feb 2026 14:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAP-0007h2-J3
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAM-0007vr-Ss
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ArWa7ZxMRfjmS5u5tmE8e+KIpDRrIw2EFlofFVZVFnE=;
 b=UvqW/pPoRN67U7NRKPhWaEDD7yE/T/bFEH6PXYM+qae+x/JcW3V6O/QqvNhCVb4hGkffO+
 gWei+wDT0JO2VWXuk7dpPK6cjpyjf4O1dOGJyyhZXudJdghrLYeeNUb6x1kbvSLQ5+Z8Oa
 /N3WHxM1KY/Biuv3sHQvP+cGbPo36I8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-fLSBq9ycPfyhk56oSO4QtA-1; Wed, 04 Feb 2026 14:03:52 -0500
X-MC-Unique: fLSBq9ycPfyhk56oSO4QtA-1
X-Mimecast-MFC-AGG-ID: fLSBq9ycPfyhk56oSO4QtA_1770231831
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4358f90fe8dso118430f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231831; x=1770836631; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ArWa7ZxMRfjmS5u5tmE8e+KIpDRrIw2EFlofFVZVFnE=;
 b=MaDtEFQI1XNoEwfdNqLNiOUsQGISeFrpCd9FOqIOWvvFv1hlzVfMSTzOVWNxGgbnbD
 e7KN958tp7i5+YFiOaEa8DA07Hovm97hV/y1bw/GZENGExDO2xe9G4TBzLz0FDG2//jw
 jsT36geI83uF2sqyO/GnOFOo2dr84tA0qqaxYySAe6omQWK2FFoPjBeZCNtq/rfMMqhH
 nlpPgJYGsda52TmcE15XKDQ3TM85PRiKzkgBCZ2cvpcoaZ/se8WDleR8p410kfBRFO5t
 OABO8ziZNv3n9knqbY0X6lolNwxcqMhNw7LVxtcYVXOD8TAVtKNNFiEhsS2du70kF0r5
 xnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231831; x=1770836631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArWa7ZxMRfjmS5u5tmE8e+KIpDRrIw2EFlofFVZVFnE=;
 b=M2o+YXxPY3qlpz5n4QSEG4/qIk/iRSa/5q8iqEbPnd0azaoK6KQcMMiPISBiMpzlNy
 wGxDvFh9M0ryZKD17ldU+WwZtWhIWhjUa3cOzfQ1ROaxNEOTn+ECHKPBtCcZt+vUcDl7
 tgqIQIK4yTQ1LyHvyBbyIlNPyYFCkTEFknEWxr2gMWSbK81teD6JjvC7etyA0yFWZOOH
 xt1goE68zrmyb2SK39/CqwkYWP13QrR0y77bo3wAAjXSRqjkO0qzFIn9lruH8mf+WgZs
 tCmiqUUbr5L0uCk1I6i0VtG1K6wZAhMVxm94VWyiuMpwu6INFrnx7qApE+9SOuAmB6f0
 sg4Q==
X-Gm-Message-State: AOJu0YzRnoOZ6bKfehIKTqUIf/29hj7ELa79nCjVPEKfvJeDjZXACsiD
 mmlsYjHWVtEATG8mNxh7eLA5ou4oWjhtKESOg+7RM6mdOwiwo/A1nUSqrZHVgqmqgDhcr6L9BJ3
 /7dLzwndz8kUPm5NjAbn4D61GR4vBcfkY7GoA6t+FDw9e5O2dOwESq0oAoRdbBTcDnSF/OIte4C
 VOQTx2akA48pjh0eVsrJg9Hp4G30ELWCXX1Q==
X-Gm-Gg: AZuq6aKJGbTnKlEStexrrcKixjLzj3oujDuzgD5SHWX6qCQCxX5rqzjBxHoaX0zQG7u
 2o0hqNmfIj9KYqkbnM3zQNUVmyFn/6f0H8VHAgQMEFR2hMCammSuJgpFn6suvjWaINL7qdN8w6W
 x1VTrf9cGhLguZtUXxb4MZvMK9fxBHEhYkbBNr1qyzG0vfsjLCz78LxMO2AByfmOi+Lrbn8G732
 NrTvc6YopBtXO9w0hoZpv6B3/wOAWtnqFfr9Y63X/W4zcG4+u3Av1t6JTtFK/1UQJXb/oHFxP+g
 sq79P8VX3kTFfS0LXdyN150svv924Gd+rw4abaP8CVIjxzEomx5+42NyQwmtsCVRogiiNNRUtHb
 ucmvL7zjZrfODbt3BR0Z0ZtDndnmC1JjIGg==
X-Received: by 2002:a05:6000:616:b0:435:92c6:d556 with SMTP id
 ffacd0b85a97d-436213dfc30mr529202f8f.16.1770231830830; 
 Wed, 04 Feb 2026 11:03:50 -0800 (PST)
X-Received: by 2002:a05:6000:616:b0:435:92c6:d556 with SMTP id
 ffacd0b85a97d-436213dfc30mr529137f8f.16.1770231830333; 
 Wed, 04 Feb 2026 11:03:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805faddsm8351974f8f.33.2026.02.04.11.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:49 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Dongjiu Geng <gengdongjiu1@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL 26/51] acpi/ghes: Automate data block cleanup in
 acpi_ghes_memory_errors()
Message-ID: <41c79ba3ab0dc84f9601f0d48f47e0502334fa2f.1770231744.git.mst@redhat.com>
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

Use g_auto_ptr() to automate data block cleanup in the function so
that it won't be a burden to us.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251201141803.2386129-2-gshan@redhat.com>
---
 hw/acpi/ghes.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 5445dc11bd..4e6903a8d3 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -566,9 +566,7 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
                   0xED, 0x7C, 0x83, 0xB1);
     Error *err = NULL;
     int data_length;
-    GArray *block;
-
-    block = g_array_new(false, true /* clear */, 1);
+    g_autoptr(GArray) block = g_array_new(false, true /* clear */, 1);
 
     data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
     /*
@@ -586,8 +584,6 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
     /* Report the error */
     ghes_record_cper_errors(ags, block->data, block->len, source_id, &err);
 
-    g_array_free(block, true);
-
     if (err) {
         error_report_err(err);
         return -1;
-- 
MST



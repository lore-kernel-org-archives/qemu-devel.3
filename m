Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94436C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7s4-0005rg-V7; Wed, 15 Jan 2025 13:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qv-000096-G5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qq-00074q-K2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/dUCsKb0TMFSGFh+lNfPFs4aoQ4JRtV+rc4QjtcMiM=;
 b=FUx7KNXsclSqiojYsajlDBNSYu3ubz8DE5qXjHyRg1z5UuJNqQn9QTZobyWeQ6184q+1ff
 erIoyS8wuZONQ1uA0tYeolSqfZ72W2rp/n4wJXPGXc3P4CGZeKYzab8+I0YbU9ds1ooM0u
 XXLn/rBF88MI6nkAQ+F+p3wBoJvzQNQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-8JSjpnw_MySaO4CKppukfw-1; Wed, 15 Jan 2025 13:10:46 -0500
X-MC-Unique: 8JSjpnw_MySaO4CKppukfw-1
X-Mimecast-MFC-AGG-ID: 8JSjpnw_MySaO4CKppukfw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e49efd59so48328f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964645; x=1737569445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/dUCsKb0TMFSGFh+lNfPFs4aoQ4JRtV+rc4QjtcMiM=;
 b=GS8K7VfSRS0UyRj7qC4jlTQgOhEKMTxvlpbgygwKVHpAitv9pQ31IK+NnYBhH1O+F6
 SrNoWBnqV/wvcxMsFfvxBqsLHBLaYjb5ts91aMX5uhLU6xeCb1q/AwpdL7pme20eap+i
 bvFTilrRr9xsu9C6sV2pOOzVOLyiB07ridTbChjZnadJQSIpZ5gWsB7uMCOgAyVuP5gk
 tgEGwpzjIm8cVd67VzTYeTQlNAAMndAj6wQ17hOxFTIopg4FWK5qTBlNxs0wsqcuazJ+
 /NgpgTDvcJlPosAbwrRF3lH2JX2VBLUDZTi1pBNn/pNnQlmok9kfW5loxlp7Zo8lNDDy
 N6bQ==
X-Gm-Message-State: AOJu0YzjU6JQfyEY+RxxgdOvIrV6UG0nK+UdIOZxQ40sNhHvVpEdNjJM
 6JfD56L2q+rSbZrBadGJMGm3h11eEo3NLkY0hCaD+k/xeJULkpFvKivDRSkd2kRPC9RhNMdMzc+
 VP75HOsNwwrhfDb3N5gkubP/MVV94de4pi18u496uca77wDk591yCwbS6tzH2hzYyX0/krm0DUE
 3YLo3VBFUeOfv1VZSDG1g7TzXPr7CFAw==
X-Gm-Gg: ASbGncsEvD7Yj0LhFLuJquMqmSQ30PP1gFdwMocZ3SaonqCIThKk6Lu7b19ZERMZRWs
 uWQ86OSEFlEFk+xH3PGbo3uUT3sVafqI06RQ+8TphzmstCGUub95/RBHEwGdGmYytUiDIqwMWOv
 XK71GBOjxdMTRmzKItqfXgn8vqFQxErSIHodGr1OrvkFqFixE3XOJbafidQlCGfHtTPTCxsUVhP
 kHl/y8GUf884kGKvjRuucvmCRUx34dU/vbJTm8Yx63738VjLMd6
X-Received: by 2002:a5d:598d:0:b0:385:e8aa:2a4e with SMTP id
 ffacd0b85a97d-38a872ec201mr26677172f8f.31.1736964645025; 
 Wed, 15 Jan 2025 10:10:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3Mv9vVAJJkAOQiw+N4OBrDBxt/CnK8sGKnUoKAfnkwLMXB+WdI7WtIzR/LXBGylLA9tMoLw==
X-Received: by 2002:a5d:598d:0:b0:385:e8aa:2a4e with SMTP id
 ffacd0b85a97d-38a872ec201mr26677139f8f.31.1736964644607; 
 Wed, 15 Jan 2025 10:10:44 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bf65sm18074120f8f.49.2025.01.15.10.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:43 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 42/48] docs: acpi_hest_ghes: fix documentation for CPER size
Message-ID: <84c146758d79b3689b6c9c7815b6bfbb70ba06b0.1736964488.git.mst@redhat.com>
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

While the spec defines a CPER size of 4KiB for each record,
currently it is set to 1KiB. Fix the documentation and add
a pointer to the macro name there, as this may help to keep
it updated.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <f7e94433bec19a9d6b23ecccc24b5fe3a6f7f52b.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_hest_ghes.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index 68f1fbe0a4..c3e9f8d9a7 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -67,8 +67,10 @@ Design Details
 (3) The address registers table contains N Error Block Address entries
     and N Read Ack Register entries. The size for each entry is 8-byte.
     The Error Status Data Block table contains N Error Status Data Block
-    entries. The size for each entry is 4096(0x1000) bytes. The total size
-    for the "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.
+    entries. The size for each entry is defined at the source code as
+    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 1024 bytes). The total size
+    for the "etc/hardware_errors" fw_cfg blob is
+    (N * 8 * 2 + N * ACPI_GHES_MAX_RAW_DATA_LENGTH) bytes.
     N is the number of the kinds of hardware error sources.
 
 (4) QEMU generates the ACPI linker/loader script for the firmware. The
-- 
MST



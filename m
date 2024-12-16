Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30E4E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28p-0007Ey-Eg; Sun, 15 Dec 2024 22:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28l-0007ET-TU
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:27 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28j-0005xG-Qg
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:27 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71e17de2816so1922183a34.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321084; x=1734925884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wosSj0kWkq5cs0VFJpmmiyQOLWqM761SJCj5OeJxoag=;
 b=PUPch/81oFocagTOpphXXxWyaea56OnqPpQkOfq4EFXtS4UfQAEzErbom6wYVv6xRF
 nGswTss3SPNvcLY+JNoDE6z8BmD48sn5B5uASygrYqVj2D3DVUbVKBRGivaJ1JhyWxCa
 S2p7LeBi764sENrw6VMF6lmVvYpzdNch6PQUlwITbEpQA9YKI22QlnV/DRUAVCicoZWt
 s2CmQFPxHsEo5elxALU0ONxuEITpBNNjbr6cpuCpDrIu5yQslqrKqlOabgF2O/d7oN44
 Is6coveyhb37inJG2qyGVTpEvAnnytbUFhodCg1Clj7EcQsfs7jVmAUqdE376D+CXjbO
 sJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321084; x=1734925884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wosSj0kWkq5cs0VFJpmmiyQOLWqM761SJCj5OeJxoag=;
 b=QwSfVhEKputhWlLubvqVSP0xVOI03OHzuUOmjRhIFQFH/hSMg4caT8KcLJqY8w7T/n
 idv7Ky0jtW5a4r5UBI5QRrdcJQzRGGTH31Uf4ETmmsr4C2TPOTb+1K93CDmoSQGCcVvN
 W1rphRTjNv34OFRbOKZHyKPaGvTOPi2/1VAO2qfY9Fe+cKW8/v69Qfu4MWNnjwvWUrQd
 gVMJghohOnn+lkWc8FqHCaO25r7xlMtTbP3z6D60Uz4G5v96zFfrcn6ufl1oz7eP/T/8
 6FnaeTJMFqKuxInA5SSP9sNAV7xZrjQXblEs/BrSX2pjlETcplhdQny3l1kTO5HaNLxj
 o8XA==
X-Gm-Message-State: AOJu0YxPqhegugWo8b/NXXJSeSSj4m/R0oBho4f56TbTPt8S6wWh5YQ4
 1c1QxHfgQNA0dXyCG77oQaMm0irQS0iuoxggw6KQWd1o9NT1v3/iMvbprF6r+2FlO49L/iJGoLE
 FvcUAQ/hs
X-Gm-Gg: ASbGncu3FejGXjzhywYPumPYZW+luTAVcQ8LYqxTlFcMKFHlXNBv3KuOEMouznq9O7h
 WEFgdpE+x3eG64jYvHlVoq5n4kmPspKh2Ls8faN/bmjbEFOYe4SRuxDBNR0nyTnqlofcXh0CGA/
 h0eZkXixgLwLffe47qzD6sxbMuiuyBS71EN5TuOw7cDgsfVa9eCSNoAfI1xXMKxPL6fjuklCOUM
 TU8Ubwz1KI9MS8l0Up5X17zRRDRT83Qc9godLcVy4apE0GIkbKtFXjzfn3ueQi8dmGfJTT4BHyQ
 fuNa/TUmfsKRhDCrMPoDtIMa6qferhWHZ5dUqLc1IPs=
X-Google-Smtp-Source: AGHT+IHxIjzQF4nqSnR94Y36o62aqj/V79zyE0l0msX9rnwXhMhRov2cmnjoEbDLwz5K+z9RpMqDKw==
X-Received: by 2002:a05:6830:6995:b0:717:fdb4:c207 with SMTP id
 46e09a7af769-71e3ba62e68mr7044607a34.26.1734321083930; 
 Sun, 15 Dec 2024 19:51:23 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/24] migration: Constify migration_properties
Date: Sun, 15 Dec 2024 21:50:46 -0600
Message-ID: <20241216035109.3486070-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/options.h | 2 +-
 migration/options.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index 79084eed0d..a360f93a44 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -20,7 +20,7 @@
 
 /* migration properties */
 
-extern Property migration_properties[];
+extern const Property migration_properties[];
 
 /* capabilities */
 
diff --git a/migration/options.c b/migration/options.c
index ad8d6989a8..24cc8471aa 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -85,7 +85,7 @@
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
-Property migration_properties[] = {
+const Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
     DEFINE_PROP_BOOL("send-configuration", MigrationState,
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE72CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 22:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL7sq-00055n-IT; Mon, 17 Nov 2025 17:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7si-00053s-IT
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7se-0003Vn-2z
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763419160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7ZqvOQ90gmFIf/hFQ8V9UgYpE72n8kZiTk3LgVKOZs=;
 b=ISuGzUNHefG+YDxq5DGFIIWq8Kj7uEZi3RZ/aG7AZN7kx9Vv43RIKo0eqmQ9y6TFwnVrl/
 DP4aozBi/n9B99xTuyY/9I6A5w65DvD15I76Yj6fBbFio59lfBNTTZzeFXLDlC+Mbm7ixn
 GyV500tnMA1PYzODd9frNJscVbcmVQQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-diI0CpyJPTaKrr-SL42ZtQ-1; Mon, 17 Nov 2025 17:39:19 -0500
X-MC-Unique: diI0CpyJPTaKrr-SL42ZtQ-1
X-Mimecast-MFC-AGG-ID: diI0CpyJPTaKrr-SL42ZtQ_1763419159
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2ea3d12fcso508523785a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763419158; x=1764023958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7ZqvOQ90gmFIf/hFQ8V9UgYpE72n8kZiTk3LgVKOZs=;
 b=XP+VNO7fzx8nOGp+Tya7lNjeH6uwTLlCQq/3mKnrrMAQgJnqKsyZdTlM1bK9VYuVVx
 wweX6ifOSatSdqOXVJlP4eF5ktKwL02txJXPH46mWnOeu9JD0PX8i/srlUeR7O52Wiao
 cFt7uR1o7yURSLHSulnZvU5fRwYDmXg2w+aiUe8K9hrUueI9I5JFVVAnY2mbbechZph9
 eVRhSGSYS4UBUpc80sWhDU03yN2VuAAUTfEqNDObCPm3wXnlSWRLNhKzZo74uK0G2wSb
 LhqCTrRYIF+eLfQJPlP1X7bpvbmmcViIi8bvjvWSpfhrK0wCTLtyFaSY4gxD0pm9vkxc
 ving==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763419158; x=1764023958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N7ZqvOQ90gmFIf/hFQ8V9UgYpE72n8kZiTk3LgVKOZs=;
 b=TmvjUFsrBIZe3DsKHz2qUl/2JU+B/YRrc8m4m+G9eB3a5smOm/1HVc6zg3gpPRiRMH
 wI/CWd8dwAwKhPgcRHiYPLr+eisj//sCkSbZ7e/mTKGc1biOBPt8gTBVSnU7EG6A1BEb
 Qs6SdYLUHenk993ZMG2oywPmdvCeHJFcLKPd9dCLkTFIf8LCelU6cHrGgxHrZOuJbHlM
 kpe8bYVT6qV3n2PloI2nUspv6rH6qcK8BFHpa/wPOlfpawHU5ZfYOmno1hMhIBbculS/
 kaeBea3lZk9HDUfEJFu4jm0mPNpWYIzpgOOOit0253M4p64avqFLjImo8Z45Ob/547Eg
 wbdw==
X-Gm-Message-State: AOJu0YwGYCRSht8ZSsHLk+5gH9Ar0nolSQJ/124RPYXhfPX9qewYyob8
 xMu3HW8zv7nnq5sqi86tZ3oAd6XU+WnDjGP9ZFS+5330jztaARSlOqnJsbzxVidMVj97hdsTS+i
 hMpTSpdZQ7pih+6e5OOluJY5XP92S0fJlkJelIgtoWHaigh+5HwHu4wlHmwencPIlxaKcEsa7xO
 2xWOq15meft5P7byh/1pE5ABzNTGW8sWSC6hQIpg==
X-Gm-Gg: ASbGncvHH+tuaamYiqhuXzfnLI1OKdnq/mHySIPPKIqfKUBC5qd6mGfmWywkENIc16n
 B5ubhE6flgRDFYoH502gOgV91eeh70J2ipu2rg5R5jGoyIBouGH5l+jEhIU9ZZ0qdNWwTR/IXqq
 xgPldsiSbCl1MIz/mIevcddGTH3Z9mkJ+zXHOCo8nBr2SFpfK0/6nm7u6ucRewqOhI/IT7z3UqJ
 0WYojnkMy5cjv7r7NOKesMgiovxagbYaIsTK8BGv6TWbWbmizOswn/ZIXiJbZYIz23FJWjRqEc2
 k0TdtTkqi1H9BjdgrG0XZ09kC1Sex0rQYFk6Ox9PUkU55nRAng7RbM5+VGHoeQROevcQB8xCZ8c
 =
X-Received: by 2002:a05:620a:462c:b0:8b2:6b9e:5396 with SMTP id
 af79cd13be357-8b2c31db495mr1905858285a.83.1763419158352; 
 Mon, 17 Nov 2025 14:39:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnsDybuBnv+4j7DwEp4HqmwIeGiD/hln7adRu8oOth8g2mdYu3wkEu6h2cKOQTWDxV3lbdjA==
X-Received: by 2002:a05:620a:462c:b0:8b2:6b9e:5396 with SMTP id
 af79cd13be357-8b2c31db495mr1905854585a.83.1763419157797; 
 Mon, 17 Nov 2025 14:39:17 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm37693521cf.30.2025.11.17.14.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 14:39:17 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 3/4] tests/migration-test: Add MEM_TYPE_SHMEM
Date: Mon, 17 Nov 2025 17:39:07 -0500
Message-ID: <20251117223908.415965-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117223908.415965-1-peterx@redhat.com>
References: <20251117223908.415965-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add memfd support for mem_type.  Will be used to replace memory_backend.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h | 13 +++++++++++++
 tests/qtest/migration/framework.c |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 70705725bc..9dec21c344 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -19,8 +19,21 @@
 #define FILE_TEST_MARKER 'X'
 
 typedef enum {
+    /*
+     * Use memory-backend-ram, private mappings
+     */
     MEM_TYPE_ANON,
+    /*
+     * Use shmem file (under /dev/shm), shared mappings
+     */
     MEM_TYPE_SHMEM,
+    /*
+     * Use anonymous memfd, shared mappings.
+     *
+     * NOTE: this is internally almost the same as MEM_TYPE_SHMEM on Linux,
+     * but only anonymously allocated.
+     */
+    MEM_TYPE_MEMFD,
     MEM_TYPE_NUM,
 } MemType;
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 6df0e56c2a..4d1663356a 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -276,6 +276,9 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
         backend = g_strdup_printf("-object memory-backend-file,mem-path=%s",
                                   shmem_path);
         break;
+    case MEM_TYPE_MEMFD:
+        backend = g_strdup("-object memory-backend-memfd");
+        break;
     case MEM_TYPE_ANON:
         backend = g_strdup("-object memory-backend-ram");
         share = false;
-- 
2.50.1



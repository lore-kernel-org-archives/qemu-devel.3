Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0C2C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKvMe-0005B7-PP; Fri, 30 May 2025 04:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMW-00054r-VT
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMU-0000rw-H1
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748594709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gk1BpX+DWlk1ccwYz/mV2ZvL76JZlfynXExlLgJwf0w=;
 b=bogy9/IRoS6Ne3h9z7PS4QGYbDAo2hpl+fmweHHQoDZ7h2AGgw4fH9zlW92uKHjlMUFstn
 MKmEbYr1jcYCVLBAYmcwuNDasGqds2ClAJhgQQVA0rXpUl7XVWtL3skS+LuMfBEbeHzw2Q
 Z37toBe3ZGhvlESh6Z3cxQQrx40EsRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-DyRzb5l-MJqpzqSIy-foxg-1; Fri, 30 May 2025 04:45:08 -0400
X-MC-Unique: DyRzb5l-MJqpzqSIy-foxg-1
X-Mimecast-MFC-AGG-ID: DyRzb5l-MJqpzqSIy-foxg_1748594707
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so9500625e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748594706; x=1749199506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gk1BpX+DWlk1ccwYz/mV2ZvL76JZlfynXExlLgJwf0w=;
 b=aB1nQPJg1cZX80F0ozf+RYrNiqR+aMYV6xI41ExYBEvkyQRz/fMWzwf0zOHaUv2UWK
 sWVfNDRC+CB2kwJ4wX8fM9+3Oa6TGNI2TM1wDWuQWCaREPQi6OhdQVFtLP8IwPZ84sis
 SFuapGqGljyPpokJFbBM+856kSEa68V25Fnm2iez1ATQ7I6Ibhyfdi5c14GpXKHTVqdq
 Ol8RFnR+uFUqDlalTaI7HxCNWjms3NReZbRY7WdRi6yNDS96AHw3CYMZYnid5smHQHmn
 ESReYqIwIiHN78Ceu+ua05dWjBy2u9m1egeyYbRnPrPhN+ouKxfafyvYY2P47vw+u/tW
 FMfA==
X-Gm-Message-State: AOJu0YxsOmZi9akPmH33aH6cBaFwPcYtFNk48USKVoPWprZWapnOCX3L
 CcpbtNYQBJa0YFJBz+Fdxdb2Z3Tplt9Oi2RRYt1VG3sigqQXYUd9iNpqsdNcU2f2M251MBKaxBu
 mdAhE+W7jP6T/4iedyrQ41kJz8XEYGTrgBVFHMmWiasZ2RG0xrsfJk8iNN8WNGs1k
X-Gm-Gg: ASbGncsAj6dgS+Bes2GIgphzxFAyuQadCCZauFfjywASZptahdeTOf7OAyLB8/Adty/
 tJqQ+oIiK3o03IhGChHDk7YgAPfGQg1lu5H4p+1GbLaGyDhtTl8cCPhrVpqr9ZfuZxPEEERoY3s
 FQFgsa6PQLJ5U15IHEgU5M/C6QBGs/3Cbt+dVThoAWgowWZCiiZVxvTdcnZXmOpaDuuAh7BVagf
 x0gqwgrIbZVqxnNzXaLsq6mesJezTDlYGX7Ic1Z3E2XyTYTFRN2FsexsuwgYW3ZghGMw0poZd5H
 rgpzNh/GL66xIJ7+zh/p6DGjqKnnDBqhPq9HFTHhmd6YzER6duzw6PE4Qo+hvdRjsNx2Gw==
X-Received: by 2002:a5d:64ed:0:b0:3a1:fa6c:4735 with SMTP id
 ffacd0b85a97d-3a4f7a714a4mr1899041f8f.35.1748594705797; 
 Fri, 30 May 2025 01:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYTcNkH8nBG14RIqrJ7WIXpQH5DGvUP22Jt0PfMBEn7MADFlHdtNPee2KGzNQTGz3MZn7o8g==
X-Received: by 2002:a5d:64ed:0:b0:3a1:fa6c:4735 with SMTP id
 ffacd0b85a97d-3a4f7a714a4mr1899025f8f.35.1748594705485; 
 Fri, 30 May 2025 01:45:05 -0700 (PDT)
Received: from localhost
 (p200300cfd700f320acd9b9a35df3ddfd.dip0.t-ipconnect.de.
 [2003:cf:d700:f320:acd9:b9a3:5df3:ddfd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b96fsm4150040f8f.8.2025.05.30.01.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:45:03 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 3/4] iotests/common.filter: Sort keep_data_file
Date: Fri, 30 May 2025 10:44:46 +0200
Message-ID: <20250530084448.192369-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530084448.192369-1-hreitz@redhat.com>
References: <20250530084448.192369-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sort the new keep_data_file creation option together with data_file and
data_file_raw.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/common.filter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index fc3c64bcb8..3744326d2d 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -176,7 +176,7 @@ _do_filter_img_create()
             -e 's/^\(fmt\)/0-\1/' \
             -e 's/^\(size\)/1-\1/' \
             -e 's/^\(backing\)/2-\1/' \
-            -e 's/^\(data_file\)/3-\1/' \
+            -e 's/^\(\(keep_\)\?data_file\)/3-\1/' \
             -e 's/^\(encryption\)/4-\1/' \
             -e 's/^\(preallocation\)/8-\1/' \
         | LC_ALL=C sort \
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5F6FCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPH-0004jx-8k; Mon, 09 Mar 2026 16:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP7-0004fa-Il
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP1-0007it-Pq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lc9q3aVwHdDuElq9fQQTf1eGS3mbbryM4KP1sxagD+M=;
 b=OR1Eup6IbplgqKNmi9akUTq7x9aZpEvvS0/bDzkbkeFsQEFiRoCShjqBqrMzGj1G6Y39aG
 5VmdYelA8pDAftcBHOyYmO9oagxcbvNTQ8jr/DUu/8oibo/zRi0Kg6hc705Yi9Z5b0XXvl
 AnZJyqFOv17PFQXelYa2wPQ9W0idyLw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Ye0saBMCMOqgczQqodNR0g-1; Mon, 09 Mar 2026 16:40:31 -0400
X-MC-Unique: Ye0saBMCMOqgczQqodNR0g-1
X-Mimecast-MFC-AGG-ID: Ye0saBMCMOqgczQqodNR0g_1773088831
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd7fc27cf7so1033395885a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088831; x=1773693631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lc9q3aVwHdDuElq9fQQTf1eGS3mbbryM4KP1sxagD+M=;
 b=g/fe4wlMGxpVH1oQLlZnJtWrdAOGOVyhyTFsLqJskjZX91n/P9MrPKWVUSxBH+zOiJ
 Y+pSC/E8jRcNO5gv/LzISGK+AiUSkD9415TlZ4iYaGtl1WMJgssyz2sUTpUrDT4djug2
 GDRTA5Ekld3KuWpzjv92/MiDEvqDIDQL8yJAZ87zBRsCP8xRAu+myYuoVfeEWzt7479m
 xPM4v0Tc9envDag4G9qxpjDTX98Z4rKdaE3focs+xlOUyNh8cXZU+qfTCMHr0ZIpr+0u
 VI1sjFMl99ipFFz8xclHmr9P4phlaFVqb1Ajhebg0QmwkujmCwFLMUqlWInKQ1y65l8U
 oOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088831; x=1773693631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lc9q3aVwHdDuElq9fQQTf1eGS3mbbryM4KP1sxagD+M=;
 b=YwbvWU2ioNlrPL5ZOH8G5H7gZL2A2Cnx91CsQO9O0IotGBQ3SOTlHY9B/22U9uBNwY
 elWKSOAs9vmPgtxItUui8GLcrpgOhxrkdOPo5NNLXsEMnjLv1X2MKEcdcS7Y8U/RDLnL
 wXbhbPxQCa86ngyR0FRTRkUIW0ooANuiL4+PRy4byv8PuYeLiwGs1E0xH8LwmuJ/TWWP
 v6xBIef136Jr9Yp/cTykCrNm5T2jXiy4IcwmB8b2rU0AD7I9PsuaD4kFHw74fEy3OR/9
 SFEjxlUtqSqCdojVDcvRQl0B3gtttdu1n8NIv5bYZg4aLFqzarL9ZrQ+OC27VL/tzKLU
 8UhQ==
X-Gm-Message-State: AOJu0YzEv99oE47scpiq1UiEf0zH9bMjO+5o86R60xWaSPofPQIXWiY/
 8QPAxQ0zJpavFZu2QLSd+F/FQbuYcAhHWudiVX+aknoF8bDym5POIz5XNy4f94tPP2onnQJ2w4G
 fhjyvIgUxF+nfxiT8oV8seCU/LbeePgzTzD6WVKLI2HUs0LsU80KCqAhJqtQbc0gpMYK+sg2fHg
 Ki5vL0+wqnKhMBaAH0PTuiP3g0E4VQBHmaAXJ7AQ==
X-Gm-Gg: ATEYQzzdHjwfR8IZTs0z5e02b4Yh6V4AY2tAy69Rg1cM0kJwNxhSt7M5yQz/LhmVojr
 B+GvjVxFLITXhXr6BM4gRZS3ZlY4/1tk1MuKK8gqaGkDAMVxP9o9TsG3FkxKQgpYLqO8bwB4bK1
 xuNgn3SLtahG5hxgIT/Y84Dk27yNDhSVKJKcpTQ2EZBgbT4pe304zFr6ye+F/qXB747yu3AMvTl
 ehjZUqUyD242GWaxqEoJgh6O5cLnQiP1oA7meKjPodcxcI/XwwrYkZAZ5LN8LMprCzLmddSTKsD
 XpWVbu1BgIgibkMC/f806hq8eJTLxLOQgJA0ATsgQyKfE7djJDCMQchE6NsvVqFSWWbgoigmJN2
 1MmibFcGoLayeN7YUmZ1WqF5TMVkb3HtBeE9DIKlN8+6YdmQviYOqGmHZS5pFGZZqwoYs9KN3jX
 vgazPEtQ==
X-Received: by 2002:a05:620a:319f:b0:8ca:4444:26e8 with SMTP id
 af79cd13be357-8cd6d47bf86mr1425229885a.63.1773088830775; 
 Mon, 09 Mar 2026 13:40:30 -0700 (PDT)
X-Received: by 2002:a05:620a:319f:b0:8ca:4444:26e8 with SMTP id
 af79cd13be357-8cd6d47bf86mr1425226385a.63.1773088830234; 
 Mon, 09 Mar 2026 13:40:30 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/18] system/rba: use DIV_ROUND_UP
Date: Mon,  9 Mar 2026 16:39:59 -0400
Message-ID: <20260309204007.1709441-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Mostly for readability.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260226140001.3622334-2-marcandre.lureau@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/ram-block-attributes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index fb7c5c2746..9f72a6b354 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -401,8 +401,7 @@ RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
         object_unref(OBJECT(attr));
         return NULL;
     }
-    attr->bitmap_size =
-        ROUND_UP(int128_get64(mr->size), block_size) / block_size;
+    attr->bitmap_size = DIV_ROUND_UP(int128_get64(mr->size), block_size);
     attr->bitmap = bitmap_new(attr->bitmap_size);
 
     return attr;
-- 
2.50.1



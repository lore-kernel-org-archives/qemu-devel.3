Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3AFC8303A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQE-0005Cj-QU; Tue, 01 Jul 2025 07:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQA-0005Ay-QG
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQ7-0003Gn-7u
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vKpmgPjmhYXTuu7BvlQEe4nDt+V2FcjCdZIcprXjuI=;
 b=DnLKSwc0yc0Njdd+XFQuzZpODYkbj9gVOG5utZ12UBbj6+jvQbCpDbVCDnsmBywJD5acTU
 W5XkGPe8urDnydGCmeEnGI15BoIs3JWpJIxu7nylkXQD6uGASJfDKM4MhJvimj4lzbt5Ug
 WWab1GmBkcy/EqysOH6WvKwr7Laq2Ck=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-X4mlzZbNMVCjoQ7-8TznqA-1; Tue, 01 Jul 2025 07:45:00 -0400
X-MC-Unique: X4mlzZbNMVCjoQ7-8TznqA-1
X-Mimecast-MFC-AGG-ID: X4mlzZbNMVCjoQ7-8TznqA_1751370299
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-453a190819bso13754785e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370296; x=1751975096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vKpmgPjmhYXTuu7BvlQEe4nDt+V2FcjCdZIcprXjuI=;
 b=lhUqJ1t5+5tNf9SZtq5nU4miSgC2bDXLG37GdsEyrdEYs3TG2r0pKMPw6PJa2k33K4
 GZ/YBVlGh5fvgWLxufqVWX9RvogwoDavBs1mlqQCi3zX15bSiCbwszK7SUR0aTA4FMG8
 ajLrzWg35QeD9k7ZUMq/NZGXcZ2/AcVXHxsIXTid51TYaL5rAzSxbxpu8gBwxWIXlrY5
 YZo18/+uSBJlpH1YtUFtQ53xg5jTkn1uChkeGuL9MnDj8sO//WrosO/hrC0SbxU4JxFy
 U/tFOXcO1EwHVEN7caRvg0+TqPs9aKSvd/vVWxyn8Qro94w1TnScPN07BrdhF9LyEOHI
 HvOQ==
X-Gm-Message-State: AOJu0YzZDuUyOV4F//zQZNhea5zg4NiMXjgNL3KRjzC7elsQaj1Ucg5w
 oFTMYiy17qdFDzj5f8zpqZokSxqtXuuCqLoVWpo5vFDAeo8e8hxw14VC3oL3LiYHCcm/mpKnjVh
 iFfc2fndyg8oNbu/nxBN5qNi7qajBgs8xEAQTOQI+qBRLtibDaYTf+IDKkkDg5nUG
X-Gm-Gg: ASbGncsgiNJd2+Y9RLvOnUuzLv5CDbT3IymWt4zwFTHq/Un/M4zlVLSHwSm1okJ7/Ig
 edPoKu8zlQHR/GF0cU7MBGhrOoWqfS4/MihUSLY8P9qg9Ne/JZPM6XrRekX/KB3c6MEsd6mJ6SR
 BRDoMcY2rl2qvVu3t3cRwd39u8jtQjVkX969ben1jvKj2a19VN2Z1PsEuO2+StabBtmHBSOLJTa
 iQJL80n6DpOKBTneoA31qXwN1znhfy745THbrEXjX7sfVK4uvMiWtviRLT5N+KFEIPy8r6qYhTA
 yCptF7t/q6pJ8NC0Ocz0iClqFN0A/iIu+l6RScRwm8FIf+iyk2uW7WuelrFJs+EBK/IEKyvlqys
 UQJwK
X-Received: by 2002:a05:600c:8709:b0:453:d3d:d9fd with SMTP id
 5b1f17b1804b1-4538ee2786dmr171246055e9.12.1751370296493; 
 Tue, 01 Jul 2025 04:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFnVhx8+S9QGIssPmVdFf2ggMvJmYrd9b7sgyt89dbVdhE/K2xro+o+esmdMZUNda9jdmdag==
X-Received: by 2002:a05:600c:8709:b0:453:d3d:d9fd with SMTP id
 5b1f17b1804b1-4538ee2786dmr171245865e9.12.1751370296118; 
 Tue, 01 Jul 2025 04:44:56 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad0fesm198409125e9.25.2025.07.01.04.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:44:54 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 04/21] fuse: Explicitly set inode ID to 1
Date: Tue,  1 Jul 2025 13:44:20 +0200
Message-ID: <20250701114437.207419-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Setting .st_ino to the FUSE inode ID is kind of arbitrary.  While in
practice it is going to be fixed (to FUSE_ROOT_ID, which is 1) because
we only have the root inode, that is not obvious in fuse_getattr().

Just explicitly set it to 1 (i.e. no functional change).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index a93316e1f4..60d68d8fdd 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -432,7 +432,7 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
     }
 
     statbuf = (struct stat) {
-        .st_ino     = inode,
+        .st_ino     = 1,
         .st_mode    = exp->st_mode,
         .st_nlink   = 1,
         .st_uid     = exp->st_uid,
-- 
2.49.0



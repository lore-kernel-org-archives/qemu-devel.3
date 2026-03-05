Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA8BF33A72
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9dm-0003zj-Je; Thu, 05 Mar 2026 09:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dl-0003yy-4D
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:25 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dj-0001n4-MY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:24 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c7382731edfso945780a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720722; x=1773325522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFc2vx9Nc5ovefioN8v2/d4AGVxpMeeeDO1skGUCAwQ=;
 b=WNCLD2nf9R3x84N5LOq5EBxs2WdKZSeTXUjs20kJBgI/tGrTCPh/Gap8ACr4IMwwEn
 enYU5NrTkIH6O9YFPJBil6L8ALejT/PC+iZKGoy3ou6Yvvki/0qStCx948h8c/5VHnlQ
 OzawgJm3irSeiku/g/jfcaDqoCifGMT9zb54LSaMauiLYRwCtjDv5LUA+H543HZYKkce
 q7fDYKDqZDxzOhkDUrTNgHIrmhALdJbeXJ9hlfg4KEn1gAqYwLfswKMGrE9bVi5CggwR
 r2P3e/JcoG9W91VfBypKQJJJUN8hxejC/JwzSbQdVJ4b0d6/DjwNxI1XvFEex1q4XwC5
 FlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720722; x=1773325522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uFc2vx9Nc5ovefioN8v2/d4AGVxpMeeeDO1skGUCAwQ=;
 b=iauOMEk9i0YBO54tVqTjgTKkGOd4/x2l2nf4mNxB2nYN3uVCbPJtiIhShmYQxdScEg
 neQH2lCn5R3F0GWCym9WJuAaNvzeNqq0qzXFWYHXTPmTfMYtyGqYR/HGusipHhg1xnli
 28WVnujksyox2ZKu0kBtjCvUhwW1bAKeQTUOsJIvXw2S5Vqd7Wrzr9dGfvMObJfoj3VB
 SuUuoQg9bWtLADLF8Qd/iNExXC3w6ecB0oqB4nWe/VQk8YqqgdsFvJ/QwTr7s9qUeZ8H
 xWE+TiPew2giyfFeJqQ5Wj5LQgkIpUo0Ub4teKIwJwCJPtzKisvAWI7hQ8L+hsfXNMAK
 8gLA==
X-Gm-Message-State: AOJu0YxaR2pmlqnrFLm1pgUPNuAtbRbDdlhxMUY/nuH4iq72ozUkoQSg
 OTHgAFn5/+37O+xf07G88LVodH6nSTksxfy+0BZtNVzHX8NS5kKS++IwDyRSs7pey9myqA==
X-Gm-Gg: ATEYQzzmWK/rgMEXt2gOHt3yhxFxBCTT7flVxnyowrKsm6pSe7QA71Jjz9mM202rACv
 N9CRDLIlVul2KbVyge9gtX2loT+/scZKpCAWWoteMvydUJW9Ix0KIK/Cxj0JYVs/q2QtaeNnf22
 1bTgeHyXQ3EbndsOqx2zb9NyNVimUN8NOakmBH59uhrpBq9t9qDyARfcrjs/d8LzEt3m4VH0yF4
 UwNd1oObcgarb2ktEA8r+F9ZgpyFtwOKJtR/v21+8h1ePJuYvMHX1TLCnmZdfoQcSIrhSgKQ6eM
 dLqJeH8UZsQtq4URkOous6ZnwX1He0QMZz7PHRKO9o148OqZBayJOsqhi0XXjGw8vx5/+ecaose
 2G9kM1uKMKznu4bYAjIAE6rI7di4RMxgO0PTO/nx6ZqOvXoCUeSVnjojUowkhMQfYsG80uCPQTG
 Egju6TZ8q2oXQR1X1lOY8nTcGtsppu23wvs2TpzxBpgbBypaf1ET54YnahOA7VrmvkU44=
X-Received: by 2002:a17:902:f541:b0:2ae:3a1e:3490 with SMTP id
 d9443c01a7336-2ae6ab10e95mr65916135ad.38.1772720721855; 
 Thu, 05 Mar 2026 06:25:21 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:21 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 04/13] blockdev: Update tracking iothread users with holder
 name
Date: Thu,  5 Mar 2026 22:24:50 +0800
Message-ID: <20260305142459.52559-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update the usage of "iothread_get_aio_context()".

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 blockdev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..01ccf64b3f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        char *path = object_get_canonical_path(OBJECT(bs));
+        /*
+         * For this qmp case, hard to find the point put aio context ???
+         * It looks like a pairing function is needed:
+         * qmp_x_blockdev_del_iothread()
+         */
+        new_context = iothread_get_aio_context(obj, path);
+        g_free(path);
     } else {
         new_context = qemu_get_aio_context();
     }
-- 
2.49.0



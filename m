Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA47CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU9R-0007T2-32; Mon, 10 Nov 2025 10:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9H-00070G-Cg
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9F-00011Q-Vq
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwv9oMOX+8cIAIEsBEPdJ3rvIMuXO+17mCsS5r9mpPo=;
 b=ae83U/wca6wfFtQUDySxHbwXlNb2NlSOjD7cD56c0B8vfCWau64TirUEmt+1/leQzEdT2N
 uYkvedlI7XmmYomwTJiEJaGKUS8ptgAtsU2mZN6ZckY8jWNAnkvZ66+mfFzh3s3la1TAzr
 mUw5fz26iAUYkUDz+7ZpZXNKsh/4Iwg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-bTScq2cYNXSkP67xKSY4MA-1; Mon, 10 Nov 2025 10:49:34 -0500
X-MC-Unique: bTScq2cYNXSkP67xKSY4MA-1
X-Mimecast-MFC-AGG-ID: bTScq2cYNXSkP67xKSY4MA_1762789774
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso24248475e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789773; x=1763394573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwv9oMOX+8cIAIEsBEPdJ3rvIMuXO+17mCsS5r9mpPo=;
 b=ZbRnT7etDTcauHSNoE1bG/6d8Wnc0u4GUAN6an6I6m3+l8JxOX4M2BXbMnNCYxMZ0d
 y384XL6PKQcyQs59MamglXDzwIYQAK1kkAtj/ZUkf9/jzHmmnhJyoCLIam7g7PetTUWy
 ISirk8X3eNao/oerxnwJBbyLvoPI7wOmvR054AEesgRbIkFweOLrKtBHATT1pxR57Q++
 M9so265+8uzhtRSvoi16zHN+JICw4/qPVmMy+w7OPclOfnW2OnI8ZUfYjzZwufh6zSzq
 UnfgGogZsDpqBM3s1zYNNZMiX1F66AgNU8JwTmf89M56921lCrzav0gVKD/5dunG54tw
 hJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789773; x=1763394573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vwv9oMOX+8cIAIEsBEPdJ3rvIMuXO+17mCsS5r9mpPo=;
 b=F/6EZ8N/A0BReJf8QPU4QTpR20/VCQOJw/JwZ0P0dLGXZmDbfoTwZr2ZjHprRn5GBw
 LnmpWX9weO0x3KHKfAc9kEJxSWPBPoRwH169M4OAdKNgwCtpbQNy+Yu1QlJnuK2Q8QpJ
 AlolhgGFe/qunFp78QtdB40VaV6YCOAMZyZIeSnU394Q/fPJhllxg1aT4+eGgP0n+gBH
 2m4l4tvBl0l8mu6Msox8A9UbvFTQaIEmi0ud58s5Paz2nxJz7v4B+oNaBgIjcNGxR31Z
 6x4fQ3AGudncHYIXGBWi6CBRMrIP11/iKJoSXXJ5R/IMFNgv0/Qrg2T0Xrl5qHyaH+GQ
 hyfQ==
X-Gm-Message-State: AOJu0Yyxy/gG5tJQWkS28mGERdlqhAE27LikUk3lxrZD5K//1exG8Znw
 F/cHykM7jYQ3KRiYgnwcnMiC7Il3MfiqZwQoT8/0nSPAad8FNdUIT/jGEL7I3EVRmQE3e6kt79m
 xCsLaeyrioYnjDEad5ZJNQJCzkgLRFBhGSgm6ziW/p+xk21uxBOfozI4G
X-Gm-Gg: ASbGncu7fOHlhbGlymCfN7oKHkExRV9RI+GfPxJeF9LRzfPdzI+1cTaY6zvtgeCHEzG
 wpxoq+ymSt5eIM85irog3Xgpm7pmXRUwbmXOkKPijjnzbdwxImSYBqDTNVf2DY6uiYbaiFQWZ6Z
 C9lnxgFgBOLDkpzwjfRlUIJmpnqLVgV3Jx+9EjAqEsPjunWwHCS5Pzo+sS6Qdpq0j8S03EnZPRR
 kpQMrYFN6ksnkBncWDCp6QNdJaGN9oIQS6aOmCrmYEOPb0Nyvk2qwEgb4Rn1MUc/BkMSxMVTKKQ
 6JISAkls1o9nU54wBKlok6bco8dcuJc6mmkqLD+WlSH6o0qsEf87ZC10Z3GqKY/82uAF3KiueyA
 DqpDKviPU0qYteVjl9SQjVXzcFHQuQWMrtHz5QJw2kGE9SuWXrzXTM4YB+w==
X-Received: by 2002:a05:600c:4ecd:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-4777327cb76mr79179815e9.27.1762789773571; 
 Mon, 10 Nov 2025 07:49:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpaV4arM40qypXSWawm0vTzq4KbiDd06rS9qXROrg/4OpsUc3yBjsCDg2PT7Cc8o4jl2l18Q==
X-Received: by 2002:a05:600c:4ecd:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-4777327cb76mr79179615e9.27.1762789773147; 
 Mon, 10 Nov 2025 07:49:33 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2dd927c9sm16143240f8f.27.2025.11.10.07.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:31 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 10/19] block/io: Take reqs_lock for tracked_requests
Date: Mon, 10 Nov 2025 16:48:45 +0100
Message-ID: <20251110154854.151484-11-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

bdrv_co_get_self_request() does not take a lock around iterating through
bs->tracked_requests.  With multiqueue, it may thus iterate over a list
that is in the process of being modified, producing an assertion
failure:

../block/file-posix.c:3702: raw_do_pwrite_zeroes: Assertion `req' failed.

[0] abort() at /lib64/libc.so.6
[1] __assert_fail_base.cold() at /lib64/libc.so.6
[2] raw_do_pwrite_zeroes() at ../block/file-posix.c:3702
[3] bdrv_co_do_pwrite_zeroes() at ../block/io.c:1910
[4] bdrv_aligned_pwritev() at ../block/io.c:2109
[5] bdrv_co_do_zero_pwritev() at ../block/io.c:2192
[6] bdrv_co_pwritev_part() at ../block/io.c:2292
[7] bdrv_co_pwritev() at ../block/io.c:2225
[8] handle_alloc_space() at ../block/qcow2.c:2573
[9] qcow2_co_pwritev_task() at ../block/qcow2.c:2625

Fix this by taking reqs_lock.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/io.c b/block/io.c
index 928c02d1ad..c4a4301321 100644
--- a/block/io.c
+++ b/block/io.c
@@ -718,11 +718,14 @@ BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs)
     Coroutine *self = qemu_coroutine_self();
     IO_CODE();
 
+    qemu_mutex_lock(&bs->reqs_lock);
     QLIST_FOREACH(req, &bs->tracked_requests, list) {
         if (req->co == self) {
+            qemu_mutex_unlock(&bs->reqs_lock);
             return req;
         }
     }
+    qemu_mutex_unlock(&bs->reqs_lock);
 
     return NULL;
 }
-- 
2.51.1



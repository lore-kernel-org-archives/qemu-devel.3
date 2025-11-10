Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE86CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUA2-0000gf-KE; Mon, 10 Nov 2025 10:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9Z-0007f9-0y
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:50:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9X-00015h-4U
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAXsKuSihMSjpHsg5qeXbwwqkrlPB91tL1NUu2U2BPI=;
 b=GTHNoEJkngFV2+7f0vFwjssVDJAD1dM4+sg6G+lJQilozhHfDdEhAjVyQWhAhHd5mtwO3Q
 /rmvFTleb03XKkRe8UpuuOkwKjasvIp5HTbTFHAv7iMmhAYRI/HAhRZCyuJAPRu3/70JUY
 wsKOxa+uWGIchZHDh7ju9LK51pGC2i8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-y5o1MSxsNeG4rNbSpBKjaA-1; Mon, 10 Nov 2025 10:49:55 -0500
X-MC-Unique: y5o1MSxsNeG4rNbSpBKjaA-1
X-Mimecast-MFC-AGG-ID: y5o1MSxsNeG4rNbSpBKjaA_1762789795
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e39567579so17101175e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789795; x=1763394595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAXsKuSihMSjpHsg5qeXbwwqkrlPB91tL1NUu2U2BPI=;
 b=s/9zhTdsi78xCF9AgXHUQu79FplLlohkGKVYD0MX7Y8FiGfLXU3Lx/xcwSFZW3UxUp
 yxMR6FDBibZzUKE6tM5VIjqACtOYmnWec1stUK6FuBPPaK0wAAYy+MzNhDJ2AEMJXu2g
 lB9Ifo8Bn6I725Dl5oTD74sZvGEPQ0rVHBtzj2eq73BknEPv6N3R8xk8g8vs5zt7yprN
 AjVsRJqv3ejTdSbDT/P7J/XdhUGwIQGQjIJYNXZ42RY1fKo58XaRNPZBCiNXY+hIV8Q7
 kW/tmzou9xqGLguhwgxRb88GfbYuBaTq6nibfmbiNU1+S0caMirJSzDCk15WJtxwGvMz
 kcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789795; x=1763394595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PAXsKuSihMSjpHsg5qeXbwwqkrlPB91tL1NUu2U2BPI=;
 b=Z225YwLihfexRXK2dgjEyalhf7k5brAQwCsiBxX9ZYhhOsunG15bbxGa9TShx9U+yI
 QPyJ77Tmy5DgKlHysPOrPQXlewMrrn/f7WdIbZgKKfhg6JS60u/8EIe7aNwHbYL4Wvjt
 7TuRgrOrULtZyZ10YxNfPONAW9l84/v9O4E1fdUndGTqFMkDYsVKV3HRbu8toMIct6hM
 wz3BYKevNgCYXsyX4fFy/eTEV7crSSgLSW70grmUoJIftn2iX7vSePUJRPKgF3fsZcGe
 pSa5AtoyzIswJXUyewwsVbh8RqIBsL88maZk49ciP+Xh+XRvSb+FNnFiuqqOBpoHEx1f
 uidw==
X-Gm-Message-State: AOJu0YzEogYfxwWwzvKWObbPNZtpF8srcR1ssDft9JtuQ419DshlgSs6
 FJAMmaSc5DoPlSv0EVv+fJlEuHXXre9tMG1ZgcDVAyeAEd3ewRlp+++q3quI+dC0QlBprc5OfDV
 IjopN+53EcbFmlxaF/jxRWz278j6AQYXGbgSx0LgtzCoCn4rA6tRE2JUH
X-Gm-Gg: ASbGncv8jaQScP1fFsaFiAu2MGa6yyZ5JKStns/tKzE+97KRwTPCqBHmcGrnVdAocye
 AjyP7+lo92DaKRvrx0iTCbyCuLq9OobQhPD7wacqjyeSIVjhjLbCIs7cSy52kWVjjifY3C/acyG
 A8z0aoloUO0QCGuSU0wKZNckKqltmN/VclrYlm+U5Hr66uyF5XTeQssgZN72OPY9foBd4rX58FC
 ikhSDVz1VDu5kGeP3qEsnQn/cAQhCUzdOmBpaWBaE7IFS0dWO5qPWfj2D0FtdXfi677vmutnFJV
 H+6pQdsR9aRftBe0EgIK1fRIOabvT7WuRohThIQOGawRgSB9ZFHgsOv89jbEq1Oh/f7GRwZHFrK
 5X7L4SSo4DYYgNA1s/+Wc06FZbuksXf1WzaBv18E0mYNoppEORIhuou22Jw==
X-Received: by 2002:a05:600c:4f89:b0:475:de68:3c30 with SMTP id
 5b1f17b1804b1-4777325ba75mr53342515e9.16.1762789794629; 
 Mon, 10 Nov 2025 07:49:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1XdIXkU1sguoUTelxCNplPso0xhRwzhhCljeSED0jqUKlVFyrbycTo/eoovAZgMn67SS9EQ==
X-Received: by 2002:a05:600c:4f89:b0:475:de68:3c30 with SMTP id
 5b1f17b1804b1-4777325ba75mr53342235e9.16.1762789794251; 
 Mon, 10 Nov 2025 07:49:54 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47767749916sm248434295e9.4.2025.11.10.07.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:51 -0800 (PST)
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
Subject: [PATCH v2 17/19] iscsi: Create AIO BH in original AioContext
Date: Mon, 10 Nov 2025 16:48:52 +0100
Message-ID: <20251110154854.151484-18-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

AIO callbacks must be called in the original request’s AioContext,
regardless of the BDS’s “main” AioContext.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/iscsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 852ecccf0d..7d6bf185ea 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -119,6 +119,7 @@ typedef struct IscsiTask {
 
 typedef struct IscsiAIOCB {
     BlockAIOCB common;
+    AioContext *ctx;
     QEMUBH *bh;
     IscsiLun *iscsilun;
     struct scsi_task *task;
@@ -173,7 +174,7 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
     if (acb->bh) {
         return;
     }
-    acb->bh = aio_bh_new(acb->iscsilun->aio_context, iscsi_bh_cb, acb);
+    acb->bh = aio_bh_new(acb->ctx, iscsi_bh_cb, acb);
     qemu_bh_schedule(acb->bh);
 }
 
@@ -1012,8 +1013,7 @@ static void iscsi_ioctl_handle_emulated(IscsiAIOCB *acb, int req, void *buf)
         ret = -EINVAL;
     }
     assert(!acb->bh);
-    acb->bh = aio_bh_new(bdrv_get_aio_context(bs),
-                         iscsi_ioctl_bh_completion, acb);
+    acb->bh = aio_bh_new(acb->ctx, iscsi_ioctl_bh_completion, acb);
     acb->ret = ret;
     qemu_bh_schedule(acb->bh);
 }
@@ -1030,6 +1030,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
     acb = qemu_aio_get(&iscsi_aiocb_info, bs, cb, opaque);
 
     acb->iscsilun = iscsilun;
+    acb->ctx         = qemu_get_current_aio_context();
     acb->bh          = NULL;
     acb->status      = -EINPROGRESS;
     acb->ioh         = buf;
-- 
2.51.1



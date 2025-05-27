Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD34BC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJu71-00023a-Ho; Tue, 27 May 2025 09:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uJu6z-0001xb-CN
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:12:57 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uJu6w-0006Vo-2i
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:12:56 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-310f082a677so2495648a91.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748351570; x=1748956370; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EAjg3F/wNl2gtmVdLmcw+xR8YyJ/5xspSeH7Ru3RjsM=;
 b=XJhuPhK5pRZqhd8SJJCBSqwq94zAZ64hf65eVleMIZ2XFePequtXhISGJRdLllG9ic
 b0VjFqmtQ+zBn0FcStF8enHTa9Nahevs3nOWjU3y2MnPHrAOxW339RSBMwEOolb3orv/
 brH8duGLoqE2zDFmxEiS++zr26hXmJB4s6TL6OAfBWLikJbHne9Erb4F8YF+7GNXspYt
 DzlAq9gLBvPeYnct2v3SRad2uls9JlvA52gjbAzwWX0CRuin3oi4Yn7yZPTz3x64fPns
 WWAEGxwjLfrgZEpym8ND5udsBnWA7C04nj8AuHM5EtOBxw0hA8ik/clQiQ8bSf3ovQFp
 GQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748351570; x=1748956370;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAjg3F/wNl2gtmVdLmcw+xR8YyJ/5xspSeH7Ru3RjsM=;
 b=H14gVrDdDbe40pJfYkvFpyzfPRKP1WoLxzSR80RMYdAvcqam0AYIfm8MqXIfSR47+3
 PNcRhdT/2UrtM9RxjjgVGyvGkcU4oNLGP/UebBkbcWljtKpx4WtKqUhx3M3BAIUGEiVR
 IjQLpv9IlZpM0WmpZ4FmFCX9+Kn3GXekZvJOMaXommvHXhokEbPkxybKa4GuTGrLn/2W
 gJ4iOsptwI755VV8O6m8/k1jnWESIHPbMD3FuXOytEE8IJR9YYCv5ZW5368OLw83vQrd
 nqQ/aDgXCZtWMLuJU3GbtiwQOxIz+4z/wPiVrI3eilCYlgy3cCoQypDgVL34Moyayav3
 UEZw==
X-Gm-Message-State: AOJu0Yx1XzH397uUYqGETWMt0dXdXrs47vh8Q/isD+eoZviwvUPlZqir
 2bWNh6kpX2q1E6HUHSRSGeVZpOBVtTHfYz0b7prAZuCdrNkoPnvm1GsKDPfwBw==
X-Gm-Gg: ASbGncu/rtQ9R3YxE1gVta9xW10XHCQrrgcEwbKZSA8xka5U8+FMwDz7T1uun4wktLA
 aO3prv/KCMUfPG70gDXq+JVYnWAKsxBzBCeWLrdCmRAWhAXT8ZJ741QxjtBGF3QgBn9HeWgEGt0
 RsdtevRBGdewnCF2HhNsBHXMCvHsMQYR41/ODPYGNcTIjvxbbK5CWM3/Wmhg8+ewTIRD+lGYfVz
 mSJsc18wjdceZvKJbRapf31NxVJzhiUqe/q5wgcmOcDA5wKQ8SvxHAkmrFP5wnpFt/BUUvPDCJE
 uq9ShQ6TsZmAIH0VR62+3TSNSBmahfCIS7scfk2GEkRpUU10pAXWTgE/VjvK6h/Xl3o=
X-Google-Smtp-Source: AGHT+IHxHYx0T9FAAHiiabHwYImDQovM1p3fmyP1sWcD+0M9kjkCx47EAHBRAGLqXU1OFPXQ+k1RqA==
X-Received: by 2002:a17:90b:390e:b0:30e:9349:2da2 with SMTP id
 98e67ed59e1d1-3110f0fa6a1mr21466533a91.4.1748351569875; 
 Tue, 27 May 2025 06:12:49 -0700 (PDT)
Received: from [10.3.2.14] ([221.216.117.153])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-311b00c6403sm1335599a91.28.2025.05.27.06.12.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 06:12:49 -0700 (PDT)
Message-ID: <37889706-8576-476c-8fea-c1a3a2858b1e@gmail.com>
Date: Tue, 27 May 2025 21:12:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/scsi/esp: fix assertion error in fifo8_push
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=hz1624917200@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch add validation checks on FIFO structures in esp_post_load() to
avoid assertion error `assert(fifo->num < fifo->capacity);` in fifo8_push(),
which can occur if the inbound migration stream is malformed. By performing 
these checks during post-load, we can catch and handle such issues earlier, 
avoiding crashes due to corrupted state.

Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
---
 hw/scsi/esp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ac841dc32e..ba77017087 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1350,11 +1350,17 @@ static int esp_post_load(void *opaque, int version_id)
         /* Migrate ti_buf to fifo */
         len = s->mig_ti_wptr - s->mig_ti_rptr;
         for (i = 0; i < len; i++) {
+            if (&s->fifo.num >= &s->fifo.capacity) {
+                return -1;
+            }
             fifo8_push(&s->fifo, s->mig_ti_buf[i]);
         }
 
         /* Migrate cmdbuf to cmdfifo */
         for (i = 0; i < s->mig_cmdlen; i++) {
+            if (&s->cmdfifo.num >= &s->cmdfifo.capacity) {
+                return -1;
+            }
             fifo8_push(&s->cmdfifo, s->mig_cmdbuf[i]);
         }
     }
-- 
2.34.1


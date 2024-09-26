Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80430CCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 04:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stgS4-0004pO-IT; Thu, 26 Sep 2024 00:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgS1-0004gV-98
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:50:01 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stgRz-0002Eg-69
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 00:50:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37ccdc0d7f6so280824f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 21:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727326195; x=1727930995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=to+EWBeBhDa/Ji3aOabza393rs6Exp8hihjvwLJK1kM=;
 b=ebbHlqYUdeRCM01e1CAXho0V2R3bXAE0sEevyjVLdngN2ueKEzVQarjHhFk7e7XUci
 V5+QU7gNcJyuzVsmuGcJnOm/fbJhdPdEGNfNkvPOk6kjbRZCJv965v9PMKLPGtFZV8K9
 QAXkGBz0js8GzyvRNWp3Di2JBTLRQK5F5bNpoDAVfSJsie76p02C5clR2VI6ntR6yDXM
 6O8UR2YE+fsiOfV+GGO5+kKQALqjEJ8ort7YyFmnRQ4sLrOz6WkLBndeq8GwwUtobvAY
 VvJVR0HZMfw/gMQUIGnvMz8dEkW9/7cBerGoUmyL77Dl3+ELRi/o8oldMxoheB9NTRzL
 xC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727326195; x=1727930995;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=to+EWBeBhDa/Ji3aOabza393rs6Exp8hihjvwLJK1kM=;
 b=XFxSzo9BCukMvsf2Ns/w45swlYqw797Gu8R4rpcDZVuaaRsXundrUYh6zS1PAfq0Km
 afaFuwokg1g/ZImNks4m4jpgBReAQ6iGr/bmFEuLF5geI5N5iWFhEYVd+Rpz1Gm3xftn
 +lTRUfHjZhMzzHUCz1jEkgZU7meznDuQade/sif1R/oqCuoHZ7RGx0dBeD5MO2//SJlh
 Jxa7l1QbrOLpGnepaMwsjN+COCidjmMLvWo5zmE+RAZnaDmoXa0EiogX1ryFemi3Q5Jn
 IscQD8mXkSDeim8c7z2Ws6AeoXq900/lQo8UUyyy0dsZ6Kxw3mhFk+hTSNgmIL2F4A0w
 JBoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViJJzALG1sEadHjKtnNLVdY2J8cYsdQz1yvMhDb9roYE5R0QLtkbZQq+82qKQV4VGXc61wel8SAdLm@nongnu.org
X-Gm-Message-State: AOJu0YzH4Waj+qbMIRdPOdpLdUYjOaFYAZ1BVTC4I+1L+HZTGrgF04Qu
 WCjZHGTK13CHgpkf4zWVcYjGOIomfHYVo8XeaXZt5Yaq49jLkipUrByicVJ9Ne8=
X-Google-Smtp-Source: AGHT+IGrfmYfYXzcCez4i+t3DujBq0uw6tO3g0tH8mDmPaM4RBmsVTqKp947WJdZmuDpInw/3imcxg==
X-Received: by 2002:adf:f405:0:b0:37c:d0f2:bab2 with SMTP id
 ffacd0b85a97d-37cd0f2bf7fmr202513f8f.3.1727326195608; 
 Wed, 25 Sep 2024 21:49:55 -0700 (PDT)
Received: from meli-email.org (adsl-109.109.242.225.tellas.gr.
 [109.242.225.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ccd4a0e34sm1432508f8f.91.2024.09.25.21.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:49:55 -0700 (PDT)
Date: Thu, 26 Sep 2024 07:45:19 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Hyman Huang <yong.huang@smartx.com>, Klaus Jensen <its@irrelevant.dk>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9_?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Bin Meng <bin.meng@windriver.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9_rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9_?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Keith Busch <kbusch@kernel.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>, 
 Stefano Garzarella <sgarzare@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 06/22] block/mirror: fix -Werror=maybe-uninitialized
 false-positive
User-Agent: meli 0.8.7
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
 <20240924130554.749278-7-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130554.749278-7-marcandre.lureau@redhat.com>
Message-ID: <kelf6.0oxhf800l0an@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 24 Sep 2024 16:05, marcandre.lureau@redhat.com wrote:
>From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
>../block/mirror.c:404:5: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>../block/mirror.c:895:12: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>../block/mirror.c:578:12: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>
>Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---
> block/mirror.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/block/mirror.c b/block/mirror.c
>index 54e3a7ea9d..fd55a580fb 100644
>--- a/block/mirror.c
>+++ b/block/mirror.c
>@@ -349,7 +349,7 @@ static void coroutine_fn mirror_co_read(void *opaque)
>     MirrorOp *op = opaque;
>     MirrorBlockJob *s = op->s;
>     int nb_chunks;
>-    uint64_t ret;
>+    uint64_t ret = -1;

This doesn't look right, `ret` should be int. It receives the return 
result of bdrv_co_preadv() which is int and is passed as an int argument 
to mirror_read_complete().

Not related to this patch obviously. But since you're touching this code 
maybe we could include this small cleanup?


>     uint64_t max_bytes;
> 
>     max_bytes = s->granularity * s->max_iov;
>@@ -565,7 +565,7 @@ static void coroutine_fn GRAPH_UNLOCKED mirror_iteration(MirrorBlockJob *s)
> 
>     bitmap_set(s->in_flight_bitmap, offset / s->granularity, nb_chunks);
>     while (nb_chunks > 0 && offset < s->bdev_length) {
>-        int ret;
>+        int ret = -1;
>         int64_t io_bytes;
>         int64_t io_bytes_acct;
>         MirrorMethod mirror_method = MIRROR_METHOD_COPY;
>@@ -841,7 +841,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
>     int64_t offset;
>     BlockDriverState *bs;
>     BlockDriverState *target_bs = blk_bs(s->target);
>-    int ret;
>+    int ret = -1;
>     int64_t count;
> 
>     bdrv_graph_co_rdlock();
>-- 
>2.45.2.827.g557ae147e6
>
>


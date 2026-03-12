Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A14106ACC9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ili-0003Em-Lq; Thu, 12 Mar 2026 12:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0ilc-0003Cw-Qn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:20:10 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0ila-0004FT-Dc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:20:08 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ad79df972so1419347d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 09:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773332405; cv=none;
 d=google.com; s=arc-20240605;
 b=ZFyo8d7+C316i9cRqH7RIhiCXf3bv7kpqSj07pZtcAXBpDu8nkqvCQs86H9mAyggla
 fl8Okhufoy19R/aZZBpkfnwqv1i+EB1VhGvGKLX/kSK1XW9ymgMUf3K6LCDfsDQHQ16K
 Feek0IcrNb0JGugF3yvuJfUtpPUYkgFuFP15O3YZ1PjqFKcmC/UkEYeT9gJvIwcy0OWs
 JU57Z1XptQpgu8H7BBLlhlQ9FGiYmD0sEhOi4utSJ3b0fN4InJqvYoiMReuy/YcdcNSS
 HDzizQSHSa6CnN1p5eXnXtVFvwKJLrDo6AIZGek4JMI54AjdezMfbXTATYjZlUtywjr8
 NPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l/C4yuv4UsQehHqtFxGMENcjWJQKLWPAKltbM7tO6Co=;
 fh=BJl9Vmm+JbWLSrBSTggJxsWGg4LVd7ft0xFGkVpeVfE=;
 b=JSGcLALyLTu9zrH6jDwi2PYqrqIgV4dmeY0C9nnS1mFa1yQCy/oEy3DV85nQsF+6+3
 mOBsYQtcNeV897UB0w44l7Nyd0h+eZDMYcavig1N78PezU2t6VoI+4s/R2gJbSvkWyRA
 7R5TfkEkKKnuDcZRca0NxuQ5SdT+l+k5HuoppGPmucfBuJxqXvA+4P1jeQhwylnqSyIT
 OCkIgOGrxYgpH9PO/UdRkNROEcSSBFK7RM7jjJPjWNQwpJMbymNHIrDFfSE+XMRnM0NT
 LxXZ8fRUy9bsWBQfITqyQZlE9xbfJKWPakDHiXs+79GPVV9AuvadByT1RJUcPMvYULdG
 9+HQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773332405; x=1773937205; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l/C4yuv4UsQehHqtFxGMENcjWJQKLWPAKltbM7tO6Co=;
 b=g8v5z/yclyTdsde/IC/ml+xPc4JsZwQgvs/gAHgaFT4zUNGdLujyqSzo75szUxaYk5
 vOcumshhv4g+3Jt+9z2TzMr/3XIT2Ae/63P55O3lRpz+klDIBl3emttAmr8mr9u91kYo
 7ebCUH3UiSw5gO5KUpXIyfopqwMnZPD9XiABUR3cwefOsKfV4i+hAaT6bMGfxQ5jrAW8
 XfMUMmZm7+2EDFjeeYRG7RNrxf6lSVD/k8EW8MZYq95d7odaCbNlOuSUnOvOYbxLudjn
 BM3dnAxQruYYRwUxFmEjwC4q8LJ4/oi+Jcc60eL34Psnms4q6L8BheywaoyyHvX/srop
 ipog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773332405; x=1773937205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/C4yuv4UsQehHqtFxGMENcjWJQKLWPAKltbM7tO6Co=;
 b=sAFk7I1tj/bp1o8E81uJchdvL01v36A3NqJpa/TY/yektfsj2eIE7WH429d33nof/l
 vcwvSGrUxTDW9uARUnEY38PdyEWSMBkyTzxR+4pLocVj4V5YoFSSfkkJc6xYTQZ5RcTT
 Tbgvk4Em3VLSDrnCoI/xhlWeBM3I3eDnEqe4vVA8UzZtlQoE1u8b3+DRZNLpTjriBnkX
 BSeRSpgLmsENEMo4Lt/QgaQUObyeTrDCSGuAY6TQSFyvOkiDZau4xb/nOKhVbKEZyh8h
 /grPbM5R9ED3EyWmTMddpQggSwrwWiDTKdcr8/ipEXkU4tJzjDDurV62LaZFowhJRv8R
 /vMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3g6nHKZTKFKaqLD5enoQnZsWX//YJ5XpoVa2eLcGfDYl54BQ+ae7Kx04WXj//lOoDHh0ywIxgXqVX@nongnu.org
X-Gm-Message-State: AOJu0Yzjg7OEgVo77V53JPvjBtxWZPB4JErXl3L8lOGiw+p760eIGryc
 jGxGIj1HOHNGRAAKr6QNG4ZIjWxCfKC5ihrWoNWM2surjztCHOazcqf4d8sphI2CRpVp0D09LOk
 Zn/guPH8WIxqtttxjAWKtza76BJLZx1sGyuyUybYioA==
X-Gm-Gg: ATEYQzyqJ4kWV4w1U80t33NR1ekveJBnycCSMKyLunQmaQEHwegM7FsHeaXPToTe2Ae
 rIP7iJq6CpKf6EvcUAyPnkR690H1HGh7NtQWOxZ7XA04iwyCfCF3DuoBAmhmaNkvCQbbsAmbrtT
 pb7Hc/8Wx5+o2jvA7iO6lrl+UfMK6FINMkoHFN0XRfSaHfyNb0iDf89kU/Xy3PK77TmdVR3kIGy
 uDjUg/DxUPYqkXUsQWv5Q4+arDdwS/RrIfQWoRFRM7sd+jXNp0/yRZ4fo+pIbyYMAMZYUMqNQxo
 GpYlk2hbJ4huoLQiLRltLRIxRpPAV+XNdIeAbCZZeHOKBBSOobOfgV9Lk3w0dDCCM4T4QSAr5sk
 Yqw==
X-Received: by 2002:a53:c246:0:b0:64c:9c1c:5f64 with SMTP id
 956f58d0204a3-64e630e6a51mr91394d50.75.1773332404901; Thu, 12 Mar 2026
 09:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-27-kwolf@redhat.com>
 <CAFEAcA_c_LOZmeMc7PvcUK4PgyAbzvrcVt3VyALRLtY6ECbpEg@mail.gmail.com>
 <abLmCCB-Wjn-mqh1@redhat.com>
In-Reply-To: <abLmCCB-Wjn-mqh1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 16:19:53 +0000
X-Gm-Features: AaiRm50G62eDdHP-Zc8YAIbVw8r6ZGZVYOj4cQl0vIWAP4uoz3KXWlxR-anlvrg
Message-ID: <CAFEAcA9caqp+JP_cq7Q0P3EPgWywd8BJCrngAKEBh6i2G7uJ1w@mail.gmail.com>
Subject: Re: [PULL 26/28] block/nfs: add support for libnfs v6
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 12 Mar 2026 at 16:13, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 12.03.2026 um 10:41 hat Peter Maydell geschrieben:
> > On Tue, 10 Mar 2026 at 16:30, Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > From: Peter Lieven <pl@dlhnet.de>
> > >
> > > libnfs v6 added a new api structure for read and write requests.
> > >
> > > This effectively also adds zero copy read support for cases where
> > > the qiov coming from the block layer has only one vector.
> > >
> > > The .brdv_refresh_limits implementation is needed because libnfs v6
> > > silently dropped support for splitting large read/write request into
> > > chunks.
> > >
> > > Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> > > Signed-off-by: Peter Lieven <pl@dlhnet.de>
> > > Message-ID: <20260306142840.72923-1-pl@dlhnet.de>
> > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >
> >
> > Hi; Coverity reports a potential issue with this code
> > (CID 1645631):
> >
> > > @@ -266,13 +270,36 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
> > >  {
> > >      NFSClient *client = bs->opaque;
> > >      NFSRPC task;
> > > +    char *buf = NULL;
> > > +    bool my_buffer = false;
> > >
> > >      nfs_co_init_task(bs, &task);
> > > -    task.iov = iov;
> > > +
> > > +#ifdef LIBNFS_API_V2
> > > +    if (iov->niov != 1) {
> > > +        buf = g_try_malloc(bytes);
> > > +        if (bytes && buf == NULL) {
> > > +            return -ENOMEM;
> > > +        }
> > > +        my_buffer = true;
> >
> > Here we have code that takes the "read zero bytes" case, and
> > still tries to malloc a 0-length buffer (which is of dubious
> > portability). Then it will continue...
>
> g_try_malloc() always returns NULL for allocating 0 bytes, so I don't
> think portability is a problem here.

Ah, so it does. The glib docs document this for g_malloc() but
don't mention it for g_try_malloc(), so I missed it.

> > > +    if (my_buffer) {
> > > +        if (task.ret > 0) {
> > > +            qemu_iovec_from_buf(iov, 0, buf, task.ret);
> >
> > ...and down here we use 'buf', but Coverity thinks it might be NULL
> > because we only returned -ENOMEM above for a NULL buffer if bytes == 0.
> > So we might be here with bytes == 0 and buf == NULL.
>
> Yes, buf might be NULL, but copying 0 bytes from NULL isn't a problem
> because you don't actually dereference the pointer then.
>
> I think the part that Coverity doesn't understand is probably that
> task.ret is limited to bytes (i.e. 0 in this case).

Mmm. Let me know if you'd prefer me to mark this issue in
Coverity as a false positive rather than changing the code.

-- PMM


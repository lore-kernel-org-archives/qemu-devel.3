Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A806DEA8550
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzu0w-0000aK-AU; Tue, 10 Mar 2026 06:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vzu0r-0000ZZ-5O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:08:29 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vzu0p-0006za-Ax
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:08:28 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6615c461d3fso7588662a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773137306; cv=none;
 d=google.com; s=arc-20240605;
 b=Wyetf8zxTFp5RFYjjA0SANcwNSK/+9X+2KTxKuP+QXowh83K4Jr6idJSoCmy9BV0Ic
 GDJOja+V9lGSXQm/6LUXekqENZJu0j37SeXn/sgjrM8b0MX7doN9caZB7IeAbX74fEyH
 Kb8ZS3iy4X7LxD+sLtdWeBbJt6nwUqbm3xAG+P7Wme0a4WWbKlZKkF2iYFUzANCKQx++
 1t8eCemAUpsWxH4JgA5uCvf61lkAmfnNRkiyl3EsOgJRZrjAO4T1yZekuZJ7QT+YN0bl
 A5dex+lP7644ocMkBwGfcL2elT6vTAH9BvFtVj12S6yR3jquPAPeRSJx3Xk5IthS5+8n
 rMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QYtpOlYvTmaTz/rTSiP40/2b6Ro3+t4u0+kcRJFaMkU=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=I0pVcicb6pLui88iZ8P1liwaljd63nzOOgybuuLYoi0H8kwJ9nkhtVN7Ebckcw4SXa
 0Xkh23K4qrIcgX8QhwdnWNnbXaCLajbKgwOZ3LKFfSukPPJJkwZa27rbbO7UROhJAQf2
 8v2oGcd5X+MqNkqr1qEp1OhWLzbII28Zuefga7X18ccMuy0acF4KCsSZrFjQKZD3z7HL
 K9YeLtMlnl1Jsc7PTH3GnIzOs2PIPCOXqJXYicZVaTxn5xGjqQ7vtjh2EliEZ++da07E
 /7rzhe4vQm3OfWtcI3Gvoi4NxVAd9YiCWq/aPsom2VvV5V6bPW6UDDqhYJfyzmCDOxmB
 2Qcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773137306; x=1773742106; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYtpOlYvTmaTz/rTSiP40/2b6Ro3+t4u0+kcRJFaMkU=;
 b=niK3rwTXEXvCgfHQ0cdekOV9SvbIFMgUrmd47CB8kklULinzahZoybdO+nS26ri8y7
 V9nkjaU/lhmgYu7OcV12JwkexWpv6LZqeWJo1QkSDpRbcdRXPRB1knwwA/5Sv5isiiY8
 a5n4EdA7XonCm8hxzseVpozug6ZgM1p4ClZOSNuFs8xKEX0fuMrUvk+ZmPzNtjhQVfYJ
 64JoF4Tqr32Yp2EG7jKWqV7hBHAJo+4innSHVLhCFWoskCGYV4VLXP8qj5Bne0q6B4cO
 DaYxAAb/A+G5LDX73kHJyeuNp03rxY/OewrivuE9SfbxXq7cVY+p+3zadqR4UxEOHgX+
 /8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773137306; x=1773742106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QYtpOlYvTmaTz/rTSiP40/2b6Ro3+t4u0+kcRJFaMkU=;
 b=qxYEL8FDRvBUQk+xV4Kfmw10o1p/ZDa8riK3Xlnlh9z16mHTK1gGf9piqvQ0kgxZxK
 fYKLLLI3+80LXNs9Xz7AVv2gzTeX4sSZAl5QlECXFFTsXMsFud/JGdB2rIvDH9pMgr78
 bI4j4rlAKTMFS2Dh5dDdaCR0n7tRxSXIn9B67d9SaphW+jqwDk3LgXVd2TMYJ/7HM6E6
 pJ6xHZOpVAQnT1Zh452obouE4tHR9LYI2YI5A0GtKTLocXnvWeijmrQPLBZr7ipMqA1s
 hUcWpIleqUnOVaUidT2helYURMyN3QqAq5gnz8PLjIDDO2tY4FRbj0cEWXJqVKQfY33j
 sW/A==
X-Gm-Message-State: AOJu0YzHZStwI5vaKLKnwedLTtrQ6bp41aUCMsYMERxIOH3xWymkfiWs
 xeRA2vfPSUGYz7sMfHseytFAM77NpuxJfQDQrj7anmKk1ya7H7pmN982y97F04ZFDJ/Lzw3KO6A
 EHGldiHhx+fKAgkWcXGale6r8RuIwU7s=
X-Gm-Gg: ATEYQzyJKPwlHe49/+ghIfm5N1YOe91efoJBP8IvrWcSGo+UNhceEFzLLytcnFXgj0i
 f6DUm37Upl+0iP1wJzZJNtCoP/WNEOa/H6WbDcjSxjRzzidoYr1q7snaczUm1r80cG8mY1Vir6l
 Y8acwWaf0ebUNLjwLuQpP0MkawgmOA17aLetUrRf8l7bZ7o+CsQMTe5LlLPKAKoB8jRWz01T6EC
 PFzTSifKPYoZH3BbMAPJH21pZT+AGkJS23mUUxGSt2XqzOx4eYLyQFpSBfuzV956o05vxyaaGTk
 RxzavNc=
X-Received: by 2002:a05:6402:50d4:b0:661:98c6:5e11 with SMTP id
 4fb4d7f45d1cf-6619d5384aemr7292050a12.31.1773137305508; Tue, 10 Mar 2026
 03:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-7-zhangckid@gmail.com>
 <20260309082720.GE39949@fedora>
In-Reply-To: <20260309082720.GE39949@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 10 Mar 2026 18:07:49 +0800
X-Gm-Features: AaiRm516UJa0G3DEGv3AmfGXqfumR2RDVFTKaNOlRbF6rnJb4txg-GLz7-OmNKA
Message-ID: <CAK3tnvJshj9rMrnYJo+XTyuRQ=BqrtLiYfKbxrEd_dQpC+ugeQ@mail.gmail.com>
Subject: Re: [PATCH V5 06/13] virtio: use iothread_get/put_aio_context for
 thread pinning
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52f.google.com
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

On Mon, Mar 9, 2026 at 4:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Mar 05, 2026 at 10:24:52PM +0800, Zhang Chen wrote:
> > Refactor virtio-blk and virtio-scsi to use the new iothread_get/put
> > APIs for AioContext management. This ensures IOThread references
> > are tracked via the device's canonical QOM path.
> >
> > Summary of changes:
> > - Lift 'path' scope to cover both vq_mapping and single iothread cases.
> > - Replace raw object_ref/unref with iothread_get/put_aio_context.
> > - Ensure consistent memory cleanup of the QOM path string.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  hw/block/virtio-blk.c           | 17 ++++++-----------
> >  hw/scsi/virtio-scsi-dataplane.c | 18 +++++++-----------
> >  2 files changed, 13 insertions(+), 22 deletions(-)
> >
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index b6f74df68f..94a70c6212 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1429,6 +1429,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIO=
Block *s, Error **errp)
> >      VirtIOBlkConf *conf =3D &s->conf;
> >      BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> >      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> > +    char *path =3D object_get_canonical_path(OBJECT(vdev));
> >
> >      if (conf->iothread && conf->iothread_vq_mapping_list) {
> >          error_setg(errp,
>
> There is a memory leak when this returns false. Please use g_autofree
> when declaring temporary string variables instead of calling g_free()
> manually.

Sure.

Thanks
Chen


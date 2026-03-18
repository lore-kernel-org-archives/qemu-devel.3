Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D91103E173
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2qwf-0001SQ-1O; Wed, 18 Mar 2026 09:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w2quv-0000Sd-EO
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:26:36 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w2qut-0005c4-Md
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:26:33 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-661cfb9f3aaso10122857a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 06:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773840389; cv=none;
 d=google.com; s=arc-20240605;
 b=F9Om+4n4TZMjhH7z8QxRifVyiqeE/R8WG56smaQPJLG7zy8qdHOgv8vzZQm+fJejNr
 qz9GEc7lqn2sQbO7khrhuSYCai2h+wTD6MtTFzGIUSgrvNE+wA8Ska1NsAGfWky60dHa
 tLopb04QzSaNCn5ybl9S7IJf/06u+Vc12MBApVSo9ZxJFRPSzYFkS7ktL50H60qlZRhl
 U29emOdAeyAs7yFSuFsyV5NikxPp8jx0JDnvI+u9QRWyFWluhS/aixDUKloGG/eMgmHD
 6x88BtDOD3soPFPYGj33AVR/dcFAbJW1zJJ8df2dAZDiOkI6BYWc+yO5i9WRGDg4ZJtS
 SVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WRWiTz/6+qlR+xnRzuNo43U8uvidEDfeVm/ThRDH1nQ=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=bkKMeHHax3cnHzHl7uWmDBwHWzv3PC/v0xqT6JoX7wPyTXuHRTVxZN2FzqT4an/xV5
 ae+cQEF24ZE1zkUR2SLqjTO10UZ9FqGnuk9qyK3GdYkJUpr2tOvzrXBI1U8BQt0pIf1z
 Zmf/9hkVaJ8VPTRYv68YaJ4uMUa0rcgx38plG0Dv243vQCADiV0G32heDY5aJlXol40B
 CRcSyH+CctnflSFIz5aGn1BjGCHQ/tVRAdB52uJZz5eZDbOpYiAzJF0UNX2Tr1BtDp9M
 YKgUYoaNqy0XcDCRkPwqpwA8gXI+NwFIiuQlpwl7FHhsrQjo7KGtgrapc+Ht7vwsYqTy
 NGVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773840389; x=1774445189; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRWiTz/6+qlR+xnRzuNo43U8uvidEDfeVm/ThRDH1nQ=;
 b=gt4qZC8RWj5CB/O2Qz+5eztHSyy9niqLy9zBj4/QzuE0cxl5qgbPIJ8equQ5s79a+t
 6y44iUQHr6s17RPydUHfKs8vZqC6/z7xewID8MBt5UFd6B1ptzZH5PwZMO1haP4JfEJi
 0r9j8aWp//Jc36fnjUChhdonu1tDDYclG2Rj+rlgF7tor34jCYyuk1lgbbmI8E2oOk0r
 mi2dBnLkbbpL5b+w4jSO1bPYtTa/TsTI4dpNAWx3ZgHA3i7pvaXFHXq89M1ueAGP89K/
 HhvmA8VfCj9y4JydYvGU4omTsicbuKz76qUzVHMdvP5Z5CKJFbB4SiJa0c+EWakgxAbJ
 cFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773840389; x=1774445189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WRWiTz/6+qlR+xnRzuNo43U8uvidEDfeVm/ThRDH1nQ=;
 b=ZyvTT/3FasULWAI/tY1xMKPgDSsZqR5gIn4suvv/hzxCH4t/vnbj6dayA6jRVMLMey
 XNHyjYr78twXuiwiEZVdMGY/qnHssuOlU0tdStl/wvhtqJ0lK8iF4ybS98CK2VxJ8EK4
 Gb1O4DrzBoPrLagJV2vKgfsG2aBE5st4aZ9fAWTE0Aw0V9w+tOBWOGVXrwc8C37A0Pm6
 qFXcgg1lCiyrx/s7rvTGTs1YHa6ADIIJOEjfxiE0P9awlSfjpNrBmAsCvebEJN+Dn0tZ
 2TefheAuVqunbO7wk0T8vE8m4h8rjgcgYG3IArLkEvprtDQiKSFPBToFCJ5nUjSwzj9w
 /cFA==
X-Gm-Message-State: AOJu0YxCubbliDFnYKzzfVXGoJkmeVFb2RJiLBBIZFGiHIlT6CP2KcAJ
 rkmIuj+Z0yueqzwltXaoFTyK4yGSPQqUwZ4fXaD/nQodK24ALGfzeYTDHtDYaT3Wt4nP1EgeIy4
 RJwPhFqRdIGefKbJK6sA9BiiRj8fYLMRK0olUn3LMxQ==
X-Gm-Gg: ATEYQzyTE4IEAgtYb4YkMxX8Uj3bXPgqdg5ac1E7OW4TZXxMjv+PH4/rjcO4Zdtb48r
 ixHk7MiWGRyhix1INtrc7yb0UCL8px6RVvG0Vd0oRPh5rEZGEDgr0A2e10zL2IDJT+UYbSElm/v
 FOe/oGPu1bgs0d5cb2AdoTVGW3oSCSLwAWL4t+nnSuWU/YLrdgBGRwiz6CtpJ6aCjdmHCdDGGkd
 lb4+CIu9kcfTG4iQYO2vmR9V3AI9mojgGKDD3lRbnaRseerRacgF6WSMjiPyXGDIUWiq3L5SlSI
 43nRpzVk
X-Received: by 2002:a17:907:1004:b0:b8e:796a:fd5c with SMTP id
 a640c23a62f3a-b97f4a78843mr145913766b.27.1773840388774; Wed, 18 Mar 2026
 06:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-14-zhangckid@gmail.com>
 <87o6klfz3e.fsf@pond.sub.org>
In-Reply-To: <87o6klfz3e.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 18 Mar 2026 21:25:46 +0800
X-Gm-Features: AaiRm52Z96PVNwPAqlvdgR_SOxgblHaCZ-U8nU78BCgo9lSO7Z1ZrNB1FNrI5SU
Message-ID: <CAK3tnvLyCkc6__O8c6SB=vNk0gn5m=8_jMGUzO1AxkNBAuJJ=g@mail.gmail.com>
Subject: Re: [PATCH V5 13/13] qapi: examine IOThread attachment status via
 query-iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52e.google.com
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

On Wed, Mar 18, 2026 at 2:09=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Extend the 'IOThreadInfo' structure to include attachment metrics.
> > This allows users to monitor the associated devices by identify them
> > by their QOM paths.
> >
> > New fields added to IOThreadInfo:
> > - @holders: A string containing of QOM paths for the attached devices.
> >
> > These fields are also exposed via the Human Monitor Interface (HMP)
> > command 'info iothreads' to assist with manual debugging and
> > performance tuning.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> [...]
>
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 1f5062df2a..a381074c04 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -76,6 +76,15 @@
> >  #
> >  # @thread-id: ID of the underlying host thread
> >  #
> > +# @holders: The parameter is an array of QOM paths indicating how many
> > +#     active devices are currently associated with this iothread
> > +#     (e.g. virtio-blk).  In hotplug scenarios, users can
> > +#     pre-allocate multiple iothread objects to serve as a persistent
> > +#     thread pool.  When a device is hot-unplugged, the corresponding
> > +#     IOThread is released but remains available, allowing subsequent
> > +#     hot-plugged devices to attach to and reuse the existing thread.
> > +#     Returns empty if no devices are attached.  (since 11.0)
>
> Let me try to polish this a bit:
>
>    # @holders: QOM paths of the devices currently associated with this
>    #     iothread.  Users can pre-allocate multiple iothread objects to
>    #     serve as a persistent thread pool.  When a device is
>    #     hot-unplugged, it is detached from its iothread, but the
>    #     iothread remains available, allowing future hot-plugged devices
>    #     to attach to it.
>
> > +#
> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >  #     disabled (since 2.9)
> >  #
> > @@ -93,6 +102,7 @@
> >  { 'struct': 'IOThreadInfo',
> >    'data': {'id': 'str',
> >             'thread-id': 'int',
> > +           'holders': ['str'],
> >             'poll-max-ns': 'int',
> >             'poll-grow': 'int',
> >             'poll-shrink': 'int',
> > @@ -118,6 +128,8 @@
> >  #              {
> >  #                 "id":"iothread0",
> >  #                 "thread-id":3134,
> > +#                 "holders":["/machine/peripheral/blk1/virtio-backend"=
,
> > +#                            "/machine/peripheral/blk0/virtio-backend"=
],
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
> > @@ -126,6 +138,7 @@
> >  #              {
> >  #                 "id":"iothread1",
> >  #                 "thread-id":3135,
> > +#                 "holders":["/machine/peripheral/blk2/virtio-backend"=
],
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
>
> With a bit of doc polish:
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thank you for your suggestion, I will update it next version.

Thanks
Chen

>


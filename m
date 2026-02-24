Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1DFEFB7EA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 02:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuiOU-0007Wh-I6; Mon, 23 Feb 2026 21:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vuiOS-0007WW-U5
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 21:43:24 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vuiOQ-0005JW-9I
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 21:43:24 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65be78011c8so6874939a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 18:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771900999; cv=none;
 d=google.com; s=arc-20240605;
 b=CUnYsyX3ILtCCLXT0oczPPK5JOm2xzksJjdCP+KP9IdLv4M2+6yC5ySZsaWmI/dmVf
 26t0bu+rz400ttUROyjrr5IxEnrjwOCxA3rpBL4hfEWpGbnbV/9nv1vh6050nkeWARUa
 f4zgTr0hoLtpqRQQ/wqdQoXX3YT2JtFRWFfoORDBhvvXAANNpWoNB6ZrUGDqfadITW7g
 EWDfZ8cXHbHOS53g28LcK9Br1l1p83B7GfnrWv1feVfMCpX021QgGdEe9nu9qSIlh5sm
 gNe8JNsJHLa7vzZgCsNB0E68f+CCgVsU/qFX7mdtXiPdlrblL+fzDkQ8IJN36FAWNPv6
 /s6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=afNVBl3XrVTLOD+fEl7GE2dkMy82gTpmhi08/NSzHhk=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=j31IZjjYAf+cMSTvWP2VNQNcSuR3p8TZuPCuHu2a2lN78PvcsxAo0C9fSIva31MXem
 pt5p+Z2w0fac9h/FzcjI9jtOxwtPDbi6tB0FVH5r96jzWWk4ryeZovqqDym6wtEZxyyG
 2lualVX5ZOfCckrJKkHGk/G0j11ZtElDYnAqbMGm+xY5GoKu38Xx10hvW1SA5RafuhSY
 ssHmPO+GxJSGeC2/wHxaWhJ1eD+GbpTu+FPyasPbKBWPl4AftOhoNxeiwmSNefy2Wfyw
 OWLS/TFsJhZIn931HyhYbSJGGNfwgRZAeDzqIdM2Nb0t9i2ym04iLw4Uyw2LjHq6FFUK
 P69w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771900999; x=1772505799; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afNVBl3XrVTLOD+fEl7GE2dkMy82gTpmhi08/NSzHhk=;
 b=Tns6/qSEGmEA3tulus0yzFOKB49lL3LWu3cuJGqPk+1yE0ZWpukXGDUJjOs7wHdjZL
 FDAqWe9YEC8y3T6JnbBXMkCvHdjX1QpAoOdl2e3sL2p6lPK/6Irs1eacXvQWYO6wOJL4
 ytJ/GYlxunkkbH1+oDmc9QRxJtJprUhsSNTUBTXO1aXxdY13LjQFqSzMLuzfQeAiOstL
 Ea68/5cTiVaeuXo+tq+Crb4AS2g2wmb4CXloMZ0Ba/sUUGy4DGKvnDL6jy7zr0y8VY8g
 15bB5KXPvbbVGmvU1d4GtLI+FOY+JR6S9J7cxTcd//CzFF3mEQQ9u5dg/bkVFFTMEZaS
 uqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771900999; x=1772505799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=afNVBl3XrVTLOD+fEl7GE2dkMy82gTpmhi08/NSzHhk=;
 b=kTF8TRylwzPaEfTMu2UXXEqS0PDoNsfWHvslr9iMJSJkYo10jbgHYiUqiZGdWjb+uU
 ENZBR1/PXrsp4EtviJhjSRxtVgZaUtEDmyaoj7YN+7JeL/flprCzAhMrzx9Bcr5GewHW
 dg95uXEchkuh8oXwwMuNK+9qD+sOfBhRCY5y82QOanpWwX5ZsokADpX6qQzJgIo3A4rr
 N7LHh7FM0flk8gcm6ttsVTJLWGIR+LOC8dNs7A/B3bvCFY3tZwHn3fXdkuSBW4+S+WC6
 JdPpAyHFQBSAkLff2QUymFEWHPm2EnQTYW8EwjitY15YOqcWBcnUlLxTycfmVoZ7uJji
 VBjQ==
X-Gm-Message-State: AOJu0Yx6COSFtWgIcqfgdKo8VdXsUtt+F37c08quqGN0Je9rXiYdYQNg
 K7vcDuMxhZNb6h7Vk44MnMX+Vbwyg/wRe+UCT6UBgumY5XwJlrHBAre2RpBUnsKdhINuSq8PMBH
 7WcTkNsYJRXRC5j0liZIHulIoVJzG7b0=
X-Gm-Gg: ATEYQzwIMYFzW9MUWHl6YL+bGpNFe3FOnKW9VeCJ3JnpzHhDgh/5guteQ83mrdtpZgq
 rg7LGcBgFFIKYNo1vI88vN1DcJpezgyu1J5EJ/2fzXoVt37TCdJzc2cZ+hukPjU6F4yx4UMdYz0
 6LvjVLLdZGU4ZW3egctq6ES641sXswg2a/kmmF4NYeVBo3GVJHPxufzJAejhvBZEGoq+LC5Uw5O
 oaG+xfVsLio+LzF7OMRS+zJodAEF8ygvfWI7k0gaFdrC2gC6/tz7euCApWIYEC6PqQJGaP7hRZp
 r8gv7XA=
X-Received: by 2002:a05:6402:5189:b0:65c:354e:94f0 with SMTP id
 4fb4d7f45d1cf-65ea4ee7aa1mr6114445a12.8.1771900998958; Mon, 23 Feb 2026
 18:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-4-zhangckid@gmail.com>
 <87wm0bq047.fsf@pond.sub.org>
In-Reply-To: <87wm0bq047.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 24 Feb 2026 10:42:42 +0800
X-Gm-Features: AaiRm53nzclE7tYyzUX9fykz8uY-v2FG95vWPxTikaGxQGz2Xc4aJTZRrJARur8
Message-ID: <CAK3tnvKEJSDMVC4bkEbhfsVXpp7nVbq+Kue9fFVmOrd5f_ugCg@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] qapi: examine IOThread attachment status via
 query-iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52d.google.com
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

On Tue, Feb 17, 2026 at 3:51=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Extend the 'IOThreadInfo' structure to include attachment metrics.
> > This allows users to monitor how many devices are associated with
> > a specific IOThread and identify them by their QOM paths.
> >
> > New fields added to IOThreadInfo:
> > - @attached-cnt: An integer representing the number of devices
> >   currently using this IOThread's AioContext.
> > - @attached-dev: A string containing a delimited list ("|") of
> >   QOM paths for the attached devices.
> >
> > These fields are also exposed via the Human Monitor Interface (HMP)
> > command 'info iothreads' to assist with manual debugging and
> > performance tuning.
> >
> > Example QMP output:
> > {
> >     "id": "iothread0",
> >     "thread-id": 3134,
> >     "attached-cnt": 2,
> >     "attached-dev": "/machine/peripheral/blk1/virtio-backend | /machine=
/peripheral/blk0/virtio-backend",
> >     ...
> > }
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> [...]
>
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 1f5062df2a..ca53638684 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -76,6 +76,19 @@
> >  #
> >  # @thread-id: ID of the underlying host thread
> >  #
> > +# @attached-cnt: The parameter is a counter indicating how many
> > +#     active devices are currently associated with this iothread
> > +#     (e.g. virtio-blk).  In hotplug scenarios, users can
> > +#     pre-allocate multiple iothread objects to serve as a persistent
> > +#     thread pool.  When a device is hot-unplugged, the corresponding
> > +#     IOThread is released but remains available, allowing subsequent
> > +#     hot-plugged devices to attach to and reuse the existing thread.
> > +#     (since 11.0)
> > +#
> > +# @attached-dev: A list of QOM paths for the devices currently
> > +#     associated with this IOThread, delimited by " | ".
> > +#     Returns "none" if no devices are attached. (since 11.0)
>
> QAPI schema design maxim: do not encode structured data as strings.
> @attached-devs should be an array of QOM paths instead.

OK, will fix in next version.

>
> Unless I misunderstand your docs, @attached-cnt is the number of QOM
> paths in @attached-dev, i.e. @attached-dev is redundant.  If this is the
> case, drop it.  If it isn't, educate me :)

As Stefan's comments, I try to address more specific needs:
https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg01892.html


>
> We generally avoid abbreviations in the QAPI schema: @attached-count,
> @attached-devices.
>
> > +#
> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >  #     disabled (since 2.9)
> >  #
> > @@ -93,6 +106,8 @@
> >  { 'struct': 'IOThreadInfo',
> >    'data': {'id': 'str',
> >             'thread-id': 'int',
> > +           'attached-cnt': 'int',
> > +           'attached-dev': 'str',
> >             'poll-max-ns': 'int',
> >             'poll-grow': 'int',
> >             'poll-shrink': 'int',
> > @@ -118,6 +133,8 @@
> >  #              {
> >  #                 "id":"iothread0",
> >  #                 "thread-id":3134,
> > +#                 "attached-cnt":2,
> > +#                 "attached-dev":/machine/peripheral/blk1/virtio-backe=
nd | /machine/peripheral/blk0/virtio-backend,
>
> Once again, the example is syntactically incorrect (the value lacks
> double quotes), and once again I recommend to create example I/O by
> actually running a test.  Getting tired of this, to be frank.

Sorry for that again. Will fix in next version.
And I tested this series before send the mail like this:

(qemu) info iothreads
iothread2:
  thread_id=3D434428
  attached-cnt=3D0
  attached-dev=3Dnone
  poll-max-ns=3D32768
  poll-grow=3D0
  poll-shrink=3D0
  aio-max-batch=3D0
iothread1:
  thread_id=3D434427
  attached-cnt=3D2
  attached-dev=3D/machine/peripheral/blk1/virtio-backend |
/machine/peripheral/blk0/virtio-backend
  poll-max-ns=3D32768
  poll-grow=3D0
  poll-shrink=3D0
  aio-max-batch=3D0


>
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
> > @@ -126,6 +143,8 @@
> >  #              {
> >  #                 "id":"iothread1",
> >  #                 "thread-id":3135,
> > +#                 "attached-cnt":1,
> > +#                 "attached-dev":/machine/peripheral/blk3/virtio-backe=
nd,
>
> Likewise.

Thanks
Chen

>
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
>


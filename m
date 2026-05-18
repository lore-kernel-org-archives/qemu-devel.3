Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7E8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOy20-0000ZK-Oz; Mon, 18 May 2026 09:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wOy1n-0000Ul-Mh
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:29:05 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wOy1l-0008T3-Gk
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:29:02 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd56d108454so476028366b.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 06:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779110937; cv=none;
 d=google.com; s=arc-20240605;
 b=hcbVUjD2vk6lw63Lqei9YiTRZRu6Hk9SMtAFi/1smamvKdugivEKQZAbOB7Z5m0FP4
 PIOq/PuKYJOPlBR4iEQjtPfVXglK2AVMgMeQm3f4JQOzoTiGde23uMZGplIV1Mzg0SH+
 +iwo+gcOS5rTM7V3IiYYu+H0UhbxsTw11saolEf/FWoMipUIi2k6rNesbJeVYj6Q0dTm
 Y4AowOctjsNFGn/jiFLu5FDRGswMXLc8xGZpoTkO+fj6es5WGH3giPHF64VGkfrzMHfV
 eVXlaJgNdSnB+gHNUPgkAsisximkF2QQghImsnEadOC+ek1S3BVS25wLKDY5xKb/iDmU
 L8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GYk3QCxg1O8ove6bRI0GXRiTL44V5Je4+LlOZx1gLMk=;
 fh=7PAGYePiWMAzNDEHCierLJ5smNrit7DBDzKUifdtY24=;
 b=V+TJ2X6BGsXa79K/fX/x/ZcqH1M8M1Nlk2IREYUmv8EzqTZLj20bIioUJ9H8qnMJgv
 FxvEhvfPrSpUeCVxLd7ohZ2yrSIGQes3M7QXJKGTY4iXdRY+0F9BaeYQ9zjwuGPUChLq
 lOmbWYheDvWy8r8K363DmWcGcpD8yWHI4RMcObSVR80uB3qXIuBfpXph9kGbkPbGx5vt
 5zVXiBN+DEfJGgTMB2EUFAzY3EEbT+Y+0Mv+t+k//xRiYVO3zKlSDkxSrZF2ZdI0AocI
 Sxn4NCIfcPSJYaT5IkFiDh8wT7WUY3sB+Zcnx1zkZNqKzxfDQUQVzRotlLAPF3HpqCSS
 TbPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779110937; x=1779715737; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYk3QCxg1O8ove6bRI0GXRiTL44V5Je4+LlOZx1gLMk=;
 b=DYZLo7qNAPLJbqop7hj5gDFT/I8aJ+qmp//KBwy2Ll92wUS3M3A8e+reK62UxANrIk
 t3xRbLdhp1pwSQtKRSgJms1TJMi0an2zYsw/9W/qfmhKD9Pl9J3At/H9bj7aN0P3tQOF
 AnEIjus/zxdFUoZ5GbYt6tHjGr0XvFRzecDec/tDRXRTWxi/e91jVAYAZ0Rz80NjB51q
 svZA8pc7x4BVUA9MpuU49iMFXOuPu6+ktodw0JqQF/0Cj9fGlnDXZjO/+NkGaFQ4qQr+
 yLBLInuNmxyPimGJe1Fx4hIBhH5PFV3mi9zTF4946zjFFat3AK9ucVjtXFOJDsWJf1/y
 jstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779110937; x=1779715737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GYk3QCxg1O8ove6bRI0GXRiTL44V5Je4+LlOZx1gLMk=;
 b=HYJ5jLTnFRrOq/4KOttTNOdtc5KeHg31NtTosog7WGOV+RQNJc8Ul037XnBXBQOPbX
 u5j/SunL1+6ESU6TcUEGdtigI3NLR6Zf8CZjh3cUhsFGvxK9V1dP6tZ7NoE22YUK8Cje
 ZQdRqRrlfN6RjuVpns1sFI4+1mxUtCzKun73jCQcDiqHQ9FkaJBmFtMVhBfCz1NzHNW9
 JMZIYPzu+ps7whIlhAsWqqB5tTXxVZky3nNBmz/YQn9/Z6c0g+hhMVSYDq3CMTE9du2x
 KpgJb2LDEOLAJ9PE07uGLvbAI/W5s9CsrBFNymRJbKginNA2YQx7QxYvsykDCwYRDY42
 RuMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ULU4PdGJzoILsp7ekEdNaii9wWOpHbThg7uG5ipmGM5IiX/tJS/bJRKBaLFLcIWiIOrAYWzIRETg/@nongnu.org
X-Gm-Message-State: AOJu0YwaYiSHRCe64jh+v2iz8WZ5ohX2p/bHRXjSK3SK6PH7Xk7dou6o
 puA9cKdWTQsYZHEmyIR6p29sfj6/z9fKQ1ydd8hJObpsv3rpiOzRkMiDl+DF4IJPY69SNK1tXgd
 OK48jF5JZUBe3vhmvpIf0tYiczz4CeZ8=
X-Gm-Gg: Acq92OH1/08hpf+n7u8kDnuUQYucFloxN1N2LhVkB5+PVVsVaiaHVdJrMiDpY3eUVLr
 wNYlKugMqCPvip3KhSfWx8m1tr8SXSrN9mQIj78WIxvdNIQ25kvfwJ4OQTG/CtGxUizsEWhigzG
 jzaSdVdh7nCx5SOijXnqgo0Jj0iYYrxFHdfU4JE+7RG4zFmeupigxAFo/fDHneO7gbFHboxHSYu
 RSTRVUiwkioH6YnQHYRlbMMOKqCGARyqLKprL7I/UO7dP/WjVldAwriaFeBznqv+5uvbRxuOWUp
 kkl+xEwl
X-Received: by 2002:a17:907:9491:b0:bd5:2a57:d8cb with SMTP id
 a640c23a62f3a-bd52a57d8damr646016966b.38.1779110937039; Mon, 18 May 2026
 06:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-3-zhangckid@gmail.com>
 <20260511181425.GD536999@fedora> <87y0hhsze0.fsf@pond.sub.org>
In-Reply-To: <87y0hhsze0.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 18 May 2026 21:28:19 +0800
X-Gm-Features: AVHnY4IElVtfnBusynLUzQ2ykNBHXoukRqu3TaIcQ59Z6eY7KCfKMUmRoW0Q2Ko
Message-ID: <CAK3tnvKfGCj1Y0fVkv4iks5-LieOtRSHOPhfFS3uuv-K4Eqx-Q@mail.gmail.com>
Subject: Re: [PATCH V7 02/14] iothread: introduce iothread_ref/unref to track
 attached devices
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x636.google.com
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

On Mon, May 18, 2026 at 7:58=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
> > On Mon, May 11, 2026 at 10:04:04PM +0800, Zhang Chen wrote:
> >> Currently, IOThreads do not maintain a record of which devices are
> >> associated with them. This makes it difficult to monitor the
> >> workload distribution of IOThreads, especially in complex
> >> hotplug scenarios involving multiple virtio-blk or virtio-scsi devices=
.
> >>
> >> This patch introduces a reference counting and tracking mechanism
> >> within the IOThread object:
> >>
> >> - iothread_ref(): Prepends the device's QOM path to a list.
> >> - iothread_unref(): Searches for the device path using a custom
> >>   string comparison (g_strcmp0), releases the associated memory
> >>   upon a successful match.
> >> - holders: A GList storing the QOM paths of attached devices
> >>   for runtime introspection.
> >>
> >> A later commit will add QMP commands to let management applications
> >> query the attachment status of IOThreads.
> >>
> >> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> ---
> >>  include/system/iothread.h |  5 +++
> >>  iothread.c                | 67 ++++++++++++++++++++++++++++++++++++++=
+
> >>  qapi/misc.json            | 48 ++++++++++++++++++++++++++++
> >>  3 files changed, 120 insertions(+)
> >>
> >> diff --git a/include/system/iothread.h b/include/system/iothread.h
> >> index a1ef7696cb..2871b06edc 100644
> >> --- a/include/system/iothread.h
> >> +++ b/include/system/iothread.h
> >> @@ -50,6 +50,11 @@ struct IOThread {
> >>      bool stopping;              /* has iothread_stop() been called? *=
/
> >>      bool running;               /* should iothread_run() continue? */
> >>      int thread_id;
> >> +    /*
> >> +     * The list elements are of type IoThreadHolder, which can
> >> +     * represent either a QOM path or a block node name.
> >> +     */
> >> +    GList *holders;
> >>
> >>      /* AioContext poll parameters */
> >>      int64_t poll_max_ns;
> >> diff --git a/iothread.c b/iothread.c
> >> index 3558535b40..b805e4f97d 100644
> >> --- a/iothread.c
> >> +++ b/iothread.c
> >> @@ -25,6 +25,66 @@
> >>  #include "qemu/rcu.h"
> >>  #include "qemu/main-loop.h"
> >>
> >> +/*
> >> + * Add the @holder path to the iothread's tracking list.
> >> + * The @holder is a QOM path if it starts with '/', else a block node=
 name.
> >> + */
> >
> > It would be cleaner to use IoThreadHolder in the iothread_ref() and
> > iothread_unref() APIs instead of a string:
> >
> >   static void iothread_ref(IOThread *iothread, const IoThreadHolder *ho=
lder);
> >   static void iothread_unref(IOThread *iothread, const IoThreadHolder *=
holder);
> >
> > That way the caller already uses IO_THREAD_HOLDER_KIND_QOM_OBJECT or
> > IO_THREAD_HOLDER_KIND_BLOCK_NODE to clearly distinguish QOM paths from
> > block node names. No string parsing is necessary.
>
> Exactly.
>

Please double-check the details:

We need every caller init its own IOThreadHolder then pass to the
AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
const IoThreadHolder *holder)

Like this:
IOThreadHolder holder =3D {
             .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
             .u.qom_object.data =3D (char *)virtio_blk_path,
};

new_context =3D iothread_ref_and_get_aio_context(iothread, &holder);


Thanks
Chen


> [...]
>


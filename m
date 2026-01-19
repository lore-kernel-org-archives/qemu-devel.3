Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5762DCCF2EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhnWn-0002He-Un; Mon, 19 Jan 2026 06:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vhnWm-0002EM-Lr
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vhnWk-0004Cj-FD
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768822472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7TxcPdLQ2LcqoJG9uEAdRE5KHhictaYqL39i6pRHmM=;
 b=aMQSbMiaFbayevTJsDByv011PIu4Ma+OTHdeG+w8TgvW4WguxrlEvgbT7aIAjaddN7ExdY
 l+MOPVzcc8Vcs7kvggGWvNmWidxmrRcVBdbUs8HKeIJ8+uqitPs8Mi3xOdbxU470SoP15x
 4FLDuOGtjiYpiEhvdsMfnhbKziBtqIo=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-bhg1QAhBPrC6CL01H7PGNg-1; Mon, 19 Jan 2026 06:34:31 -0500
X-MC-Unique: bhg1QAhBPrC6CL01H7PGNg-1
X-Mimecast-MFC-AGG-ID: bhg1QAhBPrC6CL01H7PGNg_1768822470
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-64558391a78so5563142d50.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:34:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768822470; cv=none;
 d=google.com; s=arc-20240605;
 b=ME1mj05PeZcxSXjGiEmYauwTvKTXXis2keUrDEPgO3sOJNgyCaZtwswgY4YkmL1afP
 peGOYBjCNCRs0prXpOJ3CTPlpKaIg2LB4pgoIVLtQE74baTxGBcUqm9MJsKEybrzER1G
 u4inDzPdO6QxHJDY4U8hih069ZNeJtBk8HS65tGODcjSHyXAEWHXvpxZFkMUcMNAcy3x
 UnlNyDiZKty5m1ugQ8YOAo/uKHVUMwKB9uqEn2bZn6NwuMko+jtXZbymR6rzXc46XjEC
 ymETlVGrLigjDKEhqhBFnBi5Dq46K30Uv/qidvEDhcd/GqodOof8svoXuqa/2QJWvtmZ
 mfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :disposition-notification-to:in-reply-to:references:mime-version
 :dkim-signature;
 bh=o7TxcPdLQ2LcqoJG9uEAdRE5KHhictaYqL39i6pRHmM=;
 fh=SCla5qwtivMsa9WuGACYFmsiD8ZAou9vajHYlsGjyaE=;
 b=VYELmX1KtlO7vj2FW+x3C06tnQn14DevkcfUznNQpWFHP02mg0OfSo1COt0XvqKJ5K
 kAZG9Co8h5UqbFxvS7U5KChyiCXk2vXImfpOb4d5jhZ40fHbyZGWBLZmjNBBZrPI7jIb
 E+RV6uQLkUPvdxcDdVqOF3kVNqhXALukhnvQXvh+dFwQWBUSgsG8jx/5ZvNN/XRiv0+B
 3bFoRJnjNNkFlhOpToFI5ENRA1Zhww0mBJcuMqHYYU+O/hmBwcJoF0HBbB0OPwrtAFST
 SBTXrDPKVVDHoKt1+XUFpjf/cyjThYz9X+wruZsRpJX/Mzi81KIPlkD5q4Sao2ShdB0q
 Plww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768822470; x=1769427270; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :disposition-notification-to:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o7TxcPdLQ2LcqoJG9uEAdRE5KHhictaYqL39i6pRHmM=;
 b=VZRm7zEbK8sEqNkKilCpLBKpxxXhww04FYNMrqwuF2cCHcuejGWnkIN/4yGEb1R8D8
 UHAOcUj8eMvFzolg5GZTz/TV9h2vh4ZpnMxKOE7WB9nWBVVM5kJGo2ot3VHRJ4P3yp5A
 kUBQ9gKK8orQpJwTimUNG7njqvGVgjf/4w9LPWgb25sbvUVFzhummXcU/u06/W4buGn+
 Tp89cu/kn0oH+qq196rwDSNyC18ZbIUnH/CXJmNQ3e1Cm97msFJ6NT7dpNHHPZrCMmKi
 nx8hwDsx8PbpFG8Ws+xuSkAiilvxaC6MMXHVCyb8Xla+7MdYJ2ftuXjGCoBcNI2i0snA
 /plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768822470; x=1769427270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :disposition-notification-to:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7TxcPdLQ2LcqoJG9uEAdRE5KHhictaYqL39i6pRHmM=;
 b=N74gvgdSE+eWyLszG4puDM4ZLI1oNL0skBdKSchD/vcs0p/M4eW4F2mYosmXQjUENO
 xR9JR8EvvuCpjxYndawjQPfCqMJ/SHlqJRaVn5kokilF5U0YMaLFfORTIRR7gBoAqWVs
 mpH+m2brC6YU6bu+XJw7esHPQDxxJWSbBE4/vYJt1+VVGjidphZoXyPeV/1uGa3E+/HL
 T8CAnj7z4n0Xwv7wp+tYfjXzRQm6K5NCvpselAGF3JstwrKtgWbNfkTgsg5ZAoWpltPl
 IMbVt8PKiT95a2q0LH6qtR755K2q2o3kjZ9uaVU5ohOzOHvB0eytDjB6Y4SvhYjOgBdp
 MLfw==
X-Gm-Message-State: AOJu0Yy6E2gJroeSf6DQS9RKAQ2Oyj8yVp8Ym+NSs2E0WMGfmynBjv7W
 Ztja8XY0AF38h86SsovENqx/ixyJJl2/+4CDUkIyWIgRGGmAmha4EwZI89WqyeyksXXFghN6/om
 Out+5RJ6jXom7SkW3Qi5K4nQl2ngmrz3fFLg4UZJN+wPu4WVu6jNQWT4+ZFskELm1zAwWLWEERW
 62QR04iAb2gXMj+gDCwrYl1r9snmaJBOg=
X-Gm-Gg: AZuq6aJe+yLBuVeSQjavqs0Kufo6OVIxINz8IwJnR1Lh7/5/BGeJqhMSIFsrxSmw+SZ
 vCVf2DTVQA6fcXekluB3HmIv8ugP7nJLyz5mvQJfuNonuBrQAoif5vNm09rCu1nSKsqVEoPNak0
 5sQaQAj756ZRQkVGzvKoa6KOW8j1Idg7p42rc39P6tNXgGYnYO6xG+LDtGC6EGAQ==
X-Received: by 2002:a05:690e:148b:b0:63f:9fbd:6e8c with SMTP id
 956f58d0204a3-649164d2b44mr8656906d50.48.1768822470409; 
 Mon, 19 Jan 2026 03:34:30 -0800 (PST)
X-Received: by 2002:a05:690e:148b:b0:63f:9fbd:6e8c with SMTP id
 956f58d0204a3-649164d2b44mr8656881d50.48.1768822470044; Mon, 19 Jan 2026
 03:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-6-aesteve@redhat.com>
 <CADSE00+24EjXdRMDXXf7tgWLaH2gqeDhL_OeRbmZQ2e8JULPXA@mail.gmail.com>
 <20260116055716-mutt-send-email-mst@kernel.org>
 <CADSE00+AOpy2JNPvZ_DFGR8pJ=-4iiYdb-5Mh_LAnLusjBDyQA@mail.gmail.com>
In-Reply-To: <CADSE00+AOpy2JNPvZ_DFGR8pJ=-4iiYdb-5Mh_LAnLusjBDyQA@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 19 Jan 2026 12:34:19 +0100
X-Gm-Features: AZwV_QhjTaZ_ib0U5u0VkKOGD69qbjo6fU9SdA2M4UqzxnqMqchk9I0sFDSOADc
Message-ID: <CADSE00+HphD568RSejK7pPFgCif52jcZU9QAXWL05cLpeKOa+g@mail.gmail.com>
Subject: Re: [PATCH v11 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com, manos.pitsidianakis@linaro.org, 
 slp@redhat.com, stefanha@redhat.com, Fabiano Rosas <farosas@suse.de>,
 jasowang@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, hi@alyssa.is,
 stevensd@chromium.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 16, 2026 at 2:04=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Fri, Jan 16, 2026 at 12:15=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >
> > On Fri, Jan 16, 2026 at 11:20:25AM +0100, Albert Esteve wrote:
> > > On Tue, Nov 11, 2025 at 10:11=E2=80=AFAM Albert Esteve <aesteve@redha=
t.com> wrote:
> > > >
> > > > Add GET_SHMEM_CONFIG vhost-user frontend
> > > > message to the spec documentation.
> > > >
> > > > Reviewed-by: Alyssa Ross <hi@alyssa.is>
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > ---
> > > >  docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 39 insertions(+)
> > > >
> > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.=
rst
> > > > index 6c1d66d7d3..6a1ecd7f48 100644
> > > > --- a/docs/interop/vhost-user.rst
> > > > +++ b/docs/interop/vhost-user.rst
> > > > @@ -371,6 +371,20 @@ MMAP request
> > > >    - 0: Pages are mapped read-only
> > > >    - 1: Pages are mapped read-write
> > > >
> > > > +VIRTIO Shared Memory Region configuration
> > > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > +
> > > > ++-------------+---------+------------+----+--------------+
> > > > +| num regions | padding | mem size 0 | .. | mem size 255 |
> > > > ++-------------+---------+------------+----+--------------+
> > > > +
> > > > +:num regions: a 32-bit number of regions
> > > > +
> > > > +:padding: 32-bit
> > > > +
> > > > +:mem size: contains ``num regions`` 64-bit fields representing the=
 size of each
> > > > +           VIRTIO Shared Memory Region
> > > > +
> > >
> > > When implementing this for rust-vmm, the mem size came up a bit
> > > confusing. In the last patch (7/7) of this series, the implementation
> > > uses `num regions` as a count for the number of valid regions (thus
> > > accounting for gaps in the shmem region mapping). Thus, `mem size` ha=
s
> > > this confusing statement saying that it containers `num regions`
> > > fields. It should say it contains 256 fields (it is only sent once
> > > during initialization, so no need to save bytes here), with only `num
> > > regions` that are valid (i.e., greater than 0). Maybe it could even
> > > discard the `num regions` field, and send only the full array.
> > > Thoughts?
> >
> > Let's discuss the exact wording here.
> > I'm not sure why would we need this padding sending unused fields
> > though. Waste no, need not?
>
> What about something like this:
>
> +:mem size: an array of 256 64-bit fields representing the size of each
> +          VIRTIO Shared Memory Region. ``num regions`` specifies the
> +          number of valid regions (non-zero size). The array index
> +          corresponds to the shared memory ID (shmid).

Just to be clear, I'd favour this change, which only entails a minor
clarification on these lines. The rest of the series, including
implementation and structures, remain unchanged.

>
> If you are suggesting removing the num regions+padding field, then the
> description could be further simplified to:
>
> +:mem size: an array of 256 64-bit fields representing the size of each
> +          VIRTIO Shared Memory Region. The array index corresponds
> +          to the shared memory ID (shmid).
>
>
>
>
> >
> > > As much as I wanted this series merged, this deserves a clarification=
.
> > > So I can either send a new version of the series or split the last
> > > three patches into a different series. Hopefully it only requires one
> > > more version though.
> > >
> > >
> > > >  C structure
> > > >  -----------
> > > >
> > > > @@ -397,6 +411,7 @@ In QEMU the vhost-user message is implemented w=
ith the following struct:
> > > >            VhostUserShared object;
> > > >            VhostUserTransferDeviceState transfer_state;
> > > >            VhostUserMMap mmap;
> > > > +          VhostUserShMemConfig shmem;
> > > >        };
> > > >    } QEMU_PACKED VhostUserMsg;
> > > >
> > > > @@ -1761,6 +1776,30 @@ Front-end message types
> > > >    Using this function requires prior negotiation of the
> > > >    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
> > > >
> > > > +``VHOST_USER_GET_SHMEM_CONFIG``
> > > > +  :id: 44
> > > > +  :equivalent ioctl: N/A
> > > > +  :request payload: N/A
> > > > +  :reply payload: ``struct VhostUserShMemConfig``
> > > > +
> > > > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has be=
en
> > > > +  successfully negotiated, this message can be submitted by the fr=
ont-end
> > > > +  to gather the VIRTIO Shared Memory Region configuration. The bac=
k-end will
> > > > +  respond with the number of VIRTIO Shared Memory Regions it requi=
res, and
> > > > +  each shared memory region size in an array. The shared memory ID=
s are
> > > > +  represented by the array index. The information returned shall c=
omply
> > > > +  with the following rules:
> > > > +
> > > > +  * The shared information will remain valid and unchanged for the=
 entire
> > > > +    lifetime of the connection.
> > > > +
> > > > +  * The Shared Memory Region size must be a multiple of the page s=
ize
> > > > +    supported by mmap(2).
> > > > +
> > > > +  * The size may be 0 if the region is unused. This can happen whe=
n the
> > > > +    device does not support an optional feature but does support a=
 feature
> > > > +    that uses a higher shmid.
> > > > +
> > > >  Back-end message types
> > > >  ----------------------
> > > >
> > > > --
> > > > 2.49.0
> > > >
> >



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C88C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 04:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulgDT-00033A-Jb; Tue, 12 Aug 2025 00:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ulgDO-00032m-GZ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ulgDH-00031a-7F
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 00:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754971329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRTrwSGXyrjIZheRvCWfz8F8zyNfNizbz9FnUbX1mzU=;
 b=OqLAI1qE+huOP9AtF6w68Qx+P4cGdu4a1YvXPdBxGjDeZtLDEgDTxZXQ8ZoVvTiten2CQF
 ztTKaLrwBugAeJlVKJZ5obckvSlebRuo2OJmLFt3UAbyAxL0+hsDHo9Rv2XignB0vet1WR
 hwm60MuV/4J3CkiKUt7p1zkfH5vM2vs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-lhD4D3qqPZOA1iW-8LhRrQ-1; Tue, 12 Aug 2025 00:02:07 -0400
X-MC-Unique: lhD4D3qqPZOA1iW-8LhRrQ-1
X-Mimecast-MFC-AGG-ID: lhD4D3qqPZOA1iW-8LhRrQ_1754971326
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b46ed24bc6bso858213a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 21:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754971326; x=1755576126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRTrwSGXyrjIZheRvCWfz8F8zyNfNizbz9FnUbX1mzU=;
 b=HTUaDcKOCmjgQ4k0asvP0lFKJvKgpbcRuoA+TQWaNksMGIfRG3N/S17Z/kiqpivhpW
 xTlqEPJgAsIQxerbWwUJcndxCcPyY/qoNxU5WtxHaQFSp+sepuJ5Oe8qKlR4jbOgC8sy
 baq3TlNKO1eexWE52/XwYkBODXHhPMrUwCSubbBdWaf+8xw9tucvoY1TKeGOvAN+GL6Q
 1sT8NfENvbOK2z0VyFx/8dXulmNn1Qf+ozqQi2/tZrWpnsLf+mKhdzG5bLaorIsrQu9U
 QcK9mRscMBsIaaa/encJStEAckuYBX71pv1uu38R6WjoewVIYkVEJQ3AxNdh00w2Vq2+
 2RFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt8M7TbF6SQ/qm9OFOrFETy/KaJqnq2WZTpMByY805UMRtNlu5eq0uRcHgpB7EUpmzuHsCh9d6s4ro@nongnu.org
X-Gm-Message-State: AOJu0YwFox0pL17O0IcYPaf7ATS8JQ1C1SWdbT+Bfan6Lw0+jMHt3XC4
 4yCqFYv8x5mO5Z72kb7gg+JT3MeCO5GokHWZhac8ajbqKNQVlT0kwWJtN61NHyq025OUBssqXm4
 HnPB8hIuT+l36xIZXeUTydVRmqdrbpkDSghqh2vMsrysQTAw4A1Ba/mvhEgbWHWyYjJ8lwOELIK
 ZZzrfILKjbIR46t3/yeKEcqdsKWMaLFnI=
X-Gm-Gg: ASbGncsb60/Bma4KEXBmITiKlQXMD6R48SiQYVbkz3JerSsAZv8D4A8MabamyJn7hST
 qbWbY37fsGLo9oL6fIHrFhijphaMUe3tXstXNGv9+V+6z83C/BuARcWj4J7QudkRxpNrqG52Qz4
 qnfGBDeQos/LQ+AlbtCEsOFUA=
X-Received: by 2002:a17:90b:314e:b0:321:2407:3ced with SMTP id
 98e67ed59e1d1-32183e6d92fmr20501069a91.28.1754971325989; 
 Mon, 11 Aug 2025 21:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs+aOrCV/WucFogsap5FwGg2pD04312vycW3y2xxyJeAGPB2mTMCYWB0GQhMhUND+GNJ/49ZpSuyjieUjVUcI=
X-Received: by 2002:a17:90b:314e:b0:321:2407:3ced with SMTP id
 98e67ed59e1d1-32183e6d92fmr20501018a91.28.1754971325431; Mon, 11 Aug 2025
 21:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1753297661.git.pabeni@redhat.com>
 <8e8a91adcbf4e37c7a5e086780e1000d3b3298d3.1753297661.git.pabeni@redhat.com>
 <de3c69a8-d874-44a3-bd47-91b6b298e184@rsg.ci.i.u-tokyo.ac.jp>
 <7c7c3f2c-e643-46ad-810c-aefdd486ad78@redhat.com>
 <8e3c5aa3-3180-4df2-b378-18e3e91d3f80@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8e3c5aa3-3180-4df2-b378-18e3e91d3f80@rsg.ci.i.u-tokyo.ac.jp>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Aug 2025 12:01:54 +0800
X-Gm-Features: Ac12FXwkaq25YPDI6B_3iNPdha_fKg9R4CoMeyNQf28Thr2bzdPszyNyU8zb6gY
Message-ID: <CACGkMEse8cM8=8y4JwBdVQi23buz1OCzhQmVxvsRJGdQ9tgaWA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 07/14] virtio-pci: implement support for extended
 features
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 8, 2025 at 12:55=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/08/08 5:18, Paolo Abeni wrote:
> > On 7/26/25 1:52 PM, Akihiko Odaki wrote:
> >> On 2025/07/24 4:31, Paolo Abeni wrote:
> >>> @@ -1477,6 +1509,13 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *pro=
xy,
> >>>        return virtio_pci_add_mem_cap(proxy, &cap.cap);
> >>>    }
> >>>
> >>> +static int virtio_pci_select_max(const VirtIODevice *vdev)
> >>> +{
> >>> +    return virtio_features_use_ex(vdev->host_features_ex) ?
> >>> +           VIRTIO_FEATURES_NU32S :
> >>> +           2;
> >>
> >> This function could be simplified by replacing VIRTIO_FEATURES_NU32S
> >> without any functional difference:

Did you mean using VIRTIO_FEATURES_NU32S instead?

> >>
> >> 1. For writes: virtio_set_features_ex() already ignores extended
> >> features when !virtio_features_use_ex(vdev->host_features_ex)
> >> 2. For reads: When !virtio_features_use_ex(vdev->host_features_ex), th=
e
> >> upper bits of host_features_ex are zero, and guest_features upper bits
> >> remain zero (since they can't be set per point 1)

I think it depends on the compatibility work which hasn't been done in
this series.

> >>
> >> So the conditional logic is redundant here.

See below

> >
> > This is to satisfy a request from Jason:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05291.html
> > https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05423.html
> >
> > I agree there will not be functional differences always accessing the
> > full space, but the guest could still be able to notice, i.e. the
> > extended space will be zeroed on read with that patched qemu and
> > untouched by the current code and this patch. To be on the safe side I
> > think it would be better to avoid such difference, as suggested by Jaso=
n.
> >
> > Does the above make sense to you?
>
> By functional, I meant the functionality of QEMU, visible to the guest,
> rather than the whole system including the guest, visible to the end
> user. The guest cannot notice the difference because the extended space
> is zero on read even without the conditional, which is described as
> point 2 in the previous email.

I'm not sure I understand this correctly. But it doesn't harm here consider=
:

1) it's the entry point from the guest, checking and failing early is
better than depending on the low layer functions
2) we have checks in several layers (both virtio-pci and virtio core).

And it looks like a must for at least GF:

    case VIRTIO_PCI_COMMON_GF:
        if (proxy->gfselect < virtio_pci_select_max(vdev)) {
            uint64_t features[VIRTIO_FEATURES_NU64S];
            int i;

            proxy->guest_features[proxy->gfselect] =3D val;

Thanks

>
>  > 2. For reads: When !virtio_features_use_ex(vdev->host_features_ex),
>  > the upper bits of host_features_ex are zero, and guest_features upper
>  > bits remain zero (since they can't be set per point 1)
>
> Regards,
> Akihiko Odaki
>



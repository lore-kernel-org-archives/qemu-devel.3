Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C819EEF3717
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzW3h-0003j0-2i; Mon, 09 Mar 2026 04:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzW3a-0003iE-48
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzW3Y-0006bR-MH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773045219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yRpy0R83R5GSuWeJUfF/mQmikeGvTD/69x9wjn7IDA=;
 b=iuvz9DEXgPPKv9zel4BqT2Zz71Vk9H+K8XA7JcP+x7yVCwXIdFdYOrtVmWpkolw9KYR1C0
 WAXcx39iKFruK/H6x3M9tBBBL3IpNtpsjmuj4GxplQ5v/06y5qpHncH+rBRQ9uPSFNB+5J
 7zCazJKYUqHl/gs5S2b4Vyglo9KbDSo=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-WZoojhnhOmW52079Tl-f0Q-1; Mon, 09 Mar 2026 04:33:38 -0400
X-MC-Unique: WZoojhnhOmW52079Tl-f0Q-1
X-Mimecast-MFC-AGG-ID: WZoojhnhOmW52079Tl-f0Q_1773045218
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-64adb64a043so15743612d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 01:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773045218; cv=none;
 d=google.com; s=arc-20240605;
 b=lX+E91ohWr/r7/3pF8l9EURyUVVpF1uq8X6ED8zfjJ/l5Wr2n14nEXo9PJTEYxMrhR
 NgUsMuclr4HPN3ovbMTU9zGpB4QYCCzyYCp9ElasjB+VEngkd8FbP3Fx9g8ZTaSUpT8P
 YvhuehB7EVA1x47RHy1Y4NLAfJIPFxTCl6bpqCzgyzrcbSgxwP0tFOumqBE5z4de/OBT
 uCXkumNzd1HKlao9Drazlf1Ldxjvuc+CXYKQFVPcnSMKbsUemxfe/6Wexbdq3Ym2+HAc
 BjDbC/LddbDgpModQrfLlwvt6EsUSTV+sGNHOXqLaHQI65eg6pDbyzDytzt5Gfoeo2/t
 NSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4yRpy0R83R5GSuWeJUfF/mQmikeGvTD/69x9wjn7IDA=;
 fh=fqzZqEnXBYYoaTLdPusSkjdikW0XdBorqTYeVjyZMQg=;
 b=NWqH6iANWMOFBZ6QIq7m8E/j0qu15HPQUNkdgb0XN2vOgUwKrkDDN36ljSgwqobqkS
 DnDCX5PsywiEN/cj6Bt7hlZZqZR0o3CaLfpKIPj0qDDg+gmHOdKrbGrdayi1eNoX/fdz
 w3YMTjLFvAkLcQTNFZzUTFUVW9PtfPIyfblniIkMmjoe+MZu7doymiTpcv+Y1Ij8gpZx
 18yhix35bzr8atBih3eyqT0DkouCro1b/81ma0SlZwn7Of+Fts5JyqbcGy16rXoT24dK
 O5czF06uPaZi4yJsQzZIBNmaBC4WvU/REK30wyvtgrXUbcniC6Voo7aA/BdZCnx4Pm07
 Rq8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773045218; x=1773650018; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yRpy0R83R5GSuWeJUfF/mQmikeGvTD/69x9wjn7IDA=;
 b=Uav1rbwgbB4C4gT6GDcxV5Ir70/i3qgFYv2FBocpAVwKCJZdDUIABw0QibWwwFINbZ
 ZWCD5o9ikgdYzKqbCJiYGZUkawXghkX1Pr0O34qgF7OdDugLHv0fBDqB1ZXG5RU7iVBy
 j8aEcg5jQ03Gdku7ceW4s2Yvoi4HVhhH5jGv34vLuqNoTpZfozKRtHtXvCNB5gj3uo1f
 dlPyuBU8aIWYFkZ3TP029bryybLnvNX+xn//BjezTyCv5vFbpBMXojsb1RabhHgdU3kD
 F/6ULWk/siudPPFVWuXRsNFQhWUfGt+Ucu8mqnxbEU6r6hXvybJ7WzX5mKuGqQt9Cfyz
 b3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773045218; x=1773650018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4yRpy0R83R5GSuWeJUfF/mQmikeGvTD/69x9wjn7IDA=;
 b=W1cKhAz5BtAnPgL8CbbKI9AebK6Vj73WziiN6Iq8Hl3Jv9UO14M0TJO+QSvpB8woL9
 0eMNG0DxdFYglQi44jW4d8DNpOqZ3fNUJME7O7dTLPlcc4Y5VEpubo+dE6POJqUqaNQq
 zHFZNTXR0Xt5mVZUCc2x7qXKGb63rBVdKoyU2lutNY9CuJ1jhKTShwH7FI/o2f1bSWij
 jlUdICABrz69R+4VU4qopFtPDiRbbp7YKuW5cP0A9ioTsCANenBW+on1fsqg0A6TMZ2Q
 KoV3sNcIKjZREqpEcMwv4v72nUsuvwWRUP3N/fXiB9FkpIb05QOi+u0D9IsftdmYISRw
 eRrg==
X-Gm-Message-State: AOJu0Yw7ZV3J6WIpmSOQmIKXrIMgmH9v6yia12y0w4Q/gZ2ecpFFGy9Y
 Zae+DfD7TDCJ6ljbh4xupa8CAnX4B/hlznYpAYKWggQ6qEXFOhUhse70QM0uO8n0kE2649vDeU6
 LwRuKthRFtjr24C7wHX98NzglkZgUX7kt2FcQiABcIa2tYFmM5t+rs3ipm08iHLAFPIM0UKFs5/
 4R3y1HUT4e4R3HC2Q1xgUkyXPQ/D7CEy4=
X-Gm-Gg: ATEYQzwAqurDE6P9vcXnpIDmmaJFnJxuOii0dDkeTKETcnreZn2XpzzhofV0z5HmvCb
 HlJpd+hw8eHdjt7zH1qsTCvAqGxF+94MpZXJ/xdNk1TOwHz+CsVOogwpyG9SrDfp+7SxUQ7owUh
 Wew+fgnwtUz2mog0/x61BiLJMW/rUcm/AlZi24OmkC5y5wYIkxKUplRkyMFlFyVluUkydrc50O0
 3IHjQ==
X-Received: by 2002:a05:690e:1907:b0:64a:de2a:e6f5 with SMTP id
 956f58d0204a3-64d140e1276mr9743224d50.21.1773045217934; 
 Mon, 09 Mar 2026 01:33:37 -0700 (PDT)
X-Received: by 2002:a05:690e:1907:b0:64a:de2a:e6f5 with SMTP id
 956f58d0204a3-64d140e1276mr9743203d50.21.1773045217540; Mon, 09 Mar 2026
 01:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173857.2705296-1-eperezma@redhat.com>
 <CACGkMEuykEy3Rt_oEw1kGLbvh5ZRv-fW-GFU3SN7qNWcc8mi5Q@mail.gmail.com>
In-Reply-To: <CACGkMEuykEy3Rt_oEw1kGLbvh5ZRv-fW-GFU3SN7qNWcc8mi5Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 9 Mar 2026 09:33:01 +0100
X-Gm-Features: AaiRm52ZJohBThwBeUzjiV0VYATaD7GIPA2rXdgqTN-ldlCTvgIEHSNUvNVwS24
Message-ID: <CAJaqyWfQEi6-snKd688V0CU9E=DNPXLk7z6Nzq53d45=KphFmQ@mail.gmail.com>
Subject: Re: [PATCH] net/vhost-vdpa: enable vqs before DRIVER_OK if no cvq
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 9, 2026 at 9:21=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Mar 5, 2026 at 1:39=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > VDUSE do not forward the enable message to the userland device at the
> > moment, leaving the dataplane disabled.  As there is no functional
> > difference if the device have no CVQ, enable them before DRIVER_OK in
> > that case.
> >
> > For devices with a control vq, keep the enabling of the dataplane after
> > CVQ so QEMU can restore the device configuration.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Fixes: 6c4825476a43 ("vdpa: move vhost_vdpa_set_vring_ready to the call=
er")
>
> Once we add cvq in the future, it looks like we need to bring this back?
>

Do you mean when we add CVQ in VDUSE? I'd prefer to handle this as a
patch independent from the vdpa backend, as I'm not sure if any other
device in the wild supports the current behavior.

Considering the conversations about adding this ioctl in vhost_vdpa,
and the patch vdpa_blk needed to restore ENABLE before DRIVER_OK, I
prefer to view this as "Restore the original QEMU behavior from before
introducing CVQ shadowing." This way, no device sees a breaking change
from previous QEMU versions or even standard VirtIO. In other words,
the behavior after merging this patch is guaranteed to be supported by
all the devices, but we have seen that some devices do not support the
initialization that happens in QEMU master.

But yes, the main use case I'm testing is VDUSE+DPDK.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAFFC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wobrg-0003qT-1E; Tue, 28 Jul 2026 03:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wobrc-0003q0-VS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:04:32 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wobrb-0003xF-7M
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:04:32 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso32273815ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 00:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785222269; cv=none;
 d=google.com; s=arc-20260327;
 b=Zsa/nVzLRK5svZfykRdCFTO6gVBd6MQmuGuwX4ETXUdYDQjNqJ2h1wd0AUH0Gy5yh8
 PGJ5RjbdGYeFrZVCjM25gSJB/J71IQO2w1s+8HNBwRNjDca/qlVc+IicQOPCjdgIMG+g
 aHnyHzsiwNezkKB0mBGyinfxAR5eFVBawg7IwFKWRaEI4b0gbS/ceKYWiWjnDwiCTJnN
 w19b6wi6RXCZXETV9qBr0Ee/CrqMfHtbKJahnaQU3EA15T41Ph8LVYufVMJy/qOiuSYC
 PmIsX0tfbFHelAmxRrEZntoDXdQG6RkaYTFdsJ5L0OQHaBqj64TqyrzUnA1zHao9FiXA
 LqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hp+8Ozl+RC1zjPFWO3nSYJyzsmOfMmGT7fXcZMHEWYg=;
 fh=TWRAAoZCm3M4LD17F0zGwps6A0QjDI6fltqLeiVJu+w=;
 b=g2BO/mFXbD1arEYGqQRol3Y1iuw+QHeABsWOvoz+ENH/n6GrQF83aoe/sjNPZenCF+
 gIIeCUY6rSgy9ZBNeRheFCN0iQveS9W5B/vQtnFPMqYd46S5DM6NmelmaV+1WVZpdA6S
 Zr2XhwLMfKvUqNxqMSMtCiZ9DOhBLSNEEkmw3+iHc4KH0RWOVwEp6kQ7rbUvwzox4xPk
 htFpLQNHAZmzgVFZGZC56YM16SVbvi9K3RamqoivuvT7W+csP35q8bxlLz6+OobEmFtN
 Js7ZUGyds/AYEKhdtbqV1kem7Kps3kyqkg1Uwhjlhy3vHvt3cVE5esNxFNEizWndzbPP
 antg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785222269; x=1785827069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hp+8Ozl+RC1zjPFWO3nSYJyzsmOfMmGT7fXcZMHEWYg=;
 b=Nju15btyKdBY+kXfOwv1RgH8H0fMRadF+4JW4DN9S51Jv6hQO8rcA6c9k3RxjzISvq
 0Yip/1DT7dLz5zn3rgU7JeCSmygb3MiRM6uu3izOsO1Zk3XcLoLsfuX9PCkmsJzrFk0g
 DU9lttMSbofn8MhSc/SVGJNASv8OQynWFNhFgLXoq51PBC5gvbwnZF0h+vDleRkm/BQj
 Nb+5k9MceEF0NuDgpNDmzxoitat3FvJ1q6ZOy0H+xCgkYG/GIPuC5XLy/0oR0ASBg+Bo
 cNmeFMaSAZbvoowfS+HcT+Mpz4h0zv8iHwJN/gkS1Lu8BkeRMmkh4TMiiyztdXOBDsuS
 C33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785222269; x=1785827069;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hp+8Ozl+RC1zjPFWO3nSYJyzsmOfMmGT7fXcZMHEWYg=;
 b=QeAE3vehm0q3ZPuzJVSmgblzoT2sch4sg+GCBslLaBW1KmNM0lb44lapAKh4hDmfqd
 4A6F/8izQH/8gr9dX/tS6u0lzpA3gybqdbVoB5HBMQ/tL0BEtt55YLeOUVtAyB/1J32b
 9OppBKExcNP5++kwOqO8EDV/ZL3pnI4PjxLPLewFyYNNEMjTQU+nZjc06huT5I1kPLet
 95BRaPgOAH/BWUv04N55lHT4w87C4pR409N7mLC1LEL7GXZC+gTn9RVbYACLMQDE4Rx7
 nJFoyWjO4hfoqKqs64d1kZ2ZR5WLtCCbWKW4nAbdkxClLJ9IKEbmAOK/j+cSW02+/fPL
 X8yQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2f0DAV9JYkUd4QjNWvgqiUGfA706K106ixe9foZWcer/k/46L7MVsQckMKLu2SjrRJaOJoVrHExf3@nongnu.org
X-Gm-Message-State: AOJu0YxTrgsvjVyIgrvzpRM50o9BeBVRFRdaPUXJprb4b84mdfocT5E8
 YaHpzgEPgsd8pCJypy8BAsnux/hHMau8iuXyQLkixKsLOkkOTkUHIsyykTZC6PnZDhC0LDcTscE
 dEOLWR98nvlrxZ+f/Xj324vwRhq92cmA=
X-Gm-Gg: AR+sD13XX6ZwZlS1tPs+0GW8lwMHYLxbc6Rli7SH0tI6Av5JMXu4643yoktgZaYPXKW
 FNa1EipperG6VWWtghx/PzCWtxSL5AheOvX1hnJvgdaxkSWUDr+IK9V39BVr/9iDerzqsO4fDIl
 Zr92dzdwwhZ7dhhpc5PaZVDRbzSCXuSSXgGdVNAoDS7SMl0hY+VGymfFzntE4ANqIC6YCtQJTpk
 xizEjOB+mZKM7QjOGjUVVnryIFSwx4AiFI1sk1hEZY5SI1crsgii0iMScouFHmHx0erjgqk1SCs
 P387XHe2EC8OWIwwYg==
X-Received: by 2002:a05:6a21:1f83:b0:3bf:6d96:ac40 with SMTP id
 adf61e73a8af0-3c8aafbdddcmr1682073637.12.1785222268908; Tue, 28 Jul 2026
 00:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-blob-v2-1-d0b9af38a975@rsg.ci.i.u-tokyo.ac.jp>
 <amclS3G5VTeZuP8Z@redhat.com>
 <5f437bad-2ca1-4960-8229-4a9e6107200f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5f437bad-2ca1-4960-8229-4a9e6107200f@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Jul 2026 11:04:16 +0400
X-Gm-Features: AUfX_myX-dCzkoAlEvwB8r3Sd_xyItniDFkxQvxdugVZFswplpk6yDMaTHlMCsw
Message-ID: <CAJ+F1CK3DKbjKUco_XLxgMFhvfqFXHnneM_ee3odf+hp5WHTrA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/display/virtio-gpu: Reject non-migratable large
 blobs
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x62e.google.com
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

Hi

On Tue, Jul 28, 2026 at 10:26=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/27 18:30, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Jul 27, 2026 at 06:23:25PM +0900, Akihiko Odaki wrote:
> >> The blob size is encoded as a 64-bit integer in the virtio protocol, b=
ut
> >> it is encoded as a 32-bit integer in the migration stream, and
> >> a large blob whose size cannot be expressed in a 32-bit integer will
> >> be corrupted after migration. Deny creating such large blobs.
> >
> > Is there a valid use case for such large blobs ?   If so, rather than
> > rejecting the blob, we could dynamically add a migration  blocker.
> > That would allow the valid use cases, while preventing the migration
> > problem.
>
> For the QEMU code path changed here, there should be no practical use
> case for a blob larger than 4 GiB. The non-virgl implementation uses
> blobs as scanout or cursor backing. Such a size is excessive for those us=
es.
>
> A dynamic migration blocker would also let the guest make an otherwise
> migratable VM non-migratable at runtime merely by creating such a
> resource. This could interfere with host-level VM management. So I think
> rejecting sizes that the current migration format cannot represent is
> better for now.

What's the difference? The dynamic blocker would simply happen earlier
or be queryable, no?

> If a concrete use case emerges, extending the migration format would be
> preferable to making migratability depend on guest-controlled state.
>
> Regards,
> Akihiko Odaki
>
> >
> >>
> >> Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsecti=
on")
> >> Fixes: 10b9ddbc83b9 ("Revert "virtio-gpu: block migration of VMs with =
blob=3Dtrue"")
> >> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> ---
> >> Changes in v2:
> >> - Add the Fixes: tag for f66767f75c9c.
> >> - Add a TODO to encode blob_size as 64 bits in virtio-gpu/blob
> >>    VMState version 2.
> >> - Link to v1: https://lore.kernel.org/qemu-devel/20260725-blob-v1-1-f6=
43fbd76398@rsg.ci.i.u-tokyo.ac.jp
> >> ---
> >>   hw/display/virtio-gpu.c | 15 +++++++++++++++
> >>   1 file changed, 15 insertions(+)
> >>
> >> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> >> index 718ba3039290..987b1b3ea860 100644
> >> --- a/hw/display/virtio-gpu.c
> >> +++ b/hw/display/virtio-gpu.c
> >> @@ -352,6 +352,14 @@ static void virtio_gpu_resource_create_blob(VirtI=
OGPU *g,
> >>           return;
> >>       }
> >>
> >> +    if (cblob.size > UINT32_MAX) {
> >> +        qemu_log_mask(LOG_GUEST_ERROR,
> >> +                      "%s: blob too large (%" PRIu64 "> %" PRIu32 ")\=
n",
> >> +                      __func__, cblob.size, UINT32_MAX);
> >> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> >> +        return;
> >> +    }
> >> +
> >>       if (virtio_gpu_find_resource(g, cblob.resource_id)) {
> >>           qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists =
%d\n",
> >>                         __func__, cblob.resource_id);
> >> @@ -1435,7 +1443,14 @@ static int virtio_gpu_blob_save(QEMUFile *f, vo=
id *opaque, size_t size,
> >>           }
> >>           assert(!res->image);
> >>           qemu_put_be32(f, res->resource_id);
> >> +
> >> +        /*
> >> +         * The migration stream encodes blob_size as a 32-bit integer=
 for
> >> +         * compatibility though virtio encodes it as a 64-bit integer=
. A newer
> >> +         * version of the migration stream should encode it as a 64-b=
it integer.
> >> +         */
> >>           qemu_put_be32(f, res->blob_size);
> >> +
> >>           qemu_put_be32(f, res->iov_cnt);
> >>           for (i =3D 0; i < res->iov_cnt; i++) {
> >>               qemu_put_be64(f, res->addrs[i]);
> >>
> >> ---
> >> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
> >> change-id: 20260725-blob-8a6a1a85601a
> >>
> >> Best regards,
> >> --
> >> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>
> >>
> >
> > With regards,
> > Daniel
>
>


--=20
Marc-Andr=C3=A9 Lureau


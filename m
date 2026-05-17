Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC44ACD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 21:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOiic-0005Za-OK; Sun, 17 May 2026 17:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wOiiW-0005Yo-KA
 for qemu-devel@nongnu.org; Sun, 17 May 2026 17:08:08 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wOiiU-0007Bl-NK
 for qemu-devel@nongnu.org; Sun, 17 May 2026 17:08:08 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c80167f56cdso507420a12.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 14:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779052085; cv=none;
 d=google.com; s=arc-20240605;
 b=QA8VRii1AMhnkMlPoMNzPT+T9vFXFhOs4ch4nlvf+HI5pYYxZleh6oJBErT7JXTBuu
 xhNRsvUsL39GmxHViP+oS7hnn9tfkqQf9NFnzoHSwJN3EjkUiMCIaXINfP2vij2sufUr
 oaeccr8z8wR/+ttFWHklHCy68R5yZCS/li1KP3Fk+sGfDdQ9tjD2mKX+mUOQYl47sBLR
 wJXLtL440rUeyxGVx1GiU3dBhyOMVRivPtC+Hycm7ACuk3ovWEhzMzK4OBWhzdmEL1oU
 MeH3kjBIXUaE+OCYp5PmpgL+E9NpD2VqwG/xHHyCUhe6ajG0+AcEw18kims739rPTuYX
 YHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AAMAc5V5ln8/O/jwy9RnlRqB0jUpihC6riHyTV7R2z0=;
 fh=16ROSnVJ/M0vRbjdNRcio4ye9tBpAiAozVgOoszGlKA=;
 b=LzzEyhcbcsJqP9NNbxbmOmie0tj+vSyyxQ49r0VNhGQB1w793KNUgya3MauBfyE0tM
 GtXpJcq5dTpCQPVaA1q9+ytP+vGWqZivXqrNUgySysgQ+9VOfudSOvKcTO8URCvaN2lC
 vJUXYBPilrtOurmNvRaKqKwKiaCdklafZrSaeW8IQXl2l5gRd5VXBPtZAacuFx6p3vVq
 jbiKm93jnPgy0tKZeaBoXZe8lck3YILxqlv0UwCyVRms8h6DYZmtGu/mxa5E5yWS6Qb4
 InJ0xtT15FhtLrOXfESpquB7Mss7m3QyLmso+rX5yVQWZfWhXrI0Ylt/DGJIjdv5ql8n
 tUuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779052085; x=1779656885; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAMAc5V5ln8/O/jwy9RnlRqB0jUpihC6riHyTV7R2z0=;
 b=QOhb7pmkQPRdHyfd1N7S+cQbXkksX7XRWNg4/c5BfE3v/nL7z4RPLQASX+HUnNhSUI
 0dwwaj/Zz/kFVlLoJDqRivLP/BNsqnvmS+JRPMLvwah+UrWgPHl3j+9+fKXWuediY9LD
 ZzpfTGyxwkFuztKAtX5ujp0rnIJfMgpU0CpyzjnivI69gxlp3bc+9xE4zOo4J+/R6gWE
 4QXpfpVr0bP6R5nB4SHKT1q0mG6QyIKA9rknoM3yBoG5IqCqiRVA9HkkkYqwAqD9Ds+7
 lmOqDuCsr6Ucl7EEp+xzlSPVLeZRV4MeZZSBk1L9GrEGx1pYCt8QMkmCyr1qPiXAUKve
 VU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779052085; x=1779656885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AAMAc5V5ln8/O/jwy9RnlRqB0jUpihC6riHyTV7R2z0=;
 b=JqLqxvKh/wHHp1sKx91HQL/SePzAdTL4nnv77OcmU1SOsJYNzOY9VGnnUiHTuXJZjY
 qyrmmlvHO6d4sEKjSk7HzPCqfsRbgbfKP+wJ/3RDWhMVcRnSIFdB60JYOdr9eIbnDNyD
 t9uQEiIrlAvwoxup85LKtEutjd0+fs40DPUPxi41YWEuIeT12nImmZMe0MfTWGqMcZ+7
 KOlqUBF7QTe/g91pPGUWCy7JLhFf8Tp6txxFOZP52CCVjGAvy1Nl3XdnvvbjwAtSQZPp
 BiIhARErgkCFlf8rVRqOa01rXbzQAUE9oYa+2JDeRc4O6pNgRfiFOKEzv9jMRZTnFSjC
 MPLA==
X-Gm-Message-State: AOJu0Yy1wKzCx4FjQySVG0jBoFLL++SLwppoRjm34bySxm0zarJX8J7n
 Cql7fhRsIjm7OOt50sXuZLZIApM8b0gG6iv/E6zcNCbzBcGfd6H7td1uz0c8G6xusikS7zl69yl
 S8Tg0MJtD8VRk+NLTShqTqxB2NQyOHqI=
X-Gm-Gg: Acq92OEYnVJ9w3XMhht14onCWKVB5kLRCCE/bqTrV63UgkEVax64kz+WFcD1IndK74K
 h5AgQuQJuOAYeSkpYtMohZzsbjj/eRnd+gYNp6oVyQrguvuLjU+zJ17cw7xj0R4DAkvBvwY35v7
 eWcOMmZ8DQ8B+9/GsF/aDsL4uEo4XrraaOGUdOpay9ws411JJVROhE3jdpdQlTfuVO5uJlneP13
 29aoTam/ApZqTIbHDyBiC/Gsfpg909ye2p2LWUo2YsZhk2Iiz9/GAu9ShbdX6XQJAtQkfXtd49u
 w5gMOA3hYcu1/ETxNb/5KEebZaWfXTmX/gK4Cp1faLgoNBOsfbAROq2VAtkIcJ1c93ZU36ra2w=
 =
X-Received: by 2002:a17:90b:3845:b0:368:763a:17b8 with SMTP id
 98e67ed59e1d1-36951889325mr12677066a91.2.1779052084612; Sun, 17 May 2026
 14:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-2-faithilikerun@gmail.com>
 <20260514184742.GB1535937@fedora>
In-Reply-To: <20260514184742.GB1535937@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Sun, 17 May 2026 23:07:38 +0200
X-Gm-Features: AVHnY4KoQABONWJ1oj74DpPSKJbVwJi2_1jm_J0xawnmLv9g-MI_yqlh4ByaszI
Message-ID: <CAAAx-8K4=7X0mybK7SOrX10kmx6ZsFHubtB0UJtJVkVyWaJczA@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] docs/qcow2: add the zoned format feature
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, dmitry.fomichev@wdc.com, 
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org,
 Markus Armbruster <armbru@redhat.com>, 
 qemu-block@nongnu.org, dlemoal@kernel.org, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=faithilikerun@gmail.com; helo=mail-pg1-x52b.google.com
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

On Thu, May 14, 2026 at 8:47=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sun, May 10, 2026 at 07:50:56PM +0200, Sam Li wrote:
> > Add the specs for the zoned format feature of the qcow2 driver.
> > The qcow2 file then can emulate real zoned devices, either passed
> > through by virtio-blk device or NVMe ZNS drive to the guest
> > given zoned information.
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  docs/system/qemu-block-drivers.rst.inc | 42 ++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)

Hi Stefan,

Thanks for reviewing!

> >
> > diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-=
block-drivers.rst.inc
> > index 384e95ba76..5066c943d5 100644
> > --- a/docs/system/qemu-block-drivers.rst.inc
> > +++ b/docs/system/qemu-block-drivers.rst.inc
> > @@ -172,6 +172,48 @@ This section describes each format and the options=
 that are supported for it.
> >      filename`` to check if the NOCOW flag is set or not (Capital 'C' i=
s
> >      NOCOW flag).
> >
> > +  .. option:: zone.mode
> > +    If this is set to ``host-managed``, the image is an emulated zoned
> > +    block device. This option is only valid to emulated zoned device f=
iles.
> > +
> > +  .. option:: zone.size
> > +
> > +    The size of a zone in bytes. The device is divided into zones of t=
his
> > +    size with the exception of the last zone, which may be smaller.
>
> This option is required when zone.mode=3Dhost-managed?
>
> It would be useful to indicate whether each option listed here is
> required or has a default value when absent.

Makes sense. I'll set the default to 256MB.

>
> > +
> > +  .. option:: zone.capacity
> > +
> > +    The initial capacity value, in bytes, for all zones. The capacity =
must
> > +    be less than or equal to zone size. If the last zone is smaller, t=
hen
> > +    its capacity is capped.
> > +
> > +    The zone capacity is per zone and may be different between zones i=
n real
> > +    devices. QCow2 sets all zones to the same capacity.
>
> This defaults to zone.size?

Yes.

>
> > +
> > +  .. option:: zone.conventional_zones
> > +
> > +    The number of conventional zones of the zoned device.
>
> This defaults to (size + size.size - 1) / zone.size?

Or just zero, meaning all zones are sequential write required.

>
> > +
> > +  .. option:: zone.max_active_zones
> > +
> > +    The limit of the zones with implicit open, explicit open or closed=
 state.
> > +
> > +    The max active zones must be less or equal to the number of SWR
> > +    (sequential write required) zones of the device.
>
> This defaults to (size + size.size - 1) / zone.size?

Or maybe zero, meaning no limit. Although it does have a limit lower
than nr_zones.

>
> > +
> > +  .. option:: zone.max_open_zones
> > +
> > +    The maximal allowed open zones. The max open zones must not be lar=
ger than
> > +    the max active zones.
> > +
> > +    If the limits of open zones or active zones are equal to the numbe=
r of
> > +    SWR zones, then it is the same as having no limits.
>
> This defaults to max_active_zones?

Yes, if max_active_zone is set, otherwise zero.

>
> > +  .. option:: zone.max_append_bytes
> > +
> > +    The number of bytes in a zone append request that can be issued to=
 the
> > +    device. It must be 512-byte aligned and less than the zone capacit=
y.
>
> Is there a default?

Yes, it can set to 64 KB.

>
> > +
> >  .. program:: image-formats
> >  .. option:: qed
> >
> > --
> > 2.43.0
> >


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C98BD1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vStXp-0001Nw-7Q; Tue, 09 Dec 2025 03:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vStXo-0001NR-4i
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:58:04 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vStXm-00048X-8f
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:58:03 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b73161849e1so186596966b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 00:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1765270680; x=1765875480; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOFX1Z6l99XREfWOCcHMWggSngsKq4Nug8xOFTfvHE8=;
 b=Wl46miTG4X0a9ldZJk5lkI4Wp+xQap6uvyFl7g+FDGee56XiOxYe2fRF1iL5ZU9dhP
 0avp84wtEfPy6rqcuozzM+BvLrXrLljus77vgKI9eeUoG2svJq9r7h5OkgkdMsOYERUI
 uv7yLllARt9jWM3Htjlffwioejbr+KcNOEAIgG2ruz7rskUSo5HBFyGBUQCmo+KbY7d5
 xoJcEm+MZLtL/1xYyE7jyXa1oCM9bI3YzBjDLPaH8P0rLZR1v2FvHTdmWezg2thwNQ8/
 8tj1xzaZMqODpdc5E59dVGAdEAiJ3uK4Nvkooa2T1w4uwAyv5GIACjRd8rcd27s/lW5D
 X//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765270680; x=1765875480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TOFX1Z6l99XREfWOCcHMWggSngsKq4Nug8xOFTfvHE8=;
 b=XZBodNrwjcnczpNmuVOQYVXRQb+mAKdjxXgCjOAv1jG/s3OCRc6mrUh+LH+AkP2VzX
 SIBlGimj9WuBBpkjknQX2kwAW+87yvlVz/C2hVuLQqgk+g8Qy/zrkRH5RJMe6Ap++bAd
 NNmrvYedo5rOyUsF0aC2LwWSg7OgmApyvNBy/5wCyGokRUYkvHeuZuCR2XtXFWAClIvZ
 otxBvaLBl4oSJuptZiVliPaYd/NiQo/paLduqvtb8mTIDeL7vKREQAJHlHAfRZUvuNQK
 jGpKdtDQbJMsV8mfv42PszzEujEgeiuZmoY5Gv4WTyC3fY8Xlxym8WJ87YNvI47kE1Lz
 Zd2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhuc50A/8Q0AYeH+lBZoLUlVXnCcxvXs9LMd7SCKEZ51mzg1TDerLCZbwreR2X3OzTPx423InfYZPO@nongnu.org
X-Gm-Message-State: AOJu0YxRVlsuu282d9FmIzvriLg4hz+XP6tSKQ9MT09hNnnCBIMZy6J3
 KhVOHKHc5MvrGJpimBCszNNglzlj8OW0FH7UqzSUQATSkLIAU/DOxt9E15YOesL04tKMtZRspwu
 iaPWYNMKQTyvbK3Jbu0ib5s3ZpLvEDeZcuGa4xL5uVyaU/ykr7n5G+OJt
X-Gm-Gg: ASbGncsxqhWzb06JG3FxV7vJRfmXCbapDJpoXSJaVHRhTIk69Xw7tKl5FgeqWcgMSEf
 YARM6pqP9CjpJkftNYQhHBb8Ae9BfJh15EBCjs6wd0tQ5UYeroDJcrIl9sJYVm694tPxHJrfrde
 oW9Fyk3jIbD8Am9dzSZzcjyzpVgfflmVjxHG67lYMJypWC8sxOeUngjbotrm4jZm7qoFw2uIiK5
 De/Qa30K20zarEt1pENt2JRaAXCOOj8p6PfuD4oPhvhhYXp6FqeUQZZoetSDGYgxYl11ZE=
X-Google-Smtp-Source: AGHT+IHg9iCteB7cN7mPSq9+0ku8rtxPDQzqfchxvouyVNo9iwTNcPIJLQ6WHEbEMLcv3tcIBQC3asm4D7sqq1IGHxc=
X-Received: by 2002:a17:907:96a2:b0:b76:3c91:68d with SMTP id
 a640c23a62f3a-b7a2477aba6mr1109096066b.33.1765270680019; Tue, 09 Dec 2025
 00:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20251127142417.710094-1-chigot@adacore.com>
 <20251127142417.710094-2-chigot@adacore.com>
 <baddb955-8a71-3f36-c5ce-c54ff15fdf8f@eik.bme.hu>
In-Reply-To: <baddb955-8a71-3f36-c5ce-c54ff15fdf8f@eik.bme.hu>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 9 Dec 2025 09:57:49 +0100
X-Gm-Features: AQt7F2odIU-qRBiDcaAsXjYFPF1B7GnkqveifLAx07PE5DiwmuXyQKzZS96Fo0I
Message-ID: <CAJ307EgA88-FOPvh0vZFpfOgzgX3GoPmvFPucb1WXAZKGgf0jQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] vvfat: introduce partitioned option
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x633.google.com
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

"

On Thu, Nov 27, 2025 at 3:40=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Thu, 27 Nov 2025, Cl=C3=A9ment Chigot wrote:
> > This option tells whether the volume should be partitioned or not. Its
> > default varies: true for hard disks and false for floppy. Its prime
> > effect is to prevent a master boot record (MBR) to be initialized.
> >
> > This is useful as some operating system (QNX, Rtems) don't
> > recognized FAT mounted disks (especially SD cards) if a MBR is present.
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > ---
> > block/vvfat.c        | 19 ++++++++++++++++---
> > qapi/block-core.json | 10 +++++++---
> > 2 files changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/block/vvfat.c b/block/vvfat.c
> > index 814796d918..dd0b3689c1 100644
> > --- a/block/vvfat.c
> > +++ b/block/vvfat.c
> > @@ -306,7 +306,8 @@ typedef struct BDRVVVFATState {
> >     array_t fat,directory,mapping;
> >     char volume_label[11];
> >
> > -    uint32_t offset_to_bootsector; /* 0 for floppy, 0x3f for disk */
> > +    /* 0x3f for partitioned disk, 0x0 otherwise */
> > +    uint32_t offset_to_bootsector;
> >
> >     unsigned int cluster_size;
> >     unsigned int sectors_per_cluster;
> > @@ -1082,6 +1083,11 @@ static QemuOptsList runtime_opts =3D {
> >             .type =3D QEMU_OPT_BOOL,
> >             .help =3D "Make the image writable",
> >         },
> > +        {
> > +            .name =3D "partitioned",
> > +            .type =3D QEMU_OPT_BOOL,
> > +            .help =3D "Do not add a Master Boot Record on this disk",
>
> Maybe should say "Add MBR to disk" and not "Do not add" as that's what
> true means now.
>
> > +        },
> >         { /* end of list */ }
> >     },
> > };
> > @@ -1138,7 +1144,7 @@ static int vvfat_open(BlockDriverState *bs, QDict=
 *options, int flags,
> > {
> >     BDRVVVFATState *s =3D bs->opaque;
> >     int cyls, heads, secs;
> > -    bool floppy;
> > +    bool floppy, partitioned;
> >     const char *dirname, *label;
> >     QemuOpts *opts;
> >     int ret;
> > @@ -1165,6 +1171,9 @@ static int vvfat_open(BlockDriverState *bs, QDict=
 *options, int flags,
> >     s->fat_type =3D qemu_opt_get_number(opts, "fat-type", 0);
> >     floppy =3D qemu_opt_get_bool(opts, "floppy", false);
> >
> > +    /* Hard disk are partitioned by default; floppy aren't.  */
>
> Singular plural mismatch. Either disks/floppies are/aren't or is/isn't
> when singular.
>
> > +    partitioned =3D qemu_opt_get_bool(opts, "partitioned", floppy ? fa=
lse : true);
> > +
> >     memset(s->volume_label, ' ', sizeof(s->volume_label));
> >     label =3D qemu_opt_get(opts, "label");
> >     if (label) {
> > @@ -1196,7 +1205,6 @@ static int vvfat_open(BlockDriverState *bs, QDict=
 *options, int flags,
> >         if (!s->fat_type) {
> >             s->fat_type =3D 16;
> >         }
> > -        s->offset_to_bootsector =3D 0x3f;
> >         cyls =3D s->fat_type =3D=3D 12 ? 64 : 1024;
> >         heads =3D 16;
> >         secs =3D 63;
> > @@ -1215,6 +1223,10 @@ static int vvfat_open(BlockDriverState *bs, QDic=
t *options, int flags,
> >         goto fail;
> >     }
> >
> > +    /* Reserver space for MBR */
> > +    if (partitioned) {
> > +        s->offset_to_bootsector =3D 0x3f;
> > +    }
> >
> >     s->bs =3D bs;
> >
> > @@ -3246,6 +3258,7 @@ static const char *const vvfat_strong_runtime_opt=
s[] =3D {
> >     "floppy",
> >     "label",
> >     "rw",
> > +    "partitioned",
>
> Does this also needs to be parsed in vvfat_parse_filename like other
> options seem to be?

It used to be the case, but I've removed that possibility in v3. This
"vvfat_parse_filename" looks like a "hack" to ease setting vvfat
options when instantiating such blocks through the format=3Draw.
However, options can still be passed using "file." prefix. For
example, "format=3Draw,file.partitioned=3Dfalse" will create an
unpartitioned vvfat block.
Overall, I think avoiding new options in the filename is a better
cleaner approach.

> >
> >     NULL
> > };
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index b82af74256..ca438fba51 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3464,8 +3464,8 @@
> > #
> > # @fat-type: FAT type: 12, 16 or 32
> > #
> > -# @floppy: whether to export a floppy image (true) or partitioned hard
> > -#     disk (false; default)
> > +# @floppy: whether to export a floppy image (true) or hard disk
> > +#     (false; default)
>
> I was wondering what does this option do now. It seems to restrict size t=
o
> different values, maybe that could be explained here.
>
> Regards,
> BALATON Zoltan
>
> > #
> > # @label: set the volume label, limited to 11 bytes.  FAT16 and FAT32
> > #     traditionally have some restrictions on labels, which are
> > @@ -3474,11 +3474,15 @@
> > #
> > # @rw: whether to allow write operations (default: false)
> > #
> > +# @partitioned: whether the volume will be partitioned;
> > +#     (default: true for hard disk, false for floppy)
> > +#     (since 10.2)
> > +#
> > # Since: 2.9
> > ##
> > { 'struct': 'BlockdevOptionsVVFAT',
> >   'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
> > -            '*label': 'str', '*rw': 'bool' } }
> > +            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool' } }
> >
> > ##
> > # @BlockdevOptionsGenericFormat:
> >


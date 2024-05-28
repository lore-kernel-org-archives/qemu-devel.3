Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB14C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1KK-0001Fl-Em; Tue, 28 May 2024 14:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1sC1KG-0001Ew-4V; Tue, 28 May 2024 14:13:33 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1sC1KE-0000yA-7R; Tue, 28 May 2024 14:13:31 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5b97539a4a5so581921eaf.2; 
 Tue, 28 May 2024 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716920007; x=1717524807; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyRt5V4g3q/kqhHWCvmKawIC6s5lIcuSHGvl2xidpWA=;
 b=YU5cai1WzDNvYUI2krVGRXzTt83D8DWN4SAHQHmLj6R8JuoeqDNWRG6RA8b2FwBe0y
 ZJIJLaxYUKqXUezHRJQFkU/bn8pWR7dZ+qsHG4xdpR8djZ8e0SXe9ma+1kOaL7FeQffw
 wY7OmJrYpUaLshgSMcJgHzb0NYrq2D6TzKDgI2k2gzWuGzsqC8O/dMUKLWxYyXDK/RQC
 31ih7W732Xs5uePrYNKMVbx3vXJ6z0UuzUsflAIZBk4HK9quJzovhZa0KDcOuty/Fzsj
 5a90K11WR12032UoofYri5/hv1Yd2ZsFdlzlK2/q4Ww/sHI9gI1/IrLcA/+Lw0y82ojL
 Ns5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716920007; x=1717524807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yyRt5V4g3q/kqhHWCvmKawIC6s5lIcuSHGvl2xidpWA=;
 b=dZjNFNzPBEUOVAlNk7Aa5yRbI03KRAXrWIE0Ujm/uy6LhyY8iv5DMV+5bCi2QCPRNt
 M0PZjlS9sP0SxBwjVIAR5Mpl+PZNiKt2THZnt3Xmz6U/mxdBULCtovre+9UymLV5ES43
 qyd9OO9+DDzL5bNFzVtfdcbgKVlcmFt2QbG+9XNhvL3BZ+DWBVFZ2rox8ABjqHSfiQRN
 5uFhX2eocr8KjWPJ8Kl1qD07DMYDnroS7PuqRyIlhjpbr9+IRrV5Dh8S3Cl9vFLHHoRD
 waLmX6THDxKtZg23PrTZdNsd2StvFfHImPtMWYDmETe0M4DqA7yM8WK7/hpoquPwhAmd
 Cvtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGUA1lpYIeYNpN+4fhmeK95oBwRjutGFCr4IHfwND7EyfOrm5teYt/vyBz0+SQYvMdhFj48NpDS+EwguPyXEbDujvnmTo=
X-Gm-Message-State: AOJu0YzTcxdHfWV3r56sLbDkD6+iNeCZh1XIxR/cDlm/AplAL/BHjmd8
 RWZ1NEkCTX0eXDKmA1UcPNKDRIh34li0ewe45glHb9MB25b8x5oYfcybEEbuLTVf7e3iYq4YPc4
 Drk5uvOsQ43NMTrak+TIgS66IgZU=
X-Google-Smtp-Source: AGHT+IFFlXc+lvUebJkGVW8aXd696ix8kHbYnd0aJK31jXkTppqOi7QW5gqV6tsbWGL9M0Wnzocli0jFSjtAC9/j4sY=
X-Received: by 2002:a05:6820:1ac5:b0:5b2:565b:b6de with SMTP id
 006d021491bc7-5b960499979mr12684531eaf.3.1716920007097; Tue, 28 May 2024
 11:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <8b639179-e567-469c-bd04-ee8dee12d7d2@gmail.com>
 <0e01a8e2-a543-4524-939c-05413fd99e86@gmail.com>
 <756f9dcb-4e9c-4c2f-bc8a-dcc7420a1839@gmail.com>
In-Reply-To: <756f9dcb-4e9c-4c2f-bc8a-dcc7420a1839@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 28 May 2024 20:13:15 +0200
Message-ID: <CAOi1vP8nJVsvvsmG5Ac4sd+9NPA8v8t=7Sao0f7-qNb129p=OA@mail.gmail.com>
Subject: Re: block snapshot issue with RBD
To: Jin Cao <jojing64@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, pl@kamp.de,
 hreitz@redhat.com, peterx@redhat.com, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=idryomov@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 9:06=E2=80=AFPM Jin Cao <jojing64@gmail.com> wrote:
>
> Supplementary info: VM is paused after "migrate" command. After being
> resumed with "cont", snapshot_delete_blkdev_internal works again, which
> is confusing, as disk snapshot generally recommend I/O is paused, and a
> frozen VM satisfy this requirement.

Hi Jin,

This doesn't seem to be related to RBD.  Given that the same error is
observed when using the RBD driver with the raw format, I would dig in
the direction of migration somehow "installing" the raw format (which
is on-disk compatible with the rbd format).

Also, did you mean to say "snapshot_blkdev_internal" instead of
"snapshot_delete_blkdev_internal" in both instances?

Thanks,

                Ilya

>
> --
> Sincerely
> Jin Cao
>
> On 5/27/24 10:56 AM, Jin Cao wrote:
> > CC block and migration related address.
> >
> > On 5/27/24 12:03 AM, Jin Cao wrote:
> >> Hi,
> >>
> >> I encountered RBD block snapshot issue after doing migration.
> >>
> >> Steps
> >> -----
> >>
> >> 1. Start QEMU with:
> >> ./qemu-system-x86_64 -name VM -machine q35 -accel kvm -cpu
> >> host,migratable=3Don -m 2G -boot menu=3Don,strict=3Don
> >> rbd:image/ubuntu-22.04-server-cloudimg-amd64.raw -net nic -net user
> >> -cdrom /home/my/path/of/cloud-init.iso -monitor stdio
> >>
> >> 2. Do block snapshot in monitor cmd: snapshot_delete_blkdev_internal.
> >> It works as expected: the snapshot is visable with command`rbd snap ls
> >> pool_name/image_name`.
> >>
> >> 3. Do pseudo migration with monitor cmd: migrate -d exec:cat>/tmp/vm.o=
ut
> >>
> >> 4. Do block snapshot again with snapshot_delete_blkdev_internal, then
> >> I get:
> >>     Error: Block format 'raw' used by device 'ide0-hd0' does not
> >> support internal snapshots
> >>
> >> I was hoping to do the second block snapshot successfully, and it
> >> feels abnormal the RBD block snapshot function is disrupted after
> >> migration.
> >>
> >> BTW, I get the same block snapshot error when I start QEMU with:
> >>      "-drive format=3Draw,file=3Drbd:pool_name/image_name"
> >>
> >> My questions is: how could I proceed with RBD block snapshot after the
> >> pseudo migration?


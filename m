Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FB9C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 22:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkYE-0000LD-KL; Sun, 04 Feb 2024 17:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWkYD-0000Kz-9R
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 17:01:21 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWkYB-0006a7-JL
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 17:01:21 -0500
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7c3de16761aso6094739f.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 14:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707084078; x=1707688878; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIPJCwgfVbGJx4lA6l5Q46GsogvtXUyIhhyVDGiT8j0=;
 b=awxG+SrmS43/DLVupUjY6stPYsgZQtkm4gPRqyUtYxL3KtEhHfYq+oPx7ZYS9s94sX
 AJDD3Vz3fLngpYO9INY4y7rDXKcywZ+zscqfm0bh4bIpzD6PwiCHv5GWDt9wCFqEmA/D
 cPfqlE06u2GeoRXYUcChiLPLFm3b8vcEw1raZIglPvTFAK/3j4RdSh1p7XeuXlTjTua8
 WLSfFPsh7Lc/VS6KqJi0lT/y5417hYoer+G+qku7j4VXv+oT0+xMNLO0Vl/TmTubslT3
 BTzKqkY1fWPv1aCHqas/4GCu5tdqOHe4zXGDj6HaCzn5YQGKRMGKbYH27yttHHpvnWnd
 SLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707084078; x=1707688878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIPJCwgfVbGJx4lA6l5Q46GsogvtXUyIhhyVDGiT8j0=;
 b=Nw3MLmNeDAUHnXw2KJv4J3V4lv6adUMaBp+KzRF2kZGOii6UcuYUjKKgA9kTScY9WU
 yVsdyaMVpSIo/w4aCxzqLs42qeyg6c7qjzQ7bjMH+enaStlzN0XwN4uIZLtrk7flJ+mt
 AXlOLvYTmZsdkIrMbGjGDMCqWSs2q6S1E3k9iVAwvknTws3lzf46tFL6dtlEt51c7thY
 vexwWX4g84Y0NA0gQ4PR1LAYX/y03WfoloR6GYrp7ezwQKZMZXks0dyjXCrr9ypTSihi
 BWrovjAq/+CgWkHepykylRKsA3EnZAEKPxx+NjYIwx2uqavFaSwclh6MaBINlY1usc+i
 JFtw==
X-Gm-Message-State: AOJu0YyS/BiuhkmBmp3RP5GxJfbfLFVNBPpQWx+O5ZzPHjTck6NRHvLU
 O5R0xsbvExrHwQJbcDBTNLnMS14gCxLQP9dgL8VqhJ4A8y59vlurajSV+Vb7I7nPJLLLGjasvIw
 N2VqCyQeceSojqgx4lJ5/xOWQMbU=
X-Google-Smtp-Source: AGHT+IGzf5okQboWx55wzK0HF3HJEFuCTbCcAOCt35BDp8fU1+pzboXxx1rG9h0x3CxR2F1Kpkd75dhPPW1HY4PpoC0=
X-Received: by 2002:a05:6e02:1bc5:b0:363:8607:1fe8 with SMTP id
 x5-20020a056e021bc500b0036386071fe8mr3351761ilv.11.1707084078194; Sun, 04 Feb
 2024 14:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-2-david@redhat.com>
 <CAFubqFuiQ5vEzELv0_y2+9KwhLDs3mNJQXMfeR4_YFMumo-x_g@mail.gmail.com>
 <8c3ffb6e-0b77-41ef-8f8a-ea67b62ff410@redhat.com>
In-Reply-To: <8c3ffb6e-0b77-41ef-8f8a-ea67b62ff410@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sun, 4 Feb 2024 17:01:07 -0500
Message-ID: <CAFubqFtqk6zDPGriu-sOwnhGo4QdZpJaaS7imRRL8ZCbWaSN4w@mail.gmail.com>
Subject: Re: [PATCH v1 01/15] libvhost-user: Fix msg_region->userspace_addr
 computation
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd30.google.com
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

On Sun, Feb 4, 2024 at 9:36=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.02.24 02:35, Raphael Norwitz wrote:
> > As a heads up, I've left Nutanix and updated it in MAINTAINERS. Will
> > be updating it again shortly so tagging these with my new work email.
> >
>
> Thanks for the fast review! The mail server already complained to me :)
>
> Maybe consider adding yourself as reviewer for vhost as well? (which
> covers libvhost-user), I took your mail address from git history, not
> get_maintainers.pl.

I don't expect I'll have much time to review code outside of
vhost-user-blk/vhost-user-scsi, but happy to add an entry if it helps
folks tag me on relevant patches.

>
> > On Fri, Feb 2, 2024 at 4:54=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> We barely had mmap_offset set in the past. With virtio-mem and
> >> dynamic-memslots that will change.
> >>
> >> In vu_add_mem_reg() and vu_set_mem_table_exec_postcopy(), we are
> >> performing pointer arithmetics, which is wrong. Let's simply
> >> use dev_region->mmap_addr instead of "void *mmap_addr".
> >>
> >> Fixes: ec94c8e621de ("Support adding individual regions in libvhost-us=
er")
> >> Fixes: 9bb38019942c ("vhost+postcopy: Send address back to qemu")
> >> Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
>
>
> --
> Cheers,
>
> David / dhildenb
>


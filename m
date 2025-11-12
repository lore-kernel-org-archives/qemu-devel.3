Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015D6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 10:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ8Jz-0001BQ-9C; Wed, 12 Nov 2025 05:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1vJ8GQ-0007rz-Hg
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1vJ8GN-0004pX-Ut
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762943982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2HB8kGKQtp93qpC7pF/EhiKAwXGpeFwQoLSp0ecPK7w=;
 b=c5/gVN6dEI9fAKfql0317NpZ3hrKJ2M8FPNRGD3pnYAakqveWTKOQCs8G2wIWhjElpgR4T
 eWGYZVhi5Pc8BqBGdBf54ewj9Eyp0cZbDMg22FndOiI9dk6dPo3yTFqOcLLW6kKaWATZkt
 oWJZoYR2wwtGA7ZAU70dlJRndWNzUA8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-fuKhOUTpNtS9jPWMx_guQQ-1; Wed, 12 Nov 2025 05:39:41 -0500
X-MC-Unique: fuKhOUTpNtS9jPWMx_guQQ-1
X-Mimecast-MFC-AGG-ID: fuKhOUTpNtS9jPWMx_guQQ_1762943980
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-3e7d56660baso1176297fac.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 02:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762943980; x=1763548780; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HB8kGKQtp93qpC7pF/EhiKAwXGpeFwQoLSp0ecPK7w=;
 b=hf/CWrXQ+1IWo9AQrK5fE+YdZ6K763Aa9COqtng6QguzAksnsQQx4QFTpPAW2LIgRo
 c125h9zsezB7qu6bdi5ub8PHTtKWoT8B05Wgt9LXdtxWyC25rjNSJjPb3rV2VLcl/CuF
 JTJYHmWxOOA0nKamkuPwvpXWGge4rh4B76vf1jQQBKcKWKnbGr/atf1vXw/N2hXoeypG
 E3KA2fa2xvoHvx28PHSeR8ACxPVXGtVp61ILv5OG4Li7XovlC6d3O4n5MV+6Ymn5sAyt
 vu0nMHi8h6esMMyfzrHLCwymQg7uczeesbHvSJpI9z8Gme8Hs69rVoef2ZG0HDdi1cL2
 WA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762943980; x=1763548780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2HB8kGKQtp93qpC7pF/EhiKAwXGpeFwQoLSp0ecPK7w=;
 b=ptXgCMkzy86nEAegsmkxL0O8+uoM6m5BTxA05Pa/XRKb+b7sbNdiEAOj0Vx2kD7r+y
 kIFzZounlEdbM9nCMrsOyO1ULJ/PRokyStkh4id7YKIqU2N+ojMhc7OwmMAlDazDff9Z
 wQayH1PZyXvDjg6+JGdYAcfO3mwVcwY873wcLAbobuAnwbSn/9ZbOvfEAw31vNUNoIpZ
 E8vuqvFjBitl7I6FO5FKY047n6UiDhX6QQluffIZ/Cu3PL4jhkq5M3QYnxfggd81bXOj
 7PvfFzJ4zRb9hCiQU1q0yShaI7vgPyLLKLp2DYwOtE52E/EZApny/o9Zd2sZ5zPs/t97
 xTAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0ILRuo26jxBn8d25OoICOz9vFfhja4Ui5cC49zV7nKulSPVKH6n6hQlqtV9kVomeZPu3VjrK+uPyg@nongnu.org
X-Gm-Message-State: AOJu0Yxk01rg723dMk+2YCvvMp+G35/5lKWQSUwBjOCQJKBtq/wOcsDB
 ONCTqlhLpMctkU7kZLMQ+qUr6SF9Htq5j7i4EH1lVuY24R6d3xY4BbFL7sw734KX68x7gJyhgdH
 GrOFkfccUgzp3AnaJeyyxyxh8bmhj2UY4v/pJfJ0CwGAydrAxBvKVyUUfbQStPHJIGVYef/Nm9H
 BxjXlo02xi5uz02AeWATH9ULzUnon2+0s=
X-Gm-Gg: ASbGncsHPbnOqqr7tp23GkQVCKaISwE8+DssMYM9OZI56YZDj/0dok0Lgw5M8s+iwZF
 y+mASjnQAq1/Qzk7dAU4Oj9OtnPwwf0MvxTfGAeyzN24zITIV+Pc/8Um+FGO7C6rcvR/a+A7Zsg
 vkDJSnUfDTQycdMkE2MLA4k+k1utPTYn4ve+d/cuIcInE6CKy3rHN8sg==
X-Received: by 2002:a05:6870:818c:b0:347:4622:7416 with SMTP id
 586e51a60fabf-3e834217f63mr1147047fac.44.1762943980226; 
 Wed, 12 Nov 2025 02:39:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtCOvcZMr2t8JS8AKtZ+RdTbqUofpDPo2AWAUf3hNlXTpfQVH9XZ5WMpf8IT49jkh3duvIUkFIo3s5ViYF48U=
X-Received: by 2002:a05:6870:818c:b0:347:4622:7416 with SMTP id
 586e51a60fabf-3e834217f63mr1147032fac.44.1762943979890; Wed, 12 Nov 2025
 02:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
 <CAELaAXwByXS0=c6m8Vx-A7Fa_q5XV7_cjPdcLa+M3w4NJR8R2g@mail.gmail.com>
In-Reply-To: <CAELaAXwByXS0=c6m8Vx-A7Fa_q5XV7_cjPdcLa+M3w4NJR8R2g@mail.gmail.com>
From: Alberto Faria <afaria@redhat.com>
Date: Wed, 12 Nov 2025 10:39:03 +0000
X-Gm-Features: AWmQ_bmcSkoRqJ6nXsWHHKoOpex3bP43hs4S1zSUZagaJLd9bH3m2Ph44Q8ry6E
Message-ID: <CAELaAXwDrkp4V=32o3SxjOKMOZSsfE6_2ZxGg-AF1KT29_wKkw@mail.gmail.com>
Subject: Re: [PATCH v14 00/10] Support persistent reservation operations
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com, k.jensen@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It seems Changqi Lu might have left ByteDance, the email is bouncing
with a user not found error.

Any tips on how to proceed?

Alberto

On Wed, Nov 12, 2025 at 10:26=E2=80=AFAM Alberto Faria <afaria@redhat.com> =
wrote:
>
> Hi Changqi,
>
> I wonder if you plan on following through with this series? It looks
> like it was/is very close to being merged. I can help or pick it up
> from here if you want, as I'm interested in seeing it merged.
>
> Thanks, Alberto
>
> On Fri, Oct 11, 2024 at 6:24=E2=80=AFPM Changqi Lu <luchangqi.123@bytedan=
ce.com> wrote:
> >
> > Patch v14 has been modified, thanks to Stefan for the code review.
> >
> > v13->v14:
> > - Fix some protocol and spelling related issues at hw/nvme/ctrl.c.
> >
> > v12->v13:
> > - Fix byte swaps at hw/nvme/ctrl.c.
> >
> > v11->v12:
> > - Fixed endian conversion during command parsing;
> > - Add the maximum number of keys, currently limited to 128.
> >
> > v10->v11:
> > - Before executing the pr operation, check whether it is supported.
> >   If it is not supported, return NVME_INVALID_OPCODE directly.
> >
> > v9->v10:
> > - When the driver does not support the pr operation, the error
> >   code returned by nvme changes to Invalid Command Opcode.
> >
> > v8->v9:
> > - Fix double-free and remove persistent reservation operations at nvme_=
is_write().
> >
> > v7->v8:
> > - Fix num_keys may be less than 0 at scsi_pr_read_keys_complete().
> > - Fix buf memory leak at iscsi driver.
> >
> > v6->v7:
> > - Add buferlen size check at SCSI layer.
> > - Add pr_cap calculation in bdrv_merge_limits() function at block layer=
,
> >   so the ugly bs->file->bs->bl.pr_cap in scsi and nvme layers was
> >   changed to bs->bl.pr_cap.
> > - Fix memory leak at iscsi driver, and some other spelling errors.
> >
> > v5->v6:
> > - Add relevant comments in the io layer.
> >
> > v4->v5:
> > - Fixed a memory leak bug at hw/nvme/ctrl.c.
> >
> > v3->v4:
> > - At the nvme layer, the two patches of enabling the ONCS
> >   function and enabling rescap are combined into one.
> > - At the nvme layer, add helper functions for pr capacity
> >   conversion between the block layer and the nvme layer.
> >
> > v2->v3:
> > In v2 Persist Through Power Loss(PTPL) is enable default.
> > In v3 PTPL is supported, which is passed as a parameter.
> >
> > v1->v2:
> > - Add sg_persist --report-capabilities for SCSI protocol and enable
> >   oncs and rescap for NVMe protocol.
> > - Add persistent reservation capabilities constants and helper function=
s for
> >   SCSI and NVMe protocol.
> > - Add comments for necessary APIs.
> >
> > v1:
> > - Add seven APIs about persistent reservation command for block layer.
> >   These APIs including reading keys, reading reservations, registering,
> >   reserving, releasing, clearing and preempting.
> > - Add the necessary pr-related operation APIs for both the
> >   SCSI protocol and NVMe protocol at the device layer.
> > - Add scsi driver at the driver layer to verify the functions
> >
> > Changqi Lu (10):
> >   block: add persistent reservation in/out api
> >   block/raw: add persistent reservation in/out driver
> >   scsi/constant: add persistent reservation in/out protocol constants
> >   scsi/util: add helper functions for persistent reservation types
> >     conversion
> >   hw/scsi: add persistent reservation in/out api for scsi device
> >   block/nvme: add reservation command protocol constants
> >   hw/nvme: add helper functions for converting reservation types
> >   hw/nvme: enable ONCS and rescap function
> >   hw/nvme: add reservation protocal command
> >   block/iscsi: add persistent reservation in/out driver
> >
> >  block/block-backend.c             | 403 ++++++++++++++++++++++++++++
> >  block/io.c                        | 164 ++++++++++++
> >  block/iscsi.c                     | 428 ++++++++++++++++++++++++++++++
> >  block/raw-format.c                |  56 ++++
> >  hw/nvme/ctrl.c                    | 350 +++++++++++++++++++++++-
> >  hw/nvme/ns.c                      |  11 +
> >  hw/nvme/nvme.h                    |  93 +++++++
> >  hw/scsi/scsi-disk.c               | 374 ++++++++++++++++++++++++++
> >  include/block/block-common.h      |  40 +++
> >  include/block/block-io.h          |  20 ++
> >  include/block/block_int-common.h  |  84 ++++++
> >  include/block/nvme.h              | 121 ++++++++-
> >  include/scsi/constants.h          |  52 ++++
> >  include/scsi/utils.h              |   8 +
> >  include/sysemu/block-backend-io.h |  24 ++
> >  scsi/utils.c                      |  81 ++++++
> >  16 files changed, 2307 insertions(+), 2 deletions(-)
> >
> > --
> > 2.20.1
> >
> >



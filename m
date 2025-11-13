Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF1DCD8C85
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 15:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJZF1-0002MN-2X; Thu, 13 Nov 2025 10:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1vJZEw-0002H3-Vn
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1vJZEu-0000nJ-Vv
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763047679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKEM6yKMjhcuIbngKCg+m+L4mZ+hzlljfDfHSFhOftk=;
 b=gSdhXahXRn0RPVCp3p9qoj2JFXARcwhASUAcid+T09vFmUbUqDfGdkhJM9MqsxM/0fq9CL
 gTTWlpYNrYeNeAMsiOrl4Dz1y3CzurqYWHX2cq6bH70LaECnKaE6SQPiwDr/JMzqPAjpz9
 HWI73V4sf3tzOVW+wUSYp699BE+IlPc=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-VQYCEZL3M3i129t3ak6-Tw-1; Thu, 13 Nov 2025 10:27:58 -0500
X-MC-Unique: VQYCEZL3M3i129t3ak6-Tw-1
X-Mimecast-MFC-AGG-ID: VQYCEZL3M3i129t3ak6-Tw_1763047677
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-3c96e523b03so2164928fac.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763047677; x=1763652477; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKEM6yKMjhcuIbngKCg+m+L4mZ+hzlljfDfHSFhOftk=;
 b=QMRYnP707nJBL7fhEFS/fkBgzdvjQy6TMroUkplJSD2oYMlqVUtMVmMZdq8TSZkEQ+
 /h1St0/Oj1nHDHZGXtRRpIRS1QLOPU/9Xj+/84VI9DOEcZMkkTsjn+XjlSOvFHiBof5y
 RnOvaHy0q0aGAH90SXJfRFqk1y9x/kFQcxKCi2j3aS1vI0jRbDmDSVbd6nDHqa7CBIXy
 ULz05YpvEp0mIg/C21LJUEQOgIV4uv13j1EFGzW8UW8sGdeH77wgzivo+LHMa67oA2bl
 z6g48Hhm3IW/sWNZTLjtbHqn1fJB5Ca2W9X02mGxw1E/x/qdfd/JPTMQEMvFD6IhUtCS
 aX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763047677; x=1763652477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jKEM6yKMjhcuIbngKCg+m+L4mZ+hzlljfDfHSFhOftk=;
 b=Gc/3dZCdbxRtLITVl5VQzPIEVFvW8TkRkPbuY99OLO5Q2LWwKBDdL9vZnBCOty5081
 TOmqSNNt1Vv69dPyQcscxN4r10XXjuE8AxphQFq6Apua51zmRTiKt3DTQU6QNa0TtFSO
 ZM6IxeWaxfls1yZTH9n5tA+0ec6z8qgrJTqSiHPOWQNgt9wvhyhYJgm8fOcw8XqqH+dt
 80Gu+4tFZDIvwCJQl9JSRwU+/H1KIL18vGfkwiX1ivaGf+778arzxGdZnGgDxU8HxDTl
 5HePrtZ1inA6UQqP828qyrbR3+g+cBQ8EA08kJVO9aTWQgvKvCrvRJI5tuzPYISwsTLt
 yrWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcSy/rlXXZ/X1XrovZ3V02IB+QAAPFPNo9BHy/CHEPnD/jYJCtjxlb7nI/x/ZQNtP86PYI6NEHgLUZ@nongnu.org
X-Gm-Message-State: AOJu0YzVY++wJczv3cz4QXvu7c69fEqEPiDLuk12tbsS+6IHSPPJZ7W7
 sKpB7NbnoSTdyqFiHUnCrEICzYZmRX9gSkmBOG9cT6kWgqKdt7qtx6BPwGNjUcto21qDToYGFcw
 ++eWg2QwGTrhzvCfavqk/UTxVfFINWhfOydDomLdsbuD/sYPZo7EQrF/b4b0frMPZeQRbQb3ofq
 +T27inPSrcRmy9ZxjcgZZJdIBLinMFPY8=
X-Gm-Gg: ASbGnct9ZsAiiEkIjGYR8utzLQS7EG6kyMxsPk198hdjHI0ocBByygNe402D8/XUjPl
 Ly+Us+57Vptz/AQhMDVMdR0ATH+kY2y4GSmv2mDqyvQn4bjxsE3a9rttrKrTLRf/0jsJOalZwDS
 PrWlTKFluwpI3f2VU83tGfmig+1JNhIKu1yyWK3Cvnp35e4zGbvwWlNMgSw8Xd0WZQyrBb1cSFJ
 aoWnswkrSWzENmDYw==
X-Received: by 2002:a05:6871:152:b0:3d3:4b61:161f with SMTP id
 586e51a60fabf-3e834213c1emr3243354fac.37.1763047677009; 
 Thu, 13 Nov 2025 07:27:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVt2iCI1Yfa2G4ALL5MQPcNF7QZAfQqh1IP2DaR0CUnl4kc42TUlobN6qoEtl0wKinkWs8t+1odchNB2ueUiQ=
X-Received: by 2002:a05:6871:152:b0:3d3:4b61:161f with SMTP id
 586e51a60fabf-3e834213c1emr3243326fac.37.1763047676563; Thu, 13 Nov 2025
 07:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
 <CAELaAXwByXS0=c6m8Vx-A7Fa_q5XV7_cjPdcLa+M3w4NJR8R2g@mail.gmail.com>
 <CAELaAXwDrkp4V=32o3SxjOKMOZSsfE6_2ZxGg-AF1KT29_wKkw@mail.gmail.com>
 <20251113150635.GB189474@fedora>
In-Reply-To: <20251113150635.GB189474@fedora>
From: Alberto Faria <afaria@redhat.com>
Date: Thu, 13 Nov 2025 15:27:19 +0000
X-Gm-Features: AWmQ_bkvi3C9PWXv7PIQjKxU8VjfjQOutu9dW9yiW3tLO2K0gpbR68wlJgqt7qU
Message-ID: <CAELaAXy2NwTSmXgLYs_+Nw6X69o176CHau9_4fnFT-z3H1+OZA@mail.gmail.com>
Subject: Re: [PATCH v14 00/10] Support persistent reservation operations
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Changqi Lu <luchangqi.123@bytedance.com>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com, k.jensen@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afaria@redhat.com;
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

On Thu, Nov 13, 2025 at 3:06=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
> On Wed, Nov 12, 2025 at 10:39:03AM +0000, Alberto Faria wrote:
> > It seems Changqi Lu might have left ByteDance, the email is bouncing
> > with a user not found error.
> >
> > Any tips on how to proceed?
>
> You can resume development of the series. Apply the patches, work on
> them until they are ready, and send them crediting the author:
> - It's easiest to add new patches that are authored by yourself, but
>   often you'll also need to fix up the original patches.
> - If the change to an original patch is small, keep the authorship
>   information and add your Signed-off-by, noting that you made changes.
> - If you change the majority of a patch, you might decide to make
>   yourself author, but note that the patch is based on the original
>   author's work.
>
> You may keep the patch series subject or pick a new one, depending on
> how relevant the original subject is to the scope of your new series.
>
> If you're unsure, try searching the web for advice on taking over patch
> series. There are multiple ways of doing it, and as long as you give
> credit to the author of the original code, it's up to you which approach
> you choose.
>
> Stefan

Thanks, I'll work on rebasing the series.

Alberto

>
> >
> > Alberto
> >
> > On Wed, Nov 12, 2025 at 10:26=E2=80=AFAM Alberto Faria <afaria@redhat.c=
om> wrote:
> > >
> > > Hi Changqi,
> > >
> > > I wonder if you plan on following through with this series? It looks
> > > like it was/is very close to being merged. I can help or pick it up
> > > from here if you want, as I'm interested in seeing it merged.
> > >
> > > Thanks, Alberto
> > >
> > > On Fri, Oct 11, 2024 at 6:24=E2=80=AFPM Changqi Lu <luchangqi.123@byt=
edance.com> wrote:
> > > >
> > > > Patch v14 has been modified, thanks to Stefan for the code review.
> > > >
> > > > v13->v14:
> > > > - Fix some protocol and spelling related issues at hw/nvme/ctrl.c.
> > > >
> > > > v12->v13:
> > > > - Fix byte swaps at hw/nvme/ctrl.c.
> > > >
> > > > v11->v12:
> > > > - Fixed endian conversion during command parsing;
> > > > - Add the maximum number of keys, currently limited to 128.
> > > >
> > > > v10->v11:
> > > > - Before executing the pr operation, check whether it is supported.
> > > >   If it is not supported, return NVME_INVALID_OPCODE directly.
> > > >
> > > > v9->v10:
> > > > - When the driver does not support the pr operation, the error
> > > >   code returned by nvme changes to Invalid Command Opcode.
> > > >
> > > > v8->v9:
> > > > - Fix double-free and remove persistent reservation operations at n=
vme_is_write().
> > > >
> > > > v7->v8:
> > > > - Fix num_keys may be less than 0 at scsi_pr_read_keys_complete().
> > > > - Fix buf memory leak at iscsi driver.
> > > >
> > > > v6->v7:
> > > > - Add buferlen size check at SCSI layer.
> > > > - Add pr_cap calculation in bdrv_merge_limits() function at block l=
ayer,
> > > >   so the ugly bs->file->bs->bl.pr_cap in scsi and nvme layers was
> > > >   changed to bs->bl.pr_cap.
> > > > - Fix memory leak at iscsi driver, and some other spelling errors.
> > > >
> > > > v5->v6:
> > > > - Add relevant comments in the io layer.
> > > >
> > > > v4->v5:
> > > > - Fixed a memory leak bug at hw/nvme/ctrl.c.
> > > >
> > > > v3->v4:
> > > > - At the nvme layer, the two patches of enabling the ONCS
> > > >   function and enabling rescap are combined into one.
> > > > - At the nvme layer, add helper functions for pr capacity
> > > >   conversion between the block layer and the nvme layer.
> > > >
> > > > v2->v3:
> > > > In v2 Persist Through Power Loss(PTPL) is enable default.
> > > > In v3 PTPL is supported, which is passed as a parameter.
> > > >
> > > > v1->v2:
> > > > - Add sg_persist --report-capabilities for SCSI protocol and enable
> > > >   oncs and rescap for NVMe protocol.
> > > > - Add persistent reservation capabilities constants and helper func=
tions for
> > > >   SCSI and NVMe protocol.
> > > > - Add comments for necessary APIs.
> > > >
> > > > v1:
> > > > - Add seven APIs about persistent reservation command for block lay=
er.
> > > >   These APIs including reading keys, reading reservations, register=
ing,
> > > >   reserving, releasing, clearing and preempting.
> > > > - Add the necessary pr-related operation APIs for both the
> > > >   SCSI protocol and NVMe protocol at the device layer.
> > > > - Add scsi driver at the driver layer to verify the functions
> > > >
> > > > Changqi Lu (10):
> > > >   block: add persistent reservation in/out api
> > > >   block/raw: add persistent reservation in/out driver
> > > >   scsi/constant: add persistent reservation in/out protocol constan=
ts
> > > >   scsi/util: add helper functions for persistent reservation types
> > > >     conversion
> > > >   hw/scsi: add persistent reservation in/out api for scsi device
> > > >   block/nvme: add reservation command protocol constants
> > > >   hw/nvme: add helper functions for converting reservation types
> > > >   hw/nvme: enable ONCS and rescap function
> > > >   hw/nvme: add reservation protocal command
> > > >   block/iscsi: add persistent reservation in/out driver
> > > >
> > > >  block/block-backend.c             | 403 ++++++++++++++++++++++++++=
++
> > > >  block/io.c                        | 164 ++++++++++++
> > > >  block/iscsi.c                     | 428 ++++++++++++++++++++++++++=
++++
> > > >  block/raw-format.c                |  56 ++++
> > > >  hw/nvme/ctrl.c                    | 350 +++++++++++++++++++++++-
> > > >  hw/nvme/ns.c                      |  11 +
> > > >  hw/nvme/nvme.h                    |  93 +++++++
> > > >  hw/scsi/scsi-disk.c               | 374 ++++++++++++++++++++++++++
> > > >  include/block/block-common.h      |  40 +++
> > > >  include/block/block-io.h          |  20 ++
> > > >  include/block/block_int-common.h  |  84 ++++++
> > > >  include/block/nvme.h              | 121 ++++++++-
> > > >  include/scsi/constants.h          |  52 ++++
> > > >  include/scsi/utils.h              |   8 +
> > > >  include/sysemu/block-backend-io.h |  24 ++
> > > >  scsi/utils.c                      |  81 ++++++
> > > >  16 files changed, 2307 insertions(+), 2 deletions(-)
> > > >
> > > > --
> > > > 2.20.1
> > > >
> > > >
> >



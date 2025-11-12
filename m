Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DD0CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 10:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ85h-0002dN-PE; Wed, 12 Nov 2025 05:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1vJ85W-0002aR-3f
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:28:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1vJ85S-0003HH-KU
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762943304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugpm3rsCEcoXBXdOkU4oEtuzEUBeYOtbGIql3+X3oe0=;
 b=Ac4eUVNn5h0WU8QkLfuUkRU9aNHnVpENODAelCaAX8TOulN56JYq2HAIQQfPCPTF4sYTZY
 nWOV2iU+5A84F8j7STa4ecCFzF76gKufbEBb3mllfXDWLmFsIDeo4u0afNI/xaCR2OfXOn
 RXhm4/HzmhkWx/tGERlaokBM1PmfKF8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-pGLPaJS6N7ajn2nbKiDuYQ-1; Wed, 12 Nov 2025 05:27:14 -0500
X-MC-Unique: pGLPaJS6N7ajn2nbKiDuYQ-1
X-Mimecast-MFC-AGG-ID: pGLPaJS6N7ajn2nbKiDuYQ_1762943234
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7c704b23037so1310410a34.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 02:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762943233; x=1763548033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugpm3rsCEcoXBXdOkU4oEtuzEUBeYOtbGIql3+X3oe0=;
 b=FiRIvJkKXUj8Ki7NxDOV3fZ6gf1Cn5EapLb5dUhnGSe85vg2C4sf02HmyDVKCg2dQk
 0QdgYzR0Un+bQ/7cBx3FxX+AS8bI5U4e8uUs+Cr3HcHo7Hdb8HkjKLyR9mhIpIFiK++r
 HKnWuQVcXWpMOcIXuX/zKERljXNGGQK6u25JnpyN8oVl5Y2A+Hkbc0cyYmbQz+aynCMW
 g+bMLgXNbFS7tCqDWzC9y0D524hS9fkn9MQXKmB2rqLqU2+YS1VtxgSXXLL+Kl7H3Ky7
 z1+5MfspEvvvQDBvG/1b+wyxcYgSoBRQlaB4cOyD+gWa4uQmdvZVJTUJyF7VvU+VoWYt
 XKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762943233; x=1763548033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ugpm3rsCEcoXBXdOkU4oEtuzEUBeYOtbGIql3+X3oe0=;
 b=VLGtb1GgV5r5zXKGUGXnciy5L1SpLVfpY1gr6PgXuu4gEpQia5tK2xl7vF7YM6DfwN
 Lh9aMg5o+iMINy4LY3d5YnxmhGBOcE41CMiwNDlCuxjo86x7YZn79qhA/45aZoI9TIYl
 3DTXb6l3I2GTZ39UAKueJsxC0gQBNj8fQyw5JvEeRlBHExbL800VAO6I0nVHLy+vf1pm
 FXsS0aMwvc6lIjJ3kwEjyn4vhVmJqp6JbUkvd6tV3KfwD5fentBIRQqwITx26tayhklE
 /0At68Pb7flas7t5I5wH3QmeGhgNcJqHOnIfZDsV+uPW3txnHWZPXjKRQkhf8OeQuiR+
 B97w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiqRWxl326ftrTENuNymG6kUUJ2S+EALQ7Bc7SebuCBWSwHt9b2dztp+4RqQ9WEROWryeFZEhJ6pQi@nongnu.org
X-Gm-Message-State: AOJu0YwVxKM4M8N6gfmF11KjeZUYHflpFwTI+8xN024EnNOhuWZPtEjn
 WUpjShOCMfjfOrJnTG6p+npk74JQC6BFcfvYF27JewPf/tpjg138F7BNvBkKIyFGGfrZiQ6c4Bq
 RnxEpJj4Atw2ThknA0H5NLVb5TO5NC43u6/ABv04sIvqBN0EQiKRMBnNX/U0/TjGOHwmaH24ymQ
 vrS78YD+SiadZwgoZGruwfW6zda46ka3M=
X-Gm-Gg: ASbGncs95L2PwOtpH1ER2Xwl+JxKrxLMrdMC6SIGDNkUMp7ra2DXQe2eNp0RlwMUogN
 mlqsrfhi67MhW1axpKZ2uk09H2N4/8XiaKyUxckOB9nEc2DEvRPVCvQ8LDgt63+cxLlLZJ7gtZv
 xASEyqCof0XYMxYa5HKIEU2m2WUIrjsXshRfc6QF8KgD1oLGUW0ZZ41EtQgAL80+0IK7iXcJ7Pi
 b9SxYhM9jrTrRqz
X-Received: by 2002:a05:6870:898d:b0:3e7:f374:8dc4 with SMTP id
 586e51a60fabf-3e83416a3b9mr1031673fac.25.1762943233665; 
 Wed, 12 Nov 2025 02:27:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNI2UYQVnDDxaJWh51sRO4GnfJ8yQAdk1XUlmQUgSMGDRp7qaiy/E5/YM0+ERUn5SHoN8MMZRHTSoeCR3IPL0=
X-Received: by 2002:a05:6870:898d:b0:3e7:f374:8dc4 with SMTP id
 586e51a60fabf-3e83416a3b9mr1031661fac.25.1762943233257; Wed, 12 Nov 2025
 02:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
In-Reply-To: <20241011121231.18333-1-luchangqi.123@bytedance.com>
From: Alberto Faria <afaria@redhat.com>
Date: Wed, 12 Nov 2025 10:26:35 +0000
X-Gm-Features: AWmQ_bl_ImxJ7NFnYg3OpcUcnQKTAkze3vKFQodjekFoA7o49i32NWnUKgnrQe0
Message-ID: <CAELaAXwByXS0=c6m8Vx-A7Fa_q5XV7_cjPdcLa+M3w4NJR8R2g@mail.gmail.com>
Subject: Re: [PATCH v14 00/10] Support persistent reservation operations
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Changqi,

I wonder if you plan on following through with this series? It looks
like it was/is very close to being merged. I can help or pick it up
from here if you want, as I'm interested in seeing it merged.

Thanks, Alberto

On Fri, Oct 11, 2024 at 6:24=E2=80=AFPM Changqi Lu <luchangqi.123@bytedance=
.com> wrote:
>
> Patch v14 has been modified, thanks to Stefan for the code review.
>
> v13->v14:
> - Fix some protocol and spelling related issues at hw/nvme/ctrl.c.
>
> v12->v13:
> - Fix byte swaps at hw/nvme/ctrl.c.
>
> v11->v12:
> - Fixed endian conversion during command parsing;
> - Add the maximum number of keys, currently limited to 128.
>
> v10->v11:
> - Before executing the pr operation, check whether it is supported.
>   If it is not supported, return NVME_INVALID_OPCODE directly.
>
> v9->v10:
> - When the driver does not support the pr operation, the error
>   code returned by nvme changes to Invalid Command Opcode.
>
> v8->v9:
> - Fix double-free and remove persistent reservation operations at nvme_is=
_write().
>
> v7->v8:
> - Fix num_keys may be less than 0 at scsi_pr_read_keys_complete().
> - Fix buf memory leak at iscsi driver.
>
> v6->v7:
> - Add buferlen size check at SCSI layer.
> - Add pr_cap calculation in bdrv_merge_limits() function at block layer,
>   so the ugly bs->file->bs->bl.pr_cap in scsi and nvme layers was
>   changed to bs->bl.pr_cap.
> - Fix memory leak at iscsi driver, and some other spelling errors.
>
> v5->v6:
> - Add relevant comments in the io layer.
>
> v4->v5:
> - Fixed a memory leak bug at hw/nvme/ctrl.c.
>
> v3->v4:
> - At the nvme layer, the two patches of enabling the ONCS
>   function and enabling rescap are combined into one.
> - At the nvme layer, add helper functions for pr capacity
>   conversion between the block layer and the nvme layer.
>
> v2->v3:
> In v2 Persist Through Power Loss(PTPL) is enable default.
> In v3 PTPL is supported, which is passed as a parameter.
>
> v1->v2:
> - Add sg_persist --report-capabilities for SCSI protocol and enable
>   oncs and rescap for NVMe protocol.
> - Add persistent reservation capabilities constants and helper functions =
for
>   SCSI and NVMe protocol.
> - Add comments for necessary APIs.
>
> v1:
> - Add seven APIs about persistent reservation command for block layer.
>   These APIs including reading keys, reading reservations, registering,
>   reserving, releasing, clearing and preempting.
> - Add the necessary pr-related operation APIs for both the
>   SCSI protocol and NVMe protocol at the device layer.
> - Add scsi driver at the driver layer to verify the functions
>
> Changqi Lu (10):
>   block: add persistent reservation in/out api
>   block/raw: add persistent reservation in/out driver
>   scsi/constant: add persistent reservation in/out protocol constants
>   scsi/util: add helper functions for persistent reservation types
>     conversion
>   hw/scsi: add persistent reservation in/out api for scsi device
>   block/nvme: add reservation command protocol constants
>   hw/nvme: add helper functions for converting reservation types
>   hw/nvme: enable ONCS and rescap function
>   hw/nvme: add reservation protocal command
>   block/iscsi: add persistent reservation in/out driver
>
>  block/block-backend.c             | 403 ++++++++++++++++++++++++++++
>  block/io.c                        | 164 ++++++++++++
>  block/iscsi.c                     | 428 ++++++++++++++++++++++++++++++
>  block/raw-format.c                |  56 ++++
>  hw/nvme/ctrl.c                    | 350 +++++++++++++++++++++++-
>  hw/nvme/ns.c                      |  11 +
>  hw/nvme/nvme.h                    |  93 +++++++
>  hw/scsi/scsi-disk.c               | 374 ++++++++++++++++++++++++++
>  include/block/block-common.h      |  40 +++
>  include/block/block-io.h          |  20 ++
>  include/block/block_int-common.h  |  84 ++++++
>  include/block/nvme.h              | 121 ++++++++-
>  include/scsi/constants.h          |  52 ++++
>  include/scsi/utils.h              |   8 +
>  include/sysemu/block-backend-io.h |  24 ++
>  scsi/utils.c                      |  81 ++++++
>  16 files changed, 2307 insertions(+), 2 deletions(-)
>
> --
> 2.20.1
>
>



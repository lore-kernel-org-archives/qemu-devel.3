Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C916FC30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQzu-0002oa-Ck; Wed, 26 Jun 2024 07:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sMQzo-0002oA-Kw
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:39:30 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sMQzj-0004gj-Fz
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:39:27 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d10354955so162656a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1719401957; x=1720006757; darn=nongnu.org;
 h=cc:to:subject:message-id:date:references:user-agent:mime-version
 :from:in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=8NsG/CGbwjFmn8K6htkzx/acdwk5yWWD08GPjMXzkfs=;
 b=Ab1mZm6vAVufqb3JWMORBwR3u51jyvTfIywyMCxF9HF7mPWh2v1TIuPWQ4natDQojM
 5GF3QaNNheDVXISyYEsZw7GKzH4m+JWm4KTchwn4PN3H+jcKTqK4qFdc/a/xHiDCZG4j
 EmLomYImxU6MmNckbGC4pSyTfMTe5Qx6d3an+Lb+5Eh18uq9nrEeST7U8ka7bqgSwzPF
 NoO6FzfNtMLIDOShX2sYb7D3tpOkYKDbLTkaA9kovADQ6bwuD0wNu08+Z+fyYAsgqfGo
 Vli3utwA4x1L989QtiZLGVFMFoptdX+gAQ8D9HHXFzHkupEvR1xkfhjJLApcswclLD8c
 5V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719401957; x=1720006757;
 h=cc:to:subject:message-id:date:references:user-agent:mime-version
 :from:in-reply-to:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NsG/CGbwjFmn8K6htkzx/acdwk5yWWD08GPjMXzkfs=;
 b=A4FaCqmrkatvnByY3Ptje5VCs02cBChyNDyI3pYify1CafB6xR604OcVfONAy7R65v
 Orcflr4qzeo8V8pJqwxsNspGuylehvfFUrpXd9Rc+pmFA6lRnB48yhZJDMcgvwh81Llt
 qDOf3QsI1oFL+k6g5xf2pM2uLFvpD6hL+jTUoCBK728dLQeTL/PrBR4BK4+UK3jV1qwA
 Z5Ajjf+pT6AyavVB1IdF+/yCeazCGevmcI9Cwvqgv4f4x5aWmk5bs9A+beFrCusJFyFF
 hRa424oeQwe+Ybw07q5zJF8gJRttQ1YVsQzTCOyYO/Emgh7gMx0M3SKKuK/GoW8ZyDuK
 bQIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMbwxv8mTqhv/9yhD+EI/vpvCIQ2IRCm1qzk4L8mA4Vb2vuftKmx2db7j2qhaabiHwaRuo6w3xr3HGzLR4koeOTc0Sq9I=
X-Gm-Message-State: AOJu0YztJouMUZ+XC+/VEQtwuUDZhp7XGHENvjXAIkVc8kQOeea3oYCZ
 q/1RCDqCcUn0nWNV7OnN5EWuHm5V7knS+vLHOBgiWatMwtWThK2aL/cNI3ROekLzTJmsKY9mUdG
 NHltn//g0UytuhGfDI+D9RmObVAvO6++0Cw6FjA==
X-Google-Smtp-Source: AGHT+IFCKXigQklrkAwCCty1gPi0ZrouXk77fZLA/dmErXOuVlnsbyEHtqg9CtxigTlETq1xCVTOYNeXddyEFls3FvA=
X-Received: by 2002:a50:9b17:0:b0:57d:619:7721 with SMTP id
 4fb4d7f45d1cf-57d49dbf387mr6725951a12.21.1719401956627; Wed, 26 Jun 2024
 04:39:16 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 26 Jun 2024 04:39:16 -0700
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
In-Reply-To: <3c9b7bb9-cb69-49c4-b7cf-5503baeee09d@bytedance.com>
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
References: <20240613071327.2498953-1-luchangqi.123@bytedance.com>
 <3c9b7bb9-cb69-49c4-b7cf-5503baeee09d@bytedance.com>
Date: Wed, 26 Jun 2024 04:39:16 -0700
Message-ID: <CAO5cSZBVDO4McPuiLwesGUQuYnaZzyXBQJTyXNY-3nagytP0Ow@mail.gmail.com>
Subject: PING: [PATCH v6 00/10] Support persistent reservation operations
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="000000000000da09e8061bc97695"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000da09e8061bc97695
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Could everyone please review this series?

On 2024/6/19 10:49, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
> Hi,
>
> Klaus, the pr related operations of the
> nvme layer are almost ready.
>
> Stefan, the block layer has been modified
> according to your comments.
>
> Please help review the code again. Thanks!
>
> On 2024/6/13 15:13, Changqi Lu wrote:
>> Hi,
>>
>> patch v6 has been modified.
>>
>> v5->v6:
>> - Add relevant comments in the io layer.
>>
>> v4->v5:
>> - Fixed a memory leak bug at hw/nvme/ctrl.c.
>>
>> v3->v4:
>> - At the nvme layer, the two patches of enabling the ONCS
>> function and enabling rescap are combined into one.
>> - At the nvme layer, add helper functions for pr capacity
>> conversion between the block layer and the nvme layer.
>>
>> v2->v3:
>> In v2 Persist Through Power Loss(PTPL) is enable default.
>> In v3 PTPL is supported, which is passed as a parameter.
>>
>> v1->v2:
>> - Add sg_persist --report-capabilities for SCSI protocol and enable
>> oncs and rescap for NVMe protocol.
>> - Add persistent reservation capabilities constants and helper functions
for
>> SCSI and NVMe protocol.
>> - Add comments for necessary APIs.
>>
>> v1:
>> - Add seven APIs about persistent reservation command for block layer.
>> These APIs including reading keys, reading reservations, registering,
>> reserving, releasing, clearing and preempting.
>> - Add the necessary pr-related operation APIs for both the
>> SCSI protocol and NVMe protocol at the device layer.
>> - Add scsi driver at the driver layer to verify the functions
>>
>> Changqi Lu (10):
>> block: add persistent reservation in/out api
>> block/raw: add persistent reservation in/out driver
>> scsi/constant: add persistent reservation in/out protocol constants
>> scsi/util: add helper functions for persistent reservation types
>> conversion
>> hw/scsi: add persistent reservation in/out api for scsi device
>> block/nvme: add reservation command protocol constants
>> hw/nvme: add helper functions for converting reservation types
>> hw/nvme: enable ONCS and rescap function
>> hw/nvme: add reservation protocal command
>> block/iscsi: add persistent reservation in/out driver
>>
>> block/block-backend.c | 403 +++++++++++++++++++++++++++
>> block/io.c | 163 +++++++++++
>> block/iscsi.c | 443 ++++++++++++++++++++++++++++++
>> block/raw-format.c | 56 ++++
>> hw/nvme/ctrl.c | 326 +++++++++++++++++++++-
>> hw/nvme/ns.c | 5 +
>> hw/nvme/nvme.h | 84 ++++++
>> hw/scsi/scsi-disk.c | 352 ++++++++++++++++++++++++
>> include/block/block-common.h | 40 +++
>> include/block/block-io.h | 20 ++
>> include/block/block_int-common.h | 84 ++++++
>> include/block/nvme.h | 98 +++++++
>> include/scsi/constants.h | 52 ++++
>> include/scsi/utils.h | 8 +
>> include/sysemu/block-backend-io.h | 24 ++
>> scsi/utils.c | 81 ++++++
>> 16 files changed, 2237 insertions(+), 2 deletions(-)
>>

--000000000000da09e8061bc97695
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi,
<br>
<br>Could everyone please review this series?
<br>
<br>On 2024/6/19 10:49, =E5=8D=A2=E9=95=BF=E5=A5=87 wrote:
<br>&gt; Hi,
<br>&gt;=20
<br>&gt; Klaus, the pr related operations of the
<br>&gt; nvme layer are almost ready.
<br>&gt;=20
<br>&gt; Stefan, the block layer has been modified
<br>&gt; according to your comments.
<br>&gt;=20
<br>&gt; Please help review the code again. Thanks!
<br>&gt;=20
<br>&gt; On 2024/6/13 15:13, Changqi Lu wrote:
<br>&gt;&gt; Hi,
<br>&gt;&gt;
<br>&gt;&gt; patch v6 has been modified.
<br>&gt;&gt;
<br>&gt;&gt; v5-&gt;v6:
<br>&gt;&gt; - Add relevant comments in the io layer.
<br>&gt;&gt;
<br>&gt;&gt; v4-&gt;v5:
<br>&gt;&gt; - Fixed a memory leak bug at hw/nvme/ctrl.c.
<br>&gt;&gt;
<br>&gt;&gt; v3-&gt;v4:
<br>&gt;&gt; - At the nvme layer, the two patches of enabling the ONCS
<br>&gt;&gt;   function and enabling rescap are combined into one.
<br>&gt;&gt; - At the nvme layer, add helper functions for pr capacity
<br>&gt;&gt;   conversion between the block layer and the nvme layer.
<br>&gt;&gt;
<br>&gt;&gt; v2-&gt;v3:
<br>&gt;&gt; In v2 Persist Through Power Loss(PTPL) is enable default.
<br>&gt;&gt; In v3 PTPL is supported, which is passed as a parameter.
<br>&gt;&gt;
<br>&gt;&gt; v1-&gt;v2:
<br>&gt;&gt; - Add sg_persist --report-capabilities for SCSI protocol and e=
nable
<br>&gt;&gt;   oncs and rescap for NVMe protocol.
<br>&gt;&gt; - Add persistent reservation capabilities constants and helper=
 functions for
<br>&gt;&gt;   SCSI and NVMe protocol.
<br>&gt;&gt; - Add comments for necessary APIs.
<br>&gt;&gt;
<br>&gt;&gt; v1:
<br>&gt;&gt; - Add seven APIs about persistent reservation command for bloc=
k layer.
<br>&gt;&gt;   These APIs including reading keys, reading reservations, reg=
istering,
<br>&gt;&gt;   reserving, releasing, clearing and preempting.
<br>&gt;&gt; - Add the necessary pr-related operation APIs for both the
<br>&gt;&gt;   SCSI protocol and NVMe protocol at the device layer.
<br>&gt;&gt; - Add scsi driver at the driver layer to verify the functions
<br>&gt;&gt;
<br>&gt;&gt; Changqi Lu (10):
<br>&gt;&gt;   block: add persistent reservation in/out api
<br>&gt;&gt;   block/raw: add persistent reservation in/out driver
<br>&gt;&gt;   scsi/constant: add persistent reservation in/out protocol co=
nstants
<br>&gt;&gt;   scsi/util: add helper functions for persistent reservation t=
ypes
<br>&gt;&gt;     conversion
<br>&gt;&gt;   hw/scsi: add persistent reservation in/out api for scsi devi=
ce
<br>&gt;&gt;   block/nvme: add reservation command protocol constants
<br>&gt;&gt;   hw/nvme: add helper functions for converting reservation typ=
es
<br>&gt;&gt;   hw/nvme: enable ONCS and rescap function
<br>&gt;&gt;   hw/nvme: add reservation protocal command
<br>&gt;&gt;   block/iscsi: add persistent reservation in/out driver
<br>&gt;&gt;
<br>&gt;&gt;  block/block-backend.c             | 403 +++++++++++++++++++++=
++++++
<br>&gt;&gt;  block/io.c                        | 163 +++++++++++
<br>&gt;&gt;  block/iscsi.c                     | 443 +++++++++++++++++++++=
+++++++++
<br>&gt;&gt;  block/raw-format.c                |  56 ++++
<br>&gt;&gt;  hw/nvme/ctrl.c                    | 326 +++++++++++++++++++++=
-
<br>&gt;&gt;  hw/nvme/ns.c                      |   5 +
<br>&gt;&gt;  hw/nvme/nvme.h                    |  84 ++++++
<br>&gt;&gt;  hw/scsi/scsi-disk.c               | 352 +++++++++++++++++++++=
+++
<br>&gt;&gt;  include/block/block-common.h      |  40 +++
<br>&gt;&gt;  include/block/block-io.h          |  20 ++
<br>&gt;&gt;  include/block/block_int-common.h  |  84 ++++++
<br>&gt;&gt;  include/block/nvme.h              |  98 +++++++
<br>&gt;&gt;  include/scsi/constants.h          |  52 ++++
<br>&gt;&gt;  include/scsi/utils.h              |   8 +
<br>&gt;&gt;  include/sysemu/block-backend-io.h |  24 ++
<br>&gt;&gt;  scsi/utils.c                      |  81 ++++++
<br>&gt;&gt;  16 files changed, 2237 insertions(+), 2 deletions(-)
<br>&gt;&gt;</p>

--000000000000da09e8061bc97695--


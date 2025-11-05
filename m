Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4D1CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 08:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGZD4-0001fU-Sd; Wed, 05 Nov 2025 03:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vGZD3-0001fB-CI
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 03:49:41 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vGZD0-0006Yb-Bh
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 03:49:41 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-640e40d4596so383276a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 00:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1762332575; x=1762937375; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qi4+afpZcBEDk2kG2lbtQmPOnL0D3spLNtFp1Gyu3RY=;
 b=Rc9QM8OWjlNoNfTTq1VNeCyNOHzP8foSf5KwhcPSMuY+A2zh/lRb1Q5eyWKFB6sdH3
 YyPDZwjnkYUYxVzAc7aEvnsbhGUxR8Y763ittOFVQV5TM5h1ZiN+V2cEVE7ROUZ56P/r
 xetZpB4uEoNv215ByM7jq0GD440AydpeoFvsLpNglbiop9YprVDsMlzpcktggV4uazKa
 m6k5o5g5BmX874E8c8WYxnii3rPoI1yYjRgD2a713kQcvRPwOQYkXuAnWZS9J0t1ep6w
 J/RNRxE52sCRYXjtKJEI3UXaVTjwU74zS0xWfiEx8EbDYLVWIC+QJ2C/2sN8qufhBXGN
 r91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762332575; x=1762937375;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qi4+afpZcBEDk2kG2lbtQmPOnL0D3spLNtFp1Gyu3RY=;
 b=uOEBuT42n0Vi+eJQ6vkRlZ0uuX8gK2vMl/dcg3kueaaUS65JzMQFbN07ucH2fa1ihw
 ojqkqGleWaX7g/+KQwDBG4nNw6mR1O1Bt8murKj92TQ/qSgueYgh/hcC1/zrlHOfvnRx
 0B4iC3lbInik1FmSlNnuN3VkkFYj7dtgMD7/35wn2K0TN0o9Y7EKKBKot7Q6sp9bTEzB
 /50Pk/mHi8GP60C3nlWDrdxu+VSdBK+9d//OcDjzrV88TZ3D3XRLdju6jURLrXAVVolf
 N40jMO5jtjO2FGE1uHggP7Cdlw1HgKELakX9r1E7lcfZjiM8V6ZsiUnWAe+wCp667Ugf
 nEHA==
X-Gm-Message-State: AOJu0YwbNwZjCT7txmf8bG9cSrO01TBEk8u8HFtYoCt8AZWm3BS217En
 kX5QbZo9qw76KFXVwg950FQKZRQ4wS3sa+3lv86n9mGmiVPse0FFyzkpIgN9iUJwhd07KbcxxUz
 mjntXBU3HQUN6fObsM6gbhq9y/HqUtgTrXRHgZjWjy4NTnL3bHpFjenM=
X-Gm-Gg: ASbGncu15TkPg31ojHRJC8kS9PnP8jeZL4ClpnV+SQj2LB8Sc4ZmY+rw50CkSqwuLwS
 i6yGnvT3UYCA07+99D4giWl215CJ0OUosA68f9WLYpKSgsT/kTnoxYzQZo9464RV8HV9OoCB/EN
 Vys/MHiKE8S4HpADM1WnIoItd9aRkJquIfPMn2bszweUo7qzCcDGZp3TTyWrOMdahihASxItA0S
 MZwqNuPF0Rmah9Bs+fLKkXfAcmOq/h7NBl/6NGS14BlnL9+YbM6NhMBw4sw1MDsJk/Dow4=
X-Google-Smtp-Source: AGHT+IE8PRF5zhi5XaSKMvDQVF9tFPsVSKnl4Sv3XHKK2x/ZjuDGxl5nd7szsFtb4UwNlvPbgnKEVU3oab8YIWN0djk=
X-Received: by 2002:a05:6402:520b:b0:640:ec0a:e88b with SMTP id
 4fb4d7f45d1cf-64105b80568mr1009902a12.6.1762332574859; Wed, 05 Nov 2025
 00:49:34 -0800 (PST)
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 5 Nov 2025 09:49:24 +0100
X-Gm-Features: AWmQ_bnqu6Xfd_DHkCdFO5jR9o6AaKaT2lTIiB0mWdlrH3ducnEiRaWo7ev7J-0
Message-ID: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8=2E2=2E1?=
 =?UTF-8?Q?0_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESET_=2F_?=
 =?UTF-8?Q?USO_features=29?=
To: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 qemu-stable@nongnu.org, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::529;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hello QEMU developers,

I=E2=80=99m encountering a migration failure when trying to live-migrate a =
VM
from a newer host (kernel 6.12 + QEMU 9.2.4) to an older one (kernel
6.1 + QEMU 8.2.10).
Migration in the forward direction (old =E2=86=92 new) works fine, but afte=
r
rebooting the guest on the new host, migration back to the old host
fails.

________________________________

Issue summary

Source host: kernel 6.12, QEMU 9.2.4

Destination host: kernel 6.1, QEMU 8.2.10

VM type: pc-q35-8.2, using virtio-net-pci with vhost backend

Symptom: Migration from 9.2.4 =E2=86=92 8.2.10 fails with virtio-net load e=
rror.

Error log (destination):

2025-09-23T07:06:14.915708Z qemu-8.2: Features 0x1c0010130afffa7
unsupported. Allowed features: 0x179bfffe7
2025-09-23T07:06:14.915843Z qemu-8.2: Failed to load virtio-net:virtio
2025-09-23T07:06:14.915851Z qemu-8.2: error while loading state for
instance 0x0 of device '0000:00:02.0:06.0/virtio-net'
2025-09-23T07:06:14.917894Z qemu-8.2: load of migration failed:
Operation not permitted

________________________________

Analysis

It appears that virtio-net feature bits differ between the two versions.
On QEMU 9.2.4, virtio-net reports additional features:

VIRTIO_F_RING_RESET

VIRTIO_NET_F_HOST_USO

VIRTIO_NET_F_GUEST_USO4

VIRTIO_NET_F_GUEST_USO6

These are not present (or not supported) on QEMU 8.2.10, which causes
the migration state load to fail.

The issue seems related to the introduction of these features and how
they are handled during incoming migration when the target QEMU does
not recognize them.

________________________________

Reproduction steps

Start VM on host with QEMU 8.2.10 (kernel 6.1).

Migrate to host with QEMU 9.2.4 (kernel 6.12).
=E2=86=92 Migration succeeds.

Reboot the guest on the 9.2.4 host.

Attempt to migrate back to QEMU 8.2.10 host.
=E2=86=92 Migration fails with virtio-net load error (see log above).

________________________________

Expected behavior

Migration from newer QEMU to older version should either:

gracefully ignore unsupported virtio-net features, or

fail with a clear compatibility message before starting migration.

Currently, migration starts and fails during device state load.

________________________________

Related patch

I found this commit that looks relevant but is already included in
both 8.2.10 and 9.2.4:

https://lore.kernel.org/qemu-devel/20240527072435.52812-15-mjt@tls.msk.ru/

________________________________

VM configuration

-uuid dbaf0b1f-4dc5-4462-86b1-d82107b58599
-name Serverwittchendbaf0b1f-4dc5-4462-86b1-d82107b58599
-M pc-q35-8.2
-accel kvm,kernel-irqchip=3Dsplit
-cpu SierraForest-v2
-smp 7,sockets=3D128,cores=3D1,maxcpus=3D128,threads=3D1
-m 4096,slots=3D252,maxmem=3D256G
-bios /usr/share/ovmf/OVMF.fd
-device virtio-net-pci,netdev=3Dhostnet6,id=3Dnet6,mac=3D02:01:17:9b:9a:35,=
bus=3Dpci.0,addr=3D0x6
-netdev tap,ifname=3Dn0201179b9a35,id=3Dhostnet6,script=3Dno,downscript=3Dn=
o

________________________________

Question

Is this expected behavior (i.e. migration incompatibility due to newer
virtio-net feature bits)?
Or should QEMU handle such feature mismatches more gracefully (e.g.,
automatically disable unsupported virtio features during migration)?

Any guidance on how to make migration between these versions work
would be appreciated.

________________________________

Thanks,
Jinpu Wang @ IONOS Cloud


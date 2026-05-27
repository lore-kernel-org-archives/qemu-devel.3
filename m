Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19A5CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 21:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSLSO-0007xH-S5; Wed, 27 May 2026 17:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wSLSO-0007wq-3b
 for qemu-devel@nongnu.org; Wed, 27 May 2026 17:06:28 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wSLSM-0002a4-9v
 for qemu-devel@nongnu.org; Wed, 27 May 2026 17:06:27 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd85ebb368fso1799754066b.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 14:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779915985; cv=none;
 d=google.com; s=arc-20240605;
 b=NyfvGYAFQVMKZ13CVV7S/mhmkO6DcMH5ijdaIg0bPZSAaHaiBkzXNB6nWEitmXRD5S
 68Zq1g7k+U861zmB1N/YidOnN8HeTHxADx2mzjnkZ3z2WbhAPBJLzUAHvdLEKfMWfRUx
 RIMhXtqqEF+aqcwIO/o3tsvuhvxI8/Gx9t6viAyyrtOZ7T8xE4vqKScLgI77K7CzJmyU
 bQI67i529r3hqLWS00OUL1GVHXjLeo6n/F2R9cqXU3J88sj5NxGByMp0DKfAP1IdTPo6
 WJJdj/DkSeBMb0namu32WjjI1aZk6rP/q0Uo08X9mQF26Q1TJto9iYVpqkHpY0NKwX+J
 LXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dweQ5y+KlunnRHzU71+MAEjvJSanMYXjwF+wo7+7lCU=;
 fh=DRPOatXgQr66kwcis/bI7oQT+jBra5OX+sdxVTD7Am8=;
 b=DW9jAQ+1Qzt7opB3Z5wNjBb3fE6/BE+Ye/DZH8Mk7hLIknZicrrS9FfoKj6yrvnhBb
 55yG7RRENbkpePjl+wpD+TgYZ1deAZUAydao+vM/6+XiM/NEs+iOIcOB9eEu4BgHWMol
 Vri3bNsBwTGz9UJ2Lyx+F7R43DZ62HTc2FqRaDVmju7SKZAuPF7DwYbsGruwxFrhBe6P
 KDLw2QB/KdXgBnGaXaFKGuGwJ368NAPJ3b8/elXo+jpvdl28mRgSvn0POPHRnfg7DAPN
 ELlegUTZK2dpZuMDAqhDrq3lymNM6H3hmQIkhbezzUMD/vAahlOPHAPrlKcujaAW2q5j
 T+AA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779915985; x=1780520785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dweQ5y+KlunnRHzU71+MAEjvJSanMYXjwF+wo7+7lCU=;
 b=Dd+BAA9fHTGAggL+pyPfxpbiiXeo0SWGz6rgdRD0QSgFlIlqTDhc+wfMSWCF6f/Kl+
 mK5V0t1XX62tVWFJzsjrbIju6OR9zPEs++rjjF72USbqB8Dt9OUedfuqel2KPP3FgnUT
 chiCPghszJE+mQSHOMjMPESjEszrg1Q6RTdWu+gZAQCC/EzyocgIpc67a2DID8/9kkCI
 IUQql844bvqA26FMKjz5t+/SBvKXxqCupQ1v8WZ1MhJwBJCM3+DVdEwdpKzds7iivPm+
 RYuK/asQgjIVDkl9pVciJ5MQK0uqxTyKCnXU9b5eKPZykiFushx//UWIHBZ9MUuykQsu
 WHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779915985; x=1780520785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dweQ5y+KlunnRHzU71+MAEjvJSanMYXjwF+wo7+7lCU=;
 b=rg8VInukVIrnFNYeh9U6TStF7HJKfiwTKjfpjDGyGGabGJ3go3yBd0UyZ2ioUq+4H4
 HB/nN5NwRiz3X0gS2cm9TPhzJ2GKxpcBfzJc4WhmPzUMnRzWHEoe3w0zIVJOhmHhNd6D
 OO3VNTBM94n5c7A8VSYxXqmhNg2527a53XD4tYdyBxiff5x7N5Ytc1nREzbqmNtuHIPt
 mP4P5gQYPx8i7TANhUzYAuImTuklKSmK2f7ykiSQMEgSeW9EkDKQloW9UyfYSVd/2QSW
 rCb6hDBwc2RGjunzuSxPYFqqFCSIwqd1T6goV24J/fqb45G6WI0XUsregCQE0LN4ansj
 6D+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+P8WtBGHFkkenE7MhZQWfeXqZ18yE2g9h79Ni/ihrjdAZ8NPJZPHSAPzuzi8n/ZKdVVRp1g11iiB5S@nongnu.org
X-Gm-Message-State: AOJu0YyVWvbs0E95CsElTgzXfLa9hOQMzYsB5X6PQ3Wsu2n9ZoheaIXR
 dnuH080mz0cfzy+1TrYOhHCpi5vKxU0/yazEqb8YqAEqiBF7djI9+3Mr3WgszHFePYBbVnxzRoW
 3LY50Kc1/lDGeRn9qESe64FnPnYtMvAc=
X-Gm-Gg: Acq92OELDopkJTEvIk90DEC/1gDK2hKiXRb2NsOZOoFsm7WfUTrVFqaE/EcIOO8eJyT
 Y0ogSL+J2AHD8Cdc/SSebFr3JlIcp+WjrwF76afBiYu/k339FuxmUgzA8NJGVEXJ1rb5k/2xZXl
 ojLBx71YlyUqP11Tb9wYfZMFy+S5dgabVX3x2BYkEQfu9SlDoeVwMhuOW7LdbdepGE/YQCqNv4S
 ryWaFwtedM6A6q9vTkGe0tSo5xerqkO2VxaJr8p1Hm5VcQh/ar65sKFBY3Vps6gTOi76zliNVat
 G1REwn3n9d2XKH5aqWqK3/DOnq7nd27dIaack2VivkSoSyVu02qL
X-Received: by 2002:a17:906:4fce:b0:bd4:e62e:d399 with SMTP id
 a640c23a62f3a-bdd25ceb7d0mr1588571266b.26.1779915984628; Wed, 27 May 2026
 14:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
 <20260202221634.GB429972@fedora>
 <36a69637-d7b9-42cb-b16f-473091efb3ee@proxmox.com>
 <aYS_G-QHlbucVpUd@redhat.com>
In-Reply-To: <aYS_G-QHlbucVpUd@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 27 May 2026 17:06:10 -0400
X-Gm-Features: AVHnY4IlWVj3sRm5M2OvPTcnKxt7A7fhdhE7mQp1_1rkNvNTvmvhHm9J-wq4wa4
Message-ID: <CAJSP0QX22xxAq7sYChGMq9up3YOAXuxrbe99_8YoLFV0pKj0Zg@mail.gmail.com>
Subject: Re: [RFC v2 0/6] block/io: avoid failure caused by misaligned
 BLKZEROOUT ioctl
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, hreitz@redhat.com, fam@euphon.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x632.google.com
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

On Thu, Feb 5, 2026 at 11:03=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 05.02.2026 um 13:13 hat Fiona Ebner geschrieben:
> > Hi Stefan,
> >
> > Am 02.02.26 um 11:15 PM schrieb Stefan Hajnoczi:
> > > On Fri, Jan 09, 2026 at 01:08:27PM +0100, Fiona Ebner wrote:
> > >> Previous discussion here:
> > >> https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@p=
roxmox.com/
> > >>
> > >> Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
> > >> enables the BLKZEROOUT ioctl when using 'writeback' cache, regressin=
g
> > >> certain 'qemu-img convert' invocations, because of a pre-existing
> > >> issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL whe=
n
> > >> the request is shorter than the block size of the block device.
> > >>
> > >> Stefan suggested prioritizing bl.pwrite_zeroes_alignment in
> > >> bdrv_co_do_zero_pwritev(). This RFC explores that approach and the
> > >> issues with qcow2 I encountered, where
> > >> bl.pwrite_zeroes_alignment =3D s->subcluster_size;
> > >> I would be happy to discuss potential solutions and whether we shoul=
d
> > >> use this approach after all.
> > >
> > > Hi Fiona,
> > > I wanted to continue this discussion. My thoughts are that making
> > > bdrv_co_do_zero_pwritev() use bl.pwrite_zeroes_alignment is the right
> > > long-term solution to keep all the padding logic in one place.
> > >
> > > On the other hand, your series shows it involves fixing a bunch of te=
st
> > > failures and that's not fun. The original bug that is being solved he=
re
> > > is my doing, so feel free to hand this over to me if you decide you
> > > don't want to work on it.
> >
> > in your other mail, you mentioned you'll ask Kevin for his opinion. So
> > in part, I was waiting for that. But I also was side-tracked by other
> > things, and it will be 1-2 more weeks until I can really focus on this
> > again. If that is too long, please go ahead and pick it up.
>
> I didn't review this thoroughly yet, but I agree that considering the
> alignment from the start is the better solution and also more consistent
> with what we're already doing for normal reads and writes.
>
> We just need to make sure that we use the right alignments in the right
> places, which can be a bit confusing with the fallbacks to buffered zero
> writes here and there.
>
> I assume that there is enough time left to do this before the 11.0
> release and there is no need to take something like v1 as an
> intermediate solution?

No progress has been made and I'm unable to commit time at the moment.

Is everyone okay with merging Fiona's smaller original patch? While it
would be nice to implement a deeper fix, it's better to have a fix and
I think there is no great risk merging the original patch.

https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@proxmox.=
com/

Stefan


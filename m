Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAE1CD1297
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsSPb-0004YR-Qo; Thu, 04 Apr 2024 15:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rsSPa-0004Y9-DH
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:06:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rsSPY-0007pT-GN
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:06:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e0d8403257so12174725ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712257567; x=1712862367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtJTFkU/fjdan9jrn8c75UoJOHghXh5adrn1veWmRac=;
 b=Y/mAnCTGdjx5wriYv2bV6aD/NP5BfaCOQM/0MHjhJdkwdJJg62YVKb+aGFuJjp3VwQ
 aSKVNUOh0qAT7DPuOawVLdvKEviuj4YS6NHnjEreTh3/A7ZToBgUBJ/AGrmAUg5MBs+p
 vwcHrILY21M0Fl/j0LyIXkZJ1q3+CCXDMqzdHYr6pAg5JW0SbYGCn+XxAhFmaHlGd2P+
 7jsavNpsbn8FFIC50i88nqdbOUSSujySs3aJXKT2YzphYOU850djag0tuYuL/LHl7oRL
 2XM3sAYdAXC4V2DJezqE5fZrpJsxvV8oMTejOZFRyWcyyYQx7QYof8apPSZ1x5RD7p8f
 ytuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712257567; x=1712862367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CtJTFkU/fjdan9jrn8c75UoJOHghXh5adrn1veWmRac=;
 b=wiPREOjqmKmaph2FNXrIdgSariBTgNg5KjFa7kLplQQvtP/qZygMT7DjtuRpI2ErQ4
 tAg06gCB2e1li+c8U4q6yF92/z5/JFeN62sdemHKnPxoBUnzPBgEvOd0WK3bwxsIaJhO
 T1Gy2XadEukew6GlxSH73uknAxgNI/X3PGbKbxvOu8Qo/nN4DUA21VCqMmPTqzB5YgCq
 HyxHisSE7HXFoAzjmgYR6c/2ZmoJKlGXNcUjp6+fRwVKWWUPVsagqxyPY6umf6665gtr
 lZq/R2ueZz8XC97hLd7cHC76QuTMc/kdLPG3QUEJ1tohO0BeXIyoG4MW4EwqYvlI1Iie
 HACA==
X-Gm-Message-State: AOJu0YwC3C47DclPRHM49KNuGATcWpOQ41PCCSQSNMMb7OXNHIpkGonE
 zeQl2gQ4XbPVt2J0WgOce5ifwLNPbOo2MyGcz1olGgfqeM6t69Hb
X-Google-Smtp-Source: AGHT+IHzjoEHkkhYMfSTeeJJhUDW9IcBUyMC0UziWSgcb6cYhwBoCIxFC3FF/SSbTp/mVQIixf+xhw==
X-Received: by 2002:a17:903:cd:b0:1e2:7fb2:b0b with SMTP id
 x13-20020a17090300cd00b001e27fb20b0bmr279546plc.68.1712257566500; 
 Thu, 04 Apr 2024 12:06:06 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.80.57])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a170902784e00b001e010c1628fsm16082424pln.124.2024.04.04.12.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 12:06:05 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Fri, 05 Apr 2024 00:36:02 +0530
Message-ID: <3316716.aeNJFYEL58@valdaarhun>
In-Reply-To: <CAJaqyWc+8OJZ33TtqeBy+Vy9HdW8zzbMKqg2mNWVaFda=g0XBA@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun> <1934013.taCxCBeP46@valdaarhun>
 <CAJaqyWc+8OJZ33TtqeBy+Vy9HdW8zzbMKqg2mNWVaFda=g0XBA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On Thursday, April 4, 2024 12:07:49 AM IST Eugenio Perez Martin wrote:
> On Wed, Apr 3, 2024 at 4:36=E2=80=AFPM Sahil <icegambit91@gmail.com> wrot=
e:
> [...]
> > I would like to clarify one thing in the figure "Full two-entries
> > descriptor table". The driver can only overwrite a used descriptor in t=
he
> > descriptor ring, right?
>=20
> Except for the first round, the driver can only write to used entries
> in the descriptor table. In other words, their avail and used flags
> must be equal.
>=20
> > And likewise for the device?
>=20
> Yes, but with avail descs. I think you got this already, but I want to
> be as complete as possible here.
>=20
> > So in the figure, the driver will have to wait until descriptor[1] is
> > used before it can overwrite it?
>=20
> Yes, but I think it is easier to think that both descriptor id 0 and 1
> are available already. The descriptor id must be less than virtqueue
> size.
>=20
> An entry with a valid buffer and length must be invalid because of the
> descriptor id in that situation, either because it is a number > vq
> length or because it is a descriptor already available.

I didn't think of it in that way. This makes sense now.

> > Suppose the device marks descriptor[0] as used. I think the driver will
> > not be able to overwrite that descriptor entry because it has to go in
> > order and is at descriptor[1]. Is that correct?
>=20
> The device must write one descriptor as used, either 0 or 1, at
> descriptors[0] as all the descriptors are available.
>=20
> Now, it does not matter if the device marks as used one or the two
> descriptors: the driver must write its next available descriptor at
> descriptor[1]. This is not because descriptor[1] contains a special
> field or data, but because the driver must write the avail descriptors
> sequentially, so the device knows the address to poll or check after a
> notification.
>=20
> In other words, descriptor[1] is just a buffer space from the driver
> to communicate an available descriptor to the device. It does not
> matter what it contained before the writing, as the driver must
> process that information before writing the new available descriptor.
>=20
> > Is it possible for the driver
> > to go "backwards" in the descriptor ring?
>=20
> Nope, under any circumstance.

Understood. Thank you for the clarification.

> [...]
> > Q1.
> > In the paragraph just above Figure 6, there is the following line:
> > > the vhost kernel thread and QEMU may run in different CPU threads,
> > > so these writes must be synchronized with QEMU cleaning of the dirty
> > > bitmap, and this write must be seen strictly after the modifications =
of
> > > the guest memory by the QEMU thread.
> >=20
> > I am not clear on the last part of the statement. The modification of
> > guest memory is being done by the vhost device and not by the QEMU
> > thread, right?
>=20
> QEMU also writes to the bitmap cleaning it, so it knows the memory
> does not need to be resent.

Oh, I thought, from figure 6, the bitmap is a part of QEMU's memory but is
separate from the guest's memory.

> Feel free to ask questions about this, but you don't need to interact
> with the dirty bitmap in the project.

Understood, I won't go off on a tangent in that case.

> [...]
> > Regarding the implementation of this project, can the project be broken
> > down into two parts:
> > 1. implementing packed virtqueues in QEMU, and
>=20
> Right, but let me expand on this: QEMU already supports packed
> virtqueue in an emulated device (hw/virtio/virtio.c). The missing part
> is the "driver" one, to be able to communicate with a vDPA device, at
> hw/virtio/vhost-shadow-virtqueue.c.

Got it. I'll take a look at "hw/virtio/virtio.c".

> [...]
> > My plan is to also understand how split virtqueue has been implemented
> > in QEMU. I think that'll be helpful when moving the kernel's implementa=
tion
> > to QEMU.
>=20
> Sure, the split virtqueue is implemented in the same file
> vhost_shadow_virtqueue.c. If you deploy vhost_vdpa +vdpa_sim or
> vp_vdpa [1][2], you can:
> * Run QEMU with -netdev type=3Dvhost-vdpa,x-svq=3Don
> * Set GDB breakpoint in interesting functions like
> vhost_handle_guest_kick and vhost_svq_flush.

I'll set up this environment as well.

Thanks,
Sahil




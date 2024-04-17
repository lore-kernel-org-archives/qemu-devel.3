Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C163C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 04:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwwq6-0003yB-OG; Wed, 17 Apr 2024 00:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rwwq4-0003y1-TL
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:24:04 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rwwq3-00086J-9D
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:24:04 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-22efc6b8dc5so3558155fac.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 21:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713327841; x=1713932641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6I/dqOUFxLQwG+T29zUJCJ5m7mRumEM8wP7tEz1yslc=;
 b=lrM52bU9L9u206e4+9bpOAMlvEauIvnanoCv4jQBkoKVfOYCXNmuS0uqsuo85x2kOI
 b5fgoTiyMCKhtGEgIAk3kpuNtjMd4zm2KDBKUnB61umJn97ZCgYlOVVbk9INV+jk6ImS
 /q5iBoeYU6exvOvPfJiwH2IN9I5H653BvZlZ8F050Imt4Z7TAN7ExgRohs9j4JZ7IG4h
 6PayTdbAZpUCHCi+I0eZlllzq5IJ1DGQk2YTgUCDhS8xibaKzkV735rieyvHdbMVKFz8
 73yPEAw03JwGjeWUIuDYjiynpNq0cvo/YyJplAn17m7y6L4UhmAT7dghET0J7ctfWHMS
 QDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713327841; x=1713932641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6I/dqOUFxLQwG+T29zUJCJ5m7mRumEM8wP7tEz1yslc=;
 b=w0tKdwvLo96mirbbS4omyI6Oo65axQNlBJuvN7A4T16fgdJm1P8KaiVF12aAw95d+f
 ODCAXox9lQcyoVfilI+Sbnw75IJp3lijE1E13pjCpnWDYxHWaCbjsDzuXxHTYbNgWzvt
 2pRueUwes9qKW4wlr89T5xNifiILPwwsFWboLjCaUORcm0UbMvtnlUTEGymgLNiAXUk3
 7+tHy8wAkGbrw3Lv0LfLMv42bNLb+ytVzFHk6N4gBjEL7MfgahCaeIGSIvjz+e8cvmDG
 0mrdVU0j4XmCBdp9IlD4UH3JaWM3D+UAjMUQQdVdbYYpV+2VTo2RLykkE8q6je8QzN7d
 AOAQ==
X-Gm-Message-State: AOJu0YyOS5hgvfaNsbqAiBNJzxvvd+OAkryz8+YFD6N8lKo/7Q1NVL7S
 lRBiGM3kKokMJxPfIJSXyf3j07uFrQEA+gW18gbMYixTyuN3oVkL
X-Google-Smtp-Source: AGHT+IFyAUkKutjWiAmE3AZSlQFLyjlbOhCYfApvirPBlJrZeyKilLh3f8vj9lyI7x3XtiLffqgDFA==
X-Received: by 2002:a05:6870:a3d0:b0:234:2ad3:524a with SMTP id
 h16-20020a056870a3d000b002342ad3524amr11445804oak.58.1713327841537; 
 Tue, 16 Apr 2024 21:24:01 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.85.99])
 by smtp.gmail.com with ESMTPSA id
 i23-20020aa787d7000000b006ed4aa9d5c0sm9760587pfo.188.2024.04.16.21.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 21:24:01 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Wed, 17 Apr 2024 09:53:58 +0530
Message-ID: <4912056.31r3eYUQgx@valdaarhun>
In-Reply-To: <CAJaqyWdD7futYvUFt7=zV1xsoBdyAET6mvneOOjR2oob2U1-qg@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun> <5933234.MhkbZ0Pkbq@valdaarhun>
 <CAJaqyWdD7futYvUFt7=zV1xsoBdyAET6mvneOOjR2oob2U1-qg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=icegambit91@gmail.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

Thank you for your reply.

On Tuesday, April 16, 2024 2:11:16=E2=80=AFPM IST Eugenio Perez Martin wrot=
e:
> [...]
> > After re-reading the linked articles, I think I have got some more
> > clarity. One confusion was related to the difference between vdpa
> > and vhost-vdpa.
> >=20
> > So far what I have understood is that L0 acts as the host and L1
> > acts as the guest in this setup. I understand that the guest can't
> > see the vDPA device.
> >=20
> > I now also understand that vdpa_sim is not a PCI device. I am also
> > under the impression that vdpa refers to the vdpa bus while
> > vhost-vdpa is the device. Is my understanding correct?
> >=20
> > After running the commands in the blog [1], I see that there's a
> > vhost-vdpa-0 device under /dev.
> >=20
> > I also have an entry "vdpa0" under /sys/bus/vdpa/devices/ which
> > is a symlink to /sys/devices/vdpa0. There's a dir "vhost-vdpa-0"
> > under "/sys/devices/vdpa0". Hypothetically, if vhost-vdpa-0 had
> > been a PCI device, then it would have been present under
> > /sys/bus/pci/devices, right?
>=20
> Right. You'll check that scenario with the vp_vdpa one.
>=20
> > Another source of confusion was the pci.0 option passed to the
> > qemu-kvm command. But I have understood this as well now:
> > "-device virtio-net-pci" is a pci device.
> >=20
> > > > There's one more thing. In "use case 1" of "Running traffic with
> > > > vhost_vdpa in Guest" [1], running "modprobe pktgen" in the L1 VM
> > > >=20
> > > > gives an error:
> > > > > module pktgen couldn't be found in
> > > > > /lib/modules/6.5.6-300.fc39.x86_64.
> > > >=20
> > > > The kernel version is 6.5.6-300.fc39.x86_64. I haven't tried buildi=
ng
> > > > pktgen manually in L1. I'll try that and will check if vdpa_sim wor=
ks
> > > > as expected after that.
> > >=20
> > > Did you install kernel-modules-internal?
> >=20
> > I just realized I had the wrong version of kernel-modules-internal
> > installed. It works after installing the right version.
>=20
> Good! So you can move to vp_vdpa, or do you have more doubts
> about vdpa_sim?

I am ready to move on to vp_vdpa. I don't have any more doubts about
vdpa_sim as of now.

Thanks,
Sahil




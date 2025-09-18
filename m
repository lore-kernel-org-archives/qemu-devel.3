Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74746CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz9j4-0004sl-4R; Thu, 18 Sep 2025 04:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uz9j1-0004sI-8K
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:10:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uz9ix-0006o6-Cy
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:10:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3d44d734cabso371904f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758183036; x=1758787836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CHB7G7/sCO190/WrnFOgeJOrQFQPkIt6kqTebZaoV5c=;
 b=PtLnnIVx1y1g/J//Jouj+lJ5BFF3YZaZZOGQxyhaZnRkq2cEYIScL6LYv2KCXzLMw/
 mGCeX00wu6iLsKdS5Hzx14fouyzFzUzEw6Y0fywBVayvAfQowdPLs1w9MMZIZbch8Kz+
 S1X8NWHezTtqehomkit7Io3KbvUAWsbS3dLbIj7R/IGMFw+tO8CGB6D3tbdOScuI/hjW
 k4cNqC4CdDVIvQe/c+66lTYnXc74MminAOxK+fya7Wy8/IxMBQjVTaFzXvlxVSuzIP/Z
 Qm/UVbf+iKva6LXbf0Kr1/wfF9hVOcw98tCHINitbo3WJ9dKeAQYuBuh32olBIs95QzG
 xuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758183036; x=1758787836;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CHB7G7/sCO190/WrnFOgeJOrQFQPkIt6kqTebZaoV5c=;
 b=GU/kDTIVWZBtzbYGqQiLgeq1R/EmNu+Os47xkUhfWopW1ODaR4tv6xF9hxEBw0dRp7
 64iajinGsSqK7x2PP9N0saSN6mW12t8/11FVhY1nSXR9+R33Xzyk7EYhZicuoEk2dqbx
 S0a+t78DDnpLAKogoWbVw2nFLGnbozg5+X6/q4IDkR89kOiXq4VU3ZFS7ocQ1veokupD
 wmLibA/Er7k43DGAN5XKfEYNAAfKEZUEVLnfhTh9hVfMsn46+iMqBZcIO9eBoIDdLV7n
 QvFgidG9mQecENIE2woL/HEADr2zkcAZnFNfZs7JuVsO2VRHh6GIDoCIDL225TBuWm6O
 60Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGCiPpYm6/8KizOPIY0azzkpRv+6shcMekugQiYezdU6WJMhUAe4XMSvhzMPnu4XHmdPVnCNigILjV@nongnu.org
X-Gm-Message-State: AOJu0YxgTO5h3N+c1ynjVamheXEf2iLsN1Li+plaphJvXuhOPTeGuD4D
 Taq/cfYCV/gE3kXrslnPiuz8OAQCf2tR9NDYzhO0NEx5kvaU/ki1+3aK
X-Gm-Gg: ASbGnctFJQIM9cAf0VWlHgiVetxrKvNJxtDbiUO1HvZcmaGwwdYeJbyupb8/LhOncli
 k9g2fwh//VGXt2DPhkKs+T5BLmb2RpiF4sK9eHFgJvD0ISx865l5sLBdbB5BBzyWl7CKNSaLsc2
 lmDvYQY6K/HR7MNSHd7cPIG76Y/Ds5DIWL6LUxDuAcXpW2E6Szyui7pw9g8EPf8w5NYBko1qjZJ
 nEto340kne2DzhCANjRPGhf9mNfr5TRM1jcs65Q3w+0h7WgN15rteIJ7W35bw6MvaMqvsfbcS5r
 ynSWYpCiohmo+qKWOVducFboSnFL4HKgTYI3S+qUCILHn0pDz+LGbP3CYZpj3AAQidMAXBfEoPv
 e8nWgPd9lgaAtyXTYIyapVxPmYdHu7VGNFJ5YyK3Ea+9ACmT+6qKMtIQ07F5eDmypOHgDSe6yQ9
 8Gm1c9
X-Google-Smtp-Source: AGHT+IFRuBLZtHmJcnBj+fXzKfSuv+QpLjAJNiWLnvXGJrty2jyZl1e5XEjJxLiwqHe6RhwCkWYHPQ==
X-Received: by 2002:a5d:5f54:0:b0:3e9:a1cb:ea93 with SMTP id
 ffacd0b85a97d-3ecdf9bb0e3mr4764675f8f.21.1758183036189; 
 Thu, 18 Sep 2025 01:10:36 -0700 (PDT)
Received: from ehlo.thunderbird.net (37-48-56-34.nat.epc.tmcz.cz.
 [37.48.56.34]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbf286dsm2459310f8f.56.2025.09.18.01.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 01:10:35 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:10:34 +0200
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: amit@kernel.org, armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, noh4hss@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 nsg@linux.ibm.com
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
User-Agent: Thunderbird for Android
In-Reply-To: <49e6a105914fe0dd3b3476c1bceaf2c7d1f92824.camel@linux.ibm.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
 <49e6a105914fe0dd3b3476c1bceaf2c7d1f92824.camel@linux.ibm.com>
Message-ID: <0888CCA3-F5EA-4A8F-8E8F-7C29337C5CE0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42a.google.com
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

On September 18, 2025 9:53:27 AM GMT+02:00, Maximilian Immanuel Brandtner <=
maxbr@linux=2Eibm=2Ecom> wrote:
> On Wed, 2025-09-17 at 14:31 +0100, Daniel P=2E Berrang=C3=A9 wrote:
> > On Wed, Sep 17, 2025 at 03:09:50PM +0200, Filip Hejsek wrote:
> > >=20
> > >=20
> > > On September 17, 2025 11:39:55 AM GMT+02:00, Maximilian Immanuel
> > > Brandtner <maxbr@linux=2Eibm=2Ecom> wrote:
> > > > On Tue, 2025-09-16 at 00:02 +0200, Filip Hejsek wrote:
> > > > > On Mon, 2025-09-15 at 18:34 +0200, Maximilian Immanuel
> > > > > Brandtner
> > > > > wrote:
> > > > > > Update the terminal size upon SIGWINCH delivery=2E
> > > > > >=20
> > > > > > Signed-off-by: Maximilian Immanuel Brandtner
> > > > > > <maxbr@linux=2Eibm=2Ecom>
> > > > >=20
> > > > > I don't think this will work, because SIGWINCH is only
> > > > > delivered for
> > > > > the process' controling terminal=2E Unfortunately I don't think
> > > > > there
> > > > > is
> > > > > any way to get size notifications for arbitrary terminal=2E
> > > >=20
> > > > In that case there are two solutions:
> > > > 1=2E make qemu the controlling process of the pty (this has the
> > > > disadvantage of QEMU being quit when the pty is closed)
> > >=20
> > > A bigger disadvantage is that a process can only have one
> > > controlling terminal, and a terminal can only be the controlling
> > > terminal for a single session (and only sends signals to the
> > > foreground process group of that session)=2E It would require forkin=
g
> > > a process for each pty, and I don't even know if the master end can
> > > have its own session=2E
> > >=20
> > > > 2=2E create a timer polling every eg 100ms to check if the winsize
> > > > has
> > > > changed
> > > >=20
> > > > I would go with the second approach then
> > >=20
> > > Me too, the timer is a bit unfortunate, but it's probably the less
> > > bad option=2E
> >=20
> > I don't think we want a timer polling for an situation that will very
> > rarely arise=2E=C2=A0 We already add the 'chardev_resize' QMP command,=
 which
> > is
> > a good enough way to kick QEMU to re-read the size=2E
> >=20
> > With regards,
> > Daniel
>=20
> This approach would only work with libvirt and not generic pty
> applications though=2E Perhaps a bool poll_resize could be added to the
> struct Chardev which is disabled, as soon as the chardev_resize QMP
> command is used to avoid race conditions=2E

Well, terminal emulators that set the pty size typically create their own =
pty
and control it from the master side=2E I don't know what pty applications =
you
have in mind=E2=80=94changing the window size from the slave side is somew=
hat
atypical=2E Applications designed for a real serial port probably don't se=
t the size at all=2E

Regards,
Filip


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9BCC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 03:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Xtu-0007mw-P5; Tue, 07 May 2024 23:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1s4Xts-0007ma-VH
 for qemu-devel@nongnu.org; Tue, 07 May 2024 23:23:24 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1s4Xtm-0004lT-Cx
 for qemu-devel@nongnu.org; Tue, 07 May 2024 23:23:23 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c96a34a263so1251347b6e.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 20:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715138595; x=1715743395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yv+RsNIPClsAVJmqURHVjxgBhRoVw6sqF/5+enaqiCI=;
 b=W3/Hp4p1axelXf/xf55VdBhL7SNU314MsDJEy+iv+Tyy3txRuelS7rEqZy/HLtYKTh
 WLH9430K+4kU1q0O03tk7/tkT2WAMWD9F2ONReL9DSWzkQ4wTMGvx7bBlzAEu+8aPZ56
 9tD3HmIXTJ+S7tAaGcwCmaOUGtXFP6wL6IrCbQQLIcIZdhsbZcT2aeQ0wFFOF/2qiVeG
 Wu5zJsYkYJ+rjMin1bSyxbz2YG99IVgV3pV81Px1abqPg1X59/h8kt8wO2EcuSwcsPWz
 aY5VBEGvNm534+ZUg7C5cUyGGsOjgmof3bq8FUOAsc5allOSAz7qA0SRUR+dIyQm6lKc
 tUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715138595; x=1715743395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yv+RsNIPClsAVJmqURHVjxgBhRoVw6sqF/5+enaqiCI=;
 b=JML27fiQmoOvkAKzzAHqcV3wb17f7ddWUACUJR8YzrT4zMZ5Ne8Iok598qeccwIceE
 LoBna2J8XW0vdI5KsZBJ7cKjZtOIW3ap4Lax5XEuodPk5j0J61XY0FWwVkgaXtd9aota
 RMe1xIcaUgR40ZoJ0E1LbCWwu8TS8ib8VHjB2LIXArMKBPpoAdvD9Tr+sOISvmIYvw5C
 eOXqB4Q2djDwozne8XdFt+iTXV0zvI/nwOOD+KABi9fL6sofFRkIKK2Ci8BbQjvJ6g2B
 CwUYTAyG4pAr+BLTnLvcsqYY+RQ4M6hOTXVev0B8LoQVaxB3WNoBROddPFHM8cZNEtUL
 Jcvg==
X-Gm-Message-State: AOJu0Yz7IMAgZrLpY+VC1ai/KYTXZ/std5iijTzmBr6P55rW3vNk4cjW
 Pg8pWZzxOtnkVLINSKuSoRaD9wN6R+Opfchl3hg3hk97Dymbmjyx
X-Google-Smtp-Source: AGHT+IHc7gmhjrGQsrqKSsB0GWMb7KbAm/hkBsJtQEO3KNxSx+oo29DA+LnEYwVEvwrAgrL/ERTOUg==
X-Received: by 2002:a05:6808:492:b0:3c9:7066:a49b with SMTP id
 5614622812f47-3c9852c5d80mr1462939b6e.30.1715138595483; 
 Tue, 07 May 2024 20:23:15 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.84.226])
 by smtp.gmail.com with ESMTPSA id
 a14-20020aa780ce000000b006ed38291aebsm10482371pfn.178.2024.05.07.20.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 20:23:15 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Wed, 08 May 2024 08:53:12 +0530
Message-ID: <12430761.O9o76ZdvQC@valdaarhun>
In-Reply-To: <CAJaqyWeYtyfGav9Ppx=FgRg_Gzucaoz4T3kVi9EbzrDwwEBsyQ@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun> <13514535.uLZWGnKmhe@valdaarhun>
 <CAJaqyWeYtyfGav9Ppx=FgRg_Gzucaoz4T3kVi9EbzrDwwEBsyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=icegambit91@gmail.com; helo=mail-oi1-x232.google.com
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

On Tuesday, May 7, 2024 12:44:33=E2=80=AFPM IST Eugenio Perez Martin wrote:
> [...]
> > Shall I start by implementing a mechanism to check if the feature bit
> > "VIRTIO_F_RING_PACKED" is set (using "virtio_vdev_has_feature")? And
> > if it's supported, "vhost_svq_add" should call "vhost_svq_add_packed".
> > Following this, I can then start implementing "vhost_svq_add_packed"
> > and progress from there.
> >=20
> > What are your thoughts on this?
>=20
> Yes, that's totally right.
>=20
> I recommend you to also disable _F_EVENT_IDX to start, so the first
> version is easier.
>=20
> Also, you can send as many incomplete RFCs as you want. For example,
> you can send a first version that only implements reading of the guest
> avail ring, so we know we're aligned on that. Then, we can send
> subsequents RFCs adding features on top.
>=20
> Does that make sense to you?
>=20
> Thanks!
>

Thank you for your reply. This is perfect. I'll start with this and will
send the first RFC as soon as possible.

Thanks,
Sahil






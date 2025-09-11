Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE65CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uweT2-0008Nf-Iy; Thu, 11 Sep 2025 06:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uweT1-0008M3-AS
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:23:51 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uweSs-0000dM-Us
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:23:50 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61cb4374d2fso808568a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757586219; x=1758191019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wU8niMhFnqL1Dj0pnnvP/M2XkMpeaMP1pOvcmYGmUlE=;
 b=Py9RinS/KoGqNT0X+jLpfWLdFeh7aGF/RsGLR5W2944ZBeiSqrD1d6yFM6AdRyIDtb
 fxD9pYf1FPDckKtdUTD7B3t3/9UnscEGft20tOPzOAyPth1Neil4BkpyNyokaP9Bq8oQ
 5IuxmmA15AAymAfiOyfrj+AZZYTFrI4cXN8SpfZtG3a8oKPPRi+DKiNH5/tvIAG69nQW
 n+ydJS+/DBeV4u9DU7AUwT6C2ii5IhOP2j6Jus7niLjHw4lWeVE7AZ/YMS5PmDTNzSvc
 kZ8P9xIcFQXWs7XwEapmESet6YJzUGtC3CRF7JHRympgAFqXIczLPTkhqkgfMGMtnaDn
 qXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757586219; x=1758191019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wU8niMhFnqL1Dj0pnnvP/M2XkMpeaMP1pOvcmYGmUlE=;
 b=cwPnzFxJGCi7AgINzY+z0Kdoj7Yxgy6iYuJEMsFZs/xq/APU0lYf0S3D7IX1Hpohvi
 1JcNPqUxafE1QmB1BtE5ambk80Knseq3c82lAntWGgdKB8ct/bpUegM1O27oWxUAMh8A
 iTIY2JAAbU9VWPcUidtQRMHE2ylZM+sHiqBjqJaleKyRWi3oijRWLPehMhbBDCNrxkFP
 K9LJaAQ9oR8Yc547WhtC6HClY9uKD41Quw4Pj4PAWYQOOBccgR6lYd+KjF1+2mXwCZmG
 m0EcYv74IfbjOBs+G3hmBv8KQ8jRb7RhoAGPN8sYmLAW3DaOVpRCnIg7h4/EYkiuXJbF
 ijFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS1DLX9+KLZwG/sFb+291yFNiSAJzAlX/JapNShDvHVzU6c6ionFzYxMIKARiCIxYqCBJ/HBOcRHVa@nongnu.org
X-Gm-Message-State: AOJu0YzzuPSTWmh4QnqotmTqMeTQ3mXh82G5dOpUZyHgaB/ifD6cNfxp
 6d4zGpYa4mMlPSmgSPzft+iV51OFnUSn6O1L/eEyxFP3NMLE0KE7/lg58LflyTAnIc8DgpljgML
 Q6742bge81hdlISHcBPLuaSwZi0F/pz4=
X-Gm-Gg: ASbGnctV75Y7IIgBQHiZA8WRlvw3c/HqV9CaqW4+fgRBaCff0DCNT/XfO3oEKKY6doF
 /nEmqzurXBd25QAtsezxAiohWVBQkf0hUhPHjbRKV10MtQr3r3KWU6TgSWD7rJGE/W1UGi6QA68
 vZKsd/eK6V0iC6KQcOEZyu5xRD+jwG/aG1n0szu33UZT+75yyukiTO7VTNp4nAgiL14hw6g6PkM
 3RQtvZxOYkVZMq5F6zrU/0OCHI=
X-Google-Smtp-Source: AGHT+IF+LpYqk7Um175vmwip0UO+yAzy1t5JE8Eg8gJa/JuK34dP+8jIxL21fx56jnwyHpN3PecGZIhLYNJAdFtB0Pw=
X-Received: by 2002:a05:6402:5508:b0:61d:cd5:8b72 with SMTP id
 4fb4d7f45d1cf-623801e798cmr15379223a12.31.1757586219277; Thu, 11 Sep 2025
 03:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250910210849.GA379545@fedora>
 <8623c898-a0e1-42d2-8afa-35b64e41cc50@linux.ibm.com>
In-Reply-To: <8623c898-a0e1-42d2-8afa-35b64e41cc50@linux.ibm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 11 Sep 2025 06:23:26 -0400
X-Gm-Features: AS18NWD4U8dtshF5d0FQhsv64Q51ymKBXiPyTq_sKUFzNtSy33KJ5hCuTzR1P7o
Message-ID: <CAJSP0QVfaFjtuDqSiEozOmPVUMYzXWaSO21qUp1pHAgo1-Uvqg@mail.gmail.com>
Subject: Re: swtpm persistent state snapshots by copying .permall file
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 pkrempa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

On Wed, Sep 10, 2025 at 7:14=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
> On 9/10/25 5:08 PM, Stefan Hajnoczi wrote:
> > Hi Stefan,
> > I am investigating QEMU devices with persistent state like swtpm for a
> > specific snapshot use case. The VM is paused while disk images and othe=
r
> > persistent state files are snapshotted. This creates a crash-consistent
> > snapshot similar to booting after power failure on a real machine. No
> > RAM or volatile device state is collected.
> >
> > My concern is how to ensure the swtpm's persistent state is captured as
> > consistently as possible, but I'm not very familiar with the code. I
> > wanted to run the following by you:
> >
> > - Using --tpmstate dir=3D will write the persistent state to a new
> >    temporary file and then atomically replace the old .permall file usi=
ng
> >    rename(2).
>
> This is correct for the directory backend. We also have the file backend
> where a single file is keeping all the different types of state.
>
> >
> > - If the VM is paused and a copy of the .permall file is taken, then
> >    this copy is consistent. It may not reflect any in-progress changes
> >    being written into a new temporary file, but that doesn't matter fro=
m
>
> Correct.
>
> >    the snapshot point of view since the VM is paused and it hasn't seen
> >    the completion of in-progress TPM operations.
>
> >
> > - The .volatilestate and .savestate files do not need to be captured in
> >    the snapshot since the goal is just to achieve crash consistency.
>
> Yes, I think so since the .volatilestate state would be written only in
> case of VM suspend or migration and the .savestate only upon suspend-to-R=
AM.
>
> >
> > Does this sound reasonable or have I missed something?
>
> No, I think this sounds reasonable.

Thanks for confirming!

Stefan


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240B9C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 13:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPhYJ-0005So-1g; Thu, 12 Jun 2025 09:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPhXc-0005Nu-Om
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:00:27 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPhXV-0003CE-9R
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:00:24 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-607c2b96b29so2011508a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 06:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749733211; x=1750338011; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtHPaKU2swfiVtNZCe1hgNgb9zwNe7AXH3+ob8/iKlQ=;
 b=SIAUYw8mULpWezaCx9HqrJkWHpVZLXHUjsdcsI//sPSb5PZcfn4hN+gtiPDEsfLTmn
 t02tGRe+17vBsgywI8fcdFA94/6m3p4MiPSkxj1IIITxot/2KqsI27l6xksgFhAuUvUJ
 CRiXzzHBHFe3beFTOkLkcXo2gs2R9s8TWPRiEq9e5bx6DnkXtViNNS0KeUegdG7yQyXA
 kqUbXOQ1l5tdfswnYNM5+GzHC0zxFaUE/k3FVUClGpJe3/02x8RTLbzs7EVRrtM4925q
 D/oKhPT2JQsyJPqIGpwd+ivdTtzbp6vCdKi5bwJGrWZJJoE7JmWtnMBTFsJeYYdLqcvu
 H19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749733211; x=1750338011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtHPaKU2swfiVtNZCe1hgNgb9zwNe7AXH3+ob8/iKlQ=;
 b=qyhPorcUxlZJNfAcz57zpZFtZ0FZmp9MN9mgBZxe8YWIeRKerj91CS+mvMXYKRsC2e
 2cSy3zqEYAkS0/U0l0/QfkD1JmVUMyViyLo9vcPVH/J5RSg4LH3zaZXEghl3xGfz0ai3
 87UMIDj+0LXvmC3IZ4XzJH4Vrw8RsogOLXAu+HaooVPZLw86hlQZyvK7VxW+FKR7Bxw3
 iYuGwRQxBaWms/biX7iqo8x6fHRtKHMZbDz2qU0t0pGE+ZsShqwzpsA353YQbyvRx7uF
 WJ5HAtwNX1kABUhJMTiGd8m8II+Y4uGwZFx6JuZy3CxCiZMtOzvtAeoQPtOgyjJAXUKu
 b7Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0a5jax7mW+Wrr6FxjnUJGgPKbv3gRqohFXvGhFP3wgWlc44AKNyA1L3Nyh9l/rtgh8oezUUazF579@nongnu.org
X-Gm-Message-State: AOJu0YzQTtlEidFDZ16YJXC9/oZ9xDiURNS1QsAIKfV8XTWYawoHEVwL
 voBL48kc/bn/2WeEnvCJnOvqW+Um5RDtSh4HhJBHenIRsG250IcsR3G/2MUAvCq+ypZGCiX9iCW
 B7+1m/M4wXAl2qs6o5Zos1zpVM9z7KPc=
X-Gm-Gg: ASbGnct/ZQz0epkbqcevW+S2ICISgWCW4KO8jgsGEk0QexMw4TDXkPGdk7yh3BRrd9d
 EXxBfjY1w6guQC2eFWQZT5TLEj+ED/DGLqey3BLVhpO2w5WK70i1UHEUbM7QlwqQiVXXJ4uTkal
 +yzzFgXWCRhbPjYATvJ3maE90uTV0vU6k7FdQUuhCTaw==
X-Google-Smtp-Source: AGHT+IGM3wg0a83urfBEgAIRBD2I3C5xzwu5gPR7yco04mldQfKcbXUB8nEluy9YGmyfPeZxV1IpGi/sJGUlLOIJxFg=
X-Received: by 2002:a17:907:9414:b0:ad5:5b2e:655b with SMTP id
 a640c23a62f3a-ade8955ee30mr778567166b.25.1749733210844; Thu, 12 Jun 2025
 06:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250611075037.659610-1-kraxel@redhat.com>
 <aEnEiqfa57eH53Gf@redhat.com>
 <CAJSP0QX7pcNTz_uSdMBzDhTRbUkrmmSPziBs82-GscRHM-xiug@mail.gmail.com>
 <aEqo-1g4gL0QXKWe@redhat.com>
In-Reply-To: <aEqo-1g4gL0QXKWe@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 12 Jun 2025 08:59:58 -0400
X-Gm-Features: AX0GCFvj2GIsZs-Cl5u3SzC4L625K_j51igU4E2_a6JZS_AU7bWUdOO4buiotQ8
Message-ID: <CAJSP0QXFX9QBCu3h_Od1YeqTnB7gOUKRQ8ipnyKGxtY29kGA_A@mail.gmail.com>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Thu, Jun 12, 2025 at 6:16=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Jun 11, 2025 at 03:21:38PM -0400, Stefan Hajnoczi wrote:
> > On Wed, Jun 11, 2025 at 2:03=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > FYI, this seabios 1.17.0 release appears to have broken the
> > > ability to use virtio-pci with libguestfs+QEMU:
> > >
> > >   https://bugzilla.redhat.com/show_bug.cgi?id=3D2372329
> > >
> > > so I'd suggest we hold off on this pull request until
> > > the regression is diagnosed.
> >
> > Thanks, Daniel. I have pushed a revert to staging.
>
> This has been diagnosed now.
>
> Old SeaBIOS would unconditionally add ACPI tables, even when QEMU
> machine type had acpi=3Doff. libguestfs forgot to ask for ACPI in
> its libvirt XML, so was getting acpi=3Doff as far as QEMU was
> concerned, but SeaBIOS was none the less creating ACPI tables.
>
> It was a miracle this worked because the ACPI tables were
> designed for i440fx, but somehow Linux still booted with
> them under q35.
>
> So, the SeaBIOS update has a functional change, but that
> was intentional & desirable, and the root bug was the lack
> of request for ACPI in libguestfs.
>
> So no need to revert anything

Thanks for the update!

Stefan


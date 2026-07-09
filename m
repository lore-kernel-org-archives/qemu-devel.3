Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7344FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whhIy-0005s6-32; Thu, 09 Jul 2026 01:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whhIw-0005ri-VZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:28:10 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whhIv-0001J1-3j
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:28:10 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so2543131a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783574886; cv=none;
 d=google.com; s=arc-20260327;
 b=bZCOzdTmIjaZTbWzmZzvmbhTsJjml8CT8VfzBRaUFsYKXJfP4scnSZTNFwMtnPRWAv
 ilQZs3cNDsagOuoPtsRhJI4hyhF30cpgICxV/0LVh89pfNxw02Vw8isENoZYZ8SId/jB
 5vjIOcP5c9Kr5G+JTB2LOVZNhMWCj+e4IyNt2+XnC7FqpNQET0rH25KcQQVP+tW3dQ7R
 0xzT5BabdGKoaXYzUD3fQ4vPA1XvSHYKbuS9/3Y4jxiyGh+3kIYylIUYp+hjGoNnkYE5
 vcG47etAJZUTKwTHEs54gdinkmLVMpwenyfD0/3gj0SrvdSC9BEG+N5UV+cCu6ddw7WG
 BRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GEG9AOlDKvTNKW9IjjtgwLywg0OEIxdSwQKm/xBvpEY=;
 fh=YD0a5y5+QjJ7x+PnsoTqWoECzFnQiiTFu/ACkTF0P3o=;
 b=ntjZaAanuTushhsWokFvVM5xm/6pVHNhMrs4cXg5w/SOssFrLlZY9dknta5o5cR9b9
 9DEYsaVc2fLk+/qlnQy035bPD5G46DldiN026us8RLkM6E2CIso/wM/yeW6uYSslU59N
 wocV1QoonpXYqA4zS0gyhfgMP+c4dkJinkq9ih3+faCik/sYPJ4P/9ilAL1+J+DgeNvO
 nihjbgBEl9MCZeOvSFo8i5B80zp3EfS5z9XtXF4vAOtQ9cZ7faQLrh+Yi3FR826kPgNC
 wWiCn7t+oF3Pga7G2CnwLqG2iKa7yjclnw/UJ3IVmdDq7hfZigtOzbCBuY0GxayZ0cFa
 xN0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783574886; x=1784179686; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GEG9AOlDKvTNKW9IjjtgwLywg0OEIxdSwQKm/xBvpEY=;
 b=j6cqytKoissWLIMmiMvUhJyNfXYo5a/nkwctScbtELikt+7ytUzzUSNWOynlRyr6WH
 pCzL3qv+tmOOlm2gAOUCHHr3wSSNFsZcvsxhdhhG9fKbYqtQZAGOycEAgvTd/q68t7lj
 P7h1mQxu0IyqUSLOLQcqVnuS7NR0bNBpIq7gr1EsXaePp9xm8WyW7iBGjCKwTEzLiebA
 NJFfj+H+8Z4X2wmKmy5dOeOPabHOuwsp7GiUALUs5996oyhfRxa1XMqYG4xE0Udnjj24
 93SM+i+pLUpvlOFBXds4IasG5RBka+NMVXNq7/vLp3/hvgmSvhj5S3/AEpp4nPq8VAoo
 sCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783574886; x=1784179686;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GEG9AOlDKvTNKW9IjjtgwLywg0OEIxdSwQKm/xBvpEY=;
 b=nkty4uA15prR+zP6SzLTH3zger5wAnqoD5G8Q2dHOuZnTPB0tjkTQ7s616U5sTinP3
 lEj3CZD85sBAR2TB9sZRieNwf5ndND8/X7QV5p9RHWLH4f9sXILqFie/GcsTgKjzMwu0
 tZZnG+4wEW859L4L/eYchkN9G06CyoO52b2p1m9Xr3mSQtzZC9E6gF/TVhSmnSXAjxXX
 aMzlkAPpVv82z2cd5toMGTA5WgC2ZsSc/UiGwN1IaVTmFi02qmM2Bl61RSvhIkMHLh2v
 v9+Eic7C13gCRspWtYG0c8BA8rah4IRibetigONBGBlSjzMIcnODN7y0JgSBIpbGe8ny
 bh0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUELLNpSAFSRAw0zAPXC4FEf3Rn0Czv8WVFVdVVQs7i+Rjit0MOymhGkDtxD12ll8HFFwRacQyvZrY@nongnu.org
X-Gm-Message-State: AOJu0YyiIOPIybevAoW4PBk/kNIuDYMmctQHqXDQqdEApvmQV+FOqKw8
 hzQlqD342WsmKIHU6cjhv5+J7b7h1gCsoeqskKwjqqSbxsUIcJ5dnIeCrx7dA7nFZxj4XLm9OTr
 RLfrYmRchP3kNUiow0vUvoETHVnBF+10=
X-Gm-Gg: AfdE7cl9vGNTg48Aj41vJ+jwHNt/PAa6tCmc6OR2S6Abicxdt3nNIcUUZBcG20ZG4dy
 VpoNrvcO10NkCWiRQvwHc8eAsn+EH0PYDMXASSBeZk1e30qoP7+7uQHU0aSFCLFBqbBGCHYO44g
 LmwttLamiFYcRAwMYccQhTGtSFMSRlPH84pB7Uzh0Z4wCxT1zvy19EKaHorXMeN7DwXfZPL0xS0
 Z/EAFrkM6PKFc0j31IFaGtCHD1yoesAg/I/erAAjdhlu8zY092XPwQ8BzehFTefs2mM3HeZqzor
 6GTnUOn4YJe3AvAaNS9kDIPQvEeOaHfeaI/qBA==
X-Received: by 2002:a05:6402:40c5:b0:698:b1bc:ed56 with SMTP id
 4fb4d7f45d1cf-69ab43eb949mr2340151a12.0.1783574885947; Wed, 08 Jul 2026
 22:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 15:27:39 +1000
X-Gm-Features: AUfX_my3NAcNKENK2zuQG2Fe1q3uxwbDRhvh2OahwWG-ml8xPgufs8-b3v2ufAM
Message-ID: <CAKmqyKPXU1vWK0EqsR=3fF6DM8W5erq1XZuwH2yYSQ9s3m6+hg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] hw/acpi: correct field sequence in SPCR table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Sun, Jul 5, 2026 at 4:31=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On LoongArch and RISC-V invalid SPCR tables are created:
>
>     Terminal Type : 00
>     Language : 03
>
> The correct values are:
>
>     Terminal Type : 03
>     Language : 00
>
> This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
> SPCR creation to common location") that swapped the fields.
>
> See the specification of the table in
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial=
-port-console-redirection-table
>
> This page shows version 1.10. But the sequence of the fields was not chan=
ged
> since version 1.0.
>
> Our LoongArch and ARM code uses version 1.07 of the specification.
> Our RISC-V code uses version 1.10 of the specification.
>
> v5:
>         Include
> v4:
>         Reproduce the test data changes using rebuild-expected-aml.sh
>         creating the same diff as v3 but in two separate patches.
> v3:
>         Add test data changes
> v2:
>         Update commit message
>
> Heinrich Schuchardt (3):
>   tests: allow differences in SPCR
>   hw/acpi: correct field sequence in SPCR table
>   tests: update SPCR loongarch64 and riscv64 test data

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/acpi/aml-build.c                   |   4 ++--
>  tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
>  tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> 2.53.0
>


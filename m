Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EAFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 01:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgYJc-00010Y-OW; Sun, 05 Jul 2026 21:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYJJ-0000w1-Nj
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 21:39:51 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYJH-0005gQ-N9
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 21:39:49 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698bf7a1a2dso4108717a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 18:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783301986; cv=none;
 d=google.com; s=arc-20260327;
 b=DHLvgH6ZWhtR75KOd16tJ3NsrzKSx6thVmENA9rxMVKs3FFhQ2icujNwd7nckIvG7u
 5WKSQ5fBTERo3HtN4P+mz0D14HImdEXDK+N1CbAO4A1ndBH1mIC+9uv9agpxKhtQKD0N
 vOiRpG0zj3PcyXaXgMPmz2gkAz3x3btcZOymw6fpZXzjLV4/ZTkD+5dbXTr2j+ShQly4
 dVaQ4kjHuxdLTtDdc3oH3jxQDJTphgM1z+fDiqT/qswWZXyEK9BB4rSyZhaoB9hn/ITV
 t9DXXbYKI0K49PkQontImGIgWMiFwsG0nc1UPcjYuX6Ej7kna90GlMRC+AKJ4BYcwos/
 MQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=72ONWUF6Ahw7gryFCadNrVmp8t4yzRMx8GKMaXFGXXo=;
 fh=2kTt4PqxNmUDFgeKu2WkF6bswwkUWUJHRNw52r0PwwA=;
 b=WubEEbu6kgnoDxGcaIHjLC/APc7R+RhOUEYpQG6Z2sN5bukbiO8vWMCcdNBo9KH1au
 vinKC2XL/qXtcTBFQLgOnZHaKwOiHZ3Co6k00oqRskgOyZNNBlbanITgeJi54zn7JI5x
 Mavh4NqvK1AWAOofH7lZsQjclNcalpl/yQ38/D7shCHABEa4nOy8sV5cm5faH/wE1Tza
 CfM+LmiAQwtNBvgF8RLzp6VwcEjJ9C/TBRFcLtneSAwnd1I7vlNjv6F2/ne7Rwgqh3e/
 SVM7f47wYUr/CwCmV7jiRAY2lbTcFt0Alx3Fy84WwZ/34i7Kcrc0LH2UMrk+kG6QorST
 qfEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783301986; x=1783906786; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72ONWUF6Ahw7gryFCadNrVmp8t4yzRMx8GKMaXFGXXo=;
 b=gcEXBCsXqszbTn/zVxFTZ8c9dK19j6n5FZ5Ftwa1lDV81boIkfaGYQXBkxqXx4gGuY
 JsTMGGgeL1ENRPzirJ/5a6Pc2AvDTKS9rP4R92umEwnleOmspBajnp1+nPkdX2/67zRB
 EPv4pOFaVUUkqjNmOxpicGw6tVDFybQrF3BS2eR6VVT+9lRhU3K8iAYGS9k+yU88U3+U
 LhtM3mXoWoBB+/wpBFfoBvemv7aJT/jexPvMXw2hx8yLhpafJk4Rm5q22j/TRNS8lhYn
 x9S36fbWOoZgdtUfyQgHeyXl+lIrp4mqEl4YrjyDe3UcWttgNfriyoRt5hc/tE1qFmaA
 4Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783301986; x=1783906786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=72ONWUF6Ahw7gryFCadNrVmp8t4yzRMx8GKMaXFGXXo=;
 b=TvcuWZXowjg07qI0Zjw22m8xmR2sONsmrFE1/zLnyocS4nil52yQL3mORWeEcV8hAe
 S5hs6HYAMMXMspypXnwhJ+NrBiEObqHVNt4OO1+kVUJlJjlNnxD0rq98tELUw7kWrys7
 MAw4cBvtIC5MutNMiJBMuTPh7yuJVUzU5VlYQiQde6Be0+MrBGESX1ZLal2HB1PI8uH9
 sJuHBcoPKOm1y9RRlPzAs9M5+77gBFV8QyzfEAkzmKtsx58hOtSDVUZ1nzccaf1Ep4A8
 TaLxuJ7uf1Wnv5Hp3tfyvBjcQ8df6kKjvMWynp3UaD/pTRo54sCrqT22wM1QORi2xnwI
 GPzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKMbKNAkd/UkJK9UtTP+XrrpC0Rrpy+EIIWal/97IXlvHCySu5DDIWBzs0FU3kf2OxhcPP77Z2yc4q@nongnu.org
X-Gm-Message-State: AOJu0YzYzNR1lt8o/6j8eiclEHIOyhPzDMeTX3lRV54StuXohb0iBZz7
 w2KQAnjEDseAXN4urcoWvT7NDMNr+oQrkoeft8cKxuN8pRa304k5rxDt/SIF+JyKQQ9ZGigZ8dD
 elyq8xT5JuAVZSIBDuFNyFbGq3kxcQZDJ6RAp
X-Gm-Gg: AfdE7cmZVE7PANFsw32S7so55UdDaRATsejZinsonpHqajOVFFT6lowwoeZ72ZbEZ/x
 lpa8wD6lUu3tor3No0v11abIOEHjO86t7Fr3a3ugco/0AQfcS59Q1n4u0Jnr4Z+7Bs7SIDIgnfh
 ZzVcJRsSzh+uNLtj9v1uf9LRLaolL2TfZXKDrmJvfkBmhxF293ESdjyDSNaayW0rzwPUFw/fD1z
 5cCRKSfV3/o9nEYFQeuYlPpmqHNyky3YNNaOyHv/UhvXe6+HQm4DeyZuQsiB/xVc9KPj3MHDq3y
 5ka5MyW2Jwe6is6WEu6kgieKj5g=
X-Received: by 2002:a05:6402:3596:b0:698:36e2:f5e2 with SMTP id
 4fb4d7f45d1cf-69a1a263a52mr2713607a12.13.1783301986371; Sun, 05 Jul 2026
 18:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
 <20260705063147.199732-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260705063147.199732-4-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 11:39:20 +1000
X-Gm-Features: AVVi8CerOwyd3fGe25LSeyDBKXRUWDPLl3S4hcDDTtPQVMO-y0IWixAh-_Z3rMg
Message-ID: <CAKmqyKP+nQtxe61XvUqBOvGuU5zivWMnK2_LsVxL5gf33QV6Aw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] tests: update SPCR loongarch64 and riscv64 test
 data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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
> On LoongArch and RISC-V the SPCR test data contained:
>
>     Terminal Type : 00
>     Language : 03
>
> The corrected values are:
>
>     Terminal Type : 03
>     Language : 00
>
> See the specification of the table in
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial=
-port-console-redirection-table
>
> The ACPI table data was rebuilt with
> tests/data/acpi/rebuild-expected-aml.sh.
>
> Remove SPCR expections from tests/qtest/bios-tables-test-allowed-diff.h.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v5:
>         Undo bios-tables-test-allowed-diff.h changes
> v4:
>         Reproduce the test data changes using rebuild-expected-aml.sh
>         creating the same diff as v3 but in two separate patches.
> v3:
>         Update test data
>         https://lore.kernel.org/qemu-devel/20260618124020.640794-1-heinri=
ch.schuchardt@canonical.com/
> ---
>  tests/data/acpi/loongarch64/virt/SPCR       | Bin 80 -> 80 bytes
>  tests/data/acpi/riscv64/virt/SPCR           | Bin 90 -> 90 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   2 --
>  3 files changed, 2 deletions(-)
>
> diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loon=
garch64/virt/SPCR
> index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a7=
38709a45260cbb2 100644
> GIT binary patch
> delta 23
> TcmWFtm|!Qw%<vxw7?1z}S|J61
>
> delta 23
> TcmWFtm|!Qw!2BNw7?1z}S{?;}
>
> diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/=
virt/SPCR
> index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd029=
4c18bc6301e208a 100644
> GIT binary patch
> delta 10
> Rcma!wnqbGo%rMbG3IGpM0&@TW
>
> delta 10
> Rcma!wnqbGoz&z1G3IGpJ0&@TW
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index 2c7086d9de..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,3 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/loongarch64/virt/SPCR",
> -"tests/data/acpi/riscv64/virt/SPCR",
> --
> 2.53.0
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A03CD6D230
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWFgj-0003yv-PX; Thu, 18 Dec 2025 10:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWFgg-0003yZ-WC
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:13:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vWFgf-00006F-2x
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766070783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JU0yBhjfPZRL3g4n1uKEh6x3PEVCCoHtJzUO5mlmqTw=;
 b=C3XLqkpq0Vw6NEdda4YfHKdCxfDEBqkRZY+Rm5Dgtz1X1To6qmOIhpavchKRnamLKTiiHN
 /9Ii/N9lLN4jaB1wMWRQKZvzNasU+kApFbhKrZA/nlMUGzsxLgtdREev+f2IrTHY2KsEiQ
 /WxdCDQweXT5We6r6lAOsH5SCdjljEQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-0fG7VgF7NHSk5P_lZQhAwg-1; Thu, 18 Dec 2025 10:13:02 -0500
X-MC-Unique: 0fG7VgF7NHSk5P_lZQhAwg-1
X-Mimecast-MFC-AGG-ID: 0fG7VgF7NHSk5P_lZQhAwg_1766070781
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47a83800743so8861735e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766070781; x=1766675581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JU0yBhjfPZRL3g4n1uKEh6x3PEVCCoHtJzUO5mlmqTw=;
 b=pTLtkCiJTrG1H9F/aNbP6+GiLjFqisQgOOWBrFAHe0VDnzW+A7VhTeSvlYjFAolcCc
 z3xB9aVQiam8X3uZjE7tlZMEVXqJca4ObfxVdDDumlmC4/7fUI1gOiJjdYsa7emR9EP+
 zeSe3KjUwIh1nAiOJw04TNnGYvWbvQ410ap4nDqE74/XOlPnR1XVbejc3czbNgXYC61s
 jgtuScviwOjv5ssgjsjsLyh4Nhq+CDdbLM1ImdF2XRBkJpPxi+pLOv7KBNObCKcCX2h0
 dzMTokbhqXwAEqNGEMhcoZBsH6RxvXqEvwQv2hQF7qi9V+l19x+eIvCRzZMh/rO7qeLj
 UgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766070781; x=1766675581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JU0yBhjfPZRL3g4n1uKEh6x3PEVCCoHtJzUO5mlmqTw=;
 b=Dv0xGKBdTGjeI1V60G8OL22vJuT95RBcVw2e7tVgWuw5/Uq6qGBCwpVvWJlJAgf0QM
 bF39pZtJpeU6GjfilnXr/NzQDHXi4dcqRZN1/5rFTfnQ2LJ5jrNCAjkfjiySCG2LavzP
 QHhNHMVBppt/t3S6RVCsbyITZ+CQYEK2T9Jphl+/avAhApOiVINaV0u8jUNd9YDWViZi
 vccSFZTrBgwIdFdySWSpNuubYJyafLTzohERCJ8B4ifH8m+NxOz7bsMv2vBcXZGrEI3Z
 yz9f3ydZRLYCiVZR2mg7vn5v2bKcBy3TPmRjJdbB1G1RtqFMnm6h4J3bKInfeMXcYG6+
 yoaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3q2FGpyiA7I48F/Ovbqq0m+ffdKSt7HPjpDJHvpiLQzRLsDc/M7h+gOA123LW+syGp/lv4dbs+S9w@nongnu.org
X-Gm-Message-State: AOJu0YzAIYIkpmXn1dELr24skk0e65hCmopZMKmVtwaTe/utCPQCvYQo
 BvNyovTC6rM3Bx2E55Let1kQ/3YztRUvg2v+sUAYT0KURggQuzqSLwh/40IMlB/HPwOlNmgdPTN
 YbTm+AZystdmVEM70Gquse/sZXkwehvATG3vko7EU0Pv3WnPn16sUsWtT
X-Gm-Gg: AY/fxX5nMKSESOA4F4uVrZZKqrXlJpyhpU67GrouQ9NE2AytX4k1pD9/3/pCNxI+4WH
 K2Oq+KhKElwWDB7b2CCaAFCFvQJRqCNSBpQxrO2PV6Yr+ZGYs5k4InA7BymkjSJGf2f/xpCUAWR
 /e11tvwoFgEeUuojAAvsLbmvgeK0ml00/fBB8VGf7euE33Agg+BFMbNCyLN/Jx01ufWN8M4XjBV
 cz/RIbb6yhOC+drrt0XGPBQZFkF8/2q1gQu7h1txI94ufe9wGfIcIvcuOST9wnH0lEqbxNjqlgK
 OQiYcKVMOIMhzvOyOwCPDRqS0w27tKfaZf+YaHRLDNf3aJP3mBHj0fZ1MPfv/ZGWP0n+VA==
X-Received: by 2002:a05:600c:4695:b0:47b:e417:9056 with SMTP id
 5b1f17b1804b1-47be41791b6mr26934385e9.10.1766070776414; 
 Thu, 18 Dec 2025 07:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESloWnPFLLwuzbJocWYliz+xo+3vp7nj6GLpeBMnKS4yh4sbWeZtNaIM14JVMTg5+JUYxJmQ==
X-Received: by 2002:a05:600c:4695:b0:47b:e417:9056 with SMTP id
 5b1f17b1804b1-47be41791b6mr26933785e9.10.1766070775841; 
 Thu, 18 Dec 2025 07:12:55 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be274e407sm47727775e9.8.2025.12.18.07.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 07:12:55 -0800 (PST)
Date: Thu, 18 Dec 2025 16:12:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Shannon Zhao" <shannon.zhaosl@gmail.com>, "Ani
 Sinha" <anisinha@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, "Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?=" <philmd@linaro.org>, "Yanan Wang"
 <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>, "Song Gao"
 <gaosong@loongson.cn>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>, "Sunil V L"
 <sunilvl@ventanamicro.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>, "Weiwei Li"
 <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>, "qemu-devel"
 <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest
 has no serial hardware
Message-ID: <20251218161253.7f13038f@imammedo>
In-Reply-To: <19b104a617e.133b3feb891309.6986511857690603518@linux.beauty>
References: <20251211102025.873506-1-me@linux.beauty>
 <20251211080811-mutt-send-email-mst@kernel.org>
 <19b104a617e.133b3feb891309.6986511857690603518@linux.beauty>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 12 Dec 2025 10:01:08 +0800
Li Chen <me@linux.beauty> wrote:

> Hi Michael,
>=20
>  ---- On Thu, 11 Dec 2025 21:10:18 +0800  Michael S. Tsirkin <mst@redhat.=
com> wrote ---=20
>  > On Thu, Dec 11, 2025 at 06:20:25PM +0800, Li Chen wrote: =20
>  > > From: Li Chen <chenl311@chinatelecom.cn>
>  > >=20
>  > > virt machines always instantiate a PL011/16550 UART at slot 0 and de=
scribe
>  > > it in ACPI (DSDT and optional SPCR table). When the command line dis=
ables
>  > > the serial backend (e.g. "-serial none"), the guest still sees the U=
ART as
>  > > a preferred console even though it is not usable.
>  > >=20
>  > > Teach the virt ACPI code to omit the UART device and SPCR when there=
 is no
>  > > serial backend attached. This matches the hardware that the guest can
>  > > actually use and avoids confusing firmware or OS code that relies on=
 SPCR.
>  > >=20
>  > > The bios-tables-test qtests rely on an ACPI UART node and SPCR entry=
 for
>  > > UEFI-based virt machines. To keep those tests working we create a UA=
RT
>  > > with a "null" chardev backend instead. This preserves the ACPI tables
>  > > while discarding the firmware's serial output so it does not corrupt=
 the
>  > > TAP stdout stream.
>  > >=20
>  > > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>  > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
>  > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com> =20
>  >=20
>  > This bothers me:
>  > won't this mean number of serial devices changes silently?  So for
>  > example, if you install a guest, see that 1st serial device is broken,
>  > configure it with 2nd one as a work around, now with your change there
>  > is no second one so guest will be broken?
>  >=20
>  >=20
>  > I seems safer to have compat machinery around and avoid
>  > changing this for old machine types. =20
> =20
> Thanks for pointing this out, you=E2=80=99re right that changing the numb=
er of serial=20
> devices that the guest sees is risky for existing machine types.
>=20
> For v7 I=E2=80=99m planning to take a more conservative approach and only=
 gate SPCR
> on the presence of a backend for the primary UART, while  keeping the ACPI
> UART devices in DSDT unchanged.=20
> Concretely:
> - virt ACPI DSDT will continue to unconditionally describe the UART(s) as=
 before,
>    so the guest-visible UART topology doesn=E2=80=99t change for existing=
 virt-* machines.
> - We only call spcr_setup() when there is a backend attached to UART0 (e.=
g. serial_hd(0) !=3D NULL),
>   so SPCR doesn=E2=80=99t point at a completely unusable console when the=
 user passes -serial none.
>=20
> In particular, for a command line like -serial none -serial pty, this mea=
ns SPCR would not be present
> (rather than silently switching it to UART1/pty). My reasoning is that, f=
or existing virt machines,
> SPCR is meant to describe =E2=80=9Cthe board=E2=80=99s primary console (U=
ART0)=E2=80=9D, not =E2=80=9Cthe first UART that happens
> to have a host backend=E2=80=9D, and changing that interpretation feels l=
ike it would need compat machinery
> and a new machine type.
>=20
> The qtests already force -serial null for the UEFI-based virt tests, so t=
hey will still exercise the SPCR path.
>=20
> Would this behaviour be acceptable for you, or would you prefer that I go=
 further and also add a compat
> flag/new machine type where SPCR can follow =E2=80=9Cthe first UART with =
a backend=E2=80=9D while old virt-* machines
> keep the current UART/SPCR semantics?


all described above looks complicated.
In ACPI tables we usually try to avoid compat settings, and do them only if=
 we have to.

So question is how guest enumerates serial ports when
   '-nodefaults' is used _and_ there is a second serial port configured (is=
 it even possible?)
check it with and without you patch please, to see what difference the patc=
h makes.

>=20
> Regards,
> Li=E2=80=8B
>=20



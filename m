Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB90FF8864
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIeY2-00083V-7E; Thu, 30 Apr 2026 23:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIeY0-00082Q-3K
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:28:12 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIeXy-0004iS-C5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:28:11 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-676d8582a13so2861781a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777606088; cv=none;
 d=google.com; s=arc-20240605;
 b=SuZlnc5thyEjar91tfJSxANuigRVYG26jSSyRVIlD4RpLlRGoDpi6KddZDwD4wtDpd
 L72vPlKWPKiDsFc51z9aQmMGSZk7buyvRCqLZ0qvvVJwWGk9hArCEbeivpLJtrp4298z
 yy+N6/5AXVEAkDWAsGd0Yd4Voi6lKoLJWJqadInopDmdlgl+ItxRufMqGMyhPqDc8AkS
 l+Gv2lYB914H55CzJu4cI4VWMBur5+lhlpH6BITX0EihjZ4RHSs4/JDMfjAPZXJxkYlF
 2kS8+9gXwoe7jRXuRZE5nWsMJj4V25B2zU0A2gkShnX0vYOjwScYciKCjTL3rAeuyZzU
 oyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=va8tAHySlAgT3rRwEUHdCGcUpqzRXU3YLlOSvRBG/9s=;
 fh=I21oKyNy4Il063R1ym5YZ0eyRc5zhdOlCZYXtgX0pn0=;
 b=YWPtw3lxlkbMUoEoaT976EWQ1WGPRlPeFnPP1DDkJATiOX1147LoKcW30lxSOZDa35
 Kgr88/vmSZdkQGOSacWI33dadlZtOwQUmXhq5EiVLNjjwypTP4NTGRAr44sYgzbHMNbS
 q2SXyVlbwpuTnG+ceEK+KEIZG0J7eMe/3iUyqZhVnVaxIdH1BtUjREMIsUZcQ4Dw/XzY
 x9wD4DOpXVz0i35f+544GFRFIizUMxBbjZZAPjqa40e4CYwL8rBgJTS9yX/B8kSI3q39
 K/iyttS7LYgmEVTLaO7BQCMQoyywTvhdetWcUnQMDbPOsWkmmobR3MDmuQExQUluTQLu
 9DUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777606088; x=1778210888; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=va8tAHySlAgT3rRwEUHdCGcUpqzRXU3YLlOSvRBG/9s=;
 b=RZO7t7u9lzuoqLcB2Xf7bBra2WeHS+yQLSBhb0lFccg9cdthmQFaiYgR1pOT1qn8L9
 ZB6rHGsVrXJm2PgqJGnNcuYMLV4R32myIpXPht4YA1VmtVRRm5vLYDk8RPCgLeVKyI4L
 HAMVEAZhL0FjFCbvLaswUrADWX4Bpl/TkbVKTwV7YB75KZjjEGDUybaMGcPvlSStzHIw
 HJH/Jmv7ahZRc98g8kxkcdqg70uvFhLK2cEdVGExoKtEEIPTFytmBXq9j5jxj77Sg4dA
 NwyagdEp3kKPcJpcdOB22Cs/5lWCGPe8ncmyIonaCsB963U1qxqSOJXPr5FDd3yOgZJS
 /mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777606088; x=1778210888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=va8tAHySlAgT3rRwEUHdCGcUpqzRXU3YLlOSvRBG/9s=;
 b=e7mEB6cSyUJmWoQM8totlN3s3M+H0xYwD8MA1WcZmo6X4PmpS+xnbkJolInbIizMq0
 dmVO99aSjzFYsDcmEEoZGZxsmZ+BTagyVy+wT0yjiTQTDtibSjSR5YNuKaVeuQzU0tgK
 aYcY56X0Zs5bJryK7M3Anl7Rw2u/Mab9Crex3rFlEGP4rmesq9XlRVuRoAaeM0xKl/ia
 4enVlPYR+8jSq6OiiS8Y3Ilrxi4Lg09oY7r4j3k90W7LBC0w3dNJAbxhJIg9SBfSQYGc
 6DqJh/FeD9dsVtXaqS1SnhEz2kD+h8TQvwJ9aGKe0NbS48VxZuNeoak231f/fVF0F0zE
 jlaQ==
X-Gm-Message-State: AOJu0Yzi6oPEpeLbPLMwfW8j1qnsV4ApTqcg3aW+8BR+5QlbPKqmjjox
 2Qf2VJnU0NcdyOIhWLlpaJsUBnJY3EU23rfcJWUU//v1Kc/fVplJuxJJNZVq+OOF4oXLDEpuQr4
 X8DEN7JaIuYraGtDqU/3X0MU/eoTl/Wg=
X-Gm-Gg: AeBDies+OWEFNNLGFtPhIP0x1rF/S/rBhkPe5aaZnXtdsUF+7flYfof5jjXAetLNyY6
 QAtw0Rrd4lhR1J9bVOUOlSFWFqKpqp60biuInuRALh3/V4nDzFwgNAsReFRRIh/QmfCh3YAVFab
 4nEvSPgvxo7obMpw/r6u68mEZhbkQI0c6RQKSxEC+rcfM4ultRMsw/caVWtgA3RuoBvwkFLtrs1
 6G4UmFR8IQTyReKJYw0jv0Lf55xjU5gPgW2AR73A7KARz6aP0r0ANE7z5qdyloPiXnh2PHc/Thb
 N1r8aylIBm1OSA75CAMNpEBiVG2rGr1oyU2TaCSaoEABjFQQ
X-Received: by 2002:a17:907:3d0d:b0:ba9:2233:1ec with SMTP id
 a640c23a62f3a-bbac67c4f65mr388752266b.22.1777606088194; Thu, 30 Apr 2026
 20:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 13:27:41 +1000
X-Gm-Features: AVHnY4Ihs9GlP6LrQwVeLCixEzQvc9BzN_kbuRfbwzHksXGljr6X1_u_jLKYZ7k
Message-ID: <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Sat, Apr 25, 2026 at 5:13=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> From: Fei Wu <wu.fei9@sanechips.com.cn>
>
> The RISC-V Server Platform specification [1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
>
> The main features included in this emulation are:
>
> - Based on riscv virt machine type;
> - A new memory map as close as virt machine as possible;
> - An always present IOMMU platform device (riscv-iommu-sys) that uses
>   IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
> - AIA;
> - PCIe AHCI;
> - PCIe NIC;
> - No virtio device;
> - No fw_cfg device;
> - No ACPI table provided;
> - Only minimal device tree nodes.

Can you describe why we actually need/want this? The virt machine
already covers a lot of this and OSes and Hypervisors can pretty
easily target that. I'm not clear what this buys us in QEMU. Maintaing
a machine isn't that hard, but it would be nice to have a good reason
to support it.

Also we need machine docs that describe why people should use this machine.

Also, why no ACPI and why device tree? The spec talks about ACPI
tables, but I don't see a mention of device tree

>
> [1] https://github.com/riscv-non-isa/riscv-server-platform

The first line of the README says:

"""
This document is capturing discussions at the Server Platform TG.
These are not official specifications and everything in this document
may change.
"""

So this machine needs to start out with version support (like the ARM
virt board)

Alistair


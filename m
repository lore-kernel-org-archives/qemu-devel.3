Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7842ECD996
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 18:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo4Ro-0007Ch-Bm; Thu, 05 Feb 2026 13:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vo4Rm-0007CG-E9
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:51:22 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vo4Rk-0008Q8-13
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:51:21 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-795232991adso8076147b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 10:51:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770317477; cv=none;
 d=google.com; s=arc-20240605;
 b=QDKWpSaDeRu0xJwq33QP7yzxfCJublCQV6dc3MCF8B9dYlapvvD9UwY+u5tMuYHaQ4
 7mCmhML6MG9ezRTMSXxoyP2JtOutaLOAfssO23NbPnoqF+YAgzbGivxd1dYNS0vR4xet
 0Tl66X+AeRPU1s7JXNfjvYqbk0G7Tcc9VXw0koD0ubgqAZms+eRQgu6BUG+Pyjc6melq
 lW1MKm9mUOiAcpVyH4ky/eukuVsJ+riffAIP6cJ1psmecw9cZ/GTNyo6x+HOdODYQzUJ
 BTrcsxmnwJrfrw8XL3fz8Z3GSqIItCkICtHgWvDXYbtJUjl10TNPtNp/WiJ751kwaFWa
 dvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iaplVcg+C3ZIVbHnVYp/FtHc/2vtoaqZXFq0RfFunq0=;
 fh=Glmb9uYbbqGw8ozJBdGqQA9/mEPeo76cQodAziec5gI=;
 b=i/SzeSzL2+R5jg7yuZR8VyYfVzuEF5/Kae+dBPfbnJxjJUTkX3xaawf2gOKx3neqFF
 jSYhROdh+d32Fttemx8XXRFgZ9u+eWtRyB2EYPLzADJqaKx3W8C+MlfIsU4xpsmek6vA
 MaIA0RvFYorMDKGLQgJtl/do6DUe2wYW7o9iN/qstoRKoC0k/O9Vk4VjVh3Cv+1y41nZ
 5FPtFP674hpjf1+ulC8Cko11MqaqznqqVP4oTme0yxDiTagLZplT75VVzlFc7glMIyWM
 FevMgwY1R0xi1IXs/1JTq7RMuZ5vd1I5erUWdU/oipjheQ74RTgsBNkhIjbVscUUAPsC
 CvmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770317477; x=1770922277; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iaplVcg+C3ZIVbHnVYp/FtHc/2vtoaqZXFq0RfFunq0=;
 b=Zfeve+mkT8yR8xDKlAR7gU5L6kSqmj9Q/lH8GJWZH8wDftX5zGuzf36+VeVxwk1MaK
 2ph2qYC4HA/oUy9bZYmHn1m8RlqBecWIblQj12lMH0bqt0CsQkGG6ZN5dFrhGKsA+fQ1
 2X+hcjJfyK0topT+dJg89XBqURdPAkJi3NPvN/sYsGYF8j0sftr2UFPKHJ8ui/7iWXn7
 vOR63aGGwgqHF84xIxdCUacXOtX4Ys4S54w61yR2XtAszq5A3xMpi6p2M8PDpazBU5/d
 Z/7i0/KTKgPS0AOvwMHoi/UNEWFLIe8yyONAH7eRnRHfKnnj0YU+VsthFzpq8HKb9e3k
 8Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770317477; x=1770922277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaplVcg+C3ZIVbHnVYp/FtHc/2vtoaqZXFq0RfFunq0=;
 b=plQZkVmevXxMh24fsyffE6J1ULnwcO17PyoNyifnXeCyDTR2NOk7oRnPuv6HbCtL1J
 Vyg/cW2dDhY7FxKjogPvGoUCizJpmL27XAZDLySwI7pYrZCHCQ+OGaU2pD43rFEwTBIm
 R4z64U+RoQgHQQAepPmN72Z/IEF+xklSY6RLJErPBQGK7vTt/qvSpkZyaNfrmm8o4ksx
 rT7mr8UgToZuaZtdad0WJdDqsnEf4xijtamADVkSosjfDzsMpCZyTzcmd+PxBeLxGhZq
 o3FwZStppsbJ1KQ7ob+3C/O0ZnmXl2bZnIZvF2k1Fvghqffsus12GPR6p8D6Gtu1bJcU
 Sqcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvYtL1sfq2S4mHO3TrD4to169HCdzEjPGCusDgYTWDCjTq60e6c1SRFP7Vnm53siH/yvPgc46KmFJK@nongnu.org
X-Gm-Message-State: AOJu0Yyu7lSsDMTZk1WgUrBbT0QIviqLe3BlULTiXoUFr3SOfB/daXjz
 lCgIsXsY1BNcqIaxFxS6OGxUGZWka4Cvbu1/9ELvbs4yrzrsYq/q4gzr0C6vb8X0sifgkDNXkB/
 f17xZp3siMuIMboOIWCjU2tLuN/S+PiFVb4yBETGd1A==
X-Gm-Gg: AZuq6aLgF/zeFL0bkcIaw98og7DlhBytySbWoVV+5KXIq49k3w8rWJBR+MV1icoYkEV
 /VuKVZMmIp8qnM1tvIiLxWPOoo034cjSPahduLOSwuPJnFEGm3pvTIGRJFL2ItExu5LTSGSoiO1
 ijfuw0LmejawUVTowP8lpyI0LSGwvfkhzZknMfqPNsxeEeY65eAczIyg5vO+T2P+g+rJ2KRqjKT
 a1aTKDHfST8nqR2EUruwr9KHwaX1msHHG8TJMFgLHPWjEt0GkbL7XygpaU8v3LxZfl2yz+6oGYx
 nfIy9bA/N0AN06RDAa20d8N7rgkXWoBVcz+Nlh9fBH2XEmQ4K7tcIL4=
X-Received: by 2002:a05:690c:a96:b0:795:616:4367 with SMTP id
 00721157ae682-7952aa74934mr1782537b3.4.1770317477416; Thu, 05 Feb 2026
 10:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20251211102025.873506-1-me@linux.beauty>
 <CAFEAcA8FcW22-TnyBKHmFUUsR=xk2u-74uPz6KisJTeG=YWxmQ@mail.gmail.com>
 <20260205051236-mutt-send-email-mst@kernel.org>
 <CAFEAcA-2QKtniTsLFA2ayjQ28dmQ=35r_zhkL6UBpiEOr=xGVg@mail.gmail.com>
 <20260205124004-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260205124004-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 18:51:05 +0000
X-Gm-Features: AZwV_QhQKL5fV6kOZjgQ6PwWGHq3Hjx3t9EpHp2HxMUy3n5ENyeEI0CYDvHg3-8
Message-ID: <CAFEAcA_P4-Uqy_agp0VZt4+5ukL2tWYK2G394W=zkwJxKF+6Yw@mail.gmail.com>
Subject: Re: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest has
 no serial hardware
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Li Chen <me@linux.beauty>, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, 
 qemu-riscv <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 5 Feb 2026 at 17:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Feb 05, 2026 at 05:15:17PM +0000, Peter Maydell wrote:
> > On Thu, 5 Feb 2026 at 10:13, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > presumably, things would be different with -nodefaults?
> >
> > -nodefaults doesn't generally do much on Arm boards, because
> > we don't have a lot of "pluggable thing that's plugged in by
> > default" that we would turn off -- that's more of an x86 thing.
> >
> > On the virt board the UART situation is a bit complicated,
> > for command-line backwards compatibility reasons:
> >
> >  * the first UART always exists
> >  * if you're emulating the security extensions, the second
> >    UART always exists (and is the secure-world UART)
> >  * otherwise, the second UART exists only if the user
> >    configured a second serial backend (i.e. provided
> >    "-serial foo -serial bar" or similar)
> >
> > If I were designing it again from scratch without the
> > back-compat baggage, it would probably have three always-exists
> > UARTs, one for secure-world and two for normal-world.

> that is why we have machine versioning?

The problem is real world guest code that just breaks if
it gets a second serial port unexpectedly. Specifically, UEFI
would behave unhelpfully. Since fixed, but there are/were still
plenty of old UEFI binaries out there. Otherwise I'd have
just added the new UART and made it a versioned machine thing.

> I would say -nodefaults really should not have a serial port
> unless defined, no?

QEMU's arm boards have never behaved that way, and nor have
most of the other architectures' machine types. For PC
-nodefaults makes sense as it disables a lot of the optional
pluggable devices that the machines create by default. For the
Arm boards these devices are not like e.g. a floppy disk
or a PCI VGA card that you could unplug, and that you can
on the QEMU command line manually re-create, they're like a
UART that's baked into the SoC and there usually isn't
a way to create them on the command line.

-- PMM


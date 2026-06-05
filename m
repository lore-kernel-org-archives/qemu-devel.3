Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03B2CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWoO-0004oI-BM; Fri, 05 Jun 2026 11:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wVWoM-0004oA-Md
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:50:19 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wVWoK-00085V-Mc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:50:18 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-304d8362a58so1242872eec.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 08:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780674615; cv=none;
 d=google.com; s=arc-20240605;
 b=LyRJ3AxMNw5PNqhNY8r/fFZxDFH/Fv/p6s9Gzw7dRR+REtLlrR3FVprtiiAz+ayrsG
 5xX5KpXfp/ODYqZxwqVB3ORNsVfcFIRQAK4H2Sl64PoyISQbUJtHMbyNi+vZCfmyZckR
 Q4Bl9/YvQu/O4iYx+GkpKzX0M8QM+9jXn3uxeouR6ilLaT7r5c3MB65PaSYEhhu7ZyOV
 Txyhh6f87zRiK4KJNwlxSk1xcYs+8Q3/GGSv1MCbLQMxmeovvrfgp4bBiR8H4ZXk8ydH
 ENkhaCBhkL4ciRhwTVcHu1nE/apJ9eYn+dEqLZ75f6sVS2L8lJRfg5wAcxNpaKXzukR5
 123w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S1SmazQTYu8wTrU5qtGlAMwT8wVOWnOjfdFHidKv/dM=;
 fh=kaw2L4sHZvDPseqVdaN6Q7uejyTgUs0egLM0FoE7CYs=;
 b=NcvI7UNmwo2QkTEHSU7OU6EzrPDOmiF/JR9SOV5lt6q+q256yf0F+QqrM8I8dEqhZG
 21ttfx9khSmE+gj/xby45aN2oP3b0a5cR17s4K2KTC5R7rrw0LJQrM2fgjd7NbIYyg7F
 j0P8lKjB78H44nTooPP0L7cyxiJLviPQ+XLegMbs5RQ/a9sn5GoZuzbfZ79zkGb/9XWN
 N6YkJrp2Serr6WwXuC+BX6Z6j0vPaqNCYqs3IvCBEu6zgbPtjEARzhEzMNUjB8Y8zlla
 fwzOHJNmxH1JkiE0dGW+IEptrpNhxXkAG/RcPnzzqHeE8LGEYvt/JgFw9i6gAf5+EGlG
 aE3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780674615; x=1781279415; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1SmazQTYu8wTrU5qtGlAMwT8wVOWnOjfdFHidKv/dM=;
 b=E0xfszEPYnkVev2TUnupU+sCBjU0xQ/C3z8bFF/S+m8MOABcWxib69+JlXoB7+kRxN
 yIPvOKWkra4jAotvRR2avE+3oKCR2rcfe/4kojebxniU212Dwy/8KTuqNYW+bA0lKCdu
 Moxu58aRimLBOI6q7jT8ya7kqhWMdQM4xo+EFGQUnZSKo3rAELJ104OsqibiwRRQsRsN
 q39MN/MERlHjVxsfJ6oxi2tfz5CoHyXXeaYOAiTW6L+VhZD5VL3YLwLj/vsXpZ3co9h4
 mZW+au2BAsKroSu58qm4gZFU432gxEyK4RnQEgvMS38tWUs4vNA2g4Xbxv3glzM/+wZe
 UobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674615; x=1781279415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S1SmazQTYu8wTrU5qtGlAMwT8wVOWnOjfdFHidKv/dM=;
 b=g6kMObCokP7v8vihzODmUtnGSky4JxNXRpwJthQgccXPVn//exnwyRFGHiWWB/5FfX
 zEhAwyT4cAG4uROhiPjMLMS/UBr2K54ep6airFsSEo6p3/nio0PC0HtZ3fvZMxKj+okD
 htCcAbV7yEm2NjDQ/C1bdZCVchabGpWtZdjQm2KNIMCjhwKpLiGQsT1fvlVkOKw/JMtj
 UUWcs8lJap/xdkcolAZV4gaiEC6LcIWJ4mMmjj1hXyO5L4A0VjDOprOzNNtWaP9+2zH0
 Z9fnKVjqaUiQ+dxM/nvtIrI58+71qsQgVorPqY+XWNNsoGpbVaPdZzLn5TtSe22aoGVy
 JBBA==
X-Gm-Message-State: AOJu0Yx78v6reRud9LgG4sVjcoEZnbXVRFzM8cLm1QHcEIv1NsHmFEdl
 j3xVpieDzcGIAW/NFypJld16ZZ2P9PvnGYi5dqNLksHKqKt7nrJhSHMgszEZ4Zw1YmBVFubvxgr
 3FkNPXn8Ub1vhHXOpEpmBa6r29CZavNXZxX9i
X-Gm-Gg: Acq92OE9x59Tll7D4aLeIvLGxkwXd5oaqXo5eRQguv10f366s2cETSEo/qh3JOMOQou
 /Es9nmWAlpQbgZBaM1Qiwg4Iw+uhL6pBcxfv/eEdLMt2h8GBuJuWvRpnrh6jY9U7g7iOZrp5aj0
 CZ3FPm7wRCD7JKfCIXjnpfZl8sk9PxsXhrzNS9HgTp+XiuLoEmR5twqPuuJEFqPTrU0IglPvC8O
 56Q+7y5WVHCldrqefq7QuNg5tFw3q8WA9sKhQw8HQeyp9cBqnJmp8pWPLSVIPk8AlPSVosLYOeQ
 LoXb/jbvMqQMUs5D6URV+qRUKx/Yr8rQxBoYqso1TIL22Td2iQ==
X-Received: by 2002:a05:7300:760a:b0:2f3:b7b2:cbd3 with SMTP id
 5a478bee46e88-3077fdcfae9mr1554232eec.5.1780674614442; Fri, 05 Jun 2026
 08:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jun 2026 19:50:02 +0400
X-Gm-Features: AVVi8CcnilvmQ3yfrfQNWwBVNUr4E4F1ChMP1I6AwrnKfOCP8kARqBRyvAxSs50
Message-ID: <CAJ+F1C+j77ZqYh9ftH1Xa5-y307brBjE+qxejCGVKcHQYo=mSg@mail.gmail.com>
Subject: Re: [GIT PULL 0/23] Fix various QOM object life-cycle issues
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Fri, Jun 5, 2026 at 7:45=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0b=
dc:
>
>   lcitool: remove Cirrus CI support (2026-06-03 12:45:38 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/qom-tests-pr-v1
>
> for you to fetch changes up to a78ee35b70b0ef18dfd6e2a3e8ab818471a9e503:
>
>   qtest: add "qom-tests" command (2026-06-05 12:23:33 +0400)
>
> ----------------------------------------------------------------
> Fix various QOM object life-cycle issues
>
> This series adds a new "qom-tests" qtest command that exercises basic QOM
> object life-cycle: it instantiates all non-abstract object types, gets/se=
ts
> their properties, and unrefs them. This quickly surfaces leaks and crashe=
s
> that could otherwise be triggered at runtime via QMP qom commands.
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (24):
>       Fix various QOM object life-cycle issues

I have done some modifications to b4 to be able to send PR. But this
commit is the internal b4 tracking commit, it shouldn't be published.
I will resend (eventually switch back to git publish for now).

>       hw/pci: handle missing bus in prop_pci_busnr_get
>       chardev/char-socket: handle NULL addr in char_socket_get_addr
>       hw/pci-bridge: handle missing parent in prop_pxb_uid_get
>       hw/pci-host/i440fx: handle NULL bus in pci-hole64 getters
>       hw/pci-host/q35: handle NULL bus in pci-hole64 getters
>       hw/ipmi: reject NULL 'bmc' property rather than crash
>       hw/xlnx_dp: reject NULL 'dpdma' property rather than crash
>       hw/intc/apic: move checks to realize()
>       backends/cryptodev-lkcf: skip cleanup when not initialized
>       system/ioport: minor code simplification
>       hw/core/machine: free shim_filename on finalization
>       net/filter: free old values in property setters
>       target/i386/sev: add finalize functions and fix leaking setters
>       target/i386/kvm/tdx: free strings in tdx_guest_finalize
>       hw/i386/nitro_enclave: add instance finalize
>       hw/i386/pc: free pcspk on finalization
>       hw/tpm: free PPI buffer on finalization
>       hw/loongarch/virt: free flash devices and OEM strings on finalizati=
on
>       hw/ppc/spapr: free host_model and host_serial on finalization
>       target/riscv: fix general_user_opts hash table leak
>       target/riscv: use hash table as set for user_options
>       hw/i2c/pmbus: fix undefined behavior in pmbus_direct_mode2data
>       qtest: add "qom-tests" command
>
>  target/riscv/cpu.h                  |  3 ++-
>  tests/qtest/libqtest.h              |  8 ++++++
>  backends/cryptodev-lkcf.c           |  4 +++
>  chardev/char-socket.c               |  4 +++
>  hw/core/machine.c                   |  1 +
>  hw/display/xlnx_dp.c                |  6 +++++
>  hw/i2c/pmbus_device.c               |  6 +++--
>  hw/i386/nitro_enclave.c             | 11 ++++++++
>  hw/i386/pc.c                        | 10 +++++++
>  hw/intc/apic_common.c               | 23 +++++++++-------
>  hw/ipmi/ipmi.c                      |  8 +++++-
>  hw/loongarch/virt.c                 | 14 ++++++++++
>  hw/pci-bridge/pci_expander_bridge.c |  8 +++++-
>  hw/pci-host/i440fx.c                | 15 +++++++++--
>  hw/pci-host/q35.c                   | 15 +++++++++--
>  hw/pci/pci.c                        | 11 ++++++--
>  hw/ppc/spapr.c                      |  2 ++
>  hw/tpm/tpm_tis_sysbus.c             |  9 +++++++
>  net/filter.c                        |  2 ++
>  system/ioport.c                     |  3 +--
>  system/qtest.c                      | 46 +++++++++++++++++++++++++++++++=
+
>  target/i386/cpu-apic.c              |  6 +----
>  target/i386/kvm/tdx.c               |  5 ++++
>  target/i386/sev.c                   | 37 ++++++++++++++++++++++++++
>  target/riscv/cpu.c                  | 53 ++++++++++++++++++++++---------=
------
>  target/riscv/kvm/kvm-cpu.c          |  8 +++---
>  tests/qtest/libqtest.c              |  6 +++++
>  tests/qtest/qom-test.c              | 12 +++++++++
>  28 files changed, 282 insertions(+), 54 deletions(-)
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1CFCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPh51-0006u2-TJ; Wed, 20 May 2026 09:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wPh4U-0005sj-9V
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:55 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wPh4P-0004aw-52
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:34:48 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso2315740eec.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 06:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284083; cv=none;
 d=google.com; s=arc-20240605;
 b=Fdm8IxfhYnowsn6EHL2nLCURyYtW9b4BY3jHhCq3JC9xWLdD4Yf1K0A+HzcLXbfU5y
 3Cp6uKd0Nu9lFQaBuEUQSuimQua4KAo5jwY03qBqpu6UkBjuzr1h5yaAtvKYcVXM1PdT
 LtSAhDs8QXty1rysyk8wlHqZziElQ+KSd9HK1hLbOow5mZFeJy+yFnRbiiTFQX1+/jt/
 ERSi5346KQ0kEYKfgd0BNG/EahUGnlKRH/eLOGMcRNbkQHbhZF5ESmgHYiQ/fV3nUt52
 efneI4X8afxRYX2+xKCe6KurQJ42bIYv2h3jAPonxJNkJSuTkNoZTf97MsL6Chu/ccYI
 bnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cmTLPbE3jG62E9lp1UJlptEHOsMg3vLz0U5PMcY93kQ=;
 fh=BUPSVLneqrEYfk4GoKeuB/khL8E7ykQu1OCxN9EJ7z8=;
 b=a+AzOpzNgj8cHUs2cU/AJKEx+Ez+JkBcFX92zoT5UAq8YbZD4RdEAFT1JhTGBUpf5g
 b4ZJr5ZSWRJ8WbziNRMFZ0ZB2Sdfm/Mf8xol6S6Ioe4nPFYzpTVCXTX1DAexQy7ROJ0t
 MsLcEIsyuxpKDjGf36qO+zSoQWoe/Os8/AK/jYlT/W+aAZDbS3MEi9jPP2pPdCEkzeAD
 WsMdTpWe1aETDpNkyZgggucWDNT6UA/wQ45urz10VFk/dGIXtnOkmthojixBRis2sOrr
 ediJ64YjAZB0WOP+1N87VBEakw7FVMrJdhHT7Et7Isg5QShDrIcPpdTj8BI7MvBFdRqi
 LrvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779284083; x=1779888883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmTLPbE3jG62E9lp1UJlptEHOsMg3vLz0U5PMcY93kQ=;
 b=oFbeGwB3Z3z+Tb5bgT1o4/z+d59fuMZ204kOxah07vL6dxciLRcA9M+OtMoot7LxWk
 t8ixtRWB3NGMl4AIVeQr9hhE8znZ9nIbb1TmAHohhHnsuhLXsHm2cRJnJVj00c6HvB0U
 ApasNfT9k0d3wsCQj08hbqbMYwLI5s2x5Rns9BqXJ+JPUX7adyRdjjbg1VhbjMERuARs
 4rWOz7FqQDqxMtDQkzo6hSLS/AyLXR70SIgJm/owyifv5isnJs6TXgzbrckZoRikVgqH
 iUxnx6NX8oY59WC+2T4UT2aUdoCX4p5TUc/TOdoein4UQR1kzlPZXb9RVuZxy8iixutJ
 K0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284083; x=1779888883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cmTLPbE3jG62E9lp1UJlptEHOsMg3vLz0U5PMcY93kQ=;
 b=haG12ZYO+INigMCxoIzmKe/brZrbpA/2d3UEdK8Mz2QddR2IozSoigjsZzKiJDRmBt
 pivXOYsUpjMsVJrckINjPO6+jKfMvqYYVtJritXg68MKCsObRUsCJXRBhD38Mx0Kubk2
 45EDgLOrLG8wasfuGLz+ZogPZoKpl+xx6+jy1vh1iMxeuTovWmlmQ0xR21uSmDHtl5xt
 qYJKQdxPzuJZEBj3fUzKlDSZEPKk92/WJbfyv3ltyE6j7gLXl7K0i/ThgyKhS3ekB3lD
 XOloVxzmXsfgL62TD1TEOTJ0FLzkvadzCa7YSemysBepCbGPlcmcztvvK/7seElisHDv
 +zcQ==
X-Gm-Message-State: AOJu0YxZeDwvaCNbCsAKvgcxTFMbaqGoBCviA2/pBjRIcIcHjN7Htm2D
 FUUtWGHRp0rTK88fKH9HPRZXWDlzAXmh1QQtSHm5d+CTF5nr8m37BsOtDZqjWvBfoNr6gkrVZjB
 oiBev6kWye8GU0XP1nS18zwTitqDAqNr8gZnU
X-Gm-Gg: Acq92OEnAsGN5p1NU3WYL3jJZkZDBLrA3GUJeYlX28tXvAodt8H5UZNbzkZuy+WuS6B
 Dec5KicZ6HXgCuVHP1W2jQXtteAJ3Ltk9LRZcJiesi64XkwuFIBj9VfOWBVvZ5mJUtloRUMak+N
 kJIygs+H7C/CBiOXMxvLPUwgTAGUWD2S/JBQqsej6XYkcXqxnfKG9cDInCYu2SOP5xLcZTtPEOh
 q1i114R2mwvA73VZeeptN9QrF+s8rQNviPmGm8eepzcKgJf/odFiTiEQn5mkYudwZWWuw1Z0daP
 0jwZbme8bO/7Ty/nBC8UVXQOXKOfgnOFeqX+0yU=
X-Received: by 2002:a05:7300:fa14:b0:304:acc:f086 with SMTP id
 5a478bee46e88-3040acd1819mr2528666eec.33.1779284082774; Wed, 20 May 2026
 06:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 May 2026 17:34:27 +0400
X-Gm-Features: AVHnY4I8qNIuA9ojVAmqhx8OMDBr-9YbKW4nw-TAN7VtL_JYgT-_AZgZDLhRIE8
Message-ID: <CAJ+F1CKvcOow80+Nj1tTb8_+m9Vn=+z3wh2-Li8XZi+2Sbtirw@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] Fix various QOM object life-cycle issues
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132c.google.com
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

On Sat, May 16, 2026 at 12:00=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> After Markus's "Several QOM objects crash on introspection" report, I
> started writing some unit test.
>
> This series adds a new "qom-tests" qtest command that exercises basic QOM
> object life-cycle: it instantiates all non-abstract object types, gets/se=
ts
> their properties, and unrefs them. This quickly surfaces leaks and crashe=
s
> that could otherwise be triggered at runtime via QMP qom commands.
>

ping

> The bulk of the series fixes the issues found by this test and ASan
> help. Some of the patches are redundant with patches sent earlier on the
> ML and marked as RFC, they should naturally be dropped during rebases,
> but are added for completeness and to make sure CI pass after this
> series in the meantime.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> Changes in v3:
> - update "hw/ipmi: reject NULL 'bmc'" & "hw/xlnx_dp: reject NULL
>   'dpdma'"
> - fixed user-only build in target/riscv patch
> - add "ui/vt100: add vt100_fini() check" patch
> - rebased after PR with first half of series patches landed
> - Link to v2: https://lore.kernel.org/qemu-devel/20260504-qom-tests-v2-0-=
ef7e3dc94f7a@redhat.com
>
> Changes in v2:
> - tweak error messages
> - drop "qom: skip link property check callback", instead
>   added two patches to avoid crash on NULL link check, and doc update
> - drop "RFC system/ioport" in favour of Peter Xu fix
> - added "hw/fsi: move OPBus qbus_init() to instance_init" to address TODO=
 comment
> - added "target/riscv: use hash table as set for user_options"
> - gather a-b/r-b trailers
> - Link to v1: https://lore.kernel.org/qemu-devel/20260427-qom-tests-v1-0-=
c413f3605311@redhat.com
>
> ---
> Marc-Andr=C3=A9 Lureau (24):
>       ui/vt100: add vt100_fini() check
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
>  hw/i2c/pmbus_device.c               |  4 +--
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
>  target/riscv/kvm/kvm-cpu.c          |  6 ++---
>  tests/qtest/libqtest.c              |  6 +++++
>  tests/qtest/qom-test.c              | 12 +++++++++
>  ui/vt100.c                          |  3 +++
>  29 files changed, 282 insertions(+), 53 deletions(-)
> ---
> base-commit: 0bbb0c2b65db64c161f91d10a89269e6d319d2a7
> change-id: 20260427-qom-tests-9dcf3b969411
>
> Best regards,
> --
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1B91076365
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 05:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7nhn-0001Lv-3U; Wed, 01 Apr 2026 01:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7nhl-0001Lh-Ia
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:01:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7nhj-0007cU-FW
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:01:25 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-66bb66db39dso5347555a12.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 22:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775019682; cv=none;
 d=google.com; s=arc-20240605;
 b=H73umMFkSVOB69/0g88OCPHH7ZtIAG/iAUykGUZsYCA0wV1xJ+5WYLET/Le3A70uQP
 PGnw4pZ2Rl3bTw90+Y0XSNv7ZkzMJIGnhrIeWMdeZR6gaCeV1MpYy2nExNohCSICKutt
 FkaIDgaUrV7sVMvPGdFVmYrLWUulRvks5weGN1u8xRjodWIwsEektoZla9BkjALb3M6s
 Qe1jXa9aGFD+ezYA1Pk3DHm5C0dyqNp8FT3OIsR1vifayOBdGyP3qnxzM8+cQ5ZQ+rOF
 jw54/hGjWEPml+RzoOhVGRQR5+/JWMQpk6gi8wvvev6O3pQPKUuzmhMCP7rwZAfGSb3B
 5aWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mjh6hL9ZSmG8fcdCcO13TLHJQ/uCk2d3Oe8Nwf6EPeU=;
 fh=An2jDPbQYanyCSduLqTxkmOqdmKdsobic3bc+xkZAds=;
 b=Jym+mZQ/Nqb34sDP/CIFKLQEj9XT3UJNLSRgdeO9mwuOeScFMaiKwmz/pBETHn+GMi
 4LDIZh/jGynErHXKjPVzIXixZ3lidtkuQqNx558VexqbtC6Qi/lHtlt+jgDT4hug7zr5
 Zmy3N/Y4Z+3K/oZU7LhhGeZgU8Ve3j2w3pe94u3kVq/TsyS/HWfWjEtz4WSIzpY72vUZ
 jU0n5ZlE6pq2Ox0I3w75pNhu51wsW5rR5PZgcRLfef1WVSlJbFdInoD3IC2Cz9QL5w4F
 R53uCt1VWVXoozxkJIdY0Zb0XHbW5GMAUos0HlXHlUIbG3byPsR4bhiKPViVLHDuX8v6
 xOOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775019682; x=1775624482; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mjh6hL9ZSmG8fcdCcO13TLHJQ/uCk2d3Oe8Nwf6EPeU=;
 b=dBldVqZb4HdG3k8jLVxHZ3QXkLoCB/PJzRYHCWpF5t1xVzibYKdvgMAuElufxL7/AB
 /jMf9DKmyVNkJcaXuwe6im5AvSlzEI71QDUelgpEUR7ahJ0LG7T8KU4ADxmI9sFpP7tH
 /XSSbExBU+8WPfhDUK4mqMQoEHvsqVA2hSnjAdBgMHqAW0loD4ebncxVRETNkVrjkXuG
 arQLarYOK30FxnI1EFPJ3ai6UZAxFgUrVwUU0JHx8lWxp4BrbClrG+DDADsS8hf45Tbm
 f03LLbN6cscAkY9d46NmzV+fBtnO2KZbdD76MVavChh+mnMlxgFWEuq+8OHlsRgMc4Uq
 w5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775019682; x=1775624482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mjh6hL9ZSmG8fcdCcO13TLHJQ/uCk2d3Oe8Nwf6EPeU=;
 b=bc5CNVRWnnY3qBxBqqLL4gmhMj+hwPl2UZFYYvuqhyYyJ8RBhPS17B5nWs+kYcMzW1
 APRs7IA+yudMrka1L/PP1YaD11pxrMSqN22krqXn73HRq31445Byqow4yIiLb8kw5Nvb
 JBFn1SkpdG2GaPtNcfIam82JTj5FC9hIRfQfCP6H16OMegntMGk3DiV+SY9HivBslNMN
 bd0UEOky7CpagUFcnJF/1etXlZa5UKUT0vLSS5bcUe+N/fzGtxN+ttvwMY88QPxlLBgC
 7oLVBlELeZoN1c2g6ewzIuOWNm4CoFcbFXsIIxatmUSGGl2fe42Q7DIKBEx87miHbrt6
 ggEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9uEX6SgNS8SlXCgBQQMM5bzV2cipoh2BKcZQ/uRAaUxNXsuyoQMltjfH+Yk/me91w5/xE+P+NVaUz@nongnu.org
X-Gm-Message-State: AOJu0Yx34W7+1ULizzkKMy7E16nzQ0bqL/xGFTxQNfR3WW2rIxoDHTnG
 QFFj22WjhLgvz8N7MJk+CGNKweXQNZZ80q9+MD40wo1zRTZitISlJfstngiNY/ocxe99jX5ooz9
 OIQ3eVEWD1B17Uqz27JGifNkDHwGEYv6Bp3A4
X-Gm-Gg: ATEYQzxbk8J63/r7RvJ/+QOjgyD3WTUHVSD7Ce3aWU/xiUyDa4RksJBBqVCt//f4WvU
 wcIriw9EDqgnCqfc4dyDAlVWyEkMggjImgD+pmn3mvFY3Ve21k29AiVaO656v3Wt2YnTr3IjGiN
 37oiSmSStZ5YTMGvb+ooXJwBn+434XxpUBjSOcOI8Xm7+WcsjBmMeiABJdFnAj02gr6izu08/rA
 jsUKyGHAQ2A9wKoT2spOafFmDzSGH4NHTEF+GcEML0V7bf4QM/lctjdwkBYlK38KGWWTufsHsac
 4JuWnKNyHCltvOMykzrrNHyywgk/gaq9/kpbrA==
X-Received: by 2002:a17:906:208f:b0:b98:8692:bc3e with SMTP id
 a640c23a62f3a-b9c1379e34fmr101975166b.9.1775019681501; Tue, 31 Mar 2026
 22:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260325081314.57089-1-yang.yicong@picoheart.com>
In-Reply-To: <20260325081314.57089-1-yang.yicong@picoheart.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Apr 2026 15:00:54 +1000
X-Gm-Features: AQROBzDTttQJr9yIPzsc0iqyY3lTFq93hnQ8pbeNh7veDI_lWt145tJYuXpQdGk
Message-ID: <CAKmqyKPOwZoRkOxGtfatvyv4c9MEpUq8bCmGRanOgep0LZcK6w@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build.c: Use kvm timer frequency when
 kvm enabled
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: sunilvl@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, geshijian@picoheart.com, 
 wangziang.ok@picoheart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 25, 2026 at 10:34=E2=80=AFPM Yicong Yang <yang.yicong@picoheart=
.com> wrote:
>
> The timer frequency is decided by the host(kvm) rather than a fixed
> RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ on kvm accelerated VM. So build
> RCHT with KVM provided timer frequency if KVM is enabled, just like
> how we build the timer node on DT based VM.
>
> Fixes: ebfd39289370 ("hw/riscv/virt: virt-acpi-build.c: Add RHCT Table")
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/virt-acpi-build.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index f1406cb68339..fd6ca5dbc4ff 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -35,9 +35,11 @@
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/numa.h"
>  #include "hw/virtio/virtio-acpi.h"
> +#include "kvm/kvm_riscv.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "system/kvm.h"
>  #include "system/reset.h"
>
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
> @@ -296,7 +298,10 @@ static void build_rhct(GArray *table_data,
>
>      /* Time Base Frequency */
>      build_append_int_noprefix(table_data,
> -                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, 8);
> +                              kvm_enabled() ?
> +                              kvm_riscv_get_timebase_frequency(&s->soc->=
harts[0]) :
> +                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
> +                              8);
>
>      /* ISA + N hart info */
>      num_rhct_nodes =3D 1 + ms->smp.cpus;
> --
> 2.34.1
>


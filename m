Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EE7CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oNg-0006JI-SR; Thu, 25 Sep 2025 11:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1oNe-0006J6-F8
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:59:38 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1oNU-0007NG-KZ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:59:38 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6353ff1a78dso616586d50.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758815963; x=1759420763; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uzASJePoYprN1HeknVxKlWJ+aJB92keRULtXdkBKq1s=;
 b=Xyr/Fs5wDe0VVSLn3+KiQJVw5aT2pq/4uMza0X5ASuXC3IDUvNQ/41nmRwSyCypdHZ
 9zL4eztcNn4JF7+8TwA26C9FFOZRrAD2MYBvfpOj7jOzdOysIjrSB68VXlJuTW+xexHF
 DQhzQErCsStI0btuB4B/r1mg/5dCDdjFes+uKmFRMrXkztdTFmBP9arKItlQiCli2Rh5
 Q9lEycOsNMloH4//M0Rxr5YQ8Oguf0z1vY+NyAIq87zD3y2pnsq58CVeDmgrsIodWFCh
 I2Q0Q1mvWBFM52sVv6PqIE+wETBAUoNTicPiE3h2EktKG6kSHEa34joBvU5dgHBCbceb
 AXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758815963; x=1759420763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uzASJePoYprN1HeknVxKlWJ+aJB92keRULtXdkBKq1s=;
 b=CjuQR2PaK8wXAgRlfoWVvQV+S8KDnWzbS4VhPSMequ1DyT2L9ERB8ihII8Bsz7HoNh
 EWaAjS/vjR5bHGDIB3IvKMJw7ugU4XBYPRWZu+dSZ2KQSC1VcJSXmyuMCbHiAUTweix7
 sh+n+XGu+x0IWVt0Z46ocBtDxN5p5Ube719JqQwmnlS9tN6XHTiXr4usG1ZRwvF+UM2F
 vPI+Ubp19qiyv4iyb63DH8O0cCIWtVe5SvBqqGOHJ85jVgnc3IinKfc99uDc7OVxjPgy
 SadkO3HwHAFY+X/zg+/mnQWZtZRT8yVy2abbpuAMhahANgR/N7QbX5HyWpaw4/RYmf2P
 X5uw==
X-Gm-Message-State: AOJu0YzSmZWAcT6xNoAPg/zE36+kprVmLmSPwxUewZQ6Mk9HtK68rIlJ
 i1Cj6smfuCItU19sxqbynLVuGg9m2DDD4hzQxxOOnTAHBHjimS0gkQJBZ+1iFF5iACnLEpAEu29
 y6JawIIWBfOb9+H2J+hvf14eV3MEOmnyqRox4yLXbFA==
X-Gm-Gg: ASbGncthxM7MRftOXwt/OF/D4UaH/m6jViiZI2taiCtDe5CoewhSgxKHEL9dYyIV9Wg
 DUkHtjOjlp9btzGIJfOt0P3NyhmE7/cx7XPM5fy6bLgYX1CYpNqdNU/symBHNvd+Zo+SGOmOxkY
 7ZZROLOKW6L9he7WHIik2wevEHOgp+aYFvN+NDztxbRQGxs6WUoNAWGFAuE18iC2vC9uGP8k2zu
 wPOup14
X-Google-Smtp-Source: AGHT+IFSPhwXk0JvVn3LcsH6qtiVAFaDSeMlxlAMOGYHS/Bpz5/ipt2MOWiRViVkhVj3++SEhbBiPd+BvNljo70N1Wo=
X-Received: by 2002:a05:6902:6309:b0:eab:9d16:f038 with SMTP id
 3f1490d57ef6-eb37fadbba3mr3248959276.3.1758815963070; Thu, 25 Sep 2025
 08:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
 <20250920140124.63046-5-mohamed@unpredictable.fr>
In-Reply-To: <20250920140124.63046-5-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 16:59:11 +0100
X-Gm-Features: AS18NWBVfN6et6UqDg1jE2B_lcNu6A2J_kHt6qeSd9RBy04PUlwbM-UoIWXBlq8
Message-ID: <CAFEAcA-cAt4q6HfS7--T4Qd8qag-+fMYu9PQh3SoEtvPbd7VpQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/23] tests: data: update AArch64 ACPI tables
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 Igor Mammedov <imammedo@redhat.com>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Alexander Graf <agraf@csgraf.de>, Sunil Muthuswamy <sunilmut@microsoft.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 20 Sept 2025 at 15:02, Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
> After the previous commit introducing GICv3 + GICv2m configurations,
> update the AArch64 ACPI tables.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  tests/data/acpi/aarch64/virt/APIC              | Bin 172 -> 148 bytes
>  tests/data/acpi/aarch64/virt/APIC.acpihmatvirt | Bin 412 -> 388 bytes
>  tests/data/acpi/aarch64/virt/APIC.its_off      | Bin 164 -> 188 bytes
>  tests/data/acpi/aarch64/virt/APIC.topology     | Bin 732 -> 708 bytes
>  4 files changed, 0 insertions(+), 0 deletions(-)

This will break 'make check' during bisection. To make a
change which updates the ACPI table test data, you need
to do a three step process, as documented in the comment
at the top of tests/qtest/bios-tables-test.c, which will
result in three patches:
 * a patch which lists the tests which would otherwise
   fail in the allowed-to-fail list
 * the patch which makes the actual change to QEMU
 * a patch which updates the test binary blobs and
   empties the allowed-to-fail list

thanks
-- PMM


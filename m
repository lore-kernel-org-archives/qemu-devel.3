Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA24D61017
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSCp-0005x1-By; Thu, 29 Jan 2026 08:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlSCo-0005wO-3G
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:37:06 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlSCk-0003My-T0
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:37:05 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-78fc174ada4so8055307b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:37:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769693821; cv=none;
 d=google.com; s=arc-20240605;
 b=Aa+AL420dGK+GjwgLQIqWlry0rD6c2HJ5s0cXAo5RDufuPIYZtJmWKDUcbSD95uVho
 meaDSsuBvvHqPB0bp+2LMZMIIj/LlpODAKpC+BgOhNqPejJRLPDJdtWFdsDzIPlO+J6C
 4tafJY6Wt50aJ/v35v0J7qdPZFrM5oMRBGgOr560/wV+y/y10fB6Km4UDTybwyvqEawH
 h25ErpfhGEh/d2TvosDp5yQbdEPcbo7y1+g4Sk8LgDD7PkM86DLlh7h2zbs+cGLvDpOG
 SiJm86OBlPP+RFTiDSaKZFP5KJxndFb6AaSZ2Hd4hZBX+iuUSkrHxM09PKM09l+rxW7x
 eLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sN/IfYN/Xe9ADwXGup/nslEHImNz4BeTCieJNPMoAXo=;
 fh=us4lPT8YSvMw3WPWVr1x1zbLMIgA1kHH4DqlCTpJeag=;
 b=SqFG+stIMs9Anj/XB/RqcA00R94/LMznb6zgmnfj0uoUPHhIE8ZXz8fJjU0vQKCHQt
 +ioYkendt6XNVfVMrNQqfwENKTHHpTubEdK9bq+dpSm+KYHermY4ZzaeQHmmqxDjeuPy
 pznsvCZgo8ih6pJp9xMjzZhC0Eqm43DuKtnVBpc8diApXz4bq429ZKS6DAQYI+DiGvkH
 1D4PZYxd0G46RJbZLwxaVspzM52Z7+nPCAnX2xs8Fde6niPLa8MYX3qkcT6iRWbzsPsP
 EbtXpwcfHRcZbBcZE6Q0L4rKm+2+aiuEqbEkDJrxwsivcN1kZGmRSx8TPl28P9IrfYLS
 nKPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769693821; x=1770298621; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sN/IfYN/Xe9ADwXGup/nslEHImNz4BeTCieJNPMoAXo=;
 b=BHdU4g+ALqjWSP/GzPWjl6LfkHKXR/BUCEn/P7QohPmpgQ9raUx7YQDDIJSyJbRDx2
 uUbZYMk2eUqNfHQA43Lw0n6D4QJANd9jBbMM6X25sDc2hmO6yda1brzQ/V6DJoeD0t3G
 caU/K2pgOeLZVTiEk9l1H49V88okpT0KVib9Z1k5gRE1uYxoNIRleOlWIO3PnmVL56WP
 WNKJVn6hlj7JZflO69ieqXgs1vohHQg3P1NFXMwHtpreih8kwfuAj6yJCJu0sbjJMphh
 WjV1fyeZvugpzfLJlvY6qTuNN1PGvG5kFGqEqp8PVNP/EJG7Zwy/0epv9I4Sh5m6VaE9
 K4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769693821; x=1770298621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sN/IfYN/Xe9ADwXGup/nslEHImNz4BeTCieJNPMoAXo=;
 b=NI8Cyp01MN7QEKrA3PdFj4+YqKlNAr9nG0/FhHOFipxBeZTOIAfQxEIkfYWwkLuGiY
 dPi/XjHObPb1tySuk5sEUmG5XPPQfxyYWhIPHJOacZv7qEIHoHsU2bs+Qm/EQuILh1yF
 QLV+zB41vLZLCYksvecEMLXc1NZ8PDcoIeftavezjLzE9w2etmusxEdrlCCuIpGbqk/X
 8PLPwKaAJz3nDITyK1Z0tC9jI7ajCIfqcSxxBltI0c0TDl2VvV2iE6upXNWcAm/rwutn
 8ZWTdpg8SXlroKIl1ZgfsNgVeRO27IXU1OBPeGkfbhlyrwqdBIY2fvcONa35MiQOhEdx
 OjWw==
X-Gm-Message-State: AOJu0YwZd5JL5+EZVMGbM3dJScJupr9RuvY2Y4dKZNu1yOGTHNc7gWC6
 ShT4wvAB9PrLoFe6wRHjELT/5uLOyR5OXeg0RyiIEHw+6rcQr88vfboIUzF8ed1Q2IvAcGskuDZ
 iDSpP+jmar1qW46uY0uefye1iXttllSwBFg5KuQQyYg==
X-Gm-Gg: AZuq6aL48c6v5cuaZZuJppTJH7qOdgE+KDw0lX0U+f0tOdPvYMKJGPP6OQ+tusfbgt+
 Trkm26Itc6A/OtXC2PLqf26VBzkzR5TS/545FTh+P84/dsTs1GpJqgGbbs9uhAOvYh6MvCSlChV
 W6xdDD4PXE0sVZhUCoVFU/UtnziVIttqBcXNNNj8tZHIk56zDcdnALaKqkMUgKrlovP/GlACpmN
 TbvsS8OZrj87tEJtH+Gp6jiAeooWB1Xdi4TNasLjD1lJxkRXwjBts2QCV5ZywK1PEHAkw==
X-Received: by 2002:a05:690c:14:b0:794:8d58:cac8 with SMTP id
 00721157ae682-7948d58ce74mr39171537b3.4.1769693820790; Thu, 29 Jan 2026
 05:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-6-mohamed@unpredictable.fr>
In-Reply-To: <20260127182805.73212-6-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 13:36:49 +0000
X-Gm-Features: AZwV_QhJjQyc2L3PIYwRjF-3BhFl3zXOwzagj7lW2l4jmo7kyVF_gHIOKjteGYU
Message-ID: <CAFEAcA9qtLv1wOKkEmtNO5UsGTAM0x7YD+y8Fsu8hCQRAD_o5A@mail.gmail.com>
Subject: Re: [PATCH v18 05/22] tests: data: update AArch64 ACPI tables
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 27 Jan 2026 at 18:28, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> After the previous commit introducing GICv3 + GICv2m configurations,
> update the AArch64 ACPI tables for the GICv2 case.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 84 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 260 bytes
>  tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 192 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h     |   3 ---
>  4 files changed, 3 deletions(-)

The process documented in tests/qtest/bios-tables-test.c says
that this commit is supposed to have the diff of the disassembled
table data in the commit message, so that human reviewers can
confirm that the changes are as expected. (If you git log
tests/data/acpi you can see how this looks.)

Can you provide the ASL diff, please? (If this is going to be the
only fix needed to this version of the series, which I hope it
will be, then I can update the commit message as I apply the
series, so you don't need to respin, just reply with the updated
commit message with the diff in it.)

thanks
-- PMM


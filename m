Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497A9106FD9F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0yFB-0002Kb-2h; Fri, 13 Mar 2026 04:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0yFA-0002KT-3b
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:51:40 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0yF8-0000vv-D1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:51:39 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79853c0f5b9so16679567b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 01:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773391897; cv=none;
 d=google.com; s=arc-20240605;
 b=AbI19K/kyqWefYnYEuxkGn8FfwTmJD9QB3a6HmtbtGhPUTUcT2VVJP7qhBQJ9j4Puh
 +WFwEBnWmwfhWWBGPWnYPQio78tY0l8jo99elZh3K10Jig4/hrGKcHKDlzgFceHrUVzp
 FVKBRXl0q0t2Yra23jA41b/JVioylBuKutvOZRLMDGpV9pr3IY2hKD/m7Aty3YJg4cO4
 Z0R0YVzGLGBOlUN/Au5B9/A/aJf4nGifv4dYhFqQaJyv3IaJc7P8MfxpMVeTm7FDlivn
 WqZrjhp20NTZGbQhDMVF8ArO2u6uiQSZgA4XjNZSxQZtE6hApmPqdjoLPX6Bx3O3FwFg
 85mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i5t1G+Zco6bUzzI6D3C7vhsJ3PS3uCBgdy6Tt5rVteQ=;
 fh=lr2UDnFlALW4PWJS1098kMDjkwOB0pK9skvwqB1SRxg=;
 b=HUgu+vme9uo+/FLZSnFMWF5KZ+LyZhIy2vvMkfv09/XNR/n1dYMJWWZ9c91JrN3giw
 TkfTyqcyN0szJ1UKfBt6C4pm9LXp8jlO9ak22Z4tViVEaoP6P5VBBQ8maTlewUNnH6bD
 QngNVpBLQR4ynsOQGf33lvX0E+pIjtMKs4tOLaHLFpRxMHok+9o8c09pC2Jza+kfp2o+
 /xIik+Su9KoLkhGz8EBB6fl3rnSemNpfBsLbTozkQs0FAXo+VMZsezLGbOg6HFYHT3BY
 9jamowM0OM4rUTFNE+L+Co3EKVUZos/vDJFFLIdEw3MQX5ZkxVY0UmQj8XadP4WOniCM
 6YEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773391897; x=1773996697; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5t1G+Zco6bUzzI6D3C7vhsJ3PS3uCBgdy6Tt5rVteQ=;
 b=NLUUodS7IfhSrvm2gJdov18awodjV5TxmK1s9xFLBb4lx8pu3m8OvNguoLjLDq0v7e
 YtxtGJlNrpfkEJWwJVUZ+HWcMPlQcEGAnJu+QYsHKHGTwlLfB729W/Lw1c0BIE0SgDhc
 HLJ9uxU8Y0YUOH0J14GT36NMpHlj1tWsThY1UMW7yNYsRAEV1ClzZholy/LK8SFwhKMY
 0aPixjVJQCrGGoNWaU+KfuU1pvkBVWhfXBeU6lU0d15B4CYgByVO/rVK5Zdmk+iOhHw+
 P3fbmcfzhiXrh8Ij225pna5NqI6vNPS8BptEGjfr8x8iIBexRlwa9loMykPWAdhf4s/M
 daLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773391897; x=1773996697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i5t1G+Zco6bUzzI6D3C7vhsJ3PS3uCBgdy6Tt5rVteQ=;
 b=SWAehEO9lWmoEg0r4IKTXIVTz6cAnFjVfxhlxNZX9tA7o5ymoilq7PBXe209dNFjPd
 zcaLJJKSjVvfHspGnmoU3j16ZQsbeauNY8DGBvZnFcZ7cL5P2EErVy0SR4IlNEK7pEF/
 uay+Vg2HRPfPUCS8bofe4BjKVp7IO8rOUzbZRVpWwZ/Y+Lwx8nJs49ENqM32ytJhjmKW
 kRohotEspoy4O9x9xfoAEF8JdQhZCoYezFnppXDD600/5No1OaJ3G9igfNKjHxZvhJzx
 yflEJ7zp4l0cxyEQ7Aj2vVySyfiuzlWdpQRocXeeXAXbXFT0A5Nv3jLGg6EYa9a7gJuZ
 9WEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmsF9YCq70RwH6CW7iWOelGCuRfehytPfB7QbSj6/yJp+DZ3rXMlAvsSNyQUUsyJY6MM0DC3iS8aF9@nongnu.org
X-Gm-Message-State: AOJu0YzOxWR6CNSYHYJroPfZWw9dfWbMWQLe84vWL+htRZ7I2ZWhsJ7C
 eQ2alFjdOj/vVaA7hh6/5fnodx/av4llu1/L3QJb+pgfQu//RXN5zayTyNN/wWdsVpUSAEOSgqF
 j620XxVXOQF8nkyhtqv8c+C7SY/D++LpOFTpp9flk8g==
X-Gm-Gg: ATEYQzwJ4FWnTceLXtKo+qSZD0GZIkJ34MZW0NcLJkf6W2Vu1+ESlRsKmaqhRhUHqXr
 zs/Tl+jAhPjNmzQ4g7S4LRkc2KAX5l5fVNhoyEp42tXWTwCU3CEhMjYWTiOvRD7KvhFbMQRjhWg
 M+9iBSiuCyoGqRZC/Lj878zPIIgC/XfbFxL75kPyarvfJcsD8O+bhz5aushaYUge783F9Y/oyAp
 tqGD3BJs/q0YEZDQRvqd94AxIo9Av0H55bxxa4B2Ns0rQiBIfSeh0guNKjDij1HG1hJvUsQ5hO0
 rn1UZszKboU5K3zvglAI+YYbW88+8e449nxXp9na/3fUF3FI7fA2f6mt9DNVOraJfW8=
X-Received: by 2002:a05:690c:f04:b0:794:e167:b4c0 with SMTP id
 00721157ae682-79a1c1ff194mr27090577b3.52.1773391896695; Fri, 13 Mar 2026
 01:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <20260311-semihosting-cpu-tswap-v3-2-8e239575ec08@eonerc.rwth-aachen.de>
 <bde55593-a51d-421c-bfa5-4a0c774f4b61@linaro.org>
 <CAFEAcA_Qvo86Ek2W7xGQqGP94400c7wx-C0=zpBUF5NoM2jhfQ@mail.gmail.com>
 <80ad84b1-0c4d-45de-93d4-90a471f7f751@linaro.org>
In-Reply-To: <80ad84b1-0c4d-45de-93d4-90a471f7f751@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 08:51:25 +0000
X-Gm-Features: AaiRm51TSE2kVc9V3aI6rp8BwGtvrmHve6-doG3dlueGqEvAPzcD5UUEz5_-0zg
Message-ID: <CAFEAcA9-umnREmEpWLV5hhXkfXZWqmMqpt3DAL2kUe1spttyKg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] include/exec: Provide the cpu_internal_tswap()
 functions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>, 
 qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 12 Mar 2026 at 19:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 12/3/26 20:30, Peter Maydell wrote:
> > On Thu, 12 Mar 2026 at 19:29, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> On 11/3/26 17:27, Martin Kr=C3=B6ning wrote:
> >>> These functions are needed to support semihosting on CPUs that suppor=
t
> >>> runtime-configurable endianness. They should not be used in other con=
texts.
> >>
> >> Another note is these function are not target-specific, which is great=
!
> >>
> >> These can also be used outside of semihosting.
> >>
> >> Matter of taste I'd have named them using this shorter pattern:
> >>
> >> cpu_internal_tswap16() -> tswap16_cpu()
> >
> > We specifically didn't want to use a name that might tempt
> > people to use them -- these are only wanted for the very
> > few niche use cases that are outside the CPU but need to
> > know information about the CPU's internals, which is basically
> > legacy-virtio and semihosting.
>
> This was the missing piece to make qtest target-agnostic:
>
> -- >8 --
> diff --git a/system/qtest.c b/system/qtest.c
> index cf90cd53adb..392c1394656 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -523,18 +523,15 @@ static void qtest_process_command(CharFrontend
> *chr, gchar **words)
>               address_space_write(first_cpu->as, addr,
> MEMTXATTRS_UNSPECIFIED,
>                                   &data, 1);
>           } else if (words[0][5] =3D=3D 'w') {
> -            uint16_t data =3D value;
> -            tswap16s(&data);
> +            uint16_t data =3D cpu_internal_tswap16(first_cpu, value);

This is a behaviour change, and I don't think we want it.
tswap16s() swaps per the system endianness. cpu_internal_tswap16()
swaps based on the CPU's current configuration. With qtest
that's a bit of a weird thing, because we can never run the
CPU in a way that will make it switch endianness.

This is why we gave these functions the _internal_ bit in
the name -- they really are a very very specific piece
of functionality that you almost never want.

> And these endianness checks in QTest framework are only there to test
> legacy virtio, so we are good, this isn't even another niche use case.

No, these ones are here so that when when a test does a read
or write of non-byte width data (e.g. via "writel 0x8000 0x12345678")
we send it into the memory system in the endianness that it
expects, so that it arrives at the device as "write of width 4
with value 0x12345678". That is, we want to match it to the
system endianness, because that's what we want to cancel out
the swapping done in adjust_endianness() in system/memory.c.

thanks
-- PMM


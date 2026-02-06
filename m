Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B41EE20AF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 15:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNcp-0001bu-KD; Fri, 06 Feb 2026 10:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voNcl-0001aa-Uy
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:20:00 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voNck-0002yj-HT
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:19:59 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79430ef54c3so8179067b3.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 07:19:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770391196; cv=none;
 d=google.com; s=arc-20240605;
 b=G4VQfv893HMMPTt4i4BFr0kcWNN/QSa4EU2lK4ZKuk3koFsWCR1XiD2RiR2VQ7xxXs
 LR1JbFrfR9JqrHrvCpqsprW76XpcCoSEZMDfCppXXF6aIP3/7aiUigaCs6gsdiq1GIho
 fhSQW7C33R+/EtPVZEL2zYbeJwnk0AoiDPwTiNxmp6xQ9vFWm8sKj3oZBAj3nkL4aCdK
 tIdW4PPOfCJhee3/OnV1xwxbrZMWLr2t16gvUtOcf+NEKh5oe2M9ZVrNkM8xw0m05pAF
 p4f9+5B2wPnC9HtBhE1Z3+x/HyglCn7zO0kEiUt3OrvUQqBZ82zAZjtgxg+CE1Dh0Uel
 BvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SvTBzAJzAOl8XXIQCF1doyuIcJREGlonAbssikLKClo=;
 fh=gF4tJPZZ+BLtU/HltKIrKDpuHOv58/ttGSsaTOAx7EM=;
 b=N8rsAdkPogEl2lB/TcPiqldS/rrOgyrOKH9RQQGUHVLrDYXUPDg4xzjKE9tLqDtTag
 z9HqGl/0P9tzeI1qgw9zUgrmXGsw0/A/Mr30+ifhlenp9ZHQ8baEkzgxs+LqpLdE9LGs
 Ei7711h77zwCwyuL1d8z1M9mL4/jrQNygZ6hdyR7P63nQypg8gZc99dAs8y1MNBsjFSP
 Fpg+kd/vlEbCJWqsKhSR6+qjFE0NZFHFVP6wOmwxFh3WGEw5RZOzsF6f/b4Dphb928HV
 YyVMBEb/ZCiuICPf0l8dfTzMVkUT2NLsXVeKOoP9mQFa1rI2/VNgBmb65bS5Jd/NpntO
 BJaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770391196; x=1770995996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvTBzAJzAOl8XXIQCF1doyuIcJREGlonAbssikLKClo=;
 b=mMwpRx6FQaXGOq3Nxli7BgzvB1q5tzeLSjRyrxLYlUkk7URrS9GntRGMdadjPJvyZD
 B9NlmwK7Pj30W9CHytHSnbcn7Vz1ShdA7hb+ahmKrhH8GeZf0lW/+9C+uP4qGROy3/fV
 H8AS4ntJytOvCJ3oLsKHhJu/w5sCst0kfK4+HcitiwmZDVQL/kIf3c3iEThTxLLiVCbw
 WiATKXItzygJp8FauXQ7rHnwuHAG9f5CPms4qOGlzwqVHlDOfm3rIKzavv78RiKfwjWD
 4/XN0FF85QjSqIKWkmwuYLCNbQhSu0SwcvJ2+9ashyiYcjBW0pk1nr7pDB4NqZeHSOEo
 5cBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770391196; x=1770995996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SvTBzAJzAOl8XXIQCF1doyuIcJREGlonAbssikLKClo=;
 b=RCTlhgPBmDkmQvMT5WDkbbzsQLuya21P12SGkeuywItjw9KF+CctksgObAzDyOXdfG
 0A1llAUD5c2XfGiXL69aQ9gcxvILThQ2xETGfxzm9B6fJ8Dx967hDN2E3F4Abd49el9D
 Yu1yRTqJj+WBeXIs6vGgkOvsACDGNx1jzp0iCWbMBCZ/jz5dSuHUhsKVHhLL94vI9mAV
 g9uRnsPD/It2HH6lqcpKmwEv70nW3wcI2UjWn9vEZGt+cd1Ope86tP1RDpDsHQA4YZY3
 w4e9MmNmEY1dC898inrB+J/RD0zIapPGXpO7NAHJTfzA7ciMWx54pE8Dz37VKqRDPUON
 uI/w==
X-Gm-Message-State: AOJu0Yx/Hz/Uu3n0ogAA1qpYAnqKHPsbgu2N4rBJy+QDalat6vtYw/jl
 RTDjnus94KpMgpN74pi++1Ee2rD8buk2FYT620CniLgjVdOJMkH7QBZQpRnlXtyVeouXUXcnm34
 VY2mPca4F+eD9AxAH7YJHPKeeS63tdQILNW8mtCEPWg9iegSaiRfWMeI=
X-Gm-Gg: AZuq6aK4O/JNSsLL+Pb+OP7Zja6idiEb50lnIfpjSww6sW3CyWvT3OIxN9H7XlVbdNU
 edDgL44Q2BxMvEcFo+J4UREt+k8oKsrYnP6wkbMRmzLpM5kr/R7VjBNox5bohUQNVp8v/0lGk0e
 XQiR4pfk9JSJ0bd9oLj+Pq9XljeuoH0gzcrFOO7oh/0b2pZNNBMYKgBk9lcnC9WE50saAJgQHep
 +a3JXWLMRguCOK4LmZGvomMnIhqAIEK4/CbduQIDjhOlVQ8k49TCy5zP+205fxVTxB7puDIpNO8
 ZI2NIAjp92pnF0u69WO33DlRu7V7LTfZNgX+lHDDvEPos57SO0FOwRg=
X-Received: by 2002:a05:690c:dc4:b0:794:a7d:6bc4 with SMTP id
 00721157ae682-7952ab6f3f7mr29778237b3.58.1770391196400; Fri, 06 Feb 2026
 07:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20260202153618.78675-1-philmd@linaro.org>
 <20260202153618.78675-3-philmd@linaro.org>
In-Reply-To: <20260202153618.78675-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Feb 2026 15:19:44 +0000
X-Gm-Features: AZwV_Qj1FcYgTWLOC3kd8lxNpxKD40eAcbqmEKy-BJuNj7ZXe3wExirsyiA6ehk
Message-ID: <CAFEAcA9wK+r32zLwhwHTAmnXHm0_bQUuNpegGp7ymZFTCa-FMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/arm: Deprecate '-cpu any' (remplaced by
 '-cpu max')
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@lists.libvirt.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
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

On Mon, 2 Feb 2026 at 15:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Since more then 5 years the '-cpu any' is aliased to '-cpu max'
> (see commit a0032cc5427 "target/arm: Make 'any' CPU just an alias
> for 'max'"). Time to deprecate the alias so we can eventually
> remove the alias code. Emit a warnig meanwhile.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 586202071d0..da664c4e30a 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2218,6 +2218,7 @@ static ObjectClass *arm_cpu_class_by_name(const cha=
r *cpu_model)
>       * which has the same semantics as "-cpu max".
>       */
>      if (!strcmp(cpunamestr, "any")) {
> +        warn_report("CPU type 'any' is deprecated, use 'max' instead.");
>          cpunamestr =3D "max";
>      }

This doesn't compile:

../../target/arm/cpu.c: In function =E2=80=98arm_cpu_class_by_name=E2=80=99=
:
../../target/arm/cpu.c:2224:9: error: implicit declaration of function
=E2=80=98warn_report=E2=80=99 [-Werror=3Dimplicit-function-declaration]
 2224 |         warn_report("CPU type 'any' is deprecated, use 'max' instea=
d.");
      |         ^~~~~~~~~~~
../../target/arm/cpu.c:2224:9: error: nested extern declaration of
=E2=80=98warn_report=E2=80=99 [-Werror=3Dnested-externs]


Also linux-user still asks for "any" by default in the
arm and aarch64 get_elf_cpu_model() functions, as does
bsd-user in its TARGET_DEFAULT_CPU_MODEL macros.

This seems to me like the kind of deprecation that is more
effort than keeping the compat handling around, if it's only
three lines of code in arm_cpu_class_by_name(). Or is this
going to get in the way of some cleanup we'd like to do ?

thanks
-- PMM


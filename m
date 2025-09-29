Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63673CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 05:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v36oq-0007XO-CB; Mon, 29 Sep 2025 01:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v36oZ-0007WJ-ED
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 01:52:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v36oQ-0002FI-3I
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 01:52:47 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6349e3578adso7996350a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 22:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759125148; x=1759729948; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VCq/p/lbn3Kl+U3I6tXHtQ0bYzRnf9Ug2LmxEWr4K4=;
 b=ZRrbDXp25a8RRLMird1amQ7/B9A34aXBhWPfSXUmYrq/D/cyB0OAfP201wOGMmfbNy
 2jgJ0XaaAboipWOGjMckSKBOsyNWK31HEDHBV/WT7BXJpKQk6GbDqz6NeDKUBVfQCnwd
 3d74iVotBxTgBknYz91qlR+mKlPwGPH3C5vDrMuoFjoYbL1bsFji/xgXGHUKQh6xdjYS
 xc8dCuTRQU/2m7nh4Je3ZYRkPMV7GOSMICFSsPL6usuOhMnTeptIwaknZzLF9MNOF8eT
 wWamrOpynCUBWxMxy620wTWyc67Ux0vvrOasmHBxgDjHS/afNAYcr876RfpO5/DvwnHd
 FLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759125148; x=1759729948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VCq/p/lbn3Kl+U3I6tXHtQ0bYzRnf9Ug2LmxEWr4K4=;
 b=KTiXV41AeNnBJ1EF5mg4/z0oyRQSSiBaPgeaQTTqchSC3WcgtEMVMpOoTiMueE/JPc
 4WeJqYmganwuHtbCuHiLgu+IM8sci6NnBIhJQvN4meysK3l7BlI/LgNZ24gEvBhSPEmh
 4UXP2klsaaWnVv3HKhbhQaAULHDmKPB2znT+E4Arekh1TR03VMyzRCkA2pYuRkaqjJPt
 ks/X84qhjX7CFqMjPmfkKCOu9TPWXSAPGZONIEVbTKM1inRlvpUqrVGZifzInF0SptQV
 8hp/TExmBsibSYveXJTVUC1zeZb3NQkx0n4zXxm+ImEwTZ+tW5Avj8oIf6Eg11IG1o6Q
 TN/w==
X-Gm-Message-State: AOJu0YzrKX4pq1GOGTUgnNIXxwoDPfTLQWp+3WVEZR/f0RSoRrCrZuXU
 o8GXyAFt5iqspqMyUFzhI/9RGxpx3XyMydSTIic0ZKYDaGGYzLKe3j6WjbHIzvtcgNax33a8+IO
 5QKbwbNXeDlQ5ZjRQIEd3uNSVyZP64UvPVfsBFg8zoA==
X-Gm-Gg: ASbGncsNlD8byBgFNQFCSCeD5MqFnfEOwj/iij46hHuVUII09/yrYlFlG0sEgaTwLtT
 7dVy/VbMiweGsGkvuQanWk7U+b50mDi7VxbR1yjuGmhxrbkvYt30nJgewJoIKfpQeHC/BLnw7gJ
 s38uoJZEMpvA4VkyaEiHRRKfmptBtLNPqQMXc55qr3HSq14u+wN4cPzOCs3Ex2EMGX9RIHCv0yC
 T9D
X-Google-Smtp-Source: AGHT+IHmR0pXlkXEaqYJAssv72wOWNWbEpP7cKo7XWRMxbPtxerSu5ZwGFrCXz8PUQpfUTuMB4DcO2s5jaBgQlgA0uM=
X-Received: by 2002:a17:906:16d9:b0:b3b:b839:577b with SMTP id
 a640c23a62f3a-b3bb8395f8cmr507944166b.12.1759125147852; Sun, 28 Sep 2025
 22:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250925025520.71805-1-philmd@linaro.org>
 <20250925025520.71805-3-philmd@linaro.org>
In-Reply-To: <20250925025520.71805-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Sep 2025 08:52:01 +0300
X-Gm-Features: AS18NWB3aHu3e0FbaOMrIuIjUMcGC42FdIPVgPmXuiLfo0G3DvYKo2-l5KGdA-I
Message-ID: <CAAjaMXa9qGfE=tjOsLg_pZ_Zjzpwen1agdfxjJe6VNi2MnOYgQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] cpus: Access CPUState::thread_kicked atomically
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Mads Ynddal <mads@ynddal.dk>, 
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 25, 2025 at 5:55=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> cpus_kick_thread() is called via cpu_exit() -> qemu_cpu_kick(),
> and also via gdb_syscall_handling(). Access the CPUState field
> using atomic accesses. See commit 8ac2ca02744 ("accel: use atomic
> accesses for exit_request") for rationale.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  system/cpus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/system/cpus.c b/system/cpus.c
> index 6062226d4ac..818a8047198 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -480,10 +480,10 @@ void qemu_process_cpu_events(CPUState *cpu)
>
>  void cpus_kick_thread(CPUState *cpu)
>  {
> -    if (cpu->thread_kicked) {
> +    if (qatomic_read(&cpu->thread_kicked)) {
>          return;
>      }
> -    cpu->thread_kicked =3D true;
> +    qatomic_set(&cpu->thread_kicked, true);
>
>  #ifndef _WIN32
>      int err =3D pthread_kill(cpu->thread->thread, SIG_IPI);
> --
> 2.51.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584C0CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTG6-0002xf-Ol; Thu, 28 May 2026 01:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTG5-0002vv-57
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:26:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wSTG1-0000Rd-2k
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:26:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4903974854dso58654055e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779945971; cv=none;
 d=google.com; s=arc-20240605;
 b=JpWp2s7H4k9Oa1RRGPFAy0JtVz7sbXkf3scbPIV/q7MWI1Gm14wGNnatzuwh2gNnIM
 5ZG65XwuzFKsFMSUez/5ZMGUPnncy30t8ZPOp9VGGHmmexndRhvZrmtvYGbXRaUOqlER
 kWb88DTv1wsRCeQpd6IzmDbW0jEHxO2PHePWK2FDcHWQnz2ctG1h00npwZUXgMyAPOX3
 LhcDiJT1jeJ0eS/HMAw9q+1k6DSsrO1o+RsamOGRcqbNL6yWgMzmm0bGCA7/UM3MEjIq
 SKIGAtdYg0o0vnqi/J5YeaZRe5NS9veFpi54RY6mN2WVIOOZVMD1huO/Fmbq7K7HzWwP
 KPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vz8TqbIohTQ8fN1xrWGabOSiqk1+f4dc86NYMrIYKZs=;
 fh=XBvXNygMbloJp+VR+lP4ESgdVtRHCxc7UtbU1PDcF3s=;
 b=E9QbSaDRJCGEWD7UceSk0qANk1DYO/1noA7pb8voercb8blDMVdAUqb+0fbBDKDWzF
 OLpfrHnN5R8Nnv7Lq1fpymAgW7Jt0n3Fat1kYP6JV5SKcumP0/RQpV+sk7J0LH3h2XtU
 /9XsFzMlmS5+EKVORImXjADtfFm5JP12H7JFPY6QI3Vxtq5GxcAQsIrEQfqCLYQz+GTo
 ClOQ7I+afdKGC6tVKrXWbg/RqzLb0T0YVhfkl0h/DE4ymy9j7al1NNkjkFLeVwfT63xT
 FuZDqQvS0j44OlzgQAfckH8P/J9yfrRVB/9cFaUt3RAPsbUNWLGfc3syzkiU4thaTeVa
 TmUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779945971; x=1780550771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vz8TqbIohTQ8fN1xrWGabOSiqk1+f4dc86NYMrIYKZs=;
 b=ZJZuE5jrfibzVlkRVbsCXE6HVibnTBjVIOl0mY1tqiWyFPKfm3AkrEA863bZYgzVla
 fTkC4N21ThhpmlUW2Y8oup4LED2N/vTl8fb4H+Pu0u6KpG6OBdbLmFZFkkLsn0h4z9bO
 UV0oTJ5Aq7jdJll9LifKEeTYhsUfQ8SSCls7NeF21C7MaylofjUJqtmuAb01hSpgknaM
 EA91JHIS4sLhLm6mKbyWDqYsWki3T1oQymgjB+niAeCHXzSqi5r0dKy7iml4o3MOXP46
 K2Z6XXklmo/7CZK3knAcrh/gZrs0jITZwt1JREhcNkj3Fix2EH0YpNRHYNfzIpmwDlsu
 1TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945971; x=1780550771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vz8TqbIohTQ8fN1xrWGabOSiqk1+f4dc86NYMrIYKZs=;
 b=KhyCzG1Ph2mDc0s2Klkn57hQMiQCAnNT4YwCqFuo4s4dlDyQpMjzbz1s+pteiU78jn
 OBq9PSn8axpWSGgMyk/9DzKkxMJRBgtv2VVbP6yH//8YtfWPwOcL7rQgcC/g2LJpdH/w
 lc2hi5AaRjVDpmWnQh9Fz3qXjcm0efSy9420nyKW/soJfMxCxPNwaNybMy5AaBwkWbbz
 u129jvmjKiaOolWr9CS2CWTEKL9embbFhGUrewclvUdO6xsTjK5bnhpiIwd0450MTvYF
 Tfznnci4Fse51kAWbW/itMUnzOR394ol3LOLzJsKu0a6Kql0JsYX0t5511xy98eWCa2L
 I9rg==
X-Gm-Message-State: AOJu0YzyYstnKuogXTRIhkjVjpTQtv3sT/qqDsf0C/YGQ6JIqJKfNaC9
 +qN7lyiIa+p2JTPX9uwyBHVpJW5pUL/YobgpRzhBNRCO5QGS50GFKhyLfwJjpfTL7JArnQ/5nH5
 PAoD+yBp+crN58urw1qKIcyz8Tcd89AL9CUaZyOgYyQ==
X-Gm-Gg: Acq92OEnzNQ0I0vXRJplMIBeMVyRKS19MpM/7pwqdYO8HBLI8h5EpY2x1jZi7uI8DYd
 j9PtLmoJ+PLp1UWaAZRaq5JWSOZjrtxbQkcP3g6zTGaNDY6AFKq3SuGqc7s5+h/ONDQhg/ou4lX
 uR83kbRLaxSMREdpAHCagdw+0DZjGjXL2sroqniPmSAOtT9dFF0UEukv0IjWpHeT3iNnsBGrqeh
 4KgOsZSSvDR2qyq0lZPhEb36BGU4v/o45v9aNNipnG7GnUFgbR2JFF1PWo678I7Tomj0ZcSFU8m
 iz19fjuSNGqyloTg/MuG2eavZ2IMkdp3Zl+GcULA/mu3cysmOdmCjfKwWX4H
X-Received: by 2002:a05:600c:6217:b0:490:44d0:11b6 with SMTP id
 5b1f17b1804b1-49044d01257mr424122455e9.12.1779945970504; Wed, 27 May 2026
 22:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-10-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260528051642.115721-10-pierrick.bouvier@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 May 2026 08:25:44 +0300
X-Gm-Features: AVHnY4JGjkNLld-f8_LXRbM-7SGVNZI6QT5eUV9zvTKqSZL5To-aSG22maQhFD0
Message-ID: <CAAjaMXZdFFi-dKVLWNTVcpYCVVAX3dB=JYbvpwyfLt758xEEhg@mail.gmail.com>
Subject: Re: [PATCH 09/10] target/microblaze: rename helper unaligned_access
 to microblaze_unaligned_access
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, 
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>, 
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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

On Thu, May 28, 2026 at 8:19=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Solves conflict with aarch64 unaligned_access.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/microblaze/helper.c    | 2 +-
>  target/microblaze/helper.h    | 2 +-
>  target/microblaze/translate.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index f81c4f625b5..3434ea47e8c 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -69,7 +69,7 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr add=
r,
>
>  #ifndef CONFIG_USER_ONLY
>
> -void HELPER(unaligned_access)(CPUMBState *env, uint64_t addr)
> +void HELPER(microblaze_unaligned_access)(CPUMBState *env, uint64_t addr)
>  {
>      mb_unaligned_access_internal(env_cpu(env), addr, GETPC());
>  }
> diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
> index 01eba592b26..1429c1727ef 100644
> --- a/target/microblaze/helper.h
> +++ b/target/microblaze/helper.h
> @@ -27,7 +27,7 @@ DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32=
, i32)
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
>  DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
> -DEF_HELPER_FLAGS_2(unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
> +DEF_HELPER_FLAGS_2(microblaze_unaligned_access, TCG_CALL_NO_WG, noreturn=
, env, i64)
>  DEF_HELPER_FLAGS_2(lbuea, TCG_CALL_NO_WG, i32, env, i64)
>  DEF_HELPER_FLAGS_2(lhuea_be, TCG_CALL_NO_WG, i32, env, i64)
>  DEF_HELPER_FLAGS_2(lhuea_le, TCG_CALL_NO_WG, i32, env, i64)
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index 74b5420ed24..a93f14d6e09 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -692,7 +692,7 @@ static void gen_alignment_check_ea(DisasContext *dc, =
TCGv_i64 ea, int rb,
>          record_unaligned_ess(dc, rd, size, store);
>
>          tcg_gen_brcondi_i64(TCG_COND_TSTEQ, ea, (1 << size) - 1, over);
> -        gen_helper_unaligned_access(tcg_env, ea);
> +        gen_helper_microblaze_unaligned_access(tcg_env, ea);
>          gen_set_label(over);
>      }
>  }
> --
> 2.47.3
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EECC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubLF-000884-LS; Tue, 18 Mar 2025 14:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tubKp-00085I-D6
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:06:44 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tubKl-0006RO-Qc
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:06:38 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so5560636276.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742321193; x=1742925993; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIKBRtlhzPsM9FYHmDEFkH3srgSNrGh/z0c4h/04G2w=;
 b=N1jxqZeEX8eDZ1ntpZdqrM+1QsEBdGJ6ETPbNRgzPTYt6wAOjXMY7p1m7Gk3JGH9/P
 2oRMfYJ/MG9J9V/HXOITTXZnYSaFiS6RKRvzlrb39NR/C/jEyBsbWjcva5VjUwH0TdND
 SUdqKqUm0ahWAo6sRATFwRpzQ3Bgqe8+jK4S6BZVXYcSzezdhSK+taTVDCT0I0vrcwCB
 ntDFONZStDl51ppz/v3+iRDud3aBcvH4+I2Hd2ydpuXpI9StrD3oVKA4LUyviR1rXT1I
 dGCbEEndpF0ZwSOsL6zr+PQrigey+1ZuNR3p6GP5dBEUencwkGVehjjhut9jV+v5SnIa
 DAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742321193; x=1742925993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pIKBRtlhzPsM9FYHmDEFkH3srgSNrGh/z0c4h/04G2w=;
 b=dm6s7zWIr2tsbei+f0LWDNFjZ57mZIlCLY2uNXtWhYO9C1Vfd48cOBlFcZv5Ihw2JV
 Mij+uiOeFn3tj25YWSpoymzQ+GojTY2VUk0+ZSVWwgDUj+ZC5vTVx9in0AZU3p6dG+1E
 tVbll1i1sqC5VcgwlClh1Q1oVdpqfvOCHcRx7r2WfIIKM9NHQICI700Fx7fDOnN7prE/
 bhaUB/oV+qVSpLm8sr5HEq1TWXsxH9YEKFt+o+xU2qX5uBOqIwk+9qb2kjFg2DEvq0XU
 dDfYFeGqJhN8yPKdWHIQC3tXZU211Vjws+gMgd4hDWglqRHQkezDRdkmsv+ShGk6oGEh
 ovmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYv64q0tavzkpTykSRlGuCq9rcinsY2bNEb5Y171xargGGCxcferWJ7gTa9/zFVIRmJz+vY+0lOyOi@nongnu.org
X-Gm-Message-State: AOJu0YwZSZ54s5M6K/PoJO/mGvEAMeuUU4uLpueTvYqOGM6shA1s6kvX
 I6Mb1TES5otuoWV2NK/5zKIrIdEP/hqqoJi9NO9ahQ5pJTwYbHMAeTY8vE/fhcDkZYxEjx4G/bk
 +D+J9EmegjHE6MvzUuzYBwFXpgNA0DSfE+Yr8xA==
X-Gm-Gg: ASbGnct+hHeIDeDcVKVfcKfNae6A10YW7tpA3k9eKiGjHVrQVxOWr2buElkmNtYX104
 1sYU+h9xJAQunNT2iQA8vaGq5G0UmIkNM7IVGCa23SjwlZ9bzlfQRvD6tC+A025KUL5oyHqKbbg
 Kof6E9O1MX+UOy8+CQSL57dRcHLg8=
X-Google-Smtp-Source: AGHT+IFgxkES2TvRDqY5GNivdNl51kTxz2g9VDNygV9JwUiXyElJy4gopiu2DAfAvXAWyzKjQGh6IUkQZopqxj4Z26Q=
X-Received: by 2002:a05:6902:2405:b0:e5d:d9e4:532e with SMTP id
 3f1490d57ef6-e63f652e146mr20848324276.24.1742321193595; Tue, 18 Mar 2025
 11:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-12-pierrick.bouvier@linaro.org>
 <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
 <CAFEAcA--jw3GmS70NTwviAEhdWeJ1UXE+ucNSkR60BXk6G8B6g@mail.gmail.com>
 <a3b61916-2466-4ec8-a4e1-567581be7a2b@linaro.org>
In-Reply-To: <a3b61916-2466-4ec8-a4e1-567581be7a2b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 18:06:22 +0000
X-Gm-Features: AQ5f1JpnElkFWteuW9nidJdWxKahaGJiIURK8S1_MEu9ArX9YDqVQFuSsoQL1Lk
Message-ID: <CAFEAcA9jsFqD-BR+zTzWV1V92fJqpghaOrGq1rDcdidm=R94Pw@mail.gmail.com>
Subject: Re: [PATCH 11/13] target/arm/cpu: remove inline stubs for aarch32
 emulation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-arm@nongnu.org, alex.bennee@linaro.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Tue, 18 Mar 2025 at 17:52, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/18/25 10:50, Peter Maydell wrote:
> > On Tue, 18 Mar 2025 at 17:42, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> On 18/3/25 05:51, Pierrick Bouvier wrote:
> >>> Directly condition associated calls in target/arm/helper.c for now.
> >>>
> >>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >>> ---
> >>>    target/arm/cpu.h    | 8 --------
> >>>    target/arm/helper.c | 6 ++++++
> >>>    2 files changed, 6 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> >>> index 51b6428cfec..9205cbdec43 100644
> >>> --- a/target/arm/cpu.h
> >>> +++ b/target/arm/cpu.h
> >>> @@ -1222,7 +1222,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunct=
ion f, CPUState *cs,
> >>>     */
> >>>    void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)=
;
> >>>
> >>> -#ifdef TARGET_AARCH64
> >>>    int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, =
int reg);
> >>>    int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, in=
t reg);
> >>>    void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
> >>> @@ -1254,13 +1253,6 @@ static inline uint64_t *sve_bswap64(uint64_t *=
dst, uint64_t *src, int nr)
> >>>    #endif
> >>>    }
> >>>
> >>> -#else
> >>> -static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned =
vq) { }
> >>> -static inline void aarch64_sve_change_el(CPUARMState *env, int o,
> >>> -                                         int n, bool a)
> >>> -{ }
> >>> -#endif
> >>> -
> >>>    void aarch64_sync_32_to_64(CPUARMState *env);
> >>>    void aarch64_sync_64_to_32(CPUARMState *env);
> >>>
> >>> diff --git a/target/arm/helper.c b/target/arm/helper.c
> >>> index b46b2bffcf3..774e1ee0245 100644
> >>> --- a/target/arm/helper.c
> >>> +++ b/target/arm/helper.c
> >>> @@ -6562,7 +6562,9 @@ static void zcr_write(CPUARMState *env, const A=
RMCPRegInfo *ri,
> >>>         */
> >>>        new_len =3D sve_vqm1_for_el(env, cur_el);
> >>>        if (new_len < old_len) {
> >>> +#ifdef TARGET_AARCH64
> >>
> >> What about using runtime check instead?
> >>
> >>    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && new_len < old_le=
n) {
> >>
> >
> > That would be a dead check: it is not possible to get here
> > unless ARM_FEATURE_AARCH64 is set.
> >
>
> We can then assert it, to make sure there is no regression around that.

We have a lot of write/read/access fns for AArch64-only sysregs, and
we don't need to assert in all of them that they're called only when
the CPU has AArch64 enabled.

> We now have another conversation and something to decide in another
> file, and that's why I chose to do the minimal change ("ifdef the
> issue") instead of trying to do any change.

I think we can fairly easily avoid ifdeffing the callsite of
aarch64_sve_narrow_vq(). Currently we have:
 * a real version of the function, whose definition is inside
   an ifdef TARGET_AARCH64 in target/arm/helper.c
 * a stub version, inline in the cpu.h header

If we don't want to have the stub version with ifdefs, then we can
move the real implementation of the function to not be inside the
ifdef (matching the fact that the prototype is no longer inside
an ifdef). The function doesn't call any other functions that are
TARGET_AARCH64 only, so it shouldn't be a "now we have to move
50 other things" problem, I hope.

thanks
-- PMM


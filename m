Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBD8E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO4FR-0006vn-KY; Wed, 18 Dec 2024 19:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4FQ-0006vV-5X; Wed, 18 Dec 2024 19:18:36 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4FO-0005dV-Ah; Wed, 18 Dec 2024 19:18:35 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-72739105e02so284618b3a.0; 
 Wed, 18 Dec 2024 16:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734567512; x=1735172312; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ex+GVZ1rtzZOaKOyf8EI0Dksy3urK5gpDFLw2lK79U=;
 b=JcfN8nu1lxNLXRWBt/f7x1G0mFVEFjom4FZ3qbQF3sg6tA8MzrkB+d+RuWv0TlwvMK
 T7olKmtaxct3upypPSI87TY4UVwsSUoOl+pRb6MU8vfh77Tg5d1f0bUQvTAYYlELPd3X
 uXIgfpYHXQKpNubHw41IihxQdRjZO8LjuGP5B8dtpTHExuPsjWamMakDpHWQsN7Xmlw2
 VwRHutfX1t+DcMp+rZ0bnq4ud6SDFXZ7DOkkAmJwbfiZKcyg6BktKHjNuio//hcaHiov
 p45TQyOo9MRv3tw0RML9lUpOBcxlGVA2OckRctMKNcLxvkACJ0bxcAteS+oHVJ9CLVrR
 n8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734567512; x=1735172312;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+Ex+GVZ1rtzZOaKOyf8EI0Dksy3urK5gpDFLw2lK79U=;
 b=LUSX7FZNPwqKd1ke3gpkvc21XeZOSGw460knoSeHH6wlrZnJiCshRmAfJH59KPGSfE
 QtGDNu3qORB6aWxTMdB6VjicIh4Uu47E5Tf4c2Mli4iOH72qA0jTUUJiJ88rbP2AW+j7
 3ggWdz4BP7tgtFbGMHfFmEt+rAZggASCSWqZo1Tign0pnOp6Z1nnG6yKBei5gLtYMVSJ
 2t7N3XXMZ/F37IywVRPUZVMrkL6WhkaM0AVq2zTY1Wd9jZBGKsZGI+hkQT9C8I4VMBua
 FzryEkSw5dqPZh62v6aFEK4PgCLF4jOsGZj6ToI9IcktUTXm2iataZuEczsOAko7FX9A
 6ikg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQH2axwjcEupdM2mcExXpsqlfH26bxu2RzHpHt67YyaIFIbkLcqaeYmouWsKswKMSbSJVRe0wm79g=@nongnu.org,
 AJvYcCWdw0YkTW3WvDopnT8dH9GzZ4oO66CcDUBr7ILbeUtcHHn3M8br1eF/ykcpBBypbpZrifG2JhFTrkqk@nongnu.org
X-Gm-Message-State: AOJu0Yzs3VPqd5DucjUcJrQD3LRiMK6VxIdS2LXzzOz50hBdIlN4BzqF
 7tJixkZoDyQmgc64hfEorpJ+T2iH45MNVfvoX7gMoFVF3tvVYgls
X-Gm-Gg: ASbGncsQsRUsQLUDTp6+a3lhmoU8nVu4A2zFULWSfbZnribvD6F6naHNeLzF7VBuYpI
 DPH19WHOR+6F17TqLMkQu1Vgiph+BG/yBKCCsIy7bazjnyxKlrs/1HN5tsp7Nc7XwTHqCFPxynK
 HcTbeECXEbeDmbFUN/D8/Np2Vc2Y1aKt8VQlTUaISXu0UqhvFmjvjID6LfEOOFtwJb0ufpWmo6u
 Si5I4DyefURs29/UdJOOAHesZBS2cWjT9PI8IC1yEkiwhNMt5DDnFhBdLfqHzTwM42QbxS1/Vk=
X-Google-Smtp-Source: AGHT+IG4XrrB7G00DtLjjQJ7NLKYC2fCsTgNdo8M2Y8Jhv3ukKMSfBC5MiUTEcZx1JOno95Eh62ZVg==
X-Received: by 2002:a05:6a21:3989:b0:1e1:ae4a:1d4b with SMTP id
 adf61e73a8af0-1e5b4889115mr9838732637.34.1734567512347; 
 Wed, 18 Dec 2024 16:18:32 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842b821dab8sm34067a12.39.2024.12.18.16.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:18:31 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 10:18:24 +1000
Message-Id: <D6F8V34XKSZT.G6WIVYBYDYEF@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "BALATON
 Zoltan" <balaton@eik.bme.hu>, <qemu-ppc@nongnu.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 3/7] hw/ppc/spapr: Convert HPTE_VALID() macro as
 hpte_is_valid() method
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-4-philmd@linaro.org>
In-Reply-To: <20241218182106.78800-4-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu Dec 19, 2024 at 4:21 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Convert HPTE_VALID() macro as hpte_is_valid() method.
> Since sPAPR is in big endian configuration at reset,
> use the big endian LD/ST API to access the hash PTEs.

My knowlege of old platforms isn't great here, but I believe sPAPR
always has big-endian data structures in hardware and hypervisor
interfaces (which encompasses practically everything QEMU should be
concerned with). So patch is good, you could just reword the
changelog to make it clearer.

 sPAPR data structures including the hash page table are big-endian
 regardless of current CPU endian mode, so use the big-endian LD/ST
 API to access the hash PTEs.

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/ppc/spapr.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4845bf3244b..b67ab1ee685 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1406,7 +1406,11 @@ static uint64_t *hpte_get(SpaprMachineState *s, un=
signed index)
>      return &table[2 * index];
>  }
> =20
> -#define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_V=
ALID)
> +static bool hpte_is_valid(SpaprMachineState *s, unsigned index)
> +{
> +    return ldq_be_p(hpte_get(s, index)) & HPTE64_V_VALID;
> +}

With the previous change to hpte_get_ptr(), here we could have a new
uint64_t hpte_get(s, index) helper that calculates the pointer and does
the load?

Otherwise,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +
>  #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_H=
PTE_DIRTY)
>  #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &=3D tswap64(~HPTE64_=
V_HPTE_DIRTY))
>  #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |=3D tswap64(HPTE64_V=
_HPTE_DIRTY))
> @@ -2204,7 +2208,7 @@ static void htab_save_first_pass(QEMUFile *f, Spapr=
MachineState *spapr,
> =20
>          /* Consume invalid HPTEs */
>          while ((index < htabslots)
> -               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
> +               && !hpte_is_valid(spapr->htab, index)) {
>              CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;
>          }
> @@ -2212,7 +2216,7 @@ static void htab_save_first_pass(QEMUFile *f, Spapr=
MachineState *spapr,
>          /* Consume valid HPTEs */
>          chunkstart =3D index;
>          while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
> -               && HPTE_VALID(hpte_get(spapr->htab, index))) {
> +               && hpte_is_valid(spapr->htab, index)) {
>              CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;
>          }
> @@ -2262,7 +2266,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
>          /* Consume valid dirty HPTEs */
>          while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
>                 && HPTE_DIRTY(hpte_get(spapr->htab, index))
> -               && HPTE_VALID(hpte_get(spapr->htab, index))) {
> +               && hpte_is_valid(spapr->htab, index)) {
>              CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;
>              examined++;
> @@ -2272,7 +2276,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
>          /* Consume invalid dirty HPTEs */
>          while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
>                 && HPTE_DIRTY(hpte_get(spapr->htab, index))
> -               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
> +               && !hpte_is_valid(spapr->htab, index)) {
>              CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;
>              examined++;



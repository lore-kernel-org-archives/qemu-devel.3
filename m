Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC02BC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 10:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujEpT-0003p5-UK; Tue, 05 Aug 2025 06:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujEpL-0003hK-DP
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:23:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujEpJ-0006mw-JF
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:23:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b7848df30cso3863307f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754389403; x=1754994203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRIDLbxwSwbmKzZxn/ViOCL+Tfvpv35DqPfiPjR8t/8=;
 b=fLEJCtw4Xb0/vrSj4SNMH5Xxd1ts1q4icSFHexB6UdnrN5/y6mun7YAYeZARmCmUKq
 NkkqMqaRlHxDS4FhGSsKG4KalBm/8Qh1h+VrUPTChOAIOMjNyWPkt6vzHUY7pABJjBVg
 4IcRe0ZAj1g0Os0RMC68s0sM4uZCq/24YwR64hYYEmaUHKTLtjeWKkVuRL7slnqXo7cu
 tOT0UBk7JjglxLEinFKIuj5PUimnfrzrjdvk1kAZCoFHbhV1U409zIHTa+Z/j/K4CRBR
 CqT6+RYklH6wgSgk/+HlyXRU35RpYFhhYbNK+Gf6RA9WRkN0DbG7X7DbCHsxLfkPcXMc
 JQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754389403; x=1754994203;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SRIDLbxwSwbmKzZxn/ViOCL+Tfvpv35DqPfiPjR8t/8=;
 b=AsLXCU4krf2fAsaJF2vgJQ62/b7hbOscs6B4X8UxChC3Rd2csOXlshYWQy+L5f/YaZ
 it2Qwp7PnRpoYhSIu0DvwAIX/xete4xqDloNJWlcvA/6meqxF4Oiqvwz1IcbFVNk9MPE
 A2ooM2gqH9MNka+EHOPNWpyEqoeJyhZuJ2yH4mB5gMeK4oG3UHSOwtuVAA8qJzk5r67n
 3Kwjr0yGeZjaWpBsZrDQnWKTwV4VVy8Dn7QZhvZyR6R9+YfuCbReHxX/oWjJE4QK9ulO
 /deRQOuaXLuiAUqdwKUHNWXYBLw6xPAFxQbAnkae2pZMLVWCWYxMpwB5RQnw0BH29Mop
 6unQ==
X-Gm-Message-State: AOJu0YxHu1wY2lpsiCWUIJpy3brg14F22wJk3DH8rk5xOHzeq0i+5FHQ
 osj6X7nigoVDGMfvtHymVxl71r1dJ+A5EoCb69m/oehfJ/lPiV64eudkLiLnsUBuw7M=
X-Gm-Gg: ASbGncsB32dC4WLxHs4RJS8m/okXB/HEXybgrmpwlWCyyI2yuo7xEMl7MFkvcQq/O9q
 uAuZkQO6l+l/qV97nqosqWuuyPvu5/RlUIlI0w1hQ+1RjW2evA4IZkJpcXSEt1fR1zBMGmOew54
 fmumRS2yZElgHdpkWyL4IRmXexKjG2npxNIedjNQrRXj02DOLTRlg4OJXNCWVheyU+A0G7G22jb
 N+PP362/wp/aWV6CzHnG/jizCNLCa+y0ITTkillfd9t9nnTtFy7gymV9vcJR2khuYQXtPvXw3BQ
 spIDFha8ljKjd1Bg93/zHKor2zk9zTd6a1L0B2bqeAcKV7Zunnu+prXvWwAzn2S11liCC7vzY9U
 ylHbJHbyqNCOBZWxIwQfgLPg=
X-Google-Smtp-Source: AGHT+IGbQ0LiaXeohOzPBqsA8pI5Qnd42sp3z38xsA2r5UjjNTZeCnVik19UQcD1SynyLKqrhr56KA==
X-Received: by 2002:a05:6000:2012:b0:3b8:d8d1:1e72 with SMTP id
 ffacd0b85a97d-3b8ebeb9677mr2318042f8f.19.1754389402740; 
 Tue, 05 Aug 2025 03:23:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469093sm18807891f8f.51.2025.08.05.03.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 03:23:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F29EF5F7E9;
 Tue, 05 Aug 2025 11:23:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 rowan Hart <rowanbhart@gmail.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 4/7] contrib/plugins/uftrace: add
 timestamp-based-on-real-time option
In-Reply-To: <20250724204527.3175839-5-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 24 Jul 2025 13:45:23 -0700")
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
 <20250724204527.3175839-5-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 05 Aug 2025 11:23:20 +0100
Message-ID: <87v7n23w4n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> usage: timestamp-based-on-real-time=3D[on|off]
>
> Instead of using number of instructions executed (which is per vcpu), we
> use the wall time for timestamps. This is useful when tracing user mode
> programs as well.

Arguably it is the more useful default when examining flame graphs. The
instruction count is entirely artificial and wouldn't map onto real
execution time anyway.

Maybe use-icount-for-ts and default to off?

>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  contrib/plugins/uftrace.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> index bd4219db693..9211f273700 100644
> --- a/contrib/plugins/uftrace.c
> +++ b/contrib/plugins/uftrace.c
> @@ -94,8 +94,28 @@ enum uftrace_record_type {
>  static struct qemu_plugin_scoreboard *score;
>  static uint64_t trace_sample;
>  static bool trace_privilege_level;
> +static bool timestamp_based_on_real_time;
>  static CpuOps arch_ops;
>=20=20
> +static uint64_t gettime_ns(void)
> +{
> +#ifdef _WIN32
> +    /*
> +     * On Windows, timespec_get is available only with UCRT, but not with
> +     * MinGW64 environment. Simplify by using only gettimeofday on this
> +     * platform.
> +     */
> +    struct timeval tv;
> +    gettimeofday(&tv, NULL);
> +    uint64_t now_ns =3D tv.tv_sec * 1000 * 1000 * 1000 + tv.tv_usec * 10=
00;
> +#else
> +    struct timespec ts;
> +    timespec_get(&ts, TIME_UTC);
> +    uint64_t now_ns =3D ts.tv_sec * 1000 * 1000 * 1000 + ts.tv_nsec;

Why use timspec_get here, QEMU's own timer uses:

  /* get host real time in nanosecond */
  static inline int64_t get_clock_realtime(void)
  {
      struct timeval tv;

      gettimeofday(&tv, NULL);
      return tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);
  }


> +#endif
> +    return now_ns;
> +}
> +
>  static void uftrace_write_map(bool system_emulation)
>  {
>      const char *path =3D "./uftrace.data/sid-0.map";
> @@ -454,6 +474,9 @@ static void cpu_set_new_sample(Cpu *cpu, uint64_t tim=
estamp)
>=20=20
>  static uint64_t cpu_get_timestamp(const Cpu *cpu)
>  {
> +    if (timestamp_based_on_real_time) {
> +        return gettime_ns();
> +    }
>      return cpu->insn_count;
>  }
>=20=20
> @@ -866,6 +889,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plug=
in_id_t id,
>                  fprintf(stderr, "boolean argument parsing failed: %s\n",=
 opt);
>                  return -1;
>              }
> +        } else if (g_strcmp0(tokens[0], "timestamp-based-on-real-time") =
=3D=3D 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
> +                                        &timestamp_based_on_real_time)) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n",=
 opt);
> +                return -1;
> +            }
>          } else {
>              fprintf(stderr, "option parsing failed: %s\n", opt);
>              return -1;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


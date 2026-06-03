Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9612DCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUa0m-0006MN-LV; Tue, 02 Jun 2026 21:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUa0m-0006ME-2I
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:03:12 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUa0k-0000Ce-B9
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:03:11 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bed4f2f0898so401062166b.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 18:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780448589; cv=none;
 d=google.com; s=arc-20240605;
 b=U5CJuXJ7JRTl+uIUBpVCNlpqmr7r3Fe3BQiVganx3ZJzMpcght54pyc8C7iyTNv+Ch
 HVVTWdwDD3n00Bo8rBhsu27Wz8MDQjfQfAb3rWe04DXEDvO1Gr4pv0zYSlfOfTV9xCyn
 lveNDNmMu9HsLaIliP+1gMIspHFsWYUBNbm0LCRbESeupUbsR7zcjuS5gMvy630a/2Ig
 EyiHcILm4G5B9X3Bt2UmUPRMlcD2wTlg/gdQb5w6VJb3Z5YH+fW8gegxX0IubCYCePul
 un4644k8dWs+MpwW9Z+gHUxGES75v5KmHyFadCxRFmUarKGxCTb4mPS50yS7pU/Z/kEc
 sSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DeNsMlFJgHWj8+szJl9uInk9VdUkbLTv+vjTd07Ap50=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=gx4mEmCWKIgXzwOZyFsXt+JpnDpmE4dpkygtlpGzs68GSMhAGkLkEL+cqaIcCDZQM/
 Pw+zhBc0q8Hc7i4taVhPKNSwUN+i1Emzir3qeZwTP9Hss5KC1h0TzUukeylT/r5dwxni
 7jzANBijk3Y/djFirSx0b6IvUJSbuE20jAMICO2YpfOPXU+uE04HAZM4WTELclN/wuJJ
 wo674dNrvuxGO3qimnuBS0SVPyQgWVHFU4qFPfsPc76+OxlDCGrxKOBUwJ5RieejQ4ln
 S3o8XIQZu4IjXEc11aLgYxMLLvjIIiVHGP6Im6Zt0xT8TNk+V/aeY9pa3WnyouRYbEdL
 hvEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780448589; x=1781053389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeNsMlFJgHWj8+szJl9uInk9VdUkbLTv+vjTd07Ap50=;
 b=Ykxkydff3/ipXGMWd7iFPi9RTcanzEhInpOhrADbjKtOX/fwJuttF0EB/9/ORSWFrU
 sxcLw6+/uu8ZLiOgB28//yjHDgm+Skfp0rwqcf6rfkgmlZyO3hEztXg/Wiihj/CS6lJ+
 7pF1pWEMA/Ct4D6ZVcvuEoDtltQS9vy0UJkV3Uj7AOT6LyRuwKta1QTBL5WULZiuE3iS
 df0Adfr70ksVoVMCFpJmMF5cBzm0zymzaeyZ+mhZ8DQGGoL3Lb6F50jgVQ4PiEyk1nWS
 zIP6XzHql8/F88SYq4IozOHuGrwS/YmRklcbYY86apkkQvKvGKgevKhTs6b/jvdDqRVm
 01hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780448589; x=1781053389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DeNsMlFJgHWj8+szJl9uInk9VdUkbLTv+vjTd07Ap50=;
 b=m+Nx/PBbBdWpmAbrKhZp6ErljkMJhvYpRNkHNCmwHOtbVT13GilZGNCaLRpmkzxxzQ
 +XHzgt4Iz5v9b/wwsy/Pyf6LK/bKfuwL8MevoPY+7EnYCoiuXpz03bpl/oDVk3QNYUfq
 5Bw/MPxpuSmxTJcloKU0qdJJiTgcN8dB5rLZ+A7ldEi05OHLWijInBfH1wpalGQdhlvh
 Q0ruQyAjMVs2aLtnIn8rYe2ZI456z1jSJp4MfPB2kvIUV0nVtZvtnEnUGvSxdmy9fcF0
 7F4OOB4Pmrm8SMezdNbGGJkThCHQ6LAavDag7UMPQFX0p2mGr2bIieoGyBbhbW0UjXsv
 a+8w==
X-Gm-Message-State: AOJu0YzPrF4Loomz8d5BdK6Vh2QKUQYWhcPtAmbiitVAVUlA++ZcrmZG
 ZxmzQ1vLcdAVW6bgHk+AdFMdjOssA+p63yyQDtZvImXDRa5KkQFAnV8agfwnD9Hl9kMDB+qoAto
 Huzfg8l2fePw7ae7YKHVzN8MHPQLIQ1E=
X-Gm-Gg: Acq92OFdTs6Jx3SQsk8GFAWWynrwndvcj8LFkM38Do9f/UYqM8dvfvaSWzHEjWOeQGl
 6IOKfz3A9UVb1iZJsyLai/y9VO6jn0U1TNT3mJJMQuXmUDeIBTPzrKeWYErfpWlD4vO26Ob65D3
 C8hgoz9Hr6Ino6NwuaDOeU1YjZJlxl67CyK09Uxqb4mHYK2x4dqbM6ftutqYSQ1nLhTNNq1dogg
 FxhQYdbqvy4Fu6WjaBGog+dVLDfTu+fqpE5lZ6Ty1q7k8orOCA2qE+Q4TH5Y03V0+mcvDEinkfs
 LEfsen+3PZEdQ/VFSZnwcdpybsLM6mX+1HvYNjejcN67zT/0a9/10/ldNfw=
X-Received: by 2002:a17:906:5a5c:b0:bee:215e:5486 with SMTP id
 a640c23a62f3a-bf0b3aaceacmr20946966b.36.1780448588705; Tue, 02 Jun 2026
 18:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-22-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-22-3f20c3a029a7@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 11:02:42 +1000
X-Gm-Features: AVHnY4JZr5MZYF0uKqcxJlGqun3klwecM7wXu3IvQwX4JgzE0s9IEKuYahX0LF0
Message-ID: <CAKmqyKOhH5rd9N9yO_kjGo-Fq5pn4sZ4DEBCz6gQu48EUQT4qQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/24] target/riscv: use hash table as set for
 user_options
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, May 16, 2026 at 6:02=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The values stored in user_options are never retrieved, only key
> presence is checked. Use g_hash_table_add() instead of
> g_hash_table_insert() and drop the unused value parameter.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index bbdc9d8f5de..6adba597969 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -60,11 +60,9 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu)
>      return riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>  }
>
> -static void cpu_option_add_user_setting(RISCVCPU *cpu, const char *optna=
me,
> -                                        uint32_t value)
> +static void cpu_option_add_user_setting(RISCVCPU *cpu, const char *optna=
me)
>  {
> -    g_hash_table_insert(cpu->user_options, (gpointer)optname,
> -                        GUINT_TO_POINTER(value));
> +    g_hash_table_add(cpu->user_options, (gpointer)optname);
>  }
>
>  bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname)
> @@ -1452,7 +1450,7 @@ static void prop_pmu_num_set(Object *obj, Visitor *=
v, const char *name,
>
>      warn_report("\"pmu-num\" property is deprecated; use \"pmu-mask\"");
>      cpu->cfg.pmu_mask =3D pmu_mask;
> -    cpu_option_add_user_setting(cpu, "pmu-mask", pmu_mask);
> +    cpu_option_add_user_setting(cpu, "pmu-mask");
>  }
>
>  static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
> @@ -1494,7 +1492,7 @@ static void prop_pmu_mask_set(Object *obj, Visitor =
*v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.pmu_mask =3D value;
>  }
>
> @@ -1526,7 +1524,7 @@ static void prop_mmu_set(Object *obj, Visitor *v, c=
onst char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.mmu =3D value;
>  }
>
> @@ -1558,7 +1556,7 @@ static void prop_pmp_set(Object *obj, Visitor *v, c=
onst char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.pmp =3D value;
>  }
>
> @@ -1598,7 +1596,7 @@ static void prop_num_pmp_regions_set(Object *obj, V=
isitor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.pmp_regions =3D value;
>  }
>
> @@ -1636,7 +1634,7 @@ static void prop_pmp_granularity_set(Object *obj, V=
isitor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.pmp_granularity =3D value;
>  }
>
> @@ -1709,7 +1707,7 @@ static void prop_priv_spec_set(Object *obj, Visitor=
 *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, priv_version);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->env.priv_ver =3D priv_version;
>  }
>
> @@ -1743,7 +1741,7 @@ static void prop_vext_spec_set(Object *obj, Visitor=
 *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, VEXT_VERSION_1_00_0);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>  }
>
> @@ -1786,7 +1784,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.vlenb =3D value >> 3;
>  }
>
> @@ -1827,7 +1825,7 @@ static void prop_elen_set(Object *obj, Visitor *v, =
const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.elen =3D value;
>  }
>
> @@ -1863,7 +1861,7 @@ static void prop_cbom_blksize_set(Object *obj, Visi=
tor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.cbom_blocksize =3D value;
>  }
>
> @@ -1899,7 +1897,7 @@ static void prop_cbop_blksize_set(Object *obj, Visi=
tor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.cbop_blocksize =3D value;
>  }
>
> @@ -1935,7 +1933,7 @@ static void prop_cboz_blksize_set(Object *obj, Visi=
tor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(cpu, name, value);
> +    cpu_option_add_user_setting(cpu, name);
>      cpu->cfg.cboz_blocksize =3D value;
>  }
>
>
> --
> 2.54.0
>
>


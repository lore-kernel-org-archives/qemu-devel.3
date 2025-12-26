Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02B9E8FDA3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 15:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZADC-0005ne-Uz; Fri, 26 Dec 2025 10:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vZACv-0005mf-Ko
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 10:58:25 -0500
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vZACt-0003Bd-Bf
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 10:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1766764700; x=1767369500; i=laurent@vivier.eu;
 bh=pWbILerJ96i4HuHeVq6Sn/vzXo1LaBDBCrwUA2KwidI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LY9b9i83Fp/rSDuwAT6sj5A94Ro0qZEhAcnt2seJvjJHY8C7nN67S48LV0x60Qry
 CD+IsW9/HpH17TEEmlrnZKkqG8seFfpQZRVYpMWyiQZ4FUUFqn70jLIb+4qBA9PTo
 gQMeE4vCNXuGktZ+/GaGy1ufez3Qcyf1v9Fw1pKGhPnjR6s+mEantuHrFHsejgrid
 81h/PfqKAEleloDGltQeQLsOowhj2Xfwp3ye/86eMDUkBSFe+u/gCWqQ5zQOdVdR9
 HLWJ/KL9+Tsqsag58TCnMAnvBqeZ9uW/usJpqpTIXFzfc6EgR1s5KM/Lb/ys4mN3w
 14sOPjrcVt9TmSvgEA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MbSXf-1w6JAA3ijB-00bOqH; Fri, 26 Dec 2025 16:58:19 +0100
Message-ID: <0ead17ba-8ea0-4b26-be4c-e65779c27041@vivier.eu>
Date: Fri, 26 Dec 2025 16:58:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] linux-user/strace: fix printing of file offsets
To: =?UTF-8?Q?Jean-Christian_C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>, qemu-devel@nongnu.org
References: <20251225183644.1919184-1-jean.christian.cirstea@gmail.com>
Content-Language: fr
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20251225183644.1919184-1-jean.christian.cirstea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5QC3iOCZ4QEmdIt6UJGsImYbLQ/VLPg5IsYWo+cG2yv4jTEvKAm
 9LD5rgrLM4bPYDcEaUQJePvy24/lbD9D6gJztBp8mpf4zl4LmUgUjDygfIChj/SD2+dKhxC
 6m6z79fb7tC+HHoN9ZH4lPfDKp9qTM5TjDNtxc+RtVy9LhHXDgyVtrZZn4l4g82TBLNvDrP
 zciew56M4nirZ8Dm1HNtQ==
UI-OutboundReport: notjunk:1;M01:P0:teojIrMJk68=;aNrdLC4TtSZCFbx9+Id8iz/uiAb
 ZlnFm1UKN/CF07HjHrwx/bMUoOlFX8oRJcDt2Lo8Xt/zzzPa+VpcgWlOof808peODTsugD37Y
 onzO7w2Wg+/mfdMPScmcwDlNU9qMVkymEzNA/0xsXbKwlVw1sookCgPFyCrLRF7Z3WP8bbOEX
 JMOA/P3gfrglbbvFlt+OaBcu3xQGFXWWdU3c0LIWlftPOfRrNJ7MpsrsFCDAUrRcFybwhlOAt
 yIqt8VdRcLUQwXhB4akFMbAFMVj04t1KECwl+YGRHE945E+SmFugVCFj05cbl5uDjISX/HpnQ
 tmUVP2xX1Okoqr9y4dnPiQEBVPXzvBvPg4Frrx1QPo2cusawMWDNPA5xBKaQ1o9BQCbNwAviQ
 NUui11GX/tYfd0ujX8HLpUV5YpItIU7XAscym1P8VLOV51wSWDsxAl/p8slXNm4CTjOqxyF0J
 pSN1tTfcPcTJUJ3SQbSYBCoU6H3YSCR/OipjBkYQsKyLminTgwOawUITU+b6J3E4pKum67Rtk
 ryrlUCQ1CTmPn7T4TcnvTbytAvvdGVAAQwE1zVgwbQ4RiwrGkJJQaWK8ImcnsRzAmgaccZlym
 ETuW7LFLONRJfIbPNs7/en+xDGwGWx5Ld4EWcmqYV2hW2ODDQx9NP7/Ncq6hGdfIOP5tCZSJd
 mNB4xAYQ2Vpfx/6ATj+TJpzy0uVxjNjHZJNxVPoIqvolKa0m1zQ2FbN94TSfOtgBEQcCzIqh/
 CMhrMB4qK/ynxVQoYe4b0RguZyB/rocPjVwCC110ORvNb1/d+fOz/mGvE5UMj1/c9Tg/kuOqV
 lJZ4qIGBuO2FUONM7LKoaqLgw2sZ9cwPpaUiVPsreDcJI0dTtUXdcnz94umUcC+OU6pA7JX2u
 4j7jZXbwyVRYo40NILfryIAh82Wx9QSiKMmT8IBR88XTLaDsA6nG0St/0HwsZU7rOuwB4VsYy
 QLse3aVf9U2TU+xpm5YrHP1a1aaTsb9K8RuhL+N7SPx2ZOzFl+6MiwYcMcXTWTEepgaSrGRY8
 Bu0DIKP4PP+TMiPneVzOf6Uu18K9lGe8CwPd95UWJMyxAzgEyo57ZYmHWrjjT8lKVQjAltncS
 RATk3Cj9qfeAP+1VA2f4gPsSu2yoUo2OI7xizI76L1NSEDVetTeTOGbfhmAqVUdV2E5/d7X/b
 Vhff1ofM3pHN6KG+Wr6Q7Q1ciNRX6B04HSXxzM1gjjlnrnrI3Ka3NipMOtNvg57yevfquu74K
 BU0RLlj8aNIs8NTS8txzys/Zi/O74kkbphd5oflQkI2MsYahSjFHpIM6Aj76n32U0Ks/6LdaI
 m69pPV/esKwj2yqEIn0M2EdlVBDVleNeFOAq/CYSwvJm0rdXykLsH0IqMrXNrsleeCHOyyjo/
 YUfOfE4eFUFnl8YySbwySMq0k2gbU2wPs1fJgvATupPuABQjbVOuajgjjHV9+8raTkR4J3EBY
 92vQc6Y67hC5diWdv/occ4Zp6lM9O5R37Dwm19mSrWvJqyrnhRlkC+TFCv/aEmmXKjdD3qZWz
 BdMD5vrkhOdFq50ubMgWW9zaqYfLuD65SLDRp8ifTix1Y5bfnH2U2SeP3I0ci526M7v+W/Q+7
 EHuXNqRRlMFq8+CffxVEB51BdbE7QMX7Q3IAecgB/pH2yKiKpXJMKPfHKQNSkwbqoVhZe9/Ux
 SlLfJkF4RL+4TEgkhqJYV07evBb6DxXEiwusgGvVflnjAz0mxDGz6eHt8X1+WZ6VPLPWr01Kw
 fTlHa8BCCvpFokmlGnva1P6U936ckNkTBk85PX9Dp0ixpidAYA/RHnVxLjOAFgvS5UZY6Y44t
 Qkdc
Received-SPF: pass client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Le 25/12/2025 =C3=A0 19:36, Jean-Christian C=C3=8ERSTEA a =C3=A9crit=C2=A0=
:
> Previously, 64-bit file offsets (loff_t) were printed using `print_raw_p=
aram()`
> function, which led to silent truncation of the upper part. This commit =
fixes
> this issue by adding two helper functions:
>=20
> 1. print_file_offset32(): prints 32-bit file offsets (off_t)
> 2. print_file_offset64(): prints 64-bit file offsets (loff_t)
>=20
> *NOTE*: checkpatch.pl gives the following errors:
>=20
> ```
> ERROR: externs should be avoided in .c files
> #30: FILE: linux-user/strace.c:88:
> +UNUSED void print_file_offset32(abi_long offset, int);

I think there is an actual error here: the static is missing.

>=20
> ERROR: storage class should be at the beginning of the declaration
> #31: FILE: linux-user/strace.c:89:
> +UNUSED static void print_file_offset64(abi_long low, abi_long high, int=
);
> ```
>=20
> The errors are may be removed if `UNUSED` and `static` are switched. Sho=
uld this
> patch fix this and swap all `UNUSED`s and `static`s?

The missing `static` on print_file_offset32 is a real error . The other ch=
eckpatch warning about=20
`UNUSED static` matches existing style here, so I=E2=80=99d leave that alo=
ne.

>=20
> Signed-off-by: Jean-Christian C=C3=8ERSTEA <jean.christian.cirstea@gmail=
.com>
> ---
>   linux-user/strace.c | 38 ++++++++++++++++++++++++++++----------
>   1 file changed, 28 insertions(+), 10 deletions(-)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 758c5d32b6..f790cab4da 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -85,6 +85,8 @@ UNUSED static void print_enums(const struct enums *, a=
bi_long, int);
>   UNUSED static void print_at_dirfd(abi_long, int);
>   UNUSED static void print_file_mode(abi_long, int);
>   UNUSED static void print_open_flags(abi_long, int);
> +UNUSED void print_file_offset32(abi_long offset, int);

Missing static

> +UNUSED static void print_file_offset64(abi_long low, abi_long high, int=
);
>   UNUSED static void print_syscall_prologue(const struct syscallname *);
>   UNUSED static void print_syscall_epilogue(const struct syscallname *);
>   UNUSED static void print_string(abi_long, int);
> @@ -1664,6 +1666,20 @@ print_open_flags(abi_long flags, int last)
>       print_flags(open_flags, flags, last);
>   }
>  =20
> +/* Prints 32-bit file offset (off_t) */
> +static void
> +print_file_offset32(abi_long offset, int last)
> +{
> +    print_raw_param(TARGET_ABI_FMT_ld, offset, 0);

You should pass "last" instead of 0.

> +}
> +
> +/* Prints 64-bit file offset (loff_t) */
> +static void
> +print_file_offset64(abi_long low, abi_long high, int last)

You shouldn't call them "low", "high", because it depends on the endiannes=
s of the architecture.
Use word0, word1 as it is in target_offset64() definition.

> +{
> +    print_raw_param64("%" PRIu64, target_offset64(low, high), last);

You should use PRId64 as loff_t is supposed to be signed (PRIu64 is an exi=
sting bug)

> +}
> +
>   static void
>   print_syscall_prologue(const struct syscallname *sc)
>   {
> @@ -2187,11 +2203,13 @@ print_fallocate(CPUArchState *cpu_env, const str=
uct syscallname *name,
>       print_raw_param("%d", arg0, 0);
>       print_flags(falloc_flags, arg1, 0);
>   #if TARGET_ABI_BITS =3D=3D 32
> -    print_raw_param("%" PRIu64, target_offset64(arg2, arg3), 0);
> -    print_raw_param("%" PRIu64, target_offset64(arg4, arg5), 1);
> +    /* On 32-bit targets, two registers are used for `loff_t` */
> +    print_file_offset64(arg2, arg3, 0);
> +    print_file_offset64(arg4, arg5, 1);
>   #else
> -    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
> -    print_raw_param(TARGET_ABI_FMT_ld, arg3, 1);
> +    /* On 64-bit targets, one register is used for `loff_t` */
> +    print_file_offset64(arg2, 0, 0);
> +    print_file_offset64(arg3, 0, 1);
>   #endif
>       print_syscall_epilogue(name);
>   }
> @@ -2619,7 +2637,7 @@ print_lseek(CPUArchState *cpu_env, const struct sy=
scallname *name,
>   {
>       print_syscall_prologue(name);
>       print_raw_param("%d", arg0, 0);
> -    print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
> +    print_file_offset32(arg1, 0);
>       switch (arg2) {
>       case SEEK_SET:
>           qemu_log("SEEK_SET"); break;


I think print__llseek() should be updated/fixed too.

> @@ -2650,7 +2668,7 @@ print_truncate(CPUArchState *cpu_env, const struct=
 syscallname *name,
>   {
>       print_syscall_prologue(name);
>       print_string(arg0, 0);
> -    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
> +    print_file_offset32(arg1, 1);
>       print_syscall_epilogue(name);
>   }
>   #endif
> @@ -2667,7 +2685,7 @@ print_truncate64(CPUArchState *cpu_env, const stru=
ct syscallname *name,
>           arg1 =3D arg2;
>           arg2 =3D arg3;
>       }
> -    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
> +    print_file_offset64(arg1, arg2, 1);
>       print_syscall_epilogue(name);
>   }
>   #endif
> @@ -2684,7 +2702,7 @@ print_ftruncate64(CPUArchState *cpu_env, const str=
uct syscallname *name,
>           arg1 =3D arg2;
>           arg2 =3D arg3;
>       }
> -    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
> +    print_file_offset64(arg1, arg2, 1);
>       print_syscall_epilogue(name);
>   }
>   #endif
> @@ -3239,7 +3257,7 @@ print_stat(CPUArchState *cpu_env, const struct sys=
callname *name,
>       print_syscall_epilogue(name);
>   }
>   #define print_lstat     print_stat
> -#define print_stat64	print_stat
> +#define print_stat64    print_stat
>   #define print_lstat64   print_stat
>   #endif
>  =20
> @@ -4228,7 +4246,7 @@ print_pread64(CPUArchState *cpu_env, const struct =
syscallname *name,
>       print_raw_param("%d", arg0, 0);
>       print_pointer(arg1, 0);
>       print_raw_param("%d", arg2, 0);
> -    print_raw_param("%" PRIu64, target_offset64(arg3, arg4), 1);
> +    print_file_offset64(arg3, arg4, 1);
>       print_syscall_epilogue(name);
>   }
>   #endif

Thanks,
Laurent






Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A35CE98FA6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 04:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgeb-0008DC-Da; Thu, 09 Apr 2026 00:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAgeY-0008CL-Ub
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:06:02 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAgeX-0006OR-D5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 00:06:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-66f727d6849so534920a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 21:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775707560; cv=none;
 d=google.com; s=arc-20240605;
 b=kWaRI31KZIPU19Upy/widdHXohDugYxgY6bIeBRFbS+OwPcitzqk7YLEWFkbcq4bct
 wXBDODXxzUxvL3p4zQ3NkNKAqAJofSplSkMu93Pvfqt30FLi7ISeoq5kaQm/S2tbadxk
 yqYuXy/dTXDCyof3angGLE1iqRB94K6DQRT2MS5gPz6SoaVKuYOsbvscEh0Dy3/k4N0s
 L7bmYgTu5EI4kbJTVB19X24L2WTQgRBfXxXPw/wEesH9RXzItLQubjrEQWDQuX+oGiLt
 dWLeO3dBkqr/akvAfPFN9cY6XVijOJH0PtytViZstJSIpb+VpthkImuzh7ZMCtNUV1JP
 EHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iN4hvQvllatPh2C2Yd/64QWZumbJmuVK3Ja7PZyxzm4=;
 fh=02yfZO3MCi97EyXeoLg1BYIgpUdGEMk3Yh61+offrCA=;
 b=K1w/oOzXyU7cuX10VOGe891rG9auhnjeTKsVcUGYyoUHZLP/YIyoh3fj6VVfZp5rPF
 9IC/SDRpCMV16NwTjLSzExSowpWTk9AVifw2Z0xxp9dOfnX2hBM/I80a3C2Mgv1cE95R
 Iy6TPCTMywguRdOv/FYjx8BqmYLj7SHJ/XhE8AK52QcAkFtFwdjwPmA6yPGiFE7qWvEW
 213+DY2sMADdyZLL7QanHmoKWJyzq0ADOQF8IDmftAMttW6De6Y12SxuJqmid5Q+FdLs
 9zimB8bNPRLdg+C9z1+pb58V13P2/FspbyfO2Q8oWKbldLOq9D8h2JAFl32WeZox5Hmc
 gR7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775707560; x=1776312360; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iN4hvQvllatPh2C2Yd/64QWZumbJmuVK3Ja7PZyxzm4=;
 b=B5yS3Fv9JpdpgnKu3xCdF7zQhUnvETqyD/AHeRHGQa76mS4cSnOBSMd3YHzSBHXy0W
 GmYvNhZytqQX27gtXkjlfjt9L7od+1e9jeBaL/oXoBrGYBzcjaZy879gkfMvBxMYhn5W
 /Se4MvZZss6Iy0KfnAcpoMa3GPlOZHc9fE2SWa7l6kciDjKq0GH1dU1WNUZBbYV7KAOU
 7bs46+RMH4m6HMEWv4TYIH4V6C+KOSeqcpNYRvS+ZmFb974zAonoRT08qdBifqBvKrRI
 FBDT7vQ51YmW1qZvBrGWWgitmUVFgURROMfDXfJVlh+H4d0Z0gj+kcb8gohbJlGvRMtE
 /RUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775707560; x=1776312360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iN4hvQvllatPh2C2Yd/64QWZumbJmuVK3Ja7PZyxzm4=;
 b=ZhetaEJIPwooenOlJ13HNAefdJjJ5kRPIAF4QJZZocz9VMca0ZWDiQhSt+/qFNB3Pv
 9XDd7W7XhQEwCMhqfo8GAW4D523LeTtnhzAcZZAr8R5eFzvaBkOZrFU/BjbKOucZAzhK
 S9iBJDVfMCfEGs5khBssq01+e3vi2o8O1nMsDatEo4hpCY5odElZ0OlBkogr/qTyiwTD
 LV+Le6UheOjsOFhjA3O6q5e5hjSvYkfzymru9K6T0hesuO73OkkNs2ICV7T+xFEKh8Ay
 qpiWCcVDipZ0jZVJ6cxcmlg+TyVUI4JT3kCBfGNP5GUbYGl367op0qMTmoRhYWLfUv68
 SGJQ==
X-Gm-Message-State: AOJu0YwyspziitMDB6K1oz773oenHzLB+TEpn7duASgBHz1tC6NzsVyD
 50uMvWPTsu6sSjCVWtp6SfamAZ8cE/nfQNZmEEa0kdyO0OW87VqI9wBuWAL9BFzr3dCE9DeMC9f
 KK6wAkvjsTGc+1Z2TncSy6vL3YgHdoQg=
X-Gm-Gg: AeBDieuYJi+m0AKbYcn8hjQinqSBKK890s5Agytc9vaCbUjLu3BYGBZ8m09DNJwv0gC
 dnTyWLnKtfRFsl+nAkJDBmSNJ0dStcYuC5ssfxQ1xL+5oNgXdd0XlF28jfEvRZpyeoweUzLAxyi
 BWO7v9Z7AfnzLDxrDjFDwiFRIPrqtEhqyvoUI5o5ySCzzKtI1qYQcz4UQYQ9om4sA8sG9xCoVwU
 r9CjbAaHIcO68Zx7t+sf5n+RapOCvSw/CF+hc8ABjYwDycQYxE7/qfH4hhxx61ujfHWp+4ZENZh
 Re6qvSLGgIhxygwUkjRNUeZbZbYxBMZGY+N9utY8WtS6aPXb
X-Received: by 2002:a17:907:3d11:b0:b9a:cb5e:5354 with SMTP id
 a640c23a62f3a-b9d4749c733mr83676866b.16.1775707559484; Wed, 08 Apr 2026
 21:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-5-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260406154935.144674-5-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 14:05:33 +1000
X-Gm-Features: AQROBzB-vP2lLGow6j5VIf5Zc-YReNxtTep_LQrY0l1EVghiHRVv-L6HEadpac4
Message-ID: <CAKmqyKOXJZuZ1Xh-x_DYkgoQSrv4+BLvzYbCHvdgE-geOz2W=A@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Apr 7, 2026 at 1:49=E2=80=AFAM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Implement runtime big-endian data support by reading the MSTATUS
> UBE/SBE/MBE bits to determine data endianness per privilege level.
>
> The key changes are:
>
> - Add riscv_cpu_data_is_big_endian() helper in cpu.h that checks
>   the appropriate MSTATUS endianness bit based on current privilege
>   level (MBE for M-mode, SBE for S-mode, UBE for U-mode).
>
> - Update mo_endian() in translate.c to return MO_BE or MO_LE based
>   on a new 'big_endian' field in DisasContext, rather than the
>   previous hardcoded MO_TE.
>
> - Update mo_endian_env() in op_helper.c to call the new helper,
>   giving hypervisor load/store helpers correct runtime endianness.
>
> - Pack the endianness flag into cs_base bit 32 (alongside misa_ext
>   in bits 0-25) in riscv_get_tb_cpu_state(), ensuring translation
>   blocks are correctly separated by data endianness.
>
> Note: instruction fetches continue to use MO_LE unconditionally
> (from the previous patch), as RISC-V instructions are always
> little-endian per the ISA specification.
>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>  target/riscv/cpu.h         | 28 ++++++++++++++++++++++++++++
>  target/riscv/internals.h   |  9 +--------
>  target/riscv/tcg/tcg-cpu.c |  7 ++++++-
>  target/riscv/translate.c   | 13 +++++--------
>  4 files changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 35d1f6362c..ef870d05b3 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -703,6 +703,12 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
>  FIELD(TB_FLAGS, PM_PMM, 29, 2)
>  FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>
> +/*
> + * cs_base carries misa_ext (bits 0-25) plus additional flags.
> + * Bit 32 is used for data endianness since TB_FLAGS has no free bits.
> + */
> +#define TB_CSBASE_BIG_ENDIAN  (1ULL << 32)

We should update the cs_base comment in TranslationBlock

Alistair


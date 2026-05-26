Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BC5CD5BC9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 02:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRhZB-0008LW-Hh; Mon, 25 May 2026 22:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhZ9-0008JV-Ad
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:30:47 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhZ7-0002qx-Pt
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:30:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so722809166b.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 19:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779762644; cv=none;
 d=google.com; s=arc-20240605;
 b=lcAAiS9OTD6p6ukIxcTluxMj5ioKobfc5L+NB9MzhE3EyzSf53UHnkj52YVzaLM+5N
 giMpy+CmMIcETcQCTIGewXgrr/yr8eXJ+/zuvXvsKLRWf+WC1nrMFCnio+6/vDnPP2Wr
 rg5bdhk5hc1vvLs9uqrF+cqsdR3Tx9eJBqo202Zmz3q4c54dqydy3uk1EMwfNjm47yxV
 ZTaBmDJ5spe//d+CvQ1a8T12jTscIK5E00/yjKcss/hIHwKzW11uopxuuR6l1URchOxr
 S+Uol/pv+4doJnza+OLemoukJJb250IF60r6LRIykeFohQCAv+4GAYzyCk2FwGQnE2fa
 zMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pl7pstuZ/0oZNlLm6FvElabNpMraLRVH6DjqKvlfRTs=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=PUF9aoXzPWn0LzQ2Y1B2vN0/kL9FHO/QxDnLbnGN9nMe3b8yVlwKpAolZxw7M0N1/5
 8mpER0EZobSPgZTAr1JT9thtqBZu0XEHw1QTSkSFsVGjjKxfYzy6WGIhmo0vjcmPsVnU
 0gnROFvzhYtpsdfWVoY7r7gQ1fgGW6kAppTfO6pVVnm3DPgCefYuaEj5GaTWNnlTgu9p
 9sQm1xY/bXPx5ca7n5UPgppIrTIy54pfMOpP/pL/0Wkvdvk9vCjN8ZgnZ9IJdqDvaRPM
 7v3KruJ4RUcx81pSXKsqI3qCT28fNgDDHIWwGIvcZZRGkK/WbhwDW3i+HxNI8kVpAc4g
 U7FA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779762644; x=1780367444; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pl7pstuZ/0oZNlLm6FvElabNpMraLRVH6DjqKvlfRTs=;
 b=oZj2Sb7iGIcE6rXGyEQQCmMq8S/CJxwe6D8duBil+dHq7A+zN4hOG6/KGvgsIOZVrX
 76XvYZ+r60ufdJt7ATLRiFPgbefNi8EUvMWXI1vE5WQ1ccA6OF9Ms5Col42VwZN5wPmM
 B90gp+tvycxA0FWIdhLPpSBjx38AW1w7ApOcHFe0ZjZ4chd0RxpJj2QTqooVn8zcdlqh
 +Xo81+jfWkxjw2UwkPJ0e7chR2RU22teK6aqT8njoRh7Dp4JOuqjIbqaP40c728FWNhB
 bt9x7V01qKYMdD8R+5IUprkWmwJ0dIGh1DqSfs6gVaQ0sLLaU6Zib8s73gzlRAC53zzs
 WN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779762644; x=1780367444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pl7pstuZ/0oZNlLm6FvElabNpMraLRVH6DjqKvlfRTs=;
 b=Zf88zxRv/AlOIgZoaFH5sJYfskbzR0O06WmLuREPv7PCAAxzunrVpuiXOSFF2DXt4/
 yR+j7uKYHEVV35pUn3OAut0XeC1hUhVubnv+8m5L//UPLRWQ/Ulb2Czw91XPpNX1XiFY
 pcvoJYCKkkeRI/NYjc9rmNsh0gAeU8xktBeDU2Uded+UgJutf9hNW4uH2DaDr/VjtHyh
 Frd4wclyrrQVT6zo35nGtofleI8fLRneyHHn6wqZb3ig53nsqvX5WkRrjHuEsw57Fxk+
 mRI+b1GMkhsplxBZ1iHB+d8VU/0ZjyeXNDzBlZ8UzKZYJhMCr179fGzZU/IwH0oHnvkb
 Q3cA==
X-Gm-Message-State: AOJu0YyH8C/M+uYJC+dOJ+VabLoBOxtuOcH2OqI+9S+lF88KHXCmK3H9
 8ZIBUw2DAy4aD/lW3MHwB4MzHRlRJ7SxXeg0HgcXUqb0Np0Hv7GY/rcime6Musm6j6NySECx0uf
 XuR08AxSWEPSUeIqmnZ2KzdcMwIN5LpI=
X-Gm-Gg: Acq92OF685P768hIwXYsCEebLcTJ0s4eGAIho6RHYVsJjXIjylkV2sYCRCrdWsO8ivJ
 wwZbbs4eHWyA38RK+MJDAm5vRgtooEm3qwgJ11pC9iNaEXIyW9IMwLtohd8oRQK/TGTkBTxC1Qx
 5+Am+TrJIIaKUgvD5VNoK3ktW1wOVTE+r5PiSSEaqsi95nrT8TwDLbL5fRkd4O4GoQE15EK8I8l
 kA4qSRyrJZ/L0DDcLJ0amzpg2XyJ8i7VwCsaOYoBgI/O0AirnAyVMR4U41+hQ5YdDwplJMo63wY
 99K85wngJQMycBhDAQcv8DMn7OS/vgcoGh52gg==
X-Received: by 2002:a17:906:eec4:b0:bd4:8b66:334f with SMTP id
 a640c23a62f3a-bdd27bd2a5amr1043026566b.33.1779762643974; Mon, 25 May 2026
 19:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260514194537.2416243-1-daniel.barboza@oss.qualcomm.com>
 <20260514194537.2416243-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260514194537.2416243-3-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 12:30:14 +1000
X-Gm-Features: AVHnY4IJEof41xlZgGRNBFVCKF8Oda9SW8qsUfXL5dhE9Oq8AQiyoLkxmq-oaHA
Message-ID: <CAKmqyKPnA6J+mQtto5+kQvcNnCP1k86hj0TvFUpUuS9oMmiWyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv/csr.c: fix mstatus.UXL reserved value
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Fri, May 15, 2026 at 5:47=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> By the priv spec the value "3" is marked as 'Reserved' for mstatus.UXL.
> Handle a mstatus.UXL =3D 3 write by writing the current 'xl' instead.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3367
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 74f5f868f0..53bbecb617 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2041,7 +2041,17 @@ static RISCVException write_mstatus(CPURISCVState =
*env, int csrno,
>
>      if (xl !=3D MXL_RV32 || env->debugger) {
>          if ((val & MSTATUS64_UXL) !=3D 0) {
> +            uint64_t uxl =3D val & MSTATUS64_UXL >> 32;
>              mask |=3D MSTATUS64_UXL;
> +
> +            /*
> +             * uxl =3D 3 is reserved so write the current xl instead.
> +             * In case xl =3D MXL_RV128 (3) write MXL_RV64.
> +             */
> +            if (uxl =3D=3D 3) {
> +                uxl =3D xl =3D=3D MXL_RV128 ? MXL_RV64 : xl;
> +                val =3D deposit64(val, 32, 2, uxl);
> +            }
>          }
>      }
>
> --
> 2.43.0
>
>


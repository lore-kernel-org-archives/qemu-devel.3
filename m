Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242C0E93807
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 23:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC4d7-0002Cs-4Y; Sun, 12 Apr 2026 19:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wC4d5-0002C8-FI
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 19:54:15 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wC4d3-0003ha-Jf
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 19:54:15 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66b2d49ffb0so4876698a12.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 16:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776038051; cv=none;
 d=google.com; s=arc-20240605;
 b=llGo4ex6pLlmiaIBm8vefJjIy7f65tA3cjGpwHe9nYUH50McdtgBPlRoR5DbEPjYrj
 6Eom4Mi9LJEwhNhAdQ6ce7P5Udy0jYz7l0l2BWcWdS60aKy3Hrw9JqcjWd5aaJRC2Q33
 ZmOWEt+Jr3wR7mviwYO5DC7IstUB51BN1OtEBK4HG1g+4ocmQutcTo91/G3Y4R+AHfAt
 afZhfkwhYfaMni8IaVp3mxY1CagO6YrLhHXZiS9JSINn9gL9NDTe7jofv4w0gzfPEWvM
 9VJ9NHPZPeWkjYrnu0IaLev3AHIGBDQQgPwiptWC4skSixyPhZpjZs5DNNpRKtzHH3bG
 5J8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KTd2H0CTGgEh5OeFbtce3WgwBUn0KoR6CcXrGlSPvTk=;
 fh=zqccCkjyU3Nf3yeS9c5ebWV8rczJMg4v5Ntm0euKmwU=;
 b=W5tXyoibjU/0gBSqr+UbeDzDGatzKzUkXAs3oVjeLhDiVkU7dp2Q5wRFY5W9p4LcHw
 aoonv342posM5EclLtXezOmsXiwh3xDkgaM0GKiVRowbLU+YLCxY29VSjeTp8kQcwFdf
 Rh6uYORqWR+FMZ+hJVudERf6l5ikJN+gS+Paw3DVjQDVFpPNb/VkLp4eNvTZnurUYQkE
 clT7zF0IeB3EAan+NKA07WSd1kRnr8cmxH+5enR0aBnaq9Bi5MFCBE7mCCCliGYBRP/d
 ow+LnAjimX0/V09NAIQ1bKkeyYGJqEUjoJiUucd8Lw+5LDhjC6KDRQQ21fNTT2GjGpkz
 /uwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776038051; x=1776642851; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTd2H0CTGgEh5OeFbtce3WgwBUn0KoR6CcXrGlSPvTk=;
 b=IsgjD+qb3JlPyuw1/GSa5wPAwpiV4zcIdGdRFC7pn/lNP5Bf4KGgB++6vB4bbxWlo/
 ORL8sxUKTf3UF8yE0b6OBDMcJ6tu2SGtX/fVOuplemKRuo8vjuL+3rU3vMg2VvANPL4c
 L6gnMbsnKu2W0j5DzkiauakKo/w58wQuc8snTrZ88iOiltEmHlvvSsS50LxDevVbBDmJ
 n0rxSx5jRUdN5FenW4dG50dLDAb4G1wPEOntw3DiqvN0brFlKfxYhVdW8x59jHd8gryD
 gtFYS0N4Ok7u0sNpf39nSQCBwJxG4/Pwr83N0+AdfVcyDh6L707rOKv5SVcI9nUZ1Kel
 a6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776038051; x=1776642851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KTd2H0CTGgEh5OeFbtce3WgwBUn0KoR6CcXrGlSPvTk=;
 b=kBhaPnlkOnX3VOsM3EdmwyDiZlPjvSqOIkeGBd3ap828uhaVVya3TnjKDrvdgMIEV8
 V8fuobr3IBsIG3GkzFGoACNOzlUuK033mdrSmX54xCZm9HLk2lWRBGpHr7w2RLMXxqeH
 Bj9bHErcxeQqHNUYs0e/n4DQqWghfZjot2M/6KOzwb71eraOSl91K2WF0MNYY4x+lyAF
 QRDlDLpM7EjGS9NQAR5ITFltWeJ21BF9dDPrhvmq9df5o0/sZgMnau3bEHcKaVxy3JqX
 CGHGYHYpYrOQ6sBz2YnwyZQtJRsAMUSrY6k0O1nr4lled+gKus/1bpPKV3ju/Y0yju3W
 f3GA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8C6Ghy0V1Ti5crCtUtZkQF1xg93ALNTOyaO/GWRsRwrWCU55TjGB96VKKB7tSOlyKXZxkQX9XcFXR1@nongnu.org
X-Gm-Message-State: AOJu0YxH5L3OR+xNI10CA++KlvoTHNLFZSOMwDNbpn5LiAYu48g4hB6q
 RURqZThbxwjVCLe7aFVbhPeJMRsS8wTjBOvBgVgDMT3Z26g0hLJXjDOjkHyBeB5KBl6PTZX1mLl
 TLarwd97Vikxtxybwp21EUKocQe7P+uI=
X-Gm-Gg: AeBDiesfyBeQSHKUOHeLMnwUI2nP27KQRfmsckrUKoYfrQ9xifHFWE8KEGQkYf4qFw1
 V+UbWRUQOhbabhTtxdQ6rAdyHMvi59L9CKLG5Ue1+t79oVIUQv5iZTvRZ45jaA1ITnUCetb+5Ea
 zIP22wxG1vOv0iwCmBW8UBzj05FxTlOv3+AEs85iX+r+xC9z69DZZ1Uhn5dlWj2gbFwh8jxivbp
 muN+4ko6972Zrc689cqLLNGGzuoC4UWAv/VkjaJ4xENbKKvMGQnc4ADKvAGtvm+VjYPj8BdNPsH
 5XaCcbyn
X-Received: by 2002:a17:907:c48e:b0:b9c:5672:852 with SMTP id
 a640c23a62f3a-b9d727fe83bmr634389966b.40.1776038050618; Sun, 12 Apr 2026
 16:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260412012323.1807856-1-chao.liu.zevorn@gmail.com>
In-Reply-To: <20260412012323.1807856-1-chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2026 09:53:43 +1000
X-Gm-Features: AQROBzDqc0G6sK8SLB4I1_AMGBwHoT-bVI8XigbIQ35BCodLaU8mNAkez0Z3EYA
Message-ID: <CAKmqyKPC2=rTTbxxw1jRSwxbQFNTtp+Ry=wNrNnPSiD_rp=tkg@mail.gmail.com>
Subject: Re: [PATCH v1] hw/char/riscv_htif: Fix format specifier for uint64_t
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, tangtao1634@phytium.com.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Sun, Apr 12, 2026 at 11:25=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail.co=
m> wrote:
>
> Use PRIx64 instead of %llx for uint64_t arguments to avoid
> -Werror=3Dformat warnings on platforms where uint64_t is not
> long long.
>
> This fixes the cross-riscv64-system CI failure:
>   https://gitlab.com/TaoTang/qemu/-/jobs/13878406521
>
> Fixes: d98f7a541c2c ("riscv_htif: reject invalid signature ranges (end <=
=3D begin)")
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/riscv_htif.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 65ddea3fc8..a53d2ace02 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -172,8 +172,9 @@ static void htif_handle_tohost_write(HTIFState *s, ui=
nt64_t val_written)
>                   */
>                  if (sig_file && begin_sig_addr && end_sig_addr) {
>                      if (end_sig_addr <=3D begin_sig_addr) {
> -                        error_report("Invalid HTIF signature range: begi=
n=3D0x%llx end=3D0x%llx",
> -                                    begin_sig_addr, end_sig_addr);
> +                        error_report("Invalid HTIF signature range:"
> +                                     " begin=3D0x%" PRIx64 " end=3D0x%" =
PRIx64,
> +                                     begin_sig_addr, end_sig_addr);
>                          return;
>                      }
>                      uint64_t sig_len =3D end_sig_addr - begin_sig_addr;
> --
> 2.53.0
>
>


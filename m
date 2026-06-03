Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA67CCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 00:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUZt9-0003Vu-B5; Tue, 02 Jun 2026 20:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZt3-0003RR-JF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:55:15 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZsz-0006V8-LW
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:55:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68b482888c3so193760a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 17:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780448104; cv=none;
 d=google.com; s=arc-20240605;
 b=WWORVsOinzVvD0Qo2M/ap4UwqBoAJtwGJ9fWSZAMqvlleDqmhR9TGg5bwRgkUHbUrs
 B8xlZ+qmePYadSBCoIEah9vvnLb6O5ZhnTecOmpdJ1ZGTlPT6hJulTitvIcjrwd3hs1o
 gjQGkHibiV1vEy10oljF4BrpZtelMoZ3jSz4t/SWWzyZZjHppO36Q12jqgCmLQrs6J7e
 47++LaP4PhQSXRWMh7PMVZ7fa4UDZK8x26wfopwJFACYFFf87a0GKJFZiAo52HsnFj4F
 Pd5GojVKtATqsjEUyKkiON+g5B69j8hw/9NZK89lKcCietEbeVjKdl6pwQ21h4689p/2
 05Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MfCaxHxJ72Sdk5cHzFNp6GKqyBD5CFoqX8Dk1uv/XlU=;
 fh=VHujqg+9hTfq6vg2mTI39Ti1R8WOgkqd9mnsMag08lc=;
 b=FfMjTsIgD3RsXA2MNk7QfwI0qywBzuA/09HJeDgPcjf3eCkd6EhwFrBcwTs0cnQccd
 Bman87+THVjFdFQTXyvGJQ/5txSJL3SOxoaG3UbsdXqK9TpWIlXxrtu6XznaIO/oZvhR
 /qZT7GIYfW4JDtaqZQI9yXGNjC47VVNIBjOZbWKO/5w/2D3a2Xw89Q3SlfbAbIsBT189
 iBawCidGVHSWK+aHaY7+sn1qjFvqDlTFBhugHZ58Asq5noDbmQoC3nQLNsMIKotzVUxQ
 PdntTSAozDtJRPD/tN47a5ksZ99xp5ZjpBc5RLJ+YIk+o9WBkoqhHFNdZwMcyJneV2j3
 XllQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780448104; x=1781052904; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfCaxHxJ72Sdk5cHzFNp6GKqyBD5CFoqX8Dk1uv/XlU=;
 b=dbxQc5Enp64YQRkZCBgwvIPXt57DRfSmJ/PM+u9c/SW9hSEi2gBrqr/l4HLIQE0Yqm
 fONHnPfWhe+EucaedKGLVu8vnfFfCbmjPiiZhj0O/howMPSyQJRxN38GshVdbmq7O9XQ
 IdkPVaeE81BgwzigyuHD7EujP5XktBT1cLYyDIHb2CJpOZiUJGdgKC11GUQ9sUbwgxji
 TJTk04FoQIm8STVTi79gmMYaPBSAuqqtO8zoRMl5fUM4l4sKr80RaDuPp1admbHi7TN0
 tcBlOPMKBCwS+C7mbfmi05j9DRm7p6lzTJ1FrCuAAp6S10j48E7Q0sKK33gs7W5vkyw/
 BBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780448104; x=1781052904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MfCaxHxJ72Sdk5cHzFNp6GKqyBD5CFoqX8Dk1uv/XlU=;
 b=LlHPzE0HYqQBhDGcd82XU279OIxgFoC5DTKKgvLmLbpOw/cbaMpTDhUJyUWLg0ty3V
 hpERbNSKL9DLBBrAOU3Ab8WgI7LQn0p5FoGpa4TtnUHLuT0n/6v+nFRWVsDyZCH+eBju
 wWO4eh8F6VflwBxW6Btfc8WSyoctUafK48tUX7dim1s4Gh2JRRKSlog4XjfEvhe5XBb9
 IgbMfHIUFof9QozUrZbzjMTWIYG0p4ZtIvlP7VefNlCFTA+yOwqO4tID9gjEechVs4G8
 RHVYdUbPJqDkL0xlRCOjBlgGeZpKJ4NRC1x2tTV7KMceIFx0e2t28JoqZb/x+QUhp3JP
 Cc8Q==
X-Gm-Message-State: AOJu0YyswJkF8TuOFzu9HgtR6F/a8+1jILJdusH+HIZTt+6xrf5RlvlO
 76bx+aGrN1wqxv5rFSpHxMWDpGAqsEQbee48drbbJMQvMyRYtnNN//pMkW68YKRKpUwc0mVKDI7
 jqtkXC9tN8lVSp8vLYQcl7LXE3iLDGb4=
X-Gm-Gg: Acq92OFicSHL4/jgTutCR41ZvJ2nE18F9ktvt3UAg3G1/2qw9FLAOopGAVRUXsfMkSt
 2k4Loc1EOIv/rbSbM6P8IPAP2Q+JZwPPQFjauL+LmtCV0Ma4BKxQ5tdtD5KT/O5PsP1YRMOp018
 tQxDRf9AhrSAQwtNiFy4AIWJEpxpz77/6KiO9uREgT4fQBWdba6NciuB4w370GiWAYDhYDPqoFz
 Wh5XyGEaslw2fqEY/QF8tBNLGacVQahEcXEftK3GOwsala+TVDQN5BG0cF19VwZL6BIc34xPeD5
 9HKEQfOCBGtonrb8njRZlWJkhJnsdn83cnQhUrW0WWB8evuv
X-Received: by 2002:a17:907:270f:b0:bc1:c4d:cc70 with SMTP id
 a640c23a62f3a-bf09c6a5855mr33102966b.2.1780448104295; Tue, 02 Jun 2026
 17:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260530102100.78150-1-314abh@gmail.com>
In-Reply-To: <20260530102100.78150-1-314abh@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 10:54:37 +1000
X-Gm-Features: AVHnY4I8CP4BueHDWA7d92YG7A-LD61fKhgdAd-bIKyay25mwyFhXjTtW2dgk28
Message-ID: <CAKmqyKM56VKARehfTCqkre2XvgWs=+oHRWQQmS4gLM83JHrW9Q@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: mask vxrm csrw write to the low 2 bits
To: Abhigyan Kumar <314abh@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Sat, May 30, 2026 at 8:22=E2=80=AFPM Abhigyan Kumar <314abh@gmail.com> w=
rote:
>
> Citing the RISC-V specification:
>
>     "The vector fixed-point rounding-mode register holds a two-bit
>     read-write rounding-mode field in the least-significant bits
>     (vxrm[1:0]). The upper bits, vxrm[XLEN-1:2], should be written as
>     zeros."
>
> QEMU wrote full value into env->vxrm causing read of upper bits too.
> Used existing macros for bit-masking. Previous had a hard-coded value.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3470
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5514e0f45..7b98d66db 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -977,7 +977,7 @@ static RISCVException write_vxrm(CPURISCVState *env, =
int csrno,
>  #if !defined(CONFIG_USER_ONLY)
>      env->mstatus |=3D MSTATUS_VS;
>  #endif
> -    env->vxrm =3D val;
> +    env->vxrm =3D val & (VCSR_VXRM >> VCSR_VXRM_SHIFT);
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.54.0
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039B4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlQf-0005Jf-0P; Sun, 17 May 2026 20:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlQd-0005JJ-SV
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:01:51 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlQc-0002GY-DL
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:01:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67c3cb1433cso3895345a12.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779062508; cv=none;
 d=google.com; s=arc-20240605;
 b=PXh4UYdLpS4AI/WWoDCBNfpGB1/BR+MYBUwpan7rddFClxxouIH3KWvUoLd5RCDTS/
 0L96GuUcMySfSTcxPL4bdcQs7fQW21wYQn+N/rm8k0yG5wHODk0jDEskdtwBmRJIpCVF
 ciECt/fM0nYV6c95POd93rWvdQYLgzWlQkQdBb6rmQkA9AJBTFdzU68xUodYZksR6GMu
 YqVmwL7Ugp3WWz5Pyv7z1Sluwoz0yn26aGfBgKWVaRkSRKIt1BddCWYRl0HQ/BF/FRUo
 1znVavWH30o0tuOJciAIiJCgJTwBS8gWqxHzSEIfhxdXAJC4uJSDVwcL8OiPaFh6gthS
 KNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pMd71gGYvqpjrVfieFn3+K+1uaSQQk6SAiovKGnyjyc=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=LCiJjeHgZAY/EtVnPnzfR4UCKE3STkhsnGPkvd/XGdOQdwezrweKll0Kt1Z/9rrd1w
 ZE27+YKE//sM0nF9Ut7z6RaQx2bQ7OHfidrJB4Gb44ge8JxY9peNaa6QMvDh3SHayyRL
 f+LXvS0NCz02RERq7af5tNWrW/PGGc2nY2ghfm+sED3pqkICrQ1ejfhCLjbN89gPATcs
 2PPE4PK1UbLvXeq1+ZvbsNiOFIgwKta3zkHPfZlRt2Rqin0AcLBnX/s+NVFVusl8k4bA
 NyC8Dw85CmrS3ysmw6WR8pPm0wWbYl3GsT7U2huJCvd8Ai/ysNdi/zy+IFGye3PnaaPx
 81kQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779062508; x=1779667308; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMd71gGYvqpjrVfieFn3+K+1uaSQQk6SAiovKGnyjyc=;
 b=de8j0vhYQ/jA38/ruthyIxNU5Sma//e8+8P4uE79jxKdPIJURETEDRXbKs6EDQKsQm
 e35GGDFyDOSqztEMiSrHp6a/loH2sJc6uLwuyep3e9pkUIdkhyOsn/1rYGeQPfQD5IXb
 bn8jWb9GyTvMDeJ44CPfUSbSZ5NR1/0IG/SkZWH2xbrrZZhw4ScPBKE8w8mjnDUHdqAd
 XvWitwdmEPP0yGC3BVsuzP7ThQe/ir/sNQmm7mtMCOv7zszKe0vRPREeDJwwlFk0Zwm0
 78tinrkXW4vi8bF6RHM3/BkqPfuaOR5EyDQE2BrZSwBO3cd9L5W7aUXGPU5EFRA5ue1z
 q78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062508; x=1779667308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pMd71gGYvqpjrVfieFn3+K+1uaSQQk6SAiovKGnyjyc=;
 b=i9O5DQ2nSB6Qh0N8PjQDmGQQIXs75YustEchKohJUMS56Hd3Y4fo+9vOLWJNEgaplA
 KWQUUYt+J6AwfuQ1yRgxwsQweLYQDIIOWgV2Wlnz/naw/7rcZ5jGlwQhszQxGC2HyB/w
 lJ5cdiVlIHUyRYajPuN5yruYwsDYESpFgFemwlURnq7vr3Y3BVHAC/FkrN/QoaC+wza8
 CKszC0mhldVbVKfmu8BkGCtv1Xc+AhDvjMe7tHerzFFK5RDouVN1v6yNFb5E5kFJxTR+
 Nvphbm1aU5BRSBhxmJHoQrV/dxSKA4a1AtyCboxaQVkXExUbdDNCZdNzKUBY0tEM1c5d
 WfcQ==
X-Gm-Message-State: AOJu0YwWRjlT6tIBjyTgujgaWjCsNHoUV/ixfzUOV+hj7OqtST5XvE36
 ey04xc6+1TFx346LuRwDz3C8k0p7sMw7BMBda9W38eLChG6OnrJ0hHQY1mCq/p7Uu8/ywJgwsUe
 j2XeNg/vHlIqgTZeBu/qtYB+7ZNqYfwg=
X-Gm-Gg: Acq92OHwZn8/dNHFIvf4maYFl177K2QJKMvFr5afBnuiJp3mCVpUcMRc+ng9mGb1XzS
 C6xZpzBsTIrJmgypEkBsYyQ0vRpDJ+SIDn68CmunRCfqao7wVAAe9RQq+8MxuZwPGOc5zRQrLKP
 u5QN7etJXHptG3WW/eDVMBDrtQO1cBjvcuuWHU7Se/ct5m/laopok/Ydm7Xh1THwI6m/K0QyEk8
 M5EC6fjgH1Fb8UrYBGSeuiYE2RaLN17mOrKVPMXRLkZ9971F0tsX3ioZxeKrNoFbTOT5RdeDbqd
 LMY34YMgpW3gVFk2GTvE21MTxDqO6qjGHmfGCQ==
X-Received: by 2002:a17:907:c247:b0:bd2:4aa6:1a9d with SMTP id
 a640c23a62f3a-bd5177c7b25mr694861066b.16.1779062508187; Sun, 17 May 2026
 17:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-2-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:01:21 +1000
X-Gm-Features: AVHnY4LaWkLk2boPzJodtyzHAakkQNcssJ-iBr_3jDWG1ZB5jKL-BVnkE-HfGZk
Message-ID: <CAKmqyKPKA5fygqFJzzcXr-QX=L+RL7qhBMhhP3LZREFSjkjOkQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] target/riscv/cpu.c: add xlrbr isa_edata_arr[]
 entry
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Tue, May 12, 2026 at 1:30=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The entry was missing from isa_edata_arr[].
>
> Fixes: 32bbab666 ("target/riscv: add draft RISC-V Zbr ext as xbr0p93")
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a13727c0d4..a9d9d16c1f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -255,6 +255,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b=
),
>      ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
> +    ISA_EXT_DATA_ENTRY(xlrbr, PRIV_VERSION_1_13_0, ext_xlrbr),
>      ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
>      ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
>      ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
> --
> 2.43.0
>
>


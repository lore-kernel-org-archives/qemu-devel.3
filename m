Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6B3D7495C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 04:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t601k-0000e3-Jq; Wed, 30 Oct 2024 00:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t601j-0000dn-Kl
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 00:09:47 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1t601f-00079X-S0
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 00:09:46 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e30d212b6b1so537243276.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1730261382; x=1730866182; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dJ/GjVSWNbRUptloZAHxrikX/GBfIaeieJXMVBylzCc=;
 b=gnyDvFRNHI+HxXTRWj7EFgLNF5gqbg6+mTxUpg+9qXeObFk3GIM0A/arNSEAnwbVA8
 OKUbpZikbT91Ml7hyiputRiPjFXS22TiDLpGRycvyDo4VYgljJF2aNNOOzKJ4zYDLoQ0
 XuY2td9GceZSrmYEBeKzVCM0pQsmFdq7YGX7YkTA3ZgxhJQQrHA5DVqjqGN0GuHp3vYs
 qBAFUxmmERRH0Fe20DDI3IsxDeEPSHH0nok/DUcrorWvyfMs+p/hk1scdoKPUcjKW2Z/
 BJ/it/dZLFYdp9h+3H2zH5suuVe7K0Phk31T1XiQezpWl0WSIghV2rB77FYTU4BTzy0y
 OzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730261382; x=1730866182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dJ/GjVSWNbRUptloZAHxrikX/GBfIaeieJXMVBylzCc=;
 b=qFlfGSXtr4aCmqnf5iHEP14McGslyyIisxXMBzIfVq4vSrR+4+w9HgWsZKSz2vNtBj
 ClMsL0ds1eErNRp+I2ltYThvxBHHwoeGvf+d4VMqUFeUoNAOz7Hm2ocGvPgWY/IIVq6C
 IFYDr6/JvNsBgQCYGEZY3LHifl67fF+4pSf3H58gR3V6JxWMBt6NuR7Qxug0RPHMFt9C
 bkOY2Yp72oU7buXOaYVjsfAERgiPgGB3K5PCe3pItcB3VABrN6HXsOoYfJQ8Awh+vuLl
 WV0PJGum2WCfulYRh8fp1d3HJL7xy9QQ6pXRE0JFyEiO4YHeQAd4xoBm32NFfC6MdTLV
 UEBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIPIQd+V2Xe1xBOgZAoyP1o7Dk1115gvbXYBtEeT2gkB+587NtTGkVWtUCTWrnR22j7912DfgOlVP5@nongnu.org
X-Gm-Message-State: AOJu0Yx/VUS1sVuqWH49Vnz8jgh6OiLtT5uqgZG/jRMUs+AD68qj9NsN
 R8+U0+NalXJl4EH9hCl6sJsjimNiZCD41LrKCnsxuF5+HpFxlgrFDEQSgL135kSElH4Vxe0woiL
 e29L6L8nVPEhFhviGdyIJg/+BeJPs4/Jgz+Uz9w==
X-Google-Smtp-Source: AGHT+IEII9QJYdl6gvDmZPw0pRVeLT9mhSJdMPVDhstKtW5FXKQjkU58oDGlJ/265sAQ1SPkOsuNhD/0OoiT/z4/X1U=
X-Received: by 2002:a05:6902:1204:b0:e30:cb01:be0d with SMTP id
 3f1490d57ef6-e30cb01bf22mr2934584276.55.1730261382522; Tue, 29 Oct 2024
 21:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241030004146.935656-1-antonb@tenstorrent.com>
 <CAKmqyKMJ0Lu7Jvh2KM7yGjq00uHnAmav9sV7cmWnzrkchQR2xQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMJ0Lu7Jvh2KM7yGjq00uHnAmav9sV7cmWnzrkchQR2xQ@mail.gmail.com>
From: Anton Blanchard <antonb@tenstorrent.com>
Date: Wed, 30 Oct 2024 15:09:31 +1100
Message-ID: <CAN7m+mCyx78jaMgJDHwdy8ZhxrsP-9jDhjmNrJnn_cffePqJhw@mail.gmail.com>
Subject: Re: [CAUTION - External Sender] Re: [PATCH] target/riscv: Fix
 vcompress with rvv_ta_all_1s
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000001308fd0625a9df88"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=antonb@tenstorrent.com; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000001308fd0625a9df88
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

On Wed, Oct 30, 2024 at 2:39=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com>
wrote:
> > vcompress packs vl or less fields into vd, so the tail starts after the
> > last packed field.
>
> Is that right?
>
> It's different from every other vector command. Although the wording
> in the spec is very confusing

It is confusing. This thread has some clarification, and we should probably
follow up on the suggestion to improve the ISA wording:

https://github.com/riscv/riscv-v-spec/issues/796

Thanks,
Anton

--0000000000001308fd0625a9df88
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alistair,<div><br>On Wed, Oct 30, 2024 at 2:39=E2=80=AF=
PM Alistair Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@=
gmail.com</a>&gt; wrote:<br>&gt; &gt; vcompress packs vl or less fields int=
o vd, so the tail starts after the<br>&gt; &gt; last packed field.<br>&gt;<=
br>&gt; Is that right?<br>&gt;<br>&gt; It&#39;s different from every other =
vector command. Although the wording<br>&gt; in the spec is very confusing<=
br><br></div><div><div class=3D"gmail-gs" style=3D"margin:0px;min-width:0px=
;padding:0px 0px 20px;width:initial;font-family:&quot;Google Sans&quot;,Rob=
oto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:medium"><div class=3D"=
gmail-"><div id=3D"gmail-:3ji" class=3D"gmail-ii gmail-gt" style=3D"directi=
on:ltr;margin:8px 0px 0px;padding:0px;font-size:0.875rem;overflow-x:hidden"=
><div id=3D"gmail-:3io" class=3D"gmail-a3s gmail-aiL" style=3D"direction:lt=
r;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-a=
lternates:normal;font-size-adjust:none;font-kerning:auto;font-feature-setti=
ngs:normal;font-stretch:normal;font-size:small;line-height:1.5;font-family:=
Arial,Helvetica,sans-serif;overflow:auto hidden"><div dir=3D"ltr"><div>It i=
s confusing. This thread has some clarification, and we should probably</di=
v><div>follow up on the suggestion to improve the ISA wording:</div><div><b=
r></div><div><a href=3D"https://github.com/riscv/riscv-v-spec/issues/796" t=
arget=3D"_blank">https://github.com/riscv/riscv-v-spec/issues/796</a></div>=
<font color=3D"#888888"><div><br></div><div>Thanks,</div><div>Anton</div></=
font></div></div></div></div></div></div></div>

--0000000000001308fd0625a9df88--


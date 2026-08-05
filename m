Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95DBC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdKf-0008If-Nu; Wed, 05 Aug 2026 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wrdKc-0008IE-Db
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:14:58 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wrdKa-0003vg-2J
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:14:57 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6682259cb3dso2063883d50.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785942895; cv=none;
 d=google.com; s=arc-20260327;
 b=CYjePdJNASsoAOXpzyYqIf6moaeZqQZhk46xClJMpJ6vpT81Tx16kE4eWpNyM24+8T
 u3hnYJfeWG3IvlbLM9cAW18tTWAqI9ky0TvCJ0lKmmGPODqdegDI/2AwiFLO6HkWrp8B
 /FSiubqdvXsF5teEtLu6MHV+70reo7ikhJ5ygaXDZ4n91ZFfhi2GBwxReDGXrVs5oSKJ
 zOAa4BVhpWTlhccCfCeSJiB+6fNz8CowyA+tO3Z0+go8jHfM/U63DZlUIi8xErNCgDDF
 QWQ4vvVGm0Eg+Du0PUptb5gbxH4lHwtu9sGiQtHorK6BOR4et1zfM5aOlK5uv61J8NsT
 G/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pdZ+H8C4aO6k24qQRRfn0WLFF2X3tDY9A21qNVIwjII=;
 fh=MrC4L7+H7Lh0dpszqHFglF7qoDz5PPfvwAWpuV8Tsgo=;
 b=TyZ907Kxdc3Yu7HiAdIvxtZsqO4k/WcJzApVScewOxwv85Jpa7iVItk9L6ZhJPJpFa
 F+225/gL+WLPyEvRgcNV3zZrhWEE4njIQSByHZef9wvED8cOheiDKwNEar6lggN8FimU
 uHYoMRP/yffs2SDmC3LB2GcN22S7Hoquz4udD3rrMvlYs145uy9NND96PoWbPkxmw9I/
 mAia84y/y/l4DOJAmrrcsyWp5s7M48wqLtFkLAEKSOtjqNFhsx17MvraXMOVx4LUZ+d8
 wZACFrbWMF1PfWAOAORiDapviFQ7qOFAcAVgK5Q+oKb0USvL1lfTfmVtWhUZWgBntXkV
 5Z3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1785942895; x=1786547695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pdZ+H8C4aO6k24qQRRfn0WLFF2X3tDY9A21qNVIwjII=;
 b=LuWq3jdb3mEAef1Wdr5jbTbaR+Dw8bS1DAIEEVu3W81QtfXyL1lXUMuET+GNMNL73U
 T+uudS+Jc8vt3d92RRWkg7Isur8S1weoZVQR/6F4bkymWxvipAx+Fgj7w/6e8ztjIk+1
 sAokELTC2Cm7Yp/lm1w8w/9UbWWMDWT15c6m5Y7ov8U92gDmROQiOvWf2SA0BC3aSP+m
 XqorMtgyIP7qfyXj4y7g+OJFbzpRuVDwXCaNK+XxLVH0JmC4+e7zK341x5Kocwqc1Ecr
 T/I38QG3UfNiU9tVmMw/bVbi8ecKiZWxbf6MNhf5AV+xHo4JsjRrnuDUQntz5HieUki9
 miqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785942895; x=1786547695;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pdZ+H8C4aO6k24qQRRfn0WLFF2X3tDY9A21qNVIwjII=;
 b=NhESlBRBpZWJiH64YzlSkFs6XU9SSyt4pr+nuyz1+Agf5GDCLzyyQIpg/rHnVrOh7Q
 oDOeZzVsGIwNmKxQcp2NVovLzpfel5p0PofC9t52+lBDGRs3hsJhlnubjyYK8YSuE1T/
 ARGWIp77B1y7uCrHxApY6AxZZevSxRngTHCzU81yFm2o6cXrrO4yzCSMZiGF9M70bDmD
 dOJuRyZBDbbd6lXP/8CesCNzpcLK7a6/heoQn/woEzRbYyanmgZWj7ONo1sHVd+MjqUL
 G/vztRKppTvlFmu2ckz06P7/rHP9r6SLNglwmYDweEYAZFS3U8mdda+/5mbdaVpgpTfV
 ATiQ==
X-Gm-Message-State: AOJu0YyePa6RfXdbrqXQar6sC3sIxa4nKeV0TX9b67CfUEyZVl9tMJb9
 ug2FH2ZgozrAhgXDIbLZeCiuE85VIiI864+ZUdvmdaSRYONj7IZ4ekB9D4eGZvMisXx1TULS/PM
 iREFxGDfQmVkAxn9a1mhSpsWNAmlfcaYs0cB+oSXT1A==
X-Gm-Gg: AR+sD113RnAZBiokZG66ScaTOf5PKucMvVuKJ99i3BzAzGVpxw62Pj2Mfi7tUndwGCR
 d8qA7SW85F9e2zZUpXBrJdXj+Ue2a+A2grCIcutWhcMAG7GJGY99ueYByHBOyVrtPGdDlb9qxwe
 26DCgjhwyaPA/wxXR/rn80Hvvq7CghcGJFxyXlrwpT+6rWOrYsjfE+mi8pwE75QoGp8KmIMwxt7
 3PEUmMk2sI1gaTaLvxy5cAzu3jnRQ+Pk82GnzghrtptNzcXigEvYE6u2Z6p+7R7lDSgA8D4c0js
 f2sEWuV0bnP2bCERFKxuloDekPOxlveBciK1GtIN92E9D0oZ+w/XK3OyMQdn+qlmXjaRlgU7gGI
 =
X-Received: by 2002:a53:d94a:0:b0:668:14a7:d00d with SMTP id
 956f58d0204a3-66985a1e70dmr6122636d50.2.1785942894673; Wed, 05 Aug 2026
 08:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
 <20260801192848.30606-2-flamboyant.h.01@gmail.com>
 <itp7xmctqnac4c7kytqyrrs3xbfnbjprem6ezlltc6b5ncdpdn@6pypq3e7lbog>
 <CAAW0U4a-nG-ck4g8w0_Vt1Jbu5dNcYEDjJNR-YvGEiHa9G4Rdw@mail.gmail.com>
In-Reply-To: <CAAW0U4a-nG-ck4g8w0_Vt1Jbu5dNcYEDjJNR-YvGEiHa9G4Rdw@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 5 Aug 2026 10:14:43 -0500
X-Gm-Features: AUfX_mzuYq7HsXggprpqj-z-yCsBYQMdwg_Kf8bKB4H-h0AZUPzYce_eCFbtZyc
Message-ID: <CAEev2e8UcXn46OoyqTXpx8-_PzUNyGJDVF094J+boLUSqQ3VLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hw/ssi: Add Synopsys DesignWare SSI standard PIO
 controller
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On Tue, Aug 4, 2026 at 10:57=E2=80=AFPM Kangjie Huang <flamboyant.h.01@gmai=
l.com> wrote:
>
> Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com> =E4=BA=8E2026=E5=B9=
=B48=E6=9C=885=E6=97=A5=E5=91=A8=E4=B8=89 02:39=E5=86=99=E9=81=93=EF=BC=9A
>
> > There are 2 variants of designware spi, one is called dw-apb-ssi and
> > another is called dwc-ssi. If you look at their u-boot drivers, you can
> > see that they differ in the location of the TMOD bits in the CTRLR0.
> > dw-apb-ssi has it at bits 8 and 9, while dwc-ssi has it at 10/11.
> > This implementation is for the dwc-ssi version (which is the newer one)=
.
> >
> > Would it be possible to have the naming be consistent (DWC_SSI,
> > dwc_ssi.c) everywhere? There are some places throught the series where
> > the file names/Kconfig symbols/function names are named dw_ssi.
> >
> > One could argue that this model could retain the generic designware spi
> > name and support both versions, but I don't think that's necessary.
>
> I will make the naming consistently use dwc_ssi throughout the
> next revision of the series.
>
> I compared the dw-apb-ssi and dwc-ssi , as well as their Linux
> and U-Boot driver implementations, and confirmed that the two variants
> have distinct guest-visible register ABIs. As you note, CTRLR0.TMOD is
> located at bits [9:8] in dw-apb-ssi and at bits [11:10] in DWC SSI. Also,=
The
> layouts and supported ranges of other fields, including DFS, FRF and
> SCPH/SCPOL, also differ. Linux and U-Boot likewise use explicit
> capability checks to select the appropriate register field encodings.
>
> Supporting dw-apb-ssi would require variant-specific register handling
> and tests. But QEMU currently has no concrete dw-apb-ssi machine/SoC
> consumer, my understanding is that this series should remain focused on
> dwc-ssi, with dw-apb-ssi support added together with a concrete consumer
> and its tests in the future. Please let me know if I have misunderstood.

Sounds good. I wouldn't worry about supporting dw-apb-ssi.

>
> Regards,
> Kangjie


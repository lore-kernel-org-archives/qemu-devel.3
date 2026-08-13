Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2490C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuQE2-0008Cc-Ca; Thu, 13 Aug 2026 03:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuQDt-0007v4-3j
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:51:33 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuQDr-0005vj-Mi
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 03:51:32 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81ed000b507so18607407b3.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 00:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786607490; cv=none;
 d=google.com; s=arc-20260327;
 b=omDZVgm+ye3Tt9XYg3TeckC1bUzEcwhfZj8W4O5z2kZTJjiTSEVRYNJk3BUHooLRtv
 fKUH26yPTmS23ksSVIQHMdO11vrJyi1nLSrUzROvl0fogwzXFJ9hn+3holwncTmy+yM3
 9O7u7K4i/fNkjjBuIj2PlYqVVWjRCjRU2Bx/EuJ689qbdb4i7BTVgNqLqf7DK4k+XBNL
 SWm0NJYihfpjNCm114WZMN96gKjS2TvM92EIUOcn1mEgXM5zvssq3GeWjM6m9tlp3xAD
 whPvH69xt+tsCUY8egR09pY+jHvYTBLC6r0YLEyY1X6hy/0QfbcaFdy37orU/dSIP81Z
 HUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zLY6XVyEJwjjdlR9796icQpjJYNCoOvvo7uxpuoaiRU=;
 fh=JLdhO+mcoEIPztBBYj+nSHu/CdxBGW6q2laimeDlze4=;
 b=V++nBbzonezE8rYkLDVJ6Uo0BepIfbmy2G7TbGzubaJzku4w2JDnJ/4PX2HnHfPx/P
 R74/x6JIq9cdeq3IOmty4xCbrcYcYsaeqPyA36ZeIVNGonCvWMMIQjiKzJMKE9xAawiv
 Ba15HouROy9WrzG/8/GFXKIXgooGOAYk6m9IF+VxiDrFS6lTUtfzfDPIf+kJ62UfgxlH
 EU7QaFrx1PCXRFMA2rYJC+LPZVwnW1FYKjwq/4A94TnNoDdvhsYp+/YIrkWRQR7XyZ3G
 gvvZFp7uuKbX6zebUk4GTZtS5LO4b9Vn4c9SbMbjLpFEIBGjHRpWwBXbRZGlpTjxJpMP
 /eqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786607490; x=1787212290; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zLY6XVyEJwjjdlR9796icQpjJYNCoOvvo7uxpuoaiRU=;
 b=kUTfvxejVNDXfNCl0YZnpr/zwEPapM1tpr1nAvXoqOFZHBqHMrD53tRzQlBaoHkZvn
 X+kLGrESC9Q6cZ6MducxYeU+q+W8eDGQJVOwb5AgXA/h4aPrgQy0VfiOY682HB/crVyR
 grzDVvz5Wkn5hH3HxnPQjylLO6sSA1Ja4pJ3WfkW5M8MAZ0ncOQxIoFsuagK5J6D+3Ka
 5VJpEBR5+LGoLcCqINDrRwSkRniIZL/sxMW5+wo4KHtjh6jzGTCeQxbZxf1ANZnpRwtL
 LypBpNpL1Jwajs24hlPBZPIc/TDdhM0wT07yfKBckPpHo8pNMSEm6PAA8GNSPsI3axNm
 H2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786607490; x=1787212290;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zLY6XVyEJwjjdlR9796icQpjJYNCoOvvo7uxpuoaiRU=;
 b=QQUPui78IWzoRpo5tsG/Q/zTao1nqMPT3WKo6vyBd3zG44zKL+UPmAHri+CN6MUYW2
 lKHOJrHvBjiKWsqxz++FVhSok9TaxB+1JfIlmaQ/Bs6PR66VZoePns1hxImm65itY432
 LDn1jxiKQQ6ku5vRklzXGDLHLoD/+FkzymJPHwcJQFKIgMvJp6drcDryMVZ1ZlLkaA75
 vQKlQfaBHXsurzz6qeElXDWAQBKWaYdBTbNnHI3OYtmuuUrNwH474Tb7RGOEyEL6Oc/+
 1L1LdV73/dTq4ZvhzStWeOASyHus2DZD+1V5DV0h17M0TJU4U1802b9gWS6Frl+hXPVC
 lj+g==
X-Gm-Message-State: AOJu0YzubyZabOARdd68HEb741qm0LCyIOq3CADmsl+u4/UhSJCe4m4z
 OLxOIxAgb355B063+fC845OOxraBJ6ToyxBKtvEvJRLd+yT/Fo8uD/oo2oGjRWmvbi9qq6p4Uxa
 M9aGecVIiF7ceE24lq4CmRisRl23Y3WQ=
X-Gm-Gg: AR+sD12ajlcRq7Wo7FrFDRrnoqd7zY1u57gSc4HDXFWLuFFD+KNqMRsJLGY3bLsy7YN
 xT1ZWgYbdoJeTWfJT9pA7CTnH/yTNPbDEHSAIYfRMo6rbqOUiHUQM5JLJKxKgnkER1WcgWEiz+O
 1wGGnosGIPQf4ySM07iXWzDomLtCbd30jMyn03n0EYIRGKZsWzHYozk5sjUj0X0es7FTCfcEDLX
 Uv0gNL0bWiFeQ2Mwn6ACreJRrvSV/GPvY/TOvr+RMyBZXyeHHgSzMKDKbrY6AhwqxLuIV+j5gFi
 V4XzRGRfEuo1/nVKpnZdDXl5bbhT5H04z2Ee9XYpYsg12ikChXu3
X-Received: by 2002:a05:690c:31a:b0:81e:c436:c530 with SMTP id
 00721157ae682-834723c8b1dmr23257777b3.14.1786607489888; Thu, 13 Aug 2026
 00:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1784022244.git.flamboyant.h.01@gmail.com>
 <42d005d6e530e2cf2c7df8634e8b82c0f77d1702.1784022244.git.flamboyant.h.01@gmail.com>
 <an0wcQahXAB6UCCB@ChaodeMacBook-Pro.local>
In-Reply-To: <an0wcQahXAB6UCCB@ChaodeMacBook-Pro.local>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Thu, 13 Aug 2026 15:51:17 +0800
X-Gm-Features: AUfX_mzrdsTYQgtzlU-Ct7QniI_NzOG1UNbuZhVOcmE1BGbAfpF2y1yOWx5mPdk
Message-ID: <CAAW0U4atycRToaPbd8tRo1KoNUe54zLdi_72oCFqYHv8E81=2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/misc/k230_iomux: add Kendryte K230 IOMUX model
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, caojunze424@gmail.com, 
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yw1-x112d.google.com
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

Hi
Chao Liu <chao.liu@processmission.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=9B=9B 11:18=E5=86=99=E9=81=93=EF=BC=9A
>
> According to the K230 Manual, Section 12.9.2.2, IOMUX register bit 31 (DI=
)
> is a read-only field described as =E2=80=9CInput data from outside the Ch=
ip to the PAD=E2=80=9D:
>
>   > bits: 31
>   > Field Name: DI
>   > Access: RO
>   > Field Description: Input data from outside the Chip to the PAD
>
> We don't need to simulate external input here, but I suggest adding a
> comment explaining that this is set to zero.
>
> I checked the K230 SDK and there are no dependencies on this part,
> but from the standpoint of modeling completeness, it's worth noting.
Hi Junze, Alistair, and Chao,

Thank you very much for the reviews. The suggestions are very helpful.
I will address them in v3.

Thanks,
Kangjie


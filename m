Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74416C5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpqMk-0003MK-Fq; Fri, 31 Jul 2026 12:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wpqMg-0003LW-EF
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:45:44 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wpqMc-0006j1-6b
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:45:41 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81e86df8987so17173017b3.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785516336; cv=none;
 d=google.com; s=arc-20260327;
 b=hMU5Ad37Jlh59Q3JnBoWTDUNBoEzldLEsGefhlKraYs0kWi212GAmOBs+JAw0/2+kA
 /miOzo+AmfUF/mb/xSVKV9VpSmgRgRjmkWK32mwOBkuYOys07uVBpr57VMx1dUfznOEN
 wvTEh+gp3n/u2EOt0Kqfkoa/XuGyLPDlZ1IiV8E+0VocbgW9lLWYnyQoleFQo1kofNrg
 saEuMb2qwjKkwIoWAPd6rRTQZdd7ChjW0/eioUYAFjLMHQfvjUeDm1CjNz7Y6RIfTDgI
 XWxizfihhrED8weN/WfbZO+GkhDKofHgi+/t9FLScC76mSg/2DJ4cGpFRESA8lN+Vq9K
 Zunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A+NGJY56fgdNcLlC/wNsXA1YhWHl/XQ+obiPU9wc6i8=;
 fh=Cl1qdbMJi69Nzml0jHfOHf5GnLHYX18FskqlTJAdaH0=;
 b=GRLbeVNqt5aE8ZFey8Xs1iO6KjqWkj5VRQ1KAY6Gr0DC4NH1KUcPjFDZA78oWFAwC4
 qKdCPiGpmF614ixCKZ2hA03VlSHl4FNGS8gt1x9PlPtR9WWSCaCURseq2TROqYOzcm30
 eFqcLoMn3zd/z3pw7RpVMAIyKNIWAI+uPfxisUrFOvzp4GAaqeO8sAP+pTqQDGoB2DQc
 jK71KTEYMBboyUVaPkaFSex09H2bB+Mo0/mtzqX+xrAcZSTIrHxfYs9dzjTh+zBJgB9B
 HqMtRbR4yPagUQqE5pRnjqfd7smVdSrpkjTECht/JfMNOPOGFEKxPTIZfpSeytpMqyoc
 wJig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785516336; x=1786121136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A+NGJY56fgdNcLlC/wNsXA1YhWHl/XQ+obiPU9wc6i8=;
 b=aEYE3jw2EXL+mrQVkdmIA9tGHu5tfVhy9Wr72Qyl9ztuX7Wo+WctCNVF1pozIe1+1T
 XGL/upF/b2MKHZ+lN+rLURyAPMXEATftAHv33+NCqOnDVZ5vf/EC78NLcDZX6khRqAkF
 htUAT0QOaez7VLxPqgejCvDOUGczRmmi4X6knPoLzcqwCZ7+HqVKxaijEAM3lDfNv8LS
 m/sbwzgomSJ0UioZoh//jR4N4XRAZvVmE7HiQyHo24MX5TuRi2BCHbjC4REZLo+OLNRL
 WTOQt/vww0mNIKvVf0AuYCA/F9yXUaaI/pZGTKJjuqK/k+L2y1o9b6tBK4AtCwjARpsm
 pd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785516336; x=1786121136;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A+NGJY56fgdNcLlC/wNsXA1YhWHl/XQ+obiPU9wc6i8=;
 b=kkUwL66F3olRcDJc7lpTqJdD6L+kKkZU1tYv8mnZOiQawa3zhljkFa3/QQggPRG3Rm
 m2Bo6nJG1xPPDUOCtcKcsEDLo4esuSHsCq21/7pSEN4xv2aE2xFHDGn+E9Oq64mxQ0Ol
 8E0J2CbSeu+92k/6jqhv6gIBO9L/SkyuC7FGW8tr28DRzOS+C7VYnDheD04nlJvQdFU3
 DOEu2aD2qkHadAPetg1drNRjVf9obttRyYiqquvm9bKL55nw3fkwzkc0mysVOR2cFFmY
 KNNJWF/CoKgc8tzh5b0Dv11uEP8P6MTBhSHul/B3G+qvAO+g0t+SyVVWte3cIEcotUsV
 w2yg==
X-Gm-Message-State: AOJu0Yw5oLaHE9Vwfyy3Aj4uVIMsvjkDbqy0YLAOI1rWCNqRToLuE57B
 sU01y/RQT3hb/1A74aqR2Xhf9zIAVPHzmgEyGWlHL+iYB3wh1oqAM+l2WtC9Wuh26FFUDJYK2sf
 ldlcqiAxIcfqKhQvvGmBJedJVASbKBk0=
X-Gm-Gg: AR+sD13NITgIGZrlbaRuRaYDgQcGf3nJSk9W1HZOjjHV022UkDat4GO+TzLiMjYvJX5
 KZVGSoUcMTVEub8rKbr95gU1R89cRJAxcqgw5zMhgL69SAIq2uknIAsEA8P2MiDSO27zBgu4DJZ
 /gRM46a+wueA3jpgfLorLPM5mOwrf2WxgDduwQv0cSLdouvOKIrCCfN5QWuu8VTl+t/q8cFZoA3
 DBraAA/C5vK4CdkkFEDTkfLpJ9B921CKKk9NcqJAiTdhitRhtOz57jrEb8UBHDorhqLiffblB2X
 ACGuy4nhpxESzvffCqvCDxojqEe7Bd4VnO2hHb6OEqv77HBdPowGe2WUKQ==
X-Received: by 2002:a05:690c:650c:b0:80c:5cfa:34bc with SMTP id
 00721157ae682-81fd4a2d324mr8298937b3.11.1785516335867; Fri, 31 Jul 2026
 09:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260731093618.2961031-1-peter.maydell@linaro.org>
 <20260731093618.2961031-2-peter.maydell@linaro.org>
In-Reply-To: <20260731093618.2961031-2-peter.maydell@linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 1 Aug 2026 00:45:24 +0800
X-Gm-Features: AUfX_mzaWx-YS8aYWdWlf7-OToGLz8fmf8Tf1fomxUBtRRN4xAQ5lSchil9obxA
Message-ID: <CAEUhbmUzztbEtCD6yPi+D3j4xK_k_hC+ck1t5ed-Vm=aAyNGyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/rtl8139: Fix handling of VLAN tags on incoming
 short packets
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jul 31, 2026 at 5:36=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The rtl8139 receive code handles VLAN tags in incoming packets by
> copying the VLAN tag to a special field in the receive descriptor,
> and copying only the actual payload data to the receive buffer.  This
> code tries to ensure that it pads out the payload to at least
> MIN_BUF_SIZE bytes.
>
> In commit 63b901bfd30 we removed the main "pad short frames" code
> from this device because we switched to requiring net backends to do
> the padding.  However we didn't notice that this broke the VLAN tag
> handling, which relied on the old code making the buffer at least
> MIN_BUF_SIZE + VLAN_HLEN bytes so that it could copy MIN_BUF_SIZE
> bytes into the receive buffer even after removing the VLAN tag.  The
> result is that the guest can make us read 4 bytes off the end of a
> buffer by feeding itself a suitable short packet in loopback mode.
>
> The old behaviour is actually not correct, because the IEEE802.1Q
> standard says that the minimum ethernet frame size remains 64 bytes
> including the 4 checksum bytes, and so when a tag is present the
> payload data only needs to be 56 bytes.  (A bridge implementation can
> choose to pad tagged frames out to 68 bytes, but it doesn't have to,
> and so all devices have to correctly handle incoming tagged frames
> that are 64 bytes long.)
>
> The RTL8139 datasheet isn't very communicative on this topic, but
> there's nothing that suggests it adds extra padding on receive that
> didn't exist in the incoming packet.
>
> Drop the last remnants of the padding handling from this device;
> this avoids overcopying into the guest when we receive a short
> VLAN tagged packet.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3518
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I had been looking at this from the POV of making the generic
> net code add extra padding when a VLAN tag is present, but I
> went and read the 802.1Q spec and I now think this is just a
> place where the rtl8139 code got it wrong.
> ---
>  hw/net/rtl8139.c | 5 -----
>  1 file changed, 5 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>


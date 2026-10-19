Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5207FCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xImE2-0001L8-UP; Mon, 19 Oct 2026 08:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xImDz-0001Kp-Nl
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:12:20 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xImDx-0004zL-Hi
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:12:19 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ab38a051aaso15706437b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792411935; cv=none;
 d=google.com; s=arc-20260327;
 b=ezM9myG5Ybhd6PsZnhesY/nzfGBY9wFRsEnvLSVjJpFW/ycIEYMyXHu0S2g5GLtCff
 Sh31+AYl2m9ceETzxs4842T5nV2Zd/0wKJl8Rt53tmvJm9hGDZncQo1qzPR+wD+NM04w
 xvIjfzwTIcOPD8rMGpoPLCAmB7APFt4WtA+fGpT4abj1pfWqtS8NPXhzeO2KP7599H8l
 sX4B/qDCuSGes+uBIuImXNV+3xz94DhanSCZTqsazJxHJlpcrrF0FC0u3Fy+x64BqvFq
 6jPcP7oHWO2OmguoL7s9f/odZJZpT454aDiOdGxXNMUCtWL+bchUC1+1jCUwyXVS5EPu
 aS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7cmhy7Rroz4LNmdo/2C48BjcF94jPiYFsUptYORfGWk=;
 fh=uqlfEi1dn98HS/4dWABUkTpK/JLfygkkvCdvrZ4o0Fg=;
 b=PSg5p6u+JXjYaTXnYPBkmgM73uRuWvlBX3WDOiOtFMKeOC68BnFN2WQlNS4s+TH9FR
 Slaoz5dtl3tkTsk66VkYgJBeu4b8nGtwGReowzRiKT7FrjHD7yS4i7TrQRT7vQOGTQlR
 4AG46lW1VtTVZBubw5ipBOlTj8zU5fQwnacyBSRVDiiV8yj/c/aI7hwZmSKmv+cRX4u4
 SSgvRSbNRLD8Fdsu2KI84YQCtULdmeTXNuEGNRUNwcQUa3Rg1BXqs1NDdKgxumEyVX64
 r/dTiMzaTFRpUZlm6WRFRkFhr7b4eVx4i5blMPvRuKyFOVktVv/36mq8SggFqbts/mpc
 H52w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792411935; x=1793016735; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7cmhy7Rroz4LNmdo/2C48BjcF94jPiYFsUptYORfGWk=;
 b=e0lUrd3tGOoArSSEGq005Dtac7XnAXgqQb26mp9yjE83nPnvfHDexQg/X7MRS6w71H
 bcuMrpg9Fl0tV7O5v+wPTxL4UsJpvlQ2DmoBWb91+Bks8Ty2CtfLG+ZGfthjjXBHWaCL
 UrTYecMEqM/D+u5ARFoFs55D7HKYxw7cV/DPNa+f6d+0I5F221mthB4wOS6470Ze/XCN
 nqfsbx3736r9Q0kppzIMnOQyVawLmj8u8AreT1C0zirbVNQngfp/pOxqbEOgfxk3C/Hs
 2rmuJA1px03Upjt9WxKavWwzBqKLRDDwJBI0og0UJmm91Y5sXzZzyl0LkhexgLUf7iRI
 UsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792411935; x=1793016735;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7cmhy7Rroz4LNmdo/2C48BjcF94jPiYFsUptYORfGWk=;
 b=fKRQmX1iqpDxCuMDkpQo9q6WjIzZypNGVi6UTDgHodd9R3Gcqhe/raHdSiGVOcJM0y
 ogSsrewxix+v76677ogLNCB9/a+Q+DpxNy1zQhFkzo8LXXBQq94xHxg0OHRhqIjanl/W
 JHfuw7gG7EoDvqUFLZw7n9LlNCTGGGQxrz18g7kKRb3qx5lLwP1cB5nYPQ+Vo454TL7d
 JoflxxGI60liWFdargb9Jp5B94YBGZfVoBwdWPtGG+KLcnFX23mVeUmMMYNvclRjnMOk
 WOaLICb54dcs9IQ8/k72+EC7sWI/DCPIjNJzjHf15uHfqi/ICI0TyginF3yr7MJgD9wR
 mYLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgxVl/wOFcLqsL+hKm8MfJLiqDF+IzHnMUUwtU+NQ+4YVyJt3kZ9VBRXDRHE7sl0eqEp7iJJrw5RKB@nongnu.org
X-Gm-Message-State: AFq9FYIImP5LPBaDkUWk9Kg+xbweZjiNmUeN+FeSPXyqG4RyWhyWeAcP
 D2LjlReonepuYlCYEXjNnnZsdz3f8iMtCaw03BazSRI98pPY9IJ83ywtxXBQrbnWrmfdzebBy6y
 HNZzPN05Xe2wNFYW3ay1Gek/jdHLlgdKfICycIuH21w==
X-Gm-Gg: AYBFou16waQUsBGXoIOyS52ikl+L6Pe4mHZYBonNXyjCXHqt72TxKJA2oXwFYujmyOT
 3fp2xmwPM7XtbOuCbUCbAOI9l9gBFFFCqJHTASyaIz9wmBcFISBzyyhb3GpWSdaKbkJTDIhC4u3
 d+3QRrRg+J/ADoJ/O4oFvvmZJPPW4Gijxtz2aUPc5YRK5ss0R7nLfqK+ZApfxtR98PfTXdvwGtS
 1ch7uj5Vjr9O/Sc+Sl7djZ1/VdOIy+rv+JvDoevvjwa1TnxvDm7/qPe3qg0lLpwbTtUb77+/suA
 HT23UiWlkMf7vgEuQz3UJZA9L32BDEOVJzzBjrDG8YqDuF7kMqroC6efHxSxBZvrlfAqaFM6/No
 34QnoRyX4l3TaIU9Vh3vc5lub0tDIAsNQQ1NMmEhpp0/HljtjVQ==
X-Received: by 2002:a05:690c:a6c9:b0:893:44af:ceaa with SMTP id
 00721157ae682-8b0f205bc82mr18570277b3.5.1792411935218; Mon, 19 Oct 2026
 05:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
 <20261019120517.1448687-19-mark.caveayland@nutanix.com>
In-Reply-To: <20261019120517.1448687-19-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 13:12:03 +0100
X-Gm-Features: AclHuK8ZXrS7z7rNR5xPtI86u1a7DgqF7yBwPx-IzPuf4gXWad_LCi0c6yZfuKo
Message-ID: <CAFEAcA_22wyh0cm+H_m9Cd_5zTLk-=wbXEOY3W67fi_07YAFgA@mail.gmail.com>
Subject: Re: [PATCH v3 18/28] isa-bus.c: introduce isa_realize() function
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 19 Oct 2026 at 13:08, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This is required for implementing a container device containing one or more ISA
> devices to ensure that the refcount is handled correctly.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/isa/isa.h | 1 +
>  hw/isa/isa-bus.c     | 5 +++++
>  2 files changed, 6 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


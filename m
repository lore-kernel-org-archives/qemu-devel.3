Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3E0CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOze-0007g4-Qu; Sun, 04 Oct 2026 12:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOzd-0007fX-3M
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:23:17 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOzb-0001t5-DV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:23:16 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 956f58d0204a3-67561cbafd0so669628d50.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130994; cv=none;
 d=google.com; s=arc-20260327;
 b=WPqbcXBRSOx0yPwOCiN873g0KH+ACL/wnSNupLH3+1wDzactQ5k/NMBBxP8x8SJOMm
 2jsJCMBtkf6oyJOf5GB6onPbhiokuJVFnM2v+9+OfjFM1YseQj6xyqy+ewpOo9Ji+3nL
 PnOLeyhVohgvg0CUXCWRu7esX+uQZB4+vN/YUHmvr0Y/wSVHNGCrc4fCz3EqT6RRAvbg
 gpeH18Pd9vHcVD8RrZXJyxE4uko3XYpxGWLzkIpHHVhucUcsCE+tZ2XRXvFIU7Uy/CuL
 HKLjIGW357o+DpBwi3nLng15ccNDgVwoFwudQGp0YOYsShXehdG+X4FoP7h4a6OwAdSo
 qNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0uWBLkvdDSFceOzyC8rYMyTgibfU19qKHDtqHeejCOw=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=WmlcQHU8xKKS/v8iLE6Wx5MbyPd0FHswKRXKwdUTlytqw8Celsrlan4nfB3r7jb3eu
 /QPDHyqVq43TXz2oIIQjm7tggB0pNO356iz6b8FQgMk7budjZnCP6pFFw6nYM+GERnye
 vouNOnM4PcvzAl2sdI0B2EPM+XmeTpWx1tWMTCIuxEMQKKpHLfqfafthOHTjN4kd5FVK
 xdZagTcxqiK24cX1MUCeMisKX1PNJZdpWGGzoitqDqPM/8ClTq4TZ4TChRB3b5ksv3Nv
 oD+7LQjIA7CXLGhSeDMaOg4cAQ731vCvVlPD3KZqA6Xgicz6wo74USt5iJvTT+rJH/ow
 w3aA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130994; x=1791735794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0uWBLkvdDSFceOzyC8rYMyTgibfU19qKHDtqHeejCOw=;
 b=fo8zKmx7SRep6DfpCuyY7VXSODFtYf0mj4nPdwpjSUpmyC+HNB5c0JsKhlrLS/uYDt
 xTMEkuv8OZDDBUYNc6UFJpt2nkCTGAh78mM5LMZu5CFHMZWJz9yzUeVwMQfwJn9wrTeO
 emwBLYq5xINA1inYXQcTZPtSQUGr1+4INK8Wc1StN3xGmcW8/rIPItpnnzhwzTcZrP3W
 PO5Xun/+dNraw9jIJNksRqiNOmv91dojfj3HZ/RC3dMOpw5+H6TwiXEysAV5EFv5PQuX
 fgf2oXOguTDMWJCD5ZXzsZWTIbI/XoFkTTbm/pLtWjlU4evWSziQ92uWModcluWq23ox
 L9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130994; x=1791735794;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0uWBLkvdDSFceOzyC8rYMyTgibfU19qKHDtqHeejCOw=;
 b=EQ4OJ7rhFCENLPkSSThWYW/ifybsFkdVxovkx2jvPLSmVY3wstzM0A/PViXyAtXWE7
 7vRfAqGJP6vmBhrXJGwdllkNsVPATEZDVrukIZI+dt20Q8Vxmch6lvlhQ2xLW/l+1Y7t
 OLrMo0ZnCa1fjlghwIiD1gMhSmafSeW86jULcH1NsNIeDbEeqSvME6dNZ8cxwwolCglL
 6pAYHdwuiwWYcLZETIx3YjcUASil1V7lJapF1/gXyLF+28HaIxZ2sUi2a4E13zc5TPva
 iVfV4H3NcD+0BkpI6HuNT+TU3l6vQH1w4ydYf3mzSx/HRnuebzAnlYt+pf0mvy7fOgAF
 aV+w==
X-Gm-Message-State: AFq9FYKUGLH1C/sdYOjZqHnQd2xXvqSRoEB2TgqgQIXqPUJ/KuLumzM7
 3I7zHd4sJfespCnyjoRuMdtBha6ERPdZru6QKv8rEv0raUgU33tcf4AOywmGnVns/wl9tsmCrJa
 gT+nVkoX8pVUKRnT8A67KCnf5Ub0j7tw=
X-Gm-Gg: AYBFou0tea6mfLy1l7ISBqAB8jJD+Vof1obJFcSN5gcqG8hNnv7fWF8ZWwuMDwX77ss
 2ejU7Ann4b1z5YccFV1gOD5ibB3B2q4lL17BeU2PNEqd97ru5Im7ShSOggsXxS9UCcIRln7d/ZH
 oaH309bMZO8oWpC6h5a4HGbYhxWsCTGyrf8alzT3rTBt/uY8xc3zRMzhEOyQUTtGL/5RIV3lULL
 OgLR5aufjDGi/mOMkMcsC743L8TArPLXLHvqDJY+Sl/wQtI5qS+JZvNgfWDR5I7jtjHAES138fn
 W7iPVG7jXayWfnWdJmuAxbBJWNBa9iAfURrnXmVle/7Y2fBD6V6ao4U3XNNrmPYFIO0i0gOzRJc
 Z5HX8uzNpAvNVLyM=
X-Received: by 2002:a05:690e:b47:b0:672:bfb4:5f4c with SMTP id
 956f58d0204a3-677ac1dce4amr3501287d50.101.1791130994268; Sun, 04 Oct 2026
 09:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-25-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-25-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:23:02 +0800
X-Gm-Features: AclHuK_WFrgaXVnhRvm6p4dc3G9NQEYGWbXKAEa1ayUH6DDGMpX1j7g2IZayK7U
Message-ID: <CAEUhbmXf-o+m7_L3EHJYXZmGb_SXzksFb13MY4EwScuK3M1HLg@mail.gmail.com>
Subject: Re: [PATCH v2 24/30] Kconfig: Extract config IMX_GPT from config IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Oct 4, 2026 at 8:32=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_GPT to eventually eliminate config IMX.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig       | 7 +++++++
>  hw/timer/Kconfig     | 5 +++++
>  hw/timer/meson.build | 2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>


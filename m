Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF6EF34C64
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJTZ-0003Vx-3G; Mon, 13 Apr 2026 11:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCJTX-0003VG-En
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:45:23 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCJTV-0006d9-Re
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:45:23 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-650789b22e3so5000629d50.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 08:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776095120; cv=none;
 d=google.com; s=arc-20240605;
 b=dvO53nnls/zz4KfAc67t8Mltv2voE2kdN/dXDPqiRhRHYcNR22/kpiyvux9tzmcK6p
 zPqc68lsZPaZX3e3pUkvoDcNFPiqgA7ct3VzVrthwE8z+0hYSqWXnIAicbnDTvzRCs9R
 Ootsu3n1LA0UtGiq/OJPwLRXlsfPjzEkRbidHv+ayL7b8f7Z68Ax8J5H10s6x+VdN6HF
 wb30Jmf2IgnB0zz/ZwMrTtYikECJOP4otD0BroJzFPMsjmvML2xxaPFjnbOq+S2DXwLC
 /gIFKpUIenaPvvTRrB7m2e0lcB2dZbgWg1M7G0V4fNUMkcn3CeUDVm48N7q53Q+uHyv1
 ESVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=riW71PclCiQU2fsUTHuBNzwXD1UZBB8o9+nl1jBl8jU=;
 fh=ALeMb0ICJgHgamdD3MB22cM7s6+GyDlr+DSZvDZGG74=;
 b=YPrss5knDaJluw5H3UgymZj4VC4JLsoZbeSyoRgWid6IURqy/euplw8enxGhNpLyKG
 jNa1YSQe6CR6ewL+gOAw/3rE+4C4HYZiK7f5KnnaZ77zmgAv2aotKKmU14qKj4O09AZT
 RJaHNV7UKWJouf7Nwa0icRPfAtFD47brZXhZ7PV/IdXLYZO3mJcv25bx5nWUBjIr/B0Z
 xTpSboR1cgL3RaMbJkOg3HJ1EbPDP8fjRcbu6DhX1Ja/Aw2vsdLQrYZONDF99S/hn/lg
 JaNnHBp4oh83/TNUl+hGhTII+oKd4TU7kg/0WF3vig7Kf+h8UFv0atA7GzcOE6v9n3JF
 PBPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776095120; x=1776699920; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=riW71PclCiQU2fsUTHuBNzwXD1UZBB8o9+nl1jBl8jU=;
 b=S/lkp9FwrDL2o7r6gA7vYFnHjyWtpd2TawkQ8IbtBB52WW0cH/cxU7/UzD2yaMQDTo
 jWZ2XVlr/mo5B6GPRBWsFBBdLp4bV/LYanRhzWvjnLsZfxJODCZ2fW1y438+g4+anaAp
 1HWyEN2yj2swC5/80IOiPrSVsIBsuMKcJJWBiNCsBfS+9Ba3w2JtKIhtAurJ9Fc346Cr
 92gdILKhh6lPadKlooJ7m6sZ81QXNd7YvhjaYiPayr/XGwwf2dk9q+B9pmS54UixOmuk
 HYx8cgxgC2Z/RF4pHJbRE6tSsi4rozI00pCIwDmE+kkv/y9Ue7okxt1fPwE2KOnn3rUy
 ltRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776095120; x=1776699920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riW71PclCiQU2fsUTHuBNzwXD1UZBB8o9+nl1jBl8jU=;
 b=BhqRXJyLQ0/RUfTFPzyoaDiXIvaXbTr2hbE58laeLCG8WbdgdY+1uK7f/vAjkErgWF
 +nAQNBKwjwOYH34bHJjF1+RwNEbqwWqhlUtzHoEX/4D5sCUWLci40+wOXjUN6AlNwulH
 GlKqdtuLnUBO04FmWI5vLjXykmih9AHEoiNs10yy9rOxWHxxrwT/JumvSj/U0J8d2ERc
 RybiCTfAzx4s6pqrYM47wrZSVEEzP1+uZ/oNsjJ9RQCdlphKJybTVku9hjRbkj0tIlcj
 QYEcgc3m/WgnwkugmBn/V0WXtBEVFZQ4DihMkPEBTBoLgNoZid7a3rtDIz/6MNcxdX0P
 klCQ==
X-Gm-Message-State: AOJu0Yw2oeOF3CE1ZDxlGPvMhGcFsldWdda+oVOdci0nPYJ3RoC/H0W2
 Q23WFcUJR17gV2DUSHMT2MMLjX7FUpHO+XKDd46BR8MLzvb1mcyqxM1VMuSUVo+cE5epMtsgiJ+
 T/2hLvFVsG3PNUNpjkqMgQzkux5fvL+n23Tthqc6XYA==
X-Gm-Gg: AeBDieuWg9PHyf01b6M13mp8I2EdHe8LtqZT+hYjxvcWYRokBFdHdDMOIMHkqz9NNTL
 j8ibJ2BnGjEkx9ix0FMIMzDmPN60P0htwgqJf3ndvZ29X+XhPvlduSO0czwZahZnKThoNk/hnyf
 b7uq3bvKUvwUXlLCwgAz25s4y0gNlp7mdGKUwp1+BRy6IQbNBHJfCXXdjXLjd8FCcb01sHWfagS
 JsUp0XSBlHiFyZtCrqpOhiSrwZ3cAxAVGDzynde/KLWNFZgBA6I8kyAfoV7RabMmXTIYzGmicQC
 fulSH0pETsLiBp22JWNXz2XVWSFxiRzAjlNn5bNbA6LMMNKKSsI3bdvCB7wLuex2cxA=
X-Received: by 2002:a53:ead2:0:b0:651:8abe:ce65 with SMTP id
 956f58d0204a3-65198a6cb0bmr10055130d50.18.1776095120016; Mon, 13 Apr 2026
 08:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260413132840.20439-1-stefanha@redhat.com>
In-Reply-To: <20260413132840.20439-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 16:45:08 +0100
X-Gm-Features: AQROBzDQMpsAruWzP6KeODEOECHODWFOk-lT8VNu2UEopEs2xbgr2DkTkj7ZMnY
Message-ID: <CAFEAcA-rcqNYrPJ3zN7p41SOHXQHzLHEYwSmr3J1qyMkGXbQ_Q@mail.gmail.com>
Subject: Re: [PULL for-11.0 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 13 Apr 2026 at 14:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit becd22fdc2a071783d9e04421526633772b3b98c:
>
>   Update version for v11.0.0-rc3 release (2026-04-09 21:18:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 4913ae36f9796c55d434dcbfa6bdb9ebb3e5e4b1:
>
>   virtio-blk: fix zone report buffer out-of-memory (CVE-2026-5761) (2026-04-13 09:21:38 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> virtio-blk zone report CVE DoS fix
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM


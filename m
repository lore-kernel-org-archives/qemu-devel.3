Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B785AC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNjN-0006wK-1S; Mon, 24 Aug 2026 02:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wyNjA-0006Wn-6J
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:00:14 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wyNj7-0004tq-T9
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:00:11 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66ce00575dcso4116791d50.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 23:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787551208; cv=none;
 d=google.com; s=arc-20260327;
 b=lJuuTmNR0GnGAgOgggtu82KxUO/b9zYNa1y52jv8LI48tONTQFF0BXGE+tK5pcknbg
 KAMy+rwO2h2kLoixwvcPKzeIZMu14V0zact+36/nUeuxvlihewNO0QmWb12+m1rcaun6
 OvcVZ2XJuAtA1W1Qegzd48Khu1CxzBlPDcD6dM9SNLsR4ponyboH5AsmPQZ3tZQflb3S
 rQ3LHXbFAdxiss+ZJFTUR1dfjnntdF8DCKb7WbesijEwL3WDWyL/YckO2PGwHSpUnRIJ
 GYBGp756UVDkscF+pJhv9ekjJBrc9s0fIFSVd/EspX2yZyF+TMekvAeYmp1yonc9SQQF
 qUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pCDl5Yo9QZmUe9jOqY9aOMSSsAye7TXfTZrSmYiRVhE=;
 fh=dYf8J0tZYOk2JCQqluRf7RpwFi9f7WgmsEJFEgol9qs=;
 b=rK92drk8nhGlaB/avAwY67e7uxmDo9rC5HBYtUtPploQX9mGZnq4IazJiv/3FmajzO
 y/3QCZ0DNm/13NpzpMc7fbWVHHKKPyyLRcTMzb6novcz14fuF67nxnwMtrtLFCTXnKzF
 TdkRFVJpvFa2oJU5mwLb2a726pO/RQFKaT47pWFqgmYkriRT6yzGPUEpz7ud0BycG5Ly
 fQ4SwtIR4q9vygy8Fh+iu8rTMPfLUAYnf7aSR3CSw1Oab+CDIwISR57h8f28i7kftft3
 S0VVJYu20lJ1gd8g/sFqOvok5afUGGnFjqlsVbU7O7zcRnT4LXTEc91U1vZf7jYPRS3d
 xw+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1787551208; x=1788156008; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pCDl5Yo9QZmUe9jOqY9aOMSSsAye7TXfTZrSmYiRVhE=;
 b=kYuHY7yMcFbnWVE6KHq9f7KoWkQcmS++yU9ba7WcSdlxnHvevSTy7r24mQ9qfcKR82
 S2L+cpcst7GaWnlsqfbuv/MpzKwy2FnSYEEg4ZFGtHup5XYPwd5zh+LY9qVP+EEYQmfI
 09UhS/JVOCfF/QUbO9GhWSzZMuZuJmcPGndfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787551208; x=1788156008;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pCDl5Yo9QZmUe9jOqY9aOMSSsAye7TXfTZrSmYiRVhE=;
 b=dGER+ZA1gHVk3G08SSnjd3vHZIK7PbZH0NhgqomIt6/hzWZyRXfvqwZFUeyp9clAB5
 MHpwiCAwujYn4e4viHvBaG0YIjY1ib7OvADHIHlMly8LgeKA+pDzvqzRdokXYpAz7l7c
 k+7F6LmtTK+E+dVTqZRvGrFeLV5W8Y4hLPqVQhoiEr+zcPtxIzpc09OaX9w6NHdN5ho7
 3SegbExbFTf3b8J2X3OCI8ueNjkOspvjyABBE0zjwOLVyEA3NEaRSnV6ISAh7K6/n0rq
 GAntCRpktkT17z02wnijWKZNiLgBmZnT9lR3GIInJWNeeUFJV15WD1CbHaaKNNuTcpWL
 oWXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTDxOGYFwcrv1iQTdxyV1fiLBzUNHs/9AWIpZ/JBntnrUjWO+cu+d53cr99aedSyth5PvJwQvO1iW8@nongnu.org
X-Gm-Message-State: AFuF++mfHE6y4P/jQYieJ+5sfzYaahYkQFznwUe2DKZ+J9TAzsFa5Z5H
 nDLoaubXRNo/b9Y7qgUAvNPhqDLIjXfyiqFv0SRb1GFC1yIwPwl5x5ThJAqatCuoNPTfyeTjqQn
 W1k1/xbqZn60HRsPauJnDyan31LjYU5s=
X-Gm-Gg: AR+sD11xgPDnDRpDP4Y71vw99vCcdpkkKmpCdrvnKGgqT525A0gN3DyvBO1Ln3AH/UO
 duo1f+EsxLP7N2DACVqBL2GxLVrCsb2FXg0MAdAutMsTJCODW5aTXnAmmJ34YnfinsX5xo014WZ
 /fkJRTL8jdxEbPED9jyb2wsq9dZChFJYpuOvB5n36ydUVA1TCqhKeHhmxp0OZSuL8sdr2Xj9rV2
 b1R+gxQfNq7jse+CLO4nS17Zv+XRV/wo9mug5l8vegD2P01I12Y5dr1VX27YpBOXKIW+kVvUV7Z
 n3GHlJDRC5XhJvuWKSVpoGy4+RSwwhTtvH9YbX1bUiMMqC+woSmIbcEz5oHMP0nd9il+7cmV5S3
 hudIxycTsSmZhftSLEgpyoRwG+z5UhFtDmi3QJA+eSTeLlJdxA4fT3vnR17Xfa2dz10tERhOpxO
 i57tMhqHqeUaIkAdKmETigTEN7VhM=
X-Received: by 2002:a05:690e:4892:10b0:66b:30cf:64fe with SMTP id
 956f58d0204a3-66ce4acfebdmr5870413d50.26.1787551208584; Sun, 23 Aug 2026
 23:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260824055642.41098-1-joel@jms.id.au>
In-Reply-To: <20260824055642.41098-1-joel@jms.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 24 Aug 2026 15:29:57 +0930
X-Gm-Features: AcwNN1Xxk_LOJMsUoMWZOir6fx-rUViw4NLZg-zbqq6B5aMdrYwB0b_b1PN9JpE
Message-ID: <CACPK8Xd4dhaiQi4ZgP4d2yC3BtEQM0WbUb=DhoD+94jsN56b9A@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/riscv: Post-review cleanups
To: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Portia Stephens <portias@oss.tenstorrent.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 24 Aug 2026 at 15:27, Joel Stanley <joel@jms.id.au> wrote:
>
> Phil made a bunch of suggestions during the Atlantis review for things
> to clean up afterwards. Here are those cleanups. The patches are
> otherwise unrelated.

Doh, sorry, patches went to Phil's old address. Adding him to cc here.

Cheers,

Joel


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41259CC6B19
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGecA-00014A-Tu; Tue, 13 Oct 2026 11:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGec8-00013a-N9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:40:28 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGec0-00045o-5Z
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:40:23 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-677b5148acaso3022515d50.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791906019; cv=none;
 d=google.com; s=arc-20260327;
 b=K7zgfuxZ1+x8mlpTxaRc+zMqqReGq/fv+dMWZA62pNYBlY2AvbJjPJOyFEuiEpurNC
 gtVbHwR7vOddDwyjttIayzBBZky/pMH2HvzhIllIGdZgy1NQIcOnteEFnAet2Gq7w9oy
 xZdT3/VjhMLAoGwUaR4X7br78ZGGTsJa8t1CLYvbrIftZ4yQ8IzSw8+XBaG4Q5mqSppP
 n7hQ0gzG3ItNJtQU8OdPW16Ykx8USxdhuI1dXFwDTcY7BNyagUo7wzTTp45QoMIMI/Zx
 k44Vw/Rc62PYTz4isIxo2UC5m6RtzV23fD7BaoOlxsFpqvuC4UdiLMNDtZVAtJA+VAlw
 YMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7nlBlArFve0HJmN8yN8NWx2yCMMfhH01nmfaIpVhzEU=;
 fh=RMPmDMcrYetE1CeWCEW2kHGe7Qq+O2ZUes9Y7uBIIhw=;
 b=QWkj5bTWt3vBlBGdsmlzedNWLROaWeb1S4+9T5FVgTeIf0w3viGq1gZn7UjdH2NOAW
 IqUbjv2heaVz4BpIL0/pDTukpedcBGAQ4TtTvhds7JrXWeFpZhWyVTSXoyzK6qNkLEOB
 toVliV4hCtiuW3eJCH0UOrDgWdQJvaBRR+EVwj2pshwdtA4nOPJDALMSm9FW1ZD5ki4V
 DuZzhpTKVv3ygMdyzkOBP6KzAqX2G8RBp/JM1gm48886vf4J38+QxnZsOM6nu/dssL8q
 slbe2ER16OmsHCX/aaEBg/GAh/9wY2G0qqULqfeqxCarV5wVbDktaTSwFZfhD5Jv+PMw
 bODg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791906019; x=1792510819; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7nlBlArFve0HJmN8yN8NWx2yCMMfhH01nmfaIpVhzEU=;
 b=WJ69A4YL0pEhY3PtgXN4t37kgeszdvx08VvNtBe8LbVhgQ7pQ7ddfZwoGl2jVISyQV
 nc/JT9tzzeZ0aY7Yys7pid9QLKTga2MV0/3mjdPmTbj3x+0gUoozCS+ZUNsrMABkq843
 Z3MvADSyBV79n1UTa3IGkGE6CkSwH6MYNP7NN4IoiGlsftaTqTYm7Chs6J5mLWgKU06y
 U3Hg7GMKb8MdNkM0IU+0bRAJpvf+kMNxY+itr3yixnhmupwpeeTWzOauTNOi8QVCE03s
 jKdLj29d0pUv3MRgXDh0pwBkw+UmDVLY1wginR3ZfgCfPhEwgHfhKCOWEeONoZ+gVPsC
 5RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906019; x=1792510819;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7nlBlArFve0HJmN8yN8NWx2yCMMfhH01nmfaIpVhzEU=;
 b=SkdYcY+As/ZmOujvP0f2kd+WASmLHnb2cb/eQh5zp+uhABVZ3NDjo85UHPv2GxTj/o
 H27qu22veEAI9pQITCHcEiCLuGDol71lt4yvog/HQiaGRVyJiDz7Zr9etbMIkuRTAui7
 UUNbThl4x+DwGOklXl9d++6AmUlctRWhlqeAruGqZzouDzTK6Q2oBrU/RJnCMOzWIM+I
 xB7C9x4VIDy3tDhUfuILMqfqtYiUeqgktRtOkm0TyJvrDC+H4qJyDsDcPMd6QPfPRfmG
 nvMIVrkJI29B3E0lUQM8hBgNwEYeh9mbbq53w7J4A/I8J4WlPalKxby5cpY7Qa4ocWZj
 rxIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPV0dDKsUjhohDlO4UWgrM7pCyE35QmmrRX9ArGtq+jhOq0o9fEyc6fDJg1L700yeBQflw5xkTCgk6@nongnu.org
X-Gm-Message-State: AFq9FYLupNiguaukjcaNjp9esvh//euWZ/bbcVXguXTBHGXO5mtl+7Mr
 +bnRiqNwUPatDJ/Tkv8OAj1LC/VOGKaPJiNf3ep88gNG7IWwjKlNHgOW7uiT5dmEKyEMieExkn0
 fgVVsnzsKSEpmZ7S8vHeSwlTnxWPznD3xU5weRXG3WA==
X-Gm-Gg: AYBFou1zYDPiiM8UyZOhpC8azzlaVvMJI3sx/5H1NL2huy9yTYwcS01wpnmqO5vNiw+
 rD63Up9UPZoWP6DCR80FXkHMCGm+Ieqw2zGqZQOA2+PsBeka1RtuOfjY21RmGtyAKzYHZmSOH+s
 +VI2enYvJ0fFG5fpVMio/4VuFThybtbp6/Apo4PCFGlSx5B0ch63kO8bo42HJsnjv4lF2kxjm6H
 Cq1fYWfjtPpgWovptrct9RdJz2hPRIqJ8QqubCrvQQ+mhDguX5wl2etIefLAGWC6Qtuj0zpWVMm
 MrrXv5uJI1IhOfJ7kbQQM/jt5tylBtg92u0N7ddQLPTzLaMPd7c8z+P8Ya+1JMgO7KGqirW+Ao3
 bbfLFX3WT/EvcylBXVz3E6YxJK7BNEM3ua6d46S8=
X-Received: by 2002:a05:690e:4091:b0:677:a99a:8107 with SMTP id
 956f58d0204a3-6793628b68cmr4386999d50.105.1791906018426; Tue, 13 Oct 2026
 08:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-2-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-2-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:40:06 +0100
X-Gm-Features: AclHuK-87uWTjw6PP9kfFnc6AhLREEHYfbaenIc_Hyv-azDLMNc0Tk_TV4qrG5Y
Message-ID: <CAFEAcA_ZQBiVLZLBmEKF_DFX9GkvjuHpeup_7_Nb9sB+14zeLA@mail.gmail.com>
Subject: Re: [PATCH 01/22] i8259_internal.h: rename PIC_COMMON to I8259_COMMON
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 16 Sept 2026 at 11:45, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This is to emphasise that child types of PIC_COMMON are all instances of an
> an 8259 PIC.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


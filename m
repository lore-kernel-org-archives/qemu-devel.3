Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890D3CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGedr-00030k-UB; Tue, 13 Oct 2026 11:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGedX-0002uh-9f
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:41:57 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGedU-0004Ju-7B
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:41:53 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-679334baa1fso2484683d50.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791906111; cv=none;
 d=google.com; s=arc-20260327;
 b=ldRbRBTTEajCCq7ucVJ2EWFj1MaujL4V3nnmzkifn4N6tPvo5lJl2FPxACaclh9Tuq
 1UVzGqtTt6FyKnIzVY5CHQbVrGTmQYDtsmm00v2cSAZOfqyHnuZ6ut8592+eSr0k2joN
 afMauC08XO8CxKE4lTgBXuI0Wa75SPpf6yzdy8+14fcjuCbB5TwjOjHy5XYGrpSCto7O
 mxKnvnmdMwP+JsNqBvN7P1au5LrG4MZ+TQxtR6dupNpF2ANt7tkidRZtRCWAXW4zYG2l
 9EWGGpzMt2UKQkdHpQI6rpa+EVWRlicN+pKXsFGG3mn5RBtMiGPIG7fLkK15Fg6XNva3
 SQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/y32TPfvpVgGIoKvh7+P09B6jQ5P/y+ctFLf2J9HI1g=;
 fh=eWVB/1MoHSXOFvEoih5GaOt6AFckOjcM/upgibqUDdo=;
 b=G1kI1QwpHQ4dg7qApUFC8HMIg5wn9NyLm6jHTiE1dmAbC6V1xFhpHyA3t2aL7siYpP
 oH68PX4J62qWsGpEsdEGtFJkXjqUhVcuwj78TwvF/UUlrI7HTbutN+/c3T1UR+AK2liY
 KrzTfjYZp9eOp57loM7Vd867ZrGzKDHAzoIZO0Yh2Xy1zdOIr49Mry3adE8+DWXwpB+Q
 8phB78O+Ppnn7ghptTrjnwe2yLmA/q5AMtiGi05cbYMsFY5SlXTidfTjte2SgYZwKcmN
 6lcud0lcK8jOflm9vmaHdbbOylZ6rZou2gffV3pGDlVQ/f88U7XCwtb6JgWgWHrN/ssw
 gUOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791906111; x=1792510911; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/y32TPfvpVgGIoKvh7+P09B6jQ5P/y+ctFLf2J9HI1g=;
 b=hELT8+VvObFIFkcjiQPaiAxNnbTeaV7WCOh5wbSHt91joCp3xPRgCQWriUlOAINJc0
 mNljdARxyAOq6gONmMhGaDV3m9Yy3O2JBunEj9vFQ3PhlhKIVE40Boo+aaI7N+aWGJYN
 C1Z/lXlbPP1I3Lo2mZykkA7ZIZD8yTTbMa1rL+nxRPC00LUANtrlsufKKtQ1PZhEELGw
 skA3IT+dkcmRXb2xIvD6h5bnSjco/G/Zu3hRIomSXlIaxFSQrdlPhkCRG0XDl0aN44/U
 l70R99TlQpaTG1ycPEhA9/kIQBj5BhY37qWLqcec1QLoT3MP4qkH6k5ENsh/DR6IqJTc
 2rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906111; x=1792510911;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/y32TPfvpVgGIoKvh7+P09B6jQ5P/y+ctFLf2J9HI1g=;
 b=M06SORW8g41ogHJUN7gJ2pC2XIIY8wMZpkOq8g2FVeuVbuVrELhLS1SQGZMTqrHsIF
 Qh5kYpJIvAiIOa99dxGbcRgGDJ6ADZa4ou/+0RkmEtEOqf9H0sFYWNoU77eF+E7DjasF
 mFx4zXyd4QGiPaSYTIsRZZViSWsk4I7WTOyS7kMFBjZfhfSUsDJt1EY2RVO1j301naQ9
 W4CuCgc6TTj+cmdlboxm3c+mOXfqbrpPsb2QcbnVR+iZJ+h98zJUz+3FFfhT58BY6qUb
 lq64STkp+U1XBzvZ/oDLTx+aQdiLaugp+SNWXgwUHjEwiYdZL6iB19k6qHlnKNCO5uyq
 FUrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUBNe7FYJvLpGFkDTR1VMHfwyntJjwCJay0nKy3JZlm5LRJjvhtjDaF5CD6PEdgeFwfXJq7/QKHzp5@nongnu.org
X-Gm-Message-State: AFq9FYLdGNtYHjBXJZJAg5wLvQGSzht5YXbPaJeR5WFZ7acs23zUz1tV
 4hppQZHEu1IXOWGFcPeDTVLL4Kc5AS/zDitxw485PpqFt7H1ZtH9DUTueTtFryfriTAKOp33Wm0
 hboAuc4F9XuHtc51blVWo7edXGOJlWnfhp2aekE7447HZZXQOTRDQM5A=
X-Gm-Gg: AYBFou2BiyWVSNjb7mBWOb2xAc/tULEVneffSGKcL77AeN5syAvq6KJpPaD0qfVzDCz
 ihHHdu0rTZR7rmN1E64xp/USzS3PB8O+zWh7wkmwCCpc5w6Lkob/j+N3X03h6EHTVwwey2z28CV
 eW5N37Uv3Rr7AB8LyllUVAZTRop37FPybj17dbFQu797he/LmySEvSXq2C7N0imzm3Sz6xwzb/J
 +t0MhAiosZicGftAH2F/nPNZKyZE/NH/QnZHl4NG2+nYkgOfLtFodkKdqiFJIbfsYZbCoCoCXeU
 b/otSH9Pt+jSVmpv3oHj+/Ddrpobr+lVinvI+owGA46N01EIL8tRGqPxd9eFviViNEa5uFqe3ZF
 /Y9+V9UQ/OrrPVttpr8UYZ2MOoAW6LZXEE1BisUg=
X-Received: by 2002:a05:690e:148b:b0:672:99e0:ebfe with SMTP id
 956f58d0204a3-67936346e62mr3002172d50.150.1791906110511; Tue, 13 Oct 2026
 08:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-3-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-3-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:41:36 +0100
X-Gm-Features: AclHuK__b2UbCjZFZDrffJnvH_-1ukAWp5TaM48C8WqZ5JfCRPxpvF1PnMp4eNs
Message-ID: <CAFEAcA8M6tO1-xnC5SD4gheqfVney3vy7Z5xj_164=NPRvu5UA@mail.gmail.com>
Subject: Re: [PATCH 02/22] i8259_internal.h: rename TYPE_I8259_COMMON to
 i8259-common
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This is to emphasise that child types of PIC_COMMON are all instances of an
> an 8259 PIC.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/isa/i8259_internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(I checked that we don't use the typename in a vmstate struct
name, so renaming won't accidentally break migration compat)

thanks
-- PMM


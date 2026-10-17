Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F48CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 13:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI4FG-0006Ch-4Z; Sat, 17 Oct 2026 09:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI4FA-0006B3-VU
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 09:14:37 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI4F9-0006xy-5A
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 09:14:36 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8acda240937so5914757b3.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 06:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792242874; cv=none;
 d=google.com; s=arc-20260327;
 b=h/2znHnsMtOj1hw/5CUcbwRUO5GS641aNYlvqsTo3MEuYGsuoLzmy4oWYmxOZ4i2JH
 fvmmN0z0jfHOGXPxi6MM7KAA0Rokjo4cmMRPHdpvdfXHad2reoM+mgbUeDE1yzTGq63J
 kT3qQEYFRg8x2VzV+pO4p0DsMYRoukFUgwVBBVS56xCzBekDtGcqCr64+pOAf6O9TKuB
 i+Z0nhMFjNbyiA0TZvrWsTuQA8p317gsyl0/iUbVC8BUabalyIeq1B7isdNuUeNudn22
 SRiGuidGnt5pOEvWxSCQffDtj4VP6hzVlhfj1dWnL4L2cjp251r6CXVUqPpNVaVLZP6Z
 SbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qEWOcn5RYwvYVIGDAT1q/wdyqeEISGmxEITvVszWRNc=;
 fh=ltWIwVsWDzxKvEG7jBnlBXPrQvIjQc+HOgvPossf/dc=;
 b=ftQY/MWbQs/IGzUuF30B/8NndEpIQTET8tjcB6c6/sC22NMWhHcyaVxuxoEd3niWlr
 vd3W9Ya5pm3F0n0meXme2ypnAgH3GoSmGjQgxgIHnaKr3+k6xcYnDUqpSjjqjCwE+1uc
 b6p9b61hsnZ+Cy0OwHNVJ60vOwWoJdoODSyyNAUfqs8Edxeqc0kOfUqNYKfKbeoSjpBM
 jF4en9/rQ8pnkLE6rXW02/WLXqaSqH4A2AWFAXh+uGOXpf2VZkvFksNxRdAZ15RtqLTd
 6LX+S7HKGmhLvZ78d7ih/XKzYW4q7gVSyS1des2qgCJH20mkN51CLAH1bzgKn1eOSqA7
 /usg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792242874; x=1792847674; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qEWOcn5RYwvYVIGDAT1q/wdyqeEISGmxEITvVszWRNc=;
 b=sSiHce37PiyniKcAJtzquj888uyRCgwTg6bhsAj/TVvuzexNtmyIQ3qa4vgUiINz8t
 BeF3RmOO+amVrdloO5rsITotleGs8plsR7xQ2pFKtUe8uvgP7VYW4JQwISQ37vpd1Dsf
 juYK0hK3iTdX/QOTLk8g04bxLdhEFNJpk3DKJH6nnXPLCc7eOavva8goQ7xLBWrRgt+F
 j3JVNGFwgQAzNFq6LJ6MI5caBiLG5p7HSe+wfgNkYHITgViSONeNHlsI9TJ23UobFqGl
 Lu66dBEWjWO0YLjWM75RouXUWje646B4i7ChDpqT8XVmgPBIws5dU9xU7StCLOn0QQXq
 yjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792242874; x=1792847674;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qEWOcn5RYwvYVIGDAT1q/wdyqeEISGmxEITvVszWRNc=;
 b=wiw9s+5Sgy8Csesa/oovh+nSKOZ5XkmlTfcdYQkU+ZRuJLd4B/6tzy9zE+sYosMUAB
 ssG4G2V9sUzPJRiZ+8lihvAmpWE1iRfVZCodP60oasC2SWQ3C2iL80NrQwDqYY8EcJ+o
 2sAkjXMKxHYCmDyVuCKY3iZljDoVM+HX91G+fEXqI8Ky8vpMQXoX/GNHR9cTfk2WcraQ
 i+LVb6D2bZaYMxh2mOzJ7kxBqFo07I4lKrgcFjPUJ8EvdS0h7wTnPnZ3VNJEGvsh+jUF
 EWn6hC6g16a0frTciXREzk9dv09AAN+fNt5efGRjfXTGLlQYBIlSzFUbxDR9VhFFDlQn
 gKdg==
X-Gm-Message-State: AFq9FYJjj5gHaABqKN1+az3MQKpjWr0kmmIlvy9ebfylv1iNssvl3bwW
 ykxkjrI167C18E0DY489+j98NIXIJO1e7oae/f5Dcn/Z2wlUcsoub3f4s7csXL5q0Piu3qQAZPK
 2nmbW5g+LkqtzUSX5Y25Uty+uJaAtRBYgSDt4MdcRW8Rn7YdLMfv23bk=
X-Gm-Gg: AYBFou1vHkPXMCRrudL6PsEz6LYgywf9gQ+4fxtT/aNaSAuseR0nNPVka+waPIXdB5x
 kk8Mf5COh6XTKLgrS6lirvCpQ4Y3A/jzloOC3eMSKGCat1EGGJva/pVP3XSb1Ahs4z9JwJcgShO
 +N0DbBIKoOK7czjbep6fPSdSx7k+bT56HE6P315c0KfOD9W6SkwTz1LyZfZrFbvpdy4mx/b1Iaf
 pVZl7yWJVEnNLwjeNKfRyB0aEuGm/QyNV3mhwiVYmpXUrKVEIUOYrvZlIi463T6X+rlqnGexNXS
 XWcn9MZ0nQoaQd1L0FRUZJolP41qEpFmmkicyeZHesB+NokecWDPbh2rR7xya+e7SvzA/TMsmaB
 eLqrvo8LJItaFMiHKxNlj3ANql37MpePuYr/LpOVkrbmfLdOJIQ==
X-Received: by 2002:a05:690c:6893:b0:8b0:ecff:f223 with SMTP id
 00721157ae682-8b0f2188e80mr10625377b3.37.1792242873821; Sat, 17 Oct 2026
 06:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-15-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-15-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 14:14:22 +0100
X-Gm-Features: AclHuK_zYUtq4yQVq23K3JynxC_1UL7quBQsPnT4HXp_V0ngxKXhI966H8ryyyM
Message-ID: <CAFEAcA8_voS7tWiBSgdgmJ35+zqpuoUK929sXVgGb_OHewutNA@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] hw/arm/bcm2838: enable BCM2838 GENET controller
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Wire the BCM2838 GENET device (added in the previous patches) into
> the SoC: instantiate it in the peripherals block with
> qemu_configure_nic_device() so it picks up a -nic/-netdev from the
> command line, map its register region at the real BCM2711 physical
> offset, and route its two interrupt lines through the GIC. Also stop
> raspi4b from masking out the "brcm,bcm2711-genet-v5" device-tree
> node, now that the controller it describes is actually implemented.
>
> Adapted from patches 19-29/41 of Sergey Kambalin's Raspberry Pi 4B
> series (patchwork series 829638) against current QEMU master.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(you can keep that R-by even with the rebase fixup that
the nodes_to_remove processing loop goes away when this
lands after the RNG200 series.)

thanks
-- PMM


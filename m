Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09591CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3h5-0006iT-C2; Sat, 17 Oct 2026 08:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3gx-0006i2-JD
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:39:17 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3gv-0003sW-KW
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:39:14 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67992884b02so416836d50.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792240752; cv=none;
 d=google.com; s=arc-20260327;
 b=DsC8jeCP/JFjrnWebDycCm8eyXRnr2qqcNwXfyDJ5DRHguu5+NpcRpq3XkINBIJOPn
 f3bUALIGMMoSRgKCAHaLF4LjrJIMT6y3/1WBV+ClPjrCPp4ibwqBRCl4W8jmTjq8yamj
 Jj2hbQqqwd8QUqHolINaRJTvsF9Y1HMI3qaWwhs5iBE29HhMQyQjV/pmK4PTcTE1z3/y
 T7EJJMgHgmY+2h8wmN9yFbcGTstMa38fag3hGtiLTBpFa0rFUP+mFNW9kLWhboiqeDfW
 5s8YuvPX5p/3TY93mMnkRercDI9IiA5BVV11wc4EW2yKN/ilRz4oswMLfB1URBXRUwB5
 jihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fkIRji0WXt92EPvWP8XtmleqjeC013dlE5jwP2dXmLo=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=kQYdh2rbbr0yoXwrCM2qV4/92dnMmCX0pS59ffpHhsFq8OJIuUMl+p+EKmOtSLoWEU
 hX0jTdZt1h+Yvzyyktzt/Ab7zcZGANqwkDwPgRwNPrV5rT6sIgkNa0/vXRS2eTEPzdfQ
 nyt0QQWOfFEEKW2bdj78zpqUYndW1bsQZpt20+d97dqRZSFStdDlqlS5rO8jadQfXTLW
 p3T18INE+jyDDEdX6+y+HWl2nvpbMPmhArucZ+Zm/WAn8Q1/TNujaHiOVtEvgBgwfY0E
 dXAmMrMzL4WrLI+PtSCzaNFv/jgoWQgAAjVEnxHQ8aEC65ZvMR/4f8lgAfDQrJPn5Gg0
 5NVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792240752; x=1792845552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fkIRji0WXt92EPvWP8XtmleqjeC013dlE5jwP2dXmLo=;
 b=GGy1/KcMQPE5c1PdCojZmBfRNXbF0yYSo+Pj5PQUYos1R2FQmtkQ4uRwtCU3D8P29F
 fYZNyEK1ZGLfyOFuiHSI6g+WpYVU9yyEA1VlTYItm0CiQSoBtVixTwDmpz+gDAGYJ1F9
 vm3IPMr4SIJIgx5+4wuqm/7F0cvL7M+d4QtciqebelmnfzQZ6LPDSax1yllRYaGyOTz1
 G6d2XF8ThK6kGvLmdiWyWaRBbqr8jbvsAnH3FjDPtjYkl5a/XDo6dH9FPnYUh4fpYkIf
 GBgftiblaeuH1ZW0AxgzAIcEkq9Hw1CNzm8TT+asGUne470GWKvZa2kyV+PukJTLvNS2
 gfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240752; x=1792845552;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fkIRji0WXt92EPvWP8XtmleqjeC013dlE5jwP2dXmLo=;
 b=nvCnMlCOIOchCg46gizXfWANBglZmubCZ5xJfzLIbqc9VED1aM+u35vpK3AhS9+N7/
 6rqk2QH1jZwakaeXYnBnRgCtZgGj/WwXxShOkbxWo8Ce9Py7VTji10OqVJmWKSsfR5Ra
 CTAB/RwviQxpgNWzgYMVoVoqCVOFAJ+rqbKkQ9G49+K0TWnS2pQWdq3SkGA+PdyTPSXa
 koJL39l09gXgJhwO5nNbU99zTY/ZAwRpxAKMoRq2dtYaLUAMDlSWAWDkJFJh4pgs5Tj5
 HTkZwkM1T/i9oFiuP+v1lWejpCBzrci6VaDE/Atz/YUq/kyzdOQkd4z6+Ji/SMgAbO+N
 2wUA==
X-Gm-Message-State: AFq9FYK2SNRDXiIn2+FeSXfw/MR3B385/yLI0VSXc8e/4iAYvvl2C+Qg
 z3z8VaWe6jVNklaCAb1F7I5iSTCxzq4hNF8IuAhDlBb+/8httc9GqKWLLMejgk513nRdj2rJvmL
 LY8qXXPt7qE2I7XUbXDeDdqy6qHlA5peEY+aEgoiaCQ==
X-Gm-Gg: AYBFou1ceIsWdNyZQvBWtMzYetMikYHYZBrWKRk7jrfwx4gE/XMdikmYlisHvjBDwtz
 xED99TaAkPak8ddV1mi86JO6lbXPAYX4z2DSqw3OGFuyWFHiVevdvA1W22RrG1GQXYB1dOPRzXr
 1Spwrs3E1iRJUrPA9zTehi291wv3fmN/cysTOdXA4aiz1FfpHohDZDTScmf06ZIMriYRKKzoSrd
 Q4dIncLS+aQO3HYoCLSj9++9iud0tAPqelDfVl51p4giUv6muhikoFt5+iPWQyxlQqhVyazENSY
 Ggid98+jMTEZoYPc+6R8YbM3bgb2V6dxehU9DXG2O2Q1Yp7jfQreR0i46+rQYGCfEXkjbHA8EAW
 1ZX+fMX7vTySfMFQnn4bBV1uttVM13XP7WnnfFJ4=
X-Received: by 2002:a05:690c:294:b0:8b0:cc70:f54b with SMTP id
 00721157ae682-8b0f21df262mr9713597b3.83.1792240751835; Sat, 17 Oct 2026
 05:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-12-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-12-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:39:00 +0100
X-Gm-Features: AclHuK98Sr1n_yS3ZKvEpagjnMVUWjfsxfrHJXJ_0FRxHCqx9UzvJccZWfozVgE
Message-ID: <CAFEAcA99AobP34UsChN82U9Yh6oazdV9vL8s6Fi2Wm3PkL+NXA@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] hw/net/bcm2838_genet: implement GENET MDIO
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Implement the MDIO command register handling used to read/write the
> BCM54213PE PHY's standard MII registers (BMCR, BMSR, LPA, ...) plus
> its vendor "shadow" register blocks reached through the AUX_CTL/
> EXP_SHD indirection scheme, and a simple link-state model (PHY
> starts down, comes up once BMCR is programmed and autonegotiation
> is (re)started).
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> While carrying this forward, fix the autonegotiation-restart handling
> in bcm2838_genet_mdio_cmd(): the guest PHY driver sets BMCR.ANRESTART
> and polls BMCR until it reads back as cleared, but the result of
> FIELD_DP16() (which returns a new value rather than modifying its
> argument) was discarded, so the bit never cleared and the guest
> spun forever at boot. Also refresh the link state once the restart
> has been handled.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

This doesn't compile at this point in the patchseries, because
this function:

> +static void bcm2838_genet_phy_update_link(BCM2838GenetState *s);

is prototyped and called, but never defined:

../../hw/net/bcm2838_genet.c:23:13: error:
=E2=80=98bcm2838_genet_phy_update_link=E2=80=99 used but never defined [-We=
rror]
   23 | static void bcm2838_genet_phy_update_link(BCM2838GenetState *s);
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The patchset has to be able to compile at all points, to
avoid breaking future 'git bisect' operations. Moving the
callsite and the prototype from here to the "RX path" patch
that adds the function is probably the simplest fix.

thanks
-- PMM


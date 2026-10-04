Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0548BCA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDNpm-0001j1-Lr; Sun, 04 Oct 2026 11:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDNpl-0001iX-Db
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:09:01 -0400
Received: from mail-yx2-x0d.google.com ([2607:f8b0:4864:41::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDNpk-0004hs-0l
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:09:01 -0400
Received: by mail-yx2-x0d.google.com with SMTP id
 00721157ae682-8aecf8568b6so5144357b3.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791126539; cv=none;
 d=google.com; s=arc-20260327;
 b=W6e45dCBy+mhIGanhJWYKtSGL6D0MdJJMzN8zHQUl3dlvjVp7gn2NSRDK/bPl/XNGb
 oHe1AhP4R5XF19Yso3xOG0xMZCb5OLImisoNe/t36fmq7uV8DGTq9Jvf3dIfdXoOpHpK
 7Dsv3xpLMm7NCr96VybAMjzVKuZueLoF86SyzhVUQ4zzCbIirvIk16oCb5s4DiyguEk7
 3GJwZBHty4n7XA3suG7ET0LHxtuCHEFwmx3QYA3rVmlpLvFKa3AavYZUnGbu/q3sz82j
 XlDqpGg8KBINazpC7NzB88EqIZk0w/6OJNrpBuFWCqoSBuXY2vztBvdKWKPBlMB5z8nt
 ACwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=swwDlfuawrFpdRpb/+g2X2yVGFLlCvaxB6zYNeM63Ps=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=JqO2DIwHS9PBwE8F8kPjEL0Gx46srfgeTJ9WhszXBSdQAkFCMNsuUMn9NESPpPaYyO
 IcnrmYRGalXNxJ+zVmCBLx+Y9CaijRBn3cU/kH+Myqkn6F6VVpJx9+M0TT0auJd4kIQx
 MiFkh0b/qBnQ8o3vIgciR2O9xUe4rYRmH1tCPUOCqT2pXqtTUd0UGiWpPf/LaTwvN9Kr
 aq+astojSuvDUhGufYv2uXsJ5fayWNIlLTkmH1rnrhCt1G1AR+lBdeT0SK152WYyzcJG
 33nRG361ngHn6D5Fzu0Z1ZA8sGKZy5ydvT7mm2J6pA+xJ2CK/ZZL3Coqb6LckVMW2r/P
 rQJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791126539; x=1791731339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=swwDlfuawrFpdRpb/+g2X2yVGFLlCvaxB6zYNeM63Ps=;
 b=fLrEdxepqS5zf3nFun8bw6KcJa7d8yzc0InJycW9N5Frxg0nxx0R7p6kic2cTJ4NHc
 xRQG6M/tqRuclcKayirA3BuSwCtjf1vj0x9WIwKQYZLBK+eMI1QRHlCgQxXpC9+tVVmg
 aUpF0IvBFwXH1EcHuFPjmFpFg0A0yRabrOfq/dXUgqeBJ4K2DIK8YaOmGQUGy+gUssOv
 vDmO3IrSFL3o0/VvHO/O7ZCnF6K5J+jT0GZpsSiYTvhGE7gDEteTEVxDQgjdqUhhCjsV
 6bK81sYJjjqaIDVdbzKqV6v6CuofoeY7opPpwB6XLgu804yVqA4R4b8x/yexWxyNvZAt
 FgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791126539; x=1791731339;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=swwDlfuawrFpdRpb/+g2X2yVGFLlCvaxB6zYNeM63Ps=;
 b=XWcmwMAKyhN2cf703VE6Vsee3fv01p1uPaK8yxtkP8n8i+dpH3KIJdD2KbIxsduw3g
 fAyUY0Afz9eBNB+gpJxTVXEHwutw8hxl4wn1eGp5Tyz/e2PLonFwGH++T443tGLKwb3e
 RXmBA8MZH5MCHGLnLddp+sTTFTPZFV33IEwg9dbs+qaz2QKhlTTJw7tE0GcrGCu6Olao
 6q6ojhXuC0AZa/ShyKpU7WFbqRnxlwmwSHeJp6PwQtHt+G8TBPpaeZhRjJ3gnyjX2/pM
 07Phj2zRbyaZLWxc7UZommvTJ+Lh9PXJDjX15qZtPvRlwHu4R6kzvxW0Ad4YthSIsjGZ
 nEbA==
X-Gm-Message-State: AFq9FYLHWp6I8y2WeSWNGNCWqHAhfOgSqVtj8noRUAEY/ai2wf0MIQWA
 APLdT27/Gf7euJLFVDfFdbhCtoiW6fp5qPtMqaia2jaNnkq/6BmMk2VoxRFifythKgI0MKX3iYp
 EKbGgklfEV8wNBZP3An3M86HBADIUNxk=
X-Gm-Gg: AYBFou1Sl9zKQF894JcO1061gORW9TKDFrcTZVO6McnLTJW4iVDIsqpg6YsiXd3DdAb
 k/dWb/tGmkrv+6ByQvbi0wzK0YGrKo3vc8awHCahoJ9CWTmn+Yxvi8aaDsvFlJOkAq/9PN0zLxj
 JNV8L1u7yFlFXegj94J+tYdarvAcJTKdbZDTHebYH213dufGpxe2iG6VeELzg61WqU4AT5mHde/
 S1BrNYIKqg8X/bJDN2tgEnupj6I1baewkKup7bPy68LsQGgxeBqnGSBm/0V6fceUaClvqE5c5/K
 84eIRQNyo697BKdjkP/fZTCSF/MtN77y7f+x3xN4MgQFy4aO+ISqj1F2CEuBwg2MNYR4RSAGqFe
 Enr1wiaUehtGCTA==
X-Received: by 2002:a05:690c:85:b0:88f:8384:d446 with SMTP id
 00721157ae682-8ae39aac4c0mr29111447b3.29.1791126538777; Sun, 04 Oct 2026
 08:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-2-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-2-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:08:46 +0800
X-Gm-Features: AclHuK80uxrhMBr9kymKWWSt1x9OX-okUUKszIJeZK8hPz9soArQ3B2pCf1hqXI
Message-ID: <CAEUhbmW4ArGsDv6zKQM2=S7_oayEfKMp1f+uNkYpBXeJv3ayNg@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] hw/watchdog/wdt_imx2: Fix handling of write-once
 WCR bits
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0d.google.com
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

On Sun, Oct 4, 2026 at 8:29=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Guests such as u-boot may experience inadvertant reboots when configuring

a typo: inadvertent

> the WCR register. Apparently there is a typo in the WCR locked bits
> handling: The locked values for s->wcr must come from itself rather than
> from s->wicr, so fix that.
>
> Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/watchdog/wdt_imx2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Regards,
Bin


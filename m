Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664DDCA5FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDjn0-0003eJ-K4; Mon, 05 Oct 2026 10:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDjmy-0003du-KQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:35:36 -0400
Received: from mail-yx2-x0d.google.com ([2607:f8b0:4864:41::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDjmu-0002yO-I1
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 10:35:35 -0400
Received: by mail-yx2-x0d.google.com with SMTP id
 00721157ae682-8aecf8568b6so13048827b3.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 07:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791210930; cv=none;
 d=google.com; s=arc-20260327;
 b=QyrU+nEQQSzOlsvQB9hk3gxtpvOnzOi07WqNhQ3xObkkhr5vBxwunUogxN2oUALHkQ
 OpPAZP2YvL60JKU++ZEoWpPHqL6Mtv/OH8HjLYD1/oHeDHfcNgyfDq1/xI1WcHj7jmqA
 zuSUMNXvajusX9nBNXC82RZBRmRNhhuztRk33vUSDzcaGvfvyLBJtv+4jalNfuM/3HrV
 EeU4Mf9sDAVS1tYcuuFUd+29haktzmcBunXm671bHCGu9MSTnojJzrJTud+wQOm+CjIa
 89U6ozS26MN7yoJpE4kD8rupjpo0HTndfbcvCOBIk26xSZ7J8MoYWlwakp3pCUuA7Cfg
 GckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6NZnBHmuIlQoH345NJt6JQtt6hS/i8mTlsrO4dCzUXQ=;
 fh=EjplmlcXR8MWJXDdpR5ncThIs/e4S293bvxZuvqDLMM=;
 b=U2j+rPnfTYO9bCQnlmb9jkVwKFFhlVgAOo2zUqZSEKk+22Dk+5dLgfFZ42+47n4412
 W/9Mmog23dwZx7yTiva+4DIQcBpnql9rYWiMx6t9eeIRceaiHvjC5oC5gq/yFbJJ6zqC
 gd6Uih9JChEpsHcTIZBq2ZrhjeE9z+WfxgePDodqgatYeOEyNuL9j2V7hfEfrqSr4WdX
 C0yOX5NwfZhGE2kCg+zUCRU1daIDuu/WLsm51vGZdiS4W9GiaRoYqdImhXcg+daGwInj
 8xywYBi8pwIl4qeMdjZSkB1i26HfeHz6H4gVm9NQm631bC8O3GlOezlMJlanlTYiSCeu
 2QRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791210930; x=1791815730; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6NZnBHmuIlQoH345NJt6JQtt6hS/i8mTlsrO4dCzUXQ=;
 b=X09LXh3I1iK3ze1TD/cKc36tRK94meuUeipFJK9hJBx0uWg95yhcVBWQATkNl4ZVy3
 mBB6FiFoqvoXQZGfSRILDZNir3P6AjekDJFPKtIQZMPR+X594GRwkup4Ob5PaA1ujW9i
 zlan3s576VhrhMcT8GnIcrZS26Mp4fg2tFvW8XlII2VFlwiqff3o1RA6hrMSsDQEsyC3
 T8lVnvdPTuXx6Y/2dpIOCivggfrQqa/xC4FZQBSrPhXHKwy5YzppIUarDVuHxTxhq6oe
 uJpzX7+XfXg7uKnGyXD/ydHjai1fDl1xpK8ceKWuwgu//MqrUE6NjIWHBQhNCE9AJyCZ
 CVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791210930; x=1791815730;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6NZnBHmuIlQoH345NJt6JQtt6hS/i8mTlsrO4dCzUXQ=;
 b=E2pM6s+QqnR+wipbCgXKToMVxA9pc3dhaTKRZ5tV0oRlJ4KtDiB5P+BAXxRKECcsFV
 HlGPBBsLZN7rm4YyPF0O/wU0wRleYIDHi3Qbf767sRP3Ob1Ngk8QsINgA4gDWYDnCknu
 CJ28hTvNgKUpN+/fjQ/IMkIySWg3cyIku5X44WmvqUmmRWrxAmKxmAhqXRx5ULj6u8+M
 QpRATFnXKLFt5U5HI8SoUBIUSoh7G2/INxflsQ34TbL3rmzHb+p+/sZNE5wWMt6TH+UH
 ftE2zrHUmDah3tPQNEivGVCpi8YqqIkYNzJwwTwgT3u/wY+3+GVC2LdcJiFEUlaXtzaw
 uJBg==
X-Gm-Message-State: AFq9FYK8vTbdgv94hy8LOmo3hKXPiPW03rr+THFPqo3cdrUa3uZpS4gD
 NeIrPbVunZ2pdOIJ40KW5mCT8Vyvxp1of/uLqaVEx409Sq+X4HMLKgcGAoQilXrMHii2Cjlxicx
 9Ky2faE/xIeOyQ1GS9AinNS1JMtHuiuc=
X-Gm-Gg: AYBFou0L19aiRiK/t6U47Ld/VyvnaPbfOSktRHKpKjy5jNSUqAua6XSPvAomNZrQgOb
 LjEYbLYIhHunco/56LNvRz63SvE/QBw1DMUkd/asxUaJSu5P0c2xAU18kruXPE5tdY8lx1MiiaB
 avTgtICM1E09VIG8cj7pilRGAiyanWgtR4ahtXk8wgsoI7bj4A8uKej4JXUaPpiRD6gk95/jcsi
 ltsKwMwI7b6898CsvcARzGaI3X+hsNxRwo0QvjYAa4IY2XfoaUxSC9cc2O00YRFeJxbRq8H8rGI
 YJwt9QFjiDEBcVgaYdnSkT3Rnz3J9LIh0cgJIvE3o6zwrdMqPXc05XokwblH2LkJbFhrMSQHFYV
 Vl5pf4pAF+59IQzo5
X-Received: by 2002:a53:cb07:0:b0:676:8c39:1ec1 with SMTP id
 956f58d0204a3-677ac165d14mr2764073d50.128.1791210929525; Mon, 05 Oct 2026
 07:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-3-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-3-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 22:35:18 +0800
X-Gm-Features: AclHuK8VjkzcGKGXWhndG6UrYWnZlFQGCWUfbdptdoZLGR2NHGy9x40EbLwQNEc
Message-ID: <CAEUhbmXwznFqCzuL3AhawhSEYwON0SyE1Yx7Y=0S5QUh=-4WTg@mail.gmail.com>
Subject: Re: [PATCH v3 02/31] hw/watchdog/wdt_imx2: Fix handling of write one
 once WCR bits
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0d.google.com
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

On Mon, Oct 5, 2026 at 6:22=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> In locked state, the WDE and WDT bits of the WCR register are one and
> need to be preserved when written. At the moment, the logic is reversed
> such that all but the locked bits are preserved in locked state. Fix
> that.
>
> Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog
> support")
> cc: qemu-stable
> Reported-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/watchdog/wdt_imx2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>


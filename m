Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76029C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOuz-0002yR-Mv; Thu, 16 Jul 2026 12:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wkOuy-0002y3-Ej
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:26:36 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wkOuw-000100-Us
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:26:36 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5aec201b582so6691440e87.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 09:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784219193; cv=none;
 d=google.com; s=arc-20260327;
 b=OO/heY4btilo61XvsLDeaLB6xoRG7uSGR7TifaT5ZtN0qYI2vA0a4zxj+LH6hcRgil
 cPGTTb+NFVXQ9sRkfXwWF7idpKGopLBTS/ljx8wJggBd8eW7VRaAwMSh7NIDdQ/W+qdW
 9ykeQ0pkLi4DmhjgjmVDI676CYoe/LgqMh05s2+loaGiL0v2HsMAF2heYRJNG/z+0pr+
 YhCQDE7HdD5gNKN+JxkZorSbuAo+1YFSDoIc9D2T4R1DaY8C2tWV9nlPuJO7hZ5nIS9G
 9N8Q5Ike0BgXRvrvAAjMyM5zxuer6STcOfNQgvArNLIzLtvphfEF5vDtweqtBDRt37yP
 tNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PL05atO09qDXImkJ85js7wTJNi+FnrcgORTP6RsLvi8=;
 fh=nAvN4y75j2yIYcqte9EQipAO6Eg6yPvb5+V7SAzE8Vc=;
 b=Lxa/Y1pACTVEy9Y3NYAs/z0vGZXicMDMvqG9U4Bx+xebcoWFvTAjwMgXP6oiyvvst2
 RitTsvM+IW3YlkANKGJkwRCa0EFSQ+Z3nZveyTAyU1XwCrdktnSKkymruP7neygm2z9q
 /WwjauCEuP4SeFDm3CCbqlbK9KAhBqQhWYOROhRQ2oltWjPVy1jeMWOc6vp+Z3NL5x8w
 BWX2t3OrdzLFEhmxQHkovwplFgA0MTPkun6P26cPMZEGXcbiaVti2kYyfnHgBYbzyeRU
 OFIdYC0U/rYw1VlkSPo1+jbm6gAHOxEYkXoS0qwvzDgtL4hMGWKabPuGWUIIsb3KDuzN
 ljOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784219193; x=1784823993; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PL05atO09qDXImkJ85js7wTJNi+FnrcgORTP6RsLvi8=;
 b=Bi/K5sb5ug9Eem/WqZiouHjrG42AxSeACdBMMIunZF/jGg7zZSGD/cWdyvliCzcEbJ
 Kr4zOb1+PfaE9nfMnj/b4tTePIsM0famS2eye5OYJAuwOFLDBES3fp5mYq5aaYZK7dC+
 RIv3BOcGWAYHxu6xQlUTHpTYBUiQTlakeHpOMdR+VVx/u/eOR7dcayPTGoD6md70kHQV
 ad5hSd4o9GYxWZa7dGg9H9kGybYTYrUPseD7rXNJj4UO0waDUAut/RD30WrugWfxY2pI
 EpwO2FHDIheABF4OjN/bsHM1fOc9sUGPDvS4ojw6qxqVbIruceD1u1w6tibtwGjRc1FC
 Zmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784219193; x=1784823993;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PL05atO09qDXImkJ85js7wTJNi+FnrcgORTP6RsLvi8=;
 b=H7s6YnE+kbt7c8UUmEZAZBCZRLMdx2vXna7GFTlbKcPbvyTSj59sz7MlL14Ds7qcnv
 KsV/XHWoHDt10oF4oL/czIzhHV6IXFJ16hYyFrFe4ghp5VQOOGlSCFNggt4GAyAImous
 Qgl7vbeHQ+9LXpyOGwr+ZScO6VjcQuiQRfZhrtb1a3bMOepVS0Jxz/aWKDeKSlkTh0hg
 WskvozIqO92bb2mWYSTIW7HCDycp9f15RCeWQW2TCpjMbjACsMjKOiMfZIsA4ZRDC0LA
 iy90gEuFu2zQ/eNMvSlgNd+Q1Lq+OwPXFoWmi6OEnTRIhkzjCcSDCSFYbmLUTdIf0ip1
 XE+g==
X-Gm-Message-State: AOJu0YwjMtTb9nt+BIGq0XYEGQ9ZO3rcPrh8Z3VTtd9Z9H+1wcaqTZR6
 3gCJSQnXW8P25w/2yfIvuP6aDRMCUM26z7WquG5VNuRSxvr2Ey3vEJbUn2GC91s2k72OnTaCboL
 78he/6NGNV1XJyJtrzI4EWIwCsjY9DBo=
X-Gm-Gg: AfdE7clrxRIiDTsTFkuq6RPk+aCapvs1t+EEdkaTOWOk9X90GOD9DksDHyS6iR9IaQ2
 tCgKlxXlhikPtWVaRxqtdkikTDnUS2dQQSqUF3Qvc02bgRF1fLXTRkA/Xwck9RA3bYQN5WUfTKr
 OmhWIAcHg5s9qPCRsYcAhlepfJWeaLlrs6uUt/UIECLCbOIbynjydOqpt28IJzItIc72I3X0t9Q
 Hkig0O/eFQJOZeVJJhum2kqxnzfq2GMaSapH4T6AKawoUCbaCEOt2GqRmudmSMu1BCrQ9HIkg2U
 pat+HozlzuoElZfZoE+N
X-Received: by 2002:ac2:4428:0:b0:5b1:5871:fa60 with SMTP id
 2adb3069b0e04-5b15d78126bmr1231638e87.21.1784219192346; Thu, 16 Jul 2026
 09:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260713141429.3387066-1-peter.maydell@linaro.org>
In-Reply-To: <20260713141429.3387066-1-peter.maydell@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 16 Jul 2026 12:26:19 -0400
X-Gm-Features: AUfX_mxeNaG-ArqVfpoR6BecShAXMuvuZg0FD5BNcj1LoeBFE4iZIZPcdCP224o
Message-ID: <CAEdQ38H1GtvjzdzUZyohzMWB0ijvLoEf20YZbA4y9mm1Hs=xMQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user/sparc: Take pending signals in
 sparc64_set_context()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jul 13, 2026 at 10:14=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> Every callsite of block_signals() checks its return value, except
> the one in sparc64_set_context(). Generally you need to check,
> because the standard pattern is:
>
>     if (block_signals()) {
>         return -QEMU_ERESTARTSYS;
>     }
>     /* do some blocking syscall */
>
> and we need to take any pending signal before we do the blocking
> operation, not afterwards.
>
> The use in sparc64_set_context() doesn't do this.  It doesn't have to
> because the operations it is doing aren't blocking, so it won't get
> into "we didn't take the signal that we should have" races that
> blocking syscalls do.  But it does make this way of updating the
> signal mask inconsistent with how we do it in do_sigprocmask().
> do_sigprocmask() does the usual "return -QEMU_ERESTARTSYS", so a
> pending signal that was not blocked by the old signal mask and which
> will be blocked by the new mask we're about to install will be taken
> before we change the mask.  sparc64_set_context() doesn't check the
> return value, so we won't take that pending signal.  That's not
> wrong, because it just means the signal lost the race with the
> executing code.  But it seems clearer to behave the same way as
> do_sigprocmask(), not differently.
>
> Make sparc64_set_context() check the return value of block_signals()
> and return early if there's a pending signal to take.  We don't need
> to return a separate return code to indicate this because the main
> loop handles it the same either way.
>
> Coverity CID: 1660058
> Fixes: e0f0ce88eb9 ("linux-user/sparc: call block_signals() before set_si=
gmask() in setcontext")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Matt Turner <mattst88@gmail.com>


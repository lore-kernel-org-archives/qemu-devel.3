Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21D2CF65DC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 11:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKa1-0000Dx-Ek; Mon, 26 Jan 2026 06:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkKZy-0000BN-SG
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:16:23 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkKZx-0001N7-DF
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:16:22 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-79456d5ebf9so11842097b3.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 03:16:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769426180; cv=none;
 d=google.com; s=arc-20240605;
 b=WKqZIYQHgkEJ+PWd7hBzTt7Q2PIHyb/aFkcMcd1q4wAauL57/v+PtVFCtHNk8cVjCK
 QKjAG0U1z6nu4BT9JT2iOPpLsOcfspYNVmTEyPmfmawxZ3AbAWsWwhMZOl8pNeCy0OqB
 fKQ6fEWpusZfQ3idvpIaOePwIeky8G4bQisLZbgAKN/y6DW+vliuZXQm1Kbjfo7sOYRn
 jA/DqcsHL1ZYaU9/bkrd2i2vSLJJZnJNGHmduwrDGZkjuj8TSwcGfBnHwhHgjvPHLPVt
 oQaFNX4ZONVzksNjlVPydF513ZtVk/TZSVyE9htMExKdSLg0zw/Ivg+PaMPck/q5wjM1
 0w3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=obXFGCM68Q3WZCZiCmwv7V2/EBxJWNkGk1LJ5RNuqEg=;
 fh=E/IWTL+0I/IGteiok8SRdXTFVgYYTacdVJ63aBir/oc=;
 b=CewEJ7/IT2NPG8vsugPrWNpVQYWT/QcaAo5BltArJEYp0nEGuP2SVgsWX5Op3Q+9Sq
 tZGmRE1OSLyYjw1EUwHO8qDhSKPvn2YRw3Lfwx9ykuDgocAZCQlD3S6j7FgvyYuVbMmW
 ZNDKIE/SXawHxgLT+OpRxYsmf83wXDPzmNrNX9djL2K53OgIq08OqEho68Nhh0DegBBr
 BGYRxKUEDO6z9oYFv0JVzdn72nrP3lsGzi6EqvVr5PFQkP4pWi8wIX3EHMNmbCuG/7PN
 n4Ia/HJvsm5m4hi/q+/nFcC5IYMF7ETAq/IelaRrnYBpWePCqxlW8U1PpnLv9hYdPeVk
 aTuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769426180; x=1770030980; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=obXFGCM68Q3WZCZiCmwv7V2/EBxJWNkGk1LJ5RNuqEg=;
 b=Q5ELRK9TQBDmrGzUPOXQISgP36TSgqft9RbNziqAUaKn2l8rkFblGgG+dL4bPm/yYt
 wNc3r07zchtFiSJQg6ug81NMZl9pRwlVpzyiHEJ4pHCeg414DwF6Bh/ppgcTUEaYvCVv
 yqM+vi/OjhCN5kLsHxoS9YXhGlrRekvHrJ45cfwnDaGhO+rS/IXtxAXj9Gq+lG5IvVPe
 c1ku4CbETxMsqcVJf9WM9j84VAg+Mnj1aQXbWu2XPSnB7Tzt/4k4pIUc7q5PGP2cic8Q
 6Y8g/C5MBaTJgVYjcTmtsxOljEOkCWKQuD9XWBKdzZUFTYekKt8AJGszEUiA5YQc7o1W
 r1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769426180; x=1770030980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obXFGCM68Q3WZCZiCmwv7V2/EBxJWNkGk1LJ5RNuqEg=;
 b=ehZOUCXpbZuv8tVtz6qGWUcgyZ8g1ESdIYCLkCEKV5vp1jNbs/caON2/Cfo7SBxqn/
 lIKjOydufE9sSsljA2yA9em9P7njemvRy0WtExgM02xqrmV9+WWqsx6Fu2jyzHGEtJty
 n+2Fiyf/HbyAGH2MNMx1R/dSmrIw8nfs9e6R18EbL5RELakJCRQVcPIgY2Oo2fLWappx
 86Ejs+Ml9G0aCEy3zHPfOgziP3ePsWAqsSYAFsR2MZ9RRVzTG0CR0wzvLGrX984dsRwT
 jSQxoexlwwr3NsVt13tXj3OQVyBknZJ8Q0HfsQJl/vHaBUsAp+uTNNTHy/EJXnl07ZeH
 SwKg==
X-Gm-Message-State: AOJu0Yy1PHp1j20QaVH/B4E4vQUfWfxao2bCNPdSvYmYAr12dshrsRRP
 ypw/KF3LHKmFQIn50Jrh14fq2btUgEf21D/KGGvQl++GWh5IqalgRoN1VGHlJo4Zg11SZdyRuzL
 Vefm827l4g3aohO03P0lZXcPheP8MRKsI2+Uv2p982g==
X-Gm-Gg: AZuq6aJ4lAvkTfC+ZSsDwwkKFCKKKdQMbfeifk6phbvoYbNpGBv1ibh+huuK5oh9sH2
 eZqzQXD/NioJXlOLypTGHMYv9ygHJ6wRuz7ftl8DyubRa6XnDy8psA0VDuhQKeXUk4d+Dale7RQ
 F8GzXNFQqv+RYmqUvLdVGpQT3ZMeJIQIWeq1Pj3Gnkb+ut9dFJslXWr5xcAgsKhY2sgAyKFAAOH
 lkC7GKif9/381dC3VviDGIKLclU73hpyCO7Hb617jjqar4o+AvGTK7WchQnckqB8IUnFg==
X-Received: by 2002:a05:690c:e3e8:b0:788:1b67:d741 with SMTP id
 00721157ae682-7945a8270famr32443677b3.3.1769426179847; Mon, 26 Jan 2026
 03:16:19 -0800 (PST)
MIME-Version: 1.0
References: <20260125133239.0714449BAC1@orions-MacBook-Air.local>
In-Reply-To: <20260125133239.0714449BAC1@orions-MacBook-Air.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jan 2026 11:16:08 +0000
X-Gm-Features: AZwV_Qg0a-DXW9hyqel6SjpVE7afnh6MYtoZ-a-O0ZP6Cqjl6saHrBhCZM0ARyU
Message-ID: <CAFEAcA_=unxEk3Eqc7UirodO_pBveX0Vvx+OyBaaXS5a9QTMhA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rtl8139: Fix integer overflow in
 rtl8139_write_buffer
To: orionhubble@163.com
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Sun, 25 Jan 2026 at 14:03, orion cai <orion@orions-macbook-air.local> wrote:
> Yes, you're absolutely correct.

[...]

> You raise an excellent point.

[etc]

I would like to draw your attention to QEMU's policy about
the use of AI in code contributions, which is that we do not
accept them:

https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-content

Also, I would point out that your "test case" in your
revised patch:
 * does not even compile
 * tries to write to a register that I told you is read-only
 * fails because (unsurprisingly) it did not write the value it
   tried to write, before it even gets to what it wants to test

At this point it is not clear to me that there is a bug
here at all, as you have not demonstrated how this overflow
can ever happen in practice.

Finally, we would not likely consider this a CVE even if
there is an overflow possible in this calculation, because
the guest cannot use it to escape the VM and it does not
give the guest kernel any extra ability to corrupt memory
that it did not already have.

-- PMM


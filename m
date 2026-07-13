Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72AAC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFwD-0007RE-VC; Mon, 13 Jul 2026 08:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irtaza.hyder@10xengineers.ai>)
 id 1wjEzL-0002TT-JL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:38:19 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <irtaza.hyder@10xengineers.ai>)
 id 1wjEzJ-0001un-42
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:38:19 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso3917114b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783942694; cv=none;
 d=google.com; s=arc-20260327;
 b=h4i2bwjN8jSGurcCcfnasoC205Qn75ImYyQFcdTroBmZqGykeK9ekyZdF8TUWfDuCl
 WmJ/LAZ6pMeRvkvau/VtbNdI4XQdjjmspQWbqw669km/7rMgYbQ/jAhN5FC42Q1sN02i
 akayBtFE4aQNl/iEprnC6m2L5Q5zomhFn3xVvrBGuxDXGcHvVcIVFd15/MFXNm06+MJi
 jLTfoM+H3Em8fELXXb28dPMmW+iCJmtlzbs6cV6/kIqsbOSMH35nGP38lQ4lrx7slE8n
 QKzo/BB9xrk2o4XeRRmAtphl/BOD1nNWyCKBy28PFQXJijjcQcbYoMNLkUwrSKqQqohe
 E0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=NiKAw6irtwwmsd2CbefxZg5im2z8szg6KAI42nvYiYU=;
 fh=fvbnmjizOgOnkpIRitnn9jmpn1Kh//THoGFO1lx5zxw=;
 b=XB+t6shlpng9dCPk4450FOI9spi6kBVLI+1iCBO166vAfqNSRZVXMJ2cZYJozNWb/H
 DOYzOQvgVghL3HnW+x8ZiRZbXyC7E9ou+UsF5cby5lP5eJbPARsPbwjd3BeaZbYTfT1P
 vHUfSIO+PCzJ3g4fPAfbvnagwmjTFmr2F/bF7s8VyGMNU398nxW88cVCAR4DMwEBnbmy
 3yuNqN6YkDi00A7v08GPnxa5zgZCVdoFEr/hb+tLvZb5+v4wwsgaZ6GFwYAH1RlyZBLU
 gJVS3r++/Gu6B3m8U6Z1V2ZoK9Y4LOO+XUymY9tlwsYOQGGGxWFYvD7UIHhdq9gal9hg
 LhZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=10xengineers.ai; s=google; t=1783942694; x=1784547494; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NiKAw6irtwwmsd2CbefxZg5im2z8szg6KAI42nvYiYU=;
 b=oOkXx0IX1i5LBey6bizoFPre94qlRDgwfB351hyZsEk+OFU+smPNSET+9Fp26sujcc
 vDXnklXX+SdDl8f14ymNILI/AKraLiYFNdDcW1i+odhmMgJBq9zPRWtHE5JpbUOPuBMF
 v50GHttD1mZ2GgkItj21fUY3kRQG3kb3WNVF0FCetSBBUg9OP1Foaj4vZO7BKsYf7omV
 B6EEdmm2c9W8eMuqKR+LhbociuB6khLm+A/mbYJT8r2ExQBybrfmncifPyPZ1OHlT6Tk
 nEbE/8Q0OiRB2gjOvhuqTMu5XYAxKXvtB+iT5oxCxi/Bl0aGHvUaEkaC783WLTDzI0Sv
 rAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783942694; x=1784547494;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NiKAw6irtwwmsd2CbefxZg5im2z8szg6KAI42nvYiYU=;
 b=E75kX3VOmL64ikJNErZMFs8yN5hM5qdzQqJvIhd5+j2jyn1FE+/eWHvmF3U5+w57zj
 lx/xsUijhWz0z6X9BETm2FD2kluFQxhWwX8PRzmhvqHPDlwjcux/OwtPWRdcC2NTGM+L
 /fY+a+kjzlvfGsm47p5Pzzz6a7LcGJq/+6c4AREih84BRVV987HQnO67yN6v42nMqieo
 ymC+iYacG8CUsufO70y7EJy72RcsRDB5Ctw/brVKI2IaqOcO6wOf4EfJsA9BqS8FIogQ
 ZA/6LmPszM7ZDI2q4Vv4r/FLJN+LC2/Ee9RsWwTujXsyeLYAnLzFZON4OgUkRgL/YMpk
 zl8g==
X-Gm-Message-State: AOJu0Yz483V2QMWQgI8j26nXEHQ4IgNDPf4hDi19YzVhu4nCsExHx8UP
 M/FIkoPtCou5dsvfd22rmjQGqjXtjJVm/8Zo1sBTYcu78rYr9mdoaZfDQN0GNnt8FQmgy54VuO3
 CPjOEIqxRVPq7lccqrfPANa95EMKoXyL+WVFTfBZLtQW6HDm2Y9UOqH1iYw==
X-Gm-Gg: AfdE7ckG0is6/onAy2xct5ncbRxLuRYZa+6dO5D2ZJIvjEEq9OO6uKJwmdw4TrS373d
 474aKG0EJ4v+yftKgv8uog1sR5LEGFOM+yFN6lRCc2Qy2NUhXsnPPtqMKetyGI1/79bT0GRflqF
 VxvDwYb8bR5pw6l7co9lqzliVe4emrTzl/ZkXQfsgam0qUzHCW2i1j7hkrZcQXWsnBY3rlcWz36
 2L9LOKZ1+UHW/8s0JkLRMem0x1KxDCr/ONnNrveb3lgGmngwkUzdJiTfQQQXuQVz5wRmSjLlv9n
 9NRCIxCwVUaMykixesaW2RmhlQ6Diph9kwYFVedj6QlXSBkNrRM=
X-Received: by 2002:a05:6a00:1d26:b0:848:2f77:e2dc with SMTP id
 d2e1a72fcca58-848897a7592mr8356475b3a.69.1783942694260; Mon, 13 Jul 2026
 04:38:14 -0700 (PDT)
MIME-Version: 1.0
From: Irtaza Hyder <irtaza.hyder@10xengineers.ai>
Date: Mon, 13 Jul 2026 16:38:02 +0500
X-Gm-Features: AUfX_mwVaH9NGwMIgVozW5XuQGXtDnDs_ogKK1njoLhVWF0MQxTBrQqeopoXFjM
Message-ID: <CAPF+SGe9jOaGs1Mu=+_7CbDBKYAeELp+NEQJ1u5XmHADDo+dyQ@mail.gmail.com>
Subject: Questions in Blogpost (Coroutines in QEMU: The basics)
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com
Content-Type: multipart/alternative; boundary="000000000000975f7406567c8618"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=irtaza.hyder@10xengineers.ai; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Jul 2026 08:39:02 -0400
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

--000000000000975f7406567c8618
Content-Type: text/plain; charset="UTF-8"

Hi there, I was reviewing the coroutine blogpost (
https://blog.vmsplice.net/2014/01/coroutines-in-qemu-basics.html) and had a
few questions about the example given. It states in the blog that it makes
the code sequential, but aren't the co_* requests in `void coroutine_fn
say_hello` seperate callbacks we need to implement, still leading to
callback hell?

Moreover it is stated that coroutines have to be explicitly yielded or
terminated. In the example we are using blocking functions (send and
readline), so how are we defining explicit yielding in such functions? For
example let's say I am waiting on a data being to a Chardev Frontend,
perform some operation on it and then respond to the Frontend when I am
able to write, how would I write a qemu_coroutine to deal with this? Are
coroutines even the right approach to use for such a flow?

Any relevant code snippet or QEMU implementation would be great!
Regards,
Irtaza

--000000000000975f7406567c8618
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi there, I was reviewing the coroutine blogpost (<a href=
=3D"https://blog.vmsplice.net/2014/01/coroutines-in-qemu-basics.html">https=
://blog.vmsplice.net/2014/01/coroutines-in-qemu-basics.html</a>) and had a =
few questions about the example given. It states in the blog that it makes =
the code sequential, but aren&#39;t the co_* requests in `void coroutine_fn=
 say_hello` seperate callbacks we need to implement, still leading to callb=
ack hell?<br><br>Moreover it is stated that coroutines have to be explicitl=
y yielded or terminated. In the example we are using blocking functions (se=
nd and readline), so how are we defining explicit yielding in such function=
s? For example let&#39;s say I am waiting on a data being to a Chardev Fron=
tend, perform some operation on it and then respond to the Frontend when I =
am able to write, how would I write a qemu_coroutine to deal with this? Are=
 coroutines even the right approach to use for such a flow?<br><br>Any rele=
vant code snippet or QEMU implementation would be great!<br>Regards,<br>Irt=
aza<br></div>

--000000000000975f7406567c8618--


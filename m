Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229DECD6E49
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 15:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTLdW-0007Xd-23; Sat, 30 May 2026 11:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wTLdT-0007Wm-MX
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:30:03 -0400
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wTLdR-0000O4-Hn
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:30:03 -0400
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-13721dfd471so7352010c88.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 08:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780154999; cv=none;
 d=google.com; s=arc-20240605;
 b=BaUMShS8t3cLGie9Mr365nWhoQ5l6ymspyhZTrZt5cE89zJWrFb57zFGm84Ntcc5K1
 BgGltwU92tQ78D2s1ALmVASHKPxYkABgDBCS+yKmopHqfYKEyD8OBxpyJ6OPcJw4YNET
 /AGzFI3uoeM+ikOci1K3YqTYmlk1g7iUlYSJjmR1pg/PrCHo/Towzkq8TsRcuSmXuyek
 /5yvFgg3Q1xyTYXn5a9gX1agfZUhrDUUjbZ78W+LJJHiLaYsNpGfoXpyglDjUhowCev5
 ye8Kh5HPq/ydYjZI6IWiFgws6GfOdp5SZa3FSMDSFJWJnEPCSzPK0IhIk+CLAGz+zDQr
 EX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IbH9HYSgyWB4an40BXdBnztx4w44XvAlnVNXhLAMqEM=;
 fh=Sh5V2wZoPmZcQTeMKGPa6OgJ9YbA/Nm7TTNJwX99Vxo=;
 b=bP+pTzHF99TMAN2ha98XL2I0VvvXWlSki8y0wSQGwOqikYGLOE/WzyrJGEO5b9xDPP
 dGpZwxEFUx9jj/lPZFdFstcsdAZ6+lNWOICS+hNwyWBZmOBVxXljGv65IejJt6aJMwpZ
 0Z5bzaQpf0qQcbsQpBOC7ktO4lHKnMDiArZUweWym8WSs/dz7zSbnaYzqpNvc5ZkOcVZ
 aKLYVLGW4gjT412fcbf9jt55Aap1D5q5IAXch5j8tBf6ZlrfLkKuxtvG8YxM8F9Rr835
 25aa/X24ed57eMbqe15hLlPlgh9/23auTBTNWZaF8mnXsotJN2/Bpx//TycsO0LrPyy4
 mJ6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780154999; x=1780759799; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IbH9HYSgyWB4an40BXdBnztx4w44XvAlnVNXhLAMqEM=;
 b=ExSGHdR+d4z3ib9HuEl5ei+TpUuVdXPWcaL2DdzE79GJQBYPoJF3SCrfGhF+DlMiLk
 XZ94rhMH3ro/UFQ7/LRYn70NttHyuYiescteXhP70vp1wA+63ut2Hb3i7p+k6F2lFRdK
 YL5IpKsORbyFEyW7/N/Fv46GhcDQZA6+o8vmiThsG8ig0hU4Ubnf3P0ifOjtI7oiPIJZ
 GzNiiQk1ydZQWrQ1RQGckArGopGk8NkFAIuERV/zrft4O6h1QGfQ22BrVZQPoq/rMNDX
 vKU2TGk3O4V/Rhl+fNzadF8o7RyzKGg4cg1qWIA+usOxajlumsGi9OfT6jMy54SOikax
 3UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780154999; x=1780759799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbH9HYSgyWB4an40BXdBnztx4w44XvAlnVNXhLAMqEM=;
 b=GTad5DC1tDb9zJZ0TalysLbim1z8gwc73GQ4uu8GsbtFkKeX5Sllfj88gtnLBUoDlC
 qucxk3DCI4g3glirg7cPKeiijOHmIFb4yJxBJKAs/BzEWitPwCDPdwdzTlF2Kb4U+o9a
 qeD75oxWW4rEq3FfqxLlkTZ3TzVUQyugWSRQfHYTjBzK+UC9dfk/p5XguuaWARPTSAqV
 K06mCequ05SUeZ3WH/ii+EMvH3HxKtwDxEHZF+LLqcX9BGuBDQFRcKkPiAVHyAKd8gJ8
 yLasFGWguF2WBdQubXfMTw2AwMXoLWlU5GXA7L/cct97RSfpHs6o5ga6eYqFoyrJ/khz
 Zitw==
X-Gm-Message-State: AOJu0Yz/XyvcxF+fkI/eXLv1ivRifCpGQEb4nzH612rGFcABiuDifxg6
 xabUc5B0xvgWJwymLtx4i6GZ4mWIT0XElLRYei9Hx4uxiTdeLjlvreUIoobExkpWJMTQOIS8Zf4
 U68v12ywRP/NwC8P/DHUrRsRkUebhpzY=
X-Gm-Gg: Acq92OHWzNBHqev9KAjwetep13qWN6aZzfmbmBK2uxhM6stv5YLL1Gj/5GwW6eTywqB
 s5lCxtJQ8QZzSo0a7NQV2O8gmCSXaSt/cEe0ggn82qUJLYl2IQtBLOKSF6J6DHoVokZbo1vJo7x
 wigCNiGevQGzu/BT/9r7YlANTrs421k9OmGb32wi6n7g/f39kHHRCk9OW4lU2XgiNohnUPTQQBh
 jZ/W0wDbcE1yXrbCUVvX07XLrZ7lRkzn57kYr7RG4D7eyMAmTrSorLE46+RqqMzhIdbWAdbin/J
 wxIYvF5iaCrFiZaM1A==
X-Received: by 2002:a05:7022:622:b0:137:c0a7:8d07 with SMTP id
 a92af1059eb24-137d426caccmr1701399c88.39.1780154998745; Sat, 30 May 2026
 08:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <CALk1091JwDs9SGCydB2Q-4BunCbo=VEa429bmRjmQw4SwZrULg@mail.gmail.com>
 <cac9af29-5628-4490-a1f4-d84ed3c190e0@gmx.de>
In-Reply-To: <cac9af29-5628-4490-a1f4-d84ed3c190e0@gmx.de>
From: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
Date: Sat, 30 May 2026 16:29:46 +0100
X-Gm-Features: AVHnY4LsiKXr81F8JATFtvsKgozPkG8ou5FGuP0WwUvywyZF1-GFkBqNXDHKx-s
Message-ID: <CALk10906dGjE=gmO=wr7Cea2VQLbnhsygBbgaESuqmw+YYBCAA@mail.gmail.com>
Subject: Re: [QUESTION] - SCSI tape boot
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000586d3406530aa21b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=emmanuelugwu121@gmail.com; helo=mail-dl1-x1229.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000586d3406530aa21b
Content-Type: text/plain; charset="UTF-8"

Ok thanks for the feedback. I'll keep you posted on the progress.

Emmanuel

--000000000000586d3406530aa21b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><div>Ok thanks for the feedback. I&#39;l=
l keep you posted on the=C2=A0progress.</div><div dir=3D"auto"><br></div><d=
iv data-smartmail=3D"gmail_signature" dir=3D"auto">Emmanuel</div></div>
</div>

--000000000000586d3406530aa21b--


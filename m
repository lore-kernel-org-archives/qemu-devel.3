Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74361CF6C1B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 09:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPnf-0004yF-EE; Wed, 07 Jan 2026 04:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdPnX-0004xo-PU
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:25:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdPnV-0000Pq-HN
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:25:46 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so18127855e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 01:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767777943; x=1768382743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je7EhsBvdhIN5eIEAnez63qUunUFd+qS+5QonGAu4wo=;
 b=nvyNTo7e2SgbR+48HiNbp6xb3AIsxIt/M6eKfSxCBZhh3OiV54538T+LKbm1fIOlOW
 5Cwsp+8gIFBHv3nb75ECP6J5I6n4OeGFZ5YSAnvZZOSflb1t8Q2Gybt3Nc1NrvuohAkq
 17vXgCECi1iQze21UkLPbzwvWaql6cufK9Qm7aE0GDd6+1MD51zyyc5KBXfOYuPr/9i0
 oiasyncxuZDYySaGvRtnObPA6YdhNxJx9QtH1MSvVzrajHX9cktlgq5zANl/tF6UuIQH
 Djr8XC+E/ItHrlHe+d93yhq45UEkh6Sfoej9hUPpndVZzzsL8KPxnq9+ulTaLKCfsMHY
 9BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767777943; x=1768382743;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Je7EhsBvdhIN5eIEAnez63qUunUFd+qS+5QonGAu4wo=;
 b=RiGVma15ZEmnneGK3zwNIgeJ9JDztkIACZanVYQ1dStP3a+wR/GU64OTEOLjD9Buk8
 uIwkalraBBAsgNTY1/d3Bx5uG5EddVNr907vgh/tvLJQ6f6rv8pF84PMYo97ee2UXf9q
 3ml7y4TIURW0iw+h4gKw2TfueAkYHmIoguuVU0hqS4gApTmKa527sTPHSDzmN3BuSodz
 B5YPwtkyqZilyTFoeWu3itwcRpvwBGwnAzINE2rThWt90wP9HsY7BKtZ0S8x+l/3gWIk
 cyKO9bL4r06LlLdUO+RsMwWQryLZr3cKhcaMve7AzWSSPd2j+2J7c1Apx436SfNSfc0L
 1IwQ==
X-Gm-Message-State: AOJu0YzTCBc9McVROh1h0l0hFSHfXzizdVhUWANAL/Re/bNeTFpc2rWX
 whF9wBhqDLiJbXQE5Is9QEpE32xjdtALdogEJKawJvHoaikGPQ7pf9cfcs9yZIC4WW8=
X-Gm-Gg: AY/fxX6n0ap5ajs+gtVC4utVVXuaxOJ2RiT2Fcx+3khMzrNlCEmkG5D47takGVG1M5K
 o9s4MzNZmMNBvF0M7oCcpjoMJI+Le5ehPtuWNFTtiYbez8cpCiniZkViNyux65Ivf0oTyy55h9P
 ZGFMh8ux0p0zT5NNw18CSa2QqoSPbXJ+hgzExUde7caFQNhZyl+9isqgVNZaqWs+oYtNqF7jWv/
 I5QGWzDPtT4HAbQwam8FOtBKn85LQTCIB9FswCh+E4RMU1+yMxS3YuS5Jy86MOTBJBg9ZuQql/z
 8Tf213d0F4sPuhDY8RQKfuvMwzP1DTJKWYpUkbyTxuWJxujD2xXXFF+gQ6gkNSCNCMSaW9EfRRW
 fe9/QCCzoTklDHTbspRUQEUEUTUJihgi9wRx0bModPZa9ssUmcRaW6ZRYHmaHnO858aE2rPP6bh
 RzaO6XEE4fd98=
X-Google-Smtp-Source: AGHT+IEz3rOurTUKvL1xIgIpF4X/aMzCXljazzGuN6wKN8vMIctd+t6nllLIE2CeyP+yp0b6GAiyPA==
X-Received: by 2002:a05:600c:3110:b0:479:3a86:dc1a with SMTP id
 5b1f17b1804b1-47d84b41176mr18436075e9.36.1767777942711; 
 Wed, 07 Jan 2026 01:25:42 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f70bc4fsm85811945e9.15.2026.01.07.01.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 01:25:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 455E85F88E;
 Wed, 07 Jan 2026 09:25:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests/functional/qemu_test/testcase: Fix mismatched
 quotations
In-Reply-To: <20260106220319.74785-1-yodel.eldar@yodel.dev> (Yodel Eldar's
 message of "Tue, 6 Jan 2026 16:03:19 -0600")
References: <20260106220319.74785-1-yodel.eldar@yodel.dev>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Wed, 07 Jan 2026 09:25:41 +0000
Message-ID: <87ms2pai5m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Yodel Eldar <yodel.eldar@yodel.dev> writes:

> A debug string incorrectly mixes single-quotes with double-quotes,
> causing the variable within to be treated as a literal. Fix it.
>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/functional/qemu_test/testcase.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qe=
mu_test/testcase.py
> index 58f2740100..ff86c9d187 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -349,7 +349,7 @@ def require_netdev(self, netdevname):
>          helptxt =3D run([self.qemu_bin, '-M', 'none', '-netdev', 'help'],
>                        capture_output=3DTrue, check=3DTrue, encoding=3D'u=
tf8').stdout
>          if helptxt.find('\n' + netdevname + '\n') < 0:
> -            self.skipTest('no support for " + netdevname + " networking')
> +            self.skipTest('no support for ' + netdevname + ' networking')
>=20=20
>      def require_device(self, devicename):
>          helptxt =3D run([self.qemu_bin, '-M', 'none', '-device', 'help'],

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


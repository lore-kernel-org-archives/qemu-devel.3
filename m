Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB81DC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1semdL-00038Q-2R; Thu, 15 Aug 2024 22:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1semdG-00037U-2W
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:24:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1semdE-0004vh-JF
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:24:01 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20202df1c2fso4258105ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723775039; x=1724379839; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2Kq7vgxrD0V1bNg0gZMrLJZijYM6ZFsEKzjQvvZ3Ww=;
 b=CZjrefjEdnn682KGixO8YIU0CA3A6mzWgEMRY2mMRpqpXdPy59oTWRpSWQMkp0vZZ7
 /QSSdfwc4G1OrHoxOyGNnzkZhfowREgy+TG9pql6jHkj5gkPBb2HmyhlJkGpei56g3p0
 dHfQh71vYayh527i+osxclDWLDX81onm2mkL3P+o4jFHxloL/w6rnhX1HLbXYNPwbPSf
 S+nnoUdENxCYVhFqLtWiAWaoFrKzgSTvXX0yev1ur7VIPlEF3Ub1CN5TvDHykiyqfu0l
 q4cnpS1TYxx1SeMuOEm3QPJABGMG8JVV/1STxWPYmtgz3lR2svBa7Ii3KagU06NX6H2g
 xM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723775039; x=1724379839;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z2Kq7vgxrD0V1bNg0gZMrLJZijYM6ZFsEKzjQvvZ3Ww=;
 b=obJOY/aCTeyk+z/MBlrN6FJ2nD5U96cOiaEGwGu5cwjPi1cl4Xa8gMX6j+4swfe8zJ
 pHR8H2RIqM6AacUWxrxEocenArhYR4vz6CZDF6zDSi/Goq+rc0WdNZDspsvh4KiZoYio
 GXOJ212OrklCc8kFW1250rHYDxT7i5zDlA4xto5WxqjxFvlsdRnD67DBz/mLlGb9ykWm
 XG3A0Ccsheiwbp/1Lo8CEWuHEmnCZBq4TYdxb2RvnL/o3rHV60/kEUjahlsCZWDtFv4V
 p+7Zb4yl7hK4bMk3wOnOJAShajTb9SMF2waNiq0GZS1AHssRXgFoPj/jmKISZOIvl7n6
 JL3A==
X-Gm-Message-State: AOJu0Yw/EWnu0AKopjfA4xZ2SYjyzV4Q/xZjAUcQKsmKPrXCsgrMG8Bo
 /ygRu606UdLihzJnEuilWvp/a1M60/ivp+V9QqFd3TYtfS3ftX3/
X-Google-Smtp-Source: AGHT+IEsAubLiJ6rGKZ2ZyOETuW6hbEhG1X8nqHWeTJqoHXe/vryF6hYYMYTmwi3WGilEkmO2HBy0Q==
X-Received: by 2002:a17:902:e549:b0:1fd:8b77:998e with SMTP id
 d9443c01a7336-202062baefamr16151095ad.29.1723775038507; 
 Thu, 15 Aug 2024 19:23:58 -0700 (PDT)
Received: from localhost ([1.145.119.203]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f031cbfdsm16398435ad.114.2024.08.15.19.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 19:23:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Aug 2024 12:23:50 +1000
Message-Id: <D3GZ90ORAGBC.EPV2C5TYYGKG@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "John
 Snow" <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Michael Tokarev" <mjt@tls.msk.ru>
Subject: Re: [RFC PATCH 0/2] async: rework async event API for replay
X-Mailer: aerc 0.18.2
References: <20240815132838.615330-1-npiggin@gmail.com>
 <20240815113029-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240815113029-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri Aug 16, 2024 at 1:30 AM AEST, Michael S. Tsirkin wrote:
> On Thu, Aug 15, 2024 at 11:28:35PM +1000, Nicholas Piggin wrote:
> > Continuing the conversation from the thread about record/replay
> > virtio fix. Here is a sketch of how we could improve the naming
> > convention so users of bh don't have to know about record/replay.
> >=20
> > Thanks,
> > Nick
>
> The API looks ok to me.

Thanks for taking a look. In that case let's go with the fixes for
now so we have rr regression tests in a bit better state, and I will
resend for 9.2.

Thanks,
Nick


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77292C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 17:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBdR4-0007y8-24; Sun, 04 May 2025 13:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <superbisquit@gmail.com>)
 id 1uBdR2-0007xq-9y; Sun, 04 May 2025 13:47:28 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <superbisquit@gmail.com>)
 id 1uBdR0-0003fg-PR; Sun, 04 May 2025 13:47:28 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6f2b05f87bcso40876196d6.3; 
 Sun, 04 May 2025 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746380844; x=1746985644; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4dYAADhgwW3fYRztKvahTwDS/ZOGnCHWbBU1SjJpjl8=;
 b=SlbM8SubKur5j2U+mlvkVdFUI6uOPILaDtOt2BPcMWG3qovdQ4eRrmku62xpxIdjuR
 SLTwpA2aBAqW6loYHt/Z6p+4v55ZjjxhNJpI+Vt2yCaVOHUHBAUkI3HON+xUZAPgN16f
 xNFye3Es2HLCm0N05TrvxVsAPtC2mb5qWsfOGHzCelTUVFlZMf2AXHbc3eqlSsIDfd9x
 y0XvvrbMP10dVTEif/NQt9gNplsY/2ksm37BMqwvyMCwlchfVsDFJOKptuYNNuULKvWn
 lso8wYNK1LZUu/PMt1RO9OqqpzJEsvS9R64mytttoheBGPSuhfV2kHK5cpV9PEHegWpv
 unWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746380844; x=1746985644;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4dYAADhgwW3fYRztKvahTwDS/ZOGnCHWbBU1SjJpjl8=;
 b=QIFI7Sr5unoEPkZF0etvFyoSGMdyhQq58sxokB5QJAuxb5n+PNi5o39HUo5MNLWklW
 XZBleIhVVGUGjMZdyjOfhRTTsu0EnFrP/h+CenYLJEgoQGSA4cvCw3yjdxch/RI6fok5
 pE4k4NIZCqUJCZChm8Hpc8JOlNeuaEEo/77szRqlIvRccadvYSjWkt4CypCYJv7iFcqA
 d3bFtTOBfZwP/HzvtvXLOyAu2GYWUXqpSIGXPJw0m3vXSrv9APhU/n5iWMlTaKDoBE0s
 aYTq1SOSbDa2gsVJQzQBYaK4GkX9E/QNHPANsw4ePVO0BWHNpwEJiKu3tBw5UkYWINqP
 tNIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPyvBQqq8QeQe1VIMagBeRMvmGIrLkNqEUCCaLBSDthRXaMnd0KbCCmvscBMBGm6IuTQbEh9LRSdOq@nongnu.org,
 AJvYcCW0KezQPbeU1mRVxnsJMZoPieW0NLF9v5lIDdeB+5Qs8N15hOQTG8F+55B/aKaZV7aqY7hMYTKTczE=@nongnu.org
X-Gm-Message-State: AOJu0Yzhc/gmuNuy8Vq6dSAbcvZ8KRSJFPSzgaz2regvZ9VGjbeya4Y8
 nh4gq6iFPES852q05HrkqvOJsfGPv6lZRLE4UQxDl3p5qzbIOUpMNaH0sQCFVhyy5TiAsMUhx9e
 2wHIQkLoAVltRusD1WqQYD+WSKn52hw==
X-Gm-Gg: ASbGncsS7DxviYZUzhecW0A5DfNJ/KBPCNYn+HFv4/45k9ZMyAkeb1vwxmgJjXv3ahB
 44vbZVi69k9+un8UwjJGTQGXxxoyIilFL6K+6ea6wQ0fUstJpSQUYJUp48Ueq5daoFbgtiUjdp+
 qCuclNexEZ32ykR/EFCTcRW51mIpqvEtWGEvmcdXzkgdFpYcADILZ8ToQ=
X-Google-Smtp-Source: AGHT+IG1Rlm+9CNMLofAKb5YYd+o2SuwFJakdanrzmnqr8O8X0ruFp/ta204TONuQmFPpehYdB6ckU8g4NCuFuLSLqI=
X-Received: by 2002:ad4:5ae4:0:b0:6f4:b8eb:4815 with SMTP id
 6a1803df08f44-6f528afd6e3mr81036916d6.0.1746380844255; Sun, 04 May 2025
 10:47:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:4ae6:0:b0:6ee:cff0:2fca with HTTP; Sun, 4 May 2025
 10:47:23 -0700 (PDT)
From: Joe Nosay <superbisquit@gmail.com>
Date: Sun, 4 May 2025 13:47:23 -0400
X-Gm-Features: ATxdqUFRFYR-727Pau3afXjlKB4yJzA7qMV37IM11EGaKA9YkegU5lT4gmuoKOY
Message-ID: <CA+WntOvAy5W-NOsJ2HJbb642xK5VVgc_HvU8Oac5KhBMSm_LxQ@mail.gmail.com>
Subject: Introduction of an idea and the current work to date on brltty for
 ppc64
To: Nathan Whitehorn <nwhitehorn@freebsd.org>,
 Alexey Dokuchaev <danfe@freebsd.org>, qemu-ppc@nongnu.org, 
 qemu-devel <qemu-devel@nongnu.org>,
 FreeBSD PowerPC ML <freebsd-ppc@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000dd4f7e063452f9ca"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=superbisquit@gmail.com; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000dd4f7e063452f9ca
Content-Type: text/plain; charset="UTF-8"

https://freebsdgoogledeveloper.blogspot.com/2025/05/bhyve-and-powervm-solutions.html

--000000000000dd4f7e063452f9ca
Content-Type: text/html; charset="UTF-8"

<a href="https://freebsdgoogledeveloper.blogspot.com/2025/05/bhyve-and-powervm-solutions.html">https://freebsdgoogledeveloper.blogspot.com/2025/05/bhyve-and-powervm-solutions.html</a>

--000000000000dd4f7e063452f9ca--


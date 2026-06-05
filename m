Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A254CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 20:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVakq-00043E-Ih; Fri, 05 Jun 2026 16:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wVakp-00042m-8B
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 16:02:55 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wVakn-0005dA-OW
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 16:02:54 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8ccea53f35cso25310276d6.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 13:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689772; cv=none;
 d=google.com; s=arc-20240605;
 b=KlmRgEBCH9qTmKhrZKM3bO5dpoadLYhByr0dvX8GrOiXBE5G2RWIZB69655fB8cs5T
 G411F7I5SvGB0T7uus63sDcB70VTwXWSEoSJBYZBvaS5E6OToiGMSQm8Xwo7qMdyE4y6
 BfEHH3IWbQ1xOWu3MoVSIjUiQe4IuHD4a9i9yJ9kkEceD4eG/PrXxHtdk31QruSHbWVE
 OC05XUfomjVBfk3sLMwFVcTXN9GSXUklFDcUnighSCsM4FVaHCQl39MRLZGx+rNMfqlS
 Lo02YgGTF4muDluWROSpmMVrCABF8h8uPSrea6QQGN/MaCisacSSA2nXcH0llcDVzB2X
 n0XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ywcAtAEyl9pFL932LM35eec5EOwbUUcL6zX3ilaEp7A=;
 fh=MmIu1MQUumM9oZVb9Eyp125Ez4MXIJgT8b7dzoY8x8E=;
 b=Wyq9k/rOodMA3B0vv8Y9whyGnMFTSR8uE5yuoTz9gJcVXIgoUYyqxap8neVrE0V9Ym
 DCNNVs0yPmms5lS8QhI4pgUFbhafuT9kP7WTCGMNCRnxkgWI7422XA7rBGdRZFrDailY
 gnVhoCNDwGKMKfxsNt/FfyeEwtouWhC0ZBVgKizZx8Espdp6nzsbXFW2coSbuJ2/8pZV
 rh7uOz/3VpHeh5Srx11AjeLo1pBUhISLdMjzZS1snIL1HE4pKtV1PZXLb6T79mUziBR3
 ahCrZuuvCl9iMJT72bse3cobp31sYYfp6Q73Ci6mqba7LZMf+zZgLKOwq3GeEs61FiG7
 yB1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780689772; x=1781294572; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ywcAtAEyl9pFL932LM35eec5EOwbUUcL6zX3ilaEp7A=;
 b=H2KIy+jTRnaE49/JWsmtMQTt5318Jryu3TiKlItH+qm0SQxebGywsHS8MvHZ262ejs
 X5HkZ6dIB7VNdMVIZ37hvCw9sP0K90lqyIpVG3YiYVfFtqPCM641zVa51MQtwqAUKbNJ
 w/eJMXOenlIBVEUMhmd1+0xBbhH5TDs86aBKI3gLGVSnaPMcALtitBnNxyTn9jF9b5gW
 W3FlQlZnrB87cVFpmRgWYdbCx5fsmjUP2KcArsHFSfUoHI0/etAO7WBuobf+gGWjKzpR
 9UvNioyBHPcMSLCbXC/v6K1mnk0imI/sxC1bEI0GZYtQXLzaKjEqv/Po2eOAN9YenycZ
 y33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780689772; x=1781294572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywcAtAEyl9pFL932LM35eec5EOwbUUcL6zX3ilaEp7A=;
 b=P3yH3cysWzilZerGfQImbvl+p0kZxS3wIpHmLgPZR3WyfH8q/TKb1ID7JZsffKigK1
 Z+DRzIZ0l0khbW2EQ1wXa5jkAr3hkSFIe1s3KCfpduW8EzQQNyC5+QsTZ4jdbti89Vlm
 mlKH7SHPsPmedZxwqru+GbidAHbPmGkJ8bV0/OWFC/HnhyrF7T3/0/NuPWzqJyqraAy3
 z4x90J9BCE3iiXfk/K6XnbC0zfg4L+mMgmi3s/BbmQNge1j5K6hoVEjtj4Qoer+4akaN
 7IPlo90L/JpN2rtXyC4uaJX93bVjmPnVj5yqW/SBQliIKv7XTinh8MbzkC2/FtPjndeH
 Mbpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ97tHAosQ7tlJ3MDRJQz2y1LCNUgWTZMx+trneRmaS60cUC4Hbn9IuyhB3zTGUWWDWfpuO/6suobJL8@nongnu.org
X-Gm-Message-State: AOJu0YwsJUqr7ekWCMJdo7PQN5tMkcDX5k5uiUm6P0lKERQWnZTeHNXs
 7fFGR0x5mFix3Wk5MSSnFeMN1dAU//oaf3HC3JC2xYxXtO1NLO9B/KdYLTl4upxV3SJwIc7/dqB
 Dk7UOEYOCElKZcDPRUjyViOuFlop/9Kg=
X-Gm-Gg: Acq92OECd0HocbXzsrmZwrpD1jGCzk65k7zGOWIRCz3dIMebDdWC0bi8RyZMQgg9RxF
 ip2fr5SoECR+iV7+hKimY8iWXbu4aDU+7H4EassH1YLQ9ZC7/UFv06ioXXvh5r/BzpEwtbfI2c4
 HBL0DG2N0nAPRlczlxklY6sh+PzPYizYXykz4At0B8u9UETV9X5SRZyIGFzyhhkdBRfib48d2+m
 UabbwRRpMXxpd47ORa3Z/eC05ojQL9Zo7txYjf523lhJrrzeFOhqFjyqoTBedYLdgWQYk5pewjr
 66vYBbO0oTJcJOP2qtz4URLmHZldZz0rWjFT2SFrj1EQ81bzUKxl
X-Received: by 2002:a05:6214:301a:b0:8cc:f0e0:f90b with SMTP id
 6a1803df08f44-8cee629be9emr81462956d6.40.1780689772366; Fri, 05 Jun 2026
 13:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260528202639.4097815-1-Quan.Sun@windriver.com>
 <DIV636CRY5LQ.2KV03HIYY2WKI@bootlin.com>
 <be287797-1941-4afa-8aef-b015ca194476@windriver.com>
 <CANNYZj8gMc8PdWMse=g1J7goZC5Ga=nwN5hA+uX02-G+LNHEwQ@mail.gmail.com>
 <7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org>
 <3bde2ef8-5565-4495-9904-dd3db839de1d@windriver.com>
 <CANNYZj8St8Foj7C1RZnGPFmzsAFyCEjvXVZa9DD5Wv6YQ8u1TQ@mail.gmail.com>
 <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com> <aiKEeH2UZgdePzjX@redhat.com>
 <CANNYZj-x8efUVB9Z5d2T9Ye4so6v3zamHVTexRCGmzOmkB6EuA@mail.gmail.com>
 <dd1729c6-f6e8-4790-b166-a635e34b3b1c@rsg.ci.i.u-tokyo.ac.jp>
 <CANNYZj9X4bSFxOMapsL7fB=q-GEO6oJMtwz3oPkfcX1ww1oaMw@mail.gmail.com>
In-Reply-To: <CANNYZj9X4bSFxOMapsL7fB=q-GEO6oJMtwz3oPkfcX1ww1oaMw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 5 Jun 2026 22:02:41 +0200
X-Gm-Features: AVVi8Cfs3au5-NDzQCZguCu1XY0fAQjTeaRd1stlWbHQ-JO-NalovsQhQrFFOt8
Message-ID: <CANNYZj9ykQ=6e_UKdTD=pc7Oj6wNp7BE5ZLaj6nbNq500CVHRA@mail.gmail.com>
Subject: Re: ui: Regression calling eglInitialize() since v11.0.0
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com, 
 QEMU Developers <qemu-devel@nongnu.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=alex.kanavin@gmail.com; helo=mail-qv1-xf35.google.com
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

On Fri, 5 Jun 2026 at 17:17, Alexander Kanavin <alex.kanavin@gmail.com> wrote:
> Please note the comment above about the environment - it is x11
> without wayland, provided by xtigervnc.

...

> To me it seems like forcing EGL triggers those wayland code paths
> where the crash happens.

I think I found a way to trigger this in a regular wayland desktop
(with XWayland). You need to unset WAYLAND_DISPLAY:

$ WAYLAND_DISPLAY= ../bin/qemu-system-x86_64 -display sdl,gl=on
Segmentation fault         WAYLAND_DISPLAY= ../bin/qemu-system-x86_64
-display sdl,gl=on

Alex


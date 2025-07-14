Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAACC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGuU-0005YZ-5P; Mon, 14 Jul 2025 06:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubGto-0004ea-Ed
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:59:08 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubGtl-0000Ob-K8
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:59:08 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so8661283a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752490742; x=1753095542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMCmcbuCKLVos6OaO5KzhJUCYu/ekY28SJCk7fUDf60=;
 b=faVGjmGeOjEXwo0nVFV6NtxBdlffXurjqssXZKGraNT7dfIp4IW3rlowVyNRk/XdQu
 IIXuGQqmYB7brmspNM5NonQZtrA54V0tfZ0gPAJ5WKNzSv7k5WDtbVL8elXLAt4TiPHb
 9G64/2H0FgrRUB86PnpG/zJww1idAd3UNPvdTzP6dAa9YokT6bwFCbwshTs4pfhiv2Vg
 QivEOEPA9Fh3oNRuKeYAJUBxcdo14/nH2//eC706prs0msmSgDzIiv/Ac7HGIsIpbjRo
 60drAd8fLkr+6jIFQOjC1o2AxsQkRWz/qLNxeHWNYNTKj4dKVhBbB0bEKiLNCHM0Qjwj
 2Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752490742; x=1753095542;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DMCmcbuCKLVos6OaO5KzhJUCYu/ekY28SJCk7fUDf60=;
 b=W+L6fEaD04a9WtgLZLBQpDzziS8C7WuUaHW3LftdYUXA0Pcmw4HBZx0H/OxpGidA76
 FsPOz2lotIKshNzTCspcp0uqb4HM+yVtGv76Vjm4y8IA9T6IUW/WLKa6YPe/TpvytarA
 kTDIsS7YjNfoEpcU5g0KX4eypMuXMyem4hFXFrNju9hjVaSYbWnJ8ep0vV36GAAZrQ8N
 o+3jGk5gEZ1DX3WNZ2n5oQAjXKzi+bE0Z8BRY64ucmrslQy7gSk/cPPZeQkSw1n6D14S
 08MnZYviVC6BZp2tq6GONZIO0dRP+2EiPaL9xTzM069q3gwot5v8zAuObi8X5ekKeOlo
 AbKw==
X-Gm-Message-State: AOJu0Yxa6T7syQRUzLJpKO+YheZHdSVUpBLTSW730smFz/jNJarxp2lv
 fhfuf8z06eEayxi0mIkAeatPiX/uUMyf28luO9ZEws7qlHViXty+fcVVK9saaP0FG78=
X-Gm-Gg: ASbGncuqDETS/Lr8PbpupIk9EfsRUBmP0F86ptCdwtYnoFBW0VskI2SpdMqIpkNUzZ8
 SGhMk39xdR6mpGB/azqxj4IDzYhtcTwUDohPsqkD3imuL8dI2X216Clo3dUSlvIdqB7mBf2qbJ7
 N/vfrmk/3q0j5PNgyJ4wn1IBHcJagAMyHLRuyn/mpllgAhJGoqH3xG4ZB81jkNVK5zjHWTcKFF5
 HezKV9sQkgRXFBZueexWwUUhGBUXS2arqEQUkR/FeIF+3s2OhzM5ClZMZPDR6Wc9NWdT0mxL2gE
 JOpJz+xpyAeFk1OUFnicEpyLfV6tzN9XI+wjXTAt5S3+mpdnW0A4/RbJg7lVBiYmWIqHT5s3JVK
 Qc+TEn9ubfQr+Xz7StLkA7RI=
X-Google-Smtp-Source: AGHT+IGSD7ogTkKlOeWFG5xOo0gotygW1eBUKOIzlWNTednm/ypEhvSB7a1vwKhtEpnLE5MDvy8U+g==
X-Received: by 2002:a17:907:fdca:b0:ae1:1a30:6682 with SMTP id
 a640c23a62f3a-ae6fca47eafmr1532296866b.18.1752490742132; 
 Mon, 14 Jul 2025 03:59:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7eead7csm812794166b.62.2025.07.14.03.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 03:59:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 97D235F78F;
 Mon, 14 Jul 2025 11:59:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: unisono@quyllur.org
Cc: qemu-devel@nongnu.org,  atar4qemu@gmail.com,  laurent@vivier.eu,
 mark.cave-ayland@ilande.co.uk,  philmd@linaro.org
Subject: Re: [PATCH v2 0/3] Reformatted Sparc GDB XML patches.
In-Reply-To: <20250711155141.62916-1-unisono@quyllur.org>
 (unisono@quyllur.org's message of "Fri, 11 Jul 2025 10:51:38 -0500")
References: <20250711155141.62916-1-unisono@quyllur.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 14 Jul 2025 11:59:00 +0100
Message-ID: <87h5zf11jf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

unisono@quyllur.org writes:

> From: Rot127 <unisono@quyllur.org>
>
> Adds Sparc XML register files from GDB.
<snip>
>   Adds the GDB register XML files for Sparc32.
>   Assign the GDB register XML files of Sparc64 to Sparc32plus.

I'm holding of these two until I can get sparc32-linux-user tested. Our
coverage isn't currently great due to not having cross compilers. For
sparc32plus specifically is the sparc64 xml going to work given it is
using a 32 bit ABI.

What testing have you done with these two?

>
>  configs/targets/sparc-linux-user.mak       |  1 +
>  configs/targets/sparc-softmmu.mak          |  1 +
>  configs/targets/sparc32plus-linux-user.mak |  1 +
>  configs/targets/sparc64-linux-user.mak     |  1 +
>  configs/targets/sparc64-softmmu.mak        |  1 +
>  gdb-xml/sparc32-core.xml                   | 84 ++++++++++++++++++
>  gdb-xml/sparc64-core.xml                   | 99 ++++++++++++++++++++++
>  target/sparc/cpu.c                         |  2 +
>  8 files changed, 190 insertions(+)
>  create mode 100644 gdb-xml/sparc32-core.xml
>  create mode 100644 gdb-xml/sparc64-core.xml

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


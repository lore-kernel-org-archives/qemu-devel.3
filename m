Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96117C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 14:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3EDQ-00072U-Jl; Sun, 06 Sep 2026 10:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x3EDO-000723-Je
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 10:51:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x3EDM-0005VO-7R
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 10:51:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1712169f8f.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788706280; x=1789311080; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NjW6iH71z9IEDqcLjRaoQPAVtTriQV699MDNdwsGh4c=;
 b=tSH55BZhYfCEyYkV7bZYvh+iBYSWfSvzCnLJb6kEHJmpWxJ5psOHfuSyR5yyYWxLev
 In1p+TtM1A0SSAERIP2PZnaePVQYf8EjgxOQxfrQzkLWe1jdXf7G7yoc2+PsG7zrDzHK
 jVpimiK992XGhW/ngnKZVKecwOWyVOATrxAjuLcvKKWLOOoxmPs1LJ0//bO3UxCUA+E4
 XPJbqJ0cR2Sw+udk2TvMf5C7e7QlnOARQSlheVtCCYMlQpNpuRn9j6J0izzkCIoyT6bm
 6GaQtVV7dibNf6dSDrYb/AHIcFjr9mOg56JxFbLs39mM5SJu52/Zk12BwnHPQWckroMm
 80wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788706280; x=1789311080;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NjW6iH71z9IEDqcLjRaoQPAVtTriQV699MDNdwsGh4c=;
 b=s64NYLTcuh1mGP74+X+AyC3FtnxJCfgy0BbF/akL1ufzY0bYuVVVp5o4/vTayLnGlj
 00b0PlQ1dQVqkdjhyIQ86wv6jE1xve98Jqre+DZo/d8dkRF11e2cLeSeOj8L1pJZ60Pv
 m25FlwBuMwOAUbB509uOKqHe3XaHxbpSrGGnF4xTocSLX1ckmR6fU9xFXnrCva5N6oaS
 VrVA24c91mX0XEm+2kR0b69XGB+JxL5y2jKiZ6IBKEwChAnLjeQzqIvu1A+WQQzQIYh4
 PBLfbNbKAQbglyXobHd5eyFRpRRZLsyKhtEu3E+CwQYvC9B2rGqSDY9PbzjgWWYcbefW
 uyvQ==
X-Gm-Message-State: AFuF++m4P5/5U0IPNqA5BuSnV6pCP77sd19aeX8N+A0GafCqz09V0sQV
 D+RoIHI72RP2OKbBjLqleJPZiLwSCKRN9Bk1DnJj3609+4Td9W/1toHTJkEm84Vw1BTUQgNEEc2
 3FLw1G0w=
X-Gm-Gg: AYBFou1WIh8roTuVQZ/hI5PMqlYxyH48+sYAzb+Cp5x+K4tClQvuLSJzSBtgc6ORTfh
 BZb8WvNwjQeG4/K46gOmqLNIlJz4tU9iOO4UotvCzvNFbCB2SXqGW9PEHgte7idKDGB7R2qr1jb
 G3baJv1DI04jS14C8lcKWFKCf5H3mqHL37n7aI/9pDAadhLULFBRwuUL7FE6Eg4wWoNXuS0FqQV
 SLw+1dTs4aKzZ9yBD96C5hGNvWpRpOxgdz7uh15lDPeoFho34ySKZi24q+9HljFr/JZ0cecErz9
 bSq2Po4Tsqwc72gv6sAJH8A2GTcqqhPUS5yZZyj5ZtdlJGjGtdF7oiLelTswifylpDmTF/j3XVW
 RGFCtkbGvLb0DAazQVni7ad9D0+E6oMCF3MEwaSU7m/elKZspOTvm4paf4xA32JF9ZUeB/3ENGl
 r6ZpR/odXaDvsruK4nA/BocFDiKqTotF09fTUEdi5kEDBhFbmZG6ZgJO+2lxfv
X-Received: by 2002:a05:6000:4a16:b0:485:8a47:5b98 with SMTP id
 ffacd0b85a97d-4858a475d20mr15712736f8f.53.1788706280502; 
 Sun, 06 Sep 2026 07:51:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm21799373f8f.26.2026.09.06.07.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 07:51:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4CCD25F8B4;
 Sun, 06 Sep 2026 15:51:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stuart Marshall <Stuart-J-Marshall@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: submitting code for QEMU
In-Reply-To: <AM7PR08MB53831A09C35366C17A229BB0A7B32@AM7PR08MB5383.eurprd08.prod.outlook.com>
 (Stuart Marshall's message of "Sun, 6 Sep 2026 11:02:44 +0000")
References: <AM7PR08MB53831A09C35366C17A229BB0A7B32@AM7PR08MB5383.eurprd08.prod.outlook.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Sun, 06 Sep 2026 15:51:18 +0100
Message-ID: <871pb6e8m1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Stuart Marshall <Stuart-J-Marshall@outlook.com> writes:

> Hello,
>
> I have been developing an x64 OS with USB support, and noticed that, ever=
y time I introduced a bug into my xHCI driver, QEMU would
> often silently continue successfully where real hardware that I tested wo=
uld error.
>
> Would it be helpful if I were to try and add warning messages into QEMU l=
ogs for incorrect but recoverable usage of xHCI? This could
> aid other OS & driver developers, without breaking drivers that rely on t=
he permissiveness of QEMU, but I'm not sure that it is the
> mission of QEMU to have conformance warnings.

The biggest problem the USB models have is their MAINTAINERS state:

  USB
  S: Orphan
  F: hw/usb/*
  F: tests/qtest/usb-*-test.c
  F: docs/system/devices/usb.rst
  F: include/hw/usb/usb.h
  F: include/hw/usb/

so no one is actively reviewing or cleaning up the code. So I'm not
surprised the current state of the emulation is lax compared to real
hardware.

We do use the log message qemu_log_mask(LOG_GUEST_ERROR, ... where we
detect the guest doing something weird but its by no means comprehensive
and mostly there to aid with debug logs. For actual analytics we have
trace points.=20

If your interested in helping as a reviewer or fixing issues in the
emulation there is a long backlog of issues to look at.

>
> From Stuart

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


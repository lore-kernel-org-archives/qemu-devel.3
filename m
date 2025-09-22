Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D68CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cT1-0002JE-RX; Mon, 22 Sep 2025 05:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cSt-0002HV-2w
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:04:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cSi-0001mi-8s
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:04:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46c7eb3ba1fso8357555e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758531830; x=1759136630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yN+UKz/CAibYby0+FXzDBt4CDQ7GTmgFqnp2Zk+az44=;
 b=oMSbX2FXNJuxH4w8Ebszk/LVJHx3jLM/kByRe7wRkDBfRYueMLTGuwuPq2TfQguSsV
 Zl39k7eO+pZPNIr3ZmZi78dkM1IEAGgLSNB/DPdMqgKhknt5RQvhDOL5U5I5hmDq/IFj
 16S6NTYopppwKNYMrqavjPg+ipYjl/V3tn6ZAOimIFIv+PYwF2G+rrgtaUiz/eKpXUWE
 9U+tKYyUOMAta8NoGMnUgdjxkYr6UE+2k1zVcgZfRXi23dJm+/U0ktKSLBqP7x496XlE
 NtvmXaGLnpDUDdn/r0vWpyQKplC9mxAcvD6tla5x/Fhi+YdHfODiwne5AqewVRAjLnnc
 9low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758531830; x=1759136630;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yN+UKz/CAibYby0+FXzDBt4CDQ7GTmgFqnp2Zk+az44=;
 b=efpbtpMp+1BT4Ri64PSrc6kVyIC+Q9DlMl7orFb5ZgOuwIIVUm0YT4He+Hlv02vPuk
 kbqwKPNCESusP9lGbTrHC0tQ2wQvm5+QRnudRHVm5cXZCU8BKXhTwbGunlaHLoUvLGBZ
 DPh52AzBJMr7p4hZ43B1AbhcKPsbqRCLL18c9t0lxCKzr4K6wCc2f02y9AR03OxEv2CE
 vaXkqnZpQgYmPipr5M41m83LYmJT4+noZmxJ8KpgFf+TG0ILX58dKiJekF+d2pl7EF8A
 ELocfSnO3LxqIkcVhyjbeytxYGMku07dcpMgRPw1rCdxwVn+orQK9TDks6VtkukuTCo/
 hkFw==
X-Gm-Message-State: AOJu0Yz+beF0SYboTzSoXZK9Q76C1B6z5TKqygWEblNmxxEHyZe+OQXn
 vu5uAwexcR0M/67z11UZVhbaCOC3Dq0pt9jfT056cr+BeYoxx9RaVBp1n7JWl2am18w=
X-Gm-Gg: ASbGncu+DdOEuLvhnvIjruABh+mqdtlJ/HuiKD7qOiAvJqUbPwK2P5TiTeN5G0TiGV3
 9qzHGir8tgG/NydxCmAfnS1S8DFHUrgR4lrhWrNRA57PZ3Z0lbjwueIznZqiPk3gfntcp00n7XV
 iWc00QcrYl7u83p+IXFR9S1klh3wcvkjVTIxWHCSlbuEVGK9597oEFwnachW1ygCi3FCjD65pYF
 VfSpc/w30L4LZfUGfb9hwzpJsRH0BszsHT+FtDtBCF2WD56K8Hi6G29xsFoa7naNNndkDLJdV3v
 kV66AvS1UaKmIofa6H/CpGUgR1BGNnO/qhpXSR+iIgd0E1eYW8CrrRqlvoBOdzbP1crU+10+vIt
 KU5K944n0lrFJixFLRHQLoMU=
X-Google-Smtp-Source: AGHT+IGUKb5PcZTq52Y7kamF8o9b7615SUe9DdTvOSniQwC7OZKUx9VmE2h5KXjWsqid8Zhbeo7Hkg==
X-Received: by 2002:a05:600c:45d2:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-467e6f36218mr113995895e9.12.1758531829977; 
 Mon, 22 Sep 2025 02:03:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46d5d437b90sm29435575e9.13.2025.09.22.02.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:03:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4120E5F7B1;
 Mon, 22 Sep 2025 10:03:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 0/2] hw/pci-host: fix use-after-free in hppa pci-host
 devices
In-Reply-To: <20250918114259.1802337-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 18 Sep 2025 12:42:57 +0100")
References: <20250918114259.1802337-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 10:03:47 +0100
Message-ID: <87y0q6q2oc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> This patchset fixes use-after-free bugs which show up if you put
> some of the hppa pci-host devices through an "init -> deinit" lifecycle,
> as the device-introspect-test does.
>
> The problem in both cases is that we were calling pci_register_root_bus()
> in instance_init: we should only call this in realize, as all the
> other callers do.
>
> These bugs show up if you run 'make check' with an ASAN enabled
> build; they are also likely behind the intermittent segfaults
> on s390 that RTH has noticed recently.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A5CCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIPHl-0006aH-Fm; Mon, 10 Nov 2025 05:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIP4k-00087C-W8
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:24:46 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIP4i-0000yB-VU
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:24:42 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b5a8184144dso365471066b.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762770279; x=1763375079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nwzv+m9xgL38YNspDgsD4VbCqtfnJfv2EeYaShGbrRM=;
 b=nFWhU0mJRG255sshnhE+Ysj8976X7/3iIflyrne/Latt1fPP3vOmizQfzB9fb5un09
 a+Jf7+k4xB6Vns9eugp0zpKe8ebpa8dAAxIkRWQMo7u2Hh3EIAlaN6dBAZ/fCWfWmwYD
 EB3YLTftA2TYkLZ84Peo1QUPYjyN53/0D+16LqvQfTY8jPLeBTdc9ozRlLTXCwZclByz
 x+XhktudA8VMDTI4kN6cFt7biQ+GeDs6SCx8IcoN71Ob8fGsF5HXdQXW+JcX5vzyRMj7
 B2/sHaLN/pd2uMBEdv3Z8/pfIJcyksNADmgCmSIxOgR2NaosmJg29J5wj0MPtueAUlGR
 tjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762770279; x=1763375079;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nwzv+m9xgL38YNspDgsD4VbCqtfnJfv2EeYaShGbrRM=;
 b=wlWuZo+DEi2Ud5l5obqooXYYo7b1ZWFoMtUb3nLMnwj+OZR1akLQLujpCsv2chD6R+
 klStWqWIHMXB3f8hNMxr5+x6YqxZIZYWG37AWRPlaQwWdEH4zQpDnDniQScUzASkfGL5
 3KBuoOIuWRWDORq5wkZYDbGbjsEyAZG4HIK6n9BihDbU0/ON7S6+ZNXI6wj9pAsyr7Q8
 FI1qDpnK3JwW8rvmjJSL+402sFayNpLsHkOFubpvS/znfzOCTuqaCNxOfNasMbSco/Lz
 D6vHgGWVwiG7ICUUoObDu/UjrtB26wPVQdTXoUFoimrPfZHLJdQfbIsN3uM0/XgS8ru+
 wpiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKX1Jd27nQ0lAFTcrAU/BKZEYIN8z6eIWVenLJ9o5t9Dr0O/4un6BHaBmnxO/rE5YNjKWZBrLxXkSl@nongnu.org
X-Gm-Message-State: AOJu0YxhXKDUHQILS+S1BHue+nDp2bstipDaf0jGZVG4Q2UDqFQ3OK37
 0KIIX+TZ4cr1fZI5upRuulhPbNpNG0U75tGe668s2tBWUypblUp41ecgaXva7Fjx78k=
X-Gm-Gg: ASbGncuqWXe3SHeSKbZwcWOavO8AvGl6qhM9kXVKMcDzBQYIEFI6A/m4Xc13rVPUcIe
 aog/q12+cb9VHKUjcc3W6TcMuALJaPxyxgLW1vgmIHMTDF7CBc2Igd55mFnwQPKrbXzssvIuCFb
 Wl6YMVqh4mldwTzqObguQSNTyCr2bh3GpCgBVP97dtJEKcnxMj3wdFIY+hhwkyCEWbZTT16beh6
 PonyzCN3u6P1++lkm196jiU+TboImASjiFKXBCzQ7AzmFjk2m+M9a8L3NnzUl2If6fpQbuq6Ca0
 WZk8mZfaJMiZhoxohUtjbKUk6UlRaz/8JrYxoIyEzWMs03cxniYB8j1oA9bfYIW+sc69Y5vSvIV
 Sv8bXiW6GGXLl7vZ5fXro7sjmRstVu3B4odpz0owYtMwd6XcFvi5StzM6TC87cqMG3AZLZbMzRF
 32deAjQMnEw9I=
X-Google-Smtp-Source: AGHT+IFVwu7NgLL1g0meNMs/zAPeL0UXhMYToeUoAyCGUVmoOIu0H1S/plk6X0AFnvGfa7Cg7xaQwA==
X-Received: by 2002:a17:907:2d28:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b72e02b31bamr651970066b.1.1762770279309; 
 Mon, 10 Nov 2025 02:24:39 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72dbe7c783sm800941066b.50.2025.11.10.02.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 02:24:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB9AC5F8D6;
 Mon, 10 Nov 2025 10:24:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, demiobenour@gmail.com, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, Max Chou <max.chou@sifive.com>, Mark Burton
 <mburton@qti.qualcomm.com>, mdean@redhat.com, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, wei.w.wang@intel.com, z.huo@139.com, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU Community Call (11/11/2025) call for agenda items
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Mon, 10 Nov 2025 10:24:37 +0000
Message-ID: <875xbirxqy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
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


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
11/11/2025 13:00 UTC

Are there any agenda items for the sync-up?

Note the calendar entry is in UTC so it's not moving, we just are.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


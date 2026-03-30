Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9C0FB3CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78cY-0004hB-7A; Mon, 30 Mar 2026 05:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w78cW-0004ga-Hj
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:09:16 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w78cU-00006W-Vd
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:09:16 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-66b8110361fso3170837a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774861751; x=1775466551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nGNkKpmndyexZQ+E7c1TGfjTwkVShOD/yB1VKK/J/ZU=;
 b=US7rk3estCB5ll8u2GpYAvSdfB5hU1lFJ42TBuwP+y6FNDBxpYWfGy5QUpr0Z0TpzD
 hxQjSD703JBDMHRcu8O+GOV31F5Qa5aqIgAhEJ7cK7r1DffcsAaQTlwJAOof17oRiul6
 Cvjs6egBitbB82eJIZN47DTLqWlvdf2G4JsVm4UrUGPaXFnEz4TSMCaQgpOuNqU7dEaT
 jqZHW7NLr0V4s857ixfJHDixC1ZS0jE+9W5mxDGup/5Tx7disDV4UfhYYl3QUcj0c27J
 inXNQZjD9G1sP+aLljTaMETE75fXu8kMTujKqaI94v2lygDWbSzXMmtR+kVkT7OjjGiW
 F3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774861751; x=1775466551;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGNkKpmndyexZQ+E7c1TGfjTwkVShOD/yB1VKK/J/ZU=;
 b=q+4Lle+UItQoA4oWkKo1NRfGlUOwOu5sFIjhsVKn8nbfb6dHjpxXAhzOA/WgKT59AV
 rzbh/8Kz2hM3NJwARTyT1AjMT1cI1HlvmCAchMsEg9DpVW2zU1/Y9GxG2TNU8srWGp17
 /vQGDeQQ7GdH0/KjrcaIW38coEICRrbtGy2S6ocdFy5DzSgayYEuMi5uAuaX6eea7G49
 TCrnP2HIPZAIWyWfk4AL1OjtpVt8uSu7pxBNAfiNkV72DmtJyoIWLBvt+ZcN3ocTfLpu
 qD23CrsC3kUACVGauulP1JkUNBJ0ibgOyTC58Tud/yELNR6XQQtP2dtmQUcN3JGPGkTl
 Llgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAPPC78Quc0Aftd2w+pnA0BMQrypopUHspLhAuafRoYHk+DonSD/s9f+86dg6nc9sP8XfC9+Ir33U6@nongnu.org
X-Gm-Message-State: AOJu0YzSejkRQvzQuGyLbcnwV7TeF1sOq8AkYjQeyXH/8lgiPwq0iMIC
 cvbJwizJwKUyHtoJ0v6IN0s52wpWH3iGpiZTbkobxeiSyPpUuCsLEXKlCdlQhrBmjWA=
X-Gm-Gg: ATEYQzxCMEx2dtE8HWKzBjQ3q38sQKB2MaXvvK0HS6oTs7lA23XDsyH+UTM6hSCRtRM
 PoBmD4Zg3NSDeGxDg8kv8IVXLz2xeaWqXI95YE/miJWhsayAKQnv7QaoC6HsdaxxNUZNpaswO8+
 lrryLHyZIVHwPQ7MyguvTgV4UqOhzdHv5N1IDbcOX0yQOzRyS6sAExO9OLxL53s6MA72UqNgcJq
 4kEJ+WuyRYT5idwAR6/1At0KPnJRtaV5pEWwXnqiTYe+1zLgJLUY7/ba/fMr/rF/CxAd50tOmPA
 WGJs7/nhUgcpsxybBV3/C2vmBwLtQ2zLclQ7c6avMcE0Iee55WJ/x2yomrDfkjVkbjuSBzw/5mJ
 N/m3M/lCKkLywfF6sdppm+ZxAm2pXqMdOYjCKvjR2iCWRKSVTR8srVi9EEMwJAFXbhpt6Q9Ip/D
 xxZLKXpFFhdsQMA1uj3BK+9Js=
X-Received: by 2002:a05:6402:504a:b0:668:732a:edaa with SMTP id
 4fb4d7f45d1cf-66b28464e95mr5248591a12.11.1774861750679; 
 Mon, 30 Mar 2026 02:09:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66baa0dfaf6sm1909774a12.28.2026.03.30.02.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 02:09:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 563DF5F8D7;
 Mon, 30 Mar 2026 10:09:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, Demi Marie
 Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com, Eric Blake
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
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU Community Call 31/3/2026 agenda items
User-Agent: mu4e 1.14.0; emacs 30.1
Date: Mon, 30 Mar 2026 10:09:09 +0100
Message-ID: <87y0j9ptu2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
31/03/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


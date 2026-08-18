Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54FFC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwFRe-0005zy-5U; Tue, 18 Aug 2026 04:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwFRc-0005zk-9e
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 04:45:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwFRa-0003Fh-Q2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 04:45:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so35400845e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787042712; x=1787647512; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sN7gfGZn0yB7g/gJUyR3kMVpXqQYBpGuIuBNvdG9FLc=;
 b=iSZdf7zxvGHkNz6VlrtmpZaeRbdVJ/7HSTEWdV9ekhDyka/EDeomWbfCMoP8GSlYlF
 HbkDB+wouBY4ATN2O9jfBgnJVZDMkiydIzIIK+QIlvDZS4PGXfi6PE1/Ekuo65DDoneE
 MQoCLqqi9Zg5eAg/lt2kK5gMBUo01GOP6RedrS9V6LGtTTH3J8iHAD32DGfo/eGciHyV
 wcVffZQB/ezmPr8v2nhpuclqWqqJn3LmjnwXhHU2WQfHmleAONNepRR9Whyq9bcLWDEr
 IaH39z5kS4GA42qJmvoRYldo8No0Jp72xvdScoxow0abtMb9f2GfJqniyXA+0SS/3YT/
 F20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787042712; x=1787647512;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sN7gfGZn0yB7g/gJUyR3kMVpXqQYBpGuIuBNvdG9FLc=;
 b=cqChj++zHOIDFyiYRisVU2yJYUf2alehE6PZXE+e7hN8DFNKwkHXi2HhixVyUqwPgj
 wSekKnHrBKfqnnVto1qWUqpAybaBhmo0Ei3tQYWtU20m0A2CBtUGThtPsukevYrZYpk0
 naYLoYo98MCXcXp3Bkl9nk7yxL2tnQyFGw8cAh+0kVs9sWGSRTqTEwtUjnvyKDeRhcFm
 aE9TgxzSvbPlyh48pY47m4JJEnJdXaJcb1Og37wILUtFiPgzYCD/rubWQExO4TwPZQL6
 JJc/X6gqMhMo729zOY6KRZv5+3DogRvPjhugXo495qaYxJM3fBeeoPfelHDW02DKOjlN
 Y5Og==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwTvcU/4wQoki0UeAiKbR2SYjFJ6IkxRz0pYfL+WwaE8vOxRp2N1b2G9VpkC7cJgEisHeDkRqh07Jx@nongnu.org
X-Gm-Message-State: AOJu0YwsuEbJ7DZvQrDJxB9rSM1JC/W9nn4xIuPivzf5CT0CTkQKHKj4
 80YwywEuRiLyL/Chgd29j0nNGHwekAQeHyEPw1yTRoDpQsE9h14ItvbEmoU4g6YLF7w=
X-Gm-Gg: AR+sD114PGr/Mit4/ScI2+UDqFjDFAt8U12Fzx0wH1r3eV3Zx89qC+f++0TDW22d7iD
 5Yx6PLeXDkQCJAX42Rd4EzncdqfGNdULozDJRngDBAjdzTgCFfhvcyPq+Wb+d0kXwZaGuS4vz/G
 b2tqO1EJEKnwEmKjcuIxuPmW3MDjZ29Di84Wm23RQVtkMeL1Z8ejMyVCjmnZpj+QWh3SpYDbhFb
 IbCFxrJU8P3kTbApTlM6ParP3r2jcFzdQRMjTHV+ktXQMEVDhXtb0R4t6zKQXFaOUqvqdfrNsUf
 f/T4lC3kTzanThLWQun6RS7wCuW9FNWJS1D8h5fADkgFfYTsrpfxZmGbCEBjjoXswu2Dvillf5E
 59YP0cnO7qi3CnXyuiY10eHWX3OOYCMcmPa9LRmEu9mqLeP/HunyUmeWopQEq3NSdnjPJI7UsNQ
 0P5/EoQOQLwZsStGLAedvA3pInf3EOAKUtZJdGJyIP1Z+L938oJQvmTUxj2SNP
X-Received: by 2002:a05:600c:870c:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-4999fb3be85mr115693885e9.9.1787042712468; 
 Tue, 18 Aug 2026 01:45:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm512107555e9.13.2026.08.18.01.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:45:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F2715F7DF;
 Tue, 18 Aug 2026 09:45:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 cw@f00f.org,
 dbarboza@qti.qualcomm.com, Demi Marie Obenour <demiobenour@gmail.com>,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, matthieu@minio.io, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>, "Ho,
 Nelson" <nelson.ho@windriver.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, utsingh@redhat.com, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com
Subject: KVM/QEMU community call today - any topics?
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Tue, 18 Aug 2026 09:45:10 +0100
Message-ID: <87h5krstpl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
18/08/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


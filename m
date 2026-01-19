Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EC0CCF2D5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhmGM-00049W-Cc; Mon, 19 Jan 2026 05:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vhmGL-00048n-1J
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:13:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vhmGJ-0007Dd-Fx
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:13:32 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4801c314c84so23529515e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 02:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768817609; x=1769422409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ArTS56IeXf+DFXAqRGSMNS5Jjn/RHwFy7ZqSU4dJu0M=;
 b=rqFM623+8fc/KYqgiYaQThw/hfDjzoyhUIzACr7y+7687KPeTaudfLAJ2xlNgna1wx
 rp2aw79I8S6gJbsdG3Ff+409Kv00v21oWw4k6H+KHXEeNIqvNR5YKp/yhCf8BcYiQEKD
 wsPEGigJtm/oZJdbIyDCscTvE1NLGmkvl1yyLxJTeRMQ9Or4Of3yMMECq51kLNIJb+lB
 1e83lx6d7VJmdET8Vhoj54kPGoGtY5W1LZTLrqxy6wemGVurELVb4KvIg5C/fbQdo2n6
 R1khay3roKcuHRGQqDq5mxmMztHmEzIBpiHthkNEEeK578lD0x+rtBr5ppqwJqgXd6vy
 W3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768817609; x=1769422409;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArTS56IeXf+DFXAqRGSMNS5Jjn/RHwFy7ZqSU4dJu0M=;
 b=G4iJ+JPeed00430sAcwt2WNO23X4PmzimGFKNAiwnKaxQbBbbycz3QsyRaA2YQ9+7W
 j1JUBetRDYrtJXGXkV+FlINFarLloaGMp3+oIQidMsanxNkqdhQVnRTmnRhL7bGXPXxK
 ewkKkYnEr4AZpthTDaWAPbPgRxmv7o+noSe2r5RPo863RsLZqTRJSQKs5ZZNEBCjOItG
 yBvk+CzlH4qn/cNRbPbsK5C38sKUX+FAdblr4BV/YtAfjDvGPMS3yY1upVhgyda73e0B
 qwyZqYEWZmhctZCZpGLi6tCJa0ti99eRflbDv6EU2WGWe03/cRKFwFYpm+rg97G1PCnp
 GQEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFELlnuk+m5O3EXK/WRZZGXASXvW3S5dJWCB37tndT2I4buW9NmIXLJ1kMveK5m7Gc3s9A9Gh0IBPx@nongnu.org
X-Gm-Message-State: AOJu0Yz2eT72jREscOP/udI5+N62+ZAD4OWeSe4G48E70LUMHfoREy1T
 eenidxvaeZI5WJW23wPGJOORwLtJWsrJd/s5+7tw1G1DsoJsXatVCMCZLWITwPqAti0=
X-Gm-Gg: AY/fxX5n8SKYSXgRsrpRHPFDApcHUy+JwaVMG4CPNjzR5kZcnSHiIAYZabdfvNc/26T
 88CLtCIVMxJYNRpkcI6LODcPbP8Vm7+UeQbRDxqMLCcl96QP2MeoCunHjHrRpnD98T5z/6TZh3u
 bwRYXyzwmJQimZanShgLzydgZp/8s0O3Kijtae+6ZSPhNd6ah80ONQPCUUc4kviIPo3nvcTcw1p
 FmRG6z3fkvMCz2vEH3gz9yfaJy1O7ea6lkvOLESHarOyQPf556oMp4t8wqdln/klgjHbYYzTaMy
 Ues7Dgi7tDMDaFtrxt1b/TNXqoHoEI/DZEfhK0f7saNFEoCXKwM3+UFq/bTRUP7RM3IBshCHoov
 613PY3aQ+aYynO44ZAsD05y94YF5/qDOwXHWupizZBb1MwGg6c2jud/qYvzpt5lPbgKCOy7n5ui
 OkhxC0WIXExf4=
X-Received: by 2002:a05:600c:8207:b0:480:1c75:407c with SMTP id
 5b1f17b1804b1-4801e30a4f9mr102976305e9.2.1768817609492; 
 Mon, 19 Jan 2026 02:13:29 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428bb0b5sm240048315e9.8.2026.01.19.02.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 02:13:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4E0F5F87E;
 Mon, 19 Jan 2026 10:13:27 +0000 (GMT)
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
Subject: KVM/QEMU community call for agenda items 20/01/2026
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Mon, 19 Jan 2026 10:13:27 +0000
Message-ID: <87zf69syew.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
20/01/2026 14:00 UTC

(hopefully the date is in sync again)

Are there any agenda items for the sync-up?

Admin: I am away tomorrow for unrelated things so Manos has volunteered
to run the meeting and make sure it is recorded.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


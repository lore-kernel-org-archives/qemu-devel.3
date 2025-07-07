Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF704C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 13:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYmJe-0000w0-2L; Mon, 07 Jul 2025 09:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uYmHP-00085d-Eg
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:53:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uYmHM-0006Mq-TS
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:53:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so1717972f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751896386; x=1752501186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mtQCTXgjC/bkSTSnq9Tu3F19JkIq5zQp+GbJ+smqpoA=;
 b=tP/Q3+G8VQbYmleX0BueAgqjaeUIcf4ym+f97EK1doZiVBCDmGABc71mCLG1UgxM/o
 1vsXPBQa1TgAHneBflbTnfZUAtlvffRKHq1Np76qO6Uu02sgGkz6OayW0nz5YollBg7h
 iW8IM5CyBiR1YeesQCAJw+MGw2WJy25NWdF96AqlGcsLsJdoUifRvxxev7n6acKTxyMl
 UmHc1H/XkRYN0Jm1iR5p5wwxrgDu8Ey/zldsIixTSsYxkaN40dQuCMn/1JrNJXAh+LSP
 AiW2d3gN4zu4S2VCduGvDLqQ9LXiL3zu1Vq/o5ZuHRdBrvUEvTYb2ns2YZC3nTEpMWZ4
 yLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751896386; x=1752501186;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtQCTXgjC/bkSTSnq9Tu3F19JkIq5zQp+GbJ+smqpoA=;
 b=MZCCOgypwkpQ7MydQj+Ftm2MhGShE1N31JDDpgCFJOtHxqfgyQ3asn7G7q5FSXmjtc
 U6g3v8Wha6gMMAYzLHv0birfmG+8qsmp/QtYYEZIy4KlG7Glrx+2KnecBkxR5ozvI9Pw
 lYZ8H+jlco9pwPEaJYTB2TDlNcc9vJl8cG0KpSn62I8w2YkUgW6H1Wz7RzoHITY4ZsJ0
 fJWliErPCoYY05JKjx5KMUKO6K/2MScQ/nrffCVsfh55VAke6S/Xt/vRvMrjrCUlO1HH
 /6IElsZFyJuh7P0ZRnpqc2WVcDzS1ascWqnQOh01V/aA25/9sewDxCHQekyomzQCZVrL
 Fi6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdCeASTuDDTfDBcSu0rrxDMHTmXWJBYHIdCohK/gonw/MS6KaEILEDCSyKg5VmSBW4+z0uMTx0ta9F@nongnu.org
X-Gm-Message-State: AOJu0YyIBuuP1/gX/bX7Xiw9X0SAutjp8c6JIQiPsFoe9eAw4F54bRj4
 t9E83oAs/NFbAK+On+m/YpKnY5TNCAKeWVZ2JWvM2U6c5PhYpb6RrgnPyT1OvJVgQ2k=
X-Gm-Gg: ASbGncshJOX7ICAJM6YQYF58nE1abWXJwn8b4MWPXc4s26CC9g33jW+3dLv8S8+sqjR
 UX4gp4mYb6frhmNOQdI4jl/UCCyVCha3+Fdb210suL6H3tZ0T5CgPZsx3gFcHY6wWhkVV3t6WeZ
 g3XMR024zMR5kAycPwy13LXBvhcUkruAu6Xo4K5iBP4Q4BDJLqm1vVrFqVODuanUQ8GUfE2JziG
 p0Yyn7h/+FlmJ0qJnZQHpZ5RczR8hV0pXYn1Brcm5Tk49Nkj84BQ7rrjY7VVwtJqOl0xveNMmo6
 03AqlImW/nIpy57oueCbF+QUU+NSbDq1o4xHuWoHVAwcLDCGj/TxCgaRK9s7XPM=
X-Google-Smtp-Source: AGHT+IFn4yqkXmOcNSoR8mygmbLJyGSmieTef4QkU2iCKwQREaL6gXjLpO5Y7GTo6YkWsi+W3IFeoA==
X-Received: by 2002:a05:6000:2910:b0:3a4:ec23:dba7 with SMTP id
 ffacd0b85a97d-3b497038e99mr8743165f8f.31.1751896385731; 
 Mon, 07 Jul 2025 06:53:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a409sm10251085f8f.70.2025.07.07.06.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 06:53:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 00F5A5F818;
 Mon, 07 Jul 2025 14:53:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
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
 <manos.pitsidianakis@linaro.org>, Max Chou <max.chou@sifive.com>, Mark
 Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, "Ho, Nelson" <nelson.ho@windriver.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Roberto
 Campesato <rbc@meta.com>, Richard Henderson
 <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call for agenda items (8/7/2025)
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 07 Jul 2025 14:53:03 +0100
Message-ID: <87qzysumyo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
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

Hopefully I've fixed up the timezone on the calendar entry and fixed my
snippet script for this email.

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
08/07/2025 13:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


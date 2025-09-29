Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F21CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Dd8-0004tB-4M; Mon, 29 Sep 2025 09:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3Dd5-0004sY-3V
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:09:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3Dcy-0002bj-0Q
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:09:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso3990077f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759151348; x=1759756148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rZ4UdbL/hYSxoPVg7obe/FpOdZRL4ZQ8Zf4h474kUl8=;
 b=p5weLqEZeEvl0my5d+9VM/QvrH3519A7J1ZwvL0SdFgrT25L2Uw76871WhdMZidaJ+
 zcdKk4QMXXmxgdwcYekpCqODt3uCuHK44ANUNsvJk83RAKXS1oiLryE8CuRWrSdYVrxh
 YuBtUYp5lkuhEBCuubEdOHULv012RSZiq3GNCWUsZroLbjv/Rl23CY4R1l9qnyiVtU4a
 o55ES3Yt00tIXcfduavyZu8ItBpTfuHkPVd3yJYz43M969HWeLgAqhvOEovSxFCAdjg7
 h6HhmvhVvHOrP39EDFZjF77MgMmHnthSk/MzH72fl2uH4+ZMVTujvL1WDwGQL7EyzBln
 q+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759151348; x=1759756148;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZ4UdbL/hYSxoPVg7obe/FpOdZRL4ZQ8Zf4h474kUl8=;
 b=gnPrZUFqlXVDbgkaU/IXLY3EqJ7h3mKEiuprxobA+uEYW65ysFniIK9OVBTv4vJ3Jo
 N3f4AAAVJ8Y6KuV1cnkYIGu/G57BbnTWJlgyK0k5RXuHPS/Q5gN5UJwUeWSCn/jaIRyl
 HthK5+Fbvx+uJzhd4EK3aBCe+IGy6usvbnU6lPHdx+m79w17EA1x+MVSNi4Mq6ctqOux
 WiuNPZD0KsW8N4rVBNlzcFyGThAQyjZ9nPXVCuL/Hy8oM6jKkV3MeBcMzbfysE/j9WyG
 wlq6bNF+XsQpSAmYQFEf1U//CxjZv/E6Efl+kDo37MuMbBxokVhBvRz2zJJV0xfFYtUq
 Vlog==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/1au4oIYMf/4mCOl5W6krkJrj3le722TDRJVaTIxIYXdn2oH/sX04AspGtPMSqRvfkWsxMuWM0v8f@nongnu.org
X-Gm-Message-State: AOJu0YyBrKPSs040UvoJWFl3Dkp6+GGkBFc5SV56Dj+jyPu4nC3NpfDA
 fItljNX804HNijFlMIumlxRl/JPAF4zTk3+xZiF7npLj6fqNyRSRArlao4l8GNxmYsM=
X-Gm-Gg: ASbGncuR0zaWQxFkxKxW1D9HbxY7IziKCOS8q9FUbsTZsULUi3GY0xUt/Ms02koSNzf
 A9lF+DAN60r9oXQY9trR9lKgVqZVNeJ4hgIuk2cvTUKso/EJP6vFmkCd10LnBQA9oGy6Y28gklM
 wlJnQ6SIqvV4el/c1XHfcFK77QXeJ/dzuXo8uMIlOj73g2mooHFkBYVAPXlyMUffcz9sFGfI+jn
 up/lzdGQZ/11CJNKiD/9L5Zl3Eho7fmeXsLEgFt27/YATIXiPJ3jQYrHj6ENqRLhbx51yOfTlbz
 ZCLptJFAzM++SRIBK5LLy5dpBgMamqJla6hC8C5Qto0k/ln9FTGCmrsEpF2svDpZc0GVQQ+9JCq
 kUM6n1iv4jGVIc7ziBq4FxahBp56Q6HUWSw==
X-Google-Smtp-Source: AGHT+IFdkYgOgZIOjig+JmAKfWQWn2GHVkFrlU6bk8DhQBSENHwN455cTdfWgoc6tUE3ep5MRZNSUw==
X-Received: by 2002:a05:6000:26ce:b0:3ee:141a:ede5 with SMTP id
 ffacd0b85a97d-40e4a42f3aemr14857556f8f.57.1759151347831; 
 Mon, 29 Sep 2025 06:09:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e336f2425sm88724685e9.10.2025.09.29.06.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 06:09:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF6405F83A;
 Mon, 29 Sep 2025 14:09:05 +0100 (BST)
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
 Burton <mburton@qti.qualcomm.com>, mdean@redhat.com, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, wei.w.wang@intel.com, z.huo@139.com, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 30/09/2025 agenda items?
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 29 Sep 2025 14:09:05 +0100
Message-ID: <87y0pxl826.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
30/09/2025 13:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


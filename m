Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A9E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3x2-0001Xs-LP; Tue, 07 Jan 2025 02:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tV3x1-0001Sd-2u
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:24:31 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tV3ww-0007fE-45
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:24:30 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so158536515e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736234664; x=1736839464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eHJnxc4vzLT9E7iWxo9A1aMErch7hVtwUZTlqDzT2gA=;
 b=qnoZ62hRH31lN+1I19HzYNDHZwHJ6jS5sQVxNqtaQu4P6juiSmdlsw2bu/RiEcfHr8
 8G68LWDy5JieDINc48wDgT2j2kcjntP7/Jdp530zmz1PW6ecpYrqNzNfo+UqAwdwc3KM
 0MldOb2J41fa22Xyn6y2U00UIvUTygd3impZ1+nAYSR6tiyLGFkR3Q2x5L1+mKFz3du4
 2iNRxeQMmCAdNJ98+f8cQJ3uUsr1Svg4GioJwVcMqZlfzJTT/VKoCviTZsCNlrPADSnP
 tuyJsQ/EO7uOlxkZ4fheyEJCnvUp9i2jStFi/+tKfmhB3lT9YO3rlfX1W+HFkYMs0fbF
 BSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736234664; x=1736839464;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHJnxc4vzLT9E7iWxo9A1aMErch7hVtwUZTlqDzT2gA=;
 b=pdV2x5d38CiY4795BRVrdUzF+ITi3N+hAT4YZR3C9tsZy61+MSG4zs38A1cZC5PKKK
 aGR8XTwmTbQXZo+6fTgEE5lJ8sGWUV25DvRsR2pAEre1irX/zg4YTIzE7h/1pm2fRa4Y
 nnBlUrYePBm4BUgDHi6idvNfLzgXkgh/rYvvBaxx4jLW/5/kyfFVMyruksKwapnR+9E/
 bkgL3qUge/QMo+6Tg5eg0R4bX+bwBhh0xkE16JAmfysbwVZ+gHQsWpLKGaJeymRnG5ac
 uI6leFDpHDSwDzFi4EUyHqeZemoP2h1vuyuo0xtaGtf7F7vlZe2CNx0c3VIHRSjnX0s7
 OL5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6p8OCseynkfbAA8sDGcV+hsWrDm5lgnwfHsiLv38Fx8j1ykumXuHXDfo7WX4cqL5AnMxBLZ0jW48g@nongnu.org
X-Gm-Message-State: AOJu0Yw06FGcp7C0Lo8ndGJ9okQLPMC+DTr2645QCG+iIlcZMhBOcoDE
 bg/gdasDyMMQoKEBOvOBoAKuxNH4ibfwiY+7ZPFBWPTAvTuIkXtv1sDsabhNl/M=
X-Gm-Gg: ASbGnct96I+/t7IgTRcWgDr2gMj1fA9no5nhTIBU2UFSwVtyB184+jsMOkQJpbKHrrJ
 Q99Z8LXueQJiPafSRJMBMF+b6dj1i8QtopSODoJMij5gT8SCn8JGXdZkdqFyOYauB3jetOtavuc
 3KCnE+zZ4xrrjWrVuXz4q+jBjJKGsPTxnYFnS2Hb1ptCGjpJfJGmPAEtqZTgllxFL6fctL4Lqyj
 nL/10ObRCuk7lTHk3RXaMfr9PtcbV8nu8VXE5txAv2NXM39h8RvHBc=
X-Google-Smtp-Source: AGHT+IGK1IIBigjZkUz0Ei9ZU30e9QXyFGCIwvtqpO6o5i+lDS06wybDsS33m006UZ5bSjGBMGymPQ==
X-Received: by 2002:a05:600c:1c9f:b0:434:f623:a004 with SMTP id
 5b1f17b1804b1-43671244708mr507317535e9.16.1736234663628; 
 Mon, 06 Jan 2025 23:24:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e74sm48980793f8f.30.2025.01.06.23.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 23:24:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 535E15F7DF;
 Tue,  7 Jan 2025 07:24:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com, Warner
 Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe
 <jgg@nvidia.com>, jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Max Chou <max.chou@sifive.com>, Mark
 Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, "Ho, Nelson" <nelson.ho@windriver.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 07/01/2025
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 07 Jan 2025 07:24:22 +0000
Message-ID: <87a5c3ccih.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
07/01/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EF5CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6S8-0000X8-KL; Mon, 15 Sep 2025 06:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6S6-0000Wj-1Y
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:28:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6Rw-0000QF-79
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:28:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45df0cde41bso30788545e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757932116; x=1758536916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qqu41WLbJ8JLB26yJhQEgTI/fCri2XlI+Wtenc2ljm0=;
 b=V8oYDMnFIXRlFCDM+Xyvw6trWzdOW75ahiCZVfjHonj3dFbjpUSApS9pbQ511ta7NR
 PrYWtOPpXYUh+7dhzKqcMjqML9oYlN9N+PjKQzVqkDYh/GPNaxObkVMeu6+Mu0qbPDjT
 lylPuxwM+y1hZPKLSW59WqQthWQw+YyPjEDWsYNgNN9g1d5YEqoeb2bXJ/UAuIiI1L6w
 9ujUisUUo6iXQGLoEHKSfdRd3rHA1bz4mYLjDp0wDhHCNlE2+FeLABuB7BZkGpDBnRju
 RZG2bLGrMhfm0v/i11DFwva/oRCYAo/dhQDaVx1da3Kl/nLATebXrACiy6iFoKaFkZty
 uZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757932116; x=1758536916;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqu41WLbJ8JLB26yJhQEgTI/fCri2XlI+Wtenc2ljm0=;
 b=DIBRG0ZqpElzpQIkFw+5RQ+Emfzwt4vzv2prnJrAKOi09UbCusuS3jq4VK6zC/PVxW
 5z4Ga3HVFQlcg04oZ6epV/ROB5eAALFYVWCi7OYVGS2JT+EHjRcASIcCj8/T+rhk6gBr
 HX71Omz766Ye1V6dN701BVzt6clNKUzQmY3CyNifVmmWEB2WCbA1IjUousbAhYxle8HA
 iqVO646FZ8ArObABubXyqznE91IaCD4wVUN8h9Oki+GdI130nL7J2mhMvwMnIeyUnbk1
 GlOCNfQVSfPz0ms01DSfG5RQajxxy1eM80wQh9+BNaFOLN1AvG97az7ZJ0sawTtccu3/
 pWFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWritE4jfhnzQfjdAcxnW64t76pDET+HZAtlg+QOmWNdNouA4d9L0+kg3NYmKd2YkL6mX9OM2FvrLU7@nongnu.org
X-Gm-Message-State: AOJu0Yw+TCSZu6c88fRsdaZOeu0Yv9MDzvC3QGovwCd/vMBBpYa/XgvD
 W5HmVzpI0F35Jdim2I1W/hIg74G25j8Zg/4aajfWRNZypxjJs7G3aSUYKn7r8Khgb1c=
X-Gm-Gg: ASbGncs3r4G+Jhr4ACGQYq9c3mrAUwTp5fqjSFVy6iBIa+2COUnO2DzWsKjQ9maE1BE
 11Rr65pZmyedsnPuDGzl4do6CiGI6AH/38OxJCbPI+f5Ef52wbYmwQxbG4/70s+saGJG0ZCg7aA
 5altAXiuGCOCMZlrzo90p6P37W8Z4LI2TP9vgKoQLQ+BO15YupNrDsnr0koakAW5pmZ2DqPbNfk
 d6ci7o+tf6o4ZB3zO517yPxSU200mkuplPjat7GgDFK+SxP4opmivciXVk1olJ1WMSzbxJB8Jzy
 saECk5F801G9sISCSneahUsltzYL2QVcnSlRoHt4gq/nX5LCjnFaehOyHRrlDyJr/UdXzSEwGyH
 Y5ko2aCFdUi2/0Svu2FntAAQWymqt8PJ5Sw==
X-Google-Smtp-Source: AGHT+IEE4+sXPJtUA16ZQyjCFKQKkDvBFaEiw3VoeIjcPWmc4TkAH/TXF2zqOYiz2vQcHDHXH9SAbw==
X-Received: by 2002:a05:600c:6a14:b0:45d:d5fb:185b with SMTP id
 5b1f17b1804b1-45f211f3045mr81090195e9.20.1757932116145; 
 Mon, 15 Sep 2025 03:28:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037c9d91sm169443545e9.20.2025.09.15.03.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:28:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6DE005F867;
 Mon, 15 Sep 2025 11:28:34 +0100 (BST)
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
Subject: KVM/QEMU Community call 16/9/2025 agenda items
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 11:28:34 +0100
Message-ID: <87frcoqab1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SORTED_RECIPS=2.499,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
16/09/2025 13:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


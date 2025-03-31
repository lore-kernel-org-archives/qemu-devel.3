Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD937C36010
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGjf-0001QL-20; Mon, 31 Mar 2025 11:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tzGjW-0001Pf-Ih
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:07:27 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tzGjS-0004Dq-Fp
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:07:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso3662509f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743433639; x=1744038439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDEGCgdSmh2oL2D/suZDPsmwaxjL9zROISfItLROeTQ=;
 b=U5UJaB45MFpOJLSR8KIF7mxhyl9crzLju93QqhQLpdXJCfFld2F+QL5RIaGg2kmkTy
 V12fr9HHMi/zlp2TWsyyA0+X9wkFCGYOhZ3wx93wgLbvGLAix20SV0adD4v01+YeIFK3
 FDCjpG14OCNadrNJoBvztbc6Y8eZ66mvb0tVtxGyQhp0sEXeW4SYjjn/Vs8fqsxw+c9N
 sdY/B/Wf4bzw4Xt5PzwWlupLijJHn1TdLZ+tAwS324lDdEKxgrfIrbc0rixPuYq/LZHh
 BF0kYR1lKKAQDwR8N3zmoiuRy0aDi2V7yLjeESNanhn4khZtFl+pHlEbd7Jt6qXJoK+c
 sIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743433639; x=1744038439;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDEGCgdSmh2oL2D/suZDPsmwaxjL9zROISfItLROeTQ=;
 b=LHNqTqidvKMKnltg6Zp1XqbHqrZlV2HSvY4jv/Jk6p8T/RDJHKB5FByftPwYbsUfv3
 17kdCOoZ26vq7hWQlkB+JbKkI3MsHkxXoKX84hwwHRR8bz2fHS+L5VPwptTKUAeVcdHG
 Jfg9W4+tv9yBfzpBJ2e2/sfcVwZmHcF/O7uqUy36erwXVxocy4w7RF9ggbJx5kjp7twi
 OLs+kYwHLz6otdHTQxIUeH9IFRn1XJ1PV7IbhOcGToiYWK0sXQ6gaQm+ArBapg0kWP3d
 Dj5SHfkReaYs9glxlNedWP5767Mhdrbh8H2HQ/2MutWX3hT45+wjQbaVrRFpp3uktrWP
 dFwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvdsXEsNL0dh/uPScD5dHVbddlh6kcikqUJvl5aQDkRgAZ6gnM1TRzKloffSF6uXU6mEMnbiAwo2a3@nongnu.org
X-Gm-Message-State: AOJu0Yyv9TyRjHMq0KxtE3nTBgO+DzG75fhqOaU85oxKbunqUcCex1xg
 Drtb01f7/+EGKspj5KkIuUUTuG5O0ns7BNU4027JdE1053Y6oIzLNF38j7ugIvw=
X-Gm-Gg: ASbGnctq0htL9A+zbbmPT0U6NGAgxEJystoyqotAfyo+XraGsJt2OgL1akqQTL+Zypy
 9+nBjn2UUxhWbo/xMxiVZAb9SdkKtsDsFTAA8CRzKjYCuaSFP8nlln1rGScOvJdhIznmKrbnBNU
 ugrXI4BBUVEV6MzbSHRGG8Cp4HbDCJA5aorX8lz26vU553nG8lNg3GR6EnQ4WCCobxPCgYxBC9J
 zgSdWZe9hHy/6mDhZVAljmlIJW9aV9ZDjlVd8gI1TPZRDGWbbq6htbDaR/MCkDTAaCxeGhYRtAx
 CkinVSHXc82nCyiz7ad46Hm5GfkCKOPKz/gHDUMgSTaJ6k4=
X-Google-Smtp-Source: AGHT+IGxkXCDI1PFtvpRfdrGaBzhXKfdCc9k8RaWowkXDpBIzbV6zPyC3ImgpTZigmOWWeuvJH/ZHw==
X-Received: by 2002:a05:6000:1787:b0:391:2c0c:1270 with SMTP id
 ffacd0b85a97d-39c120cca84mr7767787f8f.1.1743433638721; 
 Mon, 31 Mar 2025 08:07:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d900013besm125661155e9.38.2025.03.31.08.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:07:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3003C5F88A;
 Mon, 31 Mar 2025 16:07:17 +0100 (BST)
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
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Roberto
 Campesato <rbc@meta.com>, Richard Henderson
 <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 1/4/2025 agenda items?
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 31 Mar 2025 16:07:17 +0100
Message-ID: <87h639p7bu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
01/04/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


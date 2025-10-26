Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA99CCF9E5
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 13:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vD0ZT-0005K0-W9; Sun, 26 Oct 2025 09:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vD0ZO-0005Is-9a
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 09:14:02 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vD0ZM-0002vl-AV
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 09:14:02 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-63c12ff0c5eso7426788a12.0
 for <qemu-devel@nongnu.org>; Sun, 26 Oct 2025 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761484434; x=1762089234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCg2KuHIyhADBEtyAO750pPN7BaUMKj9tSTj6ArSi/0=;
 b=gIXXrCLSakK24k3WtqLyj2nfXhImH6g6kPRuvrzHEaoon+zHIYVE/gsc1SKUrtDAMf
 26W8ka72kmqw0OG7gXHr4DOiBccQFQyC5Rf1D89db6nzaSWrKMx3I0jyoS6a9tWE8cAQ
 gswmD7PFGIcVyU8NpoK4eiRV4KWsEog6pTYQDCls0tOV3tp14tjzrjP47hNlV87Ivcqh
 ChRvl0WTTIPkr/M+TVuard/IxmJnCcO40caZmcPIwL+5wR2CU8wZqlY2rIG0IRBH+quz
 kuSPZ1m3U3E4mETai6yjB+R4IhJcugBsKUU5FIrfsVroWU33o0IpoWJywGpt3hM89j74
 MCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761484434; x=1762089234;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCg2KuHIyhADBEtyAO750pPN7BaUMKj9tSTj6ArSi/0=;
 b=CEFY2ySb+dTYiP9ZUzKLKad+puUQPLCxx9yxfNHgrCX4HR5sJdmGyN9xH32jzsmKnq
 VZnFC/l2Bkf6KfMoHnJ9C9swf/U4XtQFaB1qgef1cGHZZZQrdQgBl/JOmME2tbnaCstl
 sfva3CEnshhYUVFTMQ+K1EhJqPr1Y67a880CoQA3V1ZyDRjku5+ZzjOG/pawyaoM1q2M
 g9VPVbfiWYesIqDuM1oSMyZYXFMx7rxXF1adDib7AEA4+Fgzi5t9ondrbM03emZP911f
 Sa9gbdqHk8xS3f3+MocN5D8dSFiErC8QsV2n556odTVhxkK6r+V+pTo0R5eE0Lv7tPhp
 RXIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5VvKYNfhpqdVCv6x/WTyKW8jMNtZdNTFc3nX0sMFPzGHc0KOMCrfpxoaXGw0qpY0TvSwVF9OIpFkE@nongnu.org
X-Gm-Message-State: AOJu0YyTg16X54RagYKUQvURs20WV+LK0EnHntAaSvyGctVlwyx+DpwR
 zo6AWY6vdZwLtYlnm2qma2IE9yvLcIbM4gN//6QoLbEx8y63Y2ugLfE1uVW3G7QpwPk=
X-Gm-Gg: ASbGncu2BqKozH4YTOQEBJ7g/AbRkVlVRXh+LXM0c5XBzRPqKjJORAR0MBuYVsPrMak
 bGkNeOu6UYz4gnCUYAzG1kjXQt79nxn1RoOMHfFCpNA2o0Ngsos1P67b6UD3hMIMywnUhDe9ZTZ
 GEASZR55G9UXLkpJhRzUKDYJabEoAF6Wded6D+yE6fD0ahVnQOhMw/xQH8ZWy48GK4+3kukxEbr
 //dUHjEdXAeLC0B39IrEOBRQWUDps0IXwUaQQmVgWiXHVPdo+GEGNXy05/1BeXMb3dLxfYjORC/
 sbaXa8ZSlNIj8msajNMZoED1SVNVTbipqO/tSJ7KHtf8fspiwfMyJbvxIB68LPV2QTnx2gL5kj0
 qORgevAf+jPmCikG+SRf1ddDnb1iAiKGfN98G/VCFUH++Nye3Ti6T+B0sO4rt+yq8tU369BeUOn
 32
X-Google-Smtp-Source: AGHT+IHohdTXeNdAezaApM4ylBLpkYwIKKIfC5yuv+XlUvglfAYp1sZTNgZk5KJjx3yajv8CBURMkA==
X-Received: by 2002:aa7:c511:0:b0:63c:1031:7c60 with SMTP id
 4fb4d7f45d1cf-63e5eb5c731mr5960661a12.19.1761484434295; 
 Sun, 26 Oct 2025 06:13:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85308c8dsm462226766b.0.2025.10.26.06.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 06:13:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4B0E15F7FA;
 Sun, 26 Oct 2025 13:13:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alberto Faria <afaria@redhat.com>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson
 <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>, Brian Cain
 <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>, Chao Peng
 <chao.p.peng@linux.intel.com>, cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le
 Goater
 <clg@kaod.org>, cw@f00f.org, demiobenour@gmail.com, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
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
Subject: KVM/QEMU community call 28/10/2025 agenda items?
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Sun, 26 Oct 2025 13:13:52 +0000
Message-ID: <87bjltkdpr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
28/10/2025 13:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


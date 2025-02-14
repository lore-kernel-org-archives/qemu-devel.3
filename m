Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F42EC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 09:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tisTX-0001po-C3; Fri, 14 Feb 2025 04:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tisTV-0001pP-1N
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 04:59:09 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tisTT-0004L9-31
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 04:59:08 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso384922366b.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739527145; x=1740131945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yT0N1IHXLPUKuQIZEiQh8Q9Eyjv6b4BwDLppwHWjDus=;
 b=F77io5Wlc1xRQ0us6D7398/+Rn1sWw3kDNQNH3OlSqy/Ug6lqNjNTDqhN8+Em3F+ut
 iONeKLd8731CbVl2Gkij55JTz9byhNzvbFHVVUEiorkEVV4nWFaONaZtAmjIPwdayP2C
 QFZ+Dgr2KhoB7eSakE9xkW3i6IMiiV+M6mqBIwlVFUSBzexLwzMlTWYxqPRSTTqTAuJy
 UL5ePZURMRc8cdhKPaPdyIiJGdRGbLkGvy6Qm9guUrdNFqdJnOc1+G9Tls1D4n7byaWZ
 5IjeWrY4S6Ir/VxISHmbhnWG7qzyqf0McfmggS4FnH8i2j79VeLDSrBZfuBXQ2/lmLhp
 do8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739527145; x=1740131945;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yT0N1IHXLPUKuQIZEiQh8Q9Eyjv6b4BwDLppwHWjDus=;
 b=RN2fovm6+HdM2FTWZoCsMEbBMlIx6g+y3Nr6W+SfyZ/Rhuf49xD/9HSRKoyar7RKoS
 2xigeglHin8EyEL3d0ijWS8ewGOYx1sCG7tbhlYTKwI9QCtiSKeanYVa19R553bjje+f
 0gGxmzrt+e84OhMI33dkXxeCiaFpHKG1oB4TBXh7Ck3cMjyLtgKk5ZtlHAtAi1aI5dEq
 FZLa+WEW8dab9VqWjyal/2vzVBfrAICXJgCIGKN5Rbx9h58SgmqUHLInzpsZDQa2WHqY
 ExEzS0sYV5AtWs3ENPdok+6Kfmlw2OONV5ERL3ZpX7BtdsKrzptK2jcnU+QoABUdww/3
 GpWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeedl5c/DzmSfHOuA5PBawOpsU+bwbWjfKhp1w6ZLg00oPoio2Zd+SNdrDq37DR0jvNM/F4hYZN34X@nongnu.org
X-Gm-Message-State: AOJu0YxkNpd4X5IMSrpcx1sVwDBAM5PXXcn5cuUOSekzvA/pZSYQNpGK
 Pn+JtrnGMOF8NtusZUAjk6m0X6tHGhoMhRzOF51Xyt1AjtRpC7PzBSa4LCKxzxI=
X-Gm-Gg: ASbGncvPVGqiOsqkAoPP0xL4iuxXdnMsy2ggMtNK635/khArPjZdNwA5hbK8SkjdJW0
 Xxd9+zB8rI0dgFDBqvIfmsZ3T7iYeJyMDLBlwNT3oz5NKyngTlmd0K/9Q1SYAIy9NdXOwFtL/2H
 xkuUqaoXxLMnIgZNJwDUBt/pQUWWFP/68SAn8NXX6LnBT0IVdTCfPBpBKyR123fgCzjMGDoK4o2
 rMvIFqCWJ2QukAh0HnBiBQamJoD+JxIHQVOA4hxQQYUbwLf3B7sAw+6IBrNzGEVN4A8A/ne9Tmp
 hcDFlBI59Pgi0orvHg==
X-Google-Smtp-Source: AGHT+IHTix6pjQSrkj1pyAL2MrX0g5cyiXiU7Q/sv49PeIuQ4/1wGQoq8xuzjyeh0H3hI1XdKXa1tw==
X-Received: by 2002:a17:907:3f25:b0:ab7:e278:2955 with SMTP id
 a640c23a62f3a-ab7f34a31b8mr888570166b.38.1739527145050; 
 Fri, 14 Feb 2025 01:59:05 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1b4e02sm2628936a12.3.2025.02.14.01.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 01:59:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E181E5F7DF;
 Fri, 14 Feb 2025 09:59:02 +0000 (GMT)
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
Subject: KVM/QEMU community call agenda items for 18/2/25
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 14 Feb 2025 09:59:02 +0000
Message-ID: <87jz9sq23d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
18/02/2025 14:00 UTC

Paolo is going to give another rust update along with an overview of
how a rust backend goes together.

Are there any other agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FECC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 13:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4JPK-0008V0-3x; Mon, 14 Apr 2025 08:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4JPI-0008Uk-2l
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 08:59:24 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4JPG-0000ji-4j
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 08:59:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so4218511f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744635560; x=1745240360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=61fQdk3eHof+LpLxQniixZJkQfdyWbShsvwC6yK1p3E=;
 b=kxsSzHUZjjIGIsDTEGSwUa0rDZp89cfh8f6kPNXrMjUqH4Q1DfBonNIC6uq7kErySW
 P5ZGu5R/4ImkpIYevXa64BfpMYM1lMDwTs1bZEhtUSMrlQiGHegQEofE8rV/dXGWE+di
 FXyh0SS55jefU54nOiOKpBPtmPvgKGRg0OimUFY2imxKypMJuMVdbCNrt0dGN68TvrcG
 4F3ubgVVZ4sEGDrHXozZMkoawEpDMrhDCaSlu+6xY/5KhjXBfz2mPjXOl8p42sNTCN80
 Y4GvXKVP6jBuzddTYhsgtj3vWcBYQw52OZbNElB9R0iRsJNlloj2ujhCSqXylr5Ag0PZ
 qWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744635560; x=1745240360;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61fQdk3eHof+LpLxQniixZJkQfdyWbShsvwC6yK1p3E=;
 b=gd0GiTwdncBKq/hwWHDma7C1fyX6iMmwIPKZKcM+XWtGEtRHNfIDb/AicCvz93EWdM
 JU3N/fXRe8tNjNvmEXQKlNZWdl8Gew/kerXgTSQztZb18WN1gQwaXGi6fXNSHqaiuKAJ
 +QSnWPBNTlSXdEH5iaHijN417Tg0fs9NKYa/OV1gGd+i9r7gGExkeqsCPUp3uNtTKGwf
 Vruiib3sN/dOc3/89fqjj3NE5MRzI1FxfSCgdWI7+DaNRFJmawJJJkQJIUpUXhqaWH63
 FZfeIB/tivjwC692pWNg5yxDLic4aByc0Namiz41+ApKqTWOEAsCmMBkSdOvuHmPbcM1
 fANg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrYtiyn9eA/3YOJO/kW4MDz7GZwuVVrL0n2LAFJqVWC+zTqFTAxcl7gK7IJnbeMVSl7PsHqF75groj@nongnu.org
X-Gm-Message-State: AOJu0YzOzs1IP4JLKa+hTfdwnxbMQza+4W2uQivJiaLFl4xZ2mty2rE/
 he96Olt+FFVBsJbbF4e3evmfWVQHaBhOPQ2gMg6V/cDiFuRwkDMd7G8oUNT3NKo=
X-Gm-Gg: ASbGnct3u7hR54EljC3vCqRm5H2Vyy5JAXPMuHf4RD4sydflnzsA7R9Phgm8USIf8ua
 +3GtvnRX29bgWQmVCsX3DgzKRvY5hwHXHvBwB26N81MRrMeZ7A8DalQYACzWSJKhbSNt6mJB2BG
 XXJh+TRKq49oIuElFHgVEIMeQadv9WDysRJSkU+xUisfg2VvU5oK+F8yjHSeoOsqqUvGrCQEl1Y
 Iw3EIJEUKufXmZ0LpP3b0DXl2rFYCe1ErlN+bt7iC7br49WplLws6yb3j7YPw6OfN9IKD8uczm9
 pO0a/D2VL6DXy3Bqd3KPeHAzG8T+Lr/UlhiQR46INZs=
X-Google-Smtp-Source: AGHT+IEbtNZH1cgvJKElKanKhrp/wDtWBA3gfR/pk0kYpPBukstuQeMRChJKP4MobkLclVkUjuXWhg==
X-Received: by 2002:a05:6000:1acf:b0:38d:d0ca:fbad with SMTP id
 ffacd0b85a97d-39ea51f46d0mr9704272f8f.14.1744635560278; 
 Mon, 14 Apr 2025 05:59:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43ccd8sm11086878f8f.72.2025.04.14.05.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 05:59:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD8125F8A5;
 Mon, 14 Apr 2025 13:59:18 +0100 (BST)
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
Subject: KVM/QEMU community call 15/04/2025 agenda items?
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 14 Apr 2025 13:59:18 +0100
Message-ID: <87ikn6ew61.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
15/04/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


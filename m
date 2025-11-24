Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502E8CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 11:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNUl6-0001oK-4K; Mon, 24 Nov 2025 06:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNUkY-0001lc-Bd
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:28:59 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNUkW-0000OT-No
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:28:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so23397185e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 03:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763983730; x=1764588530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7QusvGfy8dgBqqT9+U06ymyXNdev42S8c9khUtIfCRc=;
 b=HkW1rIKH1AMCN4KR3Ajik+C1PdF8aE1W0Ve98pRYTyj/H7A+eLePllPpUvqPr/ggBk
 ayHL8f0IjUCltr86zCIT0xIC5cFt6FWXFnwBveggwjkcIT0cd+43lUVyE7N2j1Gc1W/L
 7nGaEMREkC1znS2LEYcm6yOAWGjVsw9Opmi0SX+HpAuCQSdkRUYqqXdB5vgrUCsxT+Nd
 AAYIuWwYgQWpf6jkzlWIXyUYC33n14sNI/FvPO/ruKuaiRfD08x9Fu8MPvav21sXnRE1
 r8Za7N1FZ4iGWyYDKGI5+KNF0NqtSYfAqHNnZfyJN/BAHiSHhIevDY+oUmSXiPK9hcyE
 ELAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763983730; x=1764588530;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QusvGfy8dgBqqT9+U06ymyXNdev42S8c9khUtIfCRc=;
 b=spoVME1xuh6/6kI9w0hT+zd0BreeHwkmghkO9Q+D+MxtIaNYW8bKzmfgHwRIgXYntm
 bNub2dMNORFFxSQXqqA2XtDTebww6jGLumhnyAn+Nl7fKgbET7YqqoWIwNSxGIhPC5F2
 E+Dy8MNIXEHZ12keP1bwMjx9svxp935L8qpvui1N1MR4hRou99i3zQobqtWYxlQaKJGh
 Q/iRLuZw12ZhttCoYtlyYUrb/OThDO50s2cPZWU+QCrfUSnlA6hZAQ8mSWv3BQZo1zbk
 4e50oZ+9yuU4Kra15nMyCZx/OMnVQMz/6m6bOsBNK/YdAu/s6m6J3rFJgqgZhs+MXKYj
 5Udg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhEyKgga7QsKmGyByoXm6/AAe594gupXtXlrx4tRNQwOxna7BfNHVcTmIerXf8dgY3KBU7HrupFlHn@nongnu.org
X-Gm-Message-State: AOJu0YxZfD8RXz913KuZ7dxIIH4gIoj/UJinCL+omioEXeMzErXL99y5
 yqcfUrcto7rsV39wtMYgGoiac4tbOKUTNJgp7cbQTsRYgKRN+oLTmMrOYJb0Rzq7FxA=
X-Gm-Gg: ASbGncv9dZZEuLUwL0YTldWoPDkOyHCq9vDsJ3nyu8XxgDSOR0z60Z3Aqbe54LFR99f
 Cii0LhUKB1e6NhoVwgsg94E6ynE6a7Q+1PLsjwfK5yPQaZAUjqMDAYjXqG/bCLZ6OxUXnZkU34i
 ABqQPVMtGuFOyIgFMx0sAwKNc07vZwQU0h3LL7SUtQx0ekPYZL2x9ZuD86pGQyi+cLPRqPXfmc9
 AcgVxtNTSyby8tmGtSPgocQ7KHQsAs1RkX4SN5ypDlvvxTsHngoiDBDHCkeMKuyw9CRmEDmkodz
 EqCOa2fMET35nevx9oRoio0WsRNgExWGntTD0cgqaG5YFV90FmJDsL8e8qpHXrEi1Q8Y7yxxFLi
 pxF7uCmM+WQiRitJVxbgG3/v37k+yzjUJAjdaDMKm3UGBqaZqjusPeDRFQRe53ZlAQoU0jP2n0j
 snfyoChaXBjEVDK0KhuHzRMA==
X-Google-Smtp-Source: AGHT+IGImBAUZZz5IJPsPKUPIEtg+lcga9RXijqvqOcZZnuja35mxsnuQn2jxgSK0+HKXitoZGLOxA==
X-Received: by 2002:a05:600c:468c:b0:477:79f8:daa8 with SMTP id
 5b1f17b1804b1-477c01b219amr112910105e9.17.1763983730574; 
 Mon, 24 Nov 2025 03:28:50 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ffesm28650846f8f.10.2025.11.24.03.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 03:28:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1925E5F83A;
 Mon, 24 Nov 2025 11:28:49 +0000 (GMT)
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
Subject: KVM/QEMU community call (25/11/2025) agenda items?
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 24 Nov 2025 11:28:48 +0000
Message-ID: <875xazacun.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
25/11/2025 13:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C144CC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 13:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdr0U-0000b9-VA; Fri, 31 Jan 2025 08:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tdr0S-0000af-EN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:24:24 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tdr0Q-0005m0-Oj
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:24:24 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab2e308a99bso378240766b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 05:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738329859; x=1738934659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3M9F1/5vkIOrm1fcMjucdaqUtBTjno00tSzqG4xsEE=;
 b=hlJgjHABV6yEFfWvzqVRG/N3ZCU51hO8fpzZve8/yY5yBuBOZXdEUk7ObNJ8+CHZQ8
 0N5HSOB+T/qTRtqk4kvYEXapqUiELLCSc91+0KU2B0/lpWmEui4gr5abV9BUFlxX325f
 yWymyBTgrHAJSc9NdsD0SqYoFDCNtq+UWrcckJbFoQveJnUZxQo5j3E8OolkBAFzDFhs
 0T/wtYMWSaaka3QC9Ve9yqf9vRzeIU1ycfAqVDl1GCcd4h2AQauaNK62aEfxESlr1k7K
 m3lF2wEEBvwNp4Z6KAIk5zKodLr98lKbDgfh8iQfVd7xJ9dXFy/EI4iPiuJW0wk8RBjJ
 mJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738329859; x=1738934659;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3M9F1/5vkIOrm1fcMjucdaqUtBTjno00tSzqG4xsEE=;
 b=e/j8XdKdrECDxpbmEuHN4CAQwan7ehAcJyJJZVtqinv6f3KOjcAouFuJqtW8IiWhc3
 kIqqPHtGRnxLn/pPEBdVQYi2hagIWd3f5uEmgxlQfsIj7M0WiOae66RX9AVYW9M94eK/
 jCpskrqaJMpOhvNC3E1K4IEW0m28ZRkrvRdfsQqHDCrv72OtPlLX5cesNKFnpc2/X9yF
 PdZhV0IfqcdyT5z09Ue9Y/o/sYBGpjSCLBKHUsFh4Moa9MgrUBVKiUR+IVk6P27RFFy3
 pee5k+HEqnVAmyV1/CR5jBRf0SxmO2Y7h5uFf0pkhBn3kAjT7Xjqc/Jj6qIgTeTg21IM
 ShDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxMq5CHsCoXKVQA/iYGiaBGZ34MqZB9qjRw/xzchsgrr4mtTMZeR4S3nsTmVXaduiGbelDiy0HLeIb@nongnu.org
X-Gm-Message-State: AOJu0YwW7t/iwMZ5YqEck2Ce290NiBilv2JaIFPwDglC1oPJByCHE5fq
 jDTFK9nN/84dAkLpCkjj9ZnplTLD71Qds+OfUgavTAfPs51HbtriMh9mchKegFk=
X-Gm-Gg: ASbGncs6EvsdUP0dMEycmOvsWzaXBm4yiqeu+SIIO0JO9zQ4pPo31hPczvaGOsua6+l
 G2UUSskQe0t4Y4UMc3a+BA9jSS8VF2QCYntseofzVTOY0KElJfuj/v/PLJCy5lnBXEs312T/F9L
 fOu+bbm4Zchu4XJMlko/G7UyGFYapYq7FNGzehLQPqlsNhEl2gv8bNaHkSLv/GfizDuTKj2N5SS
 lKKflifB6CftqOBNdHuHkJy/rZ3M+5W8ihnFlBv0HsmxS/gw61N77fdY6neepeBwy6VkxZXbVXP
 K74toD+X3aT5Lmsmkw==
X-Google-Smtp-Source: AGHT+IHFXV0qtnAAIyPlLoD5xOWMKXpch8gNt9QcOZ+uu2nNHJHlIiM5u83idL8cXKFm2Sd/jGQSXw==
X-Received: by 2002:a17:906:650:b0:ab6:f88f:bf1f with SMTP id
 a640c23a62f3a-ab6f88fc26fmr348739766b.27.1738329859266; 
 Fri, 31 Jan 2025 05:24:19 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e49ffd63sm297646566b.94.2025.01.31.05.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 05:24:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89AFE5F78C;
 Fri, 31 Jan 2025 13:24:17 +0000 (GMT)
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
Subject: KVM/QEMU community call 4/2/2025 agenda items
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 31 Jan 2025 13:24:17 +0000
Message-ID: <87r04j15ha.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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
04/02/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


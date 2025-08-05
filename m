Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EDBC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 11:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujFPa-0004HJ-An; Tue, 05 Aug 2025 07:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujFOX-0003u6-Hp
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:59:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujFOV-0002Ls-Mx
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:59:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so39027685e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754391586; x=1754996386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3XkL/9f0INPK+Aoi8p62Is9/NHBrhuVvKvYDk3tDRMs=;
 b=KXFImeWx10mZSCYxdxOL2PZBkzi+ZTVs6PdU9/sJRmChad6lPvFR+Mg7pKeSXfb63z
 b2NR0AJ+FpPyG7zBQLv2xH6jbP0gVsoiPnlExuoeZPN1KGxZdABeFilC8QDQucTf572z
 EyeB+9U4sQvSxB5c0o9kF3ivjfvwe7dx5oee7VVGKoYD3dWrqI4pOxPzczUPE0VTquIQ
 ctNsmZgUjPAmL6D/HHK4TqOs+zYwpbiu5YCe8PdlN2tkfDvEojtgnL9nNaXL60vBTU1r
 U1lcskGjdeJVRnHN0wjO4GiNArQt9Aav7E4rHQC9sOtwnYadQb4ZcXWtmrrZp30QKKvx
 zrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754391586; x=1754996386;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XkL/9f0INPK+Aoi8p62Is9/NHBrhuVvKvYDk3tDRMs=;
 b=NcehSoM43VkInBwVeMOf7ngyekgUC3PMc6fhJn7j7sB0+QaVZaFuvLP0VhrPpo6/DY
 ASm9FXO6uZNU//FWAWpTTDDNJo3r2JJxwmdmmiAL1zrOFZNShevH8cvUzUG77aSrLVV5
 AduQmtKfFreyzz3QtvJCuwSs0dFkE6xD5Pgqido5bNmjlkX90Pja0ZKFzvJWrMSemb6I
 ww7oSJTiepK7AgGTR5R8sUoJJHOvy5vZ7BhgMM8N2ly/MDm4ffKiSkh/f2GdVFfoj0tM
 jn2k6u/Ip1k3lTSCWdmZrNrdadjesm8djILbMMY4wubGJjgWU4mLGXUmZuTU9q1vrPCd
 LIvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcGISGJlW5C2P4ivpS7e7Ukfmtjd3zi9PDFE4rZjynV0HJrJ9cK6BaqxEf5aiRaHNJ95NNuv56c2dH@nongnu.org
X-Gm-Message-State: AOJu0YytHa1tiPrjf2L/e3UwCNZ2uYiag9vy+nnXIlT+xbRrgL0+yCz+
 b5WGhj+YTgvQNoSvynUHnTwzwauVrqP472vQpel71UqUmFozzztP/5BP1mosNHYq5vc=
X-Gm-Gg: ASbGncsOfqOpKdP1BHsYJ5bf3uK2rkbA79fqMfvK9VkXJT9kYfFsnpGJiEYLC/DlU6X
 hoKR26RWy06ubXXOfjWiIXX3xSj2NNtri+sKcFEtCRFt9v1yCwN981g4nFLXydVu7e+se3G7vn7
 KmHTE/Nk5bvos3/e1FhDsa5FesNbFnvAQLgpRe9y1f/kfMlhWicdhGjdrMDOb7GmiCDevnVO3PF
 oq8D28pZysBUo6Q4C/iciSnBKHzE9a2gnusS0mqs66tvHiAIFHjN7BF2XBUuNYm4EemC01Tv3aq
 AfIyVosVHYOcXRHBFFsfU1kOg5caDKoMd7gul1uOf5LgA//R1qaMvAWXunL3kjTA30xgCJkwvB/
 Jq4AzqIRrrUEkb+0q2PgMANk=
X-Google-Smtp-Source: AGHT+IFAnKX/Z89m3WnnCJhzvXej2+pObVmj/dRkxabJM2V+0nNMWIPuSEP/dAnFcIsWHA+mHk41vg==
X-Received: by 2002:a05:600c:3113:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-458b6b3312emr97719525e9.20.1754391585907; 
 Tue, 05 Aug 2025 03:59:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9eddsm18752439f8f.22.2025.08.05.03.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 03:59:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A74ED5F7E9;
 Tue, 05 Aug 2025 11:59:36 +0100 (BST)
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
Subject: KVM/QEMU community call today @ 13:00 UTC
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 05 Aug 2025 11:59:36 +0100
Message-ID: <87ectq3ug7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Apologies for the late agenda call, I just returned from PTO and was
busy getting through the email backlog I forgot to send this out ;-)=20

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
05/08/2025 13:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


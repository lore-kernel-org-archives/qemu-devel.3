Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C87C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wNs-000196-0l; Mon, 31 Aug 2026 03:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x0wNq-00018w-JZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:24:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x0wNp-0007qg-14
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:24:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso9650835e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788161082; x=1788765882; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sz8lJvsDlp3AMZnFxEFmaT6IJ6cRV+2TBFHUih7qSf4=;
 b=R2/lc7wGi3Y0/rKTbXiAIK2JFvrAS52u6Gud6SJe2hDaKH2XIGd8ham5D8KagJQu3A
 RMBuOzqheTS/OaVlDWAi/4id3RGUW20egq9E/zLRvOpQIv5f1/0dUSI0ZDVlHr193JPI
 oJBX/c+OMJ17nF43Ykvcno0xPz/jAw5l25OiRMuBPX87X7N48kGdZluxWTOsUI1e/DQD
 dUocIXc2vVfVfBJd4NyHrOmWU10JfCa+KW8FQGrN+YTvb5jfTAuKVuE1glseXk5H27zT
 KNRYWd8ROA1/67lQ4XkuY7IZoNs5Ywte8+Q/z5ozdCn+ld6Ofbsn/Uoz1MmlKSR2FOYm
 LbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788161082; x=1788765882;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sz8lJvsDlp3AMZnFxEFmaT6IJ6cRV+2TBFHUih7qSf4=;
 b=bRmos6ZqAlr28xDNpcQ9/6qnGR0sDjUDgUMk4qNE4F7XBU6x1eJ9L+6MxyptFub4zM
 9dT+imHB3b5bJWgbeNyDTHmbTmDilxKx5p7S0VdqxwsmewghOh3Fzxv26bFbW62KvLpn
 GCP+gYk9DUrDCFP5OeuSXBgd66awHBVELjJlBVC9Cz7KVCEi/yhdf5gXtYt+u5AajrL9
 1lOIV6c1O28p8TvStOEcgJ18KpMH6wNvk0bT4t50JZFgXqnUKv5DN7ixPUeXGgJ6vtVX
 SCPYtcK5EyjGZ+wDUM6kTy8GUf9S9ZZAPjDuBN8GS7VWGMMrF2ozYhtBFKiyGBDi8SN/
 X15A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUyZIDlQVN3i93I+87fu/mBeTWUI7cSfs5qEEA8gu8XmX58miPn7SLEDrUXzVGinHEZVkJ2MHG3vUq@nongnu.org
X-Gm-Message-State: AFuF++lwjruuW5iXY1ZOArcFTDdmjTh881KmMeomZxcUTeX5epCF9JRS
 MPIG8fraH0SjDrkZCVBpq5A3eaE85Cy0sM77WIF9XbxY8yhslDjgoviDT6qPZRukYgs=
X-Gm-Gg: AR+sD13ZAAyazSZmKqYZCOZSfmjadmfq8i1oGq18BNZDKuZpM2x8SfqaLCqO9x1XZep
 AbP1GSt0fMLTSIz6YsjFHYNZ24Nd7akZR03UTCTQonlpe463wSaiUzsQUXo6FRyYug2tSx+M5ng
 j+R7QeTfHEvqOAjELKRDH5d0GBpMqrOuf9SJZPMkrR9aqKJ9ssxDXtmJoh22IwqlpE6/TeGuo0S
 8s3BwVLYyBfe9il+fY+cWKf5LAuMVvTFTiM1pOcnUyr+3SubpvThk/7rpGvubjw3hxleyI/Gyoe
 E6gp9AqLhYEU3RonbspaDprKs1pfcrtK0WQ4IMumZXPqZDYG4NOKQvOgukZ3WK2O/F2sxT+jRYu
 /714hrMtt66/6uBima0gDNnDG4tU8cqtciHzLDsnO7jRcf6Bq7xpA2OwkQ2767/fCOS6cp1mWs7
 igRXsNdD51yYxQF8uw27MkOPmZi68hfh7wWlQ8DYPt3mYSKbpDfhVkK+Bh5Cfe
X-Received: by 2002:a05:600c:a55:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-49b91c4cc2cmr401694795e9.13.1788161082344; 
 Mon, 31 Aug 2026 00:24:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4c321184sm415844235e9.11.2026.08.31.00.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 00:24:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D9655F8F6;
 Mon, 31 Aug 2026 08:24:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 cw@f00f.org,
 dbarboza@qti.qualcomm.com, Demi Marie Obenour <demiobenour@gmail.com>,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 helge.deller@googlemail.com, Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, jacob.oursland@gmail.com, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, matthieu@minio.io, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>, "Ho,
 Nelson" <nelson.ho@windriver.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, utsingh@redhat.com, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com
Subject: KVM/QEMU community call tomorrow - agenda items?
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Mon, 31 Aug 2026 08:24:40 +0100
Message-ID: <877bl6eoqv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
01/09/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


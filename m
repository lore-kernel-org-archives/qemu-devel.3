Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9793CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 11:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQOUt-0008EH-J3; Fri, 22 May 2026 07:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQOUq-0008E0-Ap
 for qemu-devel@nongnu.org; Fri, 22 May 2026 07:56:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQOUo-00019l-N4
 for qemu-devel@nongnu.org; Fri, 22 May 2026 07:56:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso75979685e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779451011; x=1780055811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6cLefhImIe47DJTT2wHOTx5Ffko23otfMPEXTkuqKvs=;
 b=VGqfaLXLdX+T++6iqC6veN4sP4Ze0TYFj+yUQ9ZZkkBpNT0ec1zHTg9SjcRUQxrcln
 puiCYqEyHaJeP4pB+WlXbzU6GO6lyGmtVxKPeZhmE2E8UTkWVO1XfmWykCyKCToqwCRr
 gVmaDrnJtXhiN/A6/+wFaIK2UD6ChN/8kF0QHrmH8toP48WBP/gVFFnLlXFx34stSwwC
 1ZLtotaew2ZeXGT363iHZ6jQKBbo1YXgGavTLhWedIUHziYB7RU/1sG/XpMPAfI4/Xob
 kzfYI3Nq0cc7PZeNU73Y5/PN/j79HkVlENNlfuozRVB32RB8OWFPH0rn65cFpw3czD+h
 iiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779451011; x=1780055811;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cLefhImIe47DJTT2wHOTx5Ffko23otfMPEXTkuqKvs=;
 b=YxrpFBI9ianGpxbNtcpoCRGWzatYkXiMt4l4T/5NbFA9+uCj1zbt0TQ3NMuuZjxtTk
 NuvIo6inJYGHC2l6Vos8CA8G5xI4Bxd7bqaKpUq4WTj/wqid864wDlkJBnfr++ba1cej
 MecxLKHoq9mNnrbg+msqPQSRcjChdZy0wE9MzBsOjMv64ztGGl0ewdWEIlqyt4/ER3/6
 UEon1QD/kwKPjBg/7l6MNmIwwSt7yxPgKTSA81duL6B3E/qZNZI7efvVOlrSITLaGPtt
 AzWeJ6OEXNYY5OMNXUot67iJ/jUesqpKfYJvSDcm2Kae6Hfa6YKv8pPYYip/xDbP0Xkq
 Oowg==
X-Forwarded-Encrypted: i=1;
 AFNElJ80jAqf4mdBZkfh1quxhpVWUm44TRzdNZBzoFxoOSutYSBwO1rz9oZBzN/f7xKk1ZlN5LVVuDlx+iCR@nongnu.org
X-Gm-Message-State: AOJu0Yzk7yrWDZIUpjKGT5n/Xiy/5+yieWZRPnxcHOT2FKXDmjWB6oEo
 owrzsbX3x8fxo57LReH37lIPA00KXv0cEw9lugbNkxwRpbZqovmUBNT1EO+Dojwrb7k=
X-Gm-Gg: Acq92OHg1P4NPi9EAppkZMo5tUq11XmX47TQo0bWIbHQNU952cDgDRkQWxvW2SOb9Wl
 +a8X5KaCUCFKgOdLMTaXOtKYdgY/2AKqeE/KoGB+Y+GPrRmXTm8iajs6+OW7UGiPGXVQTZblM5k
 OMeqNnb4HEWwIP/2q2+H3U62AYXpsn0z0cPr3WZgYTO/UKiAPck/E2qfZo8qjNjj/JvQsBYFFU6
 NOMhANYa8TTHXGG3UWDpMKqXohJF1rPuQdFPk/vJSgbgj6qgtDaKPbwhygibkLiA5mn6cq65BGY
 xWoghlOb77A9CxHo8w9QtnafVReeloztzee/glzDXIYxIPoD3L6DWdqWN8pDSKO/h8YsJhpPBbu
 QIrJD9vC0K7ZN06M+JW8nl5ifO797Kaq6gFvt44PwBp0yvD9Qcz7yIGedPy859z5XyIf7BujiSz
 ILiJecVl0XmiAsgFX5F9COApI=
X-Received: by 2002:a05:600c:3b92:b0:48f:f64c:c2fe with SMTP id
 5b1f17b1804b1-490426d18e5mr48420635e9.22.1779451010657; 
 Fri, 22 May 2026 04:56:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454b7d57sm36066585e9.15.2026.05.22.04.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 04:56:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D22505F8BA;
 Fri, 22 May 2026 12:56:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 cw@f00f.org, Demi
 Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, helge.deller@googlemail.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com, Warner Losh
 <imp@bsdimp.com>, jacob.oursland@gmail.com, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, matthieu@minio.io, Max Chou
 <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>, "Ho,
 Nelson" <nelson.ho@windriver.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Roberto
 Campesato <rbc@meta.com>, Richard Henderson
 <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call @ 26/05/2026 agenda items?
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 22 May 2026 12:56:48 +0100
Message-ID: <875x4fmzcv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
26/05/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


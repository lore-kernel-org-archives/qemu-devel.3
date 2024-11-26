Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73058D5A6F9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 08:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFqoo-0007J9-3Y; Tue, 26 Nov 2024 03:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFqom-0007J0-NX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:21:08 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFqoi-0006tM-4U
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:21:08 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa55171d73cso316743366b.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 00:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732609261; x=1733214061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YVGMaNu9DmDF8LPIZpOr28OEAot8zPj/5cWlid61o0Y=;
 b=XQDviFO8lhlT+CZbEFXtFxZQwQip3KlzrYYe8HPRL6oYukDluAga0Q0sTQEa+wNti5
 4XLp27cJxGYtjqmKlNhpDNTXismthJ1dqfcwQLTFVqzjot04DqIQMFmgn86wxtUDhbLj
 LoY73mKGEkMT7455fRzRMuPgBEEI1XRvP1X/VLN4teFelV65IFX6nKefjK6PWuzqN7+S
 NJaVJ+zNV0dIbvM2ZUril1eKa0pPjBv6n5YWHtVrMVvmHW1YP+7exuIMxTmIgClvAGVS
 uD7pUjTXXvDB49esf9Eh91QybptyqiN/vTo2N7Dev/E7tIQb7mrREZv6s9cFxjJfh5F/
 NI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732609261; x=1733214061;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVGMaNu9DmDF8LPIZpOr28OEAot8zPj/5cWlid61o0Y=;
 b=kkluy5F4dg1nf5APYNKJIX72MSHfKcUVYt6K0uBvRANNnG1TvdSAoVq2rbVu9tI/FO
 73VwRgwJDJZrDbecna236dhppJQCRPYnE/Kz4ZlvgTc22m/XkdQ6NNG0IyGFi0ZwB5AI
 7lk7sqHrsugG07WDUPEUHqQATQP2SeXfHuAphxbeKdiVlc1UJblij5LjjpET6bWxP1rH
 ntGvOxvzOezs000schEZCu7Xe1Na/ODs1bnBJsWRazlyD5TlVBQZ6T95oaqnZ2Ynqa/Z
 +NqlKLDzW5ciTU1wsi62MwB3fROGQy4anTQDI6W2hGIEKgfjQfoRpnMTIH/75e0xoQ7e
 zfLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoBi1ST28EKYbQfsrhDx0W7FpR/BsU4+6WVH762YVqz3k4BmIyI19HrXeHfGrG2maT9H4OJ+CzAFF7@nongnu.org
X-Gm-Message-State: AOJu0Yz8kJMK3m/EtKQKUfIydxQd33AX90ox9gqo71heCQ7VT+4iaGDa
 Qs1guOg3DY3JHyAjAHZlEAjL8K9NS1mudA7V8f5HlOM9ShZDnbSeErE2PCtSd1s=
X-Gm-Gg: ASbGncv6tqs+On2zcHfTvtFEidxg+kIMk1xL2Lz/UqMex9bkMg5iyVAJPwtgdhgzylX
 YUj81otdNsCpOK9h7Zx4DkiVgX/jQUEIQIhFFRyXF0fvSq/aYZaqR9hRQIrlFGLi9ZowptGoPZX
 SQeDYc1s4Xs2OumVTjxZz7RgwnhHpPXJebbZSTWKlgCM7gITHAmesfC2fyL2giTLH8bcSzi9dQg
 Vzvp3Qet/jD4nN9J3I9y2UwSf/s3Ap4Sg+3LTbr/t9XJRH/
X-Google-Smtp-Source: AGHT+IH+z0gF3UzsRPn8LO25RtWzvwjy4ireT1v8B3W/ay+G18OE1vC7HIjcvqDtxhNYYxpWILUNBw==
X-Received: by 2002:a17:906:3145:b0:a9a:eeb:b26a with SMTP id
 a640c23a62f3a-aa56486a020mr207126366b.1.1732609261013; 
 Tue, 26 Nov 2024 00:21:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b3426f3sm566033166b.87.2024.11.26.00.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:21:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 93D3E5F713;
 Tue, 26 Nov 2024 08:20:59 +0000 (GMT)
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
 <philmd@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call 26/11/2024 agenda items
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 26 Nov 2024 08:20:59 +0000
Message-ID: <87wmgqbe38.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
26/11/2024 14:00 UTC

Are there any agenda items for the sync-up?

So far I have:

  - follow up on Rust up-streaming

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


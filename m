Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2C0E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 11:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKbme-0002Ca-Hi; Mon, 09 Dec 2024 06:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tKbmc-0002CA-GG
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:18:34 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tKbma-0004gV-Og
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:18:34 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so27656825e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 03:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733743110; x=1734347910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6AHRdozqLYetGglLfiayF082i+1rp2lNfDEY365vT60=;
 b=lVCEhN2N/fgzwHrcdQk8q/iFoce/4lJfRpHGya4x2F3B+XQLzyw4J0WXidt/Z6bsu3
 TeCkxq5erk1vxdw7ESv69qUjWiPEjk3maY2gtq7hBWny6Sjf0lfjyggaX8dqSw63fAnT
 ydxNJwWTxuT27a8w0vsDRNuoVqpTlLfhplFB7vXTqQRYCzXQxwqLKcu/qSci4Sn8MCXD
 6ASy+1reY1ATlC5KhYWEeUBLZQ64VL4z+1iZfhYSX6O2SCjUS4o/Y0qfg/8pep6ZJumA
 NcG4DiqEkRZhpJ0mxJwiXEX/Aesmo70gndd/MCqfQ0zhCUJ6vEXB/C7krH9qt5sjOofd
 tMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733743110; x=1734347910;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AHRdozqLYetGglLfiayF082i+1rp2lNfDEY365vT60=;
 b=iMuHuo3y3acPkj6xzCw5ZutClvBK3eojpWixkp9MdrC7JJsd3gT9FxZk2hjoljnD71
 aTjDq9mLFemotawxlg9rq4DYyQeVkM2gzKmuV2LGPjvpkL1/1lCqJakjkcGSMs5TnEbF
 2u+hamY2xSRntFGV/MsxvvP14rpLgMilGnwLEYG7XU+oF8g/yLwP+3VV3Z3oxqS+FnaP
 ExNbcNXPW4GPSABbnXsL5qs5Ekjsv3aforFEz/0sXoIEfcURwEqNazCEhFRmaJVJqW6e
 uonIb1DOIKs/jWWNCzNqalX4qsYRwoML1o1ISHuydeU6Yv+6QZB56mt0xEOeYRXAgbRz
 +knA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd36x01ONuf/JTzQzSlm3yIobhcxM0rV3v1OBRQa4QfNvvsP0lXCeegOZJN4hdJzPHh1CPjecREO6f@nongnu.org
X-Gm-Message-State: AOJu0YwAlOlAbWVgj0cDUHCRn4HFwUBeYD5v+6VyOPDlHWp7nVbP2Ll8
 wWBGpHuJlBlTOZwpDTEo+Qfg01bPj7mFqSNOXnbr0zR7Bmr4T09VQUsEjgzlBks=
X-Gm-Gg: ASbGncvwlBAHXCsoJF4UzfyZkYz9SwsfqzQ8dqpmiqoRAgu6GDB86XiVJlSH0JxNsGF
 WPOp7fqGgbCe58xdh+syFIdDG4nFzm2Rx+D3oW6tthTxj08E4BDDzco9VWiFVglZyA3L2+xeZpA
 7pg4SF7c5jl1bm6LvpjJbfEjCk9uBY17ePbnitgBkU713BWxMsvhdpj5bvrclQ5HkKHNYHJaoj+
 5dsK5r2AhXAhtQnJWMaSFB89XeyMveI+KzxZb3vXQE0/7rk
X-Google-Smtp-Source: AGHT+IH2x8faGStyew9BBDuS/XtUEPSA30YIcBT/dfMb/VJxMdKqN1o1WwYQGw0Poyk3UhcYN1VLqg==
X-Received: by 2002:a05:600c:350c:b0:434:a6af:d333 with SMTP id
 5b1f17b1804b1-434fff5567cmr261385e9.16.1733743110604; 
 Mon, 09 Dec 2024 03:18:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862229a88asm12691119f8f.106.2024.12.09.03.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 03:18:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 51F765F858;
 Mon,  9 Dec 2024 11:18:29 +0000 (GMT)
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
Subject: KVM/QEMU community call 10/12/2024 agenda items
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 09 Dec 2024 11:18:29 +0000
Message-ID: <87ttbdt88q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
10/12/2024 14:00 UTC

Are there any agenda items for the sync-up?

This will be the last community call of the year as I figured not many
people would be around on the 24th.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


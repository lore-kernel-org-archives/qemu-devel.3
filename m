Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBA8C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 09:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdEJ-0003Sc-Co; Mon, 23 Jun 2025 05:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTdEI-0003SO-BN
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:12:42 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTdEG-0006eA-Bl
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:12:41 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60789b450ceso7597889a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750669957; x=1751274757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qvJ705RtX2y6NsTIGGtos6Z2y+BXv5yy3WZCSsPvnL4=;
 b=Qgg6qbeAmE/NJcApXUT+K5EtNhTfQ302zkrVpDw6pqaUXG1qlgKYrVX8VNmewwrV7P
 7cuFs9FUfI6FWeGEHdb/mrk161pE5u/OfD30D4zhnbtnlFHHzu4pfuKy8C7JA70BOJur
 zgPFVAxNxmumfB+pPMein9kKrtP1sMahzFdam6nWyl87AvrDilYlY7JLuxLFhgAN6jS4
 Dk+MOluf5J1rye2VK94YL61qr9VEFVUKuhMqBia1ENleRgOCwHh9M5lMMinjQmXw2kEw
 8Ml5GlxDXB+lKmTgcKKXVDA5Pi4BP7pB19G/t7a/JfmfhklSgfuhjhwzZhFt11CqwbGF
 xP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750669957; x=1751274757;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvJ705RtX2y6NsTIGGtos6Z2y+BXv5yy3WZCSsPvnL4=;
 b=n54iR/oL4o/g+NjX5150p/LTL7E5nKKPWz5FEipzpasEQw+4nBi5ZIywli4W/h+bIQ
 U+LzeKvKd2lRGWf0Ld9bW8To8NGXa1p3mKvJPHwklKIJDf/Aw4CvqrzUaZH1BW1ONQbz
 18tbfznVVh1oZXUknpRk2Fsl3GMw7uLbd+KWIjPeHZb7CDRo+LnHARaAEsqD3IGR1liH
 oeRgxAH46iV7BV/DTWyyoRSSrbGQ5idbvIqHFjsX1jZ7nhLX859oRkgj8J/j2MNfVm/D
 xF34LBbycMV8eEEU3ytutysDsM19I7V4KaMrxQ5uyod3wvQh6qF/vxre82DY41wKfwnr
 ubEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWg4V3CDgfz8sbLyURP2QA9iR4K2TxHj38xIQgSOD/2fGVIx+EFSCf0gemavc/BKgGNBZDqtoyQ9xy@nongnu.org
X-Gm-Message-State: AOJu0YwXmtYLTXqoiBvQwyH8+phSQS0XJEjC0JmhyGUKtZCvtKOGZq0r
 zGaDMyEdgEjFCsKHtBRY6W+l0KlJs4Bpf3BfS2dX6yuThq2e8pVFz64ftNtsN322Lso=
X-Gm-Gg: ASbGncud7UmoQZEWhsEVp0q+GYVXgvU11Hos2fn6FdVP/FPXwOPsAUW1/cJg+eIfYq0
 0/kLNlRHXvQdb4wvDq1DOMuB2+FC0A3hDG//KAs+dbvxxqqIjAjtMpDVqkM965XHkPsNhewmD4X
 2yfx11sX/RsVmyUlePeC9maci6Pi0VZ7kfBSsLb0PIYWWcuu8wTXPL9bVKtHBgycrxL7+0cWXt7
 9uLQakhMqs63Hm1w82ZiPTdMXuygxtFUux+5QP7sUG4eAnz6M3TYaCdMZ9axy3X4MabPCb1h79H
 XExb64R0jjN8R/DJWD5rxuL9tOwR0y571MEZl6wcANgZPxf2Bd+6dMUlbV09EvPOoQqrZ+rjjg=
 =
X-Google-Smtp-Source: AGHT+IGIB9xVfqXO57oA5XepWaycxgy4mPR9jP7lLIGozb+CltyVikCu3K0f+bEhayd8gNJd4UOGLQ==
X-Received: by 2002:a05:6402:3594:b0:607:ec09:d462 with SMTP id
 4fb4d7f45d1cf-60a1cca909cmr11166664a12.7.1750669956807; 
 Mon, 23 Jun 2025 02:12:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60a185795b8sm5814716a12.33.2025.06.23.02.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 02:12:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 127FA5F815;
 Mon, 23 Jun 2025 10:12:35 +0100 (BST)
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
Subject: KVM/QEMU community call 24/06/2025 agenda items?
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 23 Jun 2025 10:12:34 +0100
Message-ID: <87ms9y3jp9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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
24/06/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


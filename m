Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFCDC4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlWNp-0004KP-Cj; Sun, 19 Jul 2026 14:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlWNn-0004KG-VX
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:36:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlWNm-0008By-E4
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:36:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49557167508so8563315e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784486216; x=1785091016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u40h9dCy1D9EtQLhlV1sML2EJABd64NCr3/YGVdUOC4=;
 b=AMV0VILBLM7SpcntljN5TjQTHMZD2s2RaoId4iP6fRrF5myq0fzD3C8lpD9O0j4jDm
 n0tKI/AIgOKEvZRVMc+ZuIMeM849iajMxpgJaER6szESa6U8H0Vwzn2MgGs5hmcwSCP1
 yMVnUL6HpVgmW17C2456O1isdjwy6rI2MqmjpqJLlhVaeJ/oQhGeLqfjNF3d8Ppd7yQI
 hpbeRw3TCiGSNjZPHVx5pXaj9wnbT9Z66Q+Og//QxbEZRvELF1hgCxgJIA4/WaIY+wkQ
 zqIfvyOb9v1UIDV++7T1Sqn+2AsFprkaCk34/lCkimi8msacoBngvkGiPQWiJn66mSsH
 gihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784486216; x=1785091016;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u40h9dCy1D9EtQLhlV1sML2EJABd64NCr3/YGVdUOC4=;
 b=bpy4vpj4uuwltpYoxzRUKpTk6qfUpDv0CSZqwL/YWpY6uHD4LUXe/9XondUxqSkq2Y
 LkT3Qz9xohaHhGjugKRHIs0xBvAf+hP6my4UVZx80DXqvIxKVaMlxQypv8vddadVNde7
 pxHLdBdNaN7MZvpUpCSDAQkWFnoNz1/iOjgK/4ZwgGSWY9Ee1IOo+OJXZnQufjheSO16
 ihG1zlG7upWy+shPprVZ/n930fj09EnjB3iwC5tayCaAv9tYO2t0aogrQVIa1nu98+Sr
 FGFqI+KoeLC6xuoUbVgkGgEcQzlbYJ8D1+5WZwbIbUoaw9qGx8WeEj8EyV86O4PGw4eP
 Watg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJWn9bqxl/aMCxhq+rMm5lhfPCqSW4S5CDCKHar9wc8AhSNYRMdRq2nbets0ecR1bOfrP10WqHnOXs@nongnu.org
X-Gm-Message-State: AOJu0YwKQwr6trNlvj8zW8evFYwcghexTO0vwBgheqLglJHeizJxSJfa
 /MpuMuXYc2Gh4WDJiFr5SHz5ZNXrilsc3leUNbb/6ejVK+xFT1/VRohrS+ucstXwUAM=
X-Gm-Gg: AfdE7cm+FkQUisZ7hDk1GsHaAY6Gi6HxuZ7+qICxKYsxcWu3/3Wo8PxXs+P/kj/rZKD
 bzffy3o9tWmblVdfgpVUyai6mc/Xx/lsmuBTGj0cFvVAzfw4qgsB1Q9gOiHXhc21j0TJSxGzIXH
 C7oWTmPoAZUfPd58gQTE27yRXeaZGYR31Q3xHEkLo/p30K3LXY4QE+0DwbCHooIDgT7VUNE/jGk
 2q6hxrzmX+4PBIiJ9pB/bKcqkrRWIZmpIYk1RSC20N+GVZtnHJYy9/rJGpiyLARb2BXx9ZWHJl+
 KKwO5EWdNZ+8EH2wZPRLmejEZI6qh8c3uTNtlcD9VLwkVYUd+oucxLnxTMksOpR6eZEC5vMg0/n
 H+9AtKo794S8fg+usctA7o/PvudedDwPjSuHmTtq6j6oCjoIHqBACrPv1ovsvPjr4RfUFbHfRRa
 ZW1L+5UBZkjh6c
X-Received: by 2002:a05:600c:322a:b0:495:5dcc:52b4 with SMTP id
 5b1f17b1804b1-4955dcc535amr10909585e9.3.1784486216146; 
 Sun, 19 Jul 2026 11:36:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955dfa4a97sm31034545e9.4.2026.07.19.11.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:36:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B4FE5F8CC;
 Sun, 19 Jul 2026 19:36:53 +0100 (BST)
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
Subject: KVM/QEMU community call agenda items and host request
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Sun, 19 Jul 2026 19:36:53 +0100
Message-ID: <87v7aag722.fsf@draig.linaro.org>
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
21/07/2026 14:00 UTC

However I will be unavailable so my first request is for a volunteer to
run the call (and record it). If we have a volunteer then are there any
agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


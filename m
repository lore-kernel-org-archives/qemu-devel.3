Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB77C531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMZq-000107-RA; Tue, 20 Aug 2024 06:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sgMZp-0000zU-4X
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:59:01 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sgMZn-0008PP-Fc
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:59:00 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bec7ee6f44so4900155a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 03:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724151536; x=1724756336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=brsCAxidmfhStUHuHeps+Vt90YiRUgWVn8ielNNUEkQ=;
 b=Z4UUTdJQn9itzOEv188P64EGbaf4s/eMpv+QnGVYrdxBQ3n9yPub1lnPYNAFM2hh9q
 KUr5aOPtK3PZS5C/HMwC+DcUBelyKhdRW7SlTgB4m5rbUyYN1m5A6S8zOtMldoxc5qat
 JQsUf5uUy4ZVcnHbI+yidxmFbeqTm2ZGLLDNsO+Zyant3dwaxHIwuF75qtbUnpYd0lX3
 53YNQUlxOWI0vj2ziX45i0S1EitOglUCwBxqB36cxKU6HJ5EiDXBnBVwWipDgVq5eSv5
 I97ZwI22fUzbI4HHV2nxe1s+J0aPxejVAjXNwRkVQ1uCbKeWTwfHYb3ev8fXt300VcoT
 e/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724151536; x=1724756336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=brsCAxidmfhStUHuHeps+Vt90YiRUgWVn8ielNNUEkQ=;
 b=tPzJVpXqbvwmw9bOHRiX42jbPiXPGHYTBNzJgASVOzTsFeZ/FvfPvXaCxgDEO4k2ao
 +Ulqrx/WuEZ8biBoB37ejg+T9OeDagixbaau//54KBCb7NqQHXYULfZnKMDcCePxvD3p
 IRQbj4oFy1lqQ2Qf7D57zC89OybCBC1DGjubXgJWyT9WprWMeQV3uEqwQGB3Tyg5goCH
 UeCSE2XH6w4a0dnE/3TRdUORFK/URHuPtQlQSSedYU8mKAtWIclLfM2TVTTHFq9NXzQZ
 AC4TnnC+bxA5s6NdqGIIGXJ6vNtb+rBJGpXcIxWNrKsnLQx1F02jeXRxMyUm1XYIhxeR
 6iBw==
X-Gm-Message-State: AOJu0YyY7yUoWS7y2eswVDSTlmevVQoEfU9TwPgXz8n0ctap1r8Vj/XA
 0Ei7bEZuGJ/vnfcDquVRBN0WXZc9UDwWOagOYFVWVh+S3EDhZLlpfHZiBwbfPCo=
X-Google-Smtp-Source: AGHT+IHhJXBshKR1Ly7iuspnq3aOEY1M40XMGno3jlGNJRDOsbQM0bd0rVg17NUB8fUBmzs69gmrvg==
X-Received: by 2002:a05:6402:2792:b0:5be:db15:b3be with SMTP id
 4fb4d7f45d1cf-5bedb15b604mr7594866a12.25.1724151535828; 
 Tue, 20 Aug 2024 03:58:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbe7f17bsm6737345a12.59.2024.08.20.03.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 03:58:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72B835F7A3;
 Tue, 20 Aug 2024 11:58:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Alessandro Di Federico <ale@rev.ng>, Alistair Francis
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
 mimu@linux.vnet.ibm.com, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Bernhard
 Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas
 Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM Community Call (20/8/24) agenda items?
Date: Tue, 20 Aug 2024 11:58:54 +0100
Message-ID: <87jzgbmpe9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
20/08/2024 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


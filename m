Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D80C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9mlM-0000yN-8h; Tue, 29 Apr 2025 11:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9mlE-0000wY-SE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:20:40 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9mlD-0003uy-2L
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:20:40 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5f62d3ed994so11186649a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745940036; x=1746544836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liv/jGDBXoA3vWhb48MyqfIOZMfsx4+H2kCwl2c448o=;
 b=nvouBR+V9LbDjnwHziAhM5sQXqCr99UpJ6WXtSAmbSu2Q9n7twM+nRK9GUaTL85rbt
 IezIcky0nDNzZeqkAtWYeZeaiHE+sycLHa2UPUoUyhJprwbBb/2InEy51RMrf0Ll86i3
 vz/5wsyrDudtOcDarhcRkmy0t0QWsIwZ+XJ3d/zfoqeAfs3CXVqMHRkq35qOPhba22Db
 aA0LugbeYLXKmj5WUoSQkBBmiJmvgfrJ5tPKGb6sy9Oq0LODFlRdxJkrsQrWiNckPdxw
 QUJf/jcsI+5vlavn5qJtYcCq9WRbly+TBK4aezBImSZ8fZq9afvGY3lMONkXysDImkwD
 N5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745940036; x=1746544836;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=liv/jGDBXoA3vWhb48MyqfIOZMfsx4+H2kCwl2c448o=;
 b=scxHho6y1QT6U3I00s8gdnTgjSG39kbbeGf8MiYXuXIo5AS3scqrEWcu0Xe97tf/Uq
 +ee0m+ZQcqs4Iyqmwr+COZ7ViWVTjBMdKvVQ2YhIfV7mAcPTjQx5ww5YYIl7NsfaXYbw
 po0AFWhoz5aDVM9NjkmLycXbXJo6FopmW1btoDnTePDfj0CM4sN6sEQQHRWqY8gELdCk
 tJ/gD+0GDpHEWKNR5bjww/kTaRLmKiGpnUoRV5GI7Rw60+amrVAHhLZOET/ktt/whM/0
 /RYSOmmRHit6PENiahlzjcnYHmQOFjLaTsgtvgNAQMbT/W0Epd1Bfy+a0GEuooOEaxs7
 4uJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtH/e+RSri9dNou3zHv1n0wSQJcfYW4hRTRQlFYeCDldIhV+DhxiSSHU+IWWje5/JWxVX5K+0sySCv@nongnu.org
X-Gm-Message-State: AOJu0YwqOQJfpJDbyHgVzXVZMwsGwhwU66g9V4C5implBMdVFDJBMtcU
 L/WLTdBJSV/bvErcrxruZLqPloEZWzE9u1/zOC6eZXSwsvNFaVNXn802+eeYQdc=
X-Gm-Gg: ASbGnctkBvptE7lywjz8uk1/uEExefcgR/Q9uisZJmoiVCOnEmUQAooLE/7gU7MAx1b
 C2HRpsQG3NqX2kbUVw3FZZeIWiEXIJEYQtSnSXgBJqkk1eZd5nw3iDxPK2VqAWnsc2md180Q5Wb
 0M9VxMK31mQOMOK3E+ZewLHfVjukUQrxF0hX3t2VmcJnB/IyDWqU7MoRveOzyUPnklUT8la3zuX
 k/gq7pNEHwSB/q6LwKXG2OWy475ZZmTDfjNJXlqs8U0pZq48V0GdWLAP5nrAV/oQW3UaFlZccSl
 qZfpP3sElp/1KSDRopqsbPEewf/rmv5lLbttUkaqUh24XsREjiWDFw==
X-Google-Smtp-Source: AGHT+IHwabybpRzh68vdca4n1rCdlz2ra4aEctctmdobKdfEIw119XLGJZEOAS78kKqISYDRbt7sQQ==
X-Received: by 2002:a05:6402:26c1:b0:5f6:d1f8:98c9 with SMTP id
 4fb4d7f45d1cf-5f83b274236mr3520202a12.33.1745940036064; 
 Tue, 29 Apr 2025 08:20:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7016f6424sm7750305a12.42.2025.04.29.08.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 08:20:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 77ADE5F863;
 Tue, 29 Apr 2025 16:20:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Di Federico <ale@rev.ng>
Cc: Alistair Francis <alistair.francis@wdc.com>,  Anton Johansson
 <anjo@rev.ng>,  Markus Armbruster <armbru@redhat.com>,  Brian Cain
 <bcain@quicinc.com>,  "Daniel P. Berrange" <berrange@redhat.com>,  Chao
 Peng <chao.p.peng@linux.intel.com>,  cjia@nvidia.com,  =?utf-8?Q?C=C3=A9d?=
 =?utf-8?Q?ric?= Le Goater
 <clg@kaod.org>,  cw@f00f.org,  dhedde@kalrayinc.com,  Eric Blake
 <eblake@redhat.com>,  eblot@rivosinc.com,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Eduardo Habkost <eduardo@habkost.net>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Auger Eric
 <eric.auger@redhat.com>,  felipe@nutanix.com,  iggy@theiggy.com,  Warner
 Losh <imp@bsdimp.com>,  Jan Kiszka <jan.kiszka@web.de>,  Jason Gunthorpe
 <jgg@nvidia.com>,  jidong.xiao@gmail.com,  Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,  Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>,  Luc Michel <luc@lmichel.fr>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Max Chou
 <max.chou@sifive.com>,  Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com,  mimu@linux.vnet.ibm.com,  "Ho, Nelson"
 <nelson.ho@windriver.com>,  Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  QEMU
 Developers <qemu-devel@nongnu.org>,  Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Shameerali Kolothum
 Thodi <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth
 <thuth@redhat.com>,  Wei Wang <wei.w.wang@intel.com>,  z.huo@139.com,  LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  zwu.kernel@gmail.com
Subject: Re: KVM/QEMU Community call 29/04/2025 agenda items?
In-Reply-To: <874iy85yx2.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Mon, 28 Apr 2025 12:05:29 +0100")
References: <874iy85yx2.fsf@draig.linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 29 Apr 2025 16:20:34 +0100
Message-ID: <87h6273sfx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> The KVM/QEMU community call is at:
>
> https://meet.jit.si/kvmcallmeeting
> @
> 29/04/2025 14:00 UTC

Due to scheduling conflicts there will not be a call on the 13th of May
making the next call on the 27th.

>
> Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


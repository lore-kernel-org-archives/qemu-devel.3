Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603D5CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 09:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut0S7-0007xn-Cj; Mon, 01 Sep 2025 05:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut0Qw-0007Zl-EY
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:02:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut0Qt-0005Ul-R4
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:02:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45b869d35a0so9597075e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756717351; x=1757322151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tkAgvVdJLQEOLwPMKzScG9FdyGLnr9RBOP+C3UOgdrk=;
 b=X/xXWa2WF4C/ZbtMOT58OvlEz1xwBwhuPPip8gOGbKLEquiU0Jw1yAFwK4ibj7my6M
 sZ/cPij3nNXKREPVpCIKM81EhEmTLPiwJeMx5hmxJe/IgE36azN2QvG8QaeXSU4FreFu
 xBovik4iE3vLrUpZGotazjZrwJaTps0+HXddTsOvhBS+7qt5QjoUyiFDczx7mq2/oQoU
 b2SUGbTm9zbmyJurZm2CVTSsP9EWNb9/kSiS2Y/OCOE1SB0Py1TA+2xsiKnkQh1LaByZ
 1ZnILBXbqcBs9d2gWqPLdmoCwDsczQ4JhGXqT1erNnXplJcfDQpHoPjL5zlCGu0Eu2Yv
 BF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756717351; x=1757322151;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkAgvVdJLQEOLwPMKzScG9FdyGLnr9RBOP+C3UOgdrk=;
 b=stjCE0dQYmbq4dij10Flr6E1qtpmdl68JTwC4WCcBAkleT4zokCd4GfNUmnB8w29Ij
 N82V3BbJIflx204tQ38f1t3vP8/ItIjJs7RZZeMnwuhoAzl9UAndSCWQUDQr/zCNVwhR
 8V1ROOjoHhaZDDK/COVcLa4Qh1cMFGMNR2KeHRcFmkzBq40bRsRjhv6NYHMZt01cQki+
 tkNLgWJ9NArOY7D975xuLK48RdafyAyalf+jQv0X22wAX+G/aA9HdPaU0DqhP3g3x1bH
 Mtaju1iwfnaxFwtLFX32574C1LjS6tjzswppujZYACdfls3tWlqS5UKuGwz5bHkFGNyP
 2jtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDFqRUvVEoCj37h33OzyYNHKXdQTT0z1B+cLlKnXKs11HnhJAztqvsBgi2MSuK4hewKFhwaJef8Rpw@nongnu.org
X-Gm-Message-State: AOJu0YyGtgc6FijN89TL4HLRyuCkWmAtf0OaGSs+4Bzw92kICa3CUhFF
 xEbNMpU564KcsPcB63WXPnEQ6Y3k0vgLPE84zGf27w9zNrL7BPMR8hfBadcALHxSKMU=
X-Gm-Gg: ASbGnctNTZNH/wNPftpr8I91fxm03wjS4kKWToW48s9JxjwuWuwabnzWLOnfqKpLfm5
 caPqAcG5DPdmo7XowlF0kl34QtffXKrJo//zNH88KQh8dR+ZoOp9+IWCuIYjSX0UkC69JVYrscW
 qDwvEd7NJhSvo4Jn/OPTcKL/SnI7FH7hxdw5PtSMheN/tivCBt2fbv+6FjBMQdur9JdAJEhegoW
 fBEAEyHIiStW4+mRku318ZhW0CCFwTtGDHmioZIInerG6DiX0SDBESnwBa/Hc2xPnpq3AImzrpJ
 PoAVA20K7R8x8E6s0FgztZ/zfZenhCp3OQ7/GDBXyJYVq/i7tcfxEvzKLivEflVfSK6Yw9upjNG
 oEP+uDAyuxRPkh0uCggCecY5n9jnUkNexZw==
X-Google-Smtp-Source: AGHT+IHDyOpgXFloaQYq3OmeKz42nwLehlIm+9xcASA8KzT/jr1leuOI+KvZkGgIsLSlKnq3vf2veg==
X-Received: by 2002:a05:600c:46c8:b0:45b:7c09:bc0e with SMTP id
 5b1f17b1804b1-45b8549c7admr56833515e9.0.1756717351060; 
 Mon, 01 Sep 2025 02:02:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d643dsm14564810f8f.26.2025.09.01.02.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 02:02:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0CE8B5F7F5;
 Mon, 01 Sep 2025 10:02:29 +0100 (BST)
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
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call agenda or save it for Milan?
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 01 Sep 2025 10:02:28 +0100
Message-ID: <87o6ru35qz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

The KVM/QEMU community call is due at:

https://meet.jit.si/kvmcallmeeting
@
02/09/2025 13:00 UTC

Do we have anything we want to discuss ahead of KVM Forum in Milan on
Thursday/Friday? I'm happy to skip if most people are going to be at KVM
Forum.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


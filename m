Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28CFC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDAm-0006iv-5l; Mon, 17 Mar 2025 12:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuDAX-0006f7-R8
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:18:28 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuDAU-0004Z0-15
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:18:24 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac34257295dso374380566b.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228299; x=1742833099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kbQNsuaJlvfrTxvsKPGooN8/dTzR8HlMCbkEU6lB3E4=;
 b=Bf3y1ixwWPQqIdvio3U3CA4SqU6cGaOmnnA6msS8p7L5Equ51S6WrZmk3ehlxCaa81
 JS2QzK0lQQIBN9hAsb0hAJiFT0Bo36uCoX8o2KETD4loIU695/YenVYdpe4cbURESxUo
 vRjoSXkg00FO6KDvFc6tvkayqbuG+G0e4wsKEG740p2lAK/nt7Bb75TB2Ne/nYdFRzSj
 uEhVaAY2b7dSHrgiyUTXVvhaSJNd55ZUMcrhNfrdomNNU+lWHsCHsDu9Q4+b6rXKoF5F
 DW8DOeX8L4jihyVFn305FzazmBSU2iCJGpqzBPBQoZ1eN76a1XibpAEidKS1K41xK9nG
 dyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228299; x=1742833099;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbQNsuaJlvfrTxvsKPGooN8/dTzR8HlMCbkEU6lB3E4=;
 b=bZWDXvIKJmqi+rdOU5YxEiaxl/fSDzf17tQpi6Lh0f+S3WW7olLMUyMbzk6kbX5BwL
 eZTakNh9L8omOMQbZ3OEOZ1SoY4nOqmBtk0/LhtQFQaV7uCeRUIZ4wGsrm5vbWXIt86N
 KcTBY9/sLreV5sxsJEoIS+1SLRm0kG4rJ8Cb7YZeL4/kWA9CuoVJqgvEmyiVIRsv7gng
 LzKV4+5FMlnz4U6aE0AtHo/7TROccyZsguAMBaB86+/zhNU+dZLara4rLipYKhTly90O
 Sqpu9cKrSvh12xtGJD6wovfe+xoXFfJ9NatmcqOu2VBdPXsH7xSHLv2eGVucvQoHaCJ7
 up0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN6NQSi7xGi4APjHeKAefqQ4Hd7RbAFObIC0775/WKYiJRFdqWa32iJWhgNvB84jXQBVbdJ0zO1kVK@nongnu.org
X-Gm-Message-State: AOJu0YzDg44twigNhKSLy5oowXi0WDOt+aNdUkD1QDCWEzckWp+cgwKR
 x8WZkwoB6EbnlAjvAVcD8V30gOVePrdcT5Xn0hogPwAa2c7ONquPRPt8S+m9+hI=
X-Gm-Gg: ASbGncspDXEy6biWzIMtHHL6BRhpBgOgcKyHHKFdTjGgGqo5i8J+m0J6QKVrJd0Ue+a
 lbaM+V6Kxe3xCKKbgF3TTxPK55Uu8TZYeyZ5CNz5CviAwoe9IAWHNP4teIc5yvl+W1yrNjQkPol
 JcgmiCk9NBbujcujunoFxOjQFn9Y/B6KIb+hXPhrXonapR0cusVcEXo9t8Hf7zreQErnslwqiiR
 q0CmXUqdppkJKpRl2kA/kYf9qn1IhFZHjNt2RbUtoyMhBadBLROcEYgCFUPu4+hf5jvzJZ2mVYs
 PFOHodQW+57dWAO6nfpKKykGOeiD7PaWs+Jiiejo+Q0QHMRdAT6j1m2O0w==
X-Google-Smtp-Source: AGHT+IGGgymHBdPSTH6zaRq6WF+9FAWiBmUR2Sqd8+Av2fC/3u8z8jhNYjLSJ4dODkaVTbxSPw2CzQ==
X-Received: by 2002:a17:907:8694:b0:abf:6166:d0e0 with SMTP id
 a640c23a62f3a-ac330443079mr1346428866b.35.1742228299060; 
 Mon, 17 Mar 2025 09:18:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3149cfbb3sm696471266b.101.2025.03.17.09.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:18:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C0445F892;
 Mon, 17 Mar 2025 16:18:17 +0000 (GMT)
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
Subject: KVM/QEMU community call 18/3/2025 agenda items
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 17 Mar 2025 16:18:17 +0000
Message-ID: <877c4nocl2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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
18/03/2025 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


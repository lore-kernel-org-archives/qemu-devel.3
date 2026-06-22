Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18499CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbaHR-0007qe-8f; Mon, 22 Jun 2026 04:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbaHO-0007qG-EK
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:45:18 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbaHH-00081G-Jy
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:45:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso1837060f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782117909; x=1782722709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4+JM0LXTwW326aT6/DWg3uzHORxhh1b2m2DxtQYvURY=;
 b=ZCHTB3tGeLYpPXv6jqV2POHNsbDyBzQCKLxYbEofujKb7KSKyX5gS3/IjneP5pT6Dv
 nm4jpMUEqOuDpfMFmpg5vVPfNBZ/lp37nte1Q/UtZH6efNJ8JM76HrqE/4hWAGIEq54j
 hMPuJag+urjJLdSp8cdrESxOHcpHPsVDs6o1UTctLm//vAdBPJYZLZOmMfX3iEvPqNHP
 9cGNdhSQAj1EOad5b8N1C53sCA2w63OaQMfrjDD5s0QZdWnrxk+j4cPN9Yo4l2KYYQF2
 2Ou9XArAClnHR5EDUyY0lqQF9srspf7gLrcfZCLCGtyEPR8G1ElmNqvAQrpw8XC3uxAK
 Rsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782117909; x=1782722709;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+JM0LXTwW326aT6/DWg3uzHORxhh1b2m2DxtQYvURY=;
 b=KVWrI6DNG9T7UIognryIKf8hWomTJ6YtAVdqT2ACEMNp7phJWgPq3rqIc6bKIZTK3c
 puSH7aFmXRNsbehdDHyecPd8tec0eEpPbWl8SfiCMUZMPnanC+GNJSw4iIRZUjYmYSv9
 OpiAHi9RlSPg+jwl8nTUi8YMSaLwOgAAeHqkMuCRbgsXFyXSoX84fso7+lvr6h9OAW3/
 kfTIlkTe6q1CNkDgUlSJvZZspBlEeJtx12bOHCD/M9PTpRNy9/nR3Brw3oq5YSjUCv+T
 w5pNQgCNSmW/H47mWRBn3pZ/vZ0mWm7NUQaoMSfSUEL5Rx0ZoknrI8NrBHVR1uYNkdIf
 6Ktg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2P/HoifGt/0uJ0WLHRUrDoC1utjOFDk1/oX8BleIvm/ZOI2KobHJWuCKCAUP2aEFosfC0k2HZfo/e@nongnu.org
X-Gm-Message-State: AOJu0Yz3WdWnnDqA+0NJt775IDNJ8sArJ2mo8RYsBdr1Nj9GOYoolLNt
 XERvPIPZlpyWSbZYx7+Y58AHQw8bhMRnruSled+dx+beATUvcdW2v5XLmeqX56PTHUQ=
X-Gm-Gg: AfdE7cnxmTKgQZpf7nHhUb+AE7AhbF4ah2274LHVUSRkDvgsLBhPOxBifrqiILg2zxl
 R/fVretpDYlqluDDzRi3pOLWjKvDZ+6HZY4uR6BayrnyMKBIJv6ZmiC7eTgAHcLaOZP8k4AGBPa
 6kgsj8lhpAus7ZY8GX01eLigOl0udQP+hiC+tf+t1AFQqBQTBpS62UUlf39ed2Tdxv2uUg3TgzC
 Cz+6aRHoOZIIGSklm8iNrpKghG/vQ4jrOY+2a2aZSI2YSY74U0VcfFPUzlwrSXIncMKPyHeWJzu
 2QI/C6FF1ya2Ynawd5SjiHxvMmwCCs3ywuBl4LZqm1dhwEohC5z99+MvWzc/ug4tTN1a0KV+fSW
 jF/PaTM9QajnFyDrGVbjX6rp4usJIAcLyNQkRI1owMpgW4SQ/hXhVa7pUEBekX7cBJSy1l1ikNo
 q0W4vxCELW2Kzk5r47xj5p1NE=
X-Received: by 2002:a5d:588d:0:b0:461:b5be:3e7c with SMTP id
 ffacd0b85a97d-464fff65d21mr21385492f8f.6.1782117908512; 
 Mon, 22 Jun 2026 01:45:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46667221de7sm23553955f8f.33.2026.06.22.01.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 01:45:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA0CD5F8C7;
 Mon, 22 Jun 2026 09:45:06 +0100 (BST)
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
 Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>, z.huo@139.com, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call agenda for 23/06/26
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Mon, 22 Jun 2026 09:45:06 +0100
Message-ID: <87zf0nm0a5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
23/06/2026 14:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8F7CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRos3-00069h-OR; Tue, 26 May 2026 06:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRos0-00068j-0m
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:18:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRorx-0002a7-Ag
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:18:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso89410225e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779790720; x=1780395520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZPO+omfhuJnLd4FbrgveOGoVKdZW31eKm2GZ+9TL/Y=;
 b=gfChpYY2bytfSkGlVp7eQPSj5RNs12IVsURjlrtPH7xZ+QII5hnVqh6jwh7s+su28+
 ANgHFz9zIQ2DY2YJPHjvTHKiZqEy1wu3Jkv7l+jvDlMVpFjpUTf3064PPaj1anTAGGaf
 dJuZ3xMwG4maMtRE65zy44hSRO31k/pFeEQ0lJ9m10DJYUlCZcJKuNQuU1xXqhYCzjU+
 6LsL0UeGPxaOAwbkeXHWKyETZyQSWN3UEulG+F/5zdeAxAKkXdACwzNw251UoVgrY2nZ
 qOSB2m0SoosB4fhsLiPvQzZCNL2ymTbmXXOjgv0rHbRp+BKcYqKcQ3xnitG5SmOGZjSp
 NmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779790720; x=1780395520;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yZPO+omfhuJnLd4FbrgveOGoVKdZW31eKm2GZ+9TL/Y=;
 b=GphT6NwaXWvnpXEG7awn4IYGkTmLN7zOOAz8iRJ+F9p72SF80xyvFHNCsUmSNTNBdd
 TCOt5eTY/mrxbDgrK82HfHPqmgEZmdYU4OvULuCAJguXYbpDggsuAZPHhAFUKQuy7wsR
 z+MYxfvPd9lQgdJtQsTMB6vYns3EEhrN73JiYORu+xh2vs+4NQMYNHMZJrfTM9GrqqOc
 VT55luHspz+5wuGdSNm6wmCP1UpV+XGn0NqqVoa3TSJqmm4tmrqP+TGfu/e8VE1KSLjg
 zyF6uupdBRaq4xM3QC3lxsQ56aVfaIQ53PeiUy9JC0y2Xh0HJ5afFpDybrRc4H6pCKJW
 KncQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gPjiuDVuTK08HxCdJbiceV6i8gQOzQR03mtCi0OLKH7gi33OOuUbJxTBtrI+EoJetP7itpKd9y/9L@nongnu.org
X-Gm-Message-State: AOJu0YzjKg6eWzCpiUpkhy1BaxIroXi8RuwT6eP0vraMxImbj6u0R9VI
 GDe6g3Qd4Mk8GA3eAfEqD8QqYY+Z7cOXpSsx+IRi7siTNRNbtFu/g8+Ajae11zYudXM=
X-Gm-Gg: Acq92OGAGlC0HTvOvYEUgeIhJnYTOFP9Fci9GEa8RSy3O/LwauDbizkPrHLtRICuB0c
 iaV2xDw13muNnUjiU3DTVgTTeUn29SsEsQnaGYdWRzjE1kYCLUWOc9/w9l9NUxXaCroRO+WoulF
 vKIgZg7oj34qDhik5z3WwkNtAmWDWSjIAWD5VJ4kH8mQowQG30+cIyhvXbsNE9lD7EOJtY6jH2A
 KliBkB7SX7TtQdOVoxzyn7lexsuqx2rdfGQ9xAKelhp3LqjYMh7QwQjdTgJF5kTWtU2HJKXZ1Z0
 O4BaBo/aSF4wSGWfwr3/jndI/uMOfQhhrHrDBa5pq9fQSp4v9TPzhefY1qLqDOZltm5jjeqUsJn
 2T2RyrGtTht1PDN7WvBs2VXF3gP0eqd18zyPucnup5TX4k+XEOVS1QFLfJg7Iknf8yVuof+XEDS
 F9usFauUnmh7oT/JTDcAUcZzk=
X-Received: by 2002:a05:600c:4ecc:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-490426d4d7fmr297810375e9.17.1779790719623; 
 Tue, 26 May 2026 03:18:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm470695875e9.7.2026.05.26.03.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 03:18:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 20DE25F7DC;
 Tue, 26 May 2026 11:18:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Alberto Faria <afaria@redhat.com>,  Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,  Anton Johansson
 <anjo@rev.ng>,  Markus Armbruster <armbru@redhat.com>,  Brian Cain
 <bcain@quicinc.com>,  "Daniel P. Berrange" <berrange@redhat.com>,  Chao
 Peng <chao.p.peng@linux.intel.com>,  cjia@nvidia.com,  =?utf-8?Q?C=C3=A9d?=
 =?utf-8?Q?ric?= Le Goater
 <clg@redhat.com>,  cw@f00f.org,  Demi Marie Obenour
 <demiobenour@gmail.com>,  dhedde@kalrayinc.com,  Eric Blake
 <eblake@redhat.com>,  eblot@rivosinc.com,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Eduardo Habkost <eduardo@habkost.net>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Auger Eric
 <eric.auger@redhat.com>,  felipe@nutanix.com,
 helge.deller@googlemail.com,  Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com,  Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com,  Jan Kiszka <jan.kiszka@web.de>,  Jason
 Gunthorpe <jgg@nvidia.com>,  jidong.xiao@gmail.com,  Jim Shu
 <jim.shu@sifive.com>,  Joao Martins <joao.m.martins@oracle.com>,  Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>,  Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,  matthieu@minio.io,  Max Chou
 <max.chou@sifive.com>,  Mark Burton <mburton@qti.qualcomm.com>,  "Ho,
 Nelson" <nelson.ho@windriver.com>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  QEMU Developers <qemu-devel@nongnu.org>,  Roberto
 Campesato <rbc@meta.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth
 <thuth@redhat.com>,  Wei Wang <wei.w.wang@intel.com>,  z.huo@139.com,  LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  zwu.kernel@gmail.com
Subject: Re: KVM/QEMU community call @ 26/05/2026 agenda items?
In-Reply-To: <875x4fmzcv.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Fri, 22 May 2026 12:56:48 +0100")
References: <875x4fmzcv.fsf@draig.linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 26 May 2026 11:18:38 +0100
Message-ID: <8733ze1nk1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> The KVM/QEMU community call is at:
>
> https://meet.jit.si/kvmcallmeeting
> @
> 26/05/2026 14:00 UTC
>
> Are there any agenda items for the sync-up?

Given there is some discussion on the list w.r.t. AI contributions would
it be worth discussing the topic today?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A665C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqtk-0004y1-2j; Mon, 08 Jul 2024 12:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQqtj-0004u7-1P
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:07:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQqth-000829-Bc
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:07:26 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00ba6so5535160a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720454844; x=1721059644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VBz0PFlyWeQSwJ9cwcG3jjVeCaDhpG4N9DqbtSJjJrY=;
 b=G5xtGnSQw5u6xbitjs6NCdK8G+kwI6Tzxesv7awBGcEud8+cNuYmafcBdu9ZmtBMLC
 r4f1gqJ6DeYyHoe+zvbAs3zOGsueQ0bK0/K0fHFW5kVLNoVwtyAaCatV8UF8qbcXHBgt
 v9N5jfFviRiXo6WLqPPvf6+95nHgZnIN4X4NaJNrNPhFY349a+TvQat4xOH/LVt8aRXH
 QCzpuKip6z8gGRvWxXX3mhN6PGukxBRyAauV73OaTiD4gn/2N3LZgJ/ePr3puBrQMmoh
 ccDGR+jyCm8xkq3vFoS13XDmf5L4amCWoRGZ+nFcT81FscqmwZXvcBnGv8k9DlBmqg1l
 vKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720454844; x=1721059644;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBz0PFlyWeQSwJ9cwcG3jjVeCaDhpG4N9DqbtSJjJrY=;
 b=lD/yBLD30a5zQgIbqYRkjadvhc3yL3iTUVUoBRRvUlmHzdohL5aPJrxa41n1rsaAYt
 iTLxbweVtU7yYou4f44Kz6DDwvCLj57/fd0vAkk7d7tyC4J5bKDGQESl21XSPgM04q4X
 zysXey65xL/mfHIUpDCV20UCngYSF+nls7hYpFE623opbZrkwY+XCWsTvAsJtMyOOZt/
 zXU4Ua60nQC5ctW14qmtnGMiTJAhFAZl6uUBI042hVN5Gw7A9fo7R9tOssb4l/uOxNuM
 CC3GC05ugo9USa5iZa8tC3XIs6MoGbwKYrLHZy7G5J+4XPTaKKGcoWpc7At4mNO/RpUY
 G8mg==
X-Gm-Message-State: AOJu0YyKFEsSidHY6B9B/yAkLDuD+38UaNZ3HeqMeJglZCODfr/sN0mo
 /eum8sI5MeVsbdkMtzpzEm1jGMxhMczHvYxfGT1QSG/zI3zKw2nFE1bJgguV6gI=
X-Google-Smtp-Source: AGHT+IHyJZsZAxugR8rV+3hIKLXRhM7xfiHxXnlbypQIutNWiAvVgLoT8rw6gNkVMH5w7wFO4KJzzw==
X-Received: by 2002:a05:6402:520d:b0:58e:e2a:1b4b with SMTP id
 4fb4d7f45d1cf-594ba98f273mr39045a12.7.1720454843677; 
 Mon, 08 Jul 2024 09:07:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bda3089dsm5117a12.94.2024.07.08.09.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 09:07:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7BC175F8CC;
 Mon,  8 Jul 2024 17:07:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Andreas Faerber <afaerber@suse.de>,
 Alessandro Di Federico <ale@rev.ng>,  Alistair Francis
 <alistair.francis@wdc.com>,  Anton Johansson <anjo@rev.ng>,  Markus
 Armbruster <armbru@redhat.com>,  bbauman@redhat.com,  Brian Cain
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
 jjherne@linux.vnet.ibm.com,  Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,  Luc Michel
 <luc@lmichel.fr>,  Max Chou <max.chou@sifive.com>,  Mark Burton
 <mburton@qti.qualcomm.com>,  mdean@redhat.com,  mimu@linux.vnet.ibm.com,
 Paul Walmsley <paul.walmsley@sifive.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Phil
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Wei Wang
 <wei.w.wang@intel.com>,  z.huo@139.com,  LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  zwu.kernel@gmail.com
Subject: Re: QEMU Community Call Agenda Items (*July 9th*, 2024)
In-Reply-To: <CAAjaMXbdLZLmUr94ee4-81rXX_YjYa2-cz44xux7rJe+fwnmRw@mail.gmail.com>
 (Manos Pitsidianakis's message of "Mon, 8 Jul 2024 18:58:10 +0300")
References: <87cynoszg2.fsf@draig.linaro.org>
 <CAAjaMXbdLZLmUr94ee4-81rXX_YjYa2-cz44xux7rJe+fwnmRw@mail.gmail.com>
Date: Mon, 08 Jul 2024 17:07:22 +0100
Message-ID: <874j8zuath.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Hello Alex, I thought It was tomorrow? QEMU Project Calendar says "
> Tuesday, July 9=E2=8B=854:00 =E2=80=93 5:00pm
> Every 2 weeks on Tuesday
> "

Sorry yes - I really should script my invite rather than copy/paste edit
each time.

>
> On Mon, 8 Jul 2024 at 17:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>>
>> Hi,
>>
>> The KVM/QEMU community call is at:
>>
>>   https://meet.jit.si/kvmcallmeeting
>>   @
>>   8/7/2024 14:00 UTC
>>
>> Are there any agenda items for the sync-up?
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


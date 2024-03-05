Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15738C54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhX4G-0000NB-EF; Tue, 05 Mar 2024 10:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhX4E-0000Ml-F4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:50:59 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhX47-0007K9-Gt
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:50:57 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51326436876so6374520e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709653849; x=1710258649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oIU4ccuy4HU8mf1H46sACHHovBTUOj3TeYnZ8oicqRE=;
 b=ySyPM7/g2tcWGkfPEQGxATy0Gkc55x0EY2A9gLG2fL6tQvK02HsOWCWlQM56UzKQlC
 jaurvm0kcgZW/+juJePTsmahMWY5GS+avfxHuscVWg6VnBERsqDTtZ7MToDivBWG3zTP
 ugvR0PpOvmiMJ6v4gaaTajASU2lY3kFILhwXCTj9HklZnmyL/ezbVaZLQKmn63eQ2H1t
 9420dekIGnTHrz4aZWduUYiMpIjBYNKHjKCLUP6rQem0NDHz71mOqKljNG50p6ZE012x
 Ra+Tyyhxggqa1i622hs4JhSCReMJ6g1UQkSdEu/ftMTSM+MhQMnOszX19kjkvM0llyUz
 TB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709653849; x=1710258649;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIU4ccuy4HU8mf1H46sACHHovBTUOj3TeYnZ8oicqRE=;
 b=C82ctCkQo9czYfFnysV+VbOIz4mp2Wa47drIyRudIUhYB7dIl2lrc9jC+flGGboOcA
 Ca3IAa4V0bo5hjn2JIkNb5Bn/7yg97VxuWjVdSUF6C46n8sjlBrKQe2dxUO2VH03/6hA
 Ob9rDXt9nWagP/RXmgQVu6doDizhA6KkY+QNT1m+Ut6CCfE64VI6E1dA2QsV6sEJuCyK
 6XITvzrwZbSJxKgtwyoyasN2i2A7umtGZ5UXbolcQ5T7JugI4TkluN8FviOzuZ8EDPjV
 TpZ42kEBTdReSiMZtSxgMm+CXNXmSy+FUq11lZUT/GbySKSx1HMkZYItQQYgO7rJrnsM
 IrFQ==
X-Gm-Message-State: AOJu0Yy2/vSOyX1iUqsm6J/gen8rq2QfQWNR6Icx0XjX3K4832L4x8z7
 yCEWtrPEmd39InIgpTZO8o8cA5HQrCkoJISi77d0yNA7X9HenWsiU4xXrpYFN4A=
X-Google-Smtp-Source: AGHT+IFqOK061YemKyDyJXq8WfdSjvCdmKBALdPLKpbnSzfPq8BFdw6sYj4Cb3dmtSnNBHMWKkAjig==
X-Received: by 2002:ac2:44c2:0:b0:513:3faf:a2aa with SMTP id
 d2-20020ac244c2000000b005133fafa2aamr1514764lfm.29.1709653848740; 
 Tue, 05 Mar 2024 07:50:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u21-20020a7bc055000000b004129a1097e7sm20807439wmc.12.2024.03.05.07.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 07:50:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBF645F8B4;
 Tue,  5 Mar 2024 15:50:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Mark Burton <mburton@qti.qualcomm.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin
 Meng <bin.meng@windriver.com>, Edgar E. Iglesias
 <edgar.iglesias@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Don Harbin
 <don.harbin@linaro.org>, Alessandro Di Federico <ale@rev.ng>, Anton
 Johansson <anjo@rev.ng>, =?utf-8?Q?Fran=C3=A7ois?= Ozog <ff@shokubai.tech>,
 Song Gao
 <gaosong@loongson.cn>, Michael Rolnik <mrolnik@gmail.com>, Brian Cain
 <bcain@quicinc.com>, Christoph Muellner <christoph.muellner@vrull.eu>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Max Filippov
 <jcmvbkbc@gmail.com>, Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Any interest in the QEMU community attending DVCon Europe October
 2024?
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 05 Mar 2024 15:50:47 +0000
Message-ID: <8734t4wuco.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

Over recent years there has been a push to make QEMU more flexible for
EDA type applications. As long time developers know there are a number
of downstream forks of QEMU which have their own solutions for modelling
heterogeneous systems and integrating with hardware models. The work by
Philippe, Anton and others to build a single binary with composable
hardware is aiming at least to solve the heterogeneous modelling problem
in the upstream project.

While we do discuss these "TCG" topics during KVM Forum the project may
benefit from doing some outreach at some conferences where simulation
and emulation are the primary focus.

The Design and Verification Conference & Exhibition Europe (DVCon
Europe) is the premier European technical conference on system,
software, design, verification, validation and integration. This year it
will be on the 15-16 October 2024 in Munich. See: https://dvcon-europe.org/

There have been a number of papers and workshops on QEMU/KVM topics over
the years. Unfortunately the website doesn't provide slides or videos of
the talks but topics have included how QEMU can be used as a fast
instruction simulator alongside things such as SystemC models or
virtualisation can be leveraged to accelerate full system emulation.

The main tracks are fairly academic where engineering and research
papers are submitted and if accepted can then be presented at the
conference. This is probably over the top for QEMU related stuff but
their is a tutorial track (deadline for Abstracts 1st July) which could
be a good target for a introduction to the features and capabilities of
the QEMU upstream. I suspect there would be interest in the wider
modelling community to find out more about how to use the upstream
project directly.

There is a co-located "SystemC Evolution Day" on the 17th where there
might well be a strong overlap between SystemC users and QEMU. Mark
Burton is involved with that and is keen for proposals talking about
integrating SystemC models with QEMU. Please send a message to
mburton@quicinc.com if you're interested.

So is anyone interested?

Should we do more within the community to network and discuss our plans
for QEMU as a modelling solution?

Any other thoughts?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


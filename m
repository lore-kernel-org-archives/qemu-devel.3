Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03FEC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeei-0005pQ-6e; Fri, 05 Jul 2024 04:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeee-0005mw-J0
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:50:56 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeec-00073C-Uz
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:50:56 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa6c4so1136559a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169453; x=1720774253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PIUSbhGc+J8r4qMCbItX8lTq9ZzPNOfuOLF5nQ0zUfo=;
 b=bjgLvgfL9K4gYyoeFwyELg/KmdwHvkAC2bxwiriZ4+UThywv/ZUIzuGsvyUUxi4Jx3
 wyDraOIpVUKKNgilQ4xjwusqc+4sTYQ6G9kjmyo3W9a+I1HT+OUyqcGNfZBG//vK+xbU
 39rRKIrKcnt8fIAsAtN4kJqP63iJUJKlJIdimCWRJO80Mf5hh5EcDXkkrPWEXeU2H2fC
 bK+CwaDtqnd3GUeerN+YwSvhyv29Bxntqrbqd2FFRAYCpEdIOOb2RG6Nf1+ykPplFUw0
 d++2EBpWfpQKuJqDPXcSjC7F3Jf5i+XYPL0gKmclx7X6/5wZEJzPEYTwirLTBUt5yvng
 3j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169453; x=1720774253;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PIUSbhGc+J8r4qMCbItX8lTq9ZzPNOfuOLF5nQ0zUfo=;
 b=ZZAi6gAJ0PDIjquv7iYwXUqLEprhMcw7POEuAVgR/zGM9TfFuJrAoby+0dZFkyXa/l
 ki39W58+Ho/cjFcWbNk2SEXhArw4rOuVm3YGnbSpPI471oOjWED58sS5HlIC3JomkY/u
 /xVgih7EM4L7lm1LtNh/qAK02YDXsfZjq44WbY0JPb899Ohibfj7RWJAtZyE9W1JLohh
 0A1mlyxamPyjGNIKoR7Hf9XxYb6urMMGaHx1YQRLwEumls6ocJsWUyaNtqLsIFKfoFQz
 2WjY7ikFvCECeyOnkZG1dFB8UGt4UxH/odl80wtzHGR+paMBOYjvLScX0vPDZVI3eTrK
 Id1Q==
X-Gm-Message-State: AOJu0YygP7ahoHIBq6zG0wKjBRK7TZGVmfqjEas7P9GZq7zAWNKO36d1
 x4bGXk7/85VSCHbdciPpUEi9XhGRuLcEvwaEq/gH0fEGsxjTx4kqkz1DaSRFSjroUXF48b1PAEw
 M
X-Google-Smtp-Source: AGHT+IELchX8E8gJ+TlCVFHTZQlwT3KpShOKEtErHLRv8qPsCt0+qbcjVVL6mx9r0ox0+gWdh0nlUg==
X-Received: by 2002:a05:6402:3584:b0:58b:1df9:d3c1 with SMTP id
 4fb4d7f45d1cf-58e5984bed9mr2994123a12.12.1720169452485; 
 Fri, 05 Jul 2024 01:50:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58fd6c67567sm388787a12.21.2024.07.05.01.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:50:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D3BE5F876;
 Fri,  5 Jul 2024 09:50:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roderick Klein <roderickklein@xs4all.nl>
Cc: qemu-devel@nongnu.org
Subject: Re: Question about OS/2 support under QEMU....
In-Reply-To: <3de7c42c-575b-4e29-9d4d-85d0d0f67da4@xs4all.nl> (Roderick
 Klein's message of "Wed, 3 Jul 2024 23:05:08 +0200")
References: <3de7c42c-575b-4e29-9d4d-85d0d0f67da4@xs4all.nl>
Date: Fri, 05 Jul 2024 09:50:51 +0100
Message-ID: <87o77cmdck.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Roderick Klein <roderickklein@xs4all.nl> writes:

> Hello
>
> Recently a bug was opened to get QEMU to support OS/2 again (newer
> versions of OS/2).
> https://gitlab.com/qemu-project/qemu/-/issues/2198
>
> I would like to point out a company from the US supports a current
> version of OS/2 called ArcaOS.  I was trying to help out to figure out
> where I could point the company to contact somebody at QEMU (if the
> QEMU team is interested) to receive a copy a ArcaOS so they could test
> QEMU ?

Ideally to defend its support in CI we would want an unencumbered
download so an avocado test can be written that downloads and runs the
image.

> BTW where is documentation how to create clipboard and mouse
> integration for QEMU. I recently worked on a project for ESXi and
> would like to look what could be done to get VM integration for ArcaOS
> done for QEMU.

I guess you are looking for Spice?

  https://spice-space.org/

You run a guest agent on the guest that talks to some spice devices to
pass information back and forth between the host and guest.

>
> Best regards,
>
> Roderick Klein
> Dutch OS/2 VOICE foundation

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9594FC3DA70
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW21L-0008Vn-IT; Mon, 22 Jul 2024 19:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sW21H-0008V7-Sk
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:00:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sW21F-00028S-K2
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:00:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso34598435e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721689235; x=1722294035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BmCIVXWNOEm3eTHKvP5uWSdQUez9pm3ry5FvZl80ixY=;
 b=E9B5wPQnTVDmHw+JX2VH8m8qRi0J2iLuAkWW7/FRGq4O5jO+e7HIuM3W5cZCkcrL5I
 yL0VcEEp48q4R9TJnm8u3aeRVS3gH7ZwBThDRMcvYicV0MYl16WW3o4I0TBKidHeeJpo
 xsBaMy3qw6M1p0vKk2lDnofgA1rrKR90Q/+hNsxVEX8DKfdiGeFcVx8o2npBtCmIB6kw
 Ap7sIr/bGfZl5P7ZGBayGPf5LIpEYH5an/8YDfWmx39WPhCV60/DKxAlYDypZiexI+X2
 RK+mMZlIo7VYFBOxOz4o/iAsc3IqScDYCZB3AAPU0Y5/2WS1r/PkP+wAdmdjLBup9Dk9
 bLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721689235; x=1722294035;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmCIVXWNOEm3eTHKvP5uWSdQUez9pm3ry5FvZl80ixY=;
 b=X+YGsEAfgcs8x0xYXqcJpamCZ+dubHXNMn9afPAUmLPSUlyYQ2W1W1+58PrqRXkLlP
 Oqz8HOUGQVC9MZNidU5hoQoUingDXIMaUGM+sFIIgVR76+TH0GDoihKOZYAFonvJiNOq
 NRufWMZEBU2FicutJf3g1bW8w4+2f0B8kFmFxV2Nxjnd4FDPjXcnVAdKSgpjrFyWuxIU
 W0tC4EiQVgc+OwgChGBPVIlrgcuWkXzWGU8bqnoa06fNS/P7ljr2zocDKKPcn6IdKdEq
 rM+JiLNKN1S9A3tFTE78eYQvJa2kfKZ5DmgwhAkmqj73oY0FCw1nZaV2/S/PZvz1f3Ja
 fO0A==
X-Gm-Message-State: AOJu0YyAsAQlrnEWlTcPocukLgyTeOEnQXnXh8Yc2YuZp9JU+JUCIwHV
 6+U7s3a1mYLP2L7LpRidwPlnWpjsalT6UbPPwVP9nxMui0brGLqshaBAN+zAbDQ=
X-Google-Smtp-Source: AGHT+IGeSbZQythcjzUiz+3jgooB91wRH8ttKIiLxFRJjX3zlIonBPD1fRakssxDKOE8fu0TxAcSbw==
X-Received: by 2002:a5d:6247:0:b0:367:9621:6fa with SMTP id
 ffacd0b85a97d-369dee19e42mr939465f8f.37.1721689235058; 
 Mon, 22 Jul 2024 16:00:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b2d4sm9856081f8f.35.2024.07.22.16.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 16:00:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 947ED5F8B0;
 Tue, 23 Jul 2024 00:00:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/16] Final bits for 9.1-rc0 (docker, plugins, gdbstub,
 semihosting)
In-Reply-To: <7c8a189c-4c8a-448d-bfce-cf1b0c993122@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 22 Jul 2024 23:09:33
 +0200")
References: <20240722110413.118418-1-alex.bennee@linaro.org>
 <28ad74f2-1103-465f-b977-b1d48c06083e@linaro.org>
 <7c8a189c-4c8a-448d-bfce-cf1b0c993122@linaro.org>
Date: Tue, 23 Jul 2024 00:00:33 +0100
Message-ID: <87o76pxca6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 22/7/24 23:07, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Alex,
>> On 22/7/24 13:03, Alex Benn=C3=A9e wrote:
>>> warn: No match for commit c135d5eaafe7aa2533da663d8e5a34a424b71eb9
>>> found at https://gitlab.com/stsquad/qemu.git
>>> warn: Are you sure you pushed
>>> 'pull-target-arm-20240711-209-gc135d5eaaf' there?
>> Is this warning expected?
>
> Apparently the tag you pushed is pull-maintainer-9.1-rc0-220724-1.

doh - I fixed up a checkpatch warning and forgot to push the new tag,
let me send v2.

>
>>=20
>>> The following changes since commit
>>> a7ddb48bd1363c8bcdf42776d320289c42191f01:
>>>
>>> =C2=A0=C2=A0 Merge tag 'pull-aspeed-20240721' of
>>> https://github.com/legoater/qemu into staging (2024-07-22 07:52:05
>>> +1000)
>>>
>>> are available in the Git repository at:
>>>
>>> =C2=A0=C2=A0 https://gitlab.com/stsquad/qemu.git
>>> pull-target-arm-20240711-209-gc135d5eaaf
>>>
>>> for you to fetch changes up to c135d5eaafe7aa2533da663d8e5a34a424b71eb9:
>>>
>>> =C2=A0=C2=A0 tests/tcg/aarch64: Fix test-mte.py (2024-07-22 09:38:17 +0=
100)
>>>
>>> ----------------------------------------------------------------
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8512FCCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gM1-0005cJ-F9; Fri, 17 Oct 2025 05:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v9gLu-0005Zq-EF
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:02:22 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v9gLn-0007ae-4o
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:02:21 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-57d8ff3944dso2016288e87.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 02:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760691727; x=1761296527; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8W9epadXBSELzO5xUb4zHxvIU3+NILzN6nwXVIDHUq8=;
 b=BgLMSAI7zISoQXfKF0N/ImDg7ZMWnQMpDaCJItdDKx+T7e4eLquLhxiMHcjqjoaEsU
 Ra3sRINM6UCRdR6+n3gvfWrUeefYp9uXXLirHm9HqD0GVEFjfJzJX4XWMPidHalLpaPT
 rMYLq3hQ4FtWIIn+3PC1FnB5ar1UFQAQJ2NSNayeJy2Y/MvAUusijbCyD2aPc/DumTxy
 3RBL1PEVXvAqp/jxWU6sBYMSgIrjvIizp5eCx619HnHMZVo677J4tBZTLApsaBu8lwuF
 mYbYKQ6WCVwCACz964w6cGeYQn4mgG6ZTNl1E6mUlYo+7weELYUkCraLGkWl5LgPq2FY
 gBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760691727; x=1761296527;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8W9epadXBSELzO5xUb4zHxvIU3+NILzN6nwXVIDHUq8=;
 b=YWiFvDIJhAACc6HW3SnjPaoxNo1n/JS4nd4xK98u2kSc3O3j1pl0qOpe3gQD1QEOQ4
 RiGXa/OpRHGx59XXfYcbPjyZHDwMM2+p2EiM7tFDA1YX1/zRtsnyyCsTIhbb3oMYaj4s
 GOJuEic2Ff+m+Wx1q595n+SvfLcqnM4nt8XvpzHhMRxRrym33mzrPEUnnq3VmkP+zD6i
 ER+tBIpsxrd6o//gwxF05pxrISHWkpgK7URHJws2tMiCSRVf6eMwAjDhrgIK1B3iRP7W
 cFPLXnAgfrq2xz5LO9yRqdw2bf5mKdee9kJH7MEljA+DiwrsmHVf2gbMDiyowLO3WP1m
 zMJQ==
X-Gm-Message-State: AOJu0YwwlqXYJAop4B3UfGSRyy9Qmeq7WQAH5oECvl6e6oClDem2BYxS
 7QvmSFBO/oQ5Dwb3nRMcf+CDgetmCvUqHLnJAL6OyURgyU29f7x1jwKs
X-Gm-Gg: ASbGncujTbbwK4k4mu2rzq42p3T76yl26MydNPbdJ77Tld8Hu1zKaEw1gRD84xDyQCS
 ZQQNPe4OKvaKaXMfz+NjlA+i6rZmOMGLmgs5OxEVZGhj6TvjmzcE6NhT2vNbMY07FK64hHOhBYV
 yaDLIY8bCDY8udtiJxbWT1C94SVaw7aqDhMXOxO+L8vdvN9XEyTH+HEt/hYO7GRzd5vH0Wp/1cf
 6CNoAhvHyuSvwxa8AOzmdN6DaT+YKv41liaX1myzG3W5Pz3fK0nUSy43evEsCNtF2Tnv4Htn2D4
 +i0AvN8uqHBR3CdqHxlotcj7e0DbdpCL49x/TCSF5YAQGimUQek9sQuui2+OvW8ChAg2xCc7f1K
 ZNZWEgvRjD3pmf2MxunXheaxdBmYmWUePuLvg6Riw21dK3Wngt6kmS51ZzmmTCLlz5KLDE+4y5b
 eSo1DAzd0klFKwNfW+AkXiMZvleDmitScM
X-Google-Smtp-Source: AGHT+IE0mneS7ORKRBASrY7wNpppZdGMsr9khtqxIlYoMdQz4Skai0BRxGwcIE89NkbLJg6fPKcQdA==
X-Received: by 2002:a05:6512:3503:b0:55f:71ad:590f with SMTP id
 2adb3069b0e04-591d857583cmr1041893e87.53.1760691726868; 
 Fri, 17 Oct 2025 02:02:06 -0700 (PDT)
Received: from smtpclient.apple ([183.81.178.52])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088212380sm7671842e87.58.2025.10.17.02.02.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Oct 2025 02:02:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] hw/uefi: fix properties list definition
From: Alexander Gryanko <xpahos@gmail.com>
In-Reply-To: <542c446a-9c63-45a3-b68e-4f72f6ad51ef@tls.msk.ru>
Date: Fri, 17 Oct 2025 18:01:47 +0900
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <27CEC22D-DCBC-4BF5-97B8-114DE2551F28@gmail.com>
References: <20251012-pvvars-fix-props-v1-1-6ca31af626e0@gmail.com>
 <542c446a-9c63-45a3-b68e-4f72f6ad51ef@tls.msk.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Michael,

> On 14 Oct 2025, at 16:26, Michael Tokarev <mjt@tls.msk.ru> wrote:
>=20
> On 10/13/25 01:36, xpahos@gmail.com wrote:
>> From: Alexander Gryanko <xpahos@gmail.com>
>> Added DEFINE_PROP_END_OF_LIST() to the Property structure definition.
>> This fixes the device_class_set_legacy_reset error when accessing
>> the prop->info field.
>=20
> Please show the context where this is a problem, which error
> are you seeing.
>=20
>> --- a/hw/uefi/var-service-sysbus.c
>> +++ b/hw/uefi/var-service-sysbus.c
>> @@ -39,6 +39,7 @@ static const Property uefi_vars_sysbus_properties[] =
=3D {
>>                       state.disable_custom_mode, false),
>>      DEFINE_PROP_BOOL("use-pio", uefi_vars_sysbus_state,
>>                       state.use_pio, false),
>> +    DEFINE_PROP_END_OF_LIST(),
>=20
> Which qemu version is it?
>=20
> See commit 5fcabe628b8140691dab834a22be549d242b24bd which is in 10.0.
> This symbol (DEFINE_PROP_END_OF_LIST) is not defined (and not used)
> in current qemu.
>=20
> So it looks like this patch isn't needed.

Sorry, while I was trying to figure out what was going on, I discovered =
that I had started fuzzing on the backported branch.

Thank you.

>=20
> Thanks,
>=20
> /mjt



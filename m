Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54459C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiPo-0001cs-GG; Thu, 29 Feb 2024 10:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfiPD-0001C0-Rh
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:33:13 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfiP9-0006fb-US
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:33:06 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-512b700c8ebso1131903e87.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709220781; x=1709825581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekHpLpZjmvcgCA4auEMMYD11PMa17T0/pncCrTum3Os=;
 b=E1eAjSYNMKwJ8fk2M3yzGfQTDSJSN/n80DTd9UKRQHKEwIY/XE0crItMaE/UnkBT7L
 kP9fEjcoJQAyvLTLjISDMZKkhibD6vOL45LWM9dF1C67x724dzpbGyIsBfVgzvP5ncsj
 mEtCYkvNVXexyohWO/Lp2VLVS7wts3EB67Zez72MObntSTPIDOeghDeRVyxCiskxdAd2
 pOue3af9xhytpb4x8PPB7haNJlE5dFmTIFXLsw4vc2XHygPBv4FAMvL4wRjDOLVQWZy6
 dvhWahDm3QUB+uyLkftAM7fyoeQPoWO56U17XLLwfUog2skCpxsGJ1s2gu6u4EFjvxRF
 YjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709220781; x=1709825581;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekHpLpZjmvcgCA4auEMMYD11PMa17T0/pncCrTum3Os=;
 b=SiVc3bvnzvc95ixB7DNLiFYVztzOWlf0sEBUI2fNKMcHrQ+C+vc1ad2exQP8MrhU/f
 zmedYpebzrUIRs2lUOCxqEvIPZt/8R5s5OPhdLHsvv9yMIcRbQWM2iPPpSWw0fPPkNZL
 3euHOq9VJTBagNe54DqJbxmkImBGeRvOaUuUH+p6NvgGwGvOGxo8Tr3PF1b1ziGoIMG9
 f/Gw0wQnQDvTcc1X1beMY4261alUe/8hAQPYJW00oz4Pnxk8Fhtoheazd6ki5xnZV0hR
 8xNr0ZYPKIOrY7L10ERqclYWKOoeYMYVeyAjcLBxBg3Aly8/WgmTgWJn6fo+tUWGQjPS
 DrHA==
X-Gm-Message-State: AOJu0YxKx11z5YKENPCRVOCwXQBkDQZbPAl4yJ6w2A3XBENMCOQzCUhT
 ZuveipsoDU+y/LFyLN1pETNOP4MwkYtzKqF7FimtSRLOPNF4ADV8lDfz2UeS/c8=
X-Google-Smtp-Source: AGHT+IG46HNo8S6Ao8reA7QgBgePrHnGjQU22roLw/a0DlEEYAd7nlGBPLjXO93Qh0HunSsCufD2NA==
X-Received: by 2002:a05:6512:1255:b0:513:2c6c:4cc8 with SMTP id
 fb21-20020a056512125500b005132c6c4cc8mr351848lfb.63.1709220781015; 
 Thu, 29 Feb 2024 07:33:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t14-20020a1c770e000000b00411e1574f7fsm5439966wmi.44.2024.02.29.07.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 07:33:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 506CC5F78A;
 Thu, 29 Feb 2024 15:33:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v5 01/18] gdbstub, mcdstub: file and build structure
 adapted to accomodate for the mcdstub
In-Reply-To: <20231220162555.19545-2-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Wed, 20 Dec 2023 17:25:38 +0100")
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
 <20231220162555.19545-2-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 15:33:00 +0000
Message-ID: <87edcv8evn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> mcdstub files created including the shared header between the mcd shared =
library and the mcdstub.
> MAINTAINERS file updated

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


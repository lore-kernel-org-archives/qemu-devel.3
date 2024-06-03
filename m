Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D2EC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBlb-00030D-9U; Mon, 03 Jun 2024 13:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBlO-0002x6-JS
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:46:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBlE-0005Zo-CU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:46:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35a264cb831so4169862f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717436777; x=1718041577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7vpSiqKP2SeQR3N3rIUGIsWSyA01MJR8wqZvgPJ1Pe0=;
 b=EL2G3OW9/pVOsu3uN265rlgPCKFEmAeTXu6RTwggEAFYCO42mkJKMUldKewS7nBpSC
 0x9Cud351QVAHrk5zkOogxbMaVPIXrlduuN4YYZV4y3MKyrG69eCeV/Dj0jWxKkbJgYf
 EYwkICDbg6h8GOuLW+fGl+3RV+9LNLABoj1sg6MQ5tThoEPaRScjMtu90fqf312DW7l6
 AIXokD63Bwkrn6gCeSRwMCynI06hX/AF4c8pUP4o2G9G/pbDjb96mxsrKxl/kcMvgXMV
 Oac/bxgLtUhZXuEZkSgYJUZ3IAV9QGoV4Waou9yPGP/nGXCZHGvJRPqGXrrwHfR36g4w
 cZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717436777; x=1718041577;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vpSiqKP2SeQR3N3rIUGIsWSyA01MJR8wqZvgPJ1Pe0=;
 b=Dh1LxmWuVVRiL6CacpgaIQtm0Vh5davk/L3uEi34lrAUjwSyNQKjGnyqQbrVgtxMq7
 zhvtpuwup3kXaRm6mzfy2PQAV9CsyloaRHwLvoKTo9AnbFUkmEx0MdlHLFvYpDBJ2+ea
 d3X4yLeX8Jvsouo/N1F9ZI7ZqDbshem5ZOo3Bv2b+Tg+VkCyAjW8Nrj2XMTEWM9W2Wt5
 19pvU3VhLjDS8gsX/HbIqUR4H/qhDczzrwsr5DxzSEBsPykxZZKgQX5iicqFbXgZ1JJJ
 cUuzRlqTv+GTrAr4J0tg2OeoggUgbiytGyBBbNWIL4bCbcIK+47wIRM4zFxu4PE2r17S
 k2xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0j6UjzTWnXUDllgKWmtP/7wuChzy0cDqc18h45NjhfN+xQEQ4WaJvZDOgc6MvxzK9hCEvp9RUpGi+OjCmRfNk814r/CY=
X-Gm-Message-State: AOJu0YzOJpFNSa+jsv17yyxcBpe0Fq5xT6KOjLHAxv/23GsIITNKzbGs
 RJVqVeSk1eNRz3lncHHHJJRuo/9cvRfO4IxUfLGUGrjMVjAxF/ZZw1VZ+qSpaig=
X-Google-Smtp-Source: AGHT+IEN+XyRP7IF7QQoGnWfohTdDop8UK4FXaS7HMd0QhS3++0aB15OKw7X/HJXYUjgqZNSngs3OA==
X-Received: by 2002:a5d:46d2:0:b0:355:4cb:5049 with SMTP id
 ffacd0b85a97d-35e0f30dfcamr8003439f8f.44.1717436776566; 
 Mon, 03 Jun 2024 10:46:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0d6csm9368596f8f.1.2024.06.03.10.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:46:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96C625F860;
 Mon,  3 Jun 2024 18:46:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem
 with latest Clang
In-Reply-To: <Zl3YTm0-rEs2Kqqj@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 3 Jun 2024 15:50:54 +0100")
References: <20240529133106.1224866-1-thuth@redhat.com>
 <877cf6gk10.fsf@draig.linaro.org> <Zl3YTm0-rEs2Kqqj@redhat.com>
Date: Mon, 03 Jun 2024 18:46:15 +0100
Message-ID: <8734pthqc8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jun 03, 2024 at 03:47:55PM +0100, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>> > Casting function pointers from one type to another causes undefined
>> > behavior errors when compiling with -fsanitize=3Dundefined with Clang
>> > v18:
>>=20
>> Queued to testing/next, thanks.
>
> Please remove, as I don't think this is a viable approach to the
> problem

Ok - I'll drop it.

I still have:

  .gitlab-ci.d/buildtest.yml: Use -fno-sanitize=3Dfunction in the clang-sys=
tem job

to prevent the CI failures.

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


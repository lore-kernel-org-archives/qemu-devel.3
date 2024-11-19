Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2C8D4417F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 16:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDQzk-0007EC-CK; Tue, 19 Nov 2024 11:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDQzg-0007Da-GW
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:22:24 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tDQzT-0008Ni-KJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 11:22:13 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb4af0b6beso50421991fa.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732033330; x=1732638130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWIHpmn1KCrHTPVJvU++rauKzqqi2m03D+U8Khvj7Ak=;
 b=a6pghX8GoRS3LYV69pPezpSGUScKU6mxh67GmWDTAStkMIWQNga93gaLyV0swFLxOI
 D+7cNA3/xCr8CbCyWiE37MJQ+GThFcSxC3ewZJ2drCMmDqcKaAovYmzPRis8p0rflHb4
 kSQjgMxaktOHzjOub5yw7AnzSK3lPkSd+llFU2lio9XReIsPtUQHC9lxOyBR+s7k3UoS
 9t81buvdpTyD9G5AAlY0HvIcvpnOl+mKVvJQm7DdpwBGXzIyiwmryK+gtJOcGHI7QdBc
 X0+lK9ywAFtLYPsDnBnx+nYtpbEXRaZZANTcO5AJcOoatCWYkYM7gJdroUfWTxC/rJ7l
 YEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732033330; x=1732638130;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YWIHpmn1KCrHTPVJvU++rauKzqqi2m03D+U8Khvj7Ak=;
 b=IveXw5Q8FoWXChibOVmB0t//a1rrhHklkMx3JU2VvVbYktFVF9iRPL+XnyILw+02mO
 YUA7YaoemVmL3fmucSW396xpkncAoMGmczF7KuiLS61czCGiShgUZG96x3Jdw+B/sMZE
 AHE+F8DztsbMlIZd6JzqNA3ZaHwI44LHglnkRQECP6E4SNADhOgdhjL/KhxEBMtdtNAi
 G4//cCx+/CUwJj9WezfFiWdlABDDhUbrHUVugCYUtSmWpSzUdda121hOt/1/0jUeTHDe
 CExmNzHDGiFNCtBcceG5D9x+H0qNY9VcKpIXku1+wiwZ0M+xSKixLOHSphPSY+YqkHHv
 5FeA==
X-Gm-Message-State: AOJu0Yzjlx3O62l+Xw7mKBA1DIahmq/O67SScf4yXTXCqDW/SrobYxIk
 dY7obpDMsElNT9sjGwORpHg3odvAMFH3+C0ift85YWXk6KnYuYzqrMWswwTep8M=
X-Google-Smtp-Source: AGHT+IEK6xhyktIB0rbd+tzVSS3c7lSQSpzAR2TRxfG4f3eNsKaMdMy71i5LPbb3h+MHz+FSbpOAGQ==
X-Received: by 2002:a2e:a541:0:b0:2fb:36df:3b4 with SMTP id
 38308e7fff4ca-2ff606f9839mr123241301fa.34.1732033329893; 
 Tue, 19 Nov 2024 08:22:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20dffd78dsm664697966b.115.2024.11.19.08.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 08:22:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA8555F716;
 Tue, 19 Nov 2024 16:22:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 03/15] tests/functional: remove "AVOCADO" from env
 variable name
In-Reply-To: <20241119150519.1123365-4-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 19 Nov 2024 15:05:07
 +0000")
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-4-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 19 Nov 2024 16:22:08 +0000
Message-ID: <87a5dvp51r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x235.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This env variable is a debugging flag to save screendumps in the
> mips64el malta tests.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


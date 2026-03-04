Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9140EFCE21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqLr-0002dL-6j; Wed, 04 Mar 2026 12:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxqLo-0002cU-NL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:49:36 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxqLn-0007VX-6Q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:49:36 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6611f41eebcso587710a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 09:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772646573; x=1773251373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtYQqPSuqXD4rQnS7VhkOSaIn1E0MYS+d4pfuHlwZv8=;
 b=nJmamJGXwjBjSucHgqXf+juPrtgMX+pKQmjkeWfA9x6XdQ4uARtJfYrC92W52LcWOx
 347ScHxDACtXqzXp9eDSYn7gfykxLqmcWaFhgcaXHoNBGSOdLo0qY0lKRoHfuq75UpGG
 q9zcyac/WFEOrrBxHlY8JLI2Vy9JsrrDPfARHbnft+2tzKahlIW8w5t/kg7hWij343qx
 /gk8dkAZw0cuah47VSrF6oNQVIu10pw4DKq90p/JMnCSVO5D6Kw85lm4iF6bG8ZpnDm2
 eAPh5FIBtUvPeCYnvZb+ono552wyXFRjMgt/LdRhxfM7b16Cn+HwpSTieRXtNUmLUVBZ
 myKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772646573; x=1773251373;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qtYQqPSuqXD4rQnS7VhkOSaIn1E0MYS+d4pfuHlwZv8=;
 b=LOGv0VihWin3Fc4D4nRM1y7MwEiDqAcM3loBu+l22DYAoM5xg9B8bel5wx9ELmeXio
 pw97Bai4E4PZ8gkupRctOJJ3BcpoxiG/4/8AwZJ08h781q5j7C0Rt0stPOD70zTSJkHR
 0SnZYpSDTlx2OqmmHF/5x2fQ64PKa0CUOMgjqt/TIFGB6JYvII6xL3VSNKwCGd3N7A1A
 ofFpTN6DuMlxaL1ATNWlHpJhO1kF3Tu4nTCojDJiqOZUFba88LxR2mWuZeKrxt5Zgw3K
 fZ+EJ/65wSi8Hhe0E/x6hX55h7qUS2RIs97hst+VMY9UUv0j3jPAa1ASnWQfWMf/gBie
 TTvw==
X-Gm-Message-State: AOJu0YxWeTnBEVWMVBWVRajoyRCiHQmDaRxVrWwzF5xTo/A5fD2sB7Qp
 3Fu18Q7xoLv2kIgimeSRD+3Am3V79Ly5Nd1KObLUWBCSstO4zEmaqXoR/JQtD5WOm40=
X-Gm-Gg: ATEYQzycU7cf1YFpzsmrEkwk7kOyaEOHf3GPFtScACmKgr/nOEjAE55H528XC+voVcL
 MUOUBs0o1VSS+tKL5ePldThxopP98TakYGDiFdqLT6WYjRYmqZP8MmDY4xPf67/gQZdMstiTS7Z
 IPDglmaiLovGqLRFgYWCseQZTg2Waox1ruWJz1vx2wdeMrRULiKTzNoCKXtPf0sih8cSNJVXp5Q
 mOuw4NcpSdzOc3GKgEWruOK0BhKkPVzaziHYqlmerE7lqmFDRO68+PAPzkQ7F7EBjJHeq7T8JqV
 MmTIbJXLnNFpzDYZgPDn9HcUshWr7ytkJnEARyhHWcHHelqKN8y2IvSdP2rbBZ13jlFfAU7C7wg
 4ULMo+DqyTs+lm5zYpGj4mZyJ/mDO79dCay8NEXHAXxbPoD7wF+EzH3GscoES4TQ5Bz9oHwSEIX
 RqOp8nzbPTxHWpHL4NuGvVils=
X-Received: by 2002:a17:907:7251:b0:b8a:fd04:c789 with SMTP id
 a640c23a62f3a-b93f1372c45mr165628066b.22.1772646573399; 
 Wed, 04 Mar 2026 09:49:33 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ae666eesm777187066b.35.2026.03.04.09.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 09:49:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 18E2D5F832;
 Wed, 04 Mar 2026 17:49:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com,  marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com,  sid.manning@oss.qualcomm.com,  ale@rev.ng,
 anjo@rev.ng
Subject: Re: [PATCH v2] tests/docker: Update hexagon cross toolchain to 22.1.0
In-Reply-To: <20260303175444.1540049-1-brian.cain@oss.qualcomm.com> (Brian
 Cain's message of "Tue, 3 Mar 2026 09:54:44 -0800")
References: <20260303175444.1540049-1-brian.cain@oss.qualcomm.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 04 Mar 2026 17:49:32 +0000
Message-ID: <87zf4no577.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Brian Cain <brian.cain@oss.qualcomm.com> writes:

> Update the hexagon cross-compiler Docker container to use toolchain
> version 22.1.0, replacing the previous 12.Dec.2023 release.  This release
> has valuable compiler and linker bugfixes, but more importantly it will
> enable us to target DSP arches up to v81.
>
> This requires upgrading the base image from Debian 11 to Debian 12
> because the new toolchain needs glibc >=3D 2.34. Additional changes
> to accommodate the new base image and toolchain:
>
> * Use DEB822 format for enabling deb-src
> * Add libc++1, libc++abi1, libunwind-14 runtime deps for the new
> toolchain
> * Add zstd for the new .tar.zst archive format
> * Replace pip3 install tomli with python3-tomli system package
> (Debian 12 enforces PEP 668)
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Looks like there is enough around to put together another testing/next...

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


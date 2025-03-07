Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0E5C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqf8d-0003k2-CK; Fri, 07 Mar 2025 16:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqf8a-0003jQ-Sz
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:21:44 -0500
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqf8Z-0005fK-Ej
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:21:44 -0500
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85afc05fc40so67922439f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741382502; x=1741987302; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ctobiCqVGrh7S1pkh5GcSPLDv+nhr+by/o4CS4iddqE=;
 b=Y8hcM6AGZxtPDgUn3U72rlmAufpyVYHm61xdr1ySBYKtoY3q6pn6Whpe9D2hTY2+do
 bDz1/1XUWtTwKa2M1peyn/lX7PV+nwWe+v8jmsPXY1RkRvfJLvxuhPyq4lwzRAL/sC97
 +VRWII6K/joeIsBknhVBAQDh7osP+TZjRcBNpJ7aZ8fzCf7bdvuPtq0CKW4cK11m3f/X
 s+uNxjZhwOlhg34h5CyjMv1Bt/RRxXamw6iCugfMpdqkRj+oAHzd3e/LjN8Ca2Jl1v1I
 x4jCuJR32C7qhkW4fX0C+TEYPVZbbl2KGTNQ0/I5/ZH/cmE1gjkgjGeLToCVS9Q8zjFT
 3xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741382502; x=1741987302;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ctobiCqVGrh7S1pkh5GcSPLDv+nhr+by/o4CS4iddqE=;
 b=Iu3lqG9cnVNcrnC350v4rIi35rVD9XIr5as7xCyiLW79vu0+VhXAXDdzkEE0agXS2W
 0QthPLwuWn9FZbYgVAzL6wI5WDj1SY2ucKL3e7ZbpojZAHcPU7Zz4mxioFwkBsxm/VTU
 xcQcwraUCewMcLnfhGglNb6M83i3J6roBUBrj5KwMXIAOuqb/4jXLCYEUDmJJR7NT7Xr
 eO0+bjHKttfugfK1QySy5W2mNiGrcjXuw+ZdBHfQQWPQi91S0e3WZWu1N9KuShIpPXeS
 16c4P8pvukj6+IpSzX4LOGUtOly5DXv4feyoH372UK2aD3Ti+aarJax8WTxsvDCMXA1h
 oA8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTAAhGQRwKw2MG4WQ98XJN3+ioorNCEeG1RdOK70wD+WWcPkWTb8cAH7Bl/6DPBefMw4Pk3PLwt37K@nongnu.org
X-Gm-Message-State: AOJu0YyuA/LTPNLSSng18of+L0duDxwLESJB9YmfvumLQThwrarC1ELw
 HEFIM7oMnXk5vGnNVa07J0b2RfjjrbcIRdjTwjyRUWC0g0YrFcaa
X-Gm-Gg: ASbGncv9bsLlx+I1CeRUGuAF8jV4JTXZXhoqDdLlzqQksRtu/hzD7FVLQ2LrAXzgslG
 /rc3xrZXbsBu1NZCKD7HX77nx6zX0G2ZKJg+hCYG3lwVhtAxREiXo9956fNjcp2invsbepD7FkB
 7qCzACD10DA8jMWmAVQEZJLpj39C2EOnjwWTjjtIuFyVveMXOc3og6wHozyVZ4TaXCDhb50mpQh
 P78Mffg2WNoHGQFlR209vghzBdNe+aG/JvE4DoGd2NJxXx10xdtuxoimdoWlAtdlYxxHfwfUeFZ
 1CgUsV0F1mfAWg6j57PqbHCTx8pD0fGaZHAmVuoaAkgshOXdd6QXTpm61ieGiHg=
X-Google-Smtp-Source: AGHT+IEkEnruGvceC9/NZWaiHxnku98RAMVVzqEfGk6oOtAdPmwkhzqNL0MjLU27pCM9IdBjSUPbBQ==
X-Received: by 2002:a05:6602:3719:b0:85b:a:1e7d with SMTP id
 ca18e2360f4ac-85b1cfe8dbbmr745486939f.4.1741382502030; 
 Fri, 07 Mar 2025 13:21:42 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:8188:4e08:c1e3:fcd4])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f209dfa859sm1128924173.20.2025.03.07.13.21.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:21:41 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-20-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-20-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 19/38] target/hexagon: Define register fields for system
 regs
Date: Fri, 7 Mar 2025 15:21:40 -0600
Message-ID: <02aa01db8fa6$ebc6d0a0$c35471e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgKopPfltOdIksA=
X-Antivirus: Norton (VPS 250307-8, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 19/38] target/hexagon: Define register fields for =
system
> regs
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Define the register fields for ssr, schedcfg, stid, bestwait, ccr, =
modectl, imask,
> ipendad.
>=20
> Define the fields for TLB entries.
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>




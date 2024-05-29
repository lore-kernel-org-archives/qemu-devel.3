Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D83C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLKA-0000fP-Ku; Wed, 29 May 2024 11:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLK8-0000du-HD
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:34:44 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLK5-0005pB-UX
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:34:44 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so2810461a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716996880; x=1717601680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t/nO7Qv/O211c3rOVd7gOtNAMX8/BFciFS9PfRHH7Bc=;
 b=V1LaJNkaSikFsFuvJBlNBU8i1i9z1n2FWxEKeaVN0MvJoZzDnHddOfryELkBMzEyWG
 TZAYFhf/nyPcTjQZckSD7Z/NSgrq2lOEC84JiWAMnQAFLjAFJ/kDP9zj8KTbCC37THcq
 HMcWZ28qLGkalbuma9Lv7pk+5M/+bXmyZawTzMR3Vu4+A2XvktmbtvaNq5PL6sAvtMTb
 S6uH2WQmVpYuDcdH54LO9EHsZ/DL36gluOQK8RAjfzHbyInN9JOvmglZQzoycL2h01BS
 i1DB1D66d4WUmBUVBkBin745sOSt+KtLfucvlQgqRwg6g5g01LvgbbRDH0gR3K2edzgy
 guJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716996880; x=1717601680;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/nO7Qv/O211c3rOVd7gOtNAMX8/BFciFS9PfRHH7Bc=;
 b=Qmwspg7xzZWr0781+4aEwUtmczn14BWSeQ4ZlEoro0QygV2dPlm5nyjlpKHsSxq+ju
 8lA6/ItUS/VuTIID76/UITNRGnlQHqGgAPgtLKU6is2ueoXMcagEMOEiyGTGMNsrcwKf
 SYvvzylwdS5ZMAwKSiLUku+8rKtfj2eftFV3zpYylWbQrKZQnOcoritjOBxhp2jjM3GB
 wrGNPIikiA/aKCvahW3ipxAc8DvLsfwxeRogazTAJq1a0l82p0nemJ1GPUPBAmRY8tpF
 aZDNKZpDSRwtAH/PIowye1RC7Fh+5nxaRVHF0LYwDhLr9+ThP+2DEh5LA/DLWanIGJKw
 9DuQ==
X-Gm-Message-State: AOJu0Yx7EtdHGPRiB2DucE44FWozxmodYGZHRlNpJDDBVvwMY1Yklv/k
 ZD4EqSVJaYpfxYQtp5BSDbBTZh+WOYLs5nNpqTzuZ2dgaTY6pDeEz7JKpuFFiEo=
X-Google-Smtp-Source: AGHT+IHYdtqJJq2pgFwy425k6a+FaOatar9GGCA95l9MkqXfAiB2ponzCv3dH0gw1A/CiYeDqJs7Kw==
X-Received: by 2002:a17:907:86a2:b0:a62:c2a5:cff5 with SMTP id
 a640c23a62f3a-a62c2a5d017mr931562066b.56.1716996880279; 
 Wed, 29 May 2024 08:34:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda8f98sm725508366b.218.2024.05.29.08.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:34:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B75B5F760;
 Wed, 29 May 2024 16:34:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH 1/1] tests/avocado: update sbsa-ref firmware
In-Reply-To: <20240528182917.91027-1-marcin.juszkiewicz@linaro.org> (Marcin
 Juszkiewicz's message of "Tue, 28 May 2024 20:29:17 +0200")
References: <20240528182917.91027-1-marcin.juszkiewicz@linaro.org>
Date: Wed, 29 May 2024 16:34:39 +0100
Message-ID: <87r0dkeink.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:

> Partial support for NUMA setup:
> - cpu nodes
> - memory nodes
>
> Used versions:
>
> - Trusted Firmware v2.11.0
> - Tianocore EDK2 stable202405
> - Tianocore EDK2 Platforms code commit 4bbd0ed
>
> Firmware is built using Debian 'bookworm' cross toolchain (gcc
> 12.2.0).

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


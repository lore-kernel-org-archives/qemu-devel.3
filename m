Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED081C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwd2-0007Y6-Lr; Wed, 03 Jul 2024 05:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOwd0-0007X5-05
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:50:18 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOwcx-00074Z-4e
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:50:17 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a724b4f1218so583363366b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720000213; x=1720605013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rYekxG8Ntse9NiQsSQmQLyRMhaONwRXCWa4vrN1GsjQ=;
 b=c47SVZwC6ndgeACJ4LkOlsFWftF3tKDMbNNgbCYj0MEgwSEAxBlcTshfmFqIugXCUZ
 Um0Zc0+amMDw4sITk2ubUFscC/VKcfXZ+wvrOYbbCe8Caby4qSMGJzDgpOrY4RUCxTP0
 eKptdUhT5HF1CtYZed62C0Nc9tavOLyW/2KxAfx0p/T8cCfpTeFnliKRX1wbTNUe6G62
 IQCHCBOfQE5DOsiJ8Mlp6/V3WayzfaTF5X5POU4vtA7P2572V7ETizVeBbuLuCFEBiNX
 WIxzaO2n9sTQB7WjTmiWO8TuuUVW+q7kHHZ856JsPYVQDkFXvIGYiX7ZEoLQoSGbsFVZ
 8Ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720000213; x=1720605013;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYekxG8Ntse9NiQsSQmQLyRMhaONwRXCWa4vrN1GsjQ=;
 b=ssx/sM01PxC9WGLQoT62nJ9xS+kGmRJFBVTaOsJp/1IZaS/I2EAYznmHBmd8OyGjDK
 MuelR6Pw9dVGHy4qWa6W+c6V4QL5Lq5gJlOWyMCtG5P8Q/SQFm0Xy+xbE1fSHhuW+Qec
 V1esIG1OMmBeaDF8oNDnQdOHZpunx+uzAzgZFtLqX39Q9tUEoX3rgWJnLoKhLYKUCI+Z
 8zKwbV5u7VI0AsH+lZiwxOFqOxuLY9B13h6hOHqsEaqulZyDOL8j22WWtm+gpiVUBD/9
 NLzAAvcPTCDxP6ZwiTM2anKhUTduNPktz5UAmNsmKsCo9JPy3NVOJw7yiZwrmeEYg3fK
 hGBA==
X-Gm-Message-State: AOJu0YyeClnYTi/k4Gd9uk/KG4UtFrhFXKpUA2s6EaBm/mLpm9HnX9rE
 LbCRx9gxgB+abtL7ca/YKpRilSRA5kIDUNbpNCkI2ZKWDznIgToyOZoWYakfO0g=
X-Google-Smtp-Source: AGHT+IFMVnxvHmg3iNYBjBPRB2SCXnD0ZL8JBtAhXdoWOhSrg/2d07+z5a2KudrxAmpFFQCdqdcNhQ==
X-Received: by 2002:a17:906:f909:b0:a71:afc3:5c94 with SMTP id
 a640c23a62f3a-a7514498f2emr668253766b.74.1720000212874; 
 Wed, 03 Jul 2024 02:50:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b84d5sm491610366b.223.2024.07.03.02.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 02:50:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 498D15F841;
 Wed,  3 Jul 2024 10:50:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Cleber Rosa
 <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/4] python: linter changes for pylint 3.x
In-Reply-To: <20240626232230.408004-2-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Jun 2024 19:22:27 -0400")
References: <20240626232230.408004-1-jsnow@redhat.com>
 <20240626232230.408004-2-jsnow@redhat.com>
Date: Wed, 03 Jul 2024 10:50:11 +0100
Message-ID: <87a5iyrei4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> New bleeding edge versions, new nits to iron out. This addresses the
> 'check-python-tox' optional GitLab test, while 'check-python-minreqs'
> saw no regressions, since it's frozen on an older version of pylint.
>
> Fixes:
> qemu/machine/machine.py:345:52: E0606: Possibly using variable 'sock' bef=
ore assignment (possibly-used-before-assignment)
> qemu/utils/qemu_ga_client.py:168:4: R1711: Useless return at end of funct=
ion or method (useless-return)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


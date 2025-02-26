Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B33C021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 18:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnLpq-0004HL-62; Wed, 26 Feb 2025 13:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnLph-0004Fa-Q5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 13:08:35 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnLpf-000670-2Y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 13:08:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso1243885e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740593308; x=1741198108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/+NXxfl5tP0CR8/BMdfwaFXp0obGdeR3LfKYYteBD4=;
 b=LN/JWqYLUdkmEPD0+VQtv76avkuzTdR5YGJGa0MXtdQeBFabLUgy8T95TFUUnSLDiY
 0usEOdIwcoiU296oQbvVW0Wy7Yuqr0uHcAYZVUxgWC+MUkZHGSS8Hx0odYth77pHtwut
 4XCw/RIQjPq2JBy+mvAp7d5PkhSB7JQ9TrPV+HlOZd58h+3AmzesG3GDCBFTvOk3JgAi
 dDS0PrqzjqAbWhD5FHg0zeEqoGb68S7zG+YR4bSyHFRTHJk6YaPekXxGM5d19GoODhvk
 a0TwHcFbvIi8tyiBjyDLvvxIbqJL/y1Yy/AHHNGfIzttMo6T61X3/YNlKUoQ9F+YBonk
 yT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740593308; x=1741198108;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x/+NXxfl5tP0CR8/BMdfwaFXp0obGdeR3LfKYYteBD4=;
 b=G+6p0U7fRj0jTO1fPkFh5LIDYNWCcVhdsoGwX/cbAYkDHT8y2r+NkVDYjXiwqDSRhf
 vjSfAe5tIhFHhi0WRyXRxnSrpLYVh2UScm+NbLzN2aC32Ic7JjKSq+0mUw2FVCvmuY+X
 aaP/K9/Y4PdgXOj7CFk9uRdiLpI5yrU87VPFxrDjbVeZpKEQGFTIWB1sTyV8n0fNjTeZ
 SB7XqBK5qHSYVH34d64rlADH3+sdlgvucdbkvwCHxutpMRWEh8O6ViQEb3g6pPanRLhT
 1vIf9TLrtjMJN5DyegzmNvcqpac+BGHtviKeTzEQMMLh5GtSBOkdXkLN6pGIAnMhAQcj
 tIVQ==
X-Gm-Message-State: AOJu0Ywv29lHVaOX2LB1x1bkkmNbIl6cpduhuWtRpWsgzw/U+bnO7XGe
 3iMUsQlw391o+Yi196oDV/vRNM4Eqf4bzLK4kBxWdw2EYkXSs+C/1K+XpMZiif9Spq+GgTFjpS0
 vNlo=
X-Gm-Gg: ASbGncsUL+/XAHPeoQpfCTMF245tc9x2Fl7y/mtzT4hwsx0pzb1oEx/rqbrRxUny7cr
 TB01JUUplKz5v+7B1P+cF5u6Nk2eYYSteXuOY4VHrG6FXp4G7A/mG3E1RfryRhHW2bQZtHZblL+
 6QiMg7gwdhqrDIGFFXhcZ9QMTfLZ4tgLCHmp9mwuYVwACGVJ+fGDHnESI36D9fs4SNWimTEN0wz
 EXEQY8eLA//ciYpKs+5XPsW060sKTiOzc1pToMjMLdEOjOcZZY+079abA76Lw7eLIMR0sdYuY2a
 aGrTNBccuaUDT51WCBzUxWZMKNPr
X-Google-Smtp-Source: AGHT+IFOjehPzwfugmLQck5Z3v+9RmT0XGcz0AtvK9hR0BIYI3YwWNVQZlM7gerhjUFa1lQg6el8Uw==
X-Received: by 2002:a7b:c7d2:0:b0:439:871d:d4c0 with SMTP id
 5b1f17b1804b1-43afdd937camr3512675e9.3.1740593308238; 
 Wed, 26 Feb 2025 10:08:28 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390d6a32299sm2883689f8f.55.2025.02.26.10.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 10:08:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F33DA5F8C8;
 Wed, 26 Feb 2025 18:08:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 01/25] tests/functional: move aarch64 GPU test into own
 file
In-Reply-To: <f1e231b7-3d91-4efa-a2d9-32e731481c90@linaro.org> (Richard
 Henderson's message of "Wed, 26 Feb 2025 09:19:30 -0800")
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-2-alex.bennee@linaro.org>
 <f1e231b7-3d91-4efa-a2d9-32e731481c90@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 26 Feb 2025 18:08:26 +0000
Message-ID: <871pvk4m05.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/26/25 06:03, Alex Benn=C3=A9e wrote:
>>     'aarch64_virt' : 720,
>> +  'aarch64_virt_gpu' : 720,
>
> Does the split mean that we can reduce the timeout?

My run with all 4 tests takes ~100s but when people --enable-debug and
santisers that expands quickly.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


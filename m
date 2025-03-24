Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED034C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 17:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twlcG-0002op-5H; Mon, 24 Mar 2025 13:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twlc4-0002mk-HI
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:29:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twlc1-0007Ls-2U
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:29:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so42901785e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742837357; x=1743442157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8wioV3YcbdI6GColB6Zo3S7pJhtj4P8ic4ccrzLo7w=;
 b=d2Z9E+/YGxgJqj75boosVQCyx+ZtDXkOfL4g7Br1sIkmYXypOtxSAYH/7iF64OI4r1
 Z1GkyHoXLTodGWFASQCf2bcwX5lq8crBF1iHLbgeNiVHR7UUUl1fzm+vRa5Bd8z9hFRt
 9eX/rXRYY8AXeSkzAAQF/7ufhpGRoh2KWhdz/egVfyOtiWb85Qz6hQBDpYNtXJArqSaP
 dTTZO+DNT0okFl40fIUSRjl12vH+qJdXIH41ri9k/pSQ7O8EhVYwvwVwoUEp9fbeI+2X
 m1Vbr3Twg9yBMXbgS/Ag/qdZXbZZ3PElRYgWT9fHReh2sthMlVDoyDB0DBUF2qP4azAD
 McTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742837357; x=1743442157;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H8wioV3YcbdI6GColB6Zo3S7pJhtj4P8ic4ccrzLo7w=;
 b=m7cNIsQcni+LBBNGWO3wCnUqcTXsvydDo5s5AjGGufHZ8ZZZB1WIMd3JjbDEyjiigc
 YOEdgGHRehv/Xizs3iTbMgSeXTtdHXrDIHRSHPEfP5NJcF2DDYNVEyQs74qom07952px
 00A+2aXpmX7spGf+w0nO/yoHyzc+P6PljLQvUxqULJYTFbaNK/iRkr+YVxEBdRm3atAV
 /Hw6byI9X8Ta2VcOHqvRPDDvry5HPU43GzEDz5JWmkmwDDLLQWJlZ8PInvNQe5dF4Pcs
 Ry79EYy4/KL+PCfAnKd5d3/y5M2dAFxGY73umVgk1vM29VfdyYrEW2524lhnNxszaGAp
 c7tQ==
X-Gm-Message-State: AOJu0Yx6Xyf+W+ji88uY0zImb4UzfJr2zvb53G5jDzeGp6qjjVROiUm4
 LFREqbVIkYfsSTbKqWhdZQXYXY4JBihSPrOChwESXV3CE5S8esnQCwE4ntLVQm4=
X-Gm-Gg: ASbGnctchUZZbIe3yWJ3S+YGBmLQCWqFx2dICQYXsXa8sBOZx1LnT8NFXMpdPAeIOJg
 P15VBWkuqbB18Okjxs+d9TkZP1b3QcDQVFCOXHJxbWDhi+0oJkbg70DDHEpF8WERkVq9vER2ENw
 9HH20OAdxRF+7ehZ12wb1TzFxejUD6S3fHmr1///TK6iQCeA8FQNm86k9E6WB88G7aU84mb1fym
 y9W0Q3aYFBulHdq5/m6Q0y5S0ymJ3ewKIX3NeTeMX8jFFUVdlGK3GbDAsLBrfwZHrC6v86eUz+E
 niajNtKS4VmBlCYDADVqJYwzmOsjEAW1rx1QtqXGfPey2lN+BsSRCzs/Yw==
X-Google-Smtp-Source: AGHT+IFfHbyuNMUZCHHSRbxGGlZL2jSDsZaJOvGzmyiltRl/u5cZohHJ9fDWh+zDWSE30umdErYZdg==
X-Received: by 2002:a05:600c:ccc:b0:43c:fbe2:df3c with SMTP id
 5b1f17b1804b1-43d584351admr83378285e9.26.1742837357202; 
 Mon, 24 Mar 2025 10:29:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9ef098sm11291084f8f.84.2025.03.24.10.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 10:29:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B01EA5F906;
 Mon, 24 Mar 2025 17:29:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Nicholas Piggin
 <npiggin@gmail.com>,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  qemu-ppc@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Thomas Huth <thuth@redhat.com>,  David
 Gibson <david@gibson.dropbear.id.au>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  qemu-s390x@nongnu.org,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 11/11] include/gdbstub: add note to helpers.h
In-Reply-To: <729ee2cc-ecaf-41d0-afbd-25f51952dbeb@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 24 Mar 2025 17:46:31
 +0100")
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-12-alex.bennee@linaro.org>
 <729ee2cc-ecaf-41d0-afbd-25f51952dbeb@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 24 Mar 2025 17:29:15 +0000
Message-ID: <87v7ry2v84.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 24/3/25 11:21, Alex Benn=C3=A9e wrote:
>> We've not yet deprecated but we should steer users away from these
>> helpers if they want to be in a single/heterogeneous binary.
>
> Why not deprecate?

I guess philosophically do we expect to eventually convert all frontends
to the new API or only those that want to be in the single binary?
Should I just be more explicit:

>>    *
>>    * These are all used by the various frontends and have to be host
>> - * aware to ensure things are store in target order.
>> + * aware to ensure things are store in target order. Consider using
>> + * the endian neutral registers.h if you want the architecture to be
>> + * included in an eventual single QEMU binary.
>>    *
>>    * Copyright (c) 2022 Linaro Ltd
>>    *


 These are all used by the various frontends and have to be host aware
 to ensure things are store in target order.

 New front-ends should not be using these APIs at all. They should be
 using the endian neutral registers.h as should any architecture that
 intends to be included in an eventual single QEMU binary.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF10ECE57B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 10:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snbCd-0007Ee-PY; Mon, 09 Sep 2024 06:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1snbCT-0007DF-8q
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:00:53 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1snbCR-0007ko-Bs
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:00:48 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5365aa568ceso3428786e87.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725876045; x=1726480845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgd6Gpl2mrni7id126/5kFMIrEB9Aq8Gqvqhc2UvKc4=;
 b=bG2d2DiLUdnOHx9pM/E5QfL3OU9iJrKfhrRqjq6LI/sIsAbAgkN/r/ll49wZM0eSNm
 KpGg/cbtpqfkXhiDH9Gc03Nfc1Hj90SuIHmR82cNl7OqIt3hBbM1RSW3wqahjA8PPz0u
 ErQkcmpq6VSrJwQ0UO0aOC3QCSV41uF8q/A3+2sfpBEBqrn40HYhueISWjDCkXULu3Wq
 t8s4IAXQPNNCwlJ6MABFBuYaFCqt/UNyqwaLSznD6BEcBpAzj20Nxt84s5BmIsE/WCDH
 kDr4E3qdLCOYy6VVR3XqwVF76oT8HXofm1ntNxeMzWp+0hnvEFPkV3xwWjMp400cnS6Q
 dKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725876045; x=1726480845;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sgd6Gpl2mrni7id126/5kFMIrEB9Aq8Gqvqhc2UvKc4=;
 b=RySzUR/OveoZVu3eCyar0Jdq4KJBuEX12Dzb/TdUy352F9RPr2/FQp4tKl64dMpnyJ
 lp6TJojuwywNRbzPvuRdOGaeDLgDopiHGsLkfOdenkBPDHeV24RUo8uBET1FBAS6zE37
 QdIWtV0LYTfJ4MRyb5es9aEsA1yPwwEHSaVwcetX3xmiBfbEO2hQ+/djo6P12QwzWE4y
 RcMPKDaLZ5CJFHH3Ft48o8FK1+YShovPOUQ8UmW5uEDiaOCJ/0vklYkHLl05X2R9XbPz
 2GTPfQYNuN783r5nU46jSsAhBO+YYufZOJCPpJhn1p4+FysIBtLILrZ0fLvl1NV7vt5w
 tEaw==
X-Gm-Message-State: AOJu0Yyij9fz9pgrGZrqdCMybeimJmHnlFmtgNB0jFnVumAA4M/IGAih
 STz5S6phK57lJwrD/2iyr+7pkS4b9kvOQsOejS1iVkzk84L0sRnmwzoPeywI8FI=
X-Google-Smtp-Source: AGHT+IGka0mpOBXCvndBBTy/0F9wPP3JFturGlY+MzxIL/XGTCiOzMdoHvYJwoQ76IJZMWXnKt3pVg==
X-Received: by 2002:a05:6512:e97:b0:531:8f2f:8ae7 with SMTP id
 2adb3069b0e04-536587b537cmr10133738e87.25.1725876044111; 
 Mon, 09 Sep 2024 03:00:44 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25979e90sm319498266b.72.2024.09.09.03.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 03:00:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 70DBD5F73C;
 Mon,  9 Sep 2024 11:00:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Yanan
 Wang <wangyanan55@huawei.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v7 0/6] plugins: access values during a memory read/write
In-Reply-To: <68171cdb-8dd9-4d80-85de-457e84e17d65@linaro.org> (Pierrick
 Bouvier's message of "Fri, 6 Sep 2024 18:49:42 -0700")
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
 <8734met9c8.fsf@draig.linaro.org>
 <68171cdb-8dd9-4d80-85de-457e84e17d65@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 09 Sep 2024 11:00:42 +0100
Message-ID: <87h6apxi2d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 9/5/24 08:21, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> This series allows plugins to know which value is read/written during a=
 memory
>>> access.
>>>
>>> For every memory access, we know copy this value before calling mem cal=
lbacks,
>>> and those can query it using new API function:
>>> - qemu_plugin_mem_get_value
>> Queued to patches 1-5 to plugins/next, thanks.
>> You can send the re-spun version of 6 once the review comments have
>> been
>> done.
>>=20
>
> Thanks Alex,
>
> right now, my try to make check-tcg are blocked with the cross
> containers who don't compile, so I'll wait for this to be resolved.

Which ones?

> I still wonder if having a simple aarch64/x64 test is not enough, and
> covering 99.9% of the bug we could introduce in the future on this.

Have you measured the code coverage of the test?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


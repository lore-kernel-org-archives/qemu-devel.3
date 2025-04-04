Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABDFC369A1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZj-0002W5-LR; Fri, 04 Apr 2025 13:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZC-0002KQ-6L
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZA-0005m4-9F
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227b828de00so24214785ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786648; x=1744391448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cLk0Ct0Srmb1DscL8XYeqq85Dx7uQ2J7SbVfGD85ViA=;
 b=MIEO5ehViMCeBhlUrQCgFfywwOvkWRY3zczGzTFK59EUYPwQmXrrnfjE1jnwNXAcb/
 nTggmAHrF8jsTyMouDSewvfmcv7zQT8BGCfY6ZpId+vMpXMDDDS7tP3qXJ3gFj2cqZrT
 lE2720J4T+gmh0MA+jPzwD8/uKORslcD9MaZHdpe0WlUoERowVIqTsAGbiqAts7ekiQN
 b5QMeeJYRrGWKqct3RjZKLV29HdEGAU5pdXQ2flPyBo/ThXVDHQMInIHCOMF8uXePmF/
 lF833pCxfO+y+7Avhy+2ioBJKTj2Pz6JShDM2bAV1WoO1oWSdOaOxHPr6oFpnlAwUgv+
 iUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786648; x=1744391448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLk0Ct0Srmb1DscL8XYeqq85Dx7uQ2J7SbVfGD85ViA=;
 b=nc9W9zMpHjPybiMwTFnBloO9FbBl/h86Q8B7gpWC8wL5/Wg7qbb9SWnIWtUu7Yx9dC
 yHEu92WJvsUnWUGU1VW2cDm4jWwTdMujIytAa3npKTFicgluU1Ye5A/ogEmnikDSem36
 bT9yK+YfZnysrNFO4Tt0I5kZwJjlq1FzWrFhiXt6866AZORBQ0btfq93UKiQzzAvWOvF
 JtmNGWBmzfM2N5YdHwhtZCFWiSicVhIsMwdTpreG0Hdm26iXvE5LOsaMUglFzgqsHx8X
 hzYBquA8OYngO/F0o4CCh2F9AB6T1WdExmqsjHBYnCRkUW1TKtn2nR4lJUv1h8bBZ2i7
 17Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeuUr+aNCxkF44DfWEb65fhF3hSd96TH7mwtCXpQGAPzXpRhsbOmUTzfx29qW+up38HaGfVQIHUMRu@nongnu.org
X-Gm-Message-State: AOJu0Yw5w9VaW9SgOmBSONLk1Hx3kzVJs0YpGv6+LSqZyLRnK6VU8hE2
 3IoM2+kc/embrckePCEyN8IONeZUl1qbZ7OHuXvpoKnAdM+NkGwhmL1P7vGqOKM=
X-Gm-Gg: ASbGncsim/T5T4N7IdS2GSeszWBDrnklQGRZzUFbJbZvu7AKDtTZb+CY2hEZqYbnWky
 0jDWx4HH3RwQEYdmIjZGx58r24kHczfg6YiVCL07ZOUgZCtxvA02ikCdKyzrLSDsq16L8DjGkgW
 6B98swwp8o4l0LNMXoVq+0QyS0yYWnCu+wcRxc771JCNcrnNJPlobK4LomsamzlmMbHy/2JTf3K
 YLju+OZl+ztNXxVYT43xsjNq04HYivmU8/z+8oDcNSdn+2h6w2zpl5Cvz1WOaQCO8tY/YkL/vfI
 9bYCQFTIfHjjHPb25hYg5LoCCK6yhxOAga9kO1+uOSvbSNq3Z30z6U2/wg==
X-Google-Smtp-Source: AGHT+IGnB3Xo3mi3c/gHf+RGaIcgCRXdixaywzH4FVZTi+e7+zbOw2RKot/KzQXz8WlD2W07uBRhBg==
X-Received: by 2002:a17:903:18d:b0:224:376:7a07 with SMTP id
 d9443c01a7336-22a9552959dmr3224825ad.13.1743786648015; 
 Fri, 04 Apr 2025 10:10:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0153sm34730435ad.65.2025.04.04.10.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:46 -0700 (PDT)
Message-ID: <58473afb-337d-40d5-933d-447531c2d52f@linaro.org>
Date: Fri, 4 Apr 2025 09:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 06/19] target/tricore: Replace
 TARGET_LONG_BITS -> target_long_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICB0YXJnZXQvdHJpY29yZS90cmFuc2xhdGUuYyB8IDYgKysrKy0tDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQoNClRoZSB0ZW1wdGF0aW9uIGlzIGdvb2QsIGJ1dCBwbGVhc2UgZG8gbm90IHRvdWNoIGFu
eSB0YXJnZXQgY29kZSBhdCB0aGlzIA0KcG9pbnQuIFdlIHdhbnQgdG8gZm9jdXMgb24gZGVm
aW5pbmcgdGhlIEFQSSBmaXJzdCwgYW5kIHdlIGNhbiBwZXJmb3JtIA0KY29kZWJhc2UgY2hh
bmdlcyBhcyBhIHNlY29uZCBzdGVwLCB3aXRob3V0IGxldHRpbmcgYW55IG9jY3VycmVuY2Vz
IG9mIA0KdGhlIG9sZCBtYWNyb3MvZnVuY3Rpb25zLCBpbnN0ZWFkIG9mIGp1c3QgYWRkaW5n
ICJhbm90aGVyIHdheSB0byBkbyBpdCIuDQo=


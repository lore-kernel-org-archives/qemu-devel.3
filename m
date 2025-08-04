Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70112C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqfB-00065L-Rt; Mon, 04 Aug 2025 04:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqf4-0005su-11
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:35:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqey-0000eE-Sp
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:35:13 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so3795799f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296507; x=1754901307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O5RVg2SqWk3+B9/9EELchuK9142IIQaNCTOvKtv2SJc=;
 b=pvpYeliq+xuYwI3m6oS51K/zb2ybI+Gi/BbDOyEZ1g4PM1VGQ/W2xHcsvt7bCu3n9u
 p55pR5l1/IfZt8o237O6CMF5I5V3SBpmoonNiYrbTBjktbtw7ySSyOH47VdVVFk5bPeW
 YgtSz102a1gfnXihWV5LjoNwpmvKMIVOeWqWZ2oS0E1oRfQcJx0uD20sQo44217r4RCE
 GMybZGPmwT8lXmWV4nD6Yry0bmvxdAUntavXpTUlwPBUMaZ6PbxcElaALePFQJlI6mzo
 0ect3UlKNx9kdRJkxyyCKNKLgCt8fs/3VJvlDZpXNid4zVMrHWsd4dK99J9HZ5YKSfsL
 RARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296507; x=1754901307;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O5RVg2SqWk3+B9/9EELchuK9142IIQaNCTOvKtv2SJc=;
 b=A0A/9+jDV9Ua3J+ft7qTdUl8a8xXecOdMvXyIp/FFFkFPVWRoIlh7eWEjgRVyYhhUh
 rdpodCJ9GjSiL8gnS3DuK2OI4dHvwbw383cbkdr93cLQzXu9LTmoW8BWTvWTv2C4fzdW
 hNDY/k4hRRiNXVUZg7GtdfSCKeL9VZM2RedaWGaC5GSjB/JhvoPZZG9Mkrc3TdDQh9bI
 K68DSeiic3RDDKxWzglLgt8f8oSnxdZOJNvLl4pDiW81bcICuwPL+hrBKDaOUlVRT1T4
 xT0tVFwvkCoUyGDD6edIulFS7hcRryxl3X3boqUcJZ80Cv+59bmuX6NA7PWLYRKTukU2
 MzSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXttyM9U82nq2C/PaZb4MTNzLv7H/fyYN4QVhSABy7bbUxKqr8aH/1WlJMoGxfGbfNh+LwjruByDrhb@nongnu.org
X-Gm-Message-State: AOJu0YyUv7bUuL9d0faALvcqRMDpjKseByRgp1fNsJ+UPceLL0wPeo8/
 Tn+w9F3APhn+vbXYXLFwF2vuo0pPDdaiAYYVFIuVX5fT/7QuvcLsTg6mfZbvP0L5qv0=
X-Gm-Gg: ASbGncte7yMRTEC8fWQR0w0Yqppu88WWhMM5ZddmzEugfNzd9OmnIPdIDAxenP0gL3M
 Kzmz3xmwp7VNS+v9DqRLg9bnb9k2BrRENK+6e59gUrMT96qdNNQiDFTZMey5ZNOm0s4Xo+Z2OPj
 bnMQtJ40NgTP8Xn1PWiXCwh8ZNrIBn3On2KBHidEf1PzGb+2j3zA7SlaO9EFPCmDC7U+jN8Mypp
 jv50wWnvJ+mE2YuNbNaEbYpiWM81E+03s+CmOYyK8cairlOSDGGWFoT3fiVGzjlXYH3YF7Daho5
 euUV3X6zwIAjZ7RnyNSSxgG96PDE9KgpfOlTs70i2mbWfOl/CcYQ6scC876qJUgAzuywVZ1MQFw
 XEpF2dH8u0ppRyS04u6n1nvMD7cBjPkzuaATsiQStdCvcGO2p64WXKwDNUMGr3gVY03ZUaZc=
X-Google-Smtp-Source: AGHT+IFUSn41dEWR2/dcpUC0bp80lf1Ru/KTQ3c0A7pJMDB4ttHN3deN2aro7AS58lNXjIPWCks5Fg==
X-Received: by 2002:a05:6000:26c8:b0:3b7:95fa:ac4 with SMTP id
 ffacd0b85a97d-3b8d94ba89amr5809215f8f.32.1754296506870; 
 Mon, 04 Aug 2025 01:35:06 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459a1c79b0asm31530685e9.3.2025.08.04.01.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:35:06 -0700 (PDT)
Message-ID: <02e0d811-228d-4e5a-aa93-ca70c354eaa6@linaro.org>
Date: Mon, 4 Aug 2025 10:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] tests/functional: Move alpha tests into
 architecture specific folder
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-7-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded already, some
> restructuring would be helpful here. Thus move the alpha tests into
> a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                            |  3 ++-
>   tests/functional/alpha/meson.build                     | 10 ++++++++++
>   .../{test_alpha_clipper.py => alpha/test_clipper.py}   |  0
>   .../test_migration.py}                                 |  0
>   .../{test_alpha_replay.py => alpha/test_replay.py}     |  0
>   tests/functional/meson.build                           | 10 +---------
>   6 files changed, 13 insertions(+), 10 deletions(-)
>   create mode 100644 tests/functional/alpha/meson.build
>   rename tests/functional/{test_alpha_clipper.py => alpha/test_clipper.py} (100%)
>   rename tests/functional/{test_alpha_migration.py => alpha/test_migration.py} (100%)
>   rename tests/functional/{test_alpha_replay.py => alpha/test_replay.py} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



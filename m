Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69C7C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 09:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sghgU-00047C-9C; Wed, 21 Aug 2024 05:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sghfy-00044s-Bu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 05:30:46 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sghfw-0005R8-Eu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 05:30:45 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso9788102a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724232643; x=1724837443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qa6lKOaz9pTTU892SBDWXxp6oU2h5koEPpdJperzxIY=;
 b=YPg+44x8zLtRWOkjdDEMuyeJzYdokiy5TTVuh8sMN/sLcU5cQbGRNsJR7kygOzxlJV
 glsL4wPR78NYCT1TxU+50Df3jRoVsr+XHNrIpNnMDx3mwZEODvOxq1ZwrJ0/m2pj+I0l
 9A7GMOHebsq9cm3gir4+3Br6YcrkxjYROnGSghG7V+2qXDLSuqsNIEB7ZFHWw8wIBrF9
 b8clXgnbe4eEMuTPrcnvqIh6HgIABXYmhthySBmdIbRX6S/lCwxy8CNJfk2pivsn3rf0
 csel52h2SEjWEAa5dNGBSb322T3PCg8N8suG05Zk/zW471dyzMZrNhYgHFGH36V1QLQk
 rBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724232643; x=1724837443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qa6lKOaz9pTTU892SBDWXxp6oU2h5koEPpdJperzxIY=;
 b=eiQeLc8Z20w1yL1ueGDLXdP9h2Gk2Emcrb30P4CqnJn8Yni98wxanjmKUB1A0zh4be
 lA4F0eqOq1mlOdy9AmK/q1PtB+VkpXw7JYT3mKhESTEMLX2JTzTvQsutgCqucPfdqwMu
 Ltyo+2Q9J+qhRlhZYzRUpux4Xs3c+c+O3fVq/2dr/uWJ3ABma3XJ4LH4pfUSqhFgFQBi
 xvW03GH6ETpo/l6Pd2zDJssAhkNY2/lOJGmQGYVZMF8ENuVbuuRKxfsp1okeh0RjOgdr
 S6aHXtzwsZ8STJm4db5XhoIPdvkFEMk4Zu5a4mFIjtH2czG3roeralq2TcdOcJ4bdGN5
 2zWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUViz/90dn9uabfRRe8YAxTpbzmRfIaIpeEONTfcns9GMA/ZKeTQ64I75rsWJLdHfhiP0KrUZGjjX7y@nongnu.org
X-Gm-Message-State: AOJu0YxovIYzrssLjc2SAiHrzpVqAVw1N1vyQaUwWSkj/y0T2IfXVQDV
 T9GrUBZjaTOQ5kpBb0/W/epbEnnyqck5xoG/OkfIPl5u8aeVH8dHbEeD9SwMbFw=
X-Google-Smtp-Source: AGHT+IGplrGR+CV2UqnjxbZaXigY9CS0Q03O3iU5rThz+ag/8EzeFcWS41aeNkvwIKEkgleZwoL4kw==
X-Received: by 2002:a05:6402:13cf:b0:5be:dbbb:2d41 with SMTP id
 4fb4d7f45d1cf-5bf1f0b475fmr1508781a12.6.1724232642536; 
 Wed, 21 Aug 2024 02:30:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc0812a3sm7821675a12.82.2024.08.21.02.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 02:30:41 -0700 (PDT)
Message-ID: <1c2599e9-a4fd-4df5-ae6d-b1b8a05ce0fe@linaro.org>
Date: Wed, 21 Aug 2024 11:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/35] tests/avocado: machine aarch64: standardize
 location and RO access
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 21/8/24 10:27, Thomas Huth wrote:
> From: Cleber Rosa <crosa@redhat.com>
> 
> The tests under machine_aarch64_virt.py and machine_aarch64_sbsaref.py
> should not be writing to the ISO files.  By adding "media=cdrom" the
> "ro" is automatically set.
> 
> While at it, let's use a single code style and hash for the ISO url.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Message-ID: <20240806173119.582857-5-crosa@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py |  2 +-
>   tests/avocado/machine_aarch64_virt.py    | 14 +++++++-------
>   2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



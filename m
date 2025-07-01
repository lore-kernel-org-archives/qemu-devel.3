Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1EAC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWY3r-0000UU-S7; Tue, 01 Jul 2025 06:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWY3p-0000RH-CH
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:17:57 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWY3j-0005Cy-H6
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:17:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a522224582so2836306f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751365065; x=1751969865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qh+yvpcI8r39ZKZnBJSA3xxSTxkk3HrG+GtGOxH4/PM=;
 b=EfXN1qJgD2gYt3y+cyvflBrX6LD/KLxwWP5PkFVIU2zC5K0s2grLNSiz3C581J8PV2
 89rH3P3ziUbOgny2tHfl+cBy26R68pre8SMh/Gx2hQkotsHPh9dRw7m2OZ6CDegoX61/
 xhRS83qkGqy4z/fTkBBF1vr4Jk76spDdl9tOliqyLHD0g1NoTGG2VJ+WC9dqHXZ5hjei
 phIetlqYaa3tw1oc0XKXlAO5oBU73qos3DIMvLNfICXzjAGMq8jPcQt1Xa+ReuXAvUO6
 QauXwIUDW1Q3w28tTUqy/qpOuzd7BSKX0APwEYoJlX/E1Tzzk2BmNn/WkiQZA3dCnTLd
 4Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365065; x=1751969865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qh+yvpcI8r39ZKZnBJSA3xxSTxkk3HrG+GtGOxH4/PM=;
 b=jaIzlfYGUVz8mMvZAQ+bRP37G6XcPLBjWUBCOxaTpNCSdkeD2WJdAuByud4qPxN5TC
 BlG6b8Lknqh44Tv/GAzNjD+cEOYrPXc7ZAV2eDTj9EYPneW3jRmWWJNTAidv9bKDsc3d
 nmpXfDl4Ibej0B7fiiZnIzpMbnqdE0cIHhv7uTXcX6X9cYUf6Rq/fqxOoyLT4S2r7pLM
 pCU7lgL9d9DqeXZFkEpBaxxdz6pPaMIFIL70dcLuMHMabb94sg2+2EzU5Ua/QbA5ufd+
 hKDi5B3AeOXJ1CYuegxcyJPCfVNuKvjNvdMgHz4054Jb8qwMA+ExTd1hpDJZjdJzaGA7
 anGQ==
X-Gm-Message-State: AOJu0Yx7He74jqQfw6HKYJ3N5PY5M616w7Do9fC1RkU16qTiaMSPpm8Q
 iC4tpLzF05tepU13Fq6WaVxzC/c/LWHVl25p/2DCRC9xWMVpVqVzRQE6Y2MKQduPdAk=
X-Gm-Gg: ASbGnctbvQEx2IFb2Ig33mmne7h08kp88Xh6STrsxcFygVeopF35wvyNGb5iZl/D633
 OfmzkcsXzTHcdvzO/teky/I66OdLtwdc9XWsBZBr/Gv2mDOUT2SbREmMT9eGHxa6Ei94EEhpWYT
 rajO0X/tygzRCExvZ8/4O5uoWiqAD7CMSQNDjqMrg+RMKQUIXSivRb8JuSBoSRpuLBdypso8m57
 QPniX5bV12/55fPh5C1nV3pZthD6uLFVoK+ZTBZLNrFuPyy1FTckdAbmoYJADoCRqRZhtCJvalY
 g+aqJ9qELVbX4Uw4ENoobB6M7hujSc7fD8hJVOFvuoM+OnscoCAdVLjCQ4E9AxmA0Ys+gSP+9PL
 XrJXhAzYvhOqwvQKXhMrc42XGZhUN8g==
X-Google-Smtp-Source: AGHT+IE5IcBl2vXleQw3Z4b776SWAI+wP2cBamwyIbAvuDtna+L1v0oFCMG9wzPPraFIdJIOW3LE1g==
X-Received: by 2002:a05:6000:2b0d:b0:3a4:dfc2:2a3e with SMTP id
 ffacd0b85a97d-3a90038b75bmr11438237f8f.39.1751365064682; 
 Tue, 01 Jul 2025 03:17:44 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234b6b3sm195419235e9.13.2025.07.01.03.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 03:17:44 -0700 (PDT)
Message-ID: <ae5bcf94-b9ea-43d7-b3f5-fb3a5674f9fa@linaro.org>
Date: Tue, 1 Jul 2025 12:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/26] target/arm: Restrict system register properties
 to system binary
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Bernhard Beschow <shentey@gmail.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-13-philmd@linaro.org>
 <CAFEAcA87+SMWdSOGBaGuNDzynaLzoFMKv3PJmbfTyd3mN_TwzQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA87+SMWdSOGBaGuNDzynaLzoFMKv3PJmbfTyd3mN_TwzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 1/7/25 11:55, Peter Maydell wrote:
> On Mon, 23 Jun 2025 at 13:19, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Do not expose the following system-specific properties on user-mode
>> binaries:
>>
>>   - psci-conduit
>>   - cntfrq (ARM_FEATURE_GENERIC_TIMER)
>>   - rvbar (ARM_FEATURE_V8)
>>   - has-mpu (ARM_FEATURE_PMSA)
>>   - pmsav7-dregion (ARM_FEATURE_PMSA)
>>   - reset-cbar (ARM_FEATURE_CBAR)
>>   - reset-hivecs (ARM_FEATURE_M)
>>   - init-nsvtor (ARM_FEATURE_M)
>>   - init-svtor (ARM_FEATURE_M_SECURITY)
>>   - idau (ARM_FEATURE_M_SECURITY)
> 
> I guess these are user-accessible via "qemu-arm -cpu max,cntfrq= ..."
> syntax? Makes sense to not expose them, they won't do anything
> sensible.

Indeed, which could be confusing for users (set this property but no
behavior change), which is why I prefer to not expose them.


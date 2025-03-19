Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09588C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tus8u-0007ru-Tl; Wed, 19 Mar 2025 08:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tus8t-0007pD-Ll
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:03:27 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tus8r-0002cr-6f
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:03:27 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5499d2134e8so7554836e87.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 05:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742385802; x=1742990602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KVyIYio6vNrv9ELdVXu+H+F+YB9yOSEm/tZLel0XaM8=;
 b=C4rMhzk/dZhUvByX6C1P0royvuFi1upjzegGlmPM1Fru64OFGyisPMSNAxD1XhkAnT
 NnkCfu0uethGCTcAKkXikHP2tDWA+Kyg1988AoEf1Mw3Hxc/7m4Usi1742nLmDqOWkj7
 JyTREMLPwfwHz/DzZ8mXyj6FEzvSffoDq9GtD9XVnTLaYMUdkiqgvf42F4CGWTJijZWq
 YqLUAqwyGYiVlDWAsdzRYKHNbohXvuI9ky6rxfVNVWDdRSn1XPZd2f5H18Du6jZsL2X8
 /STVX4Hy+SfnX1zC4DmpnDZA3pvsyy+AOprWEZJXB83w2Okfvw1+hCcVavicPJIEK6FT
 jAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385802; x=1742990602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KVyIYio6vNrv9ELdVXu+H+F+YB9yOSEm/tZLel0XaM8=;
 b=uCi3CF3kVpVL0dEtGxGRCfBRcQ3Zw+SS7IukAh+OnTHjj7NsP7xYFuJRaJV1CW9b44
 w5YnCuC5zQnE233DHlJ609XZtqwOQ/DapbDEEOyKHVplGcAHDuvKj+VntAg1l4Ra8SxF
 ayzFS7O+RJ2jDmG/Uue5UVyfWSrKj27hSG1wySnd/CQFV0GQm0kLMz/Whz4KeIIOtReQ
 OhEH+sZ5FEHLt/pbse3NMh/DXuFNKNgAnBGg+wq4kysQiGXwtr+llTwYLEefwZC0ZwGH
 /XlK8sFIjC4ki/N5PDOytq8WYz6PGVj9s6W5qTpGN+4CQCsZEBagYjSDkpOi47hBsrrl
 mUWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY4/01quFBRmI8oK4N/VfB9++RrtRs8Y1tdtwEqrUs8SslEv1nPwEuvySJ85Lvd+JtPw7MWFJl/s4o@nongnu.org
X-Gm-Message-State: AOJu0Yz1V0emIQhn4FQxTJ0KOlHstEc6acRqzi0qw7DiprdY4K0uhETf
 +AUbreZaHrMxADCRST668Mm2X6Uhb0YsOj79QgZSgjv0V8UIhJ0EXeHkSqKlALc=
X-Gm-Gg: ASbGncuLU/3viTNYsQr5cBZh39wVFg/ARsCzo4qQpj0VoJwzvqznFvpv/4Ch2nDJm/3
 +V2nZoK5SmDeq0tALIl6xe0lpHNknAxLgMxUrg8n1LahVGZc3ZrB3/mS9tOZOVY478BqVVrxOEz
 r5qVYYvdtBXFP7n7rO543trJBrUPzRv8igA7eGqZU7wAvf4yHtA1TJzt1sjWjkwaoyEOUtAAO/b
 VVFCBqjz45h+HMbfstQ14+VkxuCtgLEz53tVaQYuUJF9eal6cRCm11fU5f80swkfgGGySMid613
 fWhRO0AYgqMuACn9i0LR3cx7XE3KmTMeCSiRYvh8ut7jiuTqKZEVINmHYXLHYTaamsqVL9iTkWM
 g14D3HFLmmt73XT3cbRliSz8=
X-Google-Smtp-Source: AGHT+IEBwdGRDGjlXliOt75ehhraPm6oDmRK6Pdn7nAXcG/qx3cd3uLuH+Xac8IM12EJyAC68rMbuA==
X-Received: by 2002:a05:6512:3dab:b0:549:7c13:e88a with SMTP id
 2adb3069b0e04-54acb1b6cecmr925819e87.17.1742385801661; 
 Wed, 19 Mar 2025 05:03:21 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-549ba864e18sm1988247e87.109.2025.03.19.05.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 05:03:21 -0700 (PDT)
Message-ID: <a5f66f3b-1070-4021-9616-beea78a2be1d@linaro.org>
Date: Wed, 19 Mar 2025 13:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_migration: Use "ncat" instead of
 "nc" in the exec test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250319105617.133191-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319105617.133191-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 19/3/25 11:56, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> "nc" can either bei GNU netcat, OpenBSD netcat or NMap ncat. At
> least GNU netcat currently does not work with this test anymore,
> though the comment in the test says otherwise. GNU netcat seems
> to be quite unmaintained nowadays, according to its website
> (https://netcat.sourceforge.net/), the last public release is from
> 2004, so we should rather avoid that binary.
> In our CI, we are only using "ncat" in the containers (it's the only
> flavor that lcitool supports), thus to avoid silent regressions with
> the other netcats, let's limit this test to "ncat" only now.
> 
> Reported-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_migration.py | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



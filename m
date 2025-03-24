Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD66C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 17:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twliB-0005Av-HK; Mon, 24 Mar 2025 13:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlhq-0004zp-Vj
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:35:22 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlhn-0008Dl-Ix
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:35:22 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30332dfc821so2799176a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742837718; x=1743442518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eoaD8YFe488a4ldBxRoAefiBjbsMm56Uhf96bx3V/qQ=;
 b=Gp66FB8KQI9ULLA9ep3mwHFEsYrkHnu6kvoqTUXpCyUvg6aCOKI6gE3hmwA7gMmQSr
 Jk7qaH5Jhp08e4YEKAHjBFhAIz7JuYfJwV3nvrQH/Ckt1o6ceS+AJHA0W+K5vHXNrMSF
 ldV0coy1VSaHBw97u6Pvf3ksdafmyJKf1cN3zO3HjwWT540pVghVqYwNBUGzHbbjR8nZ
 1akX3vnztzatsd+eMpZ9DVykHLDcG1ze5Kw4Uqf+GIY9QQ3t39ttu9cJDB5/ZfuntQv4
 3nXHFNEx+Y1QHR3xGIiheZWgmxYnn/eyAnL3kAEUt5iFNDjXl6ncwlFOI2ujEDsvSJ02
 Fn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742837718; x=1743442518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eoaD8YFe488a4ldBxRoAefiBjbsMm56Uhf96bx3V/qQ=;
 b=DUSy2pzuZHjt2u0zlGkH+WK/1ZB8kAPidqH7ZWA7qME1fQYl794osyNDmi+/UexuXi
 0or7t8t1WoDQny5TesqFABD+8N+nQ0FJmBU2042Chx1Pv8Fshg+89xIey/AQXrSW1kEQ
 dl0s1UDsd/iZJtks3JmqfoWPwNTrZv29UAh8D9xfXefjigLim6a15Mguh15hJlDj7YEz
 9ikTOgdi04DkCeYxDnXPsHwd7P57RpsUZSLC5AGVp0NwnMQ/d3wxlMVJRyorojLczG/D
 6wtf2qhLQWWuqVGczolac80v7YNIqiOi1m57w+gIlRNE9cyLZfp+FMaojciQ+g+TnKN1
 trsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAFA2DEFZz/HLnFWO8JSaHJ1iO8QBCuvxdrTVpjLZ15oveI1RXY2nL1v5Z3f3CEaHc+acb1W9jye5S@nongnu.org
X-Gm-Message-State: AOJu0Yyk5Jxi4LcLnYZFWCV95ENsgRE+kVmw1z4klmWpPSGgLUZ8TvVn
 VErCGuyoZkjDvDaS9dFG9oWlg4mtZQmmYhF0q4TvROZhwKJJ+evZ+Cv+FtIWaLI=
X-Gm-Gg: ASbGnctV30G0W4Y+AS6Fj/z4qzzuw4bLtwUvQcQd8ccj0gR4ibY5uGI1l0iuvONOKbj
 eUq7ST4JmjkSuV5il4ch0ywyx0g4faLGQI6FOduZkTus5+Ei1xItVzwzhFd130gHdQ/2+kKNoJV
 4mlb549Jqz3Yvr90K7uL5ud2sIT+EimFW60bU6ok6S/C8hSlL/5/fQDq7exKdQDKjBy0tzYqmwI
 1LTyw50qQ7Hl87ziDAMSIqhd+umo1p1Qaq9IjepCDa5Ei5yffW2sXPL1rK1yN+tY5TL0GEg+7xF
 vCy+NIId35+aVDq3BgDXAHwp4sS8lVKlN2aYxeO9xChC/sc1LgNdvEfKCTJpfaPwloL66m3gA+n
 90Hsy1LPT506gLKzVcz0=
X-Google-Smtp-Source: AGHT+IG/Snj26w5AJhYoACS79W3jRPimhGijSdgYskip6cg0TmDD85vEZ+PaeNxLRrI8oHbMEKZJxg==
X-Received: by 2002:a17:90b:4c52:b0:2eb:140d:f6df with SMTP id
 98e67ed59e1d1-3030fe8d64cmr20302303a91.1.1742837717730; 
 Mon, 24 Mar 2025 10:35:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5b7b23sm8552349a91.9.2025.03.24.10.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 10:35:17 -0700 (PDT)
Message-ID: <6225af3a-d824-40a3-835c-ce5c90da7a3f@linaro.org>
Date: Mon, 24 Mar 2025 10:35:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] target/ppc: expand comment on FP/VMX/VSX access
 functions
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-8-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250324102142.67022-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/24/25 03:21, Alex Bennée wrote:
> Mainly as an aid to myself getting confused too many bswaps deep into
> the code.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/ppc/cpu.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


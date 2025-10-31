Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCFBCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnee-0006ZX-4f; Fri, 31 Oct 2025 07:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnea-0006XT-Ob
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:50:48 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEneW-0005hB-4E
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:50:48 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b6d3340dc2aso598072266b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761911435; x=1762516235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hQHlfDzZkIKvwhUPONKEN0h3U8H4inETL+0+fdu2Dw=;
 b=O7xQYiA0nnZ61K1F2s9peF5PGClV61cOa/TQhQPMOtVG5xIjtg2OddAa7XNmM935Ss
 TF0Qh3TrbN26zNkqsXmkSPoyGd3Q0Ub0oh7anY2DoQC93YZnmAst4nOonqna7LrS8AjT
 r0HlbZCKc4jkvvdo4lkkwhmcRJoQ9Bg9zpSFk8pBiyXa0tmuvHJBSdqY9MIjh7ylW05v
 ET0qlCILJCxYlQv21HsFze/mkXQ64vOzlqMN5ZZbp9W+CHw6C6hjdRYhfv6xfdvnnix9
 0EsrcBQ+2Azo8Y21Wdmuc+f0hJcJtCZMrMCz/eSQi6EdRW0Cc1Lu2eEPyOBnOOekweW+
 9tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911435; x=1762516235;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3hQHlfDzZkIKvwhUPONKEN0h3U8H4inETL+0+fdu2Dw=;
 b=EKU6bOjSVVu7QqZs7dYPLTGZtTuq+dAiQd5eg64j95XiZdZzyYnhtxjCf5XhhLOw11
 GoVV8ua0uLpnu5iNezHBT7QLjPB2mh6M1alRl++8/qFWCvnMSDeIfybwhYmSZjaPcTHh
 2t4s7jLQQ6M3hP9LpXoz6MvUBkwmsivsCW15CH9LEc+VadOT4uX0/iuK6f74yU7gJxYy
 vC3RYvBi1pgffPX6FhXWgRNiU90R/K/oJQpSfP8DASdNmagkasIdHv7p02K0pxHFuKw1
 FvQ8oAvhpmj108XFpbWgNpVQNe0eYEAuNQh2Od9rrVw9Lgxa+H+RlDPhql9Br8zPnkbK
 bR8A==
X-Gm-Message-State: AOJu0YxMqLkglh0LKMbFteKjPL20xcjDuAyN0YuM2Oxcuen0lXfVtjea
 bJcpcnX6nNifMxc2F7bkJqPAZ+VWO9nThmUCIGZxneOfKxOYVv4cNenjbRMYJJwHUivnN8TEQMn
 GtbjZygg=
X-Gm-Gg: ASbGncstSPBYsJL1yqiEOuQeLCRe0pZ3TZWbAcsrX6QukEsvWK4WUMDYD48ncMD5Pr2
 YtnagdIHJvRF9ufPn4VbBN+uDSEfm30rsHG4PPIyTMSFFzqaLL0Oc0nsmpM/vzMMUML78AT5Gt2
 tBWOFPCzRg2UcPRjn26U33wUR6+Y+K/OkLqJ5Yv7HwMXYTTbDQBB/CmVuPVIECmRDx5kod7UxGI
 3UKieQs46XOhg+IvDm8KIFk5DjyxsI/tWrdKez1CaAp4Z/HzpjgbJZl7A0IfG1Tfy1cSLygVDCs
 YAFTk9KyHyMcbVEyFP9l8u3aexyekAMydLJqdLW9umsGCWvegrULdxs6UfGihHoxKVDQtgITIiu
 +AjiLMqkgUz2MFTbpIiy4q5L/b1uy8AkqFHltYeOyTYBJbZ/2d6tk2LGGIv/25T1U2T5Na/XLpw
 D8V/hKcTOU94RdVfRXN9ErEuQRms+IHVymgkE2mJoCgeoL+2mpGtjKpfdx9au22Q==
X-Google-Smtp-Source: AGHT+IFupkMrupgRnxy7dlMDnEvo+gUmOACbyyFiaw87o4f5pbUXpGEkBqFE6X1RtrfAyq1FGtZJ/g==
X-Received: by 2002:a17:907:9707:b0:b3c:5f99:dac7 with SMTP id
 a640c23a62f3a-b706e54eabfmr350412566b.21.1761911434916; 
 Fri, 31 Oct 2025 04:50:34 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077d065e1sm154996466b.71.2025.10.31.04.50.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:50:34 -0700 (PDT)
Message-ID: <74c5441c-2d00-422c-b301-93c9215ea02c@linaro.org>
Date: Fri, 31 Oct 2025 12:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/functional: Disable flaky MIPS tests on our
 GitLab CI
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20251031094118.28440-1-philmd@linaro.org>
 <1e445b6d-f1a4-47bb-b34b-38b37967e0c3@linaro.org>
Content-Language: en-US
In-Reply-To: <1e445b6d-f1a4-47bb-b34b-38b37967e0c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

On 10/31/25 11:00, Richard Henderson wrote:
> On 10/31/25 10:41, Philippe Mathieu-Daudé wrote:
>> Disable both replay / wheezy tests which have been reported
>> as flaky since too long.
>>
>> Philippe Mathieu-Daudé (2):
>>    tests/functional: Mark the MIPS replay tests as flaky
>>    tests/functional: Mark the MIPS Debian Wheezy tests as flaky
>>
>>   tests/functional/mips/test_malta.py      | 2 ++
>>   tests/functional/mips/test_replay.py     | 2 ++
>>   tests/functional/mips64/test_malta.py    | 2 ++
>>   tests/functional/mips64el/test_malta.py  | 1 +
>>   tests/functional/mips64el/test_replay.py | 2 ++
>>   tests/functional/mipsel/test_malta.py    | 2 ++
>>   6 files changed, 11 insertions(+)
>>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~

Queued.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DFECF31A9
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgev-000110-EQ; Wed, 19 Nov 2025 06:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLgeq-0000zj-Mz
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:47:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLgeo-00031H-7S
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:47:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so3770485e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552847; x=1764157647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zyYcqZXPjxQo7eXtH5Egj6+pzsjzgmzi6DJRwQ8tT98=;
 b=vgdatpWVBfXO2snlP1L8xMEcv+rd+yCd2Yuwy/bwIPqTmpTLYJAmpOIjdqzSHkfMZu
 4kTFjSqK3kvI1amF51rgoxq2N3m3G70HZ2b3UKpOBcdN46e/GKs/LGndfeZq7i0YVDKn
 +k4cOyJFUC0IN/kujUUuQ+RwuVCUNIttIR+vOCihatGVmtiJMfigC+X7UIfRPbLstX2y
 00c6Pe6BdjhQp9FeLQbCuQehUXTOdXc7zLCQL1hGG7aPRlqHJUoeDX7VtQMYsvyLc6wO
 guok6va21C4AqJJEhHvsR71fH/YffCNWnRDUxF+Bo0XiNWKHONj9n2yeEeavVGeaXMFM
 Fv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552847; x=1764157647;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zyYcqZXPjxQo7eXtH5Egj6+pzsjzgmzi6DJRwQ8tT98=;
 b=wUUWmw9cNpYaq20yAIP+TFDVodp+HVMRa6et0PpYomV2NZf81gNGxg/QlDR0qogxK1
 ldezLI4wnCqclMh/1kqOiaj0v/Bak6Lf8w5jz/FahTKbRAVC63tiZkuzSq8u/GyRclaf
 6R7ceMWqE+L2KPktsjctAo6qglf3cKfLzWpivgy7/lM4WuOvnI7p77a1E6oWvFcFBG0L
 DsLhS7w+QeOIatNYg6vPRA1jMK7ZwmIP+9DDIIrTcKDsWTs4uqbxgD1kc6G8ZzC+NvVR
 9iHvZHS+DQp2BI9Ucit+dxircsY3DhNg7Wit61TQ3R5n16K7wbDpGSsVOtywtiZMPJ6F
 SNYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeGi9jCBh3+ORF3HPYXI9uGw48HVTfWn/ycctPTugFYq0gQk6cMozyCC/YoeAASOKoWn/RqfcanQ/o@nongnu.org
X-Gm-Message-State: AOJu0Yx8HdCuR+TkULUvuMOtkIkPbVZEsaCwpeYp+pdhIq1d+ASIkCc/
 LiSwkAkSBNjAbGf1hyciE9PcRHC9U5BAe6BP5mwMROf0Dwgv48Sn2PT3hZr+mIuAWvw=
X-Gm-Gg: ASbGncsTSGiPn6CfzOCL3xnPTZdy64I4jkTXnB7QQKYkdMvcMj9wpWxTFiVi/R18xvR
 dI2kCk9IsH6ixts+aHComK6DqB9tRQhVLSsrLqw3OpI6szzv3faiq04GU6BAFad4c9Ch+m2aKwM
 C3rJhonIWZ2rFxMwaiRy1+EApEMfY+ymec8zXHEPj0AVX2VTHfps5lRP3pu6cAUztm4CrRUW/+T
 A/y19bfUMYukHUSP0YXykhLV+m6ShKSeVMvT+yN8xBKe/Jjb1np2kY8ESSZLvRk4TswxyVYhTg4
 bFV0fCQRzKKZsw5r9jrkN3djwpq9GaAfwagQpH3Y+HSTaRd/L2olK3xjJwG+QiEwkCkJbUw9y9Q
 3BkpMJdo8DhYJgLefKx8fNkv81lrP8t/OjPNvUOl85AtD2NDAX2G7xetHbAIkyiFZjBsLTiErp4
 e/DztiJwq/E3l7Blv8k5lFzDn+pkPvKEYzvVFbs3Ao8ZQjmKwp4XHGIAytD0BX/UnT4mc=
X-Google-Smtp-Source: AGHT+IE16eJ36y+cPNx9HSyxZ+rnwIXZXvw9LdMKhxCzg+dqm2gzIgNQQ5I91fhC9bKVcIJ99Vfq+g==
X-Received: by 2002:a05:600c:c178:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-4778feb2401mr176378795e9.29.1763552847210; 
 Wed, 19 Nov 2025 03:47:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e0c802sm37706455e9.15.2025.11.19.03.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 03:47:26 -0800 (PST)
Message-ID: <ec06af13-b944-4d44-937f-5ebe1a66f54b@linaro.org>
Date: Wed, 19 Nov 2025 12:47:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Python: fix tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster
 <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20251118200657.1043688-1-jsnow@redhat.com>
 <40e40d05-e491-4513-85b7-48dfe8f5c178@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <40e40d05-e491-4513-85b7-48dfe8f5c178@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 11/19/25 12:30, Philippe Mathieu-Daudé wrote:
> On 18/11/25 21:06, John Snow wrote:
>> Whack some minor annoyances down to make the tests green again. Fixes
>> both minreqs and the optional check-tox.
>>
>> John Snow (3):
>>    python/mkvenv: ensure HAVE_LIB variables are actually constants
>>    python/qapi: add an ignore for Pylint 4.x
>>    python/qapi: delint import statements
>>
>>   python/scripts/mkvenv.py   | 24 ++++++++++++++++--------
>>   python/setup.cfg           |  1 +
>>   scripts/qapi/commands.py   |  5 +----
>>   scripts/qapi/introspect.py |  2 +-
>>   4 files changed, 19 insertions(+), 13 deletions(-)

Thanks, John.  I am applying this series to master as a build fix, being the last 
non-flaky failure we have right now.

> FTR, per https://lore.kernel.org/qemu-devel/20251117185131.953681-1-jsnow@redhat.com/ 
> reviews:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Also, kudos to b4 shazam, which picked up Thomas' r-b automatically.  :-)


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9965AE73146
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 08:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmpNR-0000gc-UR; Mon, 02 Feb 2026 03:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmpNQ-0000dR-4r
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 03:33:44 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vmpNO-0002Ok-AC
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 03:33:43 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so6385245ad.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 00:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770021221; x=1770626021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UhI7T9K8VX/VQLlocdeYSWSgu+sUedlFjc+ulc/7k2k=;
 b=tzcDrdHXGJf5cCLHdkkQju/M+zpa3ZMk0vafPpuxvljHc4nmtLdu5xcm95pU8YNMmO
 hBtgUznoU11xHpe76FqkopqyfWkejE4oaZxdjvKaCf34LqXbXjfg++5Phnyf1zoh/Z2a
 7BazZhs6lwqew+bejORdIk4tSBFLWKz816dxco09eSw4EHUuentElT8W1G2x0gZnZTzQ
 nO7eGucxZriNnh8S4h4BnqTUTkbnZVauPmrtq+X3jfAo9qQDwYCgF1AS03a8QHbXtf2j
 P0lXsKu3EpC6EweZARxYTD/uGGbbF4Kfh5WDYRjD+kVDpXYYwlL6qYa/HjrSghOEy9rj
 GRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770021221; x=1770626021;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UhI7T9K8VX/VQLlocdeYSWSgu+sUedlFjc+ulc/7k2k=;
 b=vAc2vH73QH3P4X4r+dv5KpQypuSi5PqZU+hpOisJvKS12lYuNOo7RB9+nIXCJI+F4M
 1n7RPOmAqhq/he3lW1TPvEL3PpTOVjluZHTjgQDqj5AefsvGamv3GLBlEM0oUtae0YyN
 VPlmY0UTNDN+qt8GuoUdKPO69eqrclI40oNAjRWlenaGm9zPT9DbKaZ9AOxh094i3UB5
 aO/qWvwjvY01cieZTXPtUXVe8KZ/S9g/qYJNFU59CePu3cdHmVGvVb6QQUUFoh7SfoOk
 bVRGUnX6qaNY6zq1HKEYUjl/m3Gh48Cq8Q6JjMB1SHl5ljNOSSqe/ahiSjEwaMJZClRQ
 N9Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO9YQ5zV63wMmYfLGaZ+4UaN9F7613tFKervq2wRSaqQqN31Ns6ncfgNTe5UZFaMmgpCkf/hdjNsWJ@nongnu.org
X-Gm-Message-State: AOJu0YzIpy7Y/VwsIJbThN5V4YFB3pTN0bzzkcKNXQrmCDv0PxA4+L4o
 fiHT6iSUCRWFN9lcdplEomwdpGyb+STrU44N1FB+KziMAhZsbPopXUmNtoSOBoRcfQM=
X-Gm-Gg: AZuq6aIHCcD3z4/yvf/+ObCUprdy/ZwHjETT9CaSV/axSaMnEhCml12HNTNEc584gJO
 Z+MYnc9aSJ+2mixeJwda9sfFPsnEUBLYFgKowJoeQhhD5djdvwUpcvsbDFwRmTw7JC/eYdCUdRr
 dsB8O6PuQ+jV53rrzMSZDylk/TYqvkN0Yvm5s8XskgB8zx25GG+lJudsQ23HbUuIGF6Kq/6UiLq
 DtpiADBhK89PYy9clE+lkszDIWyo+zGVfHLnVZdGU8SUqyuxttdTswnaqCQ/LACx5FsaLZmUqe2
 Ygj4tE4TPgHqw9Y9UfQeHc11N5FpWm7LfUwgjsiXqiPdA1+tdBn3kNAMXp7VRmfcCgHGTooA2AA
 DVFSgqmxbsGY8LABHpCybccuCLsQmzzSvs8rvIGWU8b23p+11Ft9ClbipE4xm0qmFMABeyoBg0D
 g25Pfw+AdC78vE06erXzx9/wnjuTFWNR8CnsU8VFub0edc9PBTSupFhTIzuR/OvWczK4wC3S6oD
 uAObxp7SF0=
X-Received: by 2002:a17:903:46c6:b0:2a9:4c2:e53 with SMTP id
 d9443c01a7336-2a904c242c9mr45727665ad.48.1770021220785; 
 Mon, 02 Feb 2026 00:33:40 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:e524:51ca:ff85:53b9?
 ([2401:d002:dc0f:2100:e524:51ca:ff85:53b9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a8ec56da8esm64451315ad.13.2026.02.02.00.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 00:33:40 -0800 (PST)
Message-ID: <cab53fd4-1e4a-4bb3-8295-6fe79818a6b7@linaro.org>
Date: Mon, 2 Feb 2026 18:33:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] python: fix msys64 wheel directory specification
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260130050518.517688-1-jsnow@redhat.com>
 <20260130050518.517688-2-jsnow@redhat.com>
 <4268fecd-4460-4fe2-b0f4-579a171ffb6a@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <4268fecd-4460-4fe2-b0f4-579a171ffb6a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/31/26 02:08, Pierrick Bouvier wrote:
> On 1/29/26 9:05 PM, John Snow wrote:
>> In python3.14, fixes were made to the file URI parsing [1] such that
>> file URIs that used to work but were technically out of spec are now
>> broken.
>>
>> As a result, our msys2 GitLab CI tests began failing.
>>
>> Stop using "file://" URI links in favor of simple paths (Thanks pbo) to
>> fix parsing errors under Python 3.14 and fix the msys2 GitLab CI tests.
>>
>> [1] https://docs.python.org/3/whatsnew/3.14.html#urllib
>> Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/scripts/mkvenv.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Thanks for this patch John!
> I can confirm it solved the problem on my side as well, and works on windows/macos/linux/ 
> netbsd/freebsd.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Regards,
> Pierrick
> 

Thanks.  Applied directly to master as a build fix.

r~


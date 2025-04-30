Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183D8C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA9hC-0004tw-TD; Wed, 30 Apr 2025 11:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA9gH-00042g-0l
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 11:49:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA9gE-0000yJ-Tn
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 11:49:04 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22928d629faso80934835ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746028140; x=1746632940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JBOIUIlFOSBLx6bJg2VkhBH0+Ko96dSHQgR2E4j9Ztg=;
 b=WaVWmeprtVYPyYQRxwBnnuqn5CLwXdwmd5yCPtgCkxvdOqWVGY8bUXvAOyOZ+ZK/dS
 WUDnN2TahSO7T3lzTne/p/T5eMiRbcj/XvK+vZ3oG63NIQ6uERBatbX0ljCk2Nprbgy+
 izB/pGDtJvJfbHpXk2kp5kYwnI1b0TXjErSpfkZ7IEF3+ZjrNtupPLcXgWVaiBqRoFUg
 mVwGYg746KtTLsqzBtthzOMzQ+HinLkGV8aVmelmuXL2ceAut1Q8qiyPkd8zVR+ttyvy
 iOZhu5fUTyNf7TnYMgfIm3OugDuQe2uLXL1Mvy5BkFa9NdDREPpctd0+eP0D3SkuoAqF
 B04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746028140; x=1746632940;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JBOIUIlFOSBLx6bJg2VkhBH0+Ko96dSHQgR2E4j9Ztg=;
 b=X48ZyYSBw44lKQgPpqKrnlQ+ueDgm/WBM/LpFwZUVyzQRGOXSglB67eckObxbXuNGn
 krb4+XoIduBQ1HYWZYs2ZurJh6HjLQniBVveEqLIVg8cgJRuT9abuZiiIGM1QSintLYz
 9Ar0XSkPLVTWBu4Grmi+FhDBRimdhq/AtkbgW0OeqeEJn0u26m/BVuEPeQ9EAyacoOfK
 iArNVE7IDfFhzwz9Lhm9kmyNQL3oFQ69prP4dR9sbG1pBqziPjWLjBDdWA5Pg91QT62a
 AikpX+Yp3TNdnKFI2NQt+VT5XElg5ZXjLLKdUUVjd5Wjqjr7fJRuBht3LoGVjSth5ZQ4
 5v8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW189fLj0yW8c8W8yLtZYIo9t5HdNYHPW261b+5hIFOMTnDaB0/VqrKMAmUSVTZ4Wd9riC1xVubOnTV@nongnu.org
X-Gm-Message-State: AOJu0YwTVJ8oGu1NGe7NpBX+Qh4XjL/rUKLeICepznPm4axtP1KqKq6H
 ABrHF+raTVonXJDVl2j8/oDANdjuYsMU3YST9AFWNo/XijJeYjoEQOwXFSZ8JFQ=
X-Gm-Gg: ASbGncvbjEi54L7DIv1YP/BkPRke7gN+TGBmZXLQakbWZfK+UoGeV3msg/sD20q8Hs7
 MvDlDhTyzOMuFkUJQQ9rHcTfI3J2pHkcoFWbVjrtCxyrzGCHLEStPNa2H1uzPeWFEFmpUGInqwI
 5gvQd1RdlbJXqrk/xSxSod5XFdCinYurPamNhpboRFPfpPhf4u5V/ZRuGUJXGR94DIAdaGQN15L
 sYUntNHXpt9K6XwbRSS0anvjHSonMT1sPz9n5wW0jYh+MlHjr1WyNHA/dXQ249k8uC4H8bP4jdZ
 ckGmZz1JtPBd5uAdNPyWLPeEvBovwWiwTKZbRNsH3wIWnmRqa0gbew==
X-Google-Smtp-Source: AGHT+IGq1ZnIV6JxWImdLKncWRj0OujFWGChK7GS1++5jsFuFZvXP4Dd8NedGsszb7mvJ+ZF/p/rUg==
X-Received: by 2002:a17:902:f685:b0:223:f9a4:3f9c with SMTP id
 d9443c01a7336-22df34a60dbmr52641555ad.9.1746028140576; 
 Wed, 30 Apr 2025 08:49:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7a6csm123631495ad.151.2025.04.30.08.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 08:49:00 -0700 (PDT)
Message-ID: <6e9a3cb3-e238-48a7-a67c-c95b36a517bc@linaro.org>
Date: Wed, 30 Apr 2025 08:48:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Functional tests precache behaviour
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
 <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/30/25 8:00 AM, Thomas Huth wrote:
> On 30/04/2025 16.34, Pierrick Bouvier wrote:
>> Hi folks,
>>
>> $ ninja -C build precache-functional
>> 2025-04-30 07:23:20,382 - qemu-test - ERROR - Unable to download https://
>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>> gzimg/armv7.img.gz: HTTP error 503
>> 2025-04-30 07:23:23,131 - qemu-test - ERROR - Unable to download https://
>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>> gzimg/armv7.img.gz: HTTP error 503
>> 2025-04-30 07:23:25,870 - qemu-test - ERROR - Unable to download https://
>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>> gzimg/armv7.img.gz: HTTP error 503
>> 2025-04-30 07:23:25,871 - qemu-test - ERROR - https://archive.netbsd.org/
>> pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz:
>> Download retries exceeded: skipping asset precache
>> $ echo $?
>> 0
>>
>> Since we silently skip the asset precaching, how can we identify that an
>> asset is not available anymore (temporarily or not)?
>> Should we rely on test itself failing when trying to download again this asset?
> 
> The current logic fails hard for 404 errors, so if the asset is completely
> gone, we should notice it. For other error codes, we assume that it is only
> a temporary server problem that will hopefully be fixed on the server side
> sooner or later.
>

Sounds good.
Should we replicate this semantic when running the test itself?
It would be more useful to skip it because an asset is missing instead 
of reporting an error, except if it's a 404 error.

>    Thomas
> 



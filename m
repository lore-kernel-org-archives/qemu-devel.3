Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E53CEFC3D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFCP-0004nX-Ip; Tue, 08 Oct 2024 14:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFCK-0004nG-Tr
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:44:41 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFCH-0001Rr-RB
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:44:39 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e28d7d44dbso691372a91.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413076; x=1729017876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=11lLXYQ03TGvdWKSHnAwKlnxwSiWZ0G/c7nwKUjblss=;
 b=el8K1qccKM0qFrsOelR4Tmf+OoPWsSrC9HquqJ+8zvFQ+lTeXZXkXwQbVJDlsdzhI/
 m+kjNGhXcm1awClzLwjMI16lFMSfTvcobyEGnOuplNMP5KiHRauX6XBpxNlTMAm3WPIx
 KMoGjwPONmi9EbBgvZ2sa07u7TrkJthHBINis9Wn/rtl7x/iEX5FiNn4uICSJHrGoZLz
 NQ4Plb57K6m93KoQgMgJzCEAKbaGaREG8QIKkl+YIs9BBpsFr95qx5dcmvYlgXyg7/+Z
 GKOsaqmo3tXZ9em+PG7ZaurYdUrhlGmISsRJrbD0fmwZA+RmPn+tTELXTcCWJ/hnvnwS
 AoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413076; x=1729017876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=11lLXYQ03TGvdWKSHnAwKlnxwSiWZ0G/c7nwKUjblss=;
 b=QlqBfO9E0jPizoyZcNCI5ihaBXJ5ZZbH4F8hzglw6onsme+irlVs3rbgbIgQ03q5Gu
 aGG/cxX3gAsXAw2/M2JUSo/KOYcBkn4sNXstk8Gk5s5QeALMiq/7zL/aMk8+r27Z1+Lf
 /T1hRjW8U/2/bhT8iKKou8jd5Gt4AtY3Ze9RH0EhEe/ujVvEEc0pGdsHERPpQS9L/Oh4
 QlEqQgUwNffcijAL/U+j9rEt2Kj7lPpMoxJ5BlhjCEOEMAkmioaPY5NuqufrDI4UJCsP
 QM9Wx2x1cfhPlCY0OAtm1YSAntFZri6dGsZ/bLuZCEH9dHZDOajt5piKg58b+9GJsQYn
 93Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ3EyV3C6DxKKwe18rRWzab/4fe2RWtBYXdwgss3rDown9Hn+vdjrfxuSZ4Z4cf5w4uG0rcF709b0I@nongnu.org
X-Gm-Message-State: AOJu0YwBIoIlhDvYEVCfPJs++2aGdgrdG5OP2d6mHzZgpjbmPRsATDIG
 CfKRH1we4pHleY6spjTS+kwG1YwB/g61fletdqYu0cB//CmaYyeEf93itJwLCcxRZXH1dYVZoUG
 Z
X-Google-Smtp-Source: AGHT+IFrMgqzHwV6mjNLZpeSz97Kj3Gwauw7sBF9/3ycqQfCzUuJbMFpVpdVbpx046bv1fN+nG1Uew==
X-Received: by 2002:a17:90a:f0c3:b0:2d3:c4cd:245f with SMTP id
 98e67ed59e1d1-2e1e6296d27mr18061274a91.17.1728413076327; 
 Tue, 08 Oct 2024 11:44:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e29a306bd7sm265260a91.31.2024.10.08.11.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 11:44:35 -0700 (PDT)
Message-ID: <307638d5-395f-4193-b36e-fa38299f2607@linaro.org>
Date: Tue, 8 Oct 2024 11:44:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] block/gluster: Use g_autofree for string in
 qemu_gluster_parse_json()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <20241008164708.2966400-1-peter.maydell@linaro.org>
 <20241008164708.2966400-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241008164708.2966400-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 10/8/24 09:47, Peter Maydell wrote:
> In the loop in qemu_gluster_parse_json() we do:
> 
>      char *str = NULL;
>      for(...) {
>          str = g_strdup_printf(...);
>          ...
>          if (various errors) {
>              goto out;
>          }
>          ...
>          g_free(str);
>          str = NULL;
>      }
>      return 0;
> out:
>      various cleanups;
>      g_free(str);
>      ...
>      return -errno;
> 
> Coverity correctly complains that the assignment "str = NULL" at the
> end of the loop is unnecessary, because we will either go back to the
> top of the loop and overwrite it, or else we will exit the loop and
> then exit the function without ever reading str again. The assignment
> is there as defensive coding to ensure that str is only non-NULL if
> it's a live allocation, so this is intentional.
> 
> We can make Coverity happier and simplify the code here by using
> g_autofree, since we never need 'str' outside the loop.
> 
> Resolves: Coverity CID 1527385
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Kevin Wolf<kwolf@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> v1->v2: wrap overlong line
> ---
>   block/gluster.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


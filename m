Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1748C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7r8s-0006EC-Ex; Thu, 24 Apr 2025 03:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7r8r-0006E1-0m
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:37:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7r8p-0005M4-BU
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:37:04 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso3936675e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745480221; x=1746085021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjOeLkkhcqFnYjdEDIMiOxCJh+p63JK1r8GtZQUA2SI=;
 b=t8l15pg3gbjb6m28uDGQb5syS2scpwxVqYLCbIaZ031MQRdR52CzKcvEXQzrg3uWZO
 fPxW7nSohPtnL5iKD270qDgDQHv3v1shBGgO0RoAnNxyL5FqDzseBjINks2xuhCFH4qu
 +lVRscNVxom17pvYwAUyN4x8k+gm3CtCk5Cpwp7Q4uBn4GMIwo0nH35DWnxTe3Hj8BNC
 S6B7WMI8mVuXYZgat0ONcqoxVIyCj34ePPlxO7F9vZ86xStWqD1BM/FitPqFOjddvN1X
 EAgLGRuAcLdtNEBDBGvOND9Cv2wfMfNClwVMeTfFkgNbQWBJXep7W6xOYlZMxgHG43OM
 JHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745480221; x=1746085021;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YjOeLkkhcqFnYjdEDIMiOxCJh+p63JK1r8GtZQUA2SI=;
 b=lCj566bZENl76fl1qOyt3MH97oFhz7lVEGxc+bQHNNkIGvHkPzKf4BlLv14mnz4bLl
 flo0LolDRDeiUtkvcrEcMVjcyIN2+t4x0pyjoHWUF+LxEigGEilXaD4uF3iLipFWQcqI
 gEE1lUYpLDqAGGQvUExlMMBqgZ9ADZ2ZRVQx4X5rlaEFf3f00jo94H104EsCOOyJwSwK
 79y5e5Zltf4QBOJrp3kyUHGaU2SuLEf5gIc52YAlYNSEzyDLswBKFIo+RBoQ1E2E8u03
 cs1JiaLJKOan1Wb7/AZWRg2QHvMJucgZZNO6TDQohDWYqIMMHIR4LLm5TK2WC6QhBJ0c
 +u/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc50us5aZ+CsJ1CjrEouibM+y/jSyQeCc+06aXtJ5Ho5ZIDrG96/VM4qlBKdKnkwWCBVOTyYASZrBl@nongnu.org
X-Gm-Message-State: AOJu0Yw3sJlWkrJmI1a/gQk2SsF9K/rsXIxDVqixJOiHEMfqwOzfNKMs
 K2LWd/Ll5DDhABEUiU12JaZwPeinVa/dK4MM+6anMyPOG6tEMonUEfk9AnO79I4cckw751Pla/4
 i
X-Gm-Gg: ASbGncsjCl+cJjog7BT+gZnquNbiEV3cchq5/pqGTU4x33wnNFd3Bb6dCU93AYkS7RM
 Bi0Wwsxy9zwMM5KqVET+aHwB6/WV0Yn8gVxVYbEOzU4WjBI+TfYbLsuzaniBY7CTljSlThxrYEJ
 fN6MZ3/lS/bgYOY+3G+jfzmE4CAIwCtkTjK1K1+C6ImA37lupi+KQ+2r6FMa+1cH+xyTWoe+388
 7qzycPl8E5jHS27CCHtS45Svz9HGixgMQ4aYefiC8NssFpRUNA1QjV8+N5jQ1neqc2IEOx+v1QI
 fZjuCz6Ti28iOU1DQ9kxOUgGp/KWUZs5DdBzF6LmP76bjZZGO2aAT98LR/vWADlligKMmzbZKOQ
 P4wmlehwnMYCjUpXedZVezJcK
X-Google-Smtp-Source: AGHT+IFjb5AmxHs6+CNtqlheelaM7lvGMvCaDXpmhtsDAP24mOpO9Hyzi7oiiVx65WlKXM5W/QoWqQ==
X-Received: by 2002:a05:600c:1f0c:b0:43d:fa5d:9315 with SMTP id
 5b1f17b1804b1-4409bdaafb1mr11929155e9.33.1745480221111; 
 Thu, 24 Apr 2025 00:37:01 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a152csm9458955e9.12.2025.04.24.00.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 00:37:00 -0700 (PDT)
Message-ID: <35f49ccb-05fc-4143-9af1-c4a43e83d293@linaro.org>
Date: Thu, 24 Apr 2025 09:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-15-richard.henderson@linaro.org>
 <d48bfcaa-5d98-41cf-9ab0-829ba5f8bdd7@linaro.org>
Content-Language: en-US
In-Reply-To: <d48bfcaa-5d98-41cf-9ab0-829ba5f8bdd7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 24/4/25 09:33, Philippe Mathieu-Daudé wrote:
> On 24/4/25 03:19, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/exec-all.h          | 4 ----
>>   include/exec/translation-block.h | 4 ++++
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index 24383b6aba..90986152df 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -120,10 +120,6 @@ int probe_access_full_mmu(CPUArchState *env, 
>> vaddr addr, int size,
>>   #endif /* !CONFIG_USER_ONLY */
>>   #endif /* CONFIG_TCG */
>> -/* TranslationBlock invalidate API */
>> -void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
>> -                              tb_page_addr_t last);
>> -
>>   #if !defined(CONFIG_USER_ONLY)
> 
> We don't need to include "exec/translation-block.h" anymore, please 
> remove it.

To squash:

-- >8 --
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 90986152df3..4c5ad98c6a9 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,4 +22,6 @@

+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
  #include "exec/mmu-access-type.h"
-#include "exec/translation-block.h"
+#include "exec/vaddr.h"

---



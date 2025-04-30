Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A80C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACPU-0008OV-UG; Wed, 30 Apr 2025 14:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACPT-0008Ny-OL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:43:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACPS-0007oa-7b
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:43:55 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225df540edcso15025575ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746038630; x=1746643430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eERu5hpha4PpgkMhmqqhBzBFgIZvmQXsSQLAuCeFsU4=;
 b=j+q+d2++J9K7+7wObnwiX5Lrp60ssHbgCSe1doVIikdOlhDZLwmvhF6GjrvecE5WZR
 3+an4o52XBB9C0ex9B4jfaxdWAA2WH2GlYwpQH7kG7koriSCgUdBwV5ZgYlM/lFaKWX1
 8lewBs7X1JUemQQCGmEM7vAa0CVDGRM8oKwrR/yV+cydadNBWUqBbCQTLyGO7AbQO+Ni
 /z/ULLbthUfz2xhr6bc716xjiHzdRnZdgTfiP5KFlp0WC9CENvJQ6bE9iYeqUEQLf8Ps
 DDXv6zyPeMDmjk+/4uD7RKv5cxTVoHgPlj/5C2RvT0QB6qe7fUr8/qbL5PyInF5sbK7C
 jm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746038630; x=1746643430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eERu5hpha4PpgkMhmqqhBzBFgIZvmQXsSQLAuCeFsU4=;
 b=lwF1lyFw3Ror/AutcoL6FaOjK9BnarZuHfQ5DLZkn7p8RwJkMizeIxHSmqgLfLvyqm
 mps9ZggWagDqbXdXvWE8FOAmqqp3FYdxgzEbLgY65jtOSNIAhSLwWEF7QFeSFismV2pq
 dQRTWIWueLXrfLFWXac4PBZTVlxg2iuIHAmCpPZMqDb0G+AWUh3ZZ8XmbVR7sM3tgzaf
 NQoVxo9OnapAJfKKip6rcpuqGLiNe+03WQ822FCAQRoWJZVQsk43Hxdzqo4V2WqONipd
 t1WFMnPFDBYR0GcsKt02Pge87fiG9i98jARzb/7nUSPf/SpiopiBIstjoyIkNSWriODB
 Aw5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjiRblbLsNcnMS6DaOLcYMYlK8IlW4afuuzLOdphxQjteba/FRPqcRNPaqNWnfKN+KWMr4IGGwvIeL@nongnu.org
X-Gm-Message-State: AOJu0YwS4wLl2Ke0750lNPnMYk5HqhPyAvyvhPpPIA28I79tWT836WSA
 c6apY39FDYEvp54Mt/1jH+NCFOwlZ5upncggUjcgn2hYrn1Y2xHRNGczDGoRdto=
X-Gm-Gg: ASbGncuhjXxsNHW7GEBIvrkhQ0lpx3dySkz7LMeNbwBK7fbjbjfS8k94uR9gDrBKek+
 h68bmP+HfD/idtUG7fvdiI647ibqMPr7yJSDwexDN3vFWwYG3QQPWAWbq6/sJ0XAkEfyiNEG/Fm
 GCNHU6Sl4pxsybMaZoB3I5FVtQ5DTNne4jHNorwtWAbCWX9PuZ+3uy83M7/s4s3yYl4QqNn85Z1
 KDAPAZPf86cAq82nG9RLQM89rHyiaHLSXDss64iUv9MDNYemJRkRH9utk+/VK5R6YfNQa1tVN0z
 MDj4J9MG2ecQpl91xsdkdh8+2zcGgeIs4AHzclbHcEH47hFUjTku15W067BHm1JAK79Ccy42nW0
 aFXT+FT8=
X-Google-Smtp-Source: AGHT+IFcTY0EafwDz49gNChfNmQsOIOBymhD6KYDInJcF69ZZEdaHOS8/3OcR7xmJH99nfyMr6bJUQ==
X-Received: by 2002:a17:902:f541:b0:216:271d:e06c with SMTP id
 d9443c01a7336-22e03491b39mr6315505ad.4.1746038630387; 
 Wed, 30 Apr 2025 11:43:50 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221c60sm125821895ad.228.2025.04.30.11.43.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:43:49 -0700 (PDT)
Message-ID: <db654764-8377-4080-8f68-7fc61e8eaaae@linaro.org>
Date: Wed, 30 Apr 2025 11:43:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] accel/hvf: add hvf_enabled() for common code
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> +++ b/accel/hvf/hvf-stub.c
> @@ -0,0 +1,3 @@
> +#include "qemu/osdep.h"
> +
> +bool hvf_allowed;

Even small files require license lines.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7031C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHsJa-0001y1-FD; Wed, 21 May 2025 18:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHsJY-0001uq-HB
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:53:32 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHsJW-0000BK-Hj
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:53:32 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30e7e46cb47so5992239a91.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747868009; x=1748472809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wcJT2kIk89iHTxtboW68hw5M9Lgdha4/NUieuiFxM0s=;
 b=YwKfiDosNzDyZyYl9BfAnL2V2InYiwLyurEhQQnxOSvgWqRW9NQQyhYJPUdzPoDvID
 VQt1YSIz4ZlJre/CggvZfzjf5OvjXruVO4TMnbGYwq1o5/ofkcAsfr0iKhe9j7PBE1CM
 E7RqtxKpDp3zaAe20UyfaGRZgQIO9nC3bI3ceHHP6VEFd3ymTl+ZNchXHdS8rquLZNUr
 I7ywHbxwEBrltcisAK5wGE6qF7exGtGGr8b+te07MbLYJCRec3URRe3h1h7z+2Aff1tb
 dsz9O1J6qj0ZIR8Lfbywx3G1RcEgRUBIBDtZVFtIxk2njoA2s7V3h2WKwCJ9I8ABKQ/1
 rFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868009; x=1748472809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wcJT2kIk89iHTxtboW68hw5M9Lgdha4/NUieuiFxM0s=;
 b=TdJdYxgpyqoZRpnFa0NKLUK0hfp16aGPpt66myIboParjsruGZ6JSGmEOaaLq8H9n1
 ohce2hYrz/siP/q3xfT6kZpwfIRJiF9ZGNW5U9CLN9oHrOr0uD2DQZSX7G9byEy9raRT
 Q6arAYcv4/85v5cUPtEw3Mp/PUP7K7C0YxVnImwoLyNxnyb34XrsRgRhmhgL/03IxOZ7
 HED2Skvv0q9ay5lJzXSKrGH8dJu/kTocMXsO+ySXcngvNdRIyND3wzXTlU/tS1eWG4JM
 F5f1FpXxtklqmG572/EoPo4wcKWOxgVEgRsidqgU6nFuhwvnZTSxZ5enUa7WHvMw7O2t
 AaBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGZJhoMrh7H0TQfPoBy9v6EYnLNJa1g+JVUSK3JyVL0JcmPBo5O6d0c8WtzvpVEqk2QrmNrulBiayZ@nongnu.org
X-Gm-Message-State: AOJu0YxL2OKfXwZFmkf9MrSHxGWLt+FElhaIU8Tw+r7VIXN9a4qXwjOg
 52tNsCFdpb6xF4DVux4+BxbIXb/x+OXi8WDh4pXBm5jbY8UxogeKvd3VBw5eAs3kHEA=
X-Gm-Gg: ASbGncuhF+3updtxZyAbEgQKlL6amBOkW2arCL8gf6PnISG6vkicCv38AMht6r3vDb9
 Iq0hOSlg7y1HO/xT+IpvW1lEoLgrin17Afn8Mk/MzrI4Z5G+9fljlakdNYkBPvzGeMckeurw/an
 Q4nD6SP9cJWFDp4JVpzpw7Yi/QHXSIX9TSjg6m37JZaqLfXGacscYfKNV0DcEj1XeRZZDBulTGW
 ypJH+YSL1cy6A56c2k4/RKp31i4wz/fGXeiQEuhzH5IPMth3VYtzyHWwFQ9X+xHgp83hg35A6pA
 5wo47v4PI+V9jXwHajOO0rEiUMLXEXngcSUnkpMJHqy7PjHex8/T6kybFtnohipp
X-Google-Smtp-Source: AGHT+IF6nNNjMbz6GUI6a4zne2NEXRiBOS4ciV+Oq57aY1ib7OgxILyo80WnJSvSs9qZH+aFDnAErQ==
X-Received: by 2002:a17:90a:dfc7:b0:30c:5479:c92e with SMTP id
 98e67ed59e1d1-30e830c7988mr33822085a91.4.1747868008725; 
 Wed, 21 May 2025 15:53:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f365e5bd3sm4186512a91.37.2025.05.21.15.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 15:53:28 -0700 (PDT)
Message-ID: <f81ee368-8056-49c3-bf10-983412261ca6@linaro.org>
Date: Wed, 21 May 2025 15:53:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] Add memory virtual address write API
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-5-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250521094333.4075796-5-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 5/21/25 2:43 AM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h | 21 +++++++++++++++++++++
>   plugins/api.c              | 18 ++++++++++++++++++
>   2 files changed, 39 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



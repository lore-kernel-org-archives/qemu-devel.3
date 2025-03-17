Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D14C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDmv-0008Qv-4J; Mon, 17 Mar 2025 12:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuDmn-0008Pb-9k
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:57:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuDme-000407-6Y
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:57:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2241053582dso37374775ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742230661; x=1742835461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l4+U+NkA1KcByv/WZWfm+L42XLXTbuFgkBpKt1aIzNo=;
 b=J90jnO0XoLFjmX3oPGyy+11JhF8sqCsGtKWhG7x1dliMzPc+L0nFuQVvRbYzNFIj2G
 sTsa5/xKRD4CDVxIYUaDysAhQ2FirhltAnZQc9tsZVLeBONZRvyJbVlnbv7whnXe+Hq4
 +CL1mj/o+9Jhu43dy7bjsP1BtK/Wpvh38sY3UtxULsxtUrTMc3J3eNVAzzB6kHWKoyXx
 ClTf8I1oloBCtHeX1O+snnGHua1/4dQcBQHdjoYP0jJd2wgf0uI8zL3q5xUNcpNj3DWi
 tQC0H+tUS+jBpOuVRt1NOiY+p8vH1CAfhvhpgRRuu/U6eAeWMFTpcvVPKG5Ve+i0T/pq
 3aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742230661; x=1742835461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l4+U+NkA1KcByv/WZWfm+L42XLXTbuFgkBpKt1aIzNo=;
 b=l3XnQoZhJa/HqcvjC1fZqrd8bB7qQcSbOdLdTmW2XI54C7mtoj5dxZflqnGv1jSPBl
 UcMeyCuHqVgvsHl9THvOAHBu8iUWmT/rB9vMaEhH0AjDkWUkOc82aiT5w/kYIco6wpGq
 xuH7U08uJEb42WKFvyWXENAB57rOtZXehQQB2q+M90Ol5LAYKcTmVydSGwPcsI7JeUaW
 w6SUM2R9S9CVOKBqCVIWT7fyACA6gQ7aqTYex1M8+eEAJKO83N+RDoKJYYap9W7kdHSy
 2THP1YG0MVCPgqXnVubn0iMDk7A+X6I5hdbTwsPiEmQE3YdHlC/kGVdFPsSgTHBYMhhU
 YGnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9GzEQ5eq4bKYbcG7EH/gmoYyMawXDHet3vUfI1F/cnITwxyOlmQwFkf7qSrhkJFG06+r4oNY2z2ft@nongnu.org
X-Gm-Message-State: AOJu0YzsYusBLUgKgP926wBZFMRjfllvujvGun+0YZRi+K3ejuZdcvfR
 6XKaXN7GObxUd3N1UDCHTKLHStbnA23DQxwXucxq/rUGTVzgpPmh8wgQa0htfFM=
X-Gm-Gg: ASbGncu8UfG9Av40SxcNiyZkZAHu0xu5V0vpy+X7qzSacI6r7ysDLbO8ip+T4E8qeI8
 4lzat3oXVOsAXPVGgEDcLzuYj6aBwEX+G/iw2XxTbZs4KS0NG7jksNKVwsocGIVuNcsxgROM47b
 5Z/YmFhU9MSzIBlQq6G3J2EECJiXQ1dWVLK9s+l4IuGLMKef3v8x1WAqpFbqEFeqT4lyYtFXEX3
 M6D5NYWoBD4ecUcAS/5OyNDeE9eWLdicEYd+pYbHdeG7ideLJJopwr1dwdBU3BSqnRMWhYpcKti
 adO+MxWqmonaar29X8dvaShpawFA0bTaSOQccJwYropaI863F8nZKzfUamQjF0WbEiR+XzImlKn
 3TC0uxNdE
X-Google-Smtp-Source: AGHT+IFppBsCpLfhxcSgwWy4WOrjQv5cX0w2xu0KMnG3sPT1bKfvpN3BMktI0e9PmRz+gUC88+R5mg==
X-Received: by 2002:a05:6a20:4306:b0:1ee:d418:f764 with SMTP id
 adf61e73a8af0-1f5c13164bdmr19025084637.38.1742230661091; 
 Mon, 17 Mar 2025 09:57:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea7c718sm7461750a12.62.2025.03.17.09.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:57:40 -0700 (PDT)
Message-ID: <b3b6cd5e-8cf1-4230-9e1a-223dc8d82aee@linaro.org>
Date: Mon, 17 Mar 2025 09:57:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] gdbstub: Improve physical memory access handling
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250317051605.1108128-1-npiggin@gmail.com>
 <20250317051605.1108128-2-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250317051605.1108128-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/16/25 22:16, Nicholas Piggin wrote:
> Bring gdb's physical memory access handling up to speed with the CPU
> memory access, by setting MemTxAttribute.debug=1, and by checking for
> memory transaction errors.
> 
> GDB with PhyMemMode will now report failure for memory access outside
> valid system memory addresses, and it is also able to write to ROMs as
> it can with virtual memory access.
> 
> Reviewed-by: David Hildenbrand<david@redhat.com>
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
>   gdbstub/system.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


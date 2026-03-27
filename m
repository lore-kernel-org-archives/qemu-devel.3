Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC6E10AB814
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5wXK-0006DC-9K; Thu, 26 Mar 2026 22:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5wXJ-0006Cv-B2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:02:57 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5wXH-0002bY-Qg
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:02:57 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-35a04d6aeb0so1455207a91.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 19:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774576974; x=1775181774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ClhfEaStCTwzio18pt5wPbm6Dn4bMGPUXXpV8KUplhg=;
 b=YhpEzgJcmO93uAmjVxQzjC6doO19+5S/QUDbpUP20SwxSkykdYXtShJr6wQVdYSPA7
 VGGudgE1UQgaLcNXJfFhjMQc/79U7mresCGXo98tnKcggL4kwWjBt9YcHT6LTYi4pZre
 L2aodjKVRcyTsfV/4r9Xgbp8d/e1vKqhiw1G4zIv8dnMEzxNL3xGzkS713fizk25fHwP
 60C3IyDDew9Zae/ufsc4881+hWsUbIRf3b7AkI/HMSsJu2DBPR3JZgprHTYWaBaqBe6m
 S5WZYMgJ+ebHN66SJGA+csaPLOLeyv5Vimz89p0lUQAi5tWKfUogsmN/lYb0IOuIkfGc
 WT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774576974; x=1775181774;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ClhfEaStCTwzio18pt5wPbm6Dn4bMGPUXXpV8KUplhg=;
 b=L/lEVjj6b/qunwiS6unU8dqnp6fxwNC0oA2SqVntTiqqtfM1WJh86Nu+xwVBR9Dduj
 t/wQPyWpRFojdSbhjpPnGZlvsaSQn4HfNONB64+wH3GxeVY0w22r4rBpm6gBSsfQjrLV
 Iicksc9AT3QYz4Km8ZE4cV8Ee5vcbRRNNocfnP8QW5UON2nTEEyDipECjnm/wAJQeLhK
 3jIPzq86xxGqJtrThSOUun29BZ6RPfiyJw6H8b81vBLUNj8YJkkj9J4eFbFd1UbpJzXM
 aJfq/3GVxdsxqoxLKQU3QLphaHx7uZpjU5ieBCA5FTNM62WjYWI1LZcLnKi6ydv2N4vL
 sc5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVftxl5zQYsiJQmv8vrbSCs9M6t4C+hrRQOazHsvQeZrcO/keEbH5SHjcQDxjmCD6dgM+/juExmRGyF@nongnu.org
X-Gm-Message-State: AOJu0YzVEpdomr0uZ4TKhOBtfqZnKYRqKV9xZTb9fZPWkFVoanFdxxfO
 QyYXHq+rVD6wsUOPB0+a250Q9mJTBM6qFuvzCMd4OHByyj4zLIr32z1OJROiK/IMq54=
X-Gm-Gg: ATEYQzyKsIUAOB5vq3P04ep+JdPcvX3Qb9IKQ+ePHJC5ebXbopQN4lRApGnfaOD/7mh
 Pu/O7SbHEnH91Qmff7/mdTMOa1L/aMCPO26HopXjIp94O8Mmkir6b4i8NsBKdIZh0KL3A96qQaO
 KI153+vKjbSjir3VCFGaUH4h6gy6FOkbIRy9GA1nlhBFLKwbu3yJkJVV4gzJFkD9YYjEnKnmnEr
 Gu/bxmtvdZ2YBVytoti2eOd/1rckrjdZncApyerBDYmLb6yMhHEuBxbPnggbQgxQqTNcKEACZ7B
 bBF6Vax4N/bKBountCZ7MWnFRnjj+rRogCTsS8gcXq+z1JWmzjlIOf1uXGHGfOm59hjX9IeEyrz
 GFASDzFfOrbUgw5mP9ejgD+7JhmlaFOthuOqYJqfGDuH547HbEdiuvpS7bjJBU/b7UT9S6DUAu/
 pJvODdhI/UNpXU04O8AldLBEhz6wxJHw/44E9Gzu61vg==
X-Received: by 2002:a17:90b:3dc6:b0:35b:99f8:964e with SMTP id
 98e67ed59e1d1-35c2ffffddemr803015a91.13.1774576973857; 
 Thu, 26 Mar 2026 19:02:53 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22cebf63sm2917230a91.15.2026.03.26.19.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 19:02:53 -0700 (PDT)
Message-ID: <56341ce6-8ffb-481c-ac77-2ba2eea44922@linaro.org>
Date: Fri, 27 Mar 2026 12:02:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Replace aarch64 TCG instruction formats with more
 meaningful names
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260319-aarch64-tcg-instruction-format-rename-v1-0-8a13bf98f8ff@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260319-aarch64-tcg-instruction-format-rename-v1-0-8a13bf98f8ff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/19/26 22:12, Jim MacArthur wrote:
> tcg/aarch64/tcg-target.c.inc contains a lot of numbered instruction formats
> called "I3XXX" in the enum AArch64Insn, named for the original section in the
> Arm documentation which described those formats.
> 
> This patch aims to give them more meaningful names, for example, I3314 becomes
> Ildstpair. Where possible, these names match those used in
> target/arm/tcg/a64.decode.
> 
> For convenience, here is a list of the replacements.
> 
> * Automatic changes, made by passing the values in the enum to a modified
>    version of the code produced by scripts/decodetree.py:
...
> 3402 => bitfield_32
> 3404 => logic_imm_32
> 3405 => movw_32

The _32 here is incorrect.

In a64.decode, there are different patterns for 32- and 64-bit result, but here we use the 
same pattern for both.


r~


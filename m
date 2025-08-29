Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0138CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNgM-00009B-S4; Sat, 30 Aug 2025 11:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6X8-0000Oi-0A
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:21:18 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6X6-0003qf-9K
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:21:17 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-772301f8ae2so933019b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756502474; x=1757107274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yb4Y2tQ0VlRDKRHRGy8HmnWrB6L4HDppjYoRYBU1HSQ=;
 b=v1j7CrqmD5WuJ4o0psCYiJy45LAo55PGkfYdkhYRc466woN+Q6CkyxMCHj5dsE2w7F
 SrGk7IHm6ToY7lpY6rD/1gxXaYWQnaWganvK+wWItQtAhggB2n/imxM0PuGBeXTh8BoR
 Ycd50oNEqmqP2VojIjMCOzn1bTENkmni/X4VTi4SmDATWoNQs2gpcLuFKDGB+iN1h1jU
 SfyIXt+ptFeqkjQIrb1hsyhLeq70/63idweMmlMfaT/AL3H0Fnn2QDFT4Ph1RapwIti0
 X4wC0G/RVNrLU3npp7XYiTlSiW3BGmJ6CIJzhShFlmJObN33EXuK+bmFf8iDKTwa2mg7
 YBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756502474; x=1757107274;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yb4Y2tQ0VlRDKRHRGy8HmnWrB6L4HDppjYoRYBU1HSQ=;
 b=XNdK4JXB7Qm1od8cybtv7LJvspjeD3ZP9VvzC+zV+1Pe3ESetakyWCQVwf0Ftc+bFg
 KwtLjXDlyDIQ4sq1Ld9bb/w3FoDow989J+E1QaCIlvtHKh9kldb7COwWfXTnHWdcXh+f
 R8Qis9kNOvvZ1wDBCWJw0NSV23MBYcEKwnGn5jinxYJO9TmCs3yZ6Ndgvd6UPmKDw+LP
 C5SmCrtuNAeL1EOElJww0ojzgzR8JZrrwQv6ANkNRenjb75hNNuog7VfLA6ZEOcwia9B
 3zR8kPYMWRqq1mMCsFLeUzKxXxq9Fi7H5HuPiOyS3nrlTn02y+Xy9V/4mJwbst6N0G/W
 k6Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3l8ecjGQwSYHrcJIyshOBH8Bk/BAkseAmxAuskfvmGjOzhtEs3uhlERMV+lTbzKhKdBKuvcueK/ra@nongnu.org
X-Gm-Message-State: AOJu0Yw5XFvFMvK9mXi9D296hkuMg/HmxP4IcgsTr7R8+kzfBFTjrihR
 McCBbDR+RnsUjnENoZQnjrzG5fvHS+oYSDfONg0Hb3YT1CcZ2XAvz7MBCRG3kvBwkV4=
X-Gm-Gg: ASbGncs7vZ2B8KZCuyVQxQZr5uy6CqKFBk2tLHkt70V7DAei9Hm6Ms1JJlsRxNuxumi
 qM263xUazODycXV76+l1zFOpWvQLtCKWc7lsJX5Dp0J2MirJ/McZUGIr8dUvt/TE3Hj7bDqPAN/
 mekTYWzyqliklYp1XK68isuTULT9Sy2RycD0NOLHOMn96qkKftLOR1kL0lPKEX3nqP3Yfga029g
 Ber3pSMubPHWPS/dd5vojSq7WxlVJH+zmAHFOVWuajI6w7hrDeaz8JXFC8lI36qCHU2LhP+84xn
 4KVUO5yZW5w9/SYsrJ+ZzULaTjzyNUpRHukgp+M3T3z0N+ME+N7d0FMsQbBZhbjq9/WC7xYR/5g
 Wxl+LzyeZp+8tiJEwbtDJPzJLU5TDUNyyoRcVX2CN+mFR19JOT8XwVWCPrF+xxLvU6hiiEg==
X-Google-Smtp-Source: AGHT+IFMgflbIMIe7ACtlL8c+95ogtft0gMyVVLYHQZEy3FP4zKPreOu/TtKvPQn7EzDBN1b6nidqQ==
X-Received: by 2002:a05:6a00:b96:b0:770:4d54:6234 with SMTP id
 d2e1a72fcca58-7723e1f4471mr103529b3a.3.1756502473888; 
 Fri, 29 Aug 2025 14:21:13 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-64.dyn.ip.vocus.au.
 [122.150.204.64]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4e3fa1sm3187467b3a.83.2025.08.29.14.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:21:13 -0700 (PDT)
Message-ID: <f95cf1c1-9f86-451c-8592-43b38f43148f@linaro.org>
Date: Sat, 30 Aug 2025 07:21:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/functional: handle URLError when fetching
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20250829142616.2633254-1-berrange@redhat.com>
 <20250829142616.2633254-4-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829142616.2633254-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 8/30/25 00:26, Daniel P. Berrangé wrote:
> We treat most HTTP errors as non-fatal when fetching assets,
> but forgot to handle network level errors. This adds catching
> of URLError so that we retry on failure, and will ultimately
> trigger graceful skipping in the pre-cache task.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


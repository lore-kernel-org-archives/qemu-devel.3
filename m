Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BE2CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PnG-0004vE-JV; Thu, 02 Oct 2025 16:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pn7-0004nW-DF
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:20:43 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pn1-0006no-7t
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:20:40 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b5579235200so1023187a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436428; x=1760041228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MpjspSYPzioRlWgcfd26xIzDBFpUmR3W4Ccc27FsjhA=;
 b=IlCf2JdprkcX2uHvMSHSuPfZoTotGpktmJtGtFbsl/jydzHs6C/LBXcpYV4hnKIsnw
 UAjHT8YbJaAExJTGkLNAbQ3ewwSfM5pYluNJ5vF19GV+YqJZN6utN6tEkOJ97hslvpAl
 6sDCnBGHNWRSBVQH6FraT3PR4dLVEao+F57+o0LhrcNkzamr2yXvIscR1lZWpYJSNVKg
 SRljTT8kY+FT4yegtFKthAK5Cs9AYQEg+iX8w1IGu4UhEtatiQ+y+znCgWwRnz3lyaq+
 NfzYQZiSlOXzgx/oOY7BqUw2LdErw+mJuUT0vFMHXzczwvjuWlMwBJJJdVVljDWGFA6W
 ZHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436428; x=1760041228;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MpjspSYPzioRlWgcfd26xIzDBFpUmR3W4Ccc27FsjhA=;
 b=Ne4ixZhiCUXSV3XF55wlb65wBjlKReYq2ToeILU+RyLCPM/W4+kxAkB9eywfF8Px5D
 NSlk3dI5h1BCnzZxW23hphmuZhCObLHx7GIgKPlxC4zdu1yv71ms3KL591X3mXu1GgIM
 OTXg3JEa0rQtllUPS6MfZJTARS5ujyBwVia8ue/4dywP4tMRNViiYv33YdZlUmUbXPnp
 OqMyl/IifAPnE+Kcrk1tfGkj8z9GZGVNthQp4UYf4o3nVRu6g5AnfTTir9JFjY+SVfzM
 es9huh+Ram1EYtl8J3ye/W8mv1xyej2EGMkJ74OvXCp8JEaz/JyLtrxk1NtmBo+mN0lo
 e7gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL6akPyzBFcXIKZ74xGYa3nOUvTHZdBpjxVUkWq+hbnhNo04lKGLSgFzS0aSSRID/zjV2zedCvf968@nongnu.org
X-Gm-Message-State: AOJu0YxLHKVEqH5jKhNi2Tp3Wxi9RXw4llx0kqLI8C/y2cP6amZLnW4u
 CmVRazHVZFiicZbfNXFiiIWpKlmxZIMnqJ1+pKn7I1LDQqtAsfe9/kwjb76s5cprZkQ=
X-Gm-Gg: ASbGncsVE2Jg156ZElrkrVCruOSIAWzl5jKdnrXqNTP+qiVCacbRvsRUlL2JVn9b4FI
 pXwpXsFF2ojDw1YJXEjS2Vo6zMRIpTEF7AoaRtzTgXyJKfFkKK2wigo2Yfvc+EW6W+cqkdmzMQY
 NGIOM2eElkDjseu2lPj6wNq3Dzg7Lb49ScEWHjjcfEfETPKKv9KIrdF5BzNKdphk6BK/i2cukda
 QyzRZmYNjZKQSS4Hp3eOdqDjMIGf/SvCnh6AL7ZzinH1BhEYJuV+7aJ3ujWrdyBbx/0G7AMJqMh
 yXLZiP4bSH/J5YYUCIZ35TRULkdRZ+hbmDFeHymSDsDpKBmBOKRT8P9oj9MvcYpPSEydHZPlHVc
 5Pa6SyVBTMckRe15qaTINQG/H419m/Wgke7zFxYv7G77d9RZApLD7yer+3EPtuXE=
X-Google-Smtp-Source: AGHT+IFfj9Ymw0sTe06SrzzF8t4zjdoUMTPXhaNqX7cTxI6GehDTtvOu3uFWRfMbScQg26cUVHPycQ==
X-Received: by 2002:a17:903:2ece:b0:27e:ec72:f6d with SMTP id
 d9443c01a7336-28e9a5133c6mr6264085ad.11.1759436428436; 
 Thu, 02 Oct 2025 13:20:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b922csm28713265ad.66.2025.10.02.13.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:20:28 -0700 (PDT)
Message-ID: <9234a5a1-d945-4f0f-b2fa-e77e9d6bc124@linaro.org>
Date: Thu, 2 Oct 2025 13:20:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/33] target/riscv: Fix size of mseccfg
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-30-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-30-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 10/1/25 12:33 AM, Anton Johansson wrote:
> mseccfg is defined in version 20250508 of the privileged specification
> to be 64 bits in size.  Update relevant function arguments.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 2 +-
>   target/riscv/pmp.h | 4 ++--
>   target/riscv/pmp.c | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



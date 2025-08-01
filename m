Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53C0C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhisa-0000NH-7M; Fri, 01 Aug 2025 02:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhisS-0000GZ-Uw
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:04:25 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhisQ-0004XY-Um
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:04:24 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4fc10abc179so306008137.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754028260; x=1754633060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uwPHnK9kmcEFBe8yOrl3dcV7vgNIhM7UpxHqndW0cps=;
 b=LTnZCCoyMBudyGf/mnkwwoqu6l5W06jywLtFuEOel4jMoNs/YHw6A68N4mGWsJ3Xy6
 fhRMf52XW2yDBeHZLI0pucWpoh2xxkWOVStuiv2TTYL655prbozfraXh+SLdO5fw57oI
 PvBsxieO+nzSuAUYTp2ROxkC6997auYPGYI2/RRfauVfnwKQgkIrJzbj9JK2HtCYCrOB
 KFTHVS3EaJlbTQVYK8D1Tsit7hBTXPR7j4iCe7PvbfXwmK4t5fcdFwmra37ZgJ4qHbF7
 Nv27jfEvxbikGRW9aXe5GM8G3YkBnBawn87ig7R4GtqXM2om/I9R/jt4RM6b0OA1Wbsc
 0iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754028260; x=1754633060;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwPHnK9kmcEFBe8yOrl3dcV7vgNIhM7UpxHqndW0cps=;
 b=IWubEVtHPiHzMK6SPAAIklP+65oxO0gQzcRAP183sLpws3ZdBloF5kqJNO/nELu+9y
 bOoTCdT9PjKdgbsl20GK0kHKWCqOhMTOL58Bmu/E404hhXXHXoM3NIkziZjaY8Xz6uiZ
 goAnBLX2NripTXKmaheLyjT0hFEq/cTIc6fCZjymszBxYtHWSn5h8UqZEQBXLkZQwrsu
 7Vah6XyZtrqYRZFE2QADOj5EnmDl7ecMSzuacUesmFIJTPbW3IsPGXlVL624K87L86/i
 tmI6xQwwV/6Ue2FqjXo+A+y8ABTl9SzMYpedsYoqBmOC/o3zBqPgQjOUvJ0QYZCVjOaB
 S2fA==
X-Gm-Message-State: AOJu0YzNTXWyOR2M0aZfM1MkY+aeoBEgOHUvvR5J89KSsJ1rye5NlHZ0
 yaGlj1Z7e1/exKZgC5OmizffEO54KcBQBEk6qna1yZn4Tf+kI/jFi4Jp+XDfW/FfBlQjF5yUKb6
 xCLOryaM=
X-Gm-Gg: ASbGncvQAaIBU3JzMfkuPJecz/f46YMwOPuby3PU+fcH98swc/OKE1KPiCAOpFygvTN
 YTUrcicFDigTZ0FFWD9ftku5VunU4ZPp38KmFRqdVlPqZwiFKv0gROmJcidLLLJ6NE0oefTsTRB
 /hHvH/DMX9TB6MtP3CXE9ULVYhQmgx12/W9HdCAg6/FG1pVt4uqIkAdUuG+d9rjiKx5tsWB3KBq
 7m2vvR+f9d6X54KJLK2quMvUx+Fk67rslHf9m3a3zua77bgVf3Ywgbcx0UlxDLaauO+z8qP6p7g
 a0zWJZ9O5vvKGgn5kj3v5bmq/RnMgtileEDkK9Z/mAWGijr9wrBB+6dqZ2gmz2Vw4YE9mSe9Q4U
 5vmQ2jtCKFBytkJBRWbTL3ond2ZvNJl3wkYuXFwYT
X-Google-Smtp-Source: AGHT+IGi1QKhTXh1F4XfHXe0+WCaOCdh2VlcdWdTsnHJ+wAdT2gaa6ThCmjFpYFWjhLdCbJd2AA/rA==
X-Received: by 2002:a17:902:dacf:b0:240:5523:6658 with SMTP id
 d9443c01a7336-24096b687bemr166595055ad.29.1754028241824; 
 Thu, 31 Jul 2025 23:04:01 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89a3ae8sm33452645ad.144.2025.07.31.23.03.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 23:04:00 -0700 (PDT)
Message-ID: <f97a606a-6f63-4266-9b66-be60d9243099@linaro.org>
Date: Fri, 1 Aug 2025 16:03:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/9] whpx: add arm64 support
To: qemu-devel@nongnu.org
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <20250731052753.93255-8-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250731052753.93255-8-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/31/25 15:27, Mohamed Mediouni wrote:
> @@ -885,7 +886,7 @@ if get_option('kvm').allowed() and host_os == 'linux'
>     accelerators += 'CONFIG_KVM'
>   endif
>   if get_option('whpx').allowed() and host_os == 'windows'
> -  if get_option('whpx').enabled() and host_machine.cpu() != 'x86_64'
> +  if get_option('whpx').enabled() and host_machine.cpu() in ['x86_64', 'aarch64']
>       error('WHPX requires 64-bit host')

This is wrong, since the sense of "in" is incorrect.

But I think this really should be

   if cpu == 'i386'
     if get_option('whpx').enabled()
       error('WHPX requires 64-bit host')
     endif
     # Leave CONFIG_WHPX disabled
   else
     if cc.has_header('winhvplatform.h', required: get_option('whpx')) and \
        cc.has_header('winhvemulation.h', required: get_option('whpx'))
       accelerators += 'CONFIG_WHPX'
     endif
   endif

because that's the only way that the error message makes sense.

General reject of --enable-whpx on unsupported host will be handled later with

> if 'CONFIG_WHPX' not in accelerators and get_option('whpx').enabled()
>   error('WHPX not available on this platform')
> endif



r~


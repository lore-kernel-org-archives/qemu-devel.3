Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A3FC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmGj-0001IT-8v; Wed, 19 Aug 2026 15:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGi-0001Hx-J4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:12 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGh-0000GA-30
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:12 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1269932a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787168890; x=1787773690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7u6KdBONygM0pE/S6130Wy2Mimxk8U+ECl85NgOENK8=;
 b=RCR3MQE7mFAZJwL+gpDH0TirIi9fHP6riCAuJ7wIJ+FQyP11LkXN/4ACGJmvoLXBoc
 q87klh85N3IYVPNnAoMakb/RvM8yvXiZA9WQt9dnv7lKMl2wsC4FHdBzE72DXBlJszj7
 7UAM6fhTjyxVlDlBR6SaNifR8rVdMPDu6cLQzH2moQ/r2LdAv8n8C3Z5JMMmYoBrdtB3
 I3Q6AHQU9h9zAwy1qi98Cy/3YlQDQTamlxQY2WS9uI5Z7mduTpRQnfuOmX6HgO69xdtv
 iQ0jukVEiO79XQE8GynIN1dqjUxyruyAe9ih/kbG1IB7j+ylHV2t/UojNahYkGcJAnuO
 asWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787168890; x=1787773690;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7u6KdBONygM0pE/S6130Wy2Mimxk8U+ECl85NgOENK8=;
 b=YBUvsMQ1SIxUcdUEE3qWxFik5vdj3vFdZY/eTp6MkLuJMOEk/mgD19t88PnzjlogoB
 h1bMisagRNw3Lb6Zog9uSHSOHMF+tPfsK6Wqyhpu8fqpKZ1PCTYlfHyFJMq5ndC0n0e2
 7sCZOujb0TzxKpwTwP12NI6JctSr89izuig7n3t7VJm90CMF6i/g+o56ohniMW2Ghvlx
 Kff70EDlYe+Ji1UxreGK+AixIoiYHJt5Gnm0ikbDdYQav9KjSIPdGzOYQanoBmcnK9Dn
 h55dDsbVKV1OA3bMBgxsvIrflgk0VG86KiPRP7qQ4cdd5Hz54KkII5IVS8sBOYnasaCV
 TChQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RotDM9UAjVXPnjcbHUqzMYy+XmgVGAdfWD8UoN7QypGo7OJxnGcfNHKVLpyhoydfI2MuZQssfzIJdvC@nongnu.org
X-Gm-Message-State: AFuF++nr3M92SBNb+s3yjKW9rW81hWzSiBb3IgbV+PQe7eYKkvCISNaJ
 aEYiQgv/896QHWbJnMRpt6q0YAP/qPz6RGYMnrBS05ZAz9ENoOMCyLqUNu2WaEnNVOE=
X-Gm-Gg: AR+sD10tqnrlNDPct7L9FvyrcmXlF9TM4ZqVXZPCCGsd177thmAodiGY94uuAF8jd4E
 RY9NG5uvu1unBSHTWaozvMgxyMwEKeB67KJ21e2rNlsBCoJT9ZPh+DYZjoixT9wzmajP+OqdGuC
 Row0u3Gd0PaRJlupeyvHMkNVqnMpeiaC1q5WYpGfiQb58qnniFROPOf0HhzT3sRnsoRM7kbsx4S
 bv2xWXbdmdmHZukNjBZJPgeZ+BdQWpjwKB80NcMBO6rmlwLGNQZyL1HdgnqX5SIWOEh39J2vI/Y
 eEXeOyIyWGqdS6PQAjcJAgMDopSFVPeYQcFE0IzQnoUi6ZmdLLBJh6mMAW4dZh/spTrEH0Gihsp
 51o1qMAZFNw72pfNm62r2bqqhqV/8YgUjXdt/U0qlqYRKDUeI+6OGAQH4j2qTHNWnxYR/oswOsk
 I38P+CL9bn6uJo/S6fxySbZO0qZqlFIpN6fbSXUFB2YccJvIxIk4y6V8QKd5LJs9DIfNCKL8vxi
 MPPd/vHnuSJFy6un6Y=
X-Received: by 2002:a17:90b:5748:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-39580aa259cmr13146545a91.7.1787168889702; 
 Wed, 19 Aug 2026 12:48:09 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb51271sm4055310a91.7.2026.08.19.12.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:48:09 -0700 (PDT)
Message-ID: <7090ddf7-4272-48b4-8c49-ba6a2b53412c@linaro.org>
Date: Wed, 19 Aug 2026 12:46:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] machine: Remove 32bit limitation on ram size
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-10-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818172012.3052821-10-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/18/26 10:20, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system/user emulations.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/machine.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index e617f7804d..776df84191 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1625,14 +1625,6 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>          clock values from the log. */
>       replay_checkpoint(CHECKPOINT_INIT);
>   
> -    if (!xen_enabled()) {
> -        /* On 32-bit hosts, QEMU is limited by virtual address space */
> -        if (machine->ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
> -            error_setg(errp, "at most 2047 MB RAM can be simulated");
> -            return;
> -        }
> -    }
> -
>       if (machine->memdev) {
>           ram_addr_t backend_size = object_property_get_uint(OBJECT(machine->memdev),
>                                                              "size",  &error_abort);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A92C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9TYM-0005aw-NB; Wed, 23 Sep 2026 16:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TYK-0005af-8f
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:26:52 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9TYI-0004M1-Gm
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:26:51 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747f05ffcso7541925ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195209; x=1790800009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tCgSRMxPtrL9Efg0MA69wITdbo89EcOJ1sxvafvsnt4=;
 b=vttu9Xu79+snQGOm3d6fbufiTCC74o1CVgePCOMtMo/Gw1G+My0hmZT15148i7/Ocv
 sNlWHDDRhbVj5pyD2BLTXNPit0Vg0WHtdSpIO+rPzEJtSpE3tn9Tp2XgQsGh45e6Hmxv
 lNwF8MdG7bTfvoOLQ0GA7YazfuHAoYoJ3BGSV000ued9T6T/j00RJaEutJSVmX8nNarC
 esazirzkiYEGEcdeNDvMTc6V5lW+JGIPiTSxVFr9rrKscThS53kom9Rm+qk7ojxxKL7w
 BaRFCGcr1NmIxxaTDrAitFoJPprjpMtMN/T95NfwFjNooe/o+frtg5p1g1yZ15X4DFx8
 kkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195209; x=1790800009;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tCgSRMxPtrL9Efg0MA69wITdbo89EcOJ1sxvafvsnt4=;
 b=xSwXGn4Zs7XHHZkaG1j38YOFxbCsecYvT0OBjouZfJ0cDUJhdcLbKgEBuQn2D9XYp8
 bbTLaZH3R9FV5qc/5bNNsT39p3YZM57K8y7jxp2ZJ8ujl5tmi7L+UQfgIbG/ELG/M+LO
 JUPu0TOJxBd5I79a/737mQ+7jLdCYBp0eGpbd8sq2VhOwgJNaRZbPndXC5eUuv92iiYO
 Y8ypNANfUlMm2sLjoGZlrIo8uFxrKYW8YNafpZcNhlA9ppxYup8KDNwrC58lEeoYePU7
 PqQctA3p+J9JGOpWJbsYKFoxyLbtyln3gX4SqSmhAW4JzvfwvLJfNl3mzhhABEAhncq2
 uoLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpwsjKSzTCDtWjb368stnGPvkqAlEO/HbWVBcRoOg8IrhggbbT0kID+ER4SkJ3elE0gWXQwq4OM38Z@nongnu.org
X-Gm-Message-State: AFuF++nFsjV4UxAVY+iK7Zp9cETn1UpwXgaB4wwObqSQZib/gOPtIFp6
 4AG4rX7HfqQd4dM69z+lji61AZeGtNkQnKL5ujodpjWIqJZM51P92y1ChqnbSWZ5S/s=
X-Gm-Gg: AYBFou38zMZl0YUPNG6+BnrphjILOC+xM/7gWu5u24UipLqFjchtq1ajoFCi3FS1USz
 ypkhtoUhB/BUcHBXPGYB6l1c3ETMyp7O6Fm6Mj7r4B3l/KKPonep7QQGEuozW2JL5AYtjnJR+kk
 EkFUfeMq9tZq2uiZ4oVTgPisaaii/3o4qhzQJ5i0vS4/EgPzMtYbPtQyTwE7YJxsJG9s2few9K9
 rj4XtXHqc5+dv/bEfKkiNObCP+DGVqn4AMw/t6QO4Y/kz/cE+yIUPviN5fhmho4GB+7nghtFf5G
 lN+AEJkHm3ELSvMnpfHpXtZNWGfMdCavt566Hh2f1Ut2qXb8ABp8JBplOtgnxCaVcqEQQPRGVaD
 Et87yWoJCYeC3aH9tjo50NUGZnverIFonoGlJsuFnbB+EF1GZlJqXLH9XH39aNR2qbZSQY6Sj+R
 rJvp44zSL9X74Cz5SUQKxrF5vSWrNRGnuqUtYWsp+idlNdSMTM6xH6vQuN0sSamK0AlXvp3+kki
 RoFZM3k8u6SDZpka+iQFZhxK6ufiIGiOtjPI3lvYCWhceO5wFe3
X-Received: by 2002:a17:903:1843:b0:2d8:d4ce:9f32 with SMTP id
 d9443c01a7336-2df7e287b85mr1791975ad.16.1790195208864; 
 Wed, 23 Sep 2026 13:26:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5c3733sm16220105ad.41.2026.09.23.13.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 13:26:48 -0700 (PDT)
Message-ID: <f91d5aa8-6ee1-40f9-98f2-eddee7e6ae8c@linaro.org>
Date: Wed, 23 Sep 2026 13:26:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] linux-user/sh4: fix race in atomic variables
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
 <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
 <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
 <a435c784-849c-4a0b-95bb-182068d4abfa@linaro.org>
 <f5f389df-3865-b0de-4b91-da40a5a05256@redhat.com>
 <c621f948-add2-4e9a-9871-344906c7b662@linaro.org>
 <d1a29727-14c6-fe95-c01a-30fd63e3ec4e@redhat.com>
 <991e9427-bc5a-7226-453b-70de8825e4b4@redhat.com>
 <4799ff0f-a198-36a3-0ec5-fa41cc7337f2@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <4799ff0f-a198-36a3-0ec5-fa41cc7337f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/23/26 12:58, Mikulas Patocka wrote:
> So, after putting debugging prints into the code, I think I have found
> out what happens there:
> 
> * decode_gusa calls gen_restart_exclusive
> * gen_restart_exclusive generates code that sets TB_FLAG_GUSA_EXCLUSIVE
>    and generates a call to helper_exclusive
> 
> * when the code is executed, TB_FLAG_GUSA_EXCLUSIVE is set
> * helper_exclusive calls cpu_loop_exit_atomic, this makes cpu_exec exit
>    with EXCP_ATOMIC
> * we go to cpu_loop, we execute cpu_exec_step_atomic
> * suppose that exit request is set, cpu_exec_step_atomic does nothing, it
>    leaves the CPU in the same state as it was before
> * we go back to cpu_loop
> * suppose that no signal is delivered, so the gUSA is not rewound
> * cpu_loop goes to cpu_exec
> * there is one difference - now, TB_FLAG_GUSA_EXCLUSIVE is set and it was
>    clear before - so cpu_exec will not use the TB that calls
>    helper_exclusive, it will instead use the TB that performs the atomic
>    operation (both of these TBs have the same PC, they only differ in
>    flags)
> * the TB that performs the atomic operation is executed inside cpu_exec
>    => race condition
> 
> So, I fixed this by clearing TB_FLAG_GUSA_EXCLUSIVE after
> cpu_exec_step_atomic - to make sure that cpu_exec will find the TB that
> calls helper_exclusive and not the TB that performs the atomic operation.
> 
> I tested it and the deadlock is gone. Does this seem reasonable? Or, do
> you think that we should fix it somewhere else?

Thanks for the excellent analysis.

While I believe your fix is correct, I think the problem might be more 
general.  I think that the condition "running under atomic step" should 
be promoted to a general cflag.  I also think that the exit check could 
be suppressed for the single-step.  That way we go round the loop fewer 
times.

I'll prepare a patch.


r~


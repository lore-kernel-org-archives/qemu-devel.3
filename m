Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB49EC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk5O-0003pl-Fc; Wed, 24 Jul 2024 18:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWk5M-0003mv-Gk
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:03:48 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWk5G-0005fG-Sc
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:03:48 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d24ee79fbso203043b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721858618; x=1722463418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+rxkgRF/7bYyOTrvXLv4s30QgenTBrzKccBAAYsub78=;
 b=l+AIkGDlw2PDc0Myl6A9Wa+B/AEe/MB1Z8C0Ywyz4eMEG9opjwMMeJcbK6rLYkB9Jb
 TUJsp9IOTZVXL3+pz3h3ekU8QcLYHopY/ekL6NdC/W2rKATuHXPRnTRI0+0yozO7Xp+C
 R5wLvD6GhJhC5enPrW0jCsmCTo6nsqCgdMhHr0u8B5wPVAtPeEt02+EJAslYLzDkCiA2
 FkERepqJqNyJII5FW+8t8RvmvkBzOPkGKU94RNC0RL8G9pWXPWMuqZ8IXMLxY/InMref
 u3+k3NTDe9kqqc/oiry3yNdLj3kdpt6MKDbwkzALSXL2Gp4/DukjOgBXPbKvVHdoooi2
 9e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858618; x=1722463418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rxkgRF/7bYyOTrvXLv4s30QgenTBrzKccBAAYsub78=;
 b=RvZaAqVwp/JRdGWgk0D1yrTHDTRlMZNhxlptLzOm1J2B2XpLRjqf96rG2Q+O55W4/1
 jMirVy/Pg8i42CnTFFRND/LlVeZDoyubhCWuOriZrK00nnQx56lmDsHi8AJNjlmRHre4
 rxhT+yG6hD3BC8mBtdn4Gv5z5rnjBvRW4VKZURq20TXqd6k8DyMu9XTRZM4/RuUhA42q
 L/rXkskGEeH5G3y19e2ynwt+bjb8/iK4piKLofke8SzFZ7841WxJhNTPpv19oKw2v6iX
 Zl8f0yUh/Nfk6wjhRnbDx3pdobFtJM6ha00EluFLU2uTWQnJHURwWyiHaNMrjkszHefX
 p9jQ==
X-Gm-Message-State: AOJu0YykmQqEES9iIvZ58yHaRMXK617iRpCtjA+q/szeSHpo6j+0M4Pe
 mZkUyscg0wkm4hwPSnFzdqhC5DvsS18LYT1HvfaGMfBHKvDCaAytULj8RQidy64=
X-Google-Smtp-Source: AGHT+IEy7N2IvzaE8bWOfcpG+HgxYDpPezY7zyDmjj7O07FZf0DgV4mi7h0GR+YiCGLVm3OU03SKyg==
X-Received: by 2002:a05:6a00:987:b0:70e:98e3:1c17 with SMTP id
 d2e1a72fcca58-70eaa9496eemr1287400b3a.27.1721858617990; 
 Wed, 24 Jul 2024 15:03:37 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead89e53fsm40353b3a.187.2024.07.24.15.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 15:03:37 -0700 (PDT)
Message-ID: <904cad87-1e7e-467d-9401-009bf92ce788@linaro.org>
Date: Thu, 25 Jul 2024 08:03:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Use -fno-sanitize=function in the clang-user
 job
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org
References: <20240723232543.18093-1-richard.henderson@linaro.org>
 <ZqDc-i9ej90GoavQ@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZqDc-i9ej90GoavQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/24/24 20:52, Daniel P. Berrangé wrote:
> On Wed, Jul 24, 2024 at 09:25:42AM +1000, Richard Henderson wrote:
>> With -fsanitize=undefined, which implies -fsanitize=function,
>> clang will add a "type signature" before functions.
>> It accesses funcptr-8 and funcptr-4 to do so.
>>
>> The generated TCG prologue is directly on a page boundary,
>> so these accesses segfault.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> Does anyone know why we're using --extra-cflags for the clang-user
>> and clang-system jobs, as opposed to --enable-sanitizers?  It
>> certainly seems like regular users who use the normal configure
>> flag are going to run into this as well.
>>
>> Anyway, this is why the clang-user job is failing at the momemnt.
>> I can only assume that changes to our docker file, or upstream
>> distro updates have pulled in a new compiler version, because this
>> wasn't failing in this way last week.
> 
> Logs show the clang version didn't change, but it is possible the
> libubsan.so package changed, but we can't see package versions.

But the code generation definitely did -- the segv is right at the indirect function call 
to the (generated) tcg prologue.  The library is not involved at all.


> I've sent a series that will make it easier to compare pacakge
> versions between new & historical jobs in future situations like
> this:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg05749.html

Nice.


r~


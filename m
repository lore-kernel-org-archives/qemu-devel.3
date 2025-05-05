Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F193C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0jI-000133-Q4; Mon, 05 May 2025 14:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0jC-0000xL-JW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:39:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0j8-0005in-Ko
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:39:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so4844237b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746470381; x=1747075181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wjp7WHX6S8/97RAjKa96LznAbJzgoQ0PQ76T4W+qSTM=;
 b=crLX0+X3n+L5BL8p0Yo6pb5xxVp5dJzXoajMzaNFq1oG3j9xeVsChMD5Kba2psFfoF
 PwlNs3/gmrAClhBS/E/xUY2VQ9PY2CUeou8BH3WXFrXK2QzxAG/Iq+W2W/ORCkwM5B36
 q83L3c2ksOqwy6k5w3khRqorbUnFRMyYuWcOS37ZrQjuIJY2kenNrAfZZiZMIt2VuScX
 5OyS/fWF3BbXJyEjmwMflQc5FGE68cA83Ylz/36TtqnjDtx6/qOAvKmi8A3liYCBhpIU
 gQOOehOR32/OCFpM/6F8cbO7mKuu/YF3cCztWip8mPLZB7p3LsZfAFBRvurFn4X/JW21
 rhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746470381; x=1747075181;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wjp7WHX6S8/97RAjKa96LznAbJzgoQ0PQ76T4W+qSTM=;
 b=bFTOmsLFe2JJV8uBZCgQGPf4FrUEKg143ImyyvIYq944Cpx0yRYg3DxG/zK/4AIfM/
 NX8BVW/Jod8ijlsLtyBUDLOSAC023GjON+oxgamkgt9tvEjED9q5nq1c8LTjF9FM/pjv
 kLwOS+nuUSnP/KUvGVUWo4mFJFohbW8zXOftnx2YPV+qm1pT+G/N9UJUfwv8S1a78cxn
 86I6AA140Vc9kzSh5xwMnDVoi6Ghoh39q69JVTYSSxDOaTQxO+mNCZKBPbcbULyaynDh
 Qcg0Nmp4y10SOQVH/CfJAJdjGdt+D1SncGhkWN+PRlOG0hfDskG5CRzncyjOmsJ4kt84
 mDLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4yf2XU6PDLGbIO9/Nhk1GsB71+4THwW2mUa0Rismm1xOB12CbZDsLd384o3B5IvnnxcH6nC57iQM1@nongnu.org
X-Gm-Message-State: AOJu0YzYUnxAAwDhXtCxUOxmSI/77np/HgPE5Dcaw6jNEiyjt2wvjLjG
 SZqwp9XRojcJM9dPFYWJBv3n3Ck2Zc95G5bSnmUhWn9zXFGusSh5XvODubMT5Ks5GBE153r+aRp
 ftPc=
X-Gm-Gg: ASbGncuTpm/WprN2LBpkBJMy2+2nTufNQAOuKsvTHanf1kP5ha/xuPYXKbYG5VdfOON
 x4fBmk+S1lN4d3tgbga65peGZZi50ht4HrkBcypkIRJJoKQBp3tlyoXmETbXs2YvbLOzqVIFe8v
 fcGgPtFU+M6f/k+EjfNoGEcQKqv1eiYn9rbDjJekTsCasUSP9DmhyIODS+ctkOib089CwBnwyDD
 5ctnGDVWMUbHcRwuxBf+lBDfx078RRqq1f7s3Q5bj2wi7lJUyWgFYqBDgfyc8vTlVtBQ7v+Dm7e
 lx0p2mLbXTdASiVLHNUwStUjVc5pO8of4THEzQi9zmeJP+DzLMNH8yWRaJRMSkdL
X-Google-Smtp-Source: AGHT+IHIyGDEwNeuR+yUkZvgvcAQgfoZ8WOvYMCeAlTVmL+ZY9t98NrBZlqA2uVThyjTLh1YetB/tQ==
X-Received: by 2002:a05:6a00:2a08:b0:737:6d4b:f5f8 with SMTP id
 d2e1a72fcca58-7406f179679mr10222756b3a.17.1746470381196; 
 Mon, 05 May 2025 11:39:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058df43c8sm7188761b3a.84.2025.05.05.11.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:39:40 -0700 (PDT)
Message-ID: <a365d727-8bdd-4b27-a763-08c5b3384040@linaro.org>
Date: Mon, 5 May 2025 11:39:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/48] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-2-pierrick.bouvier@linaro.org>
 <dc27e3f6-ceac-4e05-9652-28634d4fe73c@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <dc27e3f6-ceac-4e05-9652-28634d4fe73c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/5/25 3:44 AM, Philippe Mathieu-Daudé wrote:
> On 5/5/25 03:51, Pierrick Bouvier wrote:
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> CPUARMState::pc is of type uint64_t.
> 
> Richard made a comment on this description:
> https://lore.kernel.org/qemu-devel/655c920b-8204-456f-91a3-85129c5e3b06@linaro.org/
> 

Thanks!
Once your updated commit is upstream, I can rebase the series on top of it.

>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/internals.h   | 6 +++---
>>    target/arm/hyp_gdbstub.c | 6 +++---
>>    2 files changed, 6 insertions(+), 6 deletions(-)
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8356C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 15:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Fwk-0004BQ-IP; Fri, 11 Apr 2025 11:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3Fwi-0004Aq-Lo
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 11:05:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3Fwf-0006DV-Rr
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 11:05:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso2271604f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744383926; x=1744988726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G4qS/138Eq99cHa04juMXRtjbir/bDGsqcmktJCgU1k=;
 b=tOhtrRNaLrBYAnJ62ELsCdv8IEB4z3Bo0Ec+8spg7EeALCjZ2SdjdCvnkpmWUOCdmn
 k8X4ON30+KwMDa5ZWWT6+7AfdMHmZVT8Iy/azKC4fNiNZ/QmVyluHA+Lku72YwEacXQC
 8KRkYzoP56BMdWgWrsiZ1EyN0uG/vq9u+tyiIT14RDhcVEOmdFBDvNOWflSXIlhuzo4u
 5Buu3hKMCitssq1g0nnmE0z2ZSNJvHMo9XkhRdqAfXhi7XIYm5M83c0kDhgYojH9Y7Ip
 /yErid/spo7jvaWSABHvWZWisYSo+5lBcpDswzG7bvygepRwYiiENLiyUsqJHuMscP5e
 n8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383926; x=1744988726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G4qS/138Eq99cHa04juMXRtjbir/bDGsqcmktJCgU1k=;
 b=OxGFhwDONlWUTb7kWb98kwzOWL+K9SzrM+htuYDlNT71qyNmMA2KRCgmzU/q/LClcC
 Uoro6C4TDa1IxwGBohGmbgZmn/y1ywXkNniNGvtQl1VseIZyr3TO4cqoD69vkzeIXYF3
 irn8yPFDZtgepdCqfgYRC07d+3J2/u2wFYQMJvTkSIXpA/ViZ6qQo6gWmpDp/PRx/eGy
 TwLG8/7wAyQcOgqkfj5i/OWkH8zNQb2uGrBPEwwHk2ta8Ip40x0JjNshKoBZHjkgMsry
 gdXJAZgYng3f3HPzP7do6UMOkMAxuXghDsDjeMSDte2swyIvj8YaUQCRPbKQoqTYpzfK
 wLjQ==
X-Gm-Message-State: AOJu0YyxFDozvaq+6NQVB8EgKL1wLuUYU4E8a6vqGdosqap+VYkW007Z
 Ny7QRxSf+G1ZDSEjNjjBUhN5FaQ6Aq0G0kBSshMG/cCYpr3efNGuhlm3Ve8QJn4=
X-Gm-Gg: ASbGnctzELftT1EfLnCFj2nybf2M+rjxLvsNIdBxYUhFz6uECpxKgygeZSHyVUJmdZV
 dFPjXWN1lCxcyOnqv+dKwewxKhA3NZXabURCt1cMYEvTW+lt+iS+nPz+Jjj/dLxuUjknr8A8sn7
 HuAsF5vxN5rdc3dknMFb7UWr2lO8EgiHl/13G78WuuLlOQliPnLaMRBUE7Q5tqkBVlJ5ZipgYmR
 CQPo8x8F2kyMnN6FwIzuTbIcjgc7KeKqvojbiosaKEdYtELWDDj4DyU3oc6TqZpze3vvwaAgylL
 I15rp/IOzM5jOX61xNSU0gOwRLHQgY5EN2+8j36JQ1wM/193jPVT2enAOf0gs8zmEtovUJFaPRZ
 /AtoULqaPCPsPcg==
X-Google-Smtp-Source: AGHT+IEfzHtHCTgQ6AuKCeZk0rk2NnH3eeicH4OpQB+gTL8Ltxxefv5kc2PidxvggA4fvE5oAaTEVw==
X-Received: by 2002:a5d:648d:0:b0:391:65c:1b05 with SMTP id
 ffacd0b85a97d-39e6e48d03dmr2783761f8f.11.1744383921562; 
 Fri, 11 Apr 2025 08:05:21 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae963f62sm2213118f8f.5.2025.04.11.08.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 08:05:20 -0700 (PDT)
Message-ID: <cfc8254d-6b15-4d9b-af28-7129b76363e4@linaro.org>
Date: Fri, 11 Apr 2025 17:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 8/9] meson: Disallow 64-bit on 32-bit emulation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-9-richard.henderson@linaro.org>
 <Z_kcXeS8qSDa0I8_@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z_kcXeS8qSDa0I8_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 11/4/25 15:42, Daniel P. Berrangé wrote:
> On Sat, Feb 08, 2025 at 12:57:23PM -0800, Richard Henderson wrote:
>> For system mode, we can rarely support the amount of RAM that
>> the guest requires. TCG emulation is restricted to round-robin
>> mode, which solves many of the atomicity issues, but not those
>> associated with virtio.  In any case, round-robin does nothing
>> to help the speed of emulation.
>>
>> For user mode, most emulation does not succeed at all.  Most
>> of the time we cannot even load 64-bit non-PIE binaries due
>> to lack of a 64-bit address space.  Threads are run in
>> parallel, not round-robin, which means that atomicity
>> is not handled.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   meson.build | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Shouldn't  this patch and the earlier ones in this series have
> added something to removed-features.rst, as this is a significant
> feature removal which is impacting downstream users, and distros
> in particular.

IIRC the rationale for not deprecating was the feature is largely
broken already. Skipping the deprecation process we indeed forgot
to document in removed-features.rst.

Do you expect the doc update for the 10.0 release?


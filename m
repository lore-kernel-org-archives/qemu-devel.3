Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A49CEB2CA
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 11:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKEDV-0006GU-Ii; Sat, 15 Nov 2025 06:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1vKEDN-0006BS-W9
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 06:13:10 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1vKEDM-0003Rg-6K
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 06:13:09 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-298287a26c3so34670555ad.0
 for <qemu-devel@nongnu.org>; Sat, 15 Nov 2025 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763205186; x=1763809986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=olE+ocH1/pBV1rpZ3ceFVP3qottVZ6Q+ZvEctZhp1SI=;
 b=g/TdSN7bEfbYf/e++KAVYxIUYLjGU7qsLD1u/iE0OvsYjoF6nVgiePCIpj8dQKGKOP
 Jyp7Ip03PuNjWjVMV/MZD3KgJjMJ1akYMow8JHpqaWZ8q9EQk8xCcied6P1t7FU/7Hn3
 CMhqTqK8hD2W8rRtmjkGScvtOCDQMl6CuNgWxmDh+vRmgplQYXmrn184nNE8nyrYr5mg
 ypTV9EOlnzpDNaAoCd6r9flswWNN5jltiiBQ8df/LrLl+BEMSfH2MHMXGXHD/XSlNBvS
 5bh2gLiPw1Pp9BvbC8aUKH63SP/2LNwRqPhdgqIrsDcDHWP6ykg6liFj6v4Hh8qu7GtQ
 t7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763205186; x=1763809986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=olE+ocH1/pBV1rpZ3ceFVP3qottVZ6Q+ZvEctZhp1SI=;
 b=C7mOpnuMoYRFox+4bH8nzYhzk2A4YV89/j5VjhKNo08itacCYn/63TzMTTp5O71GLB
 zo24At6FpLLtACnOm+JyKWc0ETpNug6mYzZwZCUaxwVIasPU9MxWbW7hRaK8MR8mmrL5
 2jhfkwh+amkDGfhoTRhxzLbjmPMa5SRfRJY0u9qioaV2OTHCxn1lbNe0WrcFye2TyCSv
 UYQDAbjgQU2s4WKgJsfJzQUswokAiASPG73uhKzG7nje6KQT7CY5+9zO5+Gc08jLVUqC
 XYqy+AUKsObhwOC/xk7AieTHReV/fG1mPg9UzEb+1CcDkFvssZ4kd5QuVYvDqE/obqMV
 2EWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1U0lUIUFVStCnv08XYElSJXGegS6aoRReDE3O6Ls9boHyY0tV2KXECFN+CmeZBkOLL/pFbL79fUJ7@nongnu.org
X-Gm-Message-State: AOJu0YxTpWrOEnAJkejkRrgfFYJ3B9ElBULKc4F7BX1p2NGoW4L5+P6p
 Wv0GCV4s9SIRCXISqh9PCNoTwhcYrb6xhhIu3txktu/lJjKvB5gR5aft
X-Gm-Gg: ASbGncvEj7+p9wBIIA0cwtu4sfFqJPhkm8et8yMiANkV+K6++PgJqRN4oOwMewDTU+Y
 Atu1EZUVJwdBupkpcJUukE/nwCZS3q78TcBmhW9A9XY8qlKjOnEdmJw9hCZmX9wJDVE8+zfI4Dk
 1cgerCchld/PFecCkgQabkx8SphcnZK7EJSOG3aAiDa480ZJgTWLWWZyRnsuEHnjqZ8G/5NRHUC
 RModuXXM4J5Qy8K5oZ6c+YYlOpM9llz2dx1Ni5SWZHmxXgFSVnV/yqaSwetjRG8AZL7sCfWu1Qh
 g2ZnNejHoB6U3I53B3eqeaDjhYeA8C0ubWJ8jnjfKKlznKSFZURo/gTs6ZPtVIJWm89bDnrcmiv
 P42QFWwc8RQlNmtCH9vp4HhoyhfIuIWww2X6RT9uP4scK2HhB//0QwSgaWKRWaHUKw0TecmMHpz
 EvkpdepcsqIFeC9gvtYHf293sswT4t9hDer6gMiRZ7foJ8sowhfBFHIRpyRmsPh971MAMuUhbD5
 pC/LohuE9/3fUV7
X-Google-Smtp-Source: AGHT+IFKTC1OzzyUgIxkRW0PmyqZJlCe4tzGYn4Cz3lbfDznKKraQhCk17bdfargV0z+vAfZDKEkag==
X-Received: by 2002:a17:902:c94d:b0:295:6427:87d2 with SMTP id
 d9443c01a7336-2986a76f56cmr73600625ad.53.1763205185630; 
 Sat, 15 Nov 2025 03:13:05 -0800 (PST)
Received: from [172.27.236.38]
 (ec2-13-250-3-147.ap-southeast-1.compute.amazonaws.com. [13.250.3.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2c0577sm84141215ad.78.2025.11.15.03.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Nov 2025 03:13:05 -0800 (PST)
Message-ID: <cfddf7d0-9a85-4669-9b08-9893fb00f001@gmail.com>
Date: Sat, 15 Nov 2025 19:13:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: vsock support for communication between guests
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <1943ea16-c3cb-4442-be72-5719026ee13a@gmail.com>
 <pkglizwznrfj6fm7tdyew4tzmomgtp2cetxwfj2fx7ge4vtwhv@kdlj2jdxqheo>
 <9535cd2e-239a-4002-be5b-b7c7fa85f081@gmail.com>
 <aRIQwPIGIR/6CgeE@devvm11784.nha0.facebook.com>
Content-Language: en-US
From: Robert Hoo <robert.hoo.linux@gmail.com>
In-Reply-To: <aRIQwPIGIR/6CgeE@devvm11784.nha0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=robert.hoo.linux@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 11/11/2025 12:20 AM, Bobby Eshleman wrote:
> On Sun, Nov 09, 2025 at 09:13:13PM +0800, Robert Hoo wrote:
>> On 11/6/2025 10:32 PM, Stefano Garzarella wrote:
>>> On Fri, Oct 10, 2025 at 09:00:21PM +0800, Robert Hoo wrote:
>>>> Hi,
>>>>
>>>> Does vsock support communication between guests?
>>>>  From man page, and my experiment, seems it doesn't.
>>>> But why not?
>>>>
>>>
>>> It depends, vhost-user vsock device, supports it.
>>> See https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#sibling-vm-communication
>>>
>>> The vhost-vsock in-kernel device doesn't support it.
>>>
>>> The main problem is that vsock is designed for host<->guest
>>> communication, so implementing a guest<->guest communication is
>>> possible, but requires more configuration (e.g. some kind of firewall,
>>> etc.) and also an extension to the address (see the required
>>> `.svm_flags = VMADDR_FLAG_TO_HOST` in the link).
>>>
>>> The easy way to do that with vhost-vsock, is to use socat in the host to
>>> concatenate 2 VMs (some examples here:
>>> https://stefano-garzarella.github.io/posts/2021-01-22-socat-vsock/)
>>>
>>> Cheers,
>>> Stefano
>>>
>> Nice, thanks Stefano. It sounds ideal for my VM <--> VM communication
>> requirement. I'll read the doc carefully later.
>>
> 
> Though not as convenient as socat, VSOCK also supports sockmap which can
> do this in-kernel (bpf), there are a few test cases for this in
> selftests/bpf.
> 
> Best,
> Bobby

Nice to know this, thanks Bobby. It a good idea. I'll look into the selftests 
for reference.


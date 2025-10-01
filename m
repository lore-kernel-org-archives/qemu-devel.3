Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5AECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 20:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v43Z4-0000ky-IR; Wed, 01 Oct 2025 16:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43Z1-0000kK-G0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:36:40 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43Yq-0007xz-Cm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:36:39 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so2892415ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759350979; x=1759955779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kiWW+C8RGt78WNbP+kwxGb8k5Hwbn6VzonlZTNBrRoU=;
 b=DReaxX0CE5dw+o00B3QE0DyoPBy/qF3xkBortB26og9vScktHTUIo2hPpr0VJgL4oo
 CZb2JHXX4h/k9NaBeVe8SSvD30WlHZ6+W/3n1tB2tN+J+EmSivva0XLqNWdqLRHVz/MS
 g/G8nvPwGTNudhR4hr+wjTAhBbc7pmflm1UUd/MIpIRLaoaEDY16WKiv2otDlt0CPyuK
 GeMceUVT28zRGXCoOI1QdJ9a1T4e+T2aiFAFw7U0EyggvETZML5qKLW3Cr3ebgoKIaDP
 o5tw2Eco6b95WNw1FJ6ki6ftpkx7mf+MIDtJ6kCBtRMet78oxIjQT2RfuP4UVuG4xnVE
 RICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350979; x=1759955779;
 h=content-transfer-encoding:in-reply-to:cc:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kiWW+C8RGt78WNbP+kwxGb8k5Hwbn6VzonlZTNBrRoU=;
 b=aPxB646Q+zV589Ua0q1bpBVol/ZRnldlzwaDVgvW6XTYcQ1gwjeqt0Ne29tX5FVDF7
 PRYD/bxSrbEDjUeYWLMM8q1rPKKDJQOs1qsdP4s8ybiusvcB7/CyfWa2kS9ZtEqAvqY4
 SeTrJ1LDBi/RS9rcJRjBhL0fkh3yF86GQk2FEvheLwPQAXNvm8QJ0oJBdZ3tiHRLJqZV
 TKIyaomTMAWwGiX+J7fdZQPRHg6K4zf6tog+/Ljey2gOEiMzbCLAxBKqgAUsgBJP7NJk
 PBYw+9s5PQLQ3QUxVRc29o47wNB74S4YLx56u9B7ERX2YP99lRkikX+lZErlYwX1dMJ7
 J+ug==
X-Gm-Message-State: AOJu0Yxtjt+K+k7uooELwRpncLyAk4Vf68SVN1BZMQBSb6bck8nidoxw
 8ed/AWpHBkiYQD2+XXxy9M6XOIIsqH8uqyhMppAJQI+cAk1Hp3TFmR3FqseHiDp3zFHz5CX+iZ8
 6FsNnMl4=
X-Gm-Gg: ASbGncsen537JqZYQmVLAxaUXTdABdlZICldw9ZShr6m7Fh+DIFlQ0Ocs11oqu9AIOU
 2DQEiHgIdhSfhJIwtDlWGHqg1NtS7Bw/2GZeUGpAlp78ge320/GNuF+mRJ8ki8YYUzawTLdmSuw
 SQg/T04jr3eO/KpM4rfa4I6tZg7b/A9T72X7cZzEfprsJteKo9HkvWFeWXmGsdZjLwW9lSXsNIw
 hMRFOJzelBT2iV4ORVMIcLCyofHhIQZMZ0P/yvQS8h+HFy7UoQawaL+eN2Pnz5WA5+HLNmiG6bC
 WaCR6i7cYG8ws8Qq0Seo1tSkIieB+4XCAZxEE/mLS2t1boiTP8kWDYETju2tQbDfQ/1I8j3Q/Lq
 I62IgKn47Fh+qgbDthNVLDlOdqF/EAMp+CB+IP4+e0SX7aTl/Lrm/xN7JQj9W
X-Google-Smtp-Source: AGHT+IHN3LLsCVhucy5fzqlbwTanB6CjeYBsMUBR5xu531OnnBOR7G+bH2i/DN/i0BkFq2FDPEB/4g==
X-Received: by 2002:a17:903:4b47:b0:264:8a8d:92e8 with SMTP id
 d9443c01a7336-28e7f446c33mr57311905ad.59.1759350978974; 
 Wed, 01 Oct 2025 13:36:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b93f1sm4652345ad.71.2025.10.01.13.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 13:36:18 -0700 (PDT)
Message-ID: <1c567b4a-4966-4374-8851-81c9b1393d8a@linaro.org>
Date: Wed, 1 Oct 2025 13:36:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] system: Don't leak CPU AddressSpaces
To: qemu-devel@nongnu.org
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
In-Reply-To: <20250929144228.1994037-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/29/25 07:42, Peter Maydell wrote:
> When a vCPU is created, it typically calls cpu_address_space_init()
> one or more times to set up its address spaces. We don't currently
> do anything to destroy these address spaces, which means that we
> will leak them on a vcpu hot-plug -> hot-unplug cycle.
> 
> This patchset fixes the leak by replacing the current
> cpu_address_space_destroy() (which has an awkward API, includes
> a bug, and is never called from anywhere) with a new
> cpu_destroy_address_spaces() which cleans up all the ASes a CPU
> has and is called from generic unrealize code.
> 
> Patch 1 is just a comment improvement to clarify that
> address_space_destroy() defers most of its work to RCU and you
> can't free the memory for the AS struct itself until it's done.
> 
> Patch 2 is from Peter Xu; we need to be able to do "destroy and
> free an AS" via RCU, and at the moment you can't do that.
> 
> Patch 3 is the bugfix proper.

So... I wonder this is really the right direction.

To be specific:

Over in split-accel-land we recently had a bit of a kerfuffle over TCG registering its 
MemoryListener with all of the per-cpu address spaces and HVF not doing so.  Things get 
even more complicated when one finds out that some MemoryListener callbacks are only used 
with "global" address spaces and some are only used with the per-cpu address spaces.

On reflection, it seems to me that no address spaces should be owned by the cpus.  All 
address spaces should be owned by the board model, and it should be the board model that 
configures the address spaces used by each cpu.

If we do this then address spaces, and even the array of address spaces, may be created 
once by the board, shared between all (relevant) cpus, and not destroyed by cpu unplug.

Moreover, in the context of virtualization, there's now exactly one address space (since 
Arm Secure and Tag memory spaces are not required or supported except by emulation; I 
assume the same is true for x86 smm), and the aforementioned kerfuffle goes away.  There's 
no difference between global and per-cpu address spaces.

Anyway, it seems like this provides the same flexibility in the complex heterogeneous case 
and simplifies things for the homogeneous virtualization case.

Thoughts?


r~


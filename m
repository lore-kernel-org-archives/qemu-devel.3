Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D58C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 03:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHwhl-00053l-RS; Wed, 21 May 2025 23:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHwhk-00053Z-0V
 for qemu-devel@nongnu.org; Wed, 21 May 2025 23:34:48 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHwhh-0003ij-KF
 for qemu-devel@nongnu.org; Wed, 21 May 2025 23:34:47 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-231bf5851b7so58848575ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 20:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747884883; x=1748489683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mBrBUjLsyG7x2XV1smBU8aDlgy53pEfP1aPc4hNF+Ik=;
 b=AAYkS95GcYLicpeZ6YdU74u7xSNZBDZQyOL8UMGF7IyflwGy0uUNIy+nHcAqpa9RgR
 7ChpLdFrC8TppVIZAkQvP2OUjGU6d3MKR7vVHW6yBpRAB+TAloJElJztYQTmoAyKfcDN
 6QDULNKXGx886mmdjG7lmGrihun7axQp+W69D/Ku7+3Uz1Yjxk6HeS/issXysODi60rS
 aJ7C+9GTQ7jkhtXfZS3U5502iB7U+oMK6ekOPmWFY7N2Xy35Dww0Nzejd6PWZvghTFfg
 +5DJTtCnAdVg3bVcsXq3OdxdmsfcjfdSdIFMQzZxTD/7XaQSgZll5q+m8q3vfElet49g
 VHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747884883; x=1748489683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mBrBUjLsyG7x2XV1smBU8aDlgy53pEfP1aPc4hNF+Ik=;
 b=b1kmN32YBqE808F6x/izs5cM+o3Aw4gYIn9L3jzUS3rbuCj3mgxcr2nHmNeAtuRbsP
 /8sEK5bje4Tv0a/oacfccLI/B67XIAQfcwvshsDtDHUA56kHSlUL7D4bvCnvahAiU7Fa
 2dWkD5JzsmU648f1LoJAS2NMY5Hnl1P+DA6rIF3mvgec+V0/Ji1/l64BLHkF+NoA9VnX
 Di8cGRPWK3O71/IVm34PXIO7VWhW2KF0T5gbpLnznzUdq3LDAgRLfCpbo2Q+m/02qN8v
 eNhI+R0U0m5vr85jgFmdIrucpahlsmveANxIt3p1i3VZE6rKF+RrV37LNiHYJSNjZFbA
 aNhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtwS5PB8KDSogVQlQ06LPCG7es1pFh3qUm+CVMWwnGGVY6fHiEM8gZA0LZ8lOf0EnV41JSqgevvomk@nongnu.org
X-Gm-Message-State: AOJu0Yx4bPjz4THpOmno32PLRdtEgFekK8c+JKI75bq/jwvtFNXbjA/c
 PnO2Og9yQh6ZgUwEAAX7ideHxywtWSc2L0rnnUZVQ9g6resLiEhLAtjY
X-Gm-Gg: ASbGncvGyQuMjdSrk0GY6jXJATRE9/4u7UQJePF8UTmoLykYuvmccWUOSxr39SvrxVi
 A36Yd8+RBdJey/pe6C2iha16JJjbd6soPPfuZnUgpvYgWfoqa83UJW4VPthOLboF/RePFob29gu
 5tnqG5zWS/dxPyadmTLosUoINEvB76dUWh+BapfQYoDSeOA92+jz/QnQU1LSuXLenGv0lQ76YsD
 i4g6qfeYKIAv3OBxI5ZT/wFFg9k4DHYzKw+00sQWc5mZJmTmn48JkftzOfYy5qKjEgtP6my9a6T
 C8AcApeVqH4xvEH44zxiQHAXiS7TWkia7YW+ALO81lVrahmJDMqJT0g=
X-Google-Smtp-Source: AGHT+IF6Wa9p4wTboKqta2Wy0GNUj4YOKcIbwHNbx4xrFPOKnje0BphCov2Fsk4G1RNEjBJwlmL2Tg==
X-Received: by 2002:a17:902:db08:b0:223:66bb:8993 with SMTP id
 d9443c01a7336-231d45c4e39mr366903605ad.43.1747884883347; 
 Wed, 21 May 2025 20:34:43 -0700 (PDT)
Received: from [192.168.1.119] ([50.46.174.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4afe856sm99727055ad.86.2025.05.21.20.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 20:34:43 -0700 (PDT)
Message-ID: <9e1ebea2-bfbf-4ba6-85fa-c068d627d9e1@gmail.com>
Date: Wed, 21 May 2025 20:34:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] Add memory hardware address read/write API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-6-rowanbhart@gmail.com>
 <348a6c09-3c8d-471f-af6c-e8201760614e@linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <348a6c09-3c8d-471f-af6c-e8201760614e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62f.google.com
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

Well, first I just noticed that I left a debug print in this function! 
So I'll fix that.

> Reading this patch, and patch 3 (Add address space API), I am not sure 
> AddressSpace is something we want to leak in plugins interface.
> It is a concept *very* internal to QEMU, and not reflecting directly 
> something concerning the emulated architecture (it is related, but not 
> officially described for it).
>
> The same way qemu_plugin_write_memory_vaddr is only valid in the 
> current page table setup, we could assume the same for current address 
> space, and return an error if memory is not mapped with current AS.
> Eventually, we could read/write a given hwaddr in all existing address 
> spaces (starting with current mapped one), if it makes sense to do 
> this, which I'm not sure about.
>
> What are your thoughts on this? 

I definitely see the arguments for not exposing it even as an opaque 
struct, internality not withstanding it also adds some complexity for 
plugin authors.

My thought with exposing it is kind of twofold. First, there are 
specific address spaces like the secure address space on ARM or I/O 
memory on x86 that plugins might like to access and I think it's easiest 
to facilitate that if we just let them choose which one they want to r/w 
to. Second, I wanted to lean towards being less restrictive now to avoid 
having to go back and remove restrictions later since even though it's 
very internal, it doesn't seem very likely to change.

That said, if you think it's more trouble than it's worth I'm totally 
fine with just defaulting to writing to the current AS (or to 
cpu-memory, whichever's more reasonable). Your call, just let me know 
which way you think is best for v4 :)

> qemu_plugin_translate_vaddr is fine for me. 
I did have a question about this -- one of the test plugins prints out 
vaddr, haddr from qemu_plugin_insn_haddr, and the translated haddr from 
qemu_plugin_translate_vaddr. When running with direct memory mappings in 
a system test, the vaddr = translated haddr, which is correct, but the 
haddr from qemu_plugin_insn_haddr was incorrect (it was 0x7f....f<actual 
address>). Is this expected behavior?

Thanks for the feedback!




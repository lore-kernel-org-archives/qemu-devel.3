Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AE6C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 21:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHUDL-0002Gz-Cn; Tue, 20 May 2025 17:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHUDB-0002GY-Om
 for qemu-devel@nongnu.org; Tue, 20 May 2025 17:09:23 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHUD8-0004Hx-Fy
 for qemu-devel@nongnu.org; Tue, 20 May 2025 17:09:20 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so3555002a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747775356; x=1748380156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z+Zz/trSqhH9cHhmsFKr9/dSpFPAt+EekzEHyYhLMrA=;
 b=OXkyznnEzwiwlWgNdNQxsmfy9GTxnAeTj6yoFrCkp9pZQZ7OYoxjJznxXw+MLvNdbP
 Nu1xqU3JFCi4DOn88HGb2pjaxttJvY3ocGw3sPwSPrFCcv2vVkA5ovX9xnYOYmguZ69X
 5yL4pR7WqqmKqPTMHYSzIMxOXFkDaM8JujnvmZSBryRG8W8E1USfN70TlnBX9PzXNiOd
 T15D7VbyrrYgyS1HYZgBXLtRJQhTw8XHHtfe91ZzKunjNiu7yyeM45orx2Zofb2vZYHj
 xsoc/QH79GaSKV/MAFCBjKqmTB/Uq+ev7k0VZkcdPvF3cfzjyWLTXeEPBSkTzYMOIX1E
 aW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747775356; x=1748380156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+Zz/trSqhH9cHhmsFKr9/dSpFPAt+EekzEHyYhLMrA=;
 b=UKUiOZAERaNBXtBIsvY6ZIvyrNcynExhFstn+9ylC+kh2xqicncInvJ5tsP+jVBGBK
 tQMmBQUrEEYsT4s/edQZ0ffzjy5ZO0Tj+oincdz6arP2QVs+24Yn24Fv9wUBxYLy/f6j
 7kWUV0/PupjK714/4vKaQ5Pl+qzg5r2FS5ulbSZ4bN4PwTTwRnQcvE4jZlA+yRqeKBc8
 AM6j5kA8uKI7/stRhCs4LiOoOQh4GZouJx+6sV7Lo9MIBEK4DD9bFPFQo+Y63FSe08Qn
 SDacthVCWZfxAPtSeg/hD65gaG/KoCZ4YGTTbAFlToh9yTimxsdYoJD5Vpcd4bG5ODo9
 QM0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGemyavY+YqrdSyC0AN6De+v56h+01cSVAeN3YV9+Ta2k9EFGDuhP0SR0v/GEr3nrb29h6BiOhuT9z@nongnu.org
X-Gm-Message-State: AOJu0YzcDGzBP2S3pqzgUuB6R1fOYuf7PI6NERl18kwb7K9uAGjId5+H
 7nOHlbqXjht2nYlKyH7z3K/Ga2OUskXzKxFk8uQ6zTYy4UFUJSvNDeTrGVgu39klUXc=
X-Gm-Gg: ASbGncsa6PlcjB5Vel785YQAa2vO1Smfo2NebQzo808ajn1aLv03mr4rvLdV4sc6EiM
 zDo5a2dx2d6BbFXfbB4k+5zrtpy+1ozP5M7HF2GqewFwVM4f4hdG2+EAf6ltgkFy11/EbgF6IWr
 IUF9gcUmdb6EMqU2dl6wvnoDgr8JjYs7I7T2/jIrLxGowoorkZkMZdycpapTV+YlcuR0Jqx6PYE
 xOwVAJJShAvfmqiYhInaYEsBWY0Nsc2FITrg+O6ZEy1+j/XDoYh8ZZ9aa0C2rm70uFhmHvCDupZ
 K+RF4FMSPG0OE/KYxhu4/fTBh8h5cVnImNfFsL6VstY24BEHLTS1qR5F9jYDl5FI
X-Google-Smtp-Source: AGHT+IFHaBbaJMq8wrSjmUIqLMfWreNGi+asevm4OZ0bkqEoAho0GTX+mxaPNRBHl4mzwlj6rKLGWw==
X-Received: by 2002:a17:902:e5ca:b0:223:f9a4:3f9c with SMTP id
 d9443c01a7336-231d43d5526mr250015815ad.9.1747775356272; 
 Tue, 20 May 2025 14:09:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ed5e7bsm80329655ad.249.2025.05.20.14.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 14:09:15 -0700 (PDT)
Message-ID: <03a14875-170a-4897-a4fa-073fdfd1479f@linaro.org>
Date: Tue, 20 May 2025 14:09:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/25] tests: add plugin asserting correctness of
 discon event's to_pc
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1747666625.git.neither@nut.email>
 <2a30a629012f39f8495415f87568fe9b3a0eb32b.1747666625.git.neither@nut.email>
 <dbf71afe-1ae2-4110-8f83-fe1b1823a774@linaro.org>
 <4ea8edc376234e43230b09cb1b740616dee1652a@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4ea8edc376234e43230b09cb1b740616dee1652a@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 5/20/25 1:44 PM, Julian Ganz wrote:
> Hi Pierrick,
> 
> May 20, 2025 at 10:01 PM, Pierrick Bouvier wrote:
>> Regarding the issue with the same tb being mapped at different virtual addresses, I'm ok with the current solution of comparing only page bits.
>>
>> That said, a better solution could be to compare physical addresses when a discon is detected (on plugin side), and confirm it's really a discontinuity or just a different mapping. With this approach, it's not even needed to have a dedicated option, and there would be no false positive in the plugin. It's just a suggestion though.
> 
> I actually tried to do this before resorting to the current appraoch.
> However, there is only API for querying an instruction's or TB's
> hardware address and none that would let me translate the virtual
> addresses we receive in the discon callback, which we need to compare
> against.
>

It would be acceptable to add such a function allowing to query physical 
address for a virtual address (using cpu_get_phys_page_debug behind the 
hoods), as it's not leaking any QEMU implementation detail.

We can implement this later if you don't want to extend your series with 
this.

> I considered also passing the hardware address to the callback (do the
> translation in the `plugin_vcpu_cb__discon` hook), but that turned out
> to be not straight forward and not something we'd want to do in the
> hook, either.
>

Yes, in some cases, people will want virtual addresses, and sometimes 
physical ones. So passing physical ones only is too restrictive.

This plugin is a bit specific, as it's explicitely tracking all 
transitions between instructions, where a "normal" plugin will just work 
with discontinuities. That said, the use case to get physical address 
from a virtual one is a real need.

> Regards,
> Julian

Regards,
Pierrick


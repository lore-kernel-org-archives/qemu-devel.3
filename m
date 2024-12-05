Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1CCE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKLG-0002xy-UF; Thu, 05 Dec 2024 17:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKLE-0002xj-Rw
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:29:00 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKLC-0001zP-UN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:29:00 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-724f41d550cso1093031b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733437737; x=1734042537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lzNQNH8b6RVl7t9FRbrQfL4idvqrAqaCfdV2xa48LSs=;
 b=wjnhkCb1aFGskhsMdm+OrqnzT9SQt+9SrQ4upmfqNpbzC+kHMV2vtMXqeoBFm3bMaI
 eZIGdbotCmnQQeDrdWIZqkZs6n5QuwocCfjD52C5wyuMD+wdreusHYe+ldOnuC2/vtze
 U2CLFHpblxTc2chEEYL/kXnL6cDKEEKw0aDoq5GLHKWhMI9jKEeHndlgZ0XASo5ZDoHt
 9CadHR8m9P41kRX/TO6pIPbvy60xBHgMMxe3Ux5H3pGzi8yovbyqTD567V810NZKJl1D
 iW8XGnAztGCFv9454eRXfYjLJVzLainf354xCpCoabvIsnrTB1ccrX1T6UrP5NttgU8w
 mBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733437737; x=1734042537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzNQNH8b6RVl7t9FRbrQfL4idvqrAqaCfdV2xa48LSs=;
 b=hNWI6BhAL5DjVR0I+/cux5eOj2V/+y/PeC1r7SU18lEkRgjAqD5uASC30hMg9lXPL0
 cjnMeDqVa4/2y0m3Hsq0aBA2VjDyto6GP3BAD4e1JCZyfvhSM2WqTxc0sAbwiwN0eMss
 VFtPf7e88UCDkK6fpjOYDUG2Anvkeh4VpDCChhLLGd+zlB4jZXgocC/MSk7EnH+K22aw
 bzO9ex1H0X0m0iiFxj/LbXvUiWjjGNuHYR8KlWeMQgwgEyL2cDtRh7oFfwvfKfxEFU4k
 zShipCTencJ8Lv9vXeoUs5foqQstCc5EeeeJ7RKxWHhB7A4CvjALBP4AigfQAM3Um6fO
 cXbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7yL4sTP67ipWGilMeR/0MLnPzXfqEA0/eGDThMr1WqhN60g10DTsc0r7nMMxULdRmhfXXCvwlI797@nongnu.org
X-Gm-Message-State: AOJu0YxD4bMPaE3RKaYyGxk/vx+dkWa4iuorznA2dQLiSdL67OXZMGtQ
 d/5G0nVxT/t3PPZNXm80kRLw2D5tRaLQF5Bw07nZW2kqE0DZNaY2hfmiEHFB1L8=
X-Gm-Gg: ASbGncu3tjn2uHpshrzPhtWROB7qOaLaKEwk4y2YNttDa3bDIZLvOrYN9n3nQpdswol
 WwfATVgpX+0R50TrYcLSMh2Oj0AE9DprIiqI1xstzEEd29r6deZ1beIOZbsq0a9er/juRRTauYU
 KdKxKTp/889mtbYkb74TUtcBGdeLh2A8jhoFFYAf58o1eYDQVuC8mvrGQ3c63PF5XT+/lTL3Vy0
 QpOpl7ytAM88RPd/ZU3WYgMKzmSka6DN1cKaG9UGCydxh+gW4OPieZyiS7n93NpEyYyRyf6st38
 S3OjFUzIUe5ba+fPwdV6nA==
X-Google-Smtp-Source: AGHT+IE9AxCJSCvCAaQYmtUTaulkuhc4AlMqKAaLM0mnl9YxgprMPRyGNY/Pw/LXICDFY7/rifMENg==
X-Received: by 2002:a05:6a00:988:b0:725:64d:c803 with SMTP id
 d2e1a72fcca58-725b820b6c3mr1187901b3a.26.1733437737462; 
 Thu, 05 Dec 2024 14:28:57 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a29e8fa7sm1797671b3a.67.2024.12.05.14.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 14:28:57 -0800 (PST)
Message-ID: <cda016be-c82e-4b54-a506-22afe6ec2eb2@linaro.org>
Date: Thu, 5 Dec 2024 14:28:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
 <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
 <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <450f3beedf979437fa3de8bfab1ee72f66c67ada@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 12/5/24 13:22, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 5, 2024 at 6:30 PM, "Pierrick Bouvier" wrote:
>> On 12/5/24 05:10, Julian Ganz wrote:
>>>   December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
>>>> Trap target PC mismatch
>>>>   Expected: 23faf3a80
>>>>   Encountered: 23faf3a84
>>>>
>>>>   From what I understand, it means that the next_pc we have is incorrect.
>>>>
>>>   Yes, this is indeed incorrect, and also a perfect example why this test
>>>   plugin exists. There are likely other errors lurking in target specific
>>>   code. Did you happen to also log interrupts? Do you remember what image
>>>   you used?
>>>
>> I used exactly this:
>>
>> ./build/qemu-system-aarch64 -plugin ./build/tests/tcg/plugins/libdiscons.so -smp 4 -M virt -d plugin -m 8G -device virtio-blk-pci,drive=root -drive if=none,id=root,file=./debianaarch64.img -M virt -cpu max,pauth=off -drive if=pflash,readonly=on,file=/usr/share/AAVMF/AAVMF_CODE.fd -drive if=pflash,file=./AAVMF_VARS.fd
>>
>> The arm64 image is a vanilla debian stable I installed.
>> AAVMF* files come from qemu-efi-aarch64 debian package.
> 
> Thanks! I will have a closer look and include a fix in the next iteration.
> 
>>> Btw: this also illustrates another issue I have with from_pc: we can
>>>   test the behavior for to_pc, but doing this meaningfully for from_pc
>>>   via a plugin is next to impossible because the instruction it points to
>>>   is not observable via an exec callback. At least not in the general
>>>   case, even not if we only consider a single type of event.
>>>
>> We can store the next_expected pc for each instruction (from current_instruction + insn_length), and we should be able to compare that with the expected from_pc.
>> This is mostly what contrib/plugins/cflow.c does.
>>
>> With that, we can test from_pc.
> 
> I'm not confident that this will work reliably for branch, jump and
> other "interesting" instructions. But I can have a closer look at the
> cflow plugin and try to figure out how that plugin handles those cases.
> 

It won't work for latest instructions in a tb (because we don't know 
what will be the next one), but should be good for all the others cases.

> Regards,
> Julian Ganz



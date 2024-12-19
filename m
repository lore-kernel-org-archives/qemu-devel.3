Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031BEE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 00:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tORIw-0006H4-Jr; Thu, 19 Dec 2024 19:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wqu@suse.com>) id 1tOQ1E-0005Tn-P2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 18:33:24 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wqu@suse.com>) id 1tOQ1A-0003yD-QU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 18:33:24 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38634c35129so993779f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734651196; x=1735255996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=plXzy0mqccglcjN60lQtMmRi6JM3/4v7bNfZ+B+BCEo=;
 b=Xsq3j/M2RcNLGK0nWzJdaV69rI2ilVB9uivOr3DIGDHL3EIz1gZc3LZ1ipJa0H3CGv
 yUNprB7wim2tkQyChknFaDDXGsCr8tF8lBZnl34g7vTnlD+q8p97Z/7assrUKO4sBZgm
 fLcT0XNjKnHBRJezPplG506JJfvgknivW8DOozbaJTw13pdhHT5fNsCvN2Qzuxj29y3B
 Tq64jYqn530rUZAT+05bm0g4vUWEoMQiYfq24FM3hlE/lxSsbCwlTGyY6j9L1wj4kJGE
 2FPXKWQ2ZUVr8lu1H28/9h92fOMKJOW9wLTaA2ftOG9saBe1A5rZEcL2zQ2ITGe6Bphg
 QI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734651196; x=1735255996;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plXzy0mqccglcjN60lQtMmRi6JM3/4v7bNfZ+B+BCEo=;
 b=JgmePle2M0zwHVoIrEaeLSueESPQr4pnfJOG4gGHNcEyLZIJEJf6eit1lVrUnbkqXd
 tIGdEmHFCe7K5SxpIlLZsP1IMtH/c83SS4hoE17HWsnm9t7+U/keDG36ipp4bZU4JdX6
 snN8LC+LmZw5Ot7gih6vRuuhI7vS9xE/Y4LNQKkfG6DlrcAm8K73n+yx2JZf4XL/R3N8
 f4jVqzaQb3e4wsaQXRyTPl0aXy7A4OevHPLeTvilObaDCBlYZ9jk8RSw9bB232VJTRPl
 ESO7X8FAcnBkBdlOlUvS0h3Gn10ZxepwEgzM+HGNBf1n3p4iHXLJTp/K5rNo1lIV2XZh
 TE/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Ki2CHwhmQnh6C8At3PAK54dtJyN8E95Atu1Fj4JxXKIbZNAb7WAAYvZxM5UwSukttlxiO9fcKy5i@nongnu.org
X-Gm-Message-State: AOJu0Yy4e+fojFkpfzB2rYLq473N2dY96a2lS9zcNsIUIepRvesOctOD
 nQKkOXTqp8F7eC7rMUBRzEsB25fkRcL4IJO+r0+ghQW0/XU6QfbFCKo6K9cJEC4=
X-Gm-Gg: ASbGncsX0gxssNefMFDgzBMJm6oG/B58lKTA/pXUViR5KCUqi2vKTIS7LRwnFcRZ1LO
 +65gv+xiHUcmQ8BbWOWiFSe92tUT1lO9jCLJeV9zSUY4dZrFgtWq5HbRUyuBniwLSt11xHtPImW
 QNt+Ix6+/TlGy8eXtRCu7QH4NShf87r/y00HrAPoNJhSLucZRKuoRErT8SbgxTSRHzo/dTgTxYi
 RGk+RU0fhY9XP+fn0VA1KeKRyzOILQjlrGrkhsFi9u1d9WyOqAS2rlNjEC0EshHURivcGwhk3oe
 FJwVFQln
X-Google-Smtp-Source: AGHT+IF6jsLKrygiCsaqg3pCcyY8MzhIQvO7tqSo5RX2vJWoS0uQZfdMN1myWFcxAw/3ExiSRCwNfw==
X-Received: by 2002:a5d:5e09:0:b0:385:f16d:48b4 with SMTP id
 ffacd0b85a97d-38a223f7510mr934878f8f.40.1734651196065; 
 Thu, 19 Dec 2024 15:33:16 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299?
 (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8162d0sm1883546b3a.12.2024.12.19.15.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 15:33:15 -0800 (PST)
Message-ID: <023311e6-9666-4fe0-9c22-6a8409065539@suse.com>
Date: Fri, 20 Dec 2024 10:03:08 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64
 with Linux next-20241210 and above
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, qemu-devel@nongnu.org,
 open list <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 linux-ext4 <linux-ext4@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-mm <linux-mm@kvack.org>, Linux btrfs <linux-btrfs@vger.kernel.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 David Sterba <dsterba@suse.com>
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
 <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
 <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>
 <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>
 <0c46224b-ed2b-4c8e-aa96-d8f657f59b9f@stanley.mountain>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <0c46224b-ed2b-4c8e-aa96-d8f657f59b9f@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433; envelope-from=wqu@suse.com;
 helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Dec 2024 19:55:45 -0500
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



在 2024/12/20 02:07, Dan Carpenter 写道:
> On Thu, Dec 19, 2024 at 06:10:56PM +0300, Dan Carpenter wrote:
>>>> Mind to test it with KASAN enabled?
>>>
>>
>> Anders is going to try that later and report back.
>>
> 
> Anders ran it and emailed me.  I was going to tell him to respond to
> the thread but I decided to steal the credit.  #GreatArtists
> 
>   BTRFS info (device loop0): using crc32c (crc32c-arm64) checksum algorithm
>   ==================================================================
>   BUG: KASAN: slab-out-of-bounds in __bitmap_set+0xf8/0x100
>   Read of size 8 at addr fff0000020e4a3c8 by task chdir01/479
>   
>   CPU: 1 UID: 0 PID: 479 Comm: chdir01 Not tainted 6.13.0-rc3-next-20241218 #1
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    show_stack+0x20/0x38 (C)
>    dump_stack_lvl+0x8c/0xd0
>    print_report+0x118/0x5e0
>    kasan_report+0xb4/0x100
>    __asan_report_load8_noabort+0x20/0x30
>    __bitmap_set+0xf8/0x100
>    btrfs_subpage_set_uptodate+0xd8/0x1d0 [btrfs]
>    set_extent_buffer_uptodate+0x1ac/0x288 [btrfs]
>    __alloc_dummy_extent_buffer+0x2cc/0x488 [btrfs]

Thanks a lot. The problem is still inside the dummy extent buffer 
allocation.

This time it's again related to the uninitialized fs_info->* variables.

In this case, it's the fs_info->sectorsize_bits which is not 
initialized, thus its default value is 0.

Then in btrfs_subpage_set_uptodate(), we use (len >> sectorsize_bits) to 
calculate how many bits must be set.

But since sectorsize_bits is 0, the @len (4K) is utilized, resulting the 
out-of-boundary access.

The root cause is the same as the initial failure, that we can not use a 
lot of functions to do such early verification, thus I'll create a 
dedicated helper to do the sanity check to avoid memory allocation nor 
early access to fs_info.

Thanks everyone involved in exposing this bug!
Qu

>    alloc_dummy_extent_buffer+0x4c/0x78 [btrfs]
>    btrfs_check_system_chunk_array+0x30/0x308 [btrfs]
>    btrfs_validate_super+0x7e8/0xd40 [btrfs]
>    open_ctree+0x958/0x3c98 [btrfs]
>    btrfs_get_tree+0xce4/0x13d8 [btrfs]
>    vfs_get_tree+0x7c/0x290
>    fc_mount+0x20/0xa8
>    btrfs_get_tree+0x72c/0x13d8 [btrfs]
>    vfs_get_tree+0x7c/0x290
>    path_mount+0x748/0x1518
>    __arm64_sys_mount+0x234/0x4f8
>    invoke_syscall.constprop.0+0x78/0x1f0
>    do_el0_svc+0xcc/0x1d8
>    el0_svc+0x38/0xa8
>    el0t_64_sync_handler+0x10c/0x138
>    el0t_64_sync+0x198/0x1a0
> 
> Here are the full logs.
> https://people.linaro.org/~anders.roxell/next-20241218-issue-arm64-64k+kasan/
> 
> regards,
> dan carpenter



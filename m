Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BCDC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1f72-0000zB-Jp; Wed, 02 Sep 2026 03:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1x1f6n-0000u6-FV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 03:10:09 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1x1f6j-0002ar-Vp
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 03:10:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so740189f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788333003; x=1788937803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kb/xReX3xAnCTVJo29wNMcmWr6RFMPSFBbtrwibBsX4=;
 b=Y8p+S/0cK/Jpb23034dU55G/IVuWMwcfor9UdOmtj9wWLfjIiH0UozbtiVoONCgmSw
 G2MDWYX8mTMPzHG5NObXYCeNB/f7g7NzwC0NaHZGXDlr1wdotQU/wYBQ3BP2Xxz8j97e
 5StoHQGXZv6lcZhWbe9d+gvNWftPN4UHCKcBhN3K0mQZi1uLBvzN8bAerp1wjlbj7rfS
 pKCDe27HkPdFIcqmrIOjaJy021m580eCntM6xmK0fj2nxwisGemajbPyUehsF+jR3uRK
 WIj4ZHpB0Ij0JPWIN++RP36vAZsPpVMlsofVEERx7MmYJziQn8jdoKioD5t76WDbvoog
 eW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788333003; x=1788937803;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kb/xReX3xAnCTVJo29wNMcmWr6RFMPSFBbtrwibBsX4=;
 b=eZ9uMVDKA00aysSxwD+wFRkogC5135s5u8kNySdzT7bIs3ddmTYWmfcdQG7Ave5bxE
 uT7wSXxrxuVCpqzgk8fbjMtEaGcgZsn17qRVVa3CO9klI1Qk46Gq6hMtrrsCNintXYT1
 K91vvUhTuTCi0Moa/gNSe0x/a5sM4seh0T8Q9cLQBXCYEc7W794CtAFnPXvxfDZ1Wl1A
 1L+5+RS2dFpgm/t6OIdE+4usAXgxbPMCY1jR/Jm6r03k4y9l4540Esv4K/s1b/MWQFo1
 /i+2DurWJ8rRY6ejJw0GqlsBnH6ZAuWjy6eD5OE85Pj2h33HOZk/r1+qpvNV4l6dOg3p
 KhLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBypXHYuVNAX8R0qrgIu20oxmJx9rIOaqLCGwM5v9SywoJNi2wu7PS4nugG0DLHirVD6KHDwp4CKNmAy@nongnu.org
X-Gm-Message-State: AFuF++lvEMS3QDPyD42BQV27BH7FRGw6CmpYEfbd+QSGmgGfLEbXzDWs
 JGokeBDqH9q5NKQycAbzF/51W/mD1l+WJRAzWDnghI2x6simJudiX3GV
X-Gm-Gg: AYBFou3Fb6s2okj1ExLxs95HtGUJC40/nUcvdoU1kRwJf8Ft9cxQj4BwuO09/a7Q0rF
 vZc4nnbHTJZTXQWYBLsSCGF3fNUf9uocyFWT9nUaXutCsmpibzPqzJzyndD3PHpGSHFMjUDhsFK
 jnTdZpp6hfFfHUD5TvSFyD3opqRr07jCFPnyi/hCA9sBDOre6GTowHZW4cKAcjnYpc3UoU2buGA
 TqKGFTrzrh9LnaSSJPn2aNT9DHei94rrFYQyLURBQTk64EXK0JdRuxBgegbGx1YOVggnrJ9/OpO
 TCNyej+RjnFHP4kwJmyGEF2zKgFPX2VPJCRFouunzUgz86C895ZuFFPnE3TGfYAsMe/gE1oSNuU
 iXA0mBJSvsZV+dBmBIMHxFE9SVvWBxjoBEWams4HGqOPkpzalodgtnN3dDKRDFpJQZIOafk8CK+
 PokR64smo3E0MuccXuGNQJTnS0U10UTZDi6wUeqXjiNLk+avMlkqjaQjQx1Q==
X-Received: by 2002:a05:6000:4014:b0:484:4a1d:d693 with SMTP id
 ffacd0b85a97d-485781d6ad6mr1840608f8f.6.1788333003092; 
 Wed, 02 Sep 2026 00:10:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e7fddbsm4127486f8f.11.2026.09.02.00.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 00:10:02 -0700 (PDT)
Message-ID: <e0a10f28-9b6e-4555-b31b-ec3ea111f536@gnu.org>
Date: Wed, 2 Sep 2026 09:09:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] docs/devel: introduce a new policy on AI-generated
 contributions
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "balaton@eik.bme.hu" <balaton@eik.bme.hu>, "mst@redhat.com"
 <mst@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "berrange@redhat.com" <berrange@redhat.com>, "imp@bsdimp.com"
 <imp@bsdimp.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-2-pbonzini@redhat.com>
 <e6ff364982ad264e0ea608458eaaa5aaa292913c.camel@wdc.com>
From: Paolo Bonzini <bonzini@gnu.org>
Content-Language: en-US
Autocrypt: addr=bonzini@gnu.org; keydata=
 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
In-Reply-To: <e6ff364982ad264e0ea608458eaaa5aaa292913c.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thanks for the review!

On 9/2/26 03:38, Alistair Francis wrote:
>> +Prohibited use of AI
>> +''''''''''''''''''''
>> +
>> +The following items **MUST** be written by humans:
>> +
>> +- cover letters and commit messages
>> +
>> +- responses to reviewer comments
>> +
>> +- issue descriptions or comments
>> +
>> +Light copy editing of human-written text with an AI is allowed.
> 
> What about translations? Not everyone can write English well and I see
> translations being useful.

Difficult choice.  I can see that it's useful, but we've never been 
hardliners for English grammar, and translation may cause agent-ese to 
slip in.  I am not a native speaker but I wouldn't use this possibility, 
so I'm not the best person to decide.

That said, if somebody asked the agent for help translating, it would 
probably do it anyway.

>> - small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of
>>   code) are allowed with disclosure.  Splitting a submission in multiple
>>   parts is **not** a valid way to bypass this rule; repeated, frequent
>>   posting of such fixes must follow the rule for full contributions.
> 
> Maybe add something like (fell free to edit):
> 
> """
> When submitting LLM generated bug fixes the human should clearly
> describe what the bug is, how it is triggered and how it impacted them.
> The idea her is that we don't want people pointing an LLM at the source
> and generating "bug fixes" for issues that users aren't seeing. This
> can result in reviewer burnout.

I left that out because the document is already very long.  My suspicion 
is that the agent is able to infer most of it thanks to the 
"understanding" part of AGENTS.md, and reviewer burnout is covered by 
forbidding repeated posting of this kind of fix.

>> - use of LLMs to help generating parts of a larger patch---a test
>>   case, a parser, boilerplate code for a new API, a tool to help
>>   performing mechanical changes, etc. These are generally allowed, but
>>   disclosure is recommended.
> 
> disclosure should just be required here as well.

I think it depends in general.  Sometimes there is really just one way 
to write code in this bucket, and in that case disclosure is superfluous 
(see for example the "impl<T: ToMigrationState> ToMigrationState for 
Mutex<T>" block in rust/migration/src/migratable.rs).  The AGENTS.md 
file will cause the agent to recommend it anyway.

Paolo


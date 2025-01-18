Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8990C02187
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 10:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ5hV-0003RN-SQ; Sat, 18 Jan 2025 05:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ5hU-0003R9-Eq
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 05:05:08 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ5hS-00081E-3g
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 05:05:08 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21675fd60feso65568465ad.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 02:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737194704; x=1737799504;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4w3zbCwjdLnuJ9D02gh3oe6xwG4D1ne4FosIN5nDJck=;
 b=jz6eEzH3U/a2OmbsvwGMQNXIVitoPMo0Nax2g+og1JTczeTv+nLG764oZV01HBDMKv
 Lzife0l9QJjlq4WYCAVcS/jDEWF+XXDPp7be0fgTf8H8CUCw20s8TB5j1ibznHUPCrGV
 iTLpLH3oYujTQegTyxYlI5APs8tpN36qA5BbjDe1kFjP6yeJEsETpSs/6OFagDv6MyR0
 kJDHKD0ruKxnzoFM+etxO6amsULcN5CT3jKl9LMLsQBHAEUR/PjJvrbbXfEslSjdkJ8m
 xazA5y741bJUCUcPakXZQxIZLurBKycATna/dlQVNJxCPYw6+4JiLFH/CQBKuDnrUgsw
 39JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737194704; x=1737799504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4w3zbCwjdLnuJ9D02gh3oe6xwG4D1ne4FosIN5nDJck=;
 b=B+SaND4I0rfsg0j7WadPNToE8ReWE0rtQyhGuYI+qQRneZiOB3RvLVUG7SMglhMXgg
 DB3mDC3B9p5IDX3DvBG5G2cYX7FoyIgJwakSjgfsQ33lHXB0Jd1Zr2H8Nf7vnoGAh8L+
 1FhPimI3DfhDrHsvGIWTBrIGV5wVoEno5yG0W9Q8dvIWjYrNsq5NJVzbyd6ZZOYhWtLg
 SAFbEnz+DweHHXr2st2RtmZZ+mDgJPRDYzxWSwsQMvgT3ukFLqvogjgCx+f2M8+RQ6sN
 bST15w/vx18r8yJoRjBd2aM4VYu/HFL/hDZGcZDM1+r4xCICj75xUXfHeM5kajgKn6QM
 +4ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrcdhj+IguoH4Npm/UEj0+MmnRijy0BrlOEk1qB7C2bZczDRemucfxvmvh8vM+eIG8PeY7VpqKXMXz@nongnu.org
X-Gm-Message-State: AOJu0YzP3Z2BURuxktP78X64z8jqhw8E2J7OfLDNwM9UY0hH7Dgj4Kpy
 yq7F0IOvS7wDQTNOhzLhGbWPOA1U/KqjTaAA72aeQw2i7phzcZLFqfV7bxhrUgI=
X-Gm-Gg: ASbGncubg07Tz2KPhKFWwS+VytgQ5he7hRh9Ki2B3k54vf/LtnksUCe68xL81kWItVu
 0XJd3uw/Wq09AThWI4FdOy+a9WX4mgDES9J2M86iRss3JjKGAE7hz73wVjg2+BRTx15EPM0zaDu
 PnUvmFpBSo4seS1zlyVomkrsQX3ls5M+3AQcxQx5mOWo7rhCXxDpmooptizeXgpmWHxaif6Y36N
 20HkRgt8DAUMMudDCFnoz6lJWHexBNH9pKZSv0yJIvyZN4gzkwj+N6EYMFJGIRJ8NpyJ8CkyuFo
 0yQ=
X-Google-Smtp-Source: AGHT+IF6E4xJCmbLfw78DkEEIgjZZBBeiGaR21nV3+g7iisRR/0qpuaQsL0CDBOdi8rCHPxiZDnokQ==
X-Received: by 2002:a17:903:1205:b0:216:6be9:fd57 with SMTP id
 d9443c01a7336-21c35551b81mr100326535ad.21.1737194702732; 
 Sat, 18 Jan 2025 02:05:02 -0800 (PST)
Received: from [10.4.77.176] ([118.103.63.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d404755sm28507795ad.243.2025.01.18.02.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 02:05:02 -0800 (PST)
Message-ID: <04fd873f-8fe9-4d97-90e8-63177aec4798@daynix.com>
Date: Sat, 18 Jan 2025 19:04:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] checkpatch: Check .m, .build, .hx, .json and .plist
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, devel@daynix.com
References: <20250111-checkpatch-v2-1-db77a522ab6a@daynix.com>
 <Z4pXQYHNOMJ_JPjq@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4pXQYHNOMJ_JPjq@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/17 22:12, Daniel P. Berrangé wrote:
> On Sat, Jan 11, 2025 at 05:07:48PM +0900, Akihiko Odaki wrote:
>> Check more text files: Objective-C, Meson, "hx", JSON, and property
>> list.
> 
> Objective-C looks sensible at least.
> 
> For the others though, I'm wondering if any of the current checks
> performed are liable to cause false positives for these files ?

The process subroutine says $SrcFile will enable the following checks:
- 90 column limit; exempt URLs, if no other words on line
- check for spaces before a quoted newline
- check for adding lines without a newline.
- check for RCS/CVS revision markers
- tabs are only allowed in assembly source code, and in
   some scripts we imported from other projects.

They look valid for most text files, if not all.

> 
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   scripts/checkpatch.pl | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 06d07e6c225c..94ac5230b48f 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -12,7 +12,7 @@ use Term::ANSIColor qw(:constants);
>>   my $P = $0;
>>   $P =~ s@.*/@@g;
>>   
>> -our $SrcFile    = qr{\.(?:(h|c)(\.inc)?|cpp|s|S|pl|py|sh)$};
>> +our $SrcFile = qr{\.(?:(h|c|m)(\.inc)?|cpp|s|S|pl|py|sh|build|hx|json|plist)$};
>>   
>>   my $V = '0.31';
>>   
>>
>> ---
>> base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
>> change-id: 20250111-checkpatch-26ea9d86c76a
>>
>> Best regards,
>> -- 
>> Akihiko Odaki <akihiko.odaki@daynix.com>
>>
> 
> With regards,
> Daniel



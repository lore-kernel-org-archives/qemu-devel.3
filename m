Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7662BC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Knp-0001mz-HK; Wed, 23 Sep 2026 07:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KnQ-0001mN-Ba
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KnL-0004wH-1t
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXmwBO8WeUVAxZzrDYvk2iuQT75ukOg8oVo5OGIccOY=;
 b=FN4IWfXLNP/xv6fHwrEBmvc9MeTYP9HMYRYYpH5JAJF+jmQJjX9PQnO6iYgjGziJyYaotB
 Zh2Srqkl1MkaAkwbQX54IvMdd/IzWZQIa69rZYJ9mCUrISsIbsF4++YPerb0rnYVGuNW1R
 KG8GHxG14oP9NQ2t+YApGBNvZZa4EWk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-m1mu1SOPM-2gUAXRKnkn1w-1; Wed, 23 Sep 2026 07:05:43 -0400
X-MC-Unique: m1mu1SOPM-2gUAXRKnkn1w-1
X-Mimecast-MFC-AGG-ID: m1mu1SOPM-2gUAXRKnkn1w_1790161542
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e73659ac5so11542735e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790161542; x=1790766342; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UXmwBO8WeUVAxZzrDYvk2iuQT75ukOg8oVo5OGIccOY=;
 b=VtZiyLa5qf70AJ3kvvGarr+/Pam0YBnIWLImHH5Q+uiIZgrvd7wIMotzrkTPFeBvKI
 J+JwfIvMinRHzUS7Bb881NIySE76ie2RVKsWCpM3OsimrYC5IkrWqzmrOjOKTVqATKoe
 z88gjwso0Sn1VWHYprjA5xz8viRUA44uF7nk7Db+1bq09mswfNNvenjD8fhLyZ7W5477
 9ck80mvEQHjGAARTXzyPb0zorpHCoduoyG87BJ3BuvWDbiRam1M/aeLwfHb1DbFfIODu
 9vtF3BxNltESxJ21CW11u0llbFYDKmDPZh7NUESPfD1OMFU1BfbtjeB2IA1p+lfIT2Cz
 yT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790161542; x=1790766342;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UXmwBO8WeUVAxZzrDYvk2iuQT75ukOg8oVo5OGIccOY=;
 b=hGp9wodizWTi4QdX+xamFYjY43S6HwarykVS9Gfiq5ThEnRu5ZG3/BMhbDISjevnZA
 v6Si87jg82lH3SJggTHUvWGNGx7UZDzM3Cf4yyrWXCHLEXIi3waJjKh4HPceGhzYwKZt
 mxBepQvgWrEy9cO+QTS+lVh1xBR1xPyRrx1dSG+39EuTQqUvBa+G/U010blTdL5tBrn8
 rIqGQF4LOwbSOkBPacA7pkzq3ReiKVgfc2o3b5ysT90hf6364Fmzcoanev8U9Rgjs+8H
 QLlWeS99t9tb06gGYTZpqsFOxg8RzcQDoDuuug/xqlHkFZzCLzRFjZqYyEy3jQK4wnDj
 tfWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzIMlK8CgA7SqJHB6Fx7hfFngMOgV8crjqDR4AhsmEmrAlhwvleSF9xEs2D2FhjVw9D17geRUkMtjq@nongnu.org
X-Gm-Message-State: AFuF++mStIf8I93Hbbgk1ohsc7ZqwxlVQ9qI1rjXqFuCH80E+WYgTmr/
 26ABDEyDVi4sYG7bx8AwQKL/KD09xqQkgJneUdo1nEi17M5L6M7mlkXgsd381k0nduDRqTe++iC
 cfAghwZMA0nYQZYRGZtmlsnDrVsdmNIH9DvGOQ8I2tzy9CBP+vvtKqmQo
X-Gm-Gg: AYBFou02UaUZYVNIMu689o0vGEQy6IXxXYaggMHMdUCUnIHntobJf6VWyye65oxSkzU
 l1J63QhAcDaC3Z5qiUMgwU5JcsuiLvLbnGLVB7xkGPR06z/KBUg+dJSHebh3PN1hG/miPrQdAKV
 ERUfKdf0xRfMxZKNyvo9zs/K7RAgTADVKndcFHKFYNmZoo9iK9dO5B/8cstNq8GACoWiJfYzX5s
 qkIVJKu5VrLghmYSB3lPc+zTJqTZVbtEEeOlCJlZkUcC7/xNHocTGuuAw7phk/8niFUetWHYaot
 MeFsoa7wszczUuWWM5PsmiKq8nqtsn4Kmei1Gu+Oi2H3QJYjmNC8F6Z4sDBnx29PiLSc66X82Y0
 0Vw/ooLKEN+/C4PguGQUvwhX1Npu1doq30fT7DhSMVH5CGqKGeGmXHQlrx5CBapYgWdtHGhazAt
 A3HAsOceAj+lzPMFZ+WvjwEio5OtA9kQ==
X-Received: by 2002:a05:600c:4e44:b0:49f:ce73:5e95 with SMTP id
 5b1f17b1804b1-49fdf34b3e0mr30793445e9.35.1790161542124; 
 Wed, 23 Sep 2026 04:05:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4e44:b0:49f:ce73:5e95 with SMTP id
 5b1f17b1804b1-49fdf34b3e0mr30792735e9.35.1790161541671; 
 Wed, 23 Sep 2026 04:05:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d749:526e:3864:2ce3:24f2:e6d4?
 (p200300cfd749526e38642ce324f2e6d4.dip0.t-ipconnect.de.
 [2003:cf:d749:526e:3864:2ce3:24f2:e6d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889376sm5089674f8f.33.2026.09.23.04.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 04:05:41 -0700 (PDT)
Message-ID: <0d45c606-3120-4463-b885-7264e92ff7c5@redhat.com>
Date: Wed, 23 Sep 2026 13:05:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] block/accounting: Add BB field to latency checker
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow
 <jsnow@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-6-hreitz@redhat.com> <arJxKg7414J7WnRD@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <arJxKg7414J7WnRD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22.09.26 14:14, Kevin Wolf wrote:
> Am 31.08.2026 um 15:52 hat Hanna Czenczek geschrieben:
>> The BlockBackend reference is required to be able to generate the QOM
>> path as part of emitted events.
>>
>> A weak reference is enough because BlockAcctStats is tied directly to
>> one BlockBackend, and will be deleted via block_acct_cleanup() before
>> the BlockBackend is truly deleted.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> The subject line is a bit confusing as there is no latency checker yet.
> Should it say "to BlockAcctStats"?

Oops. I fixed the body, but not the subject. Yes, it absolutely should, 
thanks!

>>   include/block/accounting.h | 3 ++-
>>   block/accounting.c         | 7 ++++++-
>>   block/block-backend.c      | 2 +-
>>   3 files changed, 9 insertions(+), 3 deletions(-)
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 164bda846f4..ca091a8bf5d 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -369,7 +369,7 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_perm)
>>       blk->on_read_error = BLOCKDEV_ON_ERROR_REPORT;
>>       blk->on_write_error = BLOCKDEV_ON_ERROR_ENOSPC;
>>   
>> -    block_acct_init(&blk->stats);
>> +    block_acct_init(blk, &blk->stats);
> This is the only caller. I'm not sure what other callers could look
> like, but now that a BlockBackend is required for it, could the second
> parameter ever give any useful additional information (as opposed to
> block_acct_init() just accessing blk->stats internally now that it has
> blk)?

I mean, to me personally it looks a bit nicer this way, because it makes 
it a bit clearer *what* is initialized.

But you’re right. Functionally, there’s absolutely no point in passing 
both, so I’ll cut it down (depending on what the next version of this 
series is going to look like…).

Hanna



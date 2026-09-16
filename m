Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53660C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ktX-0002ZO-DX; Wed, 16 Sep 2026 04:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6ktW-0002ZG-67
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6ktU-0000ux-JO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789546887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGeYSlCdtXd2a7KFnNvbzzuAVmS1KQhOtuQO/61RVRo=;
 b=D/iq7OBlDo/zNOBVq836MtTH0GGXxKVqNrovMH8xoLmLOu3/bqsrk2HMFPWYHI2SkX+tPb
 UvvgBfNw/xQpa66KKKRR6sB5Hf9GgbMX7BQluY8DgqhcY9wJ5bO0kakNaiosMCWxbmu8k/
 /HioSbTK6C9jVP2SjUAUlmlffxa8jLs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-KwqfYHYoO3unVP1N3gnwJg-1; Wed, 16 Sep 2026 04:21:26 -0400
X-MC-Unique: KwqfYHYoO3unVP1N3gnwJg-1
X-Mimecast-MFC-AGG-ID: KwqfYHYoO3unVP1N3gnwJg_1789546885
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c29959eb71fso360624666b.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789546885; x=1790151685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SGeYSlCdtXd2a7KFnNvbzzuAVmS1KQhOtuQO/61RVRo=;
 b=S8uh2nSZbsxCRopaqEHEBzrvvFaNk/LxaJdfvFLQPSr+2VDeuRbherj/4yKAWXFlc8
 A42/wXw7lULW2SN4bHkSwg7UlynIXG28rELl4XDCBf5w1mHxvYP76Xn8Cwol8GayvR80
 23qsYbFL7M0XePKwU74o6NxlLnTZtc0GNqJF5g+riwiPPoUvwEe50RuQOhvOCqDlIoEx
 /CB9dwQE92xXo901uF0+xUoc39f73PXrIV2o4DfWHyG7mykF+BFuaCaAIctF49WAaJw3
 LgWNGkAFEWhce3psW799svQkcnbq4O6Tx0mZcF5ytcZKBjbH+ZIWo3ad/9L7TUDR9sL8
 wFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789546885; x=1790151685;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SGeYSlCdtXd2a7KFnNvbzzuAVmS1KQhOtuQO/61RVRo=;
 b=kNP/mJwr7DEOmxtwnldIxLm21S9/CLXS0Nk/4X7n7p6ilBAABdDlrH0HEfh7t8N3ns
 lno8hoOgBrzHG4CrCwyNYNHalcfJfmtRMCbf+jSLLckRz6KU8jVw5083fGUUV476xGzw
 3HediIikoNAezTzOiMu7s3OSe56KGD/bzxa40tIUA2cQn3gDjydl/HgiTgylDpj6PJmf
 VTB8/u6nMZvLiJKpQYRa1BB1oM+90guK0+25jX0OCnTL6NT52iBhybS6RV0E0i6pUOkI
 uVr448RrdSQv/nhWG4CYVTOSD/F1PWRJucWzcCdoARMUz3gckX2tngvZ7jLfVDhjV/Pg
 bHQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAwWlwldiKbRK6DFzLDq9ohUeD4208Q087mAhq/kYuDbiItc8fRwLahJr52gRcpicezULPIXbTD/he@nongnu.org
X-Gm-Message-State: AFuF++k8lBgoc6HT+wTg6DPR/z3ulE61DCe/SjMyaiojy9Yz/Ie3l9Us
 E7R4EwivArKcuiTNkT0jBNT/BIVcMjmmDCRvOaTxRCiJ3pJgdT6+dECbulZHHNHVF6ZOIGghrUv
 umuBgwzc7PMkdGWtMmdryNSaMDGD4NnGB1V6hvSLKp8+pmkjiLDtf3gON
X-Gm-Gg: AYBFou34SW7TVtE77uaCdsjsvkcXdDWoVK6mnjGhuVaSmKqBHIdrWHT3oD3d9L+9fcf
 6H053oTFntsi2xZUxAiNNiEJTuwpMMpP/zzP+6mculjSEP6IACosL5xVNqrm8FWMNuwenBPBc81
 0Th9IvO01Zx0gXKVwp5CHdV76R+CrTuIY+W6mir2qQ7qRNVCDChmUAr+5cyEb1FHwnnu1wBV/xC
 Hr79e9vDfnoLcpQDh2LQCLGFmxbX8muKERO0b146nNNo+WYcU1wzcymVbCWIJ0QCDx19jrlTJev
 WywW4xcvfwI5USQN9a9TPnkvJMwA0MB/1dMWKeA9jmhnzGxeDJ+BeKyYinHz27END75Cv8Azqgx
 3oAxmy+hFU15dobOIQrHl5q7oeBLBpbRD5ZnUI7fD7dEerL7Yz1yd+5mdjtynwCOb8Zc+05GUVR
 aD3StKLVxxAodPmR6x3TvQldk8WaQ=
X-Received: by 2002:a17:907:d64a:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c29e51dc0ebmr100261566b.1.1789546885071; 
 Wed, 16 Sep 2026 01:21:25 -0700 (PDT)
X-Received: by 2002:a17:907:d64a:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c29e51dc0ebmr100259166b.1.1789546884656; 
 Wed, 16 Sep 2026 01:21:24 -0700 (PDT)
Received: from ?IPV6:2003:cf:d704:f6c1:9398:5dbc:cc8:753b?
 (p200300cfd704f6c193985dbc0cc8753b.dip0.t-ipconnect.de.
 [2003:cf:d704:f6c1:9398:5dbc:cc8:753b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de5bb4acsm80120666b.41.2026.09.16.01.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 01:21:24 -0700 (PDT)
Message-ID: <292ff2f9-b3fe-423b-9b36-ada26904a617@redhat.com>
Date: Wed, 16 Sep 2026 10:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] block/accounting: Move latency_ns override down
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-9-hreitz@redhat.com> <20260903150842.GF825275@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260903150842.GF825275@fedora>
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

On 03.09.26 17:08, Stefan Hajnoczi wrote:
> On Mon, Aug 31, 2026 at 03:52:04PM +0200, Hanna Czenczek wrote:
>> I am not quite sure why `latency_ns` is overridden by a fixed value in
>> qtest mode because personally, I find it much better if I can
>> individually change requests' latency by modifying the qtest clock.
> It looks like tests/qemu-iotests/136 relies on a hardcoded constant so
> it can check min/max/avg against known values.
>
>> But I'm not going to change existing behavior for the histogram and
>> such, so I will just move this override after the latency has been
>> evaluated regarding a potential BLOCK_IO_DELAY event.
> That's fine if you aren't taking the same testing approach as
> tests/qemu-iotests/136. I think the benefit of hardcoding the value for
> testing is that it would become possible to trigger the latency
> threshold without worrying about timing in the test environment.

FWIW, as far as I understand, in qtest mode, `clock_type` is 
`QEMU_CLOCK_VIRTUAL`, so it is not dependent on the test environment 
anyway, but on the qtest clock. That’s why I don’t understand the fixed 
latency value, but maybe it was just easier this way for 136 because 
this way it does not have to do a clock_step for each request.

Hanna

>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/accounting.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/accounting.c b/block/accounting.c
>> index debf1924455..223becd2e04 100644
>> --- a/block/accounting.c
>> +++ b/block/accounting.c
>> @@ -271,10 +271,6 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>>       int64_t time_ns = qemu_clock_get_ns(clock_type);
>>       int64_t latency_ns = time_ns - cookie->start_time_ns;
>>   
>> -    if (qtest_enabled()) {
>> -        latency_ns = qtest_latency_ns;
>> -    }
>> -
>>       assert(cookie->type < BLOCK_MAX_IOTYPE);
>>   
>>       if (cookie->type == BLOCK_ACCT_NONE) {
>> @@ -292,6 +288,10 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>>                                          cookie->bytes);
>>       }
>>   
>> +    if (qtest_enabled()) {
>> +        latency_ns = qtest_latency_ns;
>> +    }
>> +
>>       WITH_QEMU_LOCK_GUARD(&stats->lock) {
>>           if (failed) {
>>               stats->failed_ops[cookie->type]++;
>> -- 
>> 2.55.0
>>



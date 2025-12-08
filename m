Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC60BD3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 08:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSWPQ-0003wV-JS; Mon, 08 Dec 2025 03:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vSWPM-0003wA-K4
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 03:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vSWPK-0006mm-Cg
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 03:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765181744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LQEXz4MctcExFg5LuesnAZe2yjS2Chh2qubrSZqowWQ=;
 b=B/mNkhRC4IIN2E9zWQueiE5hcRpYJVOdEtrqmG/nkkGIDVR3N1UZHu6CKmfk/3QrgLhh8Y
 kSpik0pCz8cXtsiqtxvT3800ORueRA8MVi9abPn5M2chEZ1OUXYOi0c4N6l8sjZCVuLlZ1
 j9NVfpAi1eO4IVFVZWYj8uit+ixEGTs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-5nvaYMNJM3yN6bsVemthvA-1; Mon, 08 Dec 2025 03:15:42 -0500
X-MC-Unique: 5nvaYMNJM3yN6bsVemthvA-1
X-Mimecast-MFC-AGG-ID: 5nvaYMNJM3yN6bsVemthvA_1765181742
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42e2b9192a5so2004293f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 00:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765181741; x=1765786541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LQEXz4MctcExFg5LuesnAZe2yjS2Chh2qubrSZqowWQ=;
 b=sbNHL7wDuwtY35DsE2G2ZTbyoEIpDWvXR6DkVMYUsNwbNI+ULRmrguiqWUq/IO8B8a
 PhUqSZIAHW1wwFr6k3Tl61+4Rfni08XZruoph43vUHAjc1gTIab7SfTEY3jDULq4WAVn
 5lBAnO8XxBQGgbNooWfNXybcCps9eEL2eMRPdaK7CMFhZFWm02bAPStT+Cyv5Od1mlmZ
 rUGHyNjKmi0HThYUfXkOqH0BMpgXnuSQzmRJ6OS1BswcVhxMi8ba9pv7daSve5gaZo/0
 13NehfqnFmr/W6+UVONi1QG5G9Q0HWHnq4viwFhOVE7QxdoRDT4r+1o/BvUGviKC6OOz
 HFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765181741; x=1765786541;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQEXz4MctcExFg5LuesnAZe2yjS2Chh2qubrSZqowWQ=;
 b=QWnNx9sdYfOvQTTeK0Uri8Mr6MvdnnSShF4tJCgUtc89bmQCFzeKbQyJRIIaeXsP1W
 yFBpcaMgXCiVpCIKErzaSZWOBGQeZwdWna0waNqwKUqOSzIadyyolh8S2oAMa5Y2shtf
 DdEeuuGIHLqbMn/VqALLINa8AIjQUy/qGzBtLy1X1Mwf2Pchjz4oQ2axr420vHQAoGhr
 lBs5dH0FL8ZcUD1UkURL70AKFlxS8OIM3mV6WrPqEVbN1DtNHXeQDyjm9VH363pkmVAG
 dRq72rdAtRtbeLOLJ4XiNgtGxF1m7pzIr8HWacQM2YU86B37/v0TSi2Ziik5mJx1n1JC
 6/ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWUm15vnDTUdffkhBQ1murgfucuzfpE2+cztwJuMby1gwnv3LTBf+A1Rx2FeAxXwvwMZoh33j5cLuu@nongnu.org
X-Gm-Message-State: AOJu0Yw2rUBzimeBWzVU1At/6iVN93SrSP4G4BKMYzOrt1TYMMygvaR2
 RKaVTdZFekLj9xmM16ecGQpwM2xCw/gOqy/wHi1qD7YUGCSqCSudQ0r9kg3B6YSzmOHQs9fVe/0
 qWG+44bSwdlzEfTvTTY9mGforvQ7+Fwnv5XUtOX7fRPu0zx+faMtfgWSD
X-Gm-Gg: ASbGncvs9PZLMhWQ6p0TntEo558MCbBn2gR20bqU5rCtmQcSQ9YIQK+SZqBJxsoc0DX
 Qfi5QqgOe2/aXJw3NKz6fSgjxC+jliHrWXREO8aTB7IbGgfa5wMvXmK5xHRseOm7hmE1Je0pSCQ
 Mvi38JQC2AIRixp/yVv+24MDQ0jD7T+wdZWeByjbWguUp22Pp39R3zhsZbe9elvG8KgeO/eZkiX
 9TbubLPt76aZYWBWO+Kyzn/KaAz0vxh5kwCeiUcmqvLcF8i5d7X/BKFaL7YYStCagZ455mx905g
 GBd26496HvRFTSUxlqHVE8YGeFR+ZHTXjvimVvrioXPUcUhkUcTZuS9xcfji3cPfpyvh/BVQcz8
 aK8T7+Ak=
X-Received: by 2002:a05:6000:178a:b0:42b:2e94:5a90 with SMTP id
 ffacd0b85a97d-42f89f4851amr7212628f8f.36.1765181741571; 
 Mon, 08 Dec 2025 00:15:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnyUG8Qilp/zdCy4wuCGAZRfS9Mk530/husComO6AEcZQYDdZ5wsYVMtls3HGWpZSN63BkqA==
X-Received: by 2002:a05:6000:178a:b0:42b:2e94:5a90 with SMTP id
 ffacd0b85a97d-42f89f4851amr7212603f8f.36.1765181741152; 
 Mon, 08 Dec 2025 00:15:41 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee66sm24116014f8f.11.2025.12.08.00.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 00:15:40 -0800 (PST)
Message-ID: <6333f8d4-3feb-43c7-8d11-98a7c3cbe0c4@redhat.com>
Date: Mon, 8 Dec 2025 09:15:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qemu-iotests: Check for a functional "secret"
 object before using it
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 qemu-devel@nongnu.org
References: <20251205130014.693799-1-thuth@redhat.com>
 <aTMUQXOjJO0EiK8b@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aTMUQXOjJO0EiK8b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05/12/2025 18.20, Kevin Wolf wrote:
> Am 05.12.2025 um 14:00 hat Thomas Huth geschrieben:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> QEMU iotests 049, 134 and 158 are currently failing if you compiled
>> QEMU without the crypto libraries. Thus make sure that the "secret"
>> object is really usable and skip the tests otherwise.
>>
>> Reported-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index e977cb4eb61..10d83d8361b 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -1053,6 +1053,20 @@ _require_one_device_of()
>>       _notrun "$* not available"
>>   }
>>   
>> +_require_secret()
>> +{
>> +    if [ -e "$TEST_IMG" ]; then
>> +        echo "unwilling to overwrite existing file"
>> +        exit 1
>> +    fi
>> +    if $QEMU_IMG create -f $IMGFMT --object secret,id=sec0,data=123 \
>> +                 -o encryption=on,encrypt.key-secret=sec0 "$TEST_IMG" 1M 2>&1 \
>> +                 | grep "Unsupported cipher" ; then
>> +        _notrun "missing cipher support"
>> +    fi
> 
> What is the thing that you're checking here? If it's really the secret,
> then just running 'qemu-io --object secret,data=123,id=sec0 -c ""' would
> be enough. If it's not the secret, but encryption support, then the
> function is a misnomer.

The "qemu-io" statement seems to work fine in that case, so you're right, 
it's apparently not the "secret" object, but rather the "encryption" part 
that is failing.

So shall I rename it to "_require_encryption" ?

> _require_working_luks() looks pretty similar, though it requires
> specifically a working luks driver. Could something be unified? (The
> answer might be no, but it would be good to explicitly say it.)

While it looks a little bit similar, at least for me it still looks too 
distinct for unification - or is "-o key-secret=sec0" doing exactly the same 
as "-o encryption=on,encrypt.key-secret=sec0" ? ... I lack the deeper 
understanding of the parameters here to judge on that topic.

  Thomas



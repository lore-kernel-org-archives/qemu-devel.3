Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E4ECCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 10:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPfp-0007mX-0B; Thu, 30 Oct 2025 06:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEPfS-0007if-Bm
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEPfG-0003Gt-7u
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761819231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=28AB/AFfKKTC/kTU5L4l44DF24ii6kpb5ZvJpk7h51s=;
 b=LeYv3PwkYHGQIKsqp9qvlymB/AIkmX41Q5f7qVzgWc5UJRzDu1VwvHEOqRD5IK8ytBz64Q
 4bNaSrPZaYnkIK/+2z6L6tbTVt7NG4LfKVIQM3WRKw/ccwS1zXA9YwKUn0VI4Ony/0Hc5B
 /T4+SJkEoPDmL8e4LlIQ6mk09q2ZFnA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-aoydGvQNOduIdDljZVAMxQ-1; Thu, 30 Oct 2025 06:08:44 -0400
X-MC-Unique: aoydGvQNOduIdDljZVAMxQ-1
X-Mimecast-MFC-AGG-ID: aoydGvQNOduIdDljZVAMxQ_1761818923
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-475e89435e0so2372575e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 03:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818923; x=1762423723;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=28AB/AFfKKTC/kTU5L4l44DF24ii6kpb5ZvJpk7h51s=;
 b=unCLujp3sZJJU55P7CYckiZT3nTxeJ5EOo6ltD6tKZwoBJ0YLkqQfQf27GQkF8Uohi
 CJQg5dAstlUY+QWikGaQgBIYM/rbYDTIiBYjP35sWcNmTvx5c0tuRB8ko/+QHXI0m0Ds
 zHG5QziLiiz3o1wuuZxTgvNlOTniGmgln4K9IC/W9Va0sj6h60I2tq8clEgypR4tY3D5
 AAIoc9saGGTHpDVzNLBDPvC4mhJOF7YX2rL6f3BJ7QdhmIV0AUU9ZH9JWQRtsO8reR8C
 9kmNrBfFijmNhI1XhMnt5cPueEx95EEFayHi3j2eg5TH4pBdNpg143QQa4yPoupKydYw
 EDfQ==
X-Gm-Message-State: AOJu0YyZ98kLMOtE54/JKOZbvwJN3RyyDwDAcLD5IiBDfohAtpoga63/
 URS7cnpHFnBHeoK1KFAg2EhibcoIH47RcbMw6p4jNacAl56atvYl3Yoqdm5peECrd9kKYIpXU2O
 DcUGNQzQYqhJqUwerT0MOMNcviG31vXxbS82E87EiGsAsu0+yW9VCitfB
X-Gm-Gg: ASbGnctxprj/W8rZpHmun0qGlbRXAG05raW9oNE4psKXuIXVw7sHhoDJvvJfT1iggVO
 f4c9jwrqrycmlVk/WMw7PGYbf9ko6mJj/IJAEgxYck1gkMHTOog1jOz7CkUobHe9EMiYpuduVed
 bRA15QGntmZYAHY6K1CkJ5QSNxsRve0TJQNOdEqLXFvgtMTd4HgbJcQa/MKB6Fd5JyYJG/I3OpU
 oiBpW/qUp1u4I0ZXc5XzXUZFOerNqfchgPIu9+UGmbe1Ux/5K62XxEEtPAkePNCEmkeWt4HT8Q4
 9RSycZX19bprZwoNvRMAlXxAS5LLbbnLwE035mq9EJoHrMPqktD2IDghyJtvkUeXxvERfjg=
X-Received: by 2002:a05:600c:620a:b0:477:bf0:b9da with SMTP id
 5b1f17b1804b1-4771e1cac54mr62660745e9.19.1761818923405; 
 Thu, 30 Oct 2025 03:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj9mwfGEXiW+/dJhPzmQYwkd2wgx5+e960AKrbFVfEzfHq4Y4Io9zVTAjuuEPyjESO4ioCng==
X-Received: by 2002:a05:600c:620a:b0:477:bf0:b9da with SMTP id
 5b1f17b1804b1-4771e1cac54mr62660495e9.19.1761818922951; 
 Thu, 30 Oct 2025 03:08:42 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289b0dbesm32268915e9.5.2025.10.30.03.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 03:08:42 -0700 (PDT)
Message-ID: <58979253-80d5-4dab-a984-f71f50300c2c@redhat.com>
Date: Thu, 30 Oct 2025 11:08:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/vmstate-static-checker: Fix deprecation warnings
 with latest argparse
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Amit Shah <amit@kernel.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20251030092638.39505-1-thuth@redhat.com>
 <aQMw-AO720PNFzWW@redhat.com>
 <7e315a0a-5876-4816-8db3-fecbe2b1ebaf@redhat.com>
 <6b52e145-8732-413f-a3db-6e5abf1eb70b@redhat.com>
 <aQM3cNUN1sxyUCJr@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aQM3cNUN1sxyUCJr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 30/10/2025 11.01, Daniel P. Berrangé wrote:
> On Thu, Oct 30, 2025 at 10:45:32AM +0100, Thomas Huth wrote:
>> On 30/10/2025 10.42, Thomas Huth wrote:
>>> On 30/10/2025 10.33, Daniel P. Berrangé wrote:
>>>> On Thu, Oct 30, 2025 at 10:26:38AM +0100, Thomas Huth wrote:
>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>
>>>>> The argparse.FileType() type has been deprecated in the latest argparse
>>>>> version (e.g. the one from Fedora 43), now causing the test_bad_vmstate
>>>>> functional test to fail since there are unexpected strings in the output.
>>>>> Change the script to use pathlib.Path instead to fix the test_bad_vmstate
>>>>> test and to be prepared for the future when the deprecated FileType gets
>>>>> removed completely.
>> ...
>>>>> @@ -393,10 +394,10 @@ def main():
>>>>>                            help='reverse the direction')
>>>>>        args = parser.parse_args()
>>>>> -    src_data = json.load(args.src)
>>>>> -    dest_data = json.load(args.dest)
>>>>> -    args.src.close()
>>>>> -    args.dest.close()
>>>>> +    with open(args.src, 'r', encoding='utf-8') as src_fh:
>>>>> +        src_data = json.load(src_fh)
>>>>> +    with open(args.dest, 'r', encoding='utf-8') as dst_fh:
>>>>> +        dest_data = json.load(dst_fh)
>>>>
>>>> This could be
>>>>
>>>>    src_data = json.load(args.src.read_text('utf-8'))
>>>>    dest_data = json.load(args.dest.read_text('utf-8'))
>>>
>>> Does not work, looks like the load() function cannot deal with a string:
>>>
>>> $ scripts/vmstate-static-checker.py -s
>>> tests/data/vmstate-static-checker/ dump1.json -d
>>> tests/data/vmstate-static-checker/dump2.json
>>> Traceback (most recent call last):
>>>     File "../scripts/vmstate-static-checker.py", line 439, in <module>
>>>       sys.exit(main())
>>>                ~~~~^^
>>>     File "../scripts/vmstate-static-checker.py", line 397, in main
>>>       src_data = json.load(args.src.read_text('utf-8'))
>>>     File "/usr/lib64/python3.13/json/__init__.py", line 293, in load
>>>       return loads(fp.read(),
>>>                    ^^^^^^^
>>> AttributeError: 'str' object has no attribute 'read'
>>
>> Ok, there also seems to be a json.loads() function (with "s" at the end)
>> that seems to do the job ... but IMHO it would be better to continue using
>> the load() function here to let the json parser decide how to read the file.
> 
> ok, I don't mind that much

I'm basically thinking of situations where you have a big dump file: When 
using loads(), you have to completely read the file into memory first, maybe 
using a lot of memory. With load(), the parser could digest it bit by bit 
instead, and e.g. bail out early if there is a bug in the json format of the 
file. Well, it likely doesn't matter too much for the file sizes that we use 
in QEMU, but still... I think it's nicer with load().

> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks!

  Thomas



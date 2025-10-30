Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD601CCF9F1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 09:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPEG-0000Ee-9m; Thu, 30 Oct 2025 05:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEPE9-0000Do-Fq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEPDy-0007xp-7N
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761817537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9wl/byNpooaOfvgU62aGelOq0QuDu/deo/1/Vwr9rwY=;
 b=JDWy1vpsD05NScTXGVvH1nFPJzCdpxDZH36mTiPe7gkQN/7AD8ONsfYlf6q3wewwJmMrrf
 o8R0OUsIueYjz2UcK+24c4iHRznaPPBjuAZ89I70F27/pWSnUqZ2BYdI8bovN+tfST/k1D
 FWJgahAiX/iRGB1seJuzYGfYmrXlCp4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-p6q8Ab-wMFqkkPFIWevdPA-1; Thu, 30 Oct 2025 05:45:35 -0400
X-MC-Unique: p6q8Ab-wMFqkkPFIWevdPA-1
X-Mimecast-MFC-AGG-ID: p6q8Ab-wMFqkkPFIWevdPA_1761817535
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-471168953bdso6834515e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 02:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761817534; x=1762422334;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9wl/byNpooaOfvgU62aGelOq0QuDu/deo/1/Vwr9rwY=;
 b=ZWNeJn+ayj88av1qK+Wk43aoeeWTW4sZ+ypHXitcQcJ7SJOvTICZyxZF0uK151BC/k
 7iWbqTyqdl4Rdt3Sf7zkp6cKIDNfXruJnLLELH5cwbFOqvF3USmbf+pxvBwkOhUXpSDJ
 EHBVq1E1k4cV5E7aNzZUgMuwsOXIbBykBogTmr+34ZCb0cXGfecWQ3vpZ1cRInty3VjG
 +ida+e8F5Y8Zc+mDoN7DOa5Msk/wtSoBUQC7YHxQW/nZKII3cR6awCh1Ko4R3WWmCIme
 wmCGDdMGSpBEeC59FM6vUv0/vvGdH1zOeVXQUm32uCODWEWIPxvO137/arh6KnNYetXG
 sfBw==
X-Gm-Message-State: AOJu0Yx0y3n5WlWR50OfwiEAuJT1W+UtpyXw924aw3DKq6csbhTQ/apG
 eZVE02Wbc7U0pvZywitK/hv1uBNUdhmT3U1wwedP1A5kMscwfTmIJxoErKL1uL2bB1q/qrYUSgB
 G5DJDH7tPHXO3mSo0q7jx4eQ3rY7kB2Vbn6NT3Xfm8sjw5X5DCtFDBmEb
X-Gm-Gg: ASbGncs7Ww3p4IdUq6iIl1n3Ylua0nMdgLEU4CcTxLhMIlr+asKkFB7+lt4HNiWjGtV
 pQ2sEERilr9LY9p6bl0WAsHEIBmIOd+RZYHujCSY4P6oHDVGZNWyXYtD3FStDzrmf0u0JM62SV5
 Zg/IpHDRRaHyZmm8ypWvEgCtg3gw44UtBIwjEh6UpeenHFK/voEq9LE84Z9d9aC5RDCupdFBLg0
 jEg5GRXIyrFIABI8CaLjctNsy7v6B57iKF1YwFSqgBES1kJMimLoNT4mLphz/zeO5d2V5cSabWT
 hcJQls8NcSj1O1IHhMapL7tpm8unzxYixO9tY135ReFVzo9n6yu0Kd8fMgVBVYHw0iCERpA=
X-Received: by 2002:a05:600c:6299:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-477262bc2edmr24863785e9.16.1761817534511; 
 Thu, 30 Oct 2025 02:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQzoA52x3bRk6TBZ5RQAB/m9Zw2AQTJ4vCPURXZRqQw8ZefviUSbhgFg9rBwaLVgTXCbyeuw==
X-Received: by 2002:a05:600c:6299:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-477262bc2edmr24863555e9.16.1761817534076; 
 Thu, 30 Oct 2025 02:45:34 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289adc18sm32972785e9.6.2025.10.30.02.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 02:45:33 -0700 (PDT)
Message-ID: <6b52e145-8732-413f-a3db-6e5abf1eb70b@redhat.com>
Date: Thu, 30 Oct 2025 10:45:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/vmstate-static-checker: Fix deprecation warnings
 with latest argparse
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Amit Shah <amit@kernel.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20251030092638.39505-1-thuth@redhat.com>
 <aQMw-AO720PNFzWW@redhat.com>
 <7e315a0a-5876-4816-8db3-fecbe2b1ebaf@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7e315a0a-5876-4816-8db3-fecbe2b1ebaf@redhat.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/10/2025 10.42, Thomas Huth wrote:
> On 30/10/2025 10.33, Daniel P. Berrangé wrote:
>> On Thu, Oct 30, 2025 at 10:26:38AM +0100, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> The argparse.FileType() type has been deprecated in the latest argparse
>>> version (e.g. the one from Fedora 43), now causing the test_bad_vmstate
>>> functional test to fail since there are unexpected strings in the output.
>>> Change the script to use pathlib.Path instead to fix the test_bad_vmstate
>>> test and to be prepared for the future when the deprecated FileType gets
>>> removed completely.
...
>>> @@ -393,10 +394,10 @@ def main():
>>>                           help='reverse the direction')
>>>       args = parser.parse_args()
>>> -    src_data = json.load(args.src)
>>> -    dest_data = json.load(args.dest)
>>> -    args.src.close()
>>> -    args.dest.close()
>>> +    with open(args.src, 'r', encoding='utf-8') as src_fh:
>>> +        src_data = json.load(src_fh)
>>> +    with open(args.dest, 'r', encoding='utf-8') as dst_fh:
>>> +        dest_data = json.load(dst_fh)
>>
>> This could be
>>
>>   src_data = json.load(args.src.read_text('utf-8'))
>>   dest_data = json.load(args.dest.read_text('utf-8'))
> 
> Does not work, looks like the load() function cannot deal with a string:
> 
> $ scripts/vmstate-static-checker.py -s tests/data/vmstate-static-checker/ 
> dump1.json -d tests/data/vmstate-static-checker/dump2.json
> Traceback (most recent call last):
>    File "../scripts/vmstate-static-checker.py", line 439, in <module>
>      sys.exit(main())
>               ~~~~^^
>    File "../scripts/vmstate-static-checker.py", line 397, in main
>      src_data = json.load(args.src.read_text('utf-8'))
>    File "/usr/lib64/python3.13/json/__init__.py", line 293, in load
>      return loads(fp.read(),
>                   ^^^^^^^
> AttributeError: 'str' object has no attribute 'read'

Ok, there also seems to be a json.loads() function (with "s" at the end) 
that seems to do the job ... but IMHO it would be better to continue using 
the load() function here to let the json parser decide how to read the file.

  Thomas



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8800ECCF9E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 06:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBp5l-0006Rf-Tg; Thu, 23 Oct 2025 02:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBp5k-0006RW-MX
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBp5i-0002bh-3W
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 02:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761201987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kt/dSqpe48+X/Atq//qqV50r7nVjetPTOPvpguzSZv0=;
 b=Pu2BZLwdkfOTCdy0CPX0T94mlcoMzl/JEUHXHqtquiyA9mDnAgIBQpA9tm/+LypVzK1Pd+
 U64ZSZa86flhKlNpsPyKe4dL24u5WB4majjs4Ixoi0Pz+myUFrAJ+QBCRtRwpB+lau5Okl
 28H8GWoXsoY6hGEEPxldLqsMiF4CJrg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-f0O8qtd-NpSmFK4GwwE2iw-1; Thu, 23 Oct 2025 02:46:24 -0400
X-MC-Unique: f0O8qtd-NpSmFK4GwwE2iw-1
X-Mimecast-MFC-AGG-ID: f0O8qtd-NpSmFK4GwwE2iw_1761201983
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-471144baa6bso1663865e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 23:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761201983; x=1761806783;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kt/dSqpe48+X/Atq//qqV50r7nVjetPTOPvpguzSZv0=;
 b=rJdaGr2ZEa7IJfj86W6xMzq6CyoK4kQYFTjluiKDwHx+dqKqv8UA9CPqll0SLDISb+
 vDwOEWpcKi1IhgU2NRXDxP0GCjME69ufNw7mBJ9e31cSkShmhaSsAJdLN3iJQ2BKAKLe
 2l7pCeU21WNN+nZfvj9jKD+pXwNT8iNN8usMvgJAvQf+VkNw4C5iGQJRSjT/7/LqL7l/
 WdbbNPEsBiSEVAEiBUY2lN031OgRiEYXnvJt6mdzqFy5D+8RsxghSzW4AouN9PdjmwE1
 TN4Rl0KBJzAPCmVVLwTqBmWCvbOC332wL9OkE3+1e45yU3qbQGT6XztGEEaaw5RA9laz
 SOxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdFaxwxhWSb7iWim6zRmBqGOGGF0TvydkWcMBUWiiDAQjKGc9P+/FQF1kk0agvE4IumIAyaZBf5Iv6@nongnu.org
X-Gm-Message-State: AOJu0YxTodek252z5cQoa0DdKJCeZ6EbKw7I7uGMqg7Cpwo3b3aOQn7j
 dgFnWhOpN6xLtsKvyACnF80K+zlDxXDRgw8npVan6lfjW3aTUaOyf9db2AeA+bX89uk8IvrnK3O
 XNnqlZy11GciMorvFZAGn2Ca0hvapo51iaj5y/m6vl82tP0MmNgok2bwt5Z7CS2ri
X-Gm-Gg: ASbGnctvZUAYbZARNI0z8Nk81FLng86yK87FbRsAv38A4PxhjybzWPnn2hPgNxcTm8W
 A8KR7W0s9Oi07H+g88wUCbdwu/tBlWF1KlZ9HKBw8t7dhF/FQTdakZKpUZOAcLVKQGak6dySVxf
 l1b2pma0zRl28sqCP7ptpOhScntCzmiDlRXROUl7LakZwGVf1/IRdSRP/Um2jUS0rHVFEP5Ck3o
 KDAVhmC/CRO6ZV/uQFFr4swOyQ7qoqLzHZAA3ux80KTbkeoh2BqwK2rbkVfHK9x5eH0jSfO1OhR
 +2/Jcwq6FGpuLjylMD8spcjscR74Q7Xk9DjKkas6GLEIYP+dhqBq9GmovTZ9PZvdLWNszwG5zuL
 85zDInwl+TK3Y2wfi7kte6DJz97FYvdpsJ8EEaHQ=
X-Received: by 2002:a05:600c:4507:b0:45d:d88b:cca with SMTP id
 5b1f17b1804b1-47117874afbmr150665725e9.1.1761201983440; 
 Wed, 22 Oct 2025 23:46:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqYUMHc/XEp3Nz+kYaXtOve/sA/Fs2vs3nYNvDukyK9iibEb/CKVsjJ4ZK7JgudiGfgHveKg==
X-Received: by 2002:a05:600c:4507:b0:45d:d88b:cca with SMTP id
 5b1f17b1804b1-47117874afbmr150665625e9.1.1761201983035; 
 Wed, 22 Oct 2025 23:46:23 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-081.pools.arcor-ip.net.
 [47.64.113.81]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf2f3bbsm19092305e9.16.2025.10.22.23.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 23:46:22 -0700 (PDT)
Message-ID: <93275cfd-8083-4c75-81f2-46006ee42f00@redhat.com>
Date: Thu, 23 Oct 2025 08:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tests/functional: Fix problems in linuxkerenl.py
 reported by pylint
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>
References: <20251015095454.1575318-1-thuth@redhat.com>
 <20251015095454.1575318-4-thuth@redhat.com>
 <57dc76d3-2a2b-428b-a457-94dcd20cb427@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <57dc76d3-2a2b-428b-a457-94dcd20cb427@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 22/10/2025 21.14, Philippe Mathieu-Daudé wrote:
> Typo "linuxkernel" in subject.
> 
> On 15/10/25 11:54, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Use proper indentation and lazy logging here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/qemu_test/linuxkernel.py | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> 
>> @@ -48,5 +48,5 @@ def check_http_download(self, filename, hashsum, 
>> guestport=8080,
>>                   hl.update(chunk)
>>           digest = hl.hexdigest()
>> -        self.log.info(f'sha256sum of download is {digest}.')
>> +        self.log.info('sha256sum of download is %s.', digest)
>>           self.assertEqual(digest, hashsum)
> 
> TBH I don't understand why 'lazy logging' is better than f-strings.

If I got this right, it's about a small performance improvement: If the 
logging function decides that the log output could be dropped since the 
logging level does not match, there is no need to format the string in that 
case.

But thinking about this, I guess that's not a valuable argument for the 
tests, since we're not calling these functions again and again, so the 
performance impact is negligible here. So fine for me if we ignore this 
warning from pylint. ... i.e. we might want to introduce a pylintrc file 
now, similar to what we have in scripts/qapi/pylintrc or 
tests/qemu-iotests/pylintrc already ?

  Thomas



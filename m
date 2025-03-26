Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6A4C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRow-0000Qm-Ut; Wed, 26 Mar 2025 10:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txRov-0000QB-8X
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txRoq-0007KF-As
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742999601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KiGFq7AVuL2kMauf8gjCT0P5qCrw4Pw3G5WtexNXvLk=;
 b=FS+6OuF8jFAeUcVQst/0JNMDRfqj/T1/hE6AiYvZz7oiAoZsWAvo78Vr04vr/fqh4DKC7f
 cXkGJAO8wb6wTAZhooJemZrOaf4t2/Bfpb1gTOuscihDc5t8PKBaRtYVizasAKP9IMR0UE
 Jw5wER3cmSgnSLJXJn7ifL5Kg3T9+0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-_p1zC9kVMQeOODHz7QpuAg-1; Wed, 26 Mar 2025 10:33:19 -0400
X-MC-Unique: _p1zC9kVMQeOODHz7QpuAg-1
X-Mimecast-MFC-AGG-ID: _p1zC9kVMQeOODHz7QpuAg_1742999599
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so55745905e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 07:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742999599; x=1743604399;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiGFq7AVuL2kMauf8gjCT0P5qCrw4Pw3G5WtexNXvLk=;
 b=GQZlEkD0azo+n93gLwvQLP0WeuCL2DqXJErQY94NOJgdIXqv44qW1+v+y0veblR+vS
 0/CpZ4Wl9Fu3CDwtRqdmcFsRByTYMfE6NY7T6LQqHmGevr6c1LbXEFb5jZq7i/HH9ZtT
 QRxC7QM4n3FQY94AqAOmVIVZFhu9sDau8+g8pnBzsfDZy0Ci2uha+ma8OcxVLN/kUcMu
 9Sp4uJSn7HuROXyMll5SnqbCO0FRg4OdGYKPCLifNlX9p+OAl+gcP+zR0NDXN3k+moB2
 SdX1cMlAKOArgqJxfSCEzFclf6R1PEcVfIEisgsJRKVCQURbhcmLoTernr2U2Mf0h2b7
 TZiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNFGyoPo2qxnnq3zhMwPU35uqMLTqD4Mh0K5MZLpuIKUd4W5Mx41RM10IdAy0q+qHogY05W3BckRd0@nongnu.org
X-Gm-Message-State: AOJu0Yz/9SClEbld9LcbMPbBXFrebmJIgWXge0rRj+KjxXZM/g2OucaY
 eh8DjsJAgXDqDB/FTyvBsyZx5tOxcndqCU5ahqZHUbwi1LYp+id192S+NBGxtN+RJVRcWCtQHGy
 PkTN0pyWtfermKzBriX794fsh+a0V9Mg1RbKDmw3G8APW7JoOiwL0
X-Gm-Gg: ASbGnctVA1DSwMgDzACifUlu0IAFR+m6A0zxaZbGmnUq+hPUb/BX+ubPX0KOkMOE1sx
 NksGD9Ec3G7I4heaVgiH6ZY+g/an0CQTKEQwFyxUci3HYxE4vNcrZpN1T2BfS6VgEss/KrVidp/
 4OIH3G/Od5TyyZWUmXIJvUH901dG+ZQXxdDK2DS1ztMkc38iZINgm2+n2FPcoHQDYLoVvJteOXX
 3Rb8jwUwOmDU5U3aLrm6x6b8Gq2nZnyfqE51pWmCVx8XclGV6PSm7MdfqpS8XzhjAYzZbb+FIlX
 jgwsPj/WH+jkYFqVa/4vn3YCgQCazOB9MvDeEIXoC4HxADo=
X-Received: by 2002:a05:6000:2801:b0:39a:c9cb:8296 with SMTP id
 ffacd0b85a97d-39ac9cb82ffmr4481620f8f.22.1742999598611; 
 Wed, 26 Mar 2025 07:33:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcNkqCuf3cP3oozS01412zftmg6UXjEu/i/CvkyF+mrQEcuRd6jVI6Ix/TebqCkJvTwlwH9Q==
X-Received: by 2002:a05:6000:2801:b0:39a:c9cb:8296 with SMTP id
 ffacd0b85a97d-39ac9cb82ffmr4481593f8f.22.1742999598200; 
 Wed, 26 Mar 2025 07:33:18 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-49-206.web.vodafone.de.
 [109.43.49.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3f6bsm17368942f8f.39.2025.03.26.07.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 07:33:17 -0700 (PDT)
Message-ID: <535ee4c7-28b1-4357-8e76-538cc8d2a047@redhat.com>
Date: Wed, 26 Mar 2025 15:33:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "iotests: Stop NBD server in test 162 before
 starting the next one"
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org
References: <20250326123827.920305-1-thuth@redhat.com>
 <2e1e5f28-8d2c-4e3c-afae-a65a9adc85ad@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2e1e5f28-8d2c-4e3c-afae-a65a9adc85ad@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 26/03/2025 15.18, Hanna Czenczek wrote:
> On 26.03.25 13:38, Thomas Huth wrote:
>> From: Thomas Huth<thuth@redhat.com>
>>
>> This reverts commit e2668ba1ed44ad56f2f1653ff5f53b277d534fac.
>>
>> This commit made test 162 fail occasionally with:
>>
>>   162   fail       [13:06:40] [13:06:40]   0.2s   (last: 0.2s)  output mismatch
>>   --- tests/qemu-iotests/162.out
>>   +++ tests/qemu-iotests/scratch/qcow2-file-162/162.out.bad
>>   @@ -3,6 +3,7 @@
>>    === NBD ===
>>    qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address
>>     resolution failed for -1:10809: Name or service not known
>>    image: nbd://localhost:PORT
>>   +./common.rc: line 371: kill: (891116) - No such process
>>    image: nbd+unix://?socket=42
>>
>> The nbd server should normally terminate automatically, so trying to
>> kill it here now seems to cause a race that will cause a test failure
>> when the server terminated before the kill command has been executed.
>>
>> The "Stop NBD server" patch has originally been written to solve another
>> problem with a hanging nbd server, but since that problem has been properly
>> solved by commit 1453e04c63, we now don't need the "_stop_nbd_server" here
> 
> I can’t find that hash; do you mean 3e1683485656?

Drat, copy-n-paste error from my side, it's 3e1683485656 indeed!

>> anymore.
>>
>> Signed-off-by: Thomas Huth<thuth@redhat.com>
>> ---
>>   tests/qemu-iotests/162 | 1 -
>>   1 file changed, 1 deletion(-)
> 
> With the hash fixed (or explained where I have to look :)):
> 
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

  Thanks,
   Thomas



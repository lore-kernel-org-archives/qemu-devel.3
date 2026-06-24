Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50393CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQih-0003aI-0f; Wed, 24 Jun 2026 12:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcQif-0003Yv-TT
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wcQie-0002mT-C8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782319495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U/w9A5NkYf1505G0HkTRB7rAtX6H+f/I3wXhWE6/+vs=;
 b=UoqNTlURHO1edHfR3oDLehLSuBhx+uKgYNhELHj24OgDQBIPLAXZaOcgxpY8V/dfnt+ZKn
 idUIV8EsieTO6n9EnFb7xDdyhmJfr3ggRp9CRAqcD9HyZfRm9ODFm0m8z5qhQt524lIcox
 zLi9ic8U7UvjXIug+HbMc3DR7wG+dAM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-NO5wHVS7O8-i82UH8fm3kA-1; Wed, 24 Jun 2026 12:44:54 -0400
X-MC-Unique: NO5wHVS7O8-i82UH8fm3kA-1
X-Mimecast-MFC-AGG-ID: NO5wHVS7O8-i82UH8fm3kA_1782319493
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4642a5651d4so1228099f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782319493; x=1782924293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=U/w9A5NkYf1505G0HkTRB7rAtX6H+f/I3wXhWE6/+vs=;
 b=pnzNRT7NUOBt3KJo9AuaaAQdptHALcvcqx2pPLGyHpN/t1GKyAaCfBE36eUF0jCjtx
 xdbCz//kCq2LD3hD5Sn0ZbgdjH2kYDenEq8LcTKAKCXl1F4wRZ0ol3jJwHPRrH+p+ZfR
 DQACkdKHu+1HtA6G7PzF3obFSrA7Nfn3NBn7PqAQtg5xA6jxFKpb6FVPVHj1lXz/bJSc
 wpjonv69U4b8molHC8tswLsq6evnkmXRyT2qQJ64lA5beEcJRjevvR8Kw45dVPkxnmCx
 pZklN4k2GgzOjxDwU1DNw1lr9LLP+NEru5q64WQ2sN/QeNfH5DWV1FVVaf4OhjGrv0u/
 rk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782319493; x=1782924293;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/w9A5NkYf1505G0HkTRB7rAtX6H+f/I3wXhWE6/+vs=;
 b=T0vZoWMucZLI2yjII5ABzPRFPa+z0m6B5r6FP0WEPgvo35Pcfd1hM7dFKyO039dHM2
 WXQFFOkyP88qWHipKr3RPMTkh4AGepaKZL+miH+8Gtfs+I81VPY6eUfY+clB6Di/YUeX
 ouPN5CFqMvC2zI8oMYOfbCuQBpcB0VDQ1H8LTqDFMPaxySLmSq91KZCDl5px9RiZqVU2
 oyRhXBGYb4PdvnoTYjD444o1pLI29vxyeA7X2YWVxBKq0H3p+Z01Td7jaZEG0EkcukYU
 XGcxw9zuUKl0a9pai7zrXzAuZiX6YTNKtMLZGzB7Y5lZ2/B1+ysW2olyohpYNN/cyMjk
 bDvA==
X-Gm-Message-State: AOJu0YyZ6sjWz7etMEXF96AHHlPatXvuPeUQasMuahepwBsZpSufcm8s
 KJ2iAZy30/sUSlA27Pi7gcOMqEiedRkbYtPuE9MRPGFFLSGsDS0kiYyNJ3+7pXjq84wq1VOpr0C
 FFI36mrZN/l3fX2wYYeMLtvyS3oqOTFtXIwz2q5PDjrrBFpY3+eTuFCdD
X-Gm-Gg: AfdE7cmrBrpZ7F3FBfScltQDmIhi5wGeowAlxJmq+f2BhZKqeno/yE5Y5mNPccR2032
 ncsGcvE3/csbG7PWuq3v30zVn3zXZI4hz2/RRF2keL/AMSFk0pcECmGkfjJn+UftwR37jJUbYRM
 KOp/xIt49El0TS99U3Ua5m6dg9gVg0AR7PGyCUStFxymzjOjrTpkHw94ppXfp54WdcCNoeSNO8d
 gEeBnxsmKkUR7SpHwNDNYvtFJ9HT/baeUTc+x3YGD6+dr5Z059N5EM1XLKHEfos5Q1dISTIEa3g
 gSNsfYqge+UeYy6c+igoAHrnYOBc3CgIuFjl5XddwkNLZ75CDh2Ale52VmY3b+RtiICGEVoQNi0
 TY8aIvmASQtlMIZ0qZZQRVgH3RQnxNeluNk6vQsvv4yINozZwHaV7
X-Received: by 2002:a05:600c:5491:b0:490:b294:c652 with SMTP id
 5b1f17b1804b1-492608726b3mr60484365e9.20.1782319492731; 
 Wed, 24 Jun 2026 09:44:52 -0700 (PDT)
X-Received: by 2002:a05:600c:5491:b0:490:b294:c652 with SMTP id
 5b1f17b1804b1-492608726b3mr60483805e9.20.1782319492216; 
 Wed, 24 Jun 2026 09:44:52 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5?
 ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01d46sm7307969f8f.13.2026.06.24.09.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:44:51 -0700 (PDT)
Message-ID: <6833bccf-afa8-4633-85b1-f61347034594@redhat.com>
Date: Wed, 24 Jun 2026 18:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-3-adityag@linux.ibm.com>
 <ccbadb13-888b-495d-b894-826a8e664d3e@redhat.com>
 <ajvkrq3e1103wLH7@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <ajvkrq3e1103wLH7@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/24/26 16:28, Aditya Gupta wrote:
> On 26/06/24 01:47PM, Cédric Le Goater wrote:
>> On 6/23/26 16:19, Aditya Gupta wrote:
>>> <...snip...>
>>>
>>>        g_test_init(&argc, &argv, NULL);
>>> -    char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
>>> -            pnv_chips[3].cpu_model);
>>> -    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
>>> -    g_free(tname);
>>> +
>>> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
>>> +        /* TYPE_PNV_SPI is not instantiated for older Power8/9 machines */
>>> +        if (pnv_chips[i].chip_type < PNV_CHIP_POWER10) {
>>
>> Can we remove this chip_type field from the tests too ? see 248e4e924e87.
> 
> I went through the usage, and don't see any fix currently, as the
> PnvChip structure these qtests are using is basic, and we need some way
> to identify the chip type, for things like which machine to use, xscom
> addresses, and to skip/do specific things for particular chip type.
> I went through the mentioned commit and its parent, seems it was
> possible with the compat property being handled by respective
> class_init. So currently I don't see a better way, what do you think ?

OK. Thanks for looking.

C.


> 
>>
>>> +            continue;
>>> +        }
>>> +
>>> +        char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
>>> +                pnv_chips[i].cpu_model);
>>
>> please consider g_autofree variables.
> 
> Sure cedric, will use it in v2.
> 
> Thanks,
> - Aditya G
> 
>>
>>> +        qtest_add_data_func(tname, &pnv_chips[i], test_spi_seeprom);
>>> +        g_free(tname);
>>> +    }
>>>        return g_test_run();
>>>    }
>>
> 



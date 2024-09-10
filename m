Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BEBEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzAs-0001GH-ND; Tue, 10 Sep 2024 07:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1snzAq-0001FX-ND
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1snzAo-0004VB-NX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725968201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LoQghBT4B7DKrzS532OLio+2CVw/dfJ6mhzi4/2pTTA=;
 b=HT4Lrww56+lSTvyUzg1ucNcD3E71tS4h2yyAqxsRGNGRCnRo9bysYpOXTwAISBlLBXxOIS
 ybKfPw2sx2Ri+e1nCPUWy8E3MPtZlD678MkDgEU5Ejx2IEaOd35CsaYGEXztMwxrAg+4O2
 5Z8l8zVWqBdGdpW2hWX56LEzmd97u78=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-bX1lq9zzNRqSV-eZLotNqQ-1; Tue, 10 Sep 2024 07:36:39 -0400
X-MC-Unique: bX1lq9zzNRqSV-eZLotNqQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb479fab2so11528155e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725968198; x=1726572998;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LoQghBT4B7DKrzS532OLio+2CVw/dfJ6mhzi4/2pTTA=;
 b=T4XsiaWZ9GaSdkg8XcqKnE3+ZMnxr3P8XKJtvDILiAC71mgMBjQDN6gAmNx3tRg576
 ZOVFKasBxFlNpkU1dSwcdIqWidLLifpkY2BuHOzlcu6vVuIAUbYvaOwLtVFj5WGRCGf1
 B25qyoEUXxmxMVWI8wCNC6/QKY7e5yAxGFme5NVg+mD4Acro0jxY/0EfLDnNB3HPYFdb
 2GsBDNOEU/JQLJPCBFXp8kjNj50sWB8P2Tpq5s1xCryBIJCYC1r+QJp0pLszgAaSmx1+
 vwFfZ23cyNXT5XrtuOFYDLSqU8AtP3J3gWTIss0lykQ6ybrxGQrmtzASJ9Jnyyl6bcNg
 I+sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV+eIluX4m1yLIUAq0j0mVcXQ7YmptNXButS1Kdo/IFE7Zk0DUabZbKoNbziLBBUtYci2A9vvn92nl@nongnu.org
X-Gm-Message-State: AOJu0YyTK/mXyay+I2v0LesIh8GJNqqYls3oF/5rosHhpEZo7Ogf9zhG
 QhCEdCTjW1ssT3K2Zvtzq/YsMhhB1ihaSuDnUVdwFCUBgYY4qUE/h4gMCbkJ4KtFR6zKNMFo9cl
 8apBOf8leiAnM//N5ym+amWk/p5S9ayJwLTUqosr+eio28HnRxrQo
X-Received: by 2002:a05:600c:1908:b0:42c:b697:a62c with SMTP id
 5b1f17b1804b1-42cbddce6b9mr17288765e9.5.1725968198571; 
 Tue, 10 Sep 2024 04:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFmSY0w+YvqViM5UzUqZ+oaU7+gerEpMcjBlixm/x3CFSbfqcE/MfPL0it39IkO+KrCGzHHg==
X-Received: by 2002:a05:600c:1908:b0:42c:b697:a62c with SMTP id
 5b1f17b1804b1-42cbddce6b9mr17288395e9.5.1725968197576; 
 Tue, 10 Sep 2024 04:36:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:b600:cfda:b383:a116:a940?
 (p200300cbc706b600cfdab383a116a940.dip0.t-ipconnect.de.
 [2003:cb:c706:b600:cfda:b383:a116:a940])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeaba04csm108840495e9.0.2024.09.10.04.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 04:36:37 -0700 (PDT)
Message-ID: <ec3337f7-3906-4a1b-b153-e3d5b16685b6@redhat.com>
Date: Tue, 10 Sep 2024 13:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND 0/6] hugetlbfs largepage RAS project
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 pbonzini@redhat.com, peterx@redhat.com, philmd@linaro.org,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, joao.m.martins@oracle.com
References: <20240910090747.2741475-1-william.roche@oracle.com>
 <20240910100216.2744078-1-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240910100216.2744078-1-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10.09.24 12:02, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 

Hi,

> 
> Apologies for the noise; resending as I missed CC'ing the maintainers of the
> changed files
> 
> 
> Hello,
> 
> This is a Qemu RFC to introduce the possibility to deal with hardware
> memory errors impacting hugetlbfs memory backed VMs. When using
> hugetlbfs large pages, any large page location being impacted by an
> HW memory error results in poisoning the entire page, suddenly making
> a large chunk of the VM memory unusable.
> 
> The implemented proposal is simply a memory mapping change when an HW error
> is reported to Qemu, to transform a hugetlbfs large page into a set of
> standard sized pages. The failed large page is unmapped and a set of
> standard sized pages are mapped in place.
> This mechanism is triggered when a SIGBUS/MCE_MCEERR_Ax signal is received
> by qemu and the reported location corresponds to a large page.
> 
> This gives the possibility to:
> - Take advantage of newer hypervisor kernel providing a way to retrieve
> still valid data on the impacted hugetlbfs poisoned large page.
> If the backend file is MAP_SHARED, we can copy the valid data into the

How are you dealing with other consumers of the shared memory, such as 
vhost-user processes, vm migration whereby RAM is migrated using file 
content, vfio that might have these pages pinned?

In general, you cannot simply replace pages by private copies when 
somebody else might be relying on these pages to go to actual guest RAM.

It sounds very hacky and incomplete at first.


-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18A9E6C60C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMUz-0004iX-QN; Tue, 03 Dec 2024 01:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIMUx-0004gg-NJ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 01:35:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIMUw-0000GJ-1K
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 01:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733207699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uH2E7JqcruskQS7LfkHogo8A7Ps4nvxf4GSPo08Zfek=;
 b=NuAHWKGQ5G5eEDukfhTDZ1FksMNbJAx/2layZuTUAWus3jusYZiRAvV3VHlI7Ft31NoSkp
 k1rGRwS9tCD5hA7Uqugw8iOqncymPCdw0DkFZTp9RTTFjivAm62pUDwNv8F1SzZWXz2G+Z
 F2wL7xPnAI9tYZs+5ybIhxGApUwL6/k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-FmVLis98PDeDQt4S5yMb8Q-1; Tue, 03 Dec 2024 01:34:55 -0500
X-MC-Unique: FmVLis98PDeDQt4S5yMb8Q-1
X-Mimecast-MFC-AGG-ID: FmVLis98PDeDQt4S5yMb8Q
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa51518b8d0so318856966b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 22:34:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733207694; x=1733812494;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uH2E7JqcruskQS7LfkHogo8A7Ps4nvxf4GSPo08Zfek=;
 b=rvu88vhlerjpWDBnOywuEh4a+Q0hHWJSNjHrHSJDPT9IH2aexDhjoxqPXYEL5H1Ond
 rRcyDwjM8yq9evFtkS65NVT6L9Zb+kLZzGWIeXtw6vNhxS+JEVhGRH2oKK9HV/bt8X2c
 chFwNUEl268da2bJINbNfWermsChfBFeaeFDIpbFUnizgdAYa0oP4J61C5Iibnz8FWXU
 awoxxaa2wDTbOqR6nj6zvL/Y1WxcBIQ9eaGX1+ohEf+FA65akrRLrppKySjrECdPJg+q
 5vW3TBcFRIyxSDiCFjmfhw9EQVSg6eeBE1fEr9RH75Xt68C77V5UsoRmMt8l3K9TQPDB
 v34g==
X-Gm-Message-State: AOJu0YyD5RaJaM1IdfI1E+CSkZPTqo0VHzfV3PqSuGIzFbDedphbn19S
 lpGDovB77HdVoVkKBrJHpCR+F1ppStU6hstQOp6LmzRy/jzrNzH9hbW+b4nSt/A01roBXwQVTr/
 8eTkCDwnrYkjSKQRfTUjKwAjo/8/Xw7KeG6ixA2MVijnZnGSl/V4d
X-Gm-Gg: ASbGncvX3KQxbuDu2UhdKU9w9ovXSdl5iiBK16y+lYkkQnm+qR79B1IOb97scY7aFiu
 zTdevRaNhTr3IHzKpb1M03Yt0wp/FYOTMUdI+QwkjUlQCMmwrtxB8O/SwkZ5mKPvO3uNBQ1jQLT
 ZwZBcFMFNbrBnxSlagTVm2w8puNzz+YNgmq16Pijc42ZUr9M6wdFExui+im7K+q5wop7DORjQTw
 VKvZYBzaT3MroD04a4CO/GMlDN70UaQCSdPSuTJuPDPemmcMrartagLmfusMyCXwjvCQShcQDas
 PPn2NQ==
X-Received: by 2002:a17:906:bfea:b0:aa5:3631:adcb with SMTP id
 a640c23a62f3a-aa5f7f4717emr76580566b.53.1733207694127; 
 Mon, 02 Dec 2024 22:34:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB4aOMQz6DNKXU4dF5cH6g1QXED1NsNtz97bnuxcV6NldGlgMaM6C7XZYcAj0Qfmf/FZVB/Q==
X-Received: by 2002:a17:906:bfea:b0:aa5:3631:adcb with SMTP id
 a640c23a62f3a-aa5f7f4717emr76579266b.53.1733207693770; 
 Mon, 02 Dec 2024 22:34:53 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-199.web.vodafone.de.
 [109.42.51.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599905955sm578575366b.147.2024.12.02.22.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 22:34:53 -0800 (PST)
Message-ID: <1c92a38f-0e17-4b44-a035-7f921bf03958@redhat.com>
Date: Tue, 3 Dec 2024 07:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Functional test fixes for v9.2.0-rc3
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241202135640.80528-1-thuth@redhat.com>
 <CAFEAcA9j-iB2Cr2bkLpwoR-Av9XkagO7jqqdN_LSNORDBF=S3A@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA9j-iB2Cr2bkLpwoR-Av9XkagO7jqqdN_LSNORDBF=S3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 02/12/2024 18.56, Peter Maydell wrote:
> On Mon, 2 Dec 2024 at 13:56, Thomas Huth <thuth@redhat.com> wrote:
>>
>>   Hi Peter!
>>
>> The following changes since commit 72b88908d12ee9347d13539c7dd9a252625158d1:
>>
>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-11-29 10:09:05 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-12-02
>>
>> for you to fetch changes up to 92ee59bf56ba42954166e56ab112afe10f3c7556:
>>
>>    tests/functional: increase timeouts for arm sx1 test (2024-12-02 14:53:40 +0100)
>>
>> ----------------------------------------------------------------
>> * Fix timeouts in arm-sx1 test
>> * Check for the "pc" machine in the virtio_version and acpi-bits tests
>>
>> ----------------------------------------------------------------
> 
> Applied to target-arm.next, thanks.
> 
> PS: armbian.com is returning 418 again -- maybe we should
> skip that test for now?
> https://gitlab.com/qemu-project/qemu/-/jobs/8522343823

HTTP code 418 is "I'm a teapot" ... whaaat? Why is the server using this 
status code?

Anyway, we likely really need some logic that simply skips the test for such 
status codes, and only fails if you get a clean 404 error. I'll try to find 
some spare time for creating such a patch (not today, sorry), but if anybody 
wants to beat me to it, be my guest!

  Thomas



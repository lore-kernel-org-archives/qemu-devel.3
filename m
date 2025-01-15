Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092FBC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6oh-0005Im-Pb; Wed, 15 Jan 2025 12:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tY6oZ-0005Da-RQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tY6oY-00051y-77
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736960660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8zSXka34aA5y2vwoJkgxRPXeIvM6jFNIwIfoz6Rh9TA=;
 b=hLPo6fC2dOPwV1oEtbQTimClY6jAMtnlp/5FPLf5C56Uf5q6CI5kR8pwpOKChtLnoc4ott
 XrwGe92p4ADI7BK7uV6fAKXISz0Cs7IP3YY2QnemQW/XuerzOr1NFlihMhYEu6hVD6yJ51
 a7RqznwbY7975gT07ddUC+2iIrv+zsQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-79pXIsJGPpmVV-cddrhCng-1; Wed, 15 Jan 2025 12:04:18 -0500
X-MC-Unique: 79pXIsJGPpmVV-cddrhCng-1
X-Mimecast-MFC-AGG-ID: 79pXIsJGPpmVV-cddrhCng
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d89154adabso817356d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736960658; x=1737565458;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zSXka34aA5y2vwoJkgxRPXeIvM6jFNIwIfoz6Rh9TA=;
 b=vaKofQRJiUANBvW4C6Fwms6ieISj3kDqMeMJuxfyst68NQXCU/5zeiOYCUw2RNjgMo
 EycXT+XqCBXEDC8taraLM5c5WaBW34EWn0VOdsdKlQv/RyY25HTh0VWnodhWYw9OyuDe
 Bq6YO54085BW/eRVJF6Bvber6QywcVgp3c9j9AoNAXdpjj2YPW5xDYljUoIhLzZwfF/Y
 FwDYN0aEp86feHKZIBau7kSi20i4Bt0m1uKeNmKdSd4e62SqPW8a3rTClbUaNzo3x/Ep
 qZIbhkuk76noOH9D2OZDK86ep+NkqwZ7CVY3u6SnpzeVrAJSPGsr8eZtgcds5wFgK8bN
 0xLw==
X-Gm-Message-State: AOJu0YwlZ5SLlitIBUbrGPHlR5LoESb9yHZ/5Mly0k1Ws8MWyV5q7kH/
 cRlNaLRUC4Os+9HiIxwqBzQmzTRB64dOhM1xvmBhr2UOAM6Eesi8wk9Varl58Gl813RpssVEUoc
 6xDA/XILi2Dwu9hJ1J+SvODxdOGlPVhTc+REJ786Ot2DlM66sDNbZ
X-Gm-Gg: ASbGncvGq0x22suHFugz5yZCOstlxqb0JdChZNcm68SctTiwsj86da/aewaBn5Ry3+t
 KkQbLwbh0Kr2Qer+ClNnOhnLcXFjzanwnbUKDDR4ebbC/TBDFYmfzu1G/Y44ThinZfsoNJsDDQI
 MtZJU8K9s9mhsjpZ7vaGZ42Tdb1EpvjTdD4uUx2wyGALL1B3BEOIYQedyMKizpsP/cNfGjy4G/z
 9fB54ldP/0ZJ5qhmgio9kqKPae1cc/3lh9T1XV5HKKUZa0Km/H84cASELW1xhFC1eEhuIhy/Ss5
 TN/CUUO2RNLx
X-Received: by 2002:a05:6214:2341:b0:6df:b53c:7466 with SMTP id
 6a1803df08f44-6dfb53c7a8fmr240027596d6.43.1736960657907; 
 Wed, 15 Jan 2025 09:04:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH77PYmMgNPKrZNGczsl/7BGgtuMU49I6Sea7s3E+GHzYy2D9NioGQpBkZiw6rKJLEQuqnvnA==
X-Received: by 2002:a05:6214:2341:b0:6df:b53c:7466 with SMTP id
 6a1803df08f44-6dfb53c7a8fmr240027086d6.43.1736960657413; 
 Wed, 15 Jan 2025 09:04:17 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9a2358sm67424606d6.50.2025.01.15.09.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 09:04:17 -0800 (PST)
Message-ID: <1ee72a8e-5e06-482f-8dea-9575de1da8af@redhat.com>
Date: Wed, 15 Jan 2025 18:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] s390x: Remove deprecated machine types v2.9 up to
 v2.12
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250115073819.15452-1-thuth@redhat.com>
 <a20b0629-78ba-4ae6-981c-bbc1fbf0a866@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a20b0629-78ba-4ae6-981c-bbc1fbf0a866@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/01/2025 17.35, Philippe Mathieu-Daudé wrote:
> On 15/1/25 08:38, Thomas Huth wrote:
>> These machine types have been marked as deprecated two releases ago,
>> and are older than 6 years, so according to our support policy, it
>> should be fine to remove them now.
>>
>> Thomas Huth (8):
>>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.9 machine type
>>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.10 and 2.11 machine
>>      types
>>    target/s390x/gen-features: Remove the v2.11 qemu CPU model
>>    hw/s390x/s390-virtio-ccw: Remove the deprecated 2.12 machine type
> 
> Should this be documented in docs/about/removed-features.rst?

We've got a generic paragraph about machine removal now:

  https://gitlab.com/qemu-project/qemu/-/commit/ce80c4fa6ff

So I think we don't should manually mention each and every removed versioned 
machine type in removed-features.rst anymore. But some generic sentence in 
removed-features.rst about this would be good, too. I'll prepare a patch for it.

  Thomas



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC4CCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBq8D-00048K-Br; Wed, 30 Sep 2026 04:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xBq8B-000485-Ds
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xBq89-00038K-W5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790758656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wOQXc2R/fvpK/L9vgz1zQowvMTZmSvyBCR+Shjy1/TM=;
 b=Kq6MAkjXYWRwA5lgdrt3suvFt2kw23Dp3uN6SFOhNDg79HD9+BPp+ylFyBizwYQk30yevy
 JuZm8JViSPPJPOto+0bRQ1NHQASh4w/39sI70i3I2RK+EmMoKgCOjdFFmI84QrT+wUIXsN
 yltNh8/qPpT/6kIK9/2risZQpGeALic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-H8kZtCfmM4O-tdJx-LXI6g-1; Wed, 30 Sep 2026 04:57:34 -0400
X-MC-Unique: H8kZtCfmM4O-tdJx-LXI6g-1
X-Mimecast-MFC-AGG-ID: H8kZtCfmM4O-tdJx-LXI6g_1790758653
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48afcecb035so260994f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790758653; x=1791363453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wOQXc2R/fvpK/L9vgz1zQowvMTZmSvyBCR+Shjy1/TM=;
 b=mg/PKe0Znp+SFzW8KwjSLS/XiNZxD9DHIzHLZbm+xJtraZtoDhEfBBP2QVNu9PGppA
 3ewh7Q92O3tCP+dAPozjQygYHoRET2DxadcU9o4N+yeIb4Un8YKHD3imESfZz/w1JMAZ
 b4RYsjO/HjgUYVyiUt6quUrxe+NMO7cEHjzCHAX3J1OYegELmC16d0RZMXzwHTO46QGp
 Cc08wYrHXOKFj45WrtlaFdvT75qnwV8hMYcgIov7cMnBxMYlRZYf2pFtOTdJhmHbWKjX
 yPmnO0yebZdpjHQeBoJYq2H6iARz/4kj7nAalG43YvrlNWvcsZi8Tc+QlFTu+PiRcdPO
 H19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758653; x=1791363453;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wOQXc2R/fvpK/L9vgz1zQowvMTZmSvyBCR+Shjy1/TM=;
 b=cEZMP5hUGfpzCOQ0+T5tWVq1g9Dbu+GTlrZKSg78WI8t81LAOV/oSCzjDg/WzUUAmA
 wLLMecvaMb152sL+hLYrCmyhI4pg95zkXoihzt8s79OQ4H4PrhtGoFDKp7ARzJ5n3ikm
 ymGiIKI1rhRSNYDxMxQ39YMfVxLqFMb8CxAXHNN4xTRUj0enAVD7j7xzrAxmKlxi3zoG
 qkMcpZtmL/KW6PCaPBUqNSd2ALqEUvlhw89hJg+qjvjdC9cQa+F2W+0m35HOam2hqgUJ
 sGNEWAzaUxZ5SaEKKItx9DcWwSy+tsA2ZIUWX9M2DgnIt0Uh6/UafmNlCuFAgDEmZZar
 j//w==
X-Forwarded-Encrypted: i=1;
 AKwUvByEmrZvrC6nTKudcaie8q8u2BTGB6lNjsC/ZY1uDr5hYAUv0/kvYfUIuctWtqywhZnhojiqapRjFGAg@nongnu.org
X-Gm-Message-State: AFq9FYKNlN2p0LozHi7OWoPgPOaxGhLPYU2yiz/pfMCoZkECBFwxDKUF
 4o7wPc15p8w+T6mIMItAdLXu0bL3jucGkt5OBrYjhGVB0rbqh9Own5jISPW0qpXRD7bjNJhRSma
 GrnZyxIkyCw2orlf1vVYZy8niyMl/m6cwcuZ9Pv7FIwfzZAD2C8pUTnne
X-Gm-Gg: AYBFou0+ZrLb61gL4YTrM4Cffo9WIzjAM54y0B6cEzxY7np9b5IBtxj09zts8zh3nfn
 bkgORo5VE5nrqAJ/Ay6bASRk5IjGZz99FODf5GEgpmiZ2Ge3KqXTvnyfVRA1TgUelxhaQf92ZEx
 Zsofw+7no3Gej46Bpr4sB6fZkQ2nqJMTbjHu5J0TH03J6/7nqjBOrQFQDcuy7bPNxAtPO6NTDmZ
 3cvlSeFsk0aRCd6pEJdyp4a+u39jQhZ+leQOWpzedVhrjXljhrI+h7vzHT2kkfu9aJK6lUu6Kf/
 g+Q9TsGPrItH32kCamsASIIhE/92hnXfecRhSAxkWnkiqEMVN8O3AqSwmmw8WDLPQ3c1q70=
X-Received: by 2002:a05:6000:1788:b0:487:13a9:80d with SMTP id
 ffacd0b85a97d-48b0272f0a5mr1430898f8f.10.1790758653206; 
 Wed, 30 Sep 2026 01:57:33 -0700 (PDT)
X-Received: by 2002:a05:6000:1788:b0:487:13a9:80d with SMTP id
 ffacd0b85a97d-48b0272f0a5mr1430869f8f.10.1790758652832; 
 Wed, 30 Sep 2026 01:57:32 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029be71csm2076466f8f.9.2026.09.30.01.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 01:57:32 -0700 (PDT)
Message-ID: <6d74834c-486f-42cb-9ad3-cf2c5b5df1eb@redhat.com>
Date: Wed, 30 Sep 2026 10:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] contribute: define clear limits on bug report
 volume
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260924135634.2626603-1-berrange@redhat.com>
 <98a4b3e6-e538-4bd2-8cad-7307ce24b698@redhat.com>
 <a6cfb8ee-ce2e-408b-bc70-e85e8db7ed38@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a6cfb8ee-ce2e-408b-bc70-e85e8db7ed38@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On 25/09/2026 18.08, Richard Henderson wrote:
> Good idea, Daniel. While you're fixing typos, Thomas:
> 
> On 9/25/26 00:51, Thomas Huth wrote:
>> On 24/09/2026 15.56, Daniel P. Berrangé wrote:
>>> Recently QEMU has received a denial of service attack on
>>> its bug tracker in the form of 120 reports in 10 minutes,
>>> and now repeated by another reporter in the form of 50
>>> reports in the same day.
>>>
>>> Prior to switching security disclosures to the bug tracker,
>>> single reporters have submited 18, 22, and 114 bug reports.
> 
> submitted.
> 
>>>
>>> None of this is sustainable. It is an effective denial of
>>> service attack on the project maintainers' time. Every bug
>>> report is a TODO item added to someone's workload.
>>>
>>> It is time to put hard limits on how many bugs, discovered
>>> with assitance of automated tools, we are willing to accept
> 
> assistance
> 
>>> in a givenm time frame.
> 
> given
Thanks, I've fixed the typos and pushed it to the repo now.

  Thomas



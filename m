Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB350D735FD
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 10:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHKWn-0005wV-Gf; Sat, 30 Nov 2024 05:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKWl-0005w4-LH
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKWj-0007Cu-N5
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732961795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PH7N3GCdeYT/JcH3e3jSta4rNtgE5fERTsbH/CTcoYs=;
 b=F6C3WFbZagH/RJCpIdNPxbBq04VLLtc3NE1rX0R/CjWLhHf9rqMkR1CyvNDkTHqw8k1KR6
 PmxjyTdEuvFOX3esYgpuL110VEqRzBKaZeY5+e6LFyuf8QcGAPU5JHkxhRshhIGnCbqLAh
 LYtZdmvuEPTw9RLjlFOLLCQQZ9UM+cQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688--Wu-OKZFNL2pIjoPcua1aQ-1; Sat, 30 Nov 2024 05:16:33 -0500
X-MC-Unique: -Wu-OKZFNL2pIjoPcua1aQ-1
X-Mimecast-MFC-AGG-ID: -Wu-OKZFNL2pIjoPcua1aQ
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa541bd849aso154913166b.1
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 02:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732961792; x=1733566592;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PH7N3GCdeYT/JcH3e3jSta4rNtgE5fERTsbH/CTcoYs=;
 b=R1Yuk0ipGR6wByOpkDouOWtaCNyn6KmjfZebym1g86FWUN2BMmjjx9sBropONsgnUc
 Mr5n//LKdYuUg3a4cizFQ/oaeqisasQBj+ZRC0k3qeaB/mgNeZ9L0e1Bu31BisP/+yzk
 bSRjsX6Cv/X/zLeaUfUOnmKdYGnuP0Ih8BPjhSoMzlDJx9JGeJ+7ZVy1ddXOJUnWCU6e
 sCX1aQlM/UgFVVLEHX5TcBzk7UWzNPFHZeV3+z9n8ATuycoDkS2ssfF+34d4TI8azX6V
 aCKRUtqcSh7BU/lZtlwgXA4yoT3/U07JjARXLaOyJXaJB0VRSACEeEnMI7bT+rjoVyjY
 /sTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7UFtyGQW7YUgWONQoCuuL8ZsKg5z9w6xm8cPWTGflNbTQkYHc1nSTqB3IMaJgvuEyIQmMIAJo7234@nongnu.org
X-Gm-Message-State: AOJu0YwE+sr49pBROFtXPs846UDBE+zj4OzqrnIdMS5ARJsOS89h2Sof
 fiCvGGdQWM1Bn0ZsSH6oJ43mCVxsE2RY8+hcnmywkZtWZ73QyWJIiTdvcNLoA44MHWlvbhSP8xm
 DCZrjYmCCYyy8w+NiYCfMEiAq+0vgq/1BBEbt4v9FxNaxRfLknNgA
X-Gm-Gg: ASbGncutWxeh4J4PdtFb5sLNFXyiArBOLbEYCMNP5vN62ai3dvggjzFii8/xBZB6SGr
 HgP2DdmYjLOMfcWvFeMtqypsV/ptHmLFULuw6g/fKAkpVWPgi8uPBrgyAdOmb+0e5wIoYigCtsV
 mpBBRZJXoyxEn1oDgzXzHQENICxQnJ4R4xyBa6rYHzUZLS8uEw/zkQgBZ6FbPBkHP4xY2ZKyavx
 29PD1nU01opNSNCZ+pYlbaUZo/3BLgn96H2N+X8PpATeyH8OpzRFqSJSCbOYv1j53O0R4iwqOLo
 bypKfw==
X-Received: by 2002:a17:906:1da9:b0:a9a:46:83ee with SMTP id
 a640c23a62f3a-aa58102aa4bmr980320866b.48.1732961792331; 
 Sat, 30 Nov 2024 02:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFedLSK9Xri8h0vuj9L+3XWW0Oh1xVLsiUILm6+vdxqHMM0OdOGMlHk3a4eCXVFtYaTskl6w==
X-Received: by 2002:a17:906:1da9:b0:a9a:46:83ee with SMTP id
 a640c23a62f3a-aa58102aa4bmr980319266b.48.1732961791952; 
 Sat, 30 Nov 2024 02:16:31 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5994a66basm265289566b.0.2024.11.30.02.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2024 02:16:31 -0800 (PST)
Message-ID: <23b4e458-b46d-4b7f-a6a0-16e58e3e5f2a@redhat.com>
Date: Sat, 30 Nov 2024 11:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] tests/functional: remove duplicated 'which'
 function impl
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-6-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-6-berrange@redhat.com>
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> Put the 'which' function into shared code.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py |  2 +-
>   tests/functional/qemu_test/cmd.py      | 10 ++++++++++
>   tests/functional/test_acpi_bits.py     | 13 +------------
>   tests/functional/test_ppc64_hv.py      | 13 +------------
>   4 files changed, 13 insertions(+), 25 deletions(-)

None of the callers really seem to be interested in the location of the 
command, only whether it is available in the $PATH or not ... so could we 
maybe rather drop this function and use the has_cmd() function everywhere 
instead?

Hmm, thinking about it twice - has_cmd() uses the "which" program 
internally, but AFAIK this program is optional in Linux installations 
nowadays ... so maybe it's still a good idea to move our Python which() to 
cmd.py, but has_cmd() should maybe rather be changed to use it, too?

  Thomas




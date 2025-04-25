Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05DAC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FYh-0005FQ-3x; Fri, 25 Apr 2025 05:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8FYf-0005Er-Ba
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8FYd-0000oH-MJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745574078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iNI9zrnnDH2ns5ODhrT/mrCTa5/Oj9qGHxYZ8uaPJwI=;
 b=cPwvBq2RmXAYJCbTphOIGC60snwlm8zb0MKoVec7q/xLc8h9Pouptnjfo8u42quiX0zFSD
 kr3M9fGyPP3dndjdEKKmVOi/03GKqzVydv4ViVQFHxKx8Ko4a6ZB1MGegI8EBd/ZvDRR4v
 vFvv/Z4vVpYekn/pgIp/7biy62Jbw6A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22--O--sRn5M82OxW9LvvleIA-1; Fri, 25 Apr 2025 05:41:17 -0400
X-MC-Unique: -O--sRn5M82OxW9LvvleIA-1
X-Mimecast-MFC-AGG-ID: -O--sRn5M82OxW9LvvleIA_1745574076
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so662228f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745574076; x=1746178876;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iNI9zrnnDH2ns5ODhrT/mrCTa5/Oj9qGHxYZ8uaPJwI=;
 b=wOMv28VQv+iYYQV2toEbEoUP8bMfOQ/2jhXoG9oDFMwultHuQ7yP63BJe0S2FumEEG
 vpCcKDjEz+fJVBUjmWbiurAteuVTVkDpWfAxaUGFnzW1yyAC57tmoZijr8psMz9H1qvJ
 Zn6gslWJFHPXcNGDCBHfWac3/9xAMszrNM10va9DfiTo77crN5wJrxTFz2ePOHwja44N
 kbCFO/lmdv0C0OI6RoSQ0kzxyPaMeFnV5HlERKHv8QC//PD3+wpuFFywqKJBBKN5ubJp
 CuOU86optWYw6/jvgZDsxF98dGW3+yGBPK6Pi5THvuTkO7mTwnj+Q8wtFiVAUxgzH3Fx
 qt9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHQqTSWZ1umYaFlwXJRp6W5I3ijfeSicDD6IX7aYjEA53nik4VL/4C3mBtNxh/0o8WOdVz3mtg6kC9@nongnu.org
X-Gm-Message-State: AOJu0YwTY+cJfG2ek7GX36itprbON//sz2wy1A6X/45qI1yB1tY0InSW
 a0IM0abg5APrKX5u6ZGR0pxcPU8ExjgC4WfTZinglcTAGomr0O+kfNkFUH2V1INrIwM1W+ZLKsp
 G5rvfj+Lvz8HoKsP+n6TqmtUM1HJQ23gddUPAGljIV0QkAIYh5OJWnAHBqv8YcgA=
X-Gm-Gg: ASbGncsL1KJSDivPjYKpUqHbmCn6LeM0kfFGB1kmPqvjXCpOGloJNQuuKMwkWD9Gef2
 aZ1W+GGBq0BG2ZEmR1CyVigmdPwgsujsanKd3IINAPGlCQ8z2A3epkaqkWYV4PcswFtMnCttrqY
 Xq/nq7CxVnf0jxHsjN3GODcJtUxhQY9iH4d6ZVm/ucv0t2YDCF8UCzIEP/13qYhfs+BY3G8enYb
 58AWbLcIbhuVieS+AbiBQx7aQRKBBfNvXkZSPouF2ZKuBV2UHQV/ElvKyaaYLO10aHxc2ZWlxpa
 A71V9nEUFC/yWNAiC3E0VX1wSrN7un6DN5O56GHwr5Ij9A==
X-Received: by 2002:a05:6000:144b:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-3a074f1571fmr1393706f8f.46.1745574075828; 
 Fri, 25 Apr 2025 02:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH75ynVxprFPHUyoJv+yGoiT5ZR9X/j/xb3rH9cxdWoyG9WZ0dikJnfaJZy8yAp+Mh2LeUU2A==
X-Received: by 2002:a05:6000:144b:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-3a074f1571fmr1393677f8f.46.1745574075456; 
 Fri, 25 Apr 2025 02:41:15 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a52f8800sm19009395e9.3.2025.04.25.02.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 02:41:15 -0700 (PDT)
Message-ID: <2d4f438b-6bef-4ec2-8fc7-c24ebd039d56@redhat.com>
Date: Fri, 25 Apr 2025 11:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] target/s390x: Introduce function when exiting PV
To: Gautam Gala <ggala@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Steffen Eiden <seiden@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
References: <20250417123756.729132-1-ggala@linux.ibm.com>
 <20250417123756.729132-3-ggala@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250417123756.729132-3-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17/04/2025 14.37, Gautam Gala wrote:
> Replace an existing macro (s390_pv_cmd_exit) that looks like
> a function with an actual function. The function will be used
> when exiting PV instead of the macro.
> 
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> ---
>   target/s390x/kvm/pv.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



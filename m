Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B78CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3a4h-0004AT-CS; Tue, 30 Sep 2025 09:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3a4a-000496-ME
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3a4Q-00012Y-C1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759237620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yrAo9+573TZW78eTC4r1U37P+0bWUA1nEfKQlH2YVeA=;
 b=W9ji7sNl/CJkhKSd6LaSUY07Vuk3Gf39XmvTjSdUJRiQljzp8bHWwHhMVpCkU3Kxy6K4qG
 wGTK+01MocdlRFQjd4leL8zDvoO2XZg7noi2hjjOlMsZTgRQzLTRpEDLnHNUm2CGs2Tpha
 3efeET7xEJYFepu3HW1xSQ4qSo/wjkc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-pEs7YMGSNWK028i0qvLWsA-1; Tue, 30 Sep 2025 09:06:58 -0400
X-MC-Unique: pEs7YMGSNWK028i0qvLWsA-1
X-Mimecast-MFC-AGG-ID: pEs7YMGSNWK028i0qvLWsA_1759237617
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3eff3936180so2251341f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 06:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759237617; x=1759842417;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yrAo9+573TZW78eTC4r1U37P+0bWUA1nEfKQlH2YVeA=;
 b=jO2pJA+Dk1Xfgkxl3CcK31dI7BWdVUJgIqbHKqLp+N5QlAVErPJtxPxPUfqNcW3CfO
 dsSLYME6WGe4FKxm+yqSaOCqDHtW3fhpkP1/N397ysstebYSkLik85DikY/iNqEkDbim
 VAGm/5MswyxG8KBpJKD54TEye0l+LqiX0iyQSAo0KOEsYTyVc+ZYoNCUVy795vsNn7Uo
 JRBqjD+BkMqQAOLjvsRlmRF1wJBXTgxDbsAfWizPIJhsDOFi7VMPyvRU/wRyBYyHWtN1
 PbHjJ0NDwvOeXuy8lxD+QAAjmG/kqUINvgsimTaW93SXXAlmBi+9y2PkUPtfv4RfWzwg
 JPDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNGB2nP+AmzHF+XJfsIEzd5slVr864QNsrKgkkPg/f3Dfl/vrC4ATukxI9/oThJ/8rjKHK3upSA81n@nongnu.org
X-Gm-Message-State: AOJu0YzlgWIchPNL3hF2A9E0C5zZY1eROSJq/AD4eYnozWBwfteGeCVC
 isbJuM8ONKVKCkOqv5DVH0RPqrSteHaH+5xI3F84gSPfdyNnezVOVptUbFOtUEgts5JD2oyAeqc
 +o+PZs+cZovHix1Tle3GF1b0JQxFKFq2/k9XvNGYjULIcf8azYFjPQdTl
X-Gm-Gg: ASbGnctvwZsZKnyByYxBZ/cHLCqF1hIV/t/YoLU06sW8s528p3IoHzHxbv+dgzh2v67
 J7j7aV4qyi6p94oFaajAd8UNeeug/IYY9WKLun798an5z6cJ9VaK28t9PU/GfbyLpg+AES7HE05
 SAQzyTeu+L5/mePizMEMo89Y0RZj20OJKykhhIGMgZtgsDLd2TvsLrJacDG3GyDBX5QG0rgooad
 mL8Lho+R0i86D34oMFgf/DpEAT1Tl0ag+Itd+pmOl+AA3GdbD15w7PdsqadvVJhTkZQ3py4KL6e
 OlGbs7IL+148XtDHo842t54sqDcoqZXALmS+5YNqMtFAkRXZktHFkmLYHOC9328BX2Zkk05bGyN
 yvZhLnfBkfw==
X-Received: by 2002:a05:6000:220c:b0:3fa:5925:4b11 with SMTP id
 ffacd0b85a97d-40e4cb6ebe0mr18884214f8f.42.1759237617124; 
 Tue, 30 Sep 2025 06:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd0q8SVYWfUckKczrn5GnQdZ2jRwOfpRP2DfzVc9jqNihzuvyDtcFgsVRknfbyHqbUopgO/w==
X-Received: by 2002:a05:6000:220c:b0:3fa:5925:4b11 with SMTP id
 ffacd0b85a97d-40e4cb6ebe0mr18884186f8f.42.1759237616749; 
 Tue, 30 Sep 2025 06:06:56 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc88b0779sm22398588f8f.58.2025.09.30.06.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 06:06:56 -0700 (PDT)
Message-ID: <96f845b4-4821-4aa4-9548-fdbf3d6980bf@redhat.com>
Date: Tue, 30 Sep 2025 15:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/28] s390x: Guest support for Secure-IPL Code Loading
 Attributes Facility (SCLAF)
From: Thomas Huth <thuth@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-21-zycai@linux.ibm.com>
 <ff8c93b0-5e6e-4335-9b47-c5b82ae246a0@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ff8c93b0-5e6e-4335-9b47-c5b82ae246a0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 29/09/2025 14.25, Thomas Huth wrote:
> On 18/09/2025 01.21, Zhuoying Cai wrote:
> ...
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index bd2060ab93..c3e0c6ceff 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -722,6 +722,7 @@ static uint16_t full_GEN16_GA1[] = {
>>       S390_FEAT_UV_FEAT_AP_INTR,
>>       S390_FEAT_CERT_STORE,
>>       S390_FEAT_SIPL,
>> +    S390_FEAT_SCLAF,
>>   };
>  >
>>   static uint16_t full_GEN17_GA1[] = {
>> @@ -924,6 +925,7 @@ static uint16_t qemu_MAX[] = {
>>       S390_FEAT_EXTENDED_LENGTH_SCCB,
>>       S390_FEAT_CERT_STORE,
>>       S390_FEAT_SIPL,
>> +    S390_FEAT_SCLAF,
>>   };
> 
> In the cover letter you wrote "All actions must be performed on a KVM 
> guest" ... so does this feature depend on KVM or not? If you cannot use the 
> feature with TCG, I think you should not add this to the "qemu_MAX" CPU model?

Ok, after reading through a bunch of patches now, it seems like this feature 
also works with TCG, right? So the modification to qemu_MAX should stay, 
never mind me previous comment here, I was just confused by the term "KVM 
guest" in the cover letter.

  Thomas




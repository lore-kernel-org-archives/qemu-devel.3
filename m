Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65C6C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 21:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdc3n-0005JT-TH; Thu, 30 Jan 2025 16:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdc3m-0005JK-7n
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:26:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdc3k-0001iH-J6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738272407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DEv3gnuZOLg9j9vbDGXCrD9m2+YyzOnJcX0LLFeBoOs=;
 b=gf8qWYHF0yJcOEqqetfvOKQ+7le9UIAvywy+fIdD+APTOegA0InGrMRu9GSbZ6DMurLFXb
 ace9ahcmA2mr5HmBs4RwZe7WzDEVV/W7yGFyMY+OeH0U2Z/TzJ9dxxJC/Bm3E9u51A6Tsu
 gFWBSiDiK3JtXan51X0oMtSCwmButx4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-aYZIgsN-PbSD7IkS-FFCPw-1; Thu, 30 Jan 2025 16:26:45 -0500
X-MC-Unique: aYZIgsN-PbSD7IkS-FFCPw-1
X-Mimecast-MFC-AGG-ID: aYZIgsN-PbSD7IkS-FFCPw
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7bcdb02f43cso132029385a.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738272404; x=1738877204;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEv3gnuZOLg9j9vbDGXCrD9m2+YyzOnJcX0LLFeBoOs=;
 b=AOtHT2nppx3HKiq/D7aO5Iq4m8erVRbfEmJUHDPljVwDQYQCd5Iw0dT4a8jrWFVGnU
 5XmTWy/1d7l9ISErSS9n9oG5A5uMHt2aKrBivOre4BiWtJVnEvoiOoXUP7HlV9kACdbv
 0pDzTgq48ftf51R9v7P/XhmPr2tvGDFKFgYUIr0tOPTtRgw6Gst1ktmbWjZ+tcyOPjMV
 Wv8hdEd8phS6Evgkx9mda1krhWMHN8IyK/CaKBgTGTWGD24bhAl1JBeXZwabUVRi8vOo
 SvASb/ixWiPYsi6Xj8EERHEh7JBnlLLkh5AbkRpaGswevubzn41JFgpwEMbPMqnYB8W4
 k1mQ==
X-Gm-Message-State: AOJu0YybVfk2eZHQv5IVxj3n0yuTqzg3hbSoHLBDFWAfteMPxSbmJW1x
 UkiGnautlgWPaAe1t2Uy2D2S8Jdrp/oW+TBJG3cF679kPeiBVUu8EzxSMVBdqASsrBvyDEYlpTV
 InKZEAA6YNljImHywyrLnhmXmKp1yLMTsjVLXHgTGOd4NpOfJnq/yixOn9OpB
X-Gm-Gg: ASbGncuqFUSJeKg4S0UPDwIkbfg3k+JHevrZG4DspYKu8LxZrrgLdJoU9atL41zfDK0
 2P97ANWcY5qRl70wVLECpPOFbcm9K0z9JJmSSVnv3ocBHxLXdphqLBbtOLERAq0GXC+TikIb9VL
 GKtSL2xeEX/Whf0Kltg7HJjpF4okxzn/hJ9Hdi9WfF0BOopWhO0mi6l5+QvRqj3zEllsTdBPeQr
 BW4fUb99U+CbqdUGbagPnv0tkmA/Hbv3vNkr89zeSeyFhIzZpx/Kb/uzC9BRcp81/LTT4PF6QHn
 LHyU+uUU+1FC/OdYjoDPjKMLJmXs2FPlDomWa30YIsg=
X-Received: by 2002:a05:620a:24c7:b0:7b6:edd0:d754 with SMTP id
 af79cd13be357-7bffccc97e6mr1439123485a.9.1738272404553; 
 Thu, 30 Jan 2025 13:26:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYFhnowlB3Pyezt242Nvo+4RJIvOt+f0eDbtvzN2RgHgJoNyyGLD1/FLh8PXms7QllDGbCkQ==
X-Received: by 2002:a05:620a:24c7:b0:7b6:edd0:d754 with SMTP id
 af79cd13be357-7bffccc97e6mr1439120985a.9.1738272404241; 
 Thu, 30 Jan 2025 13:26:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a906518sm113293085a.84.2025.01.30.13.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 13:26:43 -0800 (PST)
Message-ID: <06a2532d-bbfa-4a7d-aade-7813173d8ca2@redhat.com>
Date: Thu, 30 Jan 2025 22:26:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] util/error: Introduce warn_report_once_err()
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-2-clg@redhat.com>
 <20250130105529.205cbdb2.alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250130105529.205cbdb2.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/30/25 18:55, Alex Williamson wrote:
> On Thu, 30 Jan 2025 14:43:38 +0100
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> Depending on the configuration, a passthrough device may produce
>> recurring DMA mapping errors at runtime and produce a lot of
>> output. It is useful to report only once.
>>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/qapi/error.h | 5 +++++
>>   util/error.c         | 9 +++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index 71f8fb2c50eee9a544992d0c05263c9793956fe1..b6ea274882b9788b64d4bb213c3458d7c674a881 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -448,6 +448,11 @@ void error_free_or_abort(Error **errp);
>>    */
>>   void warn_report_err(Error *err);
>>   
>> +/*
>> + * Convenience function to call warn_report_err() once.
>> + */
>> +void warn_report_once_err(Error *err);
>> +
> 
> Turning it into a macro would do what you want:
> 
> #define warn_report_once_err(err) ({ \
>      static bool print_once_;         \
>      if (!print_once_) {              \
>          warn_report_err(err);        \
>          print_once_ = true;          \
>      }                                \
> })
> 
> So long as we only want once per call site and not once per object,
> which would pull in something like warn_report_once_cond().  Thanks,

yeah. I came up with this :

/*
  * TODO: move to util/
  */
static bool warn_report_once_err_cond(bool *printed, Error *err)
{
     if (*printed) {
         error_free(err);
         return false;
     }
     *printed = true;
     warn_report_err(err);
     return true;
}

#define warn_report_once_err(err)                           \
     ({                                                      \
         static bool print_once_;                            \
         warn_report_once_err_cond(&print_once_, err);       \
     })


I don't know where to put it though. It sits in between qapi/error.h
and qemu/error-report.h.

Thanks,

C.



> Alex
> 
>>   /*
>>    * Convenience function to error_report() and free @err.
>>    * The report includes hints added with error_append_hint().
>> diff --git a/util/error.c b/util/error.c
>> index e5e247209a9e0796074a9794f5598325f22f8d35..b8a211cccaa609a93091b86316144a0ad0a02662 100644
>> --- a/util/error.c
>> +++ b/util/error.c
>> @@ -247,6 +247,15 @@ void warn_report_err(Error *err)
>>       error_free(err);
>>   }
>>   
>> +void warn_report_once_err(Error *err)
>> +{
>> +        static bool print_once_;
>> +        if (!print_once_) {
>> +            warn_report_err(err);
>> +            print_once_ = true;
>> +        }
>> +}
>> +
>>   void error_reportf_err(Error *err, const char *fmt, ...)
>>   {
>>       va_list ap;
> 



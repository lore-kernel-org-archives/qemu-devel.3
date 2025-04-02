Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8788AC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 06:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzrFv-0001YX-Go; Wed, 02 Apr 2025 02:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tzrEm-0001OL-KW
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 02:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tzrEi-0007NQ-03
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 02:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743573962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a4F0VrESKazgENRW6Q4vcHJz5GqcJjMC2LKRuI98eG8=;
 b=acDld+oT6CoxkEcSBbNIUl/SbrUn7ppHXtxIrImID+3PiITdZsrLtCuWN1/HeN5asLrvQK
 G90RkguHTx2jxoaOhKNQk4RTEOZHoJm9HRxO+hGkPKXT4v0G9TmQrgbXXFzWUuk7vPAQWc
 roKWBQcpZvG3c0EkqBm5vnyDbRANxQo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-rpym-H5cOmWT9Dq19hX4Xw-1; Wed, 02 Apr 2025 02:06:00 -0400
X-MC-Unique: rpym-H5cOmWT9Dq19hX4Xw-1
X-Mimecast-MFC-AGG-ID: rpym-H5cOmWT9Dq19hX4Xw_1743573959
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac710ace217so462911266b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 23:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743573959; x=1744178759;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4F0VrESKazgENRW6Q4vcHJz5GqcJjMC2LKRuI98eG8=;
 b=VxnjiUu+7CSM8T6PYEoRLkHMvzBb1sqNCD9wfpmJ/Vsqr37/pCIJPNQS+8VyZkVdpH
 TyPrACBd6i+hB2KRSW31lADFAu9NSrezYnqqg6rkMkD5ZvWjNu1nYj+5KuV6RCzH+V3a
 WovRsawAntimb8ogPZxCnRlDWoJ//T9a5s0qZqYIdsz0YVEMm5s15J/S+f1U0ZqeGaPF
 Tcf2FeDXFlYk7iKB8YyzAzjfESnek6xx21bmkNpIJy5YgatzY7LvGo6guBDVNNMemYRK
 q6V4+71sh0myVtbOXIXV5DEasX7sJWw1Xf3PAM8BlC56x1LGbtwlbsQp0Qky6V1oy+sW
 7bGA==
X-Gm-Message-State: AOJu0YxMCa4m7xyA3UXRCtLPHFB2pZaCbdPK0TxwMrofkh2y1PWM4DxV
 1zvzvFp3syRtPdN6zCdekJb80DxYAHMjfqqrIyK1mkavGxSnlqK9t2+IlvWQv/RMAvX9+b9CCCw
 wHxiMUdBXyo57Bb6xt1luTxx1Fykjl9Lqw/pC2+nptGM6q2wZ93zT
X-Gm-Gg: ASbGncsj6V299m5u9q2CObSL5y81kG9aRnVc2ETaCPJzHFJ/foHhlYPhxIR2KlBaYd/
 l00iZk2Xx8s187lPvZahxSBqvIfYqyUcp4SQzn54Je4bqwMEsRCBUi2Wd/vlxUtdDTjNgXjWzYj
 sYcbDlQdko0Qh1cg+6hjKREkGOJk8tB+ndsZpTnrOwxWptZ3uA2zl6qg2S9tolpzv5iKwcvtTlq
 sDukCrGMeo6RJ/sMaee91Qq8tuGZQRmkBJg0eWVWtnO+zhollQ7Q8DHoFTedSuoxyXdVFqykO17
 jp9qvPuZPb5s9aBcvZEv5HKvu4EDFChkTbNi9CveShFX
X-Received: by 2002:a17:907:1b10:b0:ac2:a42a:999b with SMTP id
 a640c23a62f3a-ac738c262bbmr1294799266b.52.1743573959000; 
 Tue, 01 Apr 2025 23:05:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE68rT9in/Ld6YvGdZZHolBRc/B93DbgPS2P/uqFzLA32jHWXPXjlwMIJ7ocCspb85tfubdVQ==
X-Received: by 2002:a17:907:1b10:b0:ac2:a42a:999b with SMTP id
 a640c23a62f3a-ac738c262bbmr1294796666b.52.1743573958619; 
 Tue, 01 Apr 2025 23:05:58 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-76.web.vodafone.de. [109.42.51.76])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7196d7fffsm862242166b.154.2025.04.01.23.05.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 23:05:58 -0700 (PDT)
Message-ID: <6da8fc30-c951-43dc-a3b3-903fa54237dd@redhat.com>
Date: Wed, 2 Apr 2025 08:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] hw/s390x: support migration of CPI data
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
 <20250331140041.3133621-4-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250331140041.3133621-4-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/03/2025 16.00, Shalini Chellathurai Saroja wrote:
> Register Control-Program Identification data with the live
> migration infrastructure.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   hw/s390x/sclpcpi.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index 969c15e43d..0b1b5293ea 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -62,6 +62,7 @@
>   #include "hw/s390x/event-facility.h"
>   #include "hw/s390x/ebcdic.h"
>   #include "qapi/qapi-visit-machine.h"
> +#include "migration/vmstate.h"
>   
>   typedef struct Data {
>       uint8_t id_format;
> @@ -133,12 +134,38 @@ static void get_control_program_id(Object *obj, Visitor *v,
>       visit_type_S390ControlProgramId(v, name, &cpi, errp);
>   }
>   
> +static const VMStateDescription vmstate_control_program_id = {
> +    .name = "s390_control_program_id",
> +    .version_id = 0,
> +    .minimum_version_id = 0,

Nit: As long as it is 0, I think you could simply omit the 
minimum_version_id field here.

> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
> +        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
> +        VMSTATE_UINT64(system_level, ControlProgramId),
> +        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
> +        VMSTATE_UINT64(timestamp, ControlProgramId),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_sclpcpi = {
> +    .name = "s390_sclpcpi",
> +    .version_id = 0,
> +    .minimum_version_id = 0,

dito

> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(cpi, SCLPEvent, 0, vmstate_control_program_id,
> +                       ControlProgramId),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
  Thomas



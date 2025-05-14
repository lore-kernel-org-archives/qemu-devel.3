Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D17C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 06:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF5LM-00035x-Ti; Wed, 14 May 2025 02:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uF5LL-00032j-Gd
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uF5LJ-0005or-HM
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747203108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JnKhITIb1VHgR6dXfEfBW+i4FgKOQbbHf08isMNJucs=;
 b=F9/GaQ6qYa5JHFhFb0a7aTUd3utLtihCwxxNhr6qIxtcMyaJZUrwadSA6788EgXPJRKs9M
 5b5kCVkSsUqDJuwzW/C/4C21vsszPT/UnSJ6D6Vn5S2rJ02xfTGXp4qY402gt/SUsY2eV8
 yzxd7D2vwO8aJB9V7kVQdmSlcyWzQBA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-OkJWPae7PripagOVfmVwEw-1; Wed, 14 May 2025 02:11:46 -0400
X-MC-Unique: OkJWPae7PripagOVfmVwEw-1
X-Mimecast-MFC-AGG-ID: OkJWPae7PripagOVfmVwEw_1747203106
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ad21f1eec62so50570066b.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 23:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747203105; x=1747807905;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnKhITIb1VHgR6dXfEfBW+i4FgKOQbbHf08isMNJucs=;
 b=a5E4HGgJSsPOALUbb6lTtsmfSc05dRJQCS6wYPxpMA4a676DFgH32apQoLPA8QOn0c
 ZhOJWF/gKYLiIpZ+Q06XRLYX6QBl+LMzMQv24oWSWbKzYpNVjBhVSAgd8SySi9N8Gtff
 eA1+AwJUUdSUHBfGE0DfhDT6S9ZPwxU7AzGiH/ilPMznqPWxQ/JaobGETmG8z7UntEeD
 CLv4ltItS3B2OfkHR+/CFxsmivHYHFEG6Rx+kf4U+XxsF1qfBuzRr70eEsxGqcwi9cwt
 ZYuDuztXIUiWDwoqshs2RwpIjPMKHN+gJFhrxyp7v+e0d/jUsEOu4qJ4CenxhXAiwDCs
 HD9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMuQXAonymQau/KOXhuiW+UEPUyRpO70Hx7eMo+8nxBRdJYYlpOWpMIvlQtMy2+5ibSL7wGJWSWT3y@nongnu.org
X-Gm-Message-State: AOJu0YwGggzNuY1Cn5uRCp0AGa4PMJbDLjuAByRX3885kt7V170IctpJ
 Z6Ed//ZCXpAhxqCqtQxz12AjyLYY18MQHML/NBtDzWYHfndu7S/pN4pLnRZhtn3XPJkq13sq0ft
 lEnl0GSqxp3vGMa878jBdNzRn5l6jxq1bjWaa861B7Dv+2XA8/hBKKVxrlp/JV98=
X-Gm-Gg: ASbGncv5KK85zm4HOeUYQ0QL6YAl3/luBI2HkCUtFE4/1k8ztjNyIEcmiEvG5oEjg0K
 NsPfTmLHs7QlfFu7uQoK8yCDR5dxjayImi/7fabd2jMUZGvcz0jxhb63fSbDy96jPT5n3vR0ZBK
 0hQeGg9oogpWyD/zL88+xWwEcW0O5feNnaS7a6gJrbkviZw5QKxZ3sY85XphCru4WDgaKnlKJOp
 lYAOCtmq//Q76FTn2Mh2C4kKWDCgGXDJg66HgRCJ1V72O2wxUi4Y23/KEouLKoYdi3+a+EnMiW1
 U/IaupMOdImxNk4IRWkaMEzTqX79bMQYq1I30RvYJYU=
X-Received: by 2002:a17:907:198c:b0:ace:d077:3bb with SMTP id
 a640c23a62f3a-ad4f719ac8bmr205550366b.1.1747203105553; 
 Tue, 13 May 2025 23:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGKT6iNA/0wKmXgAssLN2RLofl8h90OXZiVg4KJ5HN5SFl3PjgXpUu6/BvmdhxxMD5DvhgGQ==
X-Received: by 2002:a05:6402:510f:b0:5ec:6feb:5742 with SMTP id
 4fb4d7f45d1cf-5ff95c38619mr1853407a12.16.1747203094231; 
 Tue, 13 May 2025 23:11:34 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-129.web.vodafone.de.
 [109.42.48.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fd0028d67esm6056662a12.14.2025.05.13.23.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 23:11:33 -0700 (PDT)
Message-ID: <d67865b8-a9d1-488f-bf2b-bf53eb3ace89@redhat.com>
Date: Wed, 14 May 2025 08:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/25] s390x: Guest support for Certificate Store
 Facility (CS)
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-4-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250508225042.313672-4-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
> DIAG 320 is supported when the certificate-store (CS) facility
> is installed.
> 
> Availability of CS facility is determined by byte 134 bit 5 of the
> SCLP Read Info block. Byte 134's facilities cannot be represented
> without the availability of the extended-length-SCCB, so add it as
> a check for consistency.
> 
> Note: secure IPL is not available for Secure Execution (SE) guests,
> as their images are already integrity protected, and an additional
> protection of the kernel by secure IPL is not necessary.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   target/s390x/cpu_features.c         | 1 +
>   target/s390x/cpu_features_def.h.inc | 1 +
>   target/s390x/cpu_models.c           | 2 ++
>   target/s390x/gen-features.c         | 1 +
>   target/s390x/kvm/kvm.c              | 2 ++
>   5 files changed, 7 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 4b5be6798e..99089ab3f5 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -147,6 +147,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>           break;
>       case S390_FEAT_TYPE_SCLP_FAC134:
>           clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
> +        clear_be_bit(s390_feat_def(S390_FEAT_DIAG_320)->bit, data);
>           break;
>       default:
>           return;
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index e23e603a79..65d38f546d 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -138,6 +138,7 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
>   
>   /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
>   DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
> +DEF_FEAT(DIAG_320, "diag320", SCLP_FAC134, 5, "Provide Certificate Store functions")

Not sure, but "diag320" does not sound like a very good name for something 
related to security that is used in the interface for the users. Maybe 
"cert" or "cstore" would be a better name?

...
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 41840677ce..3d9fbe62ea 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -720,6 +720,7 @@ static uint16_t full_GEN16_GA1[] = {
>       S390_FEAT_PAIE,
>       S390_FEAT_UV_FEAT_AP,
>       S390_FEAT_UV_FEAT_AP_INTR,
> +    S390_FEAT_DIAG_320,
>   };
>   
>   static uint16_t full_GEN17_GA1[] = {
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index b9f1422197..6bad1713d2 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2487,6 +2487,8 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>           set_bit(S390_FEAT_DIAG_318, model->features);
>       }
>   
> +    set_bit(S390_FEAT_DIAG_320, model->features);
> +
>       /* Test for Ultravisor features that influence secure guest behavior */
>       query_uv_feat_guest(model->features);

Question: Could this feature be enabled of the TCG max CPU, too? If so, it 
might be a good idea to do so, so it could be used in CI tests more easily.

By the way, any chance that you could also add a functional test to this 
patch series, so that we can be sure that there are no regressions in the 
future?

  Thomas



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4EDC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKpI-0002Yq-CO; Tue, 04 Feb 2025 10:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfKpG-0002YI-At
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:26:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfKpE-0001uy-GW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738682812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v1YdNkS+Ss0UcxgID3KEE06Vg9yXoDYrBi0OgaD/Uw4=;
 b=aRHlb1yOV5HFJDI6XU75lI77cYREndkdHDC1APca0piMhPLpBxHeDO9YDW81mmPX20Hw++
 1RQMDv4vcJ65acXAMY90DGbSq03vl2tZYjMxIBeLvp7sOXj/AYF9rGywcIx5RUknHjFm6H
 0LTceeuqnFwB7MoPs3YLxMR/JmTtwx4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-CO_7lBZuMNuCGRT0RdbfEQ-1; Tue, 04 Feb 2025 10:26:51 -0500
X-MC-Unique: CO_7lBZuMNuCGRT0RdbfEQ-1
X-Mimecast-MFC-AGG-ID: CO_7lBZuMNuCGRT0RdbfEQ
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa63b02c69cso669124066b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738682810; x=1739287610;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v1YdNkS+Ss0UcxgID3KEE06Vg9yXoDYrBi0OgaD/Uw4=;
 b=HiAekm2bxtm6+TNVzrfzXbq4fhjaGGos1x88HqjrxJ4SyqDb+QqDX7UHor9Hisoszk
 fDwLytEexHnhQEIj+Vcd56SFq6BdrZFFsDxYiMoNtVvGZL+0ym4ZyjsCnBgeanq3MFRy
 dUU0V2MccNjsqMBVo0MK7WRPjbWuC9/a0rVycoqydB9JszdMfjzKdyaFHeJ/jVjSY+8W
 kC8rvMTvgXz1Fcxagbo3XZonH1a6SRwhHBvprMH4iAFZhxWuOZrdPHrW53BjSV1AP2zC
 samnrYi5uNETJBiYENFRPZJES3rc2jOjDzrbpYC3zPsRRh1UkGabocMyf9D97Fb9SnYy
 gBmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaxkdn83mriGNBaP+xpOH7hf4Y/aMQex4if7kDCwSul95/33NcEqm/TgOmUjKqcfXos0tXvb4NEbeo@nongnu.org
X-Gm-Message-State: AOJu0Yxqsljc2ECi9U6uNBGIy5YEL9pnL1iZZ4YhB6lw9k7xp9K0WSAw
 80qA7hlJ23qLalFM+CZJ2gizdusyPB3RZU9r/RNerWbMGoj6M7w1y5zIiTPhuBZs/zNA+6pmUOE
 +g3gAgEQ72wpX5UcYYV+CayW1ps4FMezmiQa75TIoN2Fwnre/41XD
X-Gm-Gg: ASbGncuRZKXmSDw8Zp3cpSJS20EDFAUi5Is1uhBNpeEJNb0Ffyl7OETDQW6JNQyBchw
 WQLat9qOwz+DZE4SU0h8ubcVea7cec+4kkuQkWa/jhTCCxnAGV+rMdxiHwAPHD//VYNb/s/EMzJ
 6c+JpGv/+FMNy/GuDaUGUrUIf7mqicDB9pyNSXIx8uxAYtdoLkwG5CWK8DpIsR5mDNFopsO5Z1R
 EDmdUJxEmquFzpuduudmYdKbJXTa7z5EpTlDozb8uP16zXse/+NYAIVojkyezeMaXmyZ0aPLO/u
 24ctEg==
X-Received: by 2002:a17:907:9946:b0:ab6:f59c:661d with SMTP id
 a640c23a62f3a-ab74843e3a0mr453633766b.17.1738682809854; 
 Tue, 04 Feb 2025 07:26:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5ZxdXj1BygqpCCEuuTruXYcVOPk6eHiyeeRqEYuM293FWsfyb7PXqY3Pd9hcThkObcVVYCQ==
X-Received: by 2002:a17:907:9946:b0:ab6:f59c:661d with SMTP id
 a640c23a62f3a-ab74843e3a0mr453628766b.17.1738682809445; 
 Tue, 04 Feb 2025 07:26:49 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab6e49ff278sm934446066b.119.2025.02.04.07.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 07:26:48 -0800 (PST)
Message-ID: <43d702c3-ac6c-4acf-9904-5c087549c682@redhat.com>
Date: Tue, 4 Feb 2025 16:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qom: reverse order of instance_post_init calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>
Cc: peter.maydell@linaro.org, mst@redhat.com, alistair.francis@wdc.com,
 xiaoyao.li@intel.com, Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250203114132.259155-1-pbonzini@redhat.com>
 <bd5ccffc-5e8c-4b87-9168-01a964dd6f0a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <bd5ccffc-5e8c-4b87-9168-01a964dd6f0a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2/4/25 16:08, Philippe Mathieu-Daudé wrote:
> Hi Paolo,
> 
> On 3/2/25 12:41, Paolo Bonzini wrote:
>> Currently, the instance_post_init calls are performed from the leaf
>> class and all the way up to Object.  This is incorrect because the
>> leaf class cannot observe property values applied by the superclasses;
>> for example, a compat property will be set on a device *after*
>> the class's post_init callback has run.
>>
>> In particular this makes it impossible for implementations of
>> accel_cpu_instance_init() to operate based on the actual values of
>> the properties, though it seems that cxl_dsp_instance_post_init and
>> rp_instance_post_init might have similar issues.
> 
> I'm not opposed to this change as I had a similar issue there few weeks
> ago, but I feel we are changing one problem by another. IIRC some class
> post_init() handlers check the instance correctly did something.

There are five - one does not have any subclass and the other four are 
all mentioned in the commit message:

- x86 and risc-v use accel_cpu_instance_init(), which is where I found 
the bug

- the other two seem broken too

>    * @instance_post_init: This function is called to finish
>    *                      initialization of an object, after
>    *                      all @instance_init functions were
>    *                      called.

Yeah I didn't adjust it because it now is simply the same order as 
instance_init (and the opposite as instance_finalize).  I can change it 
to "after all @instance_init functions were called, as well as the 
@instance_post_init functions for the parent classes".

Paolo



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA474CCF9F1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 10:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPr3-0004W5-D3; Thu, 30 Oct 2025 06:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEPr0-0004Vf-Oa
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEPqt-0005G1-Mo
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761819948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W1nPDfY2B5HjdOMuICLmP1+xOJ2TzeA7HrpW07VQbTU=;
 b=d7S/a7JeYmU4bXfHrEXybJ5swETJeYi40b3I0qySiJ3/JM4XiFilECQSrN+SRUpSu3mfaO
 iPf2nfPkzAYm6+Zv1HCGwq2DLzQdwMPkZxVq9NktiCcyQf2lkW+m4FPf9R7wNunCHCunor
 BsXOZEZs9GATyij6fHNR5le1LsVZeJU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-X394InEwOwCaVf5yVfIjKw-1; Thu, 30 Oct 2025 06:25:46 -0400
X-MC-Unique: X394InEwOwCaVf5yVfIjKw-1
X-Mimecast-MFC-AGG-ID: X394InEwOwCaVf5yVfIjKw_1761819943
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-471001b980eso4965675e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 03:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761819943; x=1762424743;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1nPDfY2B5HjdOMuICLmP1+xOJ2TzeA7HrpW07VQbTU=;
 b=iSGMCqzcLbtarE18nCUVjIhekUfiU/yxY49AjoaPSGnh2J7bJNlUgignHciXTmrAXE
 Q5G6o0Ykzw5I/AguGMDiImbph06hWlPlSUML8PVvpIv8vWDWlFb0+WkIeW6zUXYDn34n
 hAUec0Snw4XestVTy57lGDLI2d/UOi87h4VRIFXZm2NHkKS+COl4Ep+9RO6F0c4LQkNc
 kSoleNrgmGml0i+dxKbbUjo4w+mtLVT5jH1PYPRf7yzOd73fdEc+LyEzhO8/LPT6VhFt
 nbS/ZxkTqkqNO/mSu/JfXlWioOUblfMMYlkQKPqBD/UopkAe7mqp+EbsbgPoAoZCrFkc
 OuSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXKTE6WEsARq/yIPIzbao1AsdIox9VSEkloFLSzDR9GZlNfeZHN8FPJlZt4qONB2xiZ1iSQhv4m63g@nongnu.org
X-Gm-Message-State: AOJu0Yw3E+rqREinyOxXFAi8Xy8ptPu0UfZ8GRRLJXRgwP+9phPW7MBz
 cGnw1yOf9HNP4UWiOf58e/7cWcvAYnJsSUoYzdQnvMOJ1aFzg5Z+J+HDHIzIlx9zDUH5OZjVwK5
 7h28DdPZUhV9lllE+PHSPTbhjdjnYRu/9kJ6uh3eu4gCIa5fSXzWs7X2m
X-Gm-Gg: ASbGnctfgFlfETc4MS2iTd2qREDAY/zOCL/ctF2KncjXpsw+RmoxTiyFPQJ4UgcBMgz
 t25B60Kw+lH8W/R1iHg4phLy8Q0KZ6/XVwLfN/FTwovEcU77aRg0GAnhiEwwKQOd+hoGsa0XWxm
 BAAzF0Sr7h7uSkpdR8gBQ4YMwtpdmkkw5isr0kZCyYixneAyUKUqlsVl9AJXSH64reFXDL95tSK
 Vm0BGACr8PCQ+dOuHNjdNyBeUxn70M7eqj4+OILnyZX9S54Js8ecPif/OV1t0lCDtSIBUtwMqS3
 4XQlTaHg6O93beZMPy3ayy5yc2us+MHAgvGh1V3jTICfaygl0mjgBBFePECwCOkDlir+21Tyx3I
 tzfw509K3YdDzsv/1wSJrKTVv0gpRelnagoyil0tMyj1hjOY2Ak4Im659bXJZbV8YOvX/kDOK0O
 TkKKs=
X-Received: by 2002:a05:600c:528b:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-4771e3937a8mr59393955e9.23.1761819943285; 
 Thu, 30 Oct 2025 03:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLTJqSd5VCjjae7QiUcYrlvUbEr+P31svPM5TgkP/FKGFwE3PlKmA/nvtp4wfLvThRAC5yzQ==
X-Received: by 2002:a05:600c:528b:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-4771e3937a8mr59393725e9.23.1761819942807; 
 Thu, 30 Oct 2025 03:25:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b6fsm31630652f8f.1.2025.10.30.03.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 03:25:42 -0700 (PDT)
Message-ID: <318bf988-9035-4012-9708-40c3783803f8@redhat.com>
Date: Thu, 30 Oct 2025 11:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
To: Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
 <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
 <db06bf5e-b7f5-4980-a054-393529e188eb@rsg.ci.i.u-tokyo.ac.jp>
 <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu> <aQJpDE6FvkIF6GgE@x1.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aQJpDE6FvkIF6GgE@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/29/25 20:20, Peter Xu wrote:
> On Wed, Oct 29, 2025 at 11:30:10AM +0100, BALATON Zoltan wrote:
>>> memory_region_new_* will work, but I don't think removing unnecessary
>>> but harmless fields from a device state structure does not sufficiently
>>> motivates adding them.
>>
>> I haven't given up on this yet, that's why I alternatively proposed
>>
>> object_alloc (same as object_new without object_initialize)
>> memory_region_init
>>
>> which is just a small change but should also work without adding
>> memory_region_new convenience functions. Then only object_alloc needs to be
>> added.
> 
> IMHO if this will ever happen, memory_region_new*() is better, unless
> object_alloc() can be used anywhere besides MemoryRegion..
> 
> It seems to me, MemoryRegion is the only one I'm aware of that may need
> such tweak, rather than using object_new() directly.

Yes, pretty much.  Anyhow, leaking on purpose with g_new is not a good 
idea.  It's g_new, not g_leak; and everyone else is using a field in the 
device structure so I don't see why one would want to do differently.

Paolo



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88231C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHGC-0000d1-Cu; Thu, 02 Jul 2026 09:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHG9-0000bn-FU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHG7-0007kR-WC
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782998114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X8jfvXqJvjTl5eMJrgsH0/YnrKOsZNe7DWbKjldetr8=;
 b=KDmcCQyYm5h0Gr/Voca3Vy8zFfMRRtLV8BdobWb/3ADp/FNgfu3yBCqiNmcNgsaavC9/Uz
 ZvebjYXsw27r6rQTjxK8ybwYTXwjSA4YAKNf4w0QkDQjnL5zAkQjg7oEKr9gsgnABpOo65
 g1sOaYkFXsl2qx06dOzvYC4VmpsfRPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Mww8UdjaMtKyqO05x4SzQA-1; Thu, 02 Jul 2026 09:15:12 -0400
X-MC-Unique: Mww8UdjaMtKyqO05x4SzQA-1
X-Mimecast-MFC-AGG-ID: Mww8UdjaMtKyqO05x4SzQA_1782998111
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493c69e37f9so4714505e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782998111; x=1783602911; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=X8jfvXqJvjTl5eMJrgsH0/YnrKOsZNe7DWbKjldetr8=;
 b=G/ISDSNo8vCbhuJX83frlC0LCzOeSd3V7U0pscX90Q7irrrkaOMgXhsjn57MaotxNT
 4Vxuaouii2XJzx0A6+ItXSyveKJ+sKeKF3PUOfjJ6F5236w7Q+nnmjD1KMX4Qzqd4osh
 b2MiRUhRDbZOGdmSJXJfe53PKFJd9PncQi2LpxTF2qkEN8QaiMZOQFkf+k2UKr8gJOXC
 L/ztSr0LdPDbK6ZevPPOclqfc5zgJhjYDe78HbgSugLxcpUURSkTLTQe6Twr9ldpxGA/
 QkMza/zoKhv5CPpGmR7TMUBkJbRq8AM77n/LxySyAwneeGeamiLKjuGUIgDpRu6PtHu1
 KD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998111; x=1783602911;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X8jfvXqJvjTl5eMJrgsH0/YnrKOsZNe7DWbKjldetr8=;
 b=a0c/S2lFqXMb3l1vosdDoZez+X21Ai1Nv4WVVOzknm3RJZZOTufP+oWa7v+aow/DgA
 KCRPWDcYpqQlFOvvIxGZhKsq+83ztaiXDh6HWMVDCV/dHgXIvoPeH/h2HCQruINJSxf3
 wUbZhyAUx/jqRN7FCvoJMWLqF/Whwc6+ZX79DQsdvs3XrrBrwLBFUc70Q/nFhvlBM5/o
 iiDSBdmf8s+q+YZPu2y1e0KYQwU3RWmbX/fl1YQu3TJcjHlUf8Fm7LvtGHiaH0XI1R7V
 SwS7LErj0lI4teiYokVaKsiO+X3u/GlErOVIRoaGWPMnCAGZXZcYj8hQT6vaFZujFjIA
 suhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qZadFdyjWdi5MaJH/6TyrT87kjuc4DjteugHsotqtduBZiVG0z1z0fthSKClCfVb1pOh6QyGDJ2bZ@nongnu.org
X-Gm-Message-State: AOJu0YwQY1xxxsv60VGOMBtazaijvAquw0xZSopM6mIoyfEhFXFINZ7C
 BtFoOe63gviT+AEc9Le/lNrPy1NqaWrBRaxd54eWvh+PTZ8Ko7g1gNhuloNX6gh24rFR4b0UvC+
 Qagl3hsn+W05LiQO8nx/FkgzcUPY+OKCOppL+BvMs3UnXlyuyV/wTUky6
X-Gm-Gg: AfdE7ckocWKG4GHpn2eOUMTuHkK7c6fM/mg+bk3w3YQ5pa5TbrxNpJze+rB+8YZCMqa
 fPPQkPAt2Yd6oU3LR+5jKAwMBGYv2K6peBMhEP4KcqpDhZuCUHpeTUWLtrKSDT71fjVt3aSIwzq
 ULqggWkAtPPU+HCPZGRt9+CRI4KLVIPSVirv1oG2GitQG2X1Ae+VNsyjxHDtsjBrAYjGlzF615A
 eqlCJco//eHc/kH/72S/FiS8QvUQUuFWauF3pDlqjuWhpW9yI9iV+mv4DEBmynOXfSY6MmiwDAX
 AaB6oQl3o8ML3Fnc6K1Kl6Dbnc+DbTL8SZFcAo7AX4MyRRHzp0dnSS/Rh6bqBmgUwhLFXU3/BcE
 B5l24KAJRYYrd4jNtB129L9nl6m6TADNh62xsOViAzQ2PBeYbk1WDW7EWJi1j
X-Received: by 2002:a05:600c:1553:b0:493:c310:4106 with SMTP id
 5b1f17b1804b1-493c31041f0mr73355305e9.35.1782998104739; 
 Thu, 02 Jul 2026 06:15:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1553:b0:493:c310:4106 with SMTP id
 5b1f17b1804b1-493c31041f0mr73351245e9.35.1782998101214; 
 Thu, 02 Jul 2026 06:15:01 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6372c52sm55045165e9.14.2026.07.02.06.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:15:00 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:14:59 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/3] arm/kvm: get demuxed ID registers from kvm
In-Reply-To: <2c83f650-bfb5-4c59-aa62-db64ba81db81@redhat.com>
Message-ID: <61a26518-832b-c1c5-f5be-868da2adf4a8@redhat.com>
References: <20260622135627.40573-1-sebott@redhat.com>
 <20260622135627.40573-4-sebott@redhat.com>
 <2c83f650-bfb5-4c59-aa62-db64ba81db81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hey Eric,

On Mon, 29 Jun 2026, Eric Auger wrote:
> On 6/22/26 3:56 PM, Sebastian Ott wrote:
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> We now have the infrastructure in place to handle demuxed ID registers
>> from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.
>>
>> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> ---
>>  target/arm/kvm.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index a54ef51ec2..059d361d88 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -244,6 +244,33 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
>>      return ret;
>>  }
>>
>> +
>> +/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>> +#define CSSELR_MAX 14
> where does this value come from? Worth to document

It's a kvm implementation detail..

>> +
>> +static int get_host_cpu_reg_demux(int fd, ARMHostCPUFeatures *ahcf,
>> +                                  ARMIDRegisterIdx index, int subindex)
>> +{
>> +
>> +    struct kvm_one_reg one_reg = {
>> +        .id = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX,
>> +    };
>> +
>> +    switch (index) {
>> +    case CCSIDR_EL1_IDX:
>> +        if (subindex >= CSSELR_MAX) {
> Can't we introduce a macro that gets the size of the DEMUX register
> instead of hardcoding it?

Not really. What we can use with kvm is less than what we have for tcg.

>> +            return -EINVAL;
>> +        }
>> +        one_reg.id |= KVM_REG_ARM_DEMUX_ID_CCSIDR | subindex;
>> +        one_reg.addr = (uintptr_t)&ahcf->isar.idregs[index + subindex];
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return ioctl(fd, KVM_GET_ONE_REG, &one_reg);
>> +}
>> +
>>  static uint32_t kvm_arm_sve_get_vls(int fd)
>>  {
>>      uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
>> @@ -286,6 +313,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>      bool pmu_supported = false;
>>      uint64_t features = 0;
>>      int err;
>> +    int i;
> nit: you can declare it directly with the for (int i = 0

Done. Thanks!
Sebastian



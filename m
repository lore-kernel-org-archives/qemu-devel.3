Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B2AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2yU-0001IO-Em; Tue, 07 Jul 2026 06:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wh2yT-0001Hq-02
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wh2yR-0006LW-Cy
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783419858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVVpp3l0noFEukyPcmy31vkxV2XtnPY8NbgKthcr7rc=;
 b=VqoeNC6qp+S2NlSrZX3+DFAh23Zb5+pcVqfGD3YmxIZLpwco3RwauDYLIZ3tjL8gebAGKd
 Lrl5jp/+lFO2gMD/fKw8gI5dUnQLCs5ZGOkhj0nXtNWC4CO1ArUSYUhChpU/2CdF1gEMyJ
 LlRViyeA9fSeiMcACairfbR0hNODyf8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-R2hx2C0ENpSWTh2taNIW6g-1; Tue, 07 Jul 2026 06:24:17 -0400
X-MC-Unique: R2hx2C0ENpSWTh2taNIW6g-1
X-Mimecast-MFC-AGG-ID: R2hx2C0ENpSWTh2taNIW6g_1783419856
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-473941177b0so3683448f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783419856; x=1784024656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zVVpp3l0noFEukyPcmy31vkxV2XtnPY8NbgKthcr7rc=;
 b=cPjwNALDgdOyLqgm12qp2urIGpv+fna3Wq6YCbzfS9AXqOSLbEc9XMdP60qr8MOmCA
 nhpoJVbAc5IO36rpkJON+u11zySxMJv7CBtuNy0JBrf1JECXuRO4ZIWHiJB33SyTap8o
 UZByeWixnjYVBTUMNQagCy23nNDxPATLykV+yD7408ZNf0O9Uoiy1OaB2C0F2qMPAsA7
 bEksN5Bk3nE+9/3ibE2h1PPXbFP2AOf5+sXsMiG+dggyrGQ1aErqZatqR55dNs9hybfq
 33w7uwzNFL1pCqfaZoHPnwr89GFvKUoTQOtfaVo2/6FYxm8CqQal/0l1GLJEEgh91n6p
 JtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783419856; x=1784024656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zVVpp3l0noFEukyPcmy31vkxV2XtnPY8NbgKthcr7rc=;
 b=sElV02drFXnGUbYmSABavvxNT5NrGZKhZ5JgWPHWc5g+r3ZaxUgcignVdX+t3djz0z
 hVHE0w1lop62pwPX28BWXEYaXrFCxjtmWdrpFyqi3bO0M1P6XuRSFwdkQEiodvehj+2W
 GpCqzchfX62HZhLbAjBCc31aZKZIUeSLt76EZ2zhAGm8GRbFfyy5sdcZuGoZKRFAVQqc
 prgszTOG3MsHn31lwZfIiBLa71HwoTd4bYuTRbeQQ6nqHv35HkMhEkElSiPn4m+Yjm8P
 mknDv3Y57tudxziqKaYo5HND+hEGZgH8YNEaQm8muj0mafv1EXaywV/opwod2ffWEuUX
 RxDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4AV3D+plEzc/NCTM5ptRCEWH06aR0xsdt2C5pkkJ0rIl+isEYOJb3PEb1W0VVbdy6IiYGCOn6Ep2A@nongnu.org
X-Gm-Message-State: AOJu0YzT2c8eMcbVEWHqT6ejFnz8umUWF47YCWQSh3GaFGI3jX5nMIe1
 l+PuyNA058PIf1AM8aqOiU57xLWWops73pp044Z6/s8feqfzgr9Vuc1u0TIxMZwD7C9wZ072NSm
 YXE/ZV0lW7izlmaeuFnACQVKAS8lWe39MrtaOhBf+sBwOx37sWOnuuGrD
X-Gm-Gg: AfdE7ckF3F5jRq7T66RttzESsCmWzZD4QhnxFrTTqBANvOXuAM3OhGfmoqO68sbm8st
 mOS/jUN6nRpTCjmKZFv6LbMyDu+ECr/Okz8edi3CSIupVgFwo3gAtpGFNcX2eRVV0CCIKDjtzZX
 ly2RAKJCBgLTIYxNRl+OnYFeil0bYFllRcpVoPFfrpuMBk2rEFQAcpSPOcw1EEesZGO2/q9n1Yh
 5zH50LbAgY4VJR5OYPFiz75Gg92+c9SwxCYfbjreM/36PNZ222Kz4YQNaXkGQamu7RNWefPrCJY
 3FpG3o1TkKNA3XjyNXgwDh0FaQ8DKhkvpxLhGTkXEZ/dKmv9ljkOT8nK2wUhrChjf3NvZojLFic
 09j6WIgYXF77eRh2I9CA24PyxCOte1gF3zKRRZD6VCrSzYFdU9l6CT21S
X-Received: by 2002:a05:600c:4fca:b0:490:e60b:6860 with SMTP id
 5b1f17b1804b1-493df083035mr49150505e9.7.1783419855776; 
 Tue, 07 Jul 2026 03:24:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4fca:b0:490:e60b:6860 with SMTP id
 5b1f17b1804b1-493df083035mr49149995e9.7.1783419855269; 
 Tue, 07 Jul 2026 03:24:15 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:263:8800:8714:9136:d3b4:25b3?
 ([2a01:cb1c:263:8800:8714:9136:d3b4:25b3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0ab4dd0sm47133055e9.2.2026.07.07.03.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 03:24:14 -0700 (PDT)
Message-ID: <7ab742c2-2354-4316-a727-a56175a321b9@redhat.com>
Date: Tue, 7 Jul 2026 12:24:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm/kvm: get demuxed ID registers from kvm
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260702133606.34529-1-sebott@redhat.com>
 <20260702133606.34529-4-sebott@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260702133606.34529-4-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Sebastian

On 7/2/26 3:36 PM, Sebastian Ott wrote:
> From: Cornelia Huck <cohuck@redhat.com>
> 
> We now have the infrastructure in place to handle demuxed ID registers
> from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.

I wonder whether that patch is needed at this point. Were previous
ccsidr[i] initialized from KVM before? What is the actual motivation to
read them in this series. Doesn't it bring the risk to expose new values
to the guest?

For instance, in [RFC PATCH v6 11/17] arm/kvm: Initialize all writable
ID registers from host, I generalized the initialization of all writable
id regs and I noticed that the new initialization of CLIDR from KVM
broke the execution (which is not the case for the CCSIDR because I did
it a try) because CLIDR was previously uninitialized and null.


Thanks

Eric

> 
> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  target/arm/kvm.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index a54ef51ec2..f57e86b441 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -244,6 +244,33 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
>      return ret;
>  }
>  
> +
> +/* CSSELR values supported by kvm; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
> +#define CSSELR_MAX 14
> +
> +static int get_host_cpu_reg_demux(int fd, ARMHostCPUFeatures *ahcf,
> +                                  ARMIDRegisterIdx index, int subindex)
> +{
> +
> +    struct kvm_one_reg one_reg = {
> +        .id = KVM_REG_ARM64 | KsVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX,
> +    };
> +
> +    switch (index) {
> +    case CCSIDR_EL1_IDX:
> +        if (subindex >= CSSELR_MAX) {
> +            return -EINVAL;
> +        }
> +        one_reg.id |= KVM_REG_ARM_DEMUX_ID_CCSIDR | subindex;
> +        one_reg.addr = (uintptr_t)&ahcf->isar.idregs[index + subindex];
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +
> +    return ioctl(fd, KVM_GET_ONE_REG, &one_reg);
> +}
> +
>  static uint32_t kvm_arm_sve_get_vls(int fd)
>  {
>      uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
> @@ -454,6 +481,10 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>              /* Read the set of supported vector lengths. */
>              arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
>          }
> +        /* Grab demuxed registers. */
> +        for (int i = 0; i < CSSELR_MAX; i++) {
> +            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
> +        }
>      }
>  
>      kvm_arm_destroy_scratch_host_vcpu(fdarray);



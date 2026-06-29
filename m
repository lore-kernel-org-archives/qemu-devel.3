Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C699C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDur-0006oC-Rx; Mon, 29 Jun 2026 11:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weDuo-0006kW-28
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weDul-0000Zt-JU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782746925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lvq7JLqjbMX5TrlBnGXzrqrCFVtr4Qt3b91ZGtdqVQ=;
 b=EEOirRvbqAw9TDN1KRELGmnPNgj3EUWeBCrRnZTHUei36f7+1iGAoqk5VOD4kvLAOnR3ew
 S2xMuXq3BJJR63tA93f4xxbsTAlALhWUBIL+fo/ihjBPOGDlOARQsxGCBaTTZxX+FL8OQC
 EFgnhWgjiu+AAKz0hZwI+KNjCkEWqwc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-GWmZdE6FOTiBYj-J_mwzwA-1; Mon, 29 Jun 2026 11:28:43 -0400
X-MC-Unique: GWmZdE6FOTiBYj-J_mwzwA-1
X-Mimecast-MFC-AGG-ID: GWmZdE6FOTiBYj-J_mwzwA_1782746923
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c125bdd01cbso153325666b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782746922; x=1783351722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5lvq7JLqjbMX5TrlBnGXzrqrCFVtr4Qt3b91ZGtdqVQ=;
 b=D0/0R+G6FojPS6CMAoOgxF3rF5leQnFEctgC0y3LCPAMhJotl7oYvkL51LUUFSm/Sn
 UbBXuYpHoxV6JTd+CvGybeE4CYhQ6FxWv4ca56VFj7E1428DKnXp8z5QTqHa6nbY4sAj
 bhy6HniAz0bDff0HomeOaJbBG5KCGjWDdzNkzIabAFHDs1gJo+SmeYJ+mXwTvkKu1W2C
 +/i6xA/HlHYNQvC5CQpXKdGOCA+qnKABqKfzDKC9zz8ZPF1u+S/1zGczhu9Rz23Ivdda
 6Rr3IHOihy6LZLDbU+0LlMIoRyqGFrh4dH6+H6IJPW5U7V0KouUCI9sASyZnntFuxPiN
 bnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782746922; x=1783351722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5lvq7JLqjbMX5TrlBnGXzrqrCFVtr4Qt3b91ZGtdqVQ=;
 b=dVbix9dMSLHs3xiFNBpKGHWQMMtDhxxoTzul6gTaMHCAy4yq1T2oDPvJX0vIgr0Q2b
 rIMl8rzavNOalx6iLo+vTMhyRTOO2viRbhFDwViAASnDFA5uc0ZPIbf+mI9ELfW8DrQd
 IwFzVsCs8Poqlf5wTp5zN3Qci24etNXhhM3YZDkLoPAljOkZ5RFybBoUkJwvxuyl+pzq
 B06DsMHkV4F4Rn5/bRmNH13S36Naxckz4K5j0KYF3pK0EaoGxGU8CRpIpb1hTtQLH8wy
 2Kziq91erO/lnZoV4GdSzpmtUpFLPyc1+AQsbtqzxYOzGeZnLSB8hOobMgdL5olpwrI4
 xGbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RopJIiRV34s/Tk6jM8xueuPAEsZNZ/+VahdpK9WZOqB84UMCG9CJLma59pdBrvxzDXJrgWe3q+AEVVi@nongnu.org
X-Gm-Message-State: AOJu0Yze0uViLEkTzubybXJxF7GAuQwRQhtp/bS8qoXG2yOAq1bgLYiO
 A9CKpmUxkhxvi0vR0mZkSQ5huzcwYAiWtVSFBZyT6bePrMC1eZvzsnlJ999qLVjLWRyQhcz/XlE
 rsfj4g78XG3lNVXhTX5RdhkqrstaSdmpgCdFbVYFENkIesda3Fy3ufRvp
X-Gm-Gg: AfdE7clPeq6p5qNMUv17+4ZoRgRxYIE05FVgNI9HgqJm5x7NLboTKhIzbpsfojjSmxD
 T6FGao7UGKRQGEaaq9tyZHd3Lhpii0X4Lw6gy/eDjlKYUa0CJj2o9hmSFVXhUbyYjgF9H8VlL4a
 lfLN3o0FAxKzUUsd17wUK1us48dafVmaKFuruwPGEzZFjQlQSS9wdBwWZ6bUPZoUAWhtYhTh6Ri
 gK0SXB9i/uZytOcK/vnj1w48+1YCM6+QnEzM1ORLYZd7FTSoKvsE23mfTSKi1RLqYcbt9KosFFz
 9i3znR2GT58ZRuPL7bVMss2x7f+N8cVZNZbh9djFf+NbNRHyiD+N7CRCq6o/Byj2A4qal3opap2
 uJGYT/oR11f169lOyJcE2gRcc163dpAQjaETBARBoCRvZiHT5CC033A==
X-Received: by 2002:a17:906:b30e:b0:c12:6822:d292 with SMTP id
 a640c23a62f3a-c1281378684mr45597566b.4.1782746922415; 
 Mon, 29 Jun 2026 08:28:42 -0700 (PDT)
X-Received: by 2002:a17:906:b30e:b0:c12:6822:d292 with SMTP id
 a640c23a62f3a-c1281378684mr45595766b.4.1782746921905; 
 Mon, 29 Jun 2026 08:28:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1251a33abbsm300107466b.54.2026.06.29.08.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 08:28:41 -0700 (PDT)
Message-ID: <2c83f650-bfb5-4c59-aa62-db64ba81db81@redhat.com>
Date: Mon, 29 Jun 2026 17:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm/kvm: get demuxed ID registers from kvm
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260622135627.40573-1-sebott@redhat.com>
 <20260622135627.40573-4-sebott@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260622135627.40573-4-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
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

Hi Sebastian,

On 6/22/26 3:56 PM, Sebastian Ott wrote:
> From: Cornelia Huck <cohuck@redhat.com>
> 
> We now have the infrastructure in place to handle demuxed ID registers
> from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.
> 
> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  target/arm/kvm.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index a54ef51ec2..059d361d88 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -244,6 +244,33 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
>      return ret;
>  }
>  
> +
> +/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
> +#define CSSELR_MAX 14
where does this value come from? Worth to document
> +
> +static int get_host_cpu_reg_demux(int fd, ARMHostCPUFeatures *ahcf,
> +                                  ARMIDRegisterIdx index, int subindex)
> +{
> +
> +    struct kvm_one_reg one_reg = {
> +        .id = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX,
> +    };
> +
> +    switch (index) {
> +    case CCSIDR_EL1_IDX:
> +        if (subindex >= CSSELR_MAX) {
Can't we introduce a macro that gets the size of the DEMUX register
instead of hardcoding it?
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
> @@ -286,6 +313,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      bool pmu_supported = false;
>      uint64_t features = 0;
>      int err;
> +    int i;
nit: you can declare it directly with the for (int i = 0
>  
>      ahcf->target = QEMU_KVM_ARM_TARGET_NONE;
>      ahcf->dtb_compatible = "arm,armv8";
> @@ -454,6 +482,10 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>              /* Read the set of supported vector lengths. */
>              arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
>          }
> +        /* Grab demuxed registers. */
> +        for (i = 0; i < CSSELR_MAX; i++) {
> +            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
> +        }
>      }
>  
>      kvm_arm_destroy_scratch_host_vcpu(fdarray);

Thanks

Eric



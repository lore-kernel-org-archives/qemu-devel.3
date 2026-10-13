Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF18BCC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfNi-0000VI-7l; Tue, 13 Oct 2026 12:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfNY-0000ID-9g
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:29:29 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfNW-0005bh-PI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:29:28 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0a28a720aso18939697b3.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791908965; cv=none;
 d=google.com; s=arc-20260327;
 b=P+opKzpTgyljQIPTG+hSfhl7A3PavNr6nM7ydDmxnlpQqzz0DPtGzQ9uDPeWgtqHpp
 bE1OBUex0bktHOkuDqET8FPoTRkyKgbZhgyuIcNYpo1C3ViU5QLNlQQIa76wK4TBkZUv
 oXjawMqP2GPCcfDlRVqr+mVhVkE3gTb+PebjmX1vsWb0D+xMtNpGpqh4OuiBmt1PlUUF
 cRQ6OFLY/b4XY2mlVJLqwbDBVK2bEPH+cSftXbge//uLW6Ji8tWBNsBiZRK5iqkn7gIg
 xlSRBX1mdy2Q87UGYZVoFddOG3Z06oFjtl8lu51kmbcQKyhApXL68B0eJ8fhHydXnpdr
 yaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jXo9q1ZmZcN51gvyAI6giPbieASxcFI/Rz78Tc/rF4k=;
 fh=vQITof/hq+164sQZ+TCwbJpyz4qYARdPogWTh0I4m+U=;
 b=TzpnJQHCgoMQfiFPGGYYOpFDnX6Ztzgdqp3fD5JpOM1HWFzmTsmvPKAsF8yrsF5nRN
 eUbdHmN9y8W4Y3qdr7B/pYtvsO/+n6qoBThrQ5pVy9hUcjy3gPHigNDgoYgQerleoO98
 zLictw+lK9jTfirmU4a8K6WS5+6DSvIGaC+fdzytv5YNRChzl7Z/VR7tqPCBQaeAuBdo
 HiNUEUVLVJCoo7/XTe2V7L5nnmWX8v48fWPZ9N9bo5GkVNI/SjedrsbA06tjspN6sXFq
 NBj6/u6I7O4m/7kthRlU17kqMFhWcIHCMw0V4Ua6Uf8svfrHnWjLxr626exete3/b9EJ
 DsTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791908965; x=1792513765; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jXo9q1ZmZcN51gvyAI6giPbieASxcFI/Rz78Tc/rF4k=;
 b=d/JHxFCwO8hi9mI3pcaQG2lzvjAQUT2fnM6H8WjN26BcazIDaCC9Gmj+beNrhI34Fr
 TCrWOFyXV0nEDVO6K+nhjuSfak0Jsyn1FVB1IweOw8qDPv1tApWNqComthqjpWBn3PIU
 5f8kSQV0jF2nNxCOMxXC/N4O5JkQf4qSBHQTGnTyKiyp6uRkpQ4q9LoXCPimRYNTKXGK
 fZ/3jDvbz4T06yTlAc8SiLyqP25XduskC4yD4IVv031lOzMCv3YQeDfyek6zntOBg2LB
 YhNkrvIcUTH7Ydqezz6G02aQSdOPwSZbaJfy9uYrv4qUUrPeynLoXoozJo1hTXgQwJ34
 +TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791908965; x=1792513765;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jXo9q1ZmZcN51gvyAI6giPbieASxcFI/Rz78Tc/rF4k=;
 b=BJ3JdfWeBWPoaAGkeZRrnKCi22OM04PR8ZYlue9M1sEGiCEGJ1muGhri4oT8RDjjuO
 HOMRX9eruSAS4EAAdQZXSc7rsApx6JyR0v7ejqAFXSyXQO04K2fbEQC8ybWUyczZjA23
 SBtOLCcMwq9ptdokwb9F5SIniwowpT96xYbcCN0yCR1bFoT+7Vxw6pZjLdm9mcsboRHq
 FJzZSauhjo16lvTrfL3OADV4zlJwlsVXzlPqLxs1dq4Chbyp5Kct23WFmf+B2pltYLPe
 MJeSrdjHWdQt2CmBVB8QGdG5WDHEu7bOkMgZZ7LEiAu8tknZ7caftv/zPe3Cp/t9sx54
 RhAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFZX8bz7THuN/U3L0c1ojtDFScQ9vNXdJh1Tn3V4Ccy+ShZ490QCtMuCmbzSZPjvLJ82GwJLtBeUT0@nongnu.org
X-Gm-Message-State: AFq9FYITuy7w5HdW1O7I1fgzVZ9a4suE6DlwTm1QEvBwe9jNFkfu3L1y
 T3AAKfKzlISQ3c2+8JEJoQ11hY3JrnEblLk1lgZRzV35uFIJYy/tjgTgBCUB8rCdxnPe8tx/L7u
 Q+N9zqNL+xbrYxmCMbmN1dny70GU/Jw5kXnIg8f9NDQ==
X-Gm-Gg: AYBFou1BX/H3XP7j+siPvmZ9RrKZqAozW7n2rc6NatG0eVcHVMEAHV3xdcpAqHRiR3U
 yN9/HVlHQpZYQZ7CfYYrXFM4CzpbEUefqCY2b150MMK6jjLDc6vfZM3MyBAd1EzIYKQYn50aNAd
 XSyyGEERR+EZMzAR4MuvStubsO0gEEhgp0+hNPjw8zVjlJcuulI2lbfFCryKSKuN0DBihSxyklW
 ykIrQUzJ7El2spkN4I4NiDRmvGz5BZbxozYSVRNa71irS7aGOHgWE3TDnja0zvEofLICksgEofj
 0Kbo1VFdObKzLlgjaialp84nW9aYxL3BsLQO0zEnGEkIJyfqIbBE/nUn4ioI8oFdKlunsu6q9Rn
 y8EsvsXsqSMfJn+JLE2Xb1JSgdGHtyfZPjAA5oKM=
X-Received: by 2002:a05:690c:e1d9:10b0:8ae:dfee:cd30 with SMTP id
 00721157ae682-8b07ee80677mr32738227b3.56.1791908961569; Tue, 13 Oct 2026
 09:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-22-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-22-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:29:10 +0100
X-Gm-Features: AclHuK-eFYommmfqG_nkwY0m20Dw4f51-5ZNktl8ml0khtEb6QlSNypivh2nwj4
Message-ID: <CAFEAcA9vm7004bytZqYwXCNj_+VNy1RzKMqG3TDnJkswpNhLUg@mail.gmail.com>
Subject: Re: [PATCH 21/22] i8259_common.c: remove static irq_count and
 irq_level variables
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Adjust the parameters to i8259_stat_update_irq() to allow passing in pointers
> to the irq_count and irq_level arrays, and then move the arrays into the
> corresponding i8259 PIC and KVM PIC devices.
>
> Doing this allows the statistics capture logic in i8259_set_irq() that handles
> incoming cascading interrupts to be removed.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

> diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
> index 421c9279cd..ca661afc02 100644
> --- a/hw/i386/kvm/i8259.c
> +++ b/hw/i386/kvm/i8259.c
> @@ -30,6 +30,9 @@ struct KVMI8259PICState {
>
>      ISABus *isabus;
>      I8259CommonState i8259[2];
> +
> +    int irq_level[ISA_NUM_IRQS];
> +    uint64_t irq_count[ISA_NUM_IRQS];
>  };


> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index 3f10777036..ac43995ce4 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -49,14 +49,16 @@ struct I8259PICState {
>      ISABus *isabus;
>      IRQState i8259_primary_out_irq;
>      I8259CommonState i8259[2];
> +
> +    int irq_level[ISA_NUM_IRQS];
> +    uint64_t irq_count[ISA_NUM_IRQS];
> +#ifdef DEBUG_IRQ_LATENCY
> +    int64_t irq_time[ISA_NUM_IRQS];
> +#endif
>  };

Would it make sense for these two types to have a common base
class (where the stats stuff could then live)? AIUI they're
both intending to provide the same interface ("pair of i8259
devices cascaded together in the way that x86 does it").

-- PMM


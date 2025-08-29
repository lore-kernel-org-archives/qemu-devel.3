Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FE4CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGu-0007oU-OR; Sat, 30 Aug 2025 11:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryJW-0005V3-GK
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryJR-0001iH-2a
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756470858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cz1BXjpfXAmfEJm6RS15seidZTfgeDzKoSF/4UZc5Dc=;
 b=L4i/PslH98YIhnRTly2b3xpmDtZZOl0fMz1Cw5Qm4CV9KRILEHNTQ/8NzvWfqh1DWx01z+
 qEvO/YxWh33dNKgyWhWBU4PcBQBaDB6+t0mTLQRZ5/zaWJ2xoMN/iqdJkNwuo17477oKTZ
 XlHv7K5BaCjEly7OzdTg8h0NceHjQuE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-BPnKsoubNZuTrr-YYGdWOQ-1; Fri, 29 Aug 2025 08:34:10 -0400
X-MC-Unique: BPnKsoubNZuTrr-YYGdWOQ-1
X-Mimecast-MFC-AGG-ID: BPnKsoubNZuTrr-YYGdWOQ_1756470849
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3c584459d02so1322871f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 05:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756470849; x=1757075649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cz1BXjpfXAmfEJm6RS15seidZTfgeDzKoSF/4UZc5Dc=;
 b=NsSZKfvPBBvYjLGQdNQI3PD8OTYbPRdAuOs5pF69ev3Vy0Yfrtak//dZdJfo6/Rs/E
 NXM6kB9S6IkuU6DZYYnlRnukQ6y1lwbvh8/Pg+7/MwB3sxh2wMSc4hmODQ7YsAJjQfZW
 Uw+ShoqAHlxMX+mawBsJMJ7neGiodXWAozb920Y8oG7H4rSP6s+Dw6sWbJZ7HD+iaQq/
 SCDTTxo4JWERsd2aiKsiT+gySz9ugdDPqkQ0gR5wCxTPjvNSCbsvVDckbuAVgCfDzEn6
 2gdjoFT47xQakyxGCiBoWrAG+U8RiwHNhcAPWgPh0x1faJJY+FUYWZQOYGqHbhU4QkLf
 vcQw==
X-Gm-Message-State: AOJu0Yxcoukls14x/TM4oqXqjN4LpBkf7Mv57ZTXkWZET6HDtXaH6kCS
 Ox3w5CLlDNQH7Bsp/LpBcCCJe5NovrywU60F8H4KTTTJMDMoiIT8sjOLRfuT4KElLyxGE0ZjLSl
 CYbrxgqZs+i0l9lI1YtTF70gSVPX26EyNR2cjHPAz7zVPwDkQf9BqCbqVTHL290eF1DVGcGDqL5
 8uQpwykjx0pnJozqSZlpXA+Nel8kp0BFY=
X-Gm-Gg: ASbGncsmRRFjWRFrVyuVILqX1AtzXWLNmorL1VFc7Cyn6ZDNRemRet0koZoB2S/qCbr
 USoFpJQGwFD0gF2Zl15LGv/6sO39+915AZbm1PU4Zjdgs+tKEyaqWAY6P1DXvTgyTcBtjwTzvGb
 i/O1M/rNyoob8b71ow6Vpga+Y0A5wIfFntGhPI3ZVwx1EWvQdr9SevXk+6I/qgps2lDHZxcmpT2
 glE8OmeqZ7C8rPC186q7ImC
X-Received: by 2002:a05:6000:25c6:b0:3ca:4e3:6ea6 with SMTP id
 ffacd0b85a97d-3ca04e3768amr14037150f8f.46.1756470849291; 
 Fri, 29 Aug 2025 05:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+9ral3wwkJofl1NoPSw+FQ5Xplvqw2IU2Tgs39YXVRGIFh7swHtcRzbllWKRf9bNNy9J4n7PjRI+inCjOhLo=
X-Received: by 2002:a05:6000:25c6:b0:3ca:4e3:6ea6 with SMTP id
 ffacd0b85a97d-3ca04e3768amr14037101f8f.46.1756470848792; Fri, 29 Aug 2025
 05:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com>
 <aKyBFlCtnxnP9kt/@intel.com> <20250825171912.1bc7b841@fedora>
 <aK1mHGan+n9NSAOk@intel.com> <20250826104731.1440e3ed@fedora>
 <33661ea1-b0aa-45b3-8923-0b47a40dcea8@redhat.com>
In-Reply-To: <33661ea1-b0aa-45b3-8923-0b47a40dcea8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 Aug 2025 14:33:57 +0200
X-Gm-Features: Ac12FXwROH2Sg5p-UYSJ-6MOitEUdMAKq4acnRp2TbAekXjq-AqLBZUoYzx-QVw
Message-ID: <CABgObfb6Hs8EOeLQeG_S=Y8j8dj6A9fAMn0DzSSVKZYBG_rP-g@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
To: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com, 
 mtosatti@redhat.com, richard.henderson@linaro.org, riku.voipio@iki.fi, 
 thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com, 
 david@redhat.com, jjherne@linux.ibm.com, shorne@gmail.com, 
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, peter.maydell@linaro.org, agraf@csgraf.de, 
 mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de, dirty@apple.com, 
 rbolshakov@ddn.com, phil@philjordan.eu, reinoud@netbsd.org, 
 sunilmut@microsoft.com, gaosong@loongson.cn, laurent@vivier.eu, 
 edgar.iglesias@gmail.com, aurelien@aurel32.net, jiaxun.yang@flygoat.com, 
 arikalo@gmail.com, chenhuacai@kernel.org, npiggin@gmail.com, 
 rathc@linux.ibm.com, harshpb@linux.ibm.com, yoshinori.sato@nifty.com, 
 iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 29, 2025 at 10:18=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 8/26/25 10:47, Igor Mammedov wrote:
> > While overhead might be issue, it's better to have correcteness 1st.
> > (that's why blanket tree wide change to make sure we don't miss places =
that
> > set/test interrupts).
>
> Looking more at it, I found at least one place that sets interrupts
> without bql:
>
>      if (ctl_has_irq(env)) {
>          cpu_set_interrupt(cs, CPU_INTERRUPT_VIRQ);
>      }
>
> I'm going to squash this in:

Rethinking about it - this can be a separate patch that also affects
cpu_reset_interrupt(), as well as all cases where
cpu_reset_interrupt() is open coded.

Paolo

> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 1dee9d4c76e..5c3397fe108 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -959,12 +959,13 @@ static inline bool cpu_test_interrupt(CPUState *cpu=
, int mask)
>    * @cpu: The CPU to set pending interrupt(s) on.
>    * @mask: The interrupts to set.
>    *
> - * Sets interrupts in @mask as pending on @cpu.
> + * Sets interrupts in @mask as pending on @cpu.  Unlike @cpu_interrupt,
> + * this does not kick the vCPU.
>    */
>   static inline void cpu_set_interrupt(CPUState *cpu, int mask)
>   {
> -    qatomic_store_release(&cpu->interrupt_request,
> -        cpu->interrupt_request | mask);
> +    /* Pairs with cpu_test_interrupt(). */
> +    qatomic_or(&cpu->interrupt_request, mask);
>   }
>
>   /**
>



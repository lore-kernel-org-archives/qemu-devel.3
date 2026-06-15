Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770E6CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ50R-0004Yn-QX; Mon, 15 Jun 2026 06:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ50P-0004WN-JM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:57:25 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ50O-0003ik-2v
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:57:25 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66061993294so3025832d50.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781521043; cv=none;
 d=google.com; s=arc-20240605;
 b=eMLvlM70VCtosu/7ep+Eqsr2veTdUlLVfkxJC5S4ZAFy1q7mKLABVCSJs375oREqZM
 caMnRkPHrWeVw6nW3FlxyaCP9D9an76qG38Pi6GYPY7hP/jmehSJyuWKavvnyLXzQvxb
 oB6QycdGRZaSiuyxZKXLZ2eUv3tuCxwGYffKtF+l+i2jc9nN8+okl65IEi20Dcz/kQ2a
 RQ+JfVzDboWucSZBMOR2Oxh8f/+HHo7UyQOg8UpCwMqwTQNMNAPtRuLOsb1TSNhMt3sB
 RQYUWtRNKhNLgan/V+9ESVgUUQInvIU5xNRBI9FjO9gL9vdt6aYe0Ix6UAaY1X1NopcO
 IDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S/wz8lKERvbYqf5bVZv2UL7q03dzo45KKXIRywWSaCY=;
 fh=XkoIWOC0cp1wgjcb6+uy/PC2e0l2maR55LRl7oHJsTY=;
 b=isa/8IueDD6GE2uEjaILsBXFxzPqAQ5VI7n+EGPFC+z9H0oeUmfKdGacwnOjaLF27A
 ljBaaAThWKif2g1QkaORC5RjJ+NestqIqJ/812LnOchyUvEGV8VbKRW4yhVRR9odWwnu
 RePaHIi5Luh/98aZeBsYXZkShtYbWiAz9ngfs0pgU8YcddyyRr6zXtmnbqNRbzL48blO
 tCI9MzzQEg9nV9oF46jtV8luFCHC4u3hXEE9EyFWvSbjFIbAg03ZIUXIBo+2nW/nmjWB
 AHNaiyHtA60eYwzp1tqSiL+0drSQ3Zn7EsRsz/X9wlCAInboA23fk4SvCtLIfWAcvCUn
 ynSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781521043; x=1782125843; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S/wz8lKERvbYqf5bVZv2UL7q03dzo45KKXIRywWSaCY=;
 b=EgsGvmDWM4N4lLNx5cF9bPkeVmS59Mp59Lzbg4T7lHpiV7x0ynq7iEsJdtlAe1SDfb
 3b656I3TMnW8X02NEb1Q8LwxV4REPvue6Wg4D7Lyvw2PiTfFd/CY/dBKqnV/AVRyONLE
 4up6lDwZ7H0cUjdYImQEN+FlFcnY8SqYRbTFV80AzQofl5b09kqRvd/Fm2XfohYI6JY0
 tEq4/a5Sq3KNcUK5Z13DtTQmSVFvSjcRrWOIHGkuAJ/bySJTlw72DzHYCYC1ZHweZrMI
 z5ksdH228nvVqAHFFYBrGHlsooX3+9Hn0OXnAcmgOcXPDrvY32tkNw8qN9gBk5qvgf9H
 8VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781521043; x=1782125843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/wz8lKERvbYqf5bVZv2UL7q03dzo45KKXIRywWSaCY=;
 b=AWzNFwfODjm89tZcxCdqAKnkzoN3KwgUH6GKtl6aXkKJmI8iW5MSOt2RHSnKjvZchb
 Jic4TfUcDESEtKRFu5FeZ7wj0bwLXUMcC8wO4OwQ0EfYe3qEHFSIwVgpmZAtwVr/R1/p
 EAr6p6dSoyJmWcw0sdkBDZfgx7opdNDpFsYLLU/YP6K107j+6dBu0Nya/E6SFUQv5mvm
 qx04NZ+QYnsZevsP3wj+gQj73M+5B8X3ti4W0RjHOPDsSDTiWfP3mj4EZjYUL0m7Dvcp
 JpHOtcZnRg/yK9vLRjk4On2QGh70nC0WWZJyaFydvqZF1dPolnmu6IW8WdO9QE51wQM4
 2x6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8b9mGsxd/LBDra1RVbstN6EgL6PwHurIjyIh7d/GOI7ilt37uC1v96KOCgSSRkllezxuiQEZSBbNZi@nongnu.org
X-Gm-Message-State: AOJu0Yz9MfoBSSrRkFOJAoFkOsa6urEWdjHOA17FecynCVdQYiHycLQL
 MiEPm/vdz27afj7zUQUltvRf3BN3y58bP+xIy3xIeu4bgQvExrVqYkqa7hEwUbD3B2SPPNuuKUn
 euZPvu3s8C04w3ZhKcjY6rm/Q58co4927UaWHFVYhyg==
X-Gm-Gg: Acq92OEXtzTb+GEhxDBPiXKgAk2VBogDBTavgPQTHldYK8mZL2jfGK2CMz7bnYn/4FG
 V/mrUm/4SwtlFJ7aNJ0/DVtKkZr7xe97sYYa9CPKEy1lXbm/ADqzQtja6EotR++art9YVoBuUE/
 9E8YGqnd1Hqf+1jucAg6sbb9QWoMQUrhHeEhca/bCpR1A0sheoiHkjNYyuRTw4W+DbnmTwtgTVa
 yPI421tBJWhU2afnKK7orj6JbkWNI5jnuxGnA1L3jFdvOmpkT8bm5boAcFhtyE6UiP//TNT/w3p
 DjZOIhcHXbF8hCFfMfW4k3SBF0n7B7Dy0hx9NRyW3MWJFzY7VgYV4w8oR3QRfg9snzk=
X-Received: by 2002:a05:690e:124a:b0:660:460e:2563 with SMTP id
 956f58d0204a3-66278315b87mr12295166d50.33.1781521042754; Mon, 15 Jun 2026
 03:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
In-Reply-To: <20260615100200.266968-2-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2026 11:57:09 +0100
X-Gm-Features: AVVi8CcK9114rxVcfcgzUre6M_pMgbMdzMc0d-r31hNGHyPhIEI2Ir4K7Kfrb2s
Message-ID: <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com, 
 peterx@redhat.com, alex@shazbot.org, richard.henderson@linaro.org, 
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com, 
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, 
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 15 Jun 2026 at 11:03, Gavin Shan <gshan@redhat.com> wrote:
>
> All ram device regions were turned to be indirectly accessible by commit
> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
> guest is started by the following command lines, with GH100 GPU card passed
> from the host.

> diff --git a/include/system/memory.h b/include/system/memory.h
> index 1417132f6d..5878727d09 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
>  void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
>
>  /* Internal functions, part of the implementation of address_space_read.  */
> +void qemu_ram_copy(void *dest, const void *src, size_t n);
> +void qemu_ram_move(void *dest, const void *src, size_t n);

New function prototypes in include headers need documentation comments.

In particular for these, it's really important that we clearly say
what semantics we are attempting to provide with them, so that
(a) when we're reviewing or later updating the implementation we
know what we are trying to provide
(b) when we're looking at the callsites we know what the function
is guaranteeing to us and what it is not, and thus whether it's
OK to use it or we need something els.

> +#if defined(__i386__) || defined(__x86_64__)
> +#define HOST_UNALIGNED_MMIO_OK 1
> +#else
> +#define HOST_UNALIGNED_MMIO_OK 0
> +#endif

We need to do something better than this. We can't
just say "oh, we trust that on x86 this works": it is
neither actually true that the compiler guarantees it even
on x86, nor is it the case that only x86 can do unaligned
accesses to normal RAM.

thanks
-- PMM


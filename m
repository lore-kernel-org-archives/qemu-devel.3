Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F32C8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB94-0005ju-HR; Wed, 27 Aug 2025 04:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB8f-0005Xk-OM
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB8Z-0003Rf-L8
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LE+P3bRUP2E1+CDMzNLWyM2HXRUT6ojfbcwqmem+oM0=;
 b=TmT2unxJzCCUPbwn5c4Ro+1q/dLnnZDLvAzMHoCpB/YLKaeAzfpadxDgCpiSszBrQt/+cE
 l/HJltto6X6SEgdBkhR8XkvulsxO+P/kocMPhtdNYH1uiswcltAKiLPZVL3ICF3i7ZJdlh
 UB4RT9fqR5SZ8Pk/03txm7AnRve8pG8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-qKezM0RTNi-zQWNXLmESpA-1; Wed, 27 Aug 2025 04:04:03 -0400
X-MC-Unique: qKezM0RTNi-zQWNXLmESpA-1
X-Mimecast-MFC-AGG-ID: qKezM0RTNi-zQWNXLmESpA_1756281842
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3cca50781ddso305833f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 01:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756281842; x=1756886642;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LE+P3bRUP2E1+CDMzNLWyM2HXRUT6ojfbcwqmem+oM0=;
 b=Y+PGp5KS7NzJCwRxlNBKYOwwXxosqggu4jI7pL8WIi3DRHuw8JFQ1WljNy1eCfwwYS
 S15oLMkEZPRz2l1liUcUiMm1T72H36mnEiEX5IqnXFUMit+oxqKPFC/Dr6R4eSkN8W6v
 hSYymeLoA0nh0mqgJj4o35MteHUeZyPhiw78QUhJkZgS6c4yu2ayodEuVxNnNYs5Oto9
 miNXEXFjC7I/7lhavdfSTBql+DXHYpNah2Beh2pVBu06OKALdJrlTr5vjQzfVZStfPpV
 e1y4RXzNMNLM0dSoKWnHOc5vyD83qJ7XUXQKkhBOdV4BLKTBHae2IskK1+Lj68dh/+de
 O0zQ==
X-Gm-Message-State: AOJu0YyKzi3IdVOzOhGR89CXPahPjPJHC8pZmf5X02QZ0QmD5W65rLSO
 lIZ33V/b5AIYSriuUhWvsnfuyPmQzDFTDJXRpSGvbvu7mhWxpK0FN/UYYoRbAOAZbyIdA47y512
 9+QIIlD6XXTaiRYI76MpAsgQKYk2jm95XAKb+hbzXYTR7UGep40wX3tnf
X-Gm-Gg: ASbGncsKmm7AKI5MIqkn5wyWOxvlDnMAiT0ZFRnwT52AmS56Qf1aKWPj2rnoxKSU8Mx
 CVn0hArKEkEJpdzwdJJnxYzA9UzdJ6J7Rw7ujHZNKud9PTqXLDtUzbV+qrkHhqWMBPdrj4LaVnA
 5bURBPmuOytW9IUVqZr5JHXk+K5Y2AwmfQdzNVMoDqCwRl9zhyoKMem/M+nCCBvzjRBJPGTG1jo
 p23i+B2NPmDU+DWP339jFvj54NC/gCDobmNL90Dz848Xei5bnfNiEj/3wkvBwVGW+Uz1k3TfMJz
 tfr1wV8k39Fg7XI1g2G4HMFNzP0bCf9GQL1s4ggtaEicaBjYdAQovdrHzYaa7Flg+jqBp4p2tl3
 LOMCi
X-Received: by 2002:a05:6000:4383:b0:3c5:9e0f:7607 with SMTP id
 ffacd0b85a97d-3c5dc734286mr13427451f8f.33.1756281841780; 
 Wed, 27 Aug 2025 01:04:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXWUxumYr7retucVGT8tJoNIjREdTtbh3QALl4HJjZToU8rtyWxR1HkARGxfcErte8h3/8jQ==
X-Received: by 2002:a05:6000:4383:b0:3c5:9e0f:7607 with SMTP id
 ffacd0b85a97d-3c5dc734286mr13427420f8f.33.1756281841307; 
 Wed, 27 Aug 2025 01:04:01 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-247.pools.arcor-ip.net.
 [47.64.113.247]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4ba078sm21348825f8f.4.2025.08.27.01.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 01:04:00 -0700 (PDT)
Message-ID: <cd274edb-fd19-4e06-806c-cc8f30b6f32f@redhat.com>
Date: Wed, 27 Aug 2025 10:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix typo in xive doc
To: Aditya Gupta <adityag@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20250827053228.519707-1-adityag@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250827053228.519707-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 27/08/2025 07.32, Aditya Gupta wrote:
> "Interrupt Pending Buffer" IPB, which got written as IBP due to typo.
> 
> The "IPB" register is also mentioned in same doc multiple times.
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/specs/ppc-xive.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
> index 83d43f658b90..968cc760d466 100644
> --- a/docs/specs/ppc-xive.rst
> +++ b/docs/specs/ppc-xive.rst
> @@ -157,7 +157,7 @@ Interrupt flow from an O/S perspective
>   
>   After an event data has been enqueued in the O/S Event Queue, the IVPE
>   raises the bit corresponding to the priority of the pending interrupt
> -in the register IBP (Interrupt Pending Buffer) to indicate that an
> +in the register IPB (Interrupt Pending Buffer) to indicate that an
>   event is pending in one of the 8 priority queues. The Pending
>   Interrupt Priority Register (PIPR) is also updated using the IPB. This
>   register represent the priority of the most favored pending

Reviewed-by: Thomas Huth <thuth@redhat.com>



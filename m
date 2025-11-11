Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D86FCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 07:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIiZR-0008Ni-Cl; Tue, 11 Nov 2025 02:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIiZJ-0008LD-Ti
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIiZH-0001SO-H5
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762845210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N2oDoIi3kGUSb81MXjIrh3MG8OL7GfYbSAOBTE4RDcY=;
 b=fJVkEZ8/3aFlZ0ffTHda9hDRXGAKjOkdXs+zt9vsd6jO0Fw0WftIkvmOob0xLGNVkGF4pX
 oVmTk9ry5+2VnzW6aKixQ+yq0z1aUCqrxdsLchFiSrX6FauS5/zmq6d2YjIga8xNlU4ioG
 JjL7nluDd+SeslgIWFW8DTIq2liJecw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-sZxt_0zfO9axpJOfv5pOig-1; Tue, 11 Nov 2025 02:13:29 -0500
X-MC-Unique: sZxt_0zfO9axpJOfv5pOig-1
X-Mimecast-MFC-AGG-ID: sZxt_0zfO9axpJOfv5pOig_1762845208
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b6d4f19c13cso365787666b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 23:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762845208; x=1763450008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=N2oDoIi3kGUSb81MXjIrh3MG8OL7GfYbSAOBTE4RDcY=;
 b=FFxCv3HGEzYZs2RCuOjzbrC1Bg10ZWW4rSsrCG9lxP6rT+4GhAv6Mrc+Pwo028KhC6
 wgVR5v4N15TYusoWKZLKhxQHbWb/sgXI8trFEDZ1EBK3pKpTAxjMnYuKnWFawVlW2pDP
 gHKg13hyfn9/Ju5M/m8lZaCqnAtbUQnj5KX9HsIrGiWfZWPnIB+B2ACjrmSvM2LjCe3z
 Hv5fhcSuaVNTobD/ZB+tppI7AfOUrKHTKKs6sdBngoLLTCAL/F7EvqAS5nfdzxElCZ4t
 7IfctC1QYWj+Pdha6uR/8A/db93RuSkkLiqht6X9u8yaUJsfBGpA1hwO0QsiFA+pAxO7
 uT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762845208; x=1763450008;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2oDoIi3kGUSb81MXjIrh3MG8OL7GfYbSAOBTE4RDcY=;
 b=klpy2ZANWoJzh+k97aa0IXco7l/kQC2cr0tyktiqHpjBliUmlVpn8Y89vwthhbiVuh
 SbdqIItndR9EZSqJADKSubPoiU7rKqpArR7SIeNNouaKkM0mmm5XyuGYKZI/gKGgWqgL
 FfejnXQ2yxZ0zKjTfpp9qyuvXBqn0ZSON5hs01bBM93ZlP1Yo6kEtZG5CfwI/EtKJjdK
 Pc1rvzslG2BFcZzq+qDuAKHFd4snuqxu4KgXHbm+CnXkZ3EoxdlkOfbOeLVUF8xU7JOy
 uZDd1cOv9dfvXlfQP5r4tdAgQQTcg9kk+jg4piRlD5OrdM7kqeS0dkVILZImPSpO6OAU
 exfQ==
X-Gm-Message-State: AOJu0YyZtKEN4ApQnT/sjOkGkN2N+dq1f0Oto/ikFB+3zG9TMQVk3fDh
 sz4dIO/lvLAdkR2zCk9t6/bO5Hv2N9U0T5pYjy/qYE9qhS75qswNnkshqDLYn44UGJMhqSTDMDm
 SKRpcPrzXmfbghuTEIkteL1nunA3RmQR3uPCWxGkTD1n/RMOoUA08VpcH
X-Gm-Gg: ASbGncvUXGPR13aJ6VMfQ0itD625uBl7k/WKkdaqVA5qi6Z0nJpt/uPjORVIqQevQEE
 C2c6gPrfU3hX1X3a4WG3hXmxZYAxH7gS0OtBZevclDRqoBGCQOdpCWXBzrAUWQWkyBmU7l/xJWE
 1Soez4dDfjcoGtYKRpvII8A4bRwW/+I62n+C5Wzwmw4fIjgjH1ikpFAsHTohR8usXA/tWr2kEEQ
 oEtlGIh+DamOm/+22wZVKhCn84vhQ45BOk20Bs4arbWltBzYUxuQ0JaPF7rZcxhLlxXmBM6QxH7
 c5O07WVpo6lzQgj1Vnr4YYwt9W1i6tYvsUHT8an2gYNhCgAsPIWrxq9D/WG7QVdyI3XkaFs=
X-Received: by 2002:a17:907:3e15:b0:b72:6b88:5cdc with SMTP id
 a640c23a62f3a-b72e02ca207mr1039808866b.7.1762845207739; 
 Mon, 10 Nov 2025 23:13:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ7wEEATRrrNSuFEAB/VHrk8uFEi98iuxIP8VZ5HwNIEx7IciNPBIWEE1Bx6f9m/cIkeB/EA==
X-Received: by 2002:a17:907:3e15:b0:b72:6b88:5cdc with SMTP id
 a640c23a62f3a-b72e02ca207mr1039806866b.7.1762845207315; 
 Mon, 10 Nov 2025 23:13:27 -0800 (PST)
Received: from [192.168.0.7] ([47.64.113.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bfa24d2asm1262836966b.70.2025.11.10.23.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 23:13:26 -0800 (PST)
Message-ID: <2c58b1c2-13c7-4551-bcf7-bf214933d4af@redhat.com>
Date: Tue, 11 Nov 2025 08:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] RISC-V: NEORV32 CPU, peripherials, and machine
To: Michael Levit <michael@videogpu.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org,
 pbonzini@redhat.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, smishash@gmail.com
References: <20251109191532.32419-1-michael@videogpu.com>
 <d3f15618-3f1e-4e41-9e0b-228923c78e42@redhat.com>
 <CA+KCYksKitF6YO390y9JhHWaE2bvKw1nPJ0Axq8FvJyCgEEfqg@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CA+KCYksKitF6YO390y9JhHWaE2bvKw1nPJ0Axq8FvJyCgEEfqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/11/2025 19.46, Michael Levit wrote:
> 
>     Are these binaries available publically somewhere on the internet? 
> 
> 
> Currently, as far as I know, there are no prebuilt binaries — only source
> files for the bootloader and firmware examples in the NEORV32 repository.
> I compile the binaries and prepare the flash image locally.
> 
>     If so,
>     could you please add a test in tests/functional/riscv32 that make sure that
>     the machine is basically working, so we don't face any regressions in the
>     future?
> 
> 
> I can upload the generated image to my GitHub repository, or alternatively
> to some QEMU-related storage if there’s a preferred location?

The QEMU project does not maintain a storage for such third party binaries, 
so if you could put them on your GitHub repo, that would be great!

  Thanks,
   Thomas


> The test image is around 4 MB, plus a few kilobytes for the bootloader.
> I will add the test of course.
> 
> Thanks for the review and feedback!
> 



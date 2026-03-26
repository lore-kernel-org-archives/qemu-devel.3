Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEAB10A3D80
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5jRz-0000eI-V8; Thu, 26 Mar 2026 08:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5jRx-0000eA-FV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 08:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5jRv-00070s-Hv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 08:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774526666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zwhljb7kpSeHV3qL+TJux5THg5eFALv4HMYI/zEuzpA=;
 b=AF0ZCPnoS96x8D63nxOMbrqYRajeWU71eQu2c1hZtZca5DZPaX7P/4bBnwkMdo4/84zbKI
 CZBfOqyfND4D9o4NMb4Qkxgqrs2rpN4Li/SgIVAg9Vrufyjq64bFzKhjDrBTMgp99+PcQL
 wmJyN8/I/LE2tjPxrLW/tInXWfjcZHY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-aCeNwJMjMdaB_pBhC_IB8Q-1; Thu, 26 Mar 2026 08:04:25 -0400
X-MC-Unique: aCeNwJMjMdaB_pBhC_IB8Q-1
X-Mimecast-MFC-AGG-ID: aCeNwJMjMdaB_pBhC_IB8Q_1774526664
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b97f04b44b9so137416966b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 05:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774526664; x=1775131464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Zwhljb7kpSeHV3qL+TJux5THg5eFALv4HMYI/zEuzpA=;
 b=PfjP9QvZY8IinaqvXrmPVcaTeDV6IUcAI7UcP4FkEb0PCAzQ8/ubI3yvjc+zoyPAN6
 Zqk6h8vHb8lOqTcf/t+PIECLLDBfc0oLmcSlNAoFllubeoOF8fBHkel+TsHIz/0iQdeh
 4K6b+fnosvyi+qNAKfiwZNgzRIf4ftttCg1M3nGEGBDeHwOWvtP6SnfRGDlr7YBl1vCU
 kg8Iga6zsQeQxsDVJQDznYd1P4PlePNT5nOu7VyG+SdGawiX9OJy0jpydLp8nC6OPbog
 F5iGBKGvn2i7ktIwqtmPnrJ3DH0KqL2U02EMvU+YI+bz81b/ex0s6RZGFkphtC8IK/iA
 CRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774526664; x=1775131464;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zwhljb7kpSeHV3qL+TJux5THg5eFALv4HMYI/zEuzpA=;
 b=bmjM7pJByNR51krqCV2rFoIssZoSE+1sce0VhLyhOC9cNiMiMv2+UB2Fg1CAABbROx
 ImATZgLNj00/VHqxgCOdVvaXaDRxGa4G3jcCsKiabTlYoMGwNltZz/RViattPbl3urCm
 GTUHRB8q2YvgfFKmqJC8HMFCw3UUV36aEtPsvXiXdUNUEeMs9E6V55ARNsGCn0dQec5W
 kqzD7lKWQ26xY5RmmirizDdjSEPeNLAnmveVbjtdanw6eGHjlCuQsR3gkxoyUpBWIJgu
 Ek4IBnf9Luxmo4CQZUdphcGaBuiXKoWEYsAa94iX3NE+y73lKHrNCsqW9wIa6p5SUgGE
 ZbbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkWaBVJOkZxAbJLjgdqpJrymBc5vR5tFjbQ8XSH9nt3n8QjCTB7ysVUWrivBSZ8hF+8ELZQVDZDmtD@nongnu.org
X-Gm-Message-State: AOJu0YzKgSsJWB7OO9mHdMjaX0nE3ljs6Cu7CMhDtr4A/7aGx5vuxtQE
 00Mlu7TEPrn26xOlJdes4/sFBapM9cf47Qyjdqxy9MbOz5593FyC0j0Nf1wkSOd4FH1GNVagEaV
 A4FhI8O2bWx4HrAmgcyRBGp0K4WDIP1jxAcFcD7NqivXbHxpJVjbOngZ9
X-Gm-Gg: ATEYQzx+LhwViBH9GoaCSKhgecWdkaX1VOf2466PPV8uQejEMZzVglMsknq8eozKqWX
 T21u+20754ujYO9fEducbfOX76livEU4YKson2fHZE48LlV6MmqHNlBjPQwOlS5zh5o81o66Jr8
 vpqfJBwjRazWNvSAUAhO4k946T+O7zJaFYTHAZevXKktkus7vRioQGIM0pGdkqfBoChTz9JPY1K
 X29d/VMRDA8P5E5Rg2D8O3LqmATlTVexxvjHbZA77cRl47GKwlFz3OK0zSTrH0/fjnARWAIlvt2
 585IhTYZWGSAnwD8LLx+eZnMEJN4lk2q0JSa/qcYm/gWHxT9j8IbEK0Wrvg+It9viVE9odirG9k
 d3qzJxv9hTZZ+9R8yjw==
X-Received: by 2002:a17:906:1542:b0:b98:70fe:cd95 with SMTP id
 a640c23a62f3a-b9a5428fd5emr447028266b.53.1774526664076; 
 Thu, 26 Mar 2026 05:04:24 -0700 (PDT)
X-Received: by 2002:a17:906:1542:b0:b98:70fe:cd95 with SMTP id
 a640c23a62f3a-b9a5428fd5emr447025266b.53.1774526663502; 
 Thu, 26 Mar 2026 05:04:23 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.85]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b2026654fsm113890466b.22.2026.03.26.05.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 05:04:22 -0700 (PDT)
Message-ID: <f6045fed-60fb-47b8-8241-a6fcb0af7292@redhat.com>
Date: Thu, 26 Mar 2026 13:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/vga-isa: Fix migration of the isa-vga device
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260326113457.159065-1-thuth@redhat.com>
 <CAFEAcA-xWtr=Xgst=MOVcm+TxegSvNVXmDP_RDVDOvJJW76Qeg@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-xWtr=Xgst=MOVcm+TxegSvNVXmDP_RDVDOvJJW76Qeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/03/2026 12.59, Peter Maydell wrote:
> On Thu, 26 Mar 2026 at 11:35, Thomas Huth <thuth@redhat.com> wrote:
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> QEMU currently crashes when migrating a guest that uses the
>> isa-vga device as display. This happens because vga_isa_class_initfn()
>> registers a vmsd for vmstate_vga_common that operates on VGACommonState.
>> But the isa-vga device is derived from ISADevice, not from VGACommonState,
>> so the migration code tries to fill in the data for VGACommonState to
>> the memory that is a ISADevice instead, which is of cause causing trouble.
>>
>> We need an indirection here as it's also e.g. done in vga-pci.c, so
>> that the migration data gets filled into the right location.
>>
>> While we're at it, also drop the "global_vmstate = true" here. Since
>> migration was broken for this device during the last 15 years (!) anyway,
>> we don't have to worry about maintaining backward compatibility with this
>> switch for older versions of QEMU anymore.
> 
> That means the only remaining users of global_vmstate = true are:
>   * TYPE_VGA_MMIO : used only by the MIPS Jazz board, which is not
>     versioned, so we are OK with migration compat breaks
>   * TYPE_ISA_CIRRUS_VGA
> 
> I don't suppose that migration is also currently broken for Cirrus ? :-)

No, Cirrus seems to be fine. But I think we should likely do something like 
commit 1fcfdc435a3e25ab9037f6f7b8ab for the isa-cirrus-vga device, too, so 
we can at least get rid of this in a couple of years...

  Thomas



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69FACCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 22:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAc38-0004XC-HP; Sun, 19 Oct 2025 18:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAc36-0004WQ-Jg
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 18:38:48 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAc33-0003bN-44
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 18:38:47 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b3b3a6f4dd4so691686366b.0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760913514; x=1761518314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fUlR3DVhrkXnHMUK4SdPqCGl1e6I+hLWWy62h9Hp4c=;
 b=h1mGxFhLVwA0sULH9tMaSn17oDepr+Sv9+joIC/YMDReaUqOthZt9zR+DfTc6DKBnX
 bQWvIlcf5t21QKsEiUHAeqmN+gTLdjEXg5Plda7LEzze0NvK7b3BEO4FMHsFJqPmGI6D
 aFmxBuJ8EDq4pYG+lbYRZbhlPvzEZEictoGl/MO071FEf2334KvDf/0nheXRpBQiuqBC
 kh0RQBkCIMsP+rRf6NMhhexMLIc7VPR8Rta/N8GFv9oaQl2e1lV/okvn6l+Lgk6IKZoi
 /FgBzM44Uzcc+iUn6YqKGPmUXOhhIwOJTzSzMbT/+2p0/A+OGyBWuaM89fYwiZ80viAl
 dmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760913514; x=1761518314;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fUlR3DVhrkXnHMUK4SdPqCGl1e6I+hLWWy62h9Hp4c=;
 b=vgcP699K1kF/uZWyTiFQogOoe82Hx91qLLInoRw2TYH6A3jNtWhvPdvui2x4jQgSEP
 TC0Z7GxbMESEDcAlzT8NsazZHz1+WwmgHvO7y6uiPEdJ+fzMNhCNzncREz7b7Z54snQX
 V3lD98aFFZ6Bo44BYQzcDbubrq7O2yPV4fLvdBpk+zEMqKL5E//KNhqWov1Ydoz8arql
 WsCB0DBGuS9EI5R1ytC9+oMssy2Z0MnzI6PjSefVUStQqxFVEsmOH1QZjEydFQ6oHxHk
 MG8UNTqdsGdN4ZKdRLuy9r3/q+Z+QIDkJT9b6JfEcGeC6yyXmApVgPJiZrEVrd+8cd/o
 Lfqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl0VvBq5xcC62ahOhxLLe/+cTbDp5YyhUzlr6uRQ+VDw0ky7ZCWPAEp7nBaZVN45qUfc/+banma4NL@nongnu.org
X-Gm-Message-State: AOJu0YzRqrquFxVhjVLkvZecFiHq42LG29AAwwfaC9zV7bmxRQvl5XtG
 1K/0JlBTTMM4w2VQN/UnGxFVei0OyW/GyWWlGFZuBn8LMlRSRxjqqPo7
X-Gm-Gg: ASbGncvQHHOrB6Edv0UJeLJujCPJ+wkHeTlC8k9fueNuFuww9sz1OdsErUuSpqG2mn6
 rBEjdmBTl8JJbTqwMtt6Ml6UtNWppjiSk7AXua2Cy2PcLa3difFx9YUJI+Pi/9l04DHVnrwCAhl
 T+MOK7B7CIwVYWr3kaR2k2sX/aSCMfxOkmb3M5+EpFvbKXbIbJp7unKrOUvEwgrB+SC/G+gxosV
 Fnh4+rXlkvaYHsooPYWF8PIe4YbWzkzk6B3EvJCOwDMnuB8aNHmaEwgkA6DkQ+ypagT+0RNZKIi
 6HdNmnAB9dGU7JsQNMuVtAiqQRndwUfnNsw9M58HnwRWcHaYtGRfsof4XUeEOytV5DpVr1c6tM6
 gCG8YlrIm4ceASIbK3f9XD4RRcNtYWiliF1iLg2sVG4gRzrN2vtk53OTguGl9SAehfUnCc/dgjF
 niC/RGWYDGVwDVOuF1bZM6PMPUm2Ss9906lpV7sO3M40MqS678Sw/3Z1rvQ8ThNP2TtJmrZhtjl
 iSwfdrNTF7R9bl/PEjHSbsNGiuZvwHLtqppYKoQxBjL
X-Google-Smtp-Source: AGHT+IFY1AOFnz3uKVjIXWfRbHvZOYANfaygBNZ6f59WAGxWoNrkwB1vfYiS+VunXq5N8M44mfer0Q==
X-Received: by 2002:a17:906:fe41:b0:b45:a6e6:97b4 with SMTP id
 a640c23a62f3a-b64764e2fd5mr1237253066b.50.1760913513550; 
 Sun, 19 Oct 2025 15:38:33 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1c27-9400-31a8-03e5-9396-b647.310.pool.telefonica.de.
 [2a02:3100:1c27:9400:31a8:3e5:9396:b647])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c48a928cesm5246447a12.7.2025.10.19.15.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 15:38:32 -0700 (PDT)
Date: Sun, 19 Oct 2025 22:38:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
CC: Roman Bolshakov <rbolshakov@ddn.com>, Laurent Vivier <laurent@vivier.eu>, 
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_09/11=5D_hw/intc/apic=3A_Ensure_?=
 =?US-ASCII?Q?own_APIC_use_in_apic=5Fregister=5F=7Bread=2C_write=7D?=
In-Reply-To: <3C9DA9B8-8836-42F6-85CD-AB60327363EC@gmail.com>
References: <20251017141117.105944-1-shentey@gmail.com>
 <20251017141117.105944-10-shentey@gmail.com>
 <f074aed2-7702-4a4a-a7d5-7abeb29ea663@tls.msk.ru>
 <3C9DA9B8-8836-42F6-85CD-AB60327363EC@gmail.com>
Message-ID: <BDA99DB9-7585-4C1A-9B4A-DC07AE78EBE6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 17=2E Oktober 2025 19:34:36 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 17=2E Oktober 2025 14:58:50 UTC schrieb Michael Tokarev <mjt@tls=2Emsk=
=2Eru>:
>>17=2E10=2E2025 17:11, Bernhard Beschow wrote:
>>> =2E=2E=2E In apic_mem_{read,write}, the
>>> own APIC instance is available as the opaque parameter
>>
>>> diff --git a/hw/intc/apic=2Ec b/hw/intc/apic=2Ec
>>
>>> @@ -876,7 +870,7 @@ static uint64_t apic_mem_read(void *opaque, hwaddr=
 addr, unsigned size)
>>>       }
>>>         index =3D (addr >> 4) & 0xff;
>>> -    apic_register_read(index, &val);
>>> +    apic_register_read(opaque, index, &val);
>>
>>I think it would be better to use local variable here:
>>
>> APICCommonState *s =3D opaque;
>>
>>and use it down the line=2E  Yes, there's just one usage, but it is
>>still clearer this way (in my opinion anyway)=2E
>>
>>Ditto in apic_mem_write=2E
>
>I agree=2E Will fix in the next iteration=2E

I couldn't use the opaque parameter in v3 at all, so I needed an `APICComm=
onState *s` anyway=2E

Best regards,
Bernhard

>
>Best regards,
>Bernhard
>
>>
>>But it's more a nitpick really=2E
>>
>>Thanks,
>>
>>/mjt


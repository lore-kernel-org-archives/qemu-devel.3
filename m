Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D27C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp72Q-00058A-OR; Mon, 03 Mar 2025 09:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp71Y-0004lC-1M
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:44:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp71V-00053y-0j
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741013038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M+XGmihHeC1CWMyixVNN6ExRTygsQVGpTyYrnlyxQAk=;
 b=Hg8eK8NrsgQ6L1whuWfHv45mcVrBz3MuHi/yH1FE0FVoIcCmwtnQIe64mti0O5HytHgXZa
 7yWKODr20gsCUKRK2IZYNf8RymKtXf9z/Nc2aEdV+lnc7NfJYS6NL4/H5w+RJYkby3cm0Z
 4xkPdGA+OJk1f+CnS/9S7TM5f8lacHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-dfFXvW79OCGw9dh5i_afEA-1; Mon, 03 Mar 2025 09:43:51 -0500
X-MC-Unique: dfFXvW79OCGw9dh5i_afEA-1
X-Mimecast-MFC-AGG-ID: dfFXvW79OCGw9dh5i_afEA_1741013030
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43942e82719so32344085e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741013030; x=1741617830;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M+XGmihHeC1CWMyixVNN6ExRTygsQVGpTyYrnlyxQAk=;
 b=TyRyt6pJNT2r61EhuY7za96lHa8nOn8MQyAm07Fv6UG3Fs/G94g6O3zqxCTHtP49Xn
 VxqVhsl/JsZAkRiF+qgDyGP8feLZzoDwzpzJi8eMuNf2cGcd30tYFlz10LuadazXRrXO
 YzGfROUQQNTnbtzIKeLaZ6oENUVhVSwj5D2fh45IGo+4zaFSEJAlzVx+5Ju/JcPEGZiZ
 SxD3VLWmAfgC/XLFoVR3El1FC5qcJ93lHw9M0SNIsd0T03ciaziJ25OdRuSsuc5EbkAc
 N2TghjU6fZdPeo1iy4NRbdeqw4pUJsDIQBBdYaTxdpLYrj47kfKan9LmzCm1e5AKOnOE
 LJJA==
X-Gm-Message-State: AOJu0Yw2A+8RmyE15SiTkPp0uErb89JWrirmq5JsK6uoTmvD8DFHyj4y
 Pj6Q7/JQBK0DJ7A/fhTzzAFLaOy7vU9XMf1Wg3jMe/pPMz6CJUikc5ij2xusgSff3kLd+8plsPy
 UMP66XqAZiYFCyOGktyXYaKJV2ihjc63XdNXN3dQj+7BS6C8Tip0B
X-Gm-Gg: ASbGncuqh2Ad/wfPRQErGVNTumGpK2fqF2m4GWU0ZSrnHKAHYzrn+98DVLTurZ1N8+d
 Y1IAGsSn17mvfOGm8ZwfbfZrjof7kKj37b4PF4L/O3/U8lonyAuuCbZI3I5wvHFEELVQCDotuM1
 DYBlF48jSS1alLcRIENYhFTmnB2R5VMMGbeklyILYk0Wkqd1IEdvLosmDfkAc2VlMNQ+2IqLShG
 F6up/MbVOKOzcus6avzafLwK+4HTcEVxgrD5w3qi1u8d9oC/KIGBRm2rbvXRxTcAhKMVxTSh8TV
 ENP5dKHS58XWmGUWMAw=
X-Received: by 2002:a05:600c:154e:b0:439:6a7b:7697 with SMTP id
 5b1f17b1804b1-43ba670fb9bmr115624985e9.14.1741013030168; 
 Mon, 03 Mar 2025 06:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7RlZ/cBoIrdMQMxy+L+SycDX/Xy3nCucVSKjU+h/kxSJXXm+xIy5tIt+Uz6Wmwv4yf6D2TA==
X-Received: by 2002:a05:600c:154e:b0:439:6a7b:7697 with SMTP id
 5b1f17b1804b1-43ba670fb9bmr115624725e9.14.1741013029774; 
 Mon, 03 Mar 2025 06:43:49 -0800 (PST)
Received: from [192.168.10.48] ([151.95.119.44])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43bc5a32e62sm23423135e9.25.2025.03.03.06.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:43:48 -0800 (PST)
Message-ID: <7982159d-710f-4948-830f-ab61b100a5d6@redhat.com>
Date: Mon, 3 Mar 2025 15:43:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/26/25 17:26, Cédric Le Goater wrote:
> On 2/26/25 15:12, BALATON Zoltan wrote:
>> On Wed, 26 Feb 2025, Cédric Le Goater wrote:
>>> VFIO PCI never worked on PPC32 nor ARM, S390x is 64-bit, it might have
>>> worked on i386 long ago but we have no plans to further support VFIO
>>> on any 32-bit host platforms. Restrict to 64-bit host platforms.
>>>
>>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>>> Cc: Eric Farman <farman@linux.ibm.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>> hw/vfio/Kconfig | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
>>> index 
>>> 7cdba0560aa821c88d3420b36f86020575834202..6ed825429a9151fcdff33e95d1a310210689b258 100644
>>> --- a/hw/vfio/Kconfig
>>> +++ b/hw/vfio/Kconfig
>>> @@ -7,7 +7,7 @@ config VFIO_PCI
>>>     default y
>>>     select VFIO
>>>     select EDID
>>> -    depends on LINUX && PCI
>>> +    depends on LINUX && PCI && (AARCH64 || PPC64 || X86_64 || S390X)
>>
>> Are these defined for the host or target? 
> 
> host.

No, Zoltan is correct.  They are defined for the target, so if you build 
for 32-bit ARM you'd still get things with "depends on AARCH64" in 
qemu-system-aarch64.  You can check that you have

config SBSA_REF
     bool
     default y
     depends on TCG && AARCH64

but on x86-64:

$ qemu-system-aarch64 -M help|grep sbsa
sbsa-ref             QEMU 'SBSA Reference' ARM Virtual Machine


> As per commit 6d701c9bac1d3571e9ad511e01b27df7237f0b13 "meson: Deprecate
> 32-bit host support", support will be fully removed in 2 releases and
> it doesn't need to be addressed by VFIO.

Note that a deprecation *allows* full removal in 2 releases.  We have a 
lot of things that are deprecated but have not been removed.  For example

    Short-form boolean options (since 6.0)
    ''''''''''''''''''''''''''''''''''''''

    Boolean options such as ``share=on``/``share=off`` could be written
    in short form as ``share`` and ``noshare``.  This is now deprecated
    and will cause a warning.

is deprecated to *allow* switching command-line options from the 
"qemu-options" parser to the "keyval" parser that doesn't support 
short-form boolean options, but it's unlikely that qemu-options will 
drop support for short-form boolean options.

Paolo



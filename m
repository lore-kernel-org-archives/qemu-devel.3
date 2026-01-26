Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44B1C88E58
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkH7n-0004w0-Gh; Mon, 26 Jan 2026 02:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkGy7-0003Pk-TP
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:25:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkGy6-0007PG-78
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769412300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5phl15O/Wo8tMH3pRsKVPcDEhul8zW1nDTaNBC1Z5mI=;
 b=Pzwd5w394Tk/cx7LKR985rsKg5cUjgvomTstDnPd7RNqp4J9zdKtDeEAh4NJIfCuaXP3mI
 N/19FpzuF3Fu//C9cScK3VeK+iggE6EY7nJW85Dwdbbf+GDudRYW9+HfMdn24JfrvRR1iF
 5SE0YcmHJ62dNq+DiCFOyVbXMY1rmEQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Tjo6COQUOAO55rZxiMPQXg-1; Mon, 26 Jan 2026 02:24:58 -0500
X-MC-Unique: Tjo6COQUOAO55rZxiMPQXg-1
X-Mimecast-MFC-AGG-ID: Tjo6COQUOAO55rZxiMPQXg_1769412297
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee3dd7fc8so45297015e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769412297; x=1770017097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5phl15O/Wo8tMH3pRsKVPcDEhul8zW1nDTaNBC1Z5mI=;
 b=XQb9mQE5lxaMutLXLhcW/IsF8G6MfcaspCoxkXRVHPyvCWWIkGW1h3Xa/AIAumCd5l
 DOHaEAGTYQZMVG5BAcIz3J0PQqgLST8y69s4kaTkQeVJXsINsJihHndE3SYkVx/jGnf6
 MfmwDyTMiq7DUhU+8CVN8bl6DUvDwG/8MURvIKSGOB7OwqPCfpk9gwnSH9tbrR9jVkk0
 /ESJT9BSrF1olv6DFNDCTw3w8QeH5CM5g3qCJ9xODX8iixemu+sEbZJ0/7+nAVludC5n
 +vxGErUQTrsfa+WJjDF7Z+3ErxSc/5yYu1BndM7qQZqw+PZj+m9ztweRhPWoEKflGIW1
 CWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769412297; x=1770017097;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5phl15O/Wo8tMH3pRsKVPcDEhul8zW1nDTaNBC1Z5mI=;
 b=KFlmvlLLub2XWBylnS73el4OwpHJ9lH5O3DJb4e0FJEYNyqBWOsor0M2H3FlSh/M/j
 IVZXTxzrESZ25X28E8cTLdzKcw/MJlN6IfnykPkx8Fwnizrrc0YqVgYah2FcuL+Xg8of
 jTiVGMFp2XEVyocAgRiIb0RBAzbVF+4gcCMdvC3Dr9e6izYK8O9621O3jaiESz3qubR7
 cWaMpqMA8b37ycQ2npIlyv+ikcvZsEBuue8zcFPV7+2hUKV1U4auEAjwfgTJ4Q/utlXs
 lhmpE4EhJ/RzLBw0NCVdxA//Bs4scHwjCpoun5v1zB0+Cu1+x0cWuCoAE7Eyhwdhwnbt
 1rww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQaTKhdJsHnoGy6p5ghNR417HraqiPAfiqjiYiM4HAGKsE8ZRjl87UBVF7TwltKKzy7h9X+uWPG+Mx@nongnu.org
X-Gm-Message-State: AOJu0Yye1ZMWsSD9MvndhshHqmORUnCBKpW55IL4+icBAzqDYC1j9u8k
 JOEqKk2lnbm7vGBsS3i5eixoc27q9UjNJV3p2ZByrKAPOUePS4qtitpEXMt8mCicrhgfzbqJAHt
 laYnjyWGqH4DTB3rFrHzJdsbmmWPOv5cp7UAqaMMA6fwjunHYT2M44UPe
X-Gm-Gg: AZuq6aKOIkEljRpacH2HBP/CpUkGtYPksm/VeXVamTCMuGKxMDyx5ET+IPTmLrkayvX
 IzpV/jQsu2XxwwwyXC4MzHqJ6kzVclI7C9A+uK6wxPeKPPypPES+hgdEzcBpsPe/JxLArf5RmBr
 ShfED2f+EIKD9UFQLG4y7JIE6egospZ7Cf5g0nB5AGyNg8E6DKjpsNDc9AbG/hwNfEp/Izq/PeD
 jbaxNucIm8RWFHCEu4Uq/ZlnI8vgfTPpSe69/bxuIQsPpJ5PoDN8PSbyoQW6709iwKAHsH1P4Px
 9doaCMBzaYELf9UCA795/ghiShN9xVGu8zPQG4QGrkql/Ks7o5IxwqwafSk2B47qwj3g/lW85J/
 nKerkAsRNgiafunwNgKlsY6Wms6zHCv+nS323nZ3W4wQEhq/l
X-Received: by 2002:a05:600c:1d02:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-4805cf66b45mr60219105e9.26.1769412297364; 
 Sun, 25 Jan 2026 23:24:57 -0800 (PST)
X-Received: by 2002:a05:600c:1d02:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-4805cf66b45mr60218785e9.26.1769412296975; 
 Sun, 25 Jan 2026 23:24:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm26612786f8f.38.2026.01.25.23.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jan 2026 23:24:56 -0800 (PST)
Message-ID: <c4e4310d-0247-46af-93cc-c1b7cfa58057@redhat.com>
Date: Mon, 26 Jan 2026 08:24:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] vfio/pci: Grow buffer in vfio_pci_host_match()
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <20260125-nvme-v1-2-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <4ad2cafe-9518-4cda-9b25-228cee136c1c@redhat.com>
 <9c4707fb-8e7f-4d4c-ae22-0b5ad6f05cdd@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9c4707fb-8e7f-4d4c-ae22-0b5ad6f05cdd@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 1/26/26 03:37, Akihiko Odaki wrote:
> On 2026/01/25 19:22, Cédric Le Goater wrote:
>> On 1/25/26 07:42, Akihiko Odaki wrote:
>>> Ensure the buffer in vfio_pci_host_match() will not overflow even when
>>> an invalid addr parameter is provided.
>>>
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> ---
>>>   hw/vfio/pci.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index c73447272141..3338c4d7b528 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -2673,7 +2673,7 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
>>>   bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
>>>   {
>>> -    char tmp[13];
>>> +    char tmp[36];
>>>       sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
>>>               addr->bus, addr->slot, addr->function);
>>>
>>
>> Using a g_autofree variable seems possible too :
>>
>>      g_autofree char *tmp =
>>          g_strdup_printf("%04x:%02x:%02x.%1x", addr->domain, addr->bus,
>>                          addr->slot, addr->function);
>>
>> vfio_pci_host_match() could be moved under container-legacy.c, with
>> an assert on addr too.
> 
> I have another idea for improvement: replace slot and function with devfn. It will limit the range of slot and function, and is better aligned with Linux UAPI (c.f., vfio_legacy_pci_hot_reset()).
> 
> In any case, I intend to limit the scope of this series to fix the overflow. Further improvements like moving the code to container-legacy.c may be done later.

Sure.

Thanks,

C.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9E6FD2D9F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxeu-0001Bs-86; Tue, 10 Mar 2026 10:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1vzxel-00016F-UP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1vzxej-0001xI-If
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773151309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4byN41MUNTF/BCn5bu7WsWlK6aTnJSlB4DBMYQaCSXc=;
 b=MIDUXM4hwPj8ykJEAUIX/mXIHnszHOHfzYojxF+gI1o9EuLpUcBGcDVwz4K3B7XrwKAdRc
 pcWgMMz/TGqvUuTpioxaDJAYtyrj9mMbr0ErOMHD0574/FN4pYXhPIxKOKrHwD5GcGIUrg
 tDSYH68j6Em/fP0bjxqdbr5XqfFXgv8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-jKruloADMvy-6W6uoJYXzA-1; Tue, 10 Mar 2026 10:00:36 -0400
X-MC-Unique: jKruloADMvy-6W6uoJYXzA-1
X-Mimecast-MFC-AGG-ID: jKruloADMvy-6W6uoJYXzA_1773151235
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38a4b4cd644so19427131fa.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773151235; x=1773756035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4byN41MUNTF/BCn5bu7WsWlK6aTnJSlB4DBMYQaCSXc=;
 b=QYO1gLjVg0UZ1Tph1OPMFxDvQxdX7OUgZjqNWez5Tmh0JLuZbfZmN1NSw1sOymBtkr
 m3bW8cFtExZsOdjAHXFVzwBMJo8syEgSlyDWTkw2c680bf1u34SkU9bttqQ/jJOxDba1
 ycb5l135ton+daYAstAn3W/5UW9nuaH4mv1kIXsQqxycoTWfovjb7WvpyX4llK+GQJz2
 McCRi3Wi7a/QlwqT9ZxLsV0A9K31gwwyfVf6VwwVkU1y/2bHEPgmnVfCEOFweIVkZ1Ky
 lUkdbuYdy/ONQe+m0jguK908uNErQA5+WnWjR+0H8ZYqmba437vsTDwJjp7M44sGvWdB
 Y9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773151235; x=1773756035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4byN41MUNTF/BCn5bu7WsWlK6aTnJSlB4DBMYQaCSXc=;
 b=DSjPtfdQiRrT2SZdvMubxtgr/QqxnjIEi0gGkPpGm8jDdRIfSq0U8GRZ4kFUGxT2Fo
 atY8dk+mC0lhtLtCtar2rPtwbv2vfhNsIfakwIkGM6cx8CnEsuUyWgjthNFyrTNM0AqT
 +5kHr9YE5NYf0LoQ56bo/wsOG0iDoV019LSqE5TWOR1ufzYRrFmHQMnIoc7YwyAS5Gnp
 5DOUA2KwPZLywruZVfc0lIkHE7C2y63xBVf5yQqibusOrUWIVkJaqBmmebyx8e1IKVxg
 RiZ+b7FLRiuGtZ4am9bbNs7tynsysjMT3QpymLaUa4iUvZbSVKRRNptH6UA5gZR7+++r
 2S8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7JSIV2DFZ0x3D99JccMZY6y8W8xVy24B0D97Ju1NdoqdpVXpSTQPnafSseP7pjy0liLCFTel6EMOp@nongnu.org
X-Gm-Message-State: AOJu0YxU7Vqjkc95eVNTAKGCkhtjSkH2TeO8JbZH8dgpYo8ctQ1TQpnw
 ucTozk8uiXPGN/tCaZnFU979QoNPeYwToRz88sFIRYJvdNQt6O5AC9b67xDJ6K+IAHrcJ+grYad
 tF8lwftPdr8SpqSSX1Y1DaCbSMflzENc9VgLdGvDNEUvLgnmN9+2ujuHw
X-Gm-Gg: ATEYQzxgRvN+HNrllWAqhonkQ9+nDSv4FaALU7O1oSLRYc5MIM2WXEahGFA5YUlAroA
 h8GIJ1FNTbH8jwAQMO1LBWjNvfXCHda7VExAbZr/QaMAAZSFRTS4qoBdzkIjeg+F4seLIDf3iru
 GAiW0yBYZlkJ02Fa5zIeSS09frwdL7Lmh2GwUexUGiHADSbNiwKzFTVIWJfpSFBRR1G9zCjBlcB
 qCxy04Ugk4CNRZe0XkQxuu2liOAlvFNqeGxGUBaPRlnFQym4UVaUDRMsH2YBWWUrorPuk8VUVvf
 +cQtyhTTdp1q8RIZkq6aI4QvJrH1q3GG7H234Kiuu84cF0oHsMcKqfcn5Sl8ivLC8AEFI6x1E/N
 n2wJYpnWvr2k=
X-Received: by 2002:a05:651c:14f:b0:389:f86a:f44 with SMTP id
 38308e7fff4ca-38a40d96a4cmr39252851fa.26.1773151234574; 
 Tue, 10 Mar 2026 07:00:34 -0700 (PDT)
X-Received: by 2002:a05:651c:14f:b0:389:f86a:f44 with SMTP id
 38308e7fff4ca-38a40d96a4cmr39252661fa.26.1773151233927; 
 Tue, 10 Mar 2026 07:00:33 -0700 (PDT)
Received: from [10.43.3.236] ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a5cfa1459sm4861041fa.1.2026.03.10.07.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 07:00:33 -0700 (PDT)
Message-ID: <d91c6159-5c88-4424-8c0c-bd19885d3f74@redhat.com>
Date: Tue, 10 Mar 2026 15:00:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] system/hostmem: Remove
 HostMemoryBackend::use_canonical_path field
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@kernel.org>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 devel@lists.libvirt.org
References: <20260307154202.86309-1-philmd@linaro.org>
 <20260307154202.86309-3-philmd@linaro.org>
 <7c4ee27f-394a-4e2e-a67d-0c77921d8a21@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <7c4ee27f-394a-4e2e-a67d-0c77921d8a21@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/9/26 10:20, Thomas Huth via Devel wrote:
> On 07/03/2026 16.41, Philippe Mathieu-Daudé wrote:
>> The HostMemoryBackend::use_canonical_path boolean
>> was only set in the hw_compat_3_1[] array, via the
>> 'x-use-canonical-path-for-ramblock-id=true' property.
>> We removed all machines using that array, but the
>> comment added in commit 8db0b20415c ("machine: add
>> missing doc for memory-backend option") requested to
>> not remove this property "as long as 4.0 and older
>> machine types exists". Previous commit removed the
>> last machines in this range, we can now remove that
>> property and all the code around it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   qapi/qom.json            |  8 +-------
>>   include/system/hostmem.h |  2 +-
>>   backends/hostmem.c       | 34 ----------------------------------
>>   qemu-options.hx          | 10 ----------
>>   4 files changed, 2 insertions(+), 52 deletions(-)
>>


>> @@ -563,19 +542,6 @@ host_memory_backend_class_init(ObjectClass *oc,
>> const void *data)
>>       object_class_property_set_description(oc, "reserve",
>>           "Reserve swap space (or huge pages) if applicable");
>>   #endif /* CONFIG_LINUX */
>> -    /*
>> -     * Do not delete/rename option. This option must be considered
>> stable
>> -     * (as if it didn't have the 'x-' prefix including deprecation
>> period) as
>> -     * long as 4.0 and older machine types exists.
> By the way, this option seems to be used by libvirt - we should maybe
> make sure that its removal does not break libvirt by accident...?
> 
>  Thomas
> 

Thanks Thomas for raising this. Libvirt only sets this to false, it
never set it to true. And we have a code that detects whether this
attribute is present. IIUC false is the default (and after these patches
the behaviour will remain as the same as with 'false' set). So ACK from
libvirt's POV.

Michal



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A42C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxxO-0006ah-7D; Tue, 27 May 2025 13:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxxM-0006a5-Gk
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxxK-0000QY-SX
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748366353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8XjI8PUrGTVgjcxSY+wJwP09QeVT6XEtNZ5AwPPMdSM=;
 b=QzSYbdAt3KbhlB2a5QyoklX35vsL9Zc9TeWKBI2FI0lMfhk3wNjf7ye15p0xXv2NZ0XNhF
 N4z5wlM7nJL/NZCfEtII9BsqjmkY0T7e5lwm/MO0+mJ7B55qZGRNRoD4SwqJOUmdwL2LKC
 p033YLB85YlVE4PG/RhlZ0gmcBeBKPQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-nVLEP2j8MEKekyQI-oyBlw-1; Tue, 27 May 2025 13:19:12 -0400
X-MC-Unique: nVLEP2j8MEKekyQI-oyBlw-1
X-Mimecast-MFC-AGG-ID: nVLEP2j8MEKekyQI-oyBlw_1748366351
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acf16746a74so272746866b.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748366351; x=1748971151;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8XjI8PUrGTVgjcxSY+wJwP09QeVT6XEtNZ5AwPPMdSM=;
 b=GT7a55NVpaj4sGKkET8WLW86zNRimlMBDYaHHcgGVoWTMAqWX4PSbwVv6rKE0+Vyre
 J6TTXSF7lBibe6F+kDs/ZV+OQVqiLzF3XOwJSQj9F9kcnIHgyXb2hT34kiObU0NG+SnU
 6FlIfYw+43FAlHnmm5lVYSA37Yu5bOzfHeM4+p+emsOjubaEALL4dBSdiBWwxpY16Qel
 jvJcCw0cU2cAZp0cI8ZajbuLu9Q/kns6LXwjo36EXEFaXG5SfXKXwaDeWlYYpNsewn+A
 g1WhXNiCN0lEE2wmECX6YYwHxN7W1NoQ8jNfRjA6SHEbs5FKGjN7h4RoUF9wGsVXKpUz
 5Klw==
X-Gm-Message-State: AOJu0YwSfqYAU8GHr53iUHZ2bhUkQvTpdUGzsd2scMl+ey140kE2RtSO
 dIe6G9HB4F7hpjlBRWVi8YYuYKzTmdjIYPUvTyxI/DHOx9kVlGNor3KEf2lrrUtKOTGdv7fZKAR
 ynHSjZ+ZL+uLRlubAYvdeTh4HxbLfpa9W2G24d20cha1fdLJAVAUYxyYU
X-Gm-Gg: ASbGncuAvWNpnI/XcridM8rQyZwtnuqkBaSpYb5FcE2l6gJrV6suEP902gWiCUsGC97
 l1XmhXNOkH7rX92jziO72iPDxLoB1FQIyr04+sVPJ4Iotq2++b2K1Grao/f3VxVEatsKBZHnoei
 JbmYJ1EPbQt1IUyQuvv4x4OUlZM3xNkOxj/R63gI3eFJOsckx/KJ7w+nwoFrz23lq182jjnJKEi
 iAuW6Q4kCSUiCew/z/gNGXOFpBaU/iY87qMS7jLO6y0U5QPmtmY85PwFwXPqZWiecXjWkO9y2Lw
 r4XKvXa7jWMAgw==
X-Received: by 2002:a17:907:3d8c:b0:ad5:5127:873 with SMTP id
 a640c23a62f3a-ad85b28293amr1367775666b.61.1748366350599; 
 Tue, 27 May 2025 10:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7XBS/DR/RUTAQSFnTmI5GEGVnE9J9IMqe/ajoDLRqsNbpgzKpE97eIrHWB1i407djcV81/Q==
X-Received: by 2002:a17:907:3d8c:b0:ad5:5127:873 with SMTP id
 a640c23a62f3a-ad85b28293amr1367772766b.61.1748366350169; 
 Tue, 27 May 2025 10:19:10 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad89375e73csm104441166b.90.2025.05.27.10.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 10:19:08 -0700 (PDT)
Message-ID: <0af36d26-5509-4601-8e16-e420b0e4c53e@redhat.com>
Date: Tue, 27 May 2025 19:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/boards: Remove MachineState::usb_disabled field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Alexander Graf <agraf@csgraf.de>,
 Markus Armbruster <armbru@redhat.com>
References: <20250526130006.49817-1-philmd@linaro.org>
 <1c9f8e9d-1ee6-b2d9-98d6-5640f59f0e4a@eik.bme.hu>
 <649e4c91-fb4c-4cb2-9810-b1ee885ffea3@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <649e4c91-fb4c-4cb2-9810-b1ee885ffea3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/26/25 16:20, Philippe Mathieu-Daudé wrote:
> On 26/5/25 15:18, BALATON Zoltan wrote:
>> On Mon, 26 May 2025, Philippe Mathieu-Daudé wrote:
>>> Only add default devices checking defaults_enabled().
>>> Remove the unused usb_disabled field in MachineState.
>>
>> At least for Mac machines this may be more complex. I think there is a 
>> - usb switch to enable/disable USB independently of defaults and due 
>> to some bugs some MacOS versions may need this to boot so maybe it's 
>> used.
> 
> If the user asks -usb off, we shouldn't re-enable it in the shadow.

And if the user asks -usb on, you shouldn't disable it.  My
understanding is that adding

-        if (!has_adb || machine_arch == ARCH_MAC99_U3) {
+        if ((!has_adb || machine_arch == ARCH_MAC99_U3) && defaults_enabled()) {

disables USB completely when -nodefaults.

If you want to remove usb_disabled, change machine->usb to ON_OFF_AUTO
and query

static inline bool machine_usb_enabled(MachineState *ms)
{
         return (defaults_enabled()
                 ? machine->usb != ON_OFF_AUTO_OFF
                 : machine->usb == ON_OFF_AUTO_ON);
}

instead of machine->usb (even better, change the name of the field so that
it causes a compilation error).

Paolo



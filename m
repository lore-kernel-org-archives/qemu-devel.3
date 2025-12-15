Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5EBD41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 12:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV7tV-0006Re-Ei; Mon, 15 Dec 2025 07:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV7tT-0006Qf-7d
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 07:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV7tQ-0002dO-2Y
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 07:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765802495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SYbHQFn0YRj3pKRKkAd+EYCoIR+oDzB7aB68ZYGXxc4=;
 b=VoRTv3+f++xNtVNuB75kUcfLb7wnP6ECq918aDpXUkw9TH4rofFd1YocT6UOipKnDJ59p+
 97WbOpSdrUXHyLB/eCfLzk+1Zc/xmCBbTbMIiXUIdVJqSFV9i/gz3Ar21lRFVG87JCe3lE
 DXkcADnBdPi6QhJfcUaVrJ107gn1j1I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-KBfOZYaiMyyR0wQ3ClOYPQ-1; Mon, 15 Dec 2025 07:41:33 -0500
X-MC-Unique: KBfOZYaiMyyR0wQ3ClOYPQ-1
X-Mimecast-MFC-AGG-ID: KBfOZYaiMyyR0wQ3ClOYPQ_1765802492
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47775585257so24847025e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 04:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765802492; x=1766407292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SYbHQFn0YRj3pKRKkAd+EYCoIR+oDzB7aB68ZYGXxc4=;
 b=lRNXcFT8waAVxZuUjnmNlstqb0XyVBkW4TXFeM7buMMrStAyfFp7VvSI8FEzKbApiW
 OpS3OPbJzfPAJTS8ThjffPCoz3VzzuVtUc64GBBUsmCxWtlZbNXgkIYQyPMUwCLVHmlb
 GouDSDn4kk3f1W8VPBk5jRgPwbMR5UCz2KUCG4aFG0eeVEMLqmeG4kJW6DDYtoPrRJWE
 SOBQ5YDJoxHUNr+uQaI3n7V+5GEaWPzq4vGScmsgD4KLH/FxA3tMNrWxeY7wkDLxEjKe
 EAs4ZgJgo47LzHOxZ0jzJSy/nqUT0HNRPY5RxkSVivONTBAKVMOi7MuOHvS1vVcypO2p
 fO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765802492; x=1766407292;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYbHQFn0YRj3pKRKkAd+EYCoIR+oDzB7aB68ZYGXxc4=;
 b=qUzGpbh9RARnakMwmNc/jmMevX4wh9Eh9boZf5kmnmXveE0SfHdrcljBvrjMCbYwCW
 3REDl1g8IF/3fhZN6KLiB1MPXY4W9OFLjEs0W7XJ+Un/g9nlV0l3B7NEQ/rtdT+lRAhV
 qYCSJuxLaLci/NpwesQQYRK7PnrGAUvfSIu7q5MbX1HxvdZVnZ+P4BgzlCra6MBleHLU
 jvnUpXKagT97DTGlbqSp6tC6UgnhvfEW1fKYNQEiCA1nuigyd9U1BVTBg2eXWnq31wcB
 7FKim+In48kXbqvWEJFMgGxNCBHJT19vvgVGi811Fp2ehs/8tVcIyHEGi1Q//qb6eePQ
 arYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8JP7XxTut1RuRlFy+qBmiOCP6nLl47/T6YtgznDlUHQAiLDGoRuL34f/KjgV1CgUSOQHksrzefXbW@nongnu.org
X-Gm-Message-State: AOJu0YyTNbgB1YbP83lUOGXErPl1wHYVrFyaE3poCNNEwwRfqFY9Ewiv
 nz0c2ZHuNDgXTJqrY/BC6eAYH0BIbG2mQvZzvFnJZD5RSAgH3vBk3U3Axx6bPja6ZnX6O6fqmgU
 OhCeJ7eHycttrF//8WUld/iXe0dLTIBt6Xqjof+ALePyVr4c0ktQ1iwGK
X-Gm-Gg: AY/fxX4eWUA+2IoE0eMEZI0XMyaBBsSAhaRfmoJHTThRXOS0QYqUs/x2UlJsZU9YueK
 NK/phKYK750/devYpUpT/6NSnQHTdPHlF9wNHHA4kknAyPB7zeNZukroYtVK6whHlinNQNZPbWe
 kwf9dVeUsZjigYIeurfnr/uwaFLeECZtMQOcXoSL4GKB3Pr0fi9jEGJt4Dbp9SZASKcQLcVxdZ/
 LnjXEO60IvwadvJtWxZKgfUmuwTj/MVHN9P78GEImezzB5yQkz9TRZGaxeE4MElrCrvvodIPpkQ
 0KHQWfF423UIBat/g576BMBjvjMLwO0NGUOVChRiy07R9qykOyrK4kkm+O0HhdEWO7fT2BirmOQ
 ecODkau592bEO8a6tCLlPp383BigeZMGYp5Nqhp2+FWQle+rbyG+pxwn70W+U4FGANjEv1l4A9N
 PHqtOaxL46DL1Aqq8=
X-Received: by 2002:a05:600c:820f:b0:47a:829a:ebb with SMTP id
 5b1f17b1804b1-47a8f90656dmr97455675e9.19.1765802491969; 
 Mon, 15 Dec 2025 04:41:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE89vID/ppKjgHGiKI6F9A+sB63oATjNGXL4Vafgal1WeyFK5zev7LVS485qWbx8Bf0OJvEeA==
X-Received: by 2002:a05:600c:820f:b0:47a:829a:ebb with SMTP id
 5b1f17b1804b1-47a8f90656dmr97455415e9.19.1765802491511; 
 Mon, 15 Dec 2025 04:41:31 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47a8f4f2e8esm186690805e9.9.2025.12.15.04.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 04:41:31 -0800 (PST)
Message-ID: <66e03fb0-d885-44db-b77c-99d8f1f43815@redhat.com>
Date: Mon, 15 Dec 2025 13:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/28] Introduce support for confidential guest reset
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org
References: <20251212150359.548787-1-anisinha@redhat.com>
 <aT_lP8l7lS-QlMBd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aT_lP8l7lS-QlMBd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/15/25 11:38, Daniel P. Berrangé wrote:
> On Fri, Dec 12, 2025 at 08:33:28PM +0530, Ani Sinha wrote:
>> This change perfoms closing of the old KVM fd and creating a new one. After
>> the new KVM fd is opened, all generic and architecture specific ioctl calls
>> are issued again. Notifiers are added to notify subsystems that:
>> - The KVM file fd is about to be changed to state sync-ing from KVM to QEMU
>>    should be done if required.
>> - The KVM file fd has changed, so ioctl calls to the new KVM fd has to be
>>    performed again.
>> - That new VCPU fds are created so that VCPU ioctl calls must be called again
>>    where required.
> 
> Presumably this re-opening of VCPU FDs means that all  the KVM vCPU PIDs
> are going to change ?

As Ani said, no - the PIDs are attached to QEMU threads, not KVM file 
descriptors.

I can answer this though:

> Can we get this reset functionality into KVM natively instead so QEMU
> doesn't have todo this dance to re-create everything ?

The answer is no.  Unlike normal reset, resetting a confidential VMs 
entails performing all the encryption and measurement from scratch for 
memory and registers, and the data is not available to KVM anymore.

QEMU can retrieve it again, just like it did when starting the original 
VM, but KVM does not save and therefore does not know the original 
contents of the memory.

Paolo



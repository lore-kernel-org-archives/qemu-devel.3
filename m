Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456F6D2B92E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KSh-0004d0-Qu; Tue, 05 Nov 2024 09:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8KSg-0004bU-5a
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8KSe-0004su-8F
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730816591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3YxwCYFjvqWjHGFgyPBfEwCVE702KHg6Ilhczj8Xs2E=;
 b=UwLQoloSvy5Dn9J4Mw/+CuBo+wbamiZm7jAncJY7lZyUBGhx/4NEqqdTXH2aG850Jx4hqH
 cqUv5XFH3xPT+IxBoNXTHiJRQfTzkRD1AiFPWqVZ++3o9J6j1WAVH/AWfCPNqq56MhqHRg
 qykn0MeWIpJ1zZA8hZG1Xtsp/uGzjJU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-kVb6HVXLNxC88C88nRY2dw-1; Tue, 05 Nov 2024 09:23:08 -0500
X-MC-Unique: kVb6HVXLNxC88C88nRY2dw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43151a9ea95so35920715e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730816587; x=1731421387;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3YxwCYFjvqWjHGFgyPBfEwCVE702KHg6Ilhczj8Xs2E=;
 b=NEWAL2cvzl8PuT1dFkINYV/E3ulWmvXPhSFniebPoqqDKW//IWvS+8cqC8oWumW5Je
 pZYMuyMCpE30G5toxWP+GfQ3UCm1WfY2kUhGLfxlTTLHIUWWZOHU0DDrDsFEzvZ2tUep
 vAhpNhZAdZmXz5GGVb53gikZO/2FZ3X4KJ+A6WGQ0IYAj47Vb84oixzdywqoh1vw4oJR
 F2BqLtiLtFHV/e+Gfa+1ry4rv3NPke/AEm130Oo/99yeQiXcrUYfdOI1u06C11N5CvIU
 baZGIWIqgjPG7orvRrfxHRYqQ/VC2JUu6XkpmAtb3r4un2sQX+ori/xSTiWcfCB5q73r
 wMBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyfwiYaGaZqGHm2dp9LxuX4Eaycn1nGOv/0ABKY6Ps076rgnrMHgl0Op2VpUZk8EuonYuUlJ+5QzsL@nongnu.org
X-Gm-Message-State: AOJu0YzTqRrldcKA0Nw2DdhHtYpZkRONKpWy429SzzlSQk/JvNKjiQjZ
 0MGG8wCimOTTQOCpR/YEGV54uzi2BUSF8Cp05zALUyJY2l0QEEN2VFG0TGQHevQR/cx2bH+Ei+m
 /eS0q7ZIRBnqCMe5xbX7mOQ4IXh68GUeziPX7PFCxKxQMf7mOcICD
X-Received: by 2002:a05:600c:3c9a:b0:431:57cf:f13d with SMTP id
 5b1f17b1804b1-4327da727f5mr151566395e9.3.1730816587686; 
 Tue, 05 Nov 2024 06:23:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFzLlg/UFV4hvoZU6Iw2VzJemFRsBauC2gDiC/tx72Okl4O7Eqe9A/VJThWHUfJ3/aMqjNCw==
X-Received: by 2002:a05:600c:3c9a:b0:431:57cf:f13d with SMTP id
 5b1f17b1804b1-4327da727f5mr151566205e9.3.1730816587326; 
 Tue, 05 Nov 2024 06:23:07 -0800 (PST)
Received: from [192.168.10.28] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf429sm186909505e9.12.2024.11.05.06.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 06:23:06 -0800 (PST)
Message-ID: <a90e29a6-0e07-46a3-8dfc-658e02af9856@redhat.com>
Date: Tue, 5 Nov 2024 15:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 45/60] i386/tdx: Don't get/put guest state for TDX VMs
To: Xiaoyao Li <xiaoyao.li@intel.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-46-xiaoyao.li@intel.com>
 <8cd78103-5f49-4cbd-814d-a03a82a59231@redhat.com>
 <e5d02d7f-a989-4484-b0c1-3d7ac804ec73@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e5d02d7f-a989-4484-b0c1-3d7ac804ec73@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 11/5/24 12:25, Xiaoyao Li wrote:
> On 11/5/2024 5:55 PM, Paolo Bonzini wrote:
>> On 11/5/24 07:23, Xiaoyao Li wrote:
>>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>>
>>> Don't get/put state of TDX VMs since accessing/mutating guest state of
>>> production TDs is not supported.
>>>
>>> Note, it will be allowed for a debug TD. Corresponding support will be
>>> introduced when debug TD support is implemented in the future.
>>>
>>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>
>> This should be unnecessary now that QEMU has 
>> kvm_mark_guest_state_protected().
> 
> Reverting this patch, we get:
> 
> tdx: tdx: error: failed to set MSR 0x174 to 0x0
> tdx: ../../../go/src/tdx/tdx-qemu/target/i386/kvm/kvm.c:3859: 
> kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
> error: failed to set MSR 0x174 to 0x0
> tdx: ../../../go/src/tdx/tdx-qemu/target/i386/kvm/kvm.c:3859: 
> kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
Difficult to "debug" without even a backtrace, but you might be calling 
kvm_mark_guest_state_protected() too late.  For SNP, the entry values of 
the registers are customizable, for TDX they're not.  So for TDX I think 
it should be called even before realize completes, whereas SNP only 
calls it on the first transition to RUNNING.

Paolo



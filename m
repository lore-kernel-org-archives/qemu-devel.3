Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D77D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD17q-0002A3-4N; Mon, 18 Nov 2024 07:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD17o-00029n-PM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:45:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tD17l-00055R-VU
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731933897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/m0K0azwqQwWvkSaObaD+YXb1qRzy+7Oqfy+qe9TVKo=;
 b=h/SB7CzoAt6dj+t5RsjZ9Ti+4nv1E94soTYJNDgNxv7r7b8ZUEhZHlBeGsyErOksDQ7s0V
 f1kaeyhrUkXTBP6YTsdUT+8X6Y+sLemQKBuwEYofg0acCPfKziqk8TEBb7xWo2J4rttDkP
 jn+pCVW0dFeQJXwqLTp42eyjcOSJvYg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-5nmaUTcmM62wfpVii_MACA-1; Mon, 18 Nov 2024 07:44:50 -0500
X-MC-Unique: 5nmaUTcmM62wfpVii_MACA-1
X-Mimecast-MFC-AGG-ID: 5nmaUTcmM62wfpVii_MACA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38233ea8c1bso958308f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933888; x=1732538688;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/m0K0azwqQwWvkSaObaD+YXb1qRzy+7Oqfy+qe9TVKo=;
 b=CdVryRJITcOJ5/U9ivvUKhyI1W2TB1q5mPxMSwMxnzOxeSnz/keaMp8t1cZ3mGiQyZ
 npHwBS0+lhZTn3lW53hYLRdclm9nV8NWEeUMnr10wKBGLNofO2Oz3tVDPCXnFIYQu5Ar
 kGkHH5jEoHCMtlRkGYTNMpYjTczHbrX3dGP9cvwGDoqpc9LQBc55IU07whUTskTzcjqc
 A6ZDnNhrGskTvOZkYYQ3GZue4ADFgd87NYcQP+coScSKhIVnBCJ0upbE4sjttn8dcmbb
 sLyiyFd5GPiN2b4135w8sM+YRE6+/daw4Fs7QHonkkreltwHUNa7TL+5fFLH58U5R8FZ
 eeKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1UieTQIqItj3x9IihbkdtaVOR+35EDq2sddAlBN6Eygyp+LUKG3FEWSmZKWq6B0Vco12XDSs/tATP@nongnu.org
X-Gm-Message-State: AOJu0Yw1aRLyJK/r7LQ5z1ma7T6f+X891sweaXseVNdOVD58cQCNTURV
 gaCL2RTFbFb9KJ8KppXW2KD4OD4ArfzV0Ltsbllc/oS7DueopycbxhyA0WXceatpFM38uqzha8l
 Nr8gYEx1qeOB6qooSLJF7arcUU7+vou3L9+vg/+11d35/Tnb6GF6b
X-Received: by 2002:a05:6000:69a:b0:382:2386:ceaf with SMTP id
 ffacd0b85a97d-38224fd034amr12059591f8f.27.1731933888308; 
 Mon, 18 Nov 2024 04:44:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsCgERvJ3HQjdXzP2WojzutcSRTDZD/QqESED6kNASKkVJLRqKAP/lR1ebCYKht7/AkHdMkQ==
X-Received: by 2002:a05:6000:69a:b0:382:2386:ceaf with SMTP id
 ffacd0b85a97d-38224fd034amr12059571f8f.27.1731933888028; 
 Mon, 18 Nov 2024 04:44:48 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3823c1480b1sm6364827f8f.47.2024.11.18.04.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:44:47 -0800 (PST)
Message-ID: <ee008fb3-f9a7-4397-814c-4b5e6c93a0a6@redhat.com>
Date: Mon, 18 Nov 2024 13:44:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix !CONFIG_SYNDBG build
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20241114130152.352009-1-vkuznets@redhat.com>
 <f202f7b5-5840-45c7-8b4d-a93c71c4aad5@linaro.org>
 <f60d1429-ab8c-44b4-a864-5a5937dd844c@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <f60d1429-ab8c-44b4-a864-5a5937dd844c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 11/18/24 13:40, Michael Tokarev wrote:
> 18.11.2024 15:39, Philippe Mathieu-Daudé wrote:
>> On 14/11/24 13:01, Vitaly Kuznetsov wrote:
>>> Commit bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG
>>> enablement") broke !CONFIG_SYNDBG builds as 
>>> hyperv_syndbg_query_options()
>>> is missing there. The idea probably was that as "hv-syndbg" is now under
>>> '#ifdef CONFIG_SYNDBG', hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) 
>>> cannot
>>> be true anyway.
>>>
>>> It would have been possible to add a stub for 
>>> hyperv_syndbg_query_options()
>>> instead of resurrecting '#ifdef CONFIG_SYNDBG' but avoiding
>>> HV_X64_MSR_SYNDBG_OPTIONS altogether instead of zeroing it when
>>> !CONFIG_SYNDBG seems preferable.
>>>
>>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>>> Fixes: bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG 
>>> enablement")
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>>   target/i386/kvm/kvm.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>
>> Patch queued to hw-misc, thanks.
> 
> Please note once again there's another fix from pbonzini for this.

I'll send a pull request for this soon; Philippe, can you drop this one? 
(I'll drop the hda fix from my tree instead)

Thanks,

Paolo



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79CECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 20:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyFdM-0005Ir-FV; Mon, 15 Sep 2025 16:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyFdI-0005Ic-20
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyFd9-0007bh-Rl
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757967407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yfy6kCJuv5qCBzzYrjENT95j6njlse1U3T3KUO1PjLs=;
 b=MYyTq+gpS1VO1pAgMxi2IodeaaR9Ivio+nU/i3BLJ0tm8u6al7thsel4m4p9iyqpub8Wj8
 hmur1ttnFrDPpsX75ZdMF2TCYzK3LaKfdgMslhnvcRfKoNSVxfpjf7vpMEb5UFxG+24/tk
 yS+nP3flU3mLdQvPQSuY/KIEJjU3qq8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-btDLpxAiNlaiKDcGUOh_Gw-1; Mon, 15 Sep 2025 16:16:45 -0400
X-MC-Unique: btDLpxAiNlaiKDcGUOh_Gw-1
X-Mimecast-MFC-AGG-ID: btDLpxAiNlaiKDcGUOh_Gw_1757967405
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b111d2951b9so162272066b.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 13:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757967405; x=1758572205;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yfy6kCJuv5qCBzzYrjENT95j6njlse1U3T3KUO1PjLs=;
 b=fj10XbYtx+r/S9WxDIM5kOAXHXvf2YQZUZTydVCvO97Tj+loL5KT1ZYh+LmNEQxB2i
 P0VI4J2PU1rzQ2BDPC1AeXxBpKNM9crenRb9HRyYewWgh9nN7MRxT3zcdLK7XUqyRs6w
 gdG/XmuDfWpFt/fN6SHBrTujtkvMOdVpA+k+UWSG5hckLMlu7n3o/j4NJsJsE21rZ6N0
 9Ehv0SAQ/KxEHrR63YqvGVemzJfTILKBZZkKe3kvc0/Rc30Bqzz+mTB7DZVOdf7dVYQF
 DQi10NhcX3IY32d+5/YDavZAC0gWPZWMWltMlia6SYvcZrnA3YrjvN8e2izBTzIQLPiR
 Mq9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJfJUqaEClqrZAssS4bXUVB3Oaw/xCw3bDgmIt++icFhzRISYgNmXYtQqly3hBgGOtjr2mnHqteiKE@nongnu.org
X-Gm-Message-State: AOJu0YwJxbXptxGD+MxcuPq7sK9Et4gajnjCdVXlKwchQgu+EMlmHi3D
 7dALmpIYX3c1NH6Tsdpw6BoKJNKmdMiPFXp2JwGg8U8NmpyfkuBx6vyW9p2TGxfWdgDhR5YaZDN
 aQvrGwYNPvbe1fCkaFy5ZTyo3cSxBaNoKMDGU7BxFurogSJDdZaHjvuHR
X-Gm-Gg: ASbGncsBB7tFjjw7YePXFH7MpSSDIcZ7A/Mvk+xgebpn7syDuQQ5MIUmfizBwdWwVZG
 1C6svTESqh33PzP6nUnSH505zgl7mRA7nqt/tsZ3iwLpMehmBXi6mzBvamp588JPvBtePYZ8YmN
 w4W+70qt0KKCW2THmfYs1X5tPSoi0dvWHaAry6OywX4qy4aU2zs8cRwb66rOUcTl3Yw6ZkU97lg
 RrBh5UFHBOksPkJ7dW1cWP9l4SMNh/Mr8yOPELlJFXK9URpDwvFAWRShTvpusb6xlnRV7BXHcx5
 JNywLP8PLRdyJiCc2kT3CodT96+2so5ojq99IQoay2vk4pB7mrIchXFvNj1YW+DBC0NbJ6LpFSg
 RGsPzvw==
X-Received: by 2002:a17:906:1611:b0:b07:dbf9:a2a3 with SMTP id
 a640c23a62f3a-b07dbf9a7ddmr839969066b.14.1757967404663; 
 Mon, 15 Sep 2025 13:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWhfsHGZnIOOCClg9/3dNt3Pkw6mB0M2ob7UnuJFAHH+3eCDzZmoLW+tLGAN1zxdBAybJytw==
X-Received: by 2002:a17:906:1611:b0:b07:dbf9:a2a3 with SMTP id
 a640c23a62f3a-b07dbf9a7ddmr839966666b.14.1757967404241; 
 Mon, 15 Sep 2025 13:16:44 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b132b141790sm159386966b.101.2025.09.15.13.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 13:16:43 -0700 (PDT)
Message-ID: <a3740262-1a53-47ef-acf8-fb404611b82d@redhat.com>
Date: Mon, 15 Sep 2025 22:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/x86_64: Accept a few locked pages in
 test_memlock.py
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250915185509.340022-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250915185509.340022-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 15/09/2025 20.55, Richard Henderson wrote:
> Startup of libgcrypt locks a small pool of pages -- by default 16k.
> Testing for zero locked pages is isn't correct, while testing for
> 32k is a decent compromise.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/functional/x86_64/test_memlock.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/x86_64/test_memlock.py b/tests/functional/x86_64/test_memlock.py
> index 2b515ff979..81bce80b0c 100755
> --- a/tests/functional/x86_64/test_memlock.py
> +++ b/tests/functional/x86_64/test_memlock.py
> @@ -37,7 +37,8 @@ def test_memlock_off(self):
>   
>           status = self.get_process_status_values(self.vm.get_pid())
>   
> -        self.assertTrue(status['VmLck'] == 0)
> +        # libgcrypt may mlock a few pages
> +        self.assertTrue(status['VmLck'] < 32)
>   
>       def test_memlock_on(self):
>           self.common_vm_setup_with_memlock('on')

Reviewed-by: Thomas Huth <thuth@redhat.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710DDCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAn4H-0004kv-9V; Mon, 20 Oct 2025 06:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAn4F-0004im-8d
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAn4B-00079Q-A4
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760955878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tiXza33DH6Lu7ZnDTz0zQ5shUKeVTi5FwIYml4nR1rs=;
 b=Avu9sfYmK8MuhqyAjaIQXGfEFHAzrhJnhaytL80La5v9RVXE9yxh5vu41AJ9ESl3ydnfR/
 g9wc2b2HlCm3roOftE+LQzVlJXvewTU3/85hRMBOVLByTWxQO8nD7wmIuZgIc4yqBL/JPm
 lU7/tTWR4O4YkPvDFHtB1pGe4e/DVdY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-z_NVxrAIMsGiEd8mcHRXPw-1; Mon, 20 Oct 2025 06:24:36 -0400
X-MC-Unique: z_NVxrAIMsGiEd8mcHRXPw-1
X-Mimecast-MFC-AGG-ID: z_NVxrAIMsGiEd8mcHRXPw_1760955875
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47113dfdd20so12778935e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760955875; x=1761560675;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tiXza33DH6Lu7ZnDTz0zQ5shUKeVTi5FwIYml4nR1rs=;
 b=p5eD14uTU1S5ilfrUhUhsvWL/psL+h3a+ocx1eM84+XD0M/8r2ygXcqYvH18oGncai
 uliOyzbKcwKQYr0IuSJv+WcHz3zsya0covEF0z4uC14j3fmGMqse0WwP8ED8MS+juU4g
 0RDzxSbW20XvdeigFLG8lVAhQMHadQy2wdgwuNA3vgqgNXu0bXnuWnTurFP54Dv3JC/j
 BnKaHXlIfmvcysI0lz3Zvwx0qIlW+FgFqvnnWKzC9WwwJfunYfTkYTcA1XMJXvVLVMfd
 +j58O62ENDKwvnTNwmbOHGrZbE7oAXkzXh2uokNWnqYzzoZD0w/oigOajdlgOyufFHBM
 abyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+vz6/aKBal5Gwfc0w7jIprXT9uxIm7kUpzDrFtb91EUhHjs8Bvxnh7eFcs+xhNlKgqvXSfZ0w/Xup@nongnu.org
X-Gm-Message-State: AOJu0YwJWgvVzslN/KDn2UqctQMgKELeEHsEKCTcmMcvlL8ksPZoTIg4
 AUtLwxLhWV13B8O6c/jUdhJCC5dNlp42VMsfNp0O01HTLLJDHLg14g/37nXK9Sv3Dyq0w6+MCrW
 bCCfd17ddXUyN1gsfweGxCB9Wj/MMxyScyiSqj7I9FyyX4K9J1tCoSBPh
X-Gm-Gg: ASbGncvgDBWei/qfltVitSj9PdARr0zNn8+5OGJ5PpPMZABmEINsd5PrS+7dEyM/EIn
 5X0XCrXVY5lNgcf1cM9WC5kNOxeZHXGrwch7dcjH9T6uaDdyX88oPIQNKBYoccmsSyenaTTWq0H
 FGof1CWGWFoI0WUHaXo+SsJHmP4SG69VVTpbZvEnv+W1cYLpCjenxeUu0u8oHObYfJgowUQNIRr
 5XXgYCfCKDnfP9Z5DcESgNBaTD5eNrt/8SLYxUMwpG46q094YMIgRejgCGRcDGb8RVf/Q8qfH8D
 gLU41w88nyMCNfQ0ynl0+c7qXSqrnfQ648WfEEuToI1yF4ni/hJdiThqQI0xaXuq9MtsAl8SyMb
 tf5ARHURB0EbrHU941gnxxYWLegClXaEIMD9wtxSC
X-Received: by 2002:a05:600c:871a:b0:46d:996b:826f with SMTP id
 5b1f17b1804b1-47117917257mr95552235e9.25.1760955875263; 
 Mon, 20 Oct 2025 03:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuqbYk7KlpAuOaj9wRqzEWX1m2whnMO9GVx8bDFrYlhbiYRvqLuFNDI9Ipt31e5siyO7kp3w==
X-Received: by 2002:a05:600c:871a:b0:46d:996b:826f with SMTP id
 5b1f17b1804b1-47117917257mr95552045e9.25.1760955874834; 
 Mon, 20 Oct 2025 03:24:34 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4714fb1b668sm157663065e9.0.2025.10.20.03.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 03:24:34 -0700 (PDT)
Message-ID: <e3d4853c-98ec-4bf2-8bd4-3346682d9f33@redhat.com>
Date: Mon, 20 Oct 2025 12:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/core/machine: Remove
 MachineClass::fixup_ram_size callback
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20251020094903.72182-1-philmd@linaro.org>
 <20251020094903.72182-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251020094903.72182-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 20/10/2025 11.49, Philippe Mathieu-Daudé wrote:
> The MachineClass::fixup_ram_size callback, which was added
> in commit 5c30ef937f5 ("vl/s390x: fixup ram sizes for compat
> machines"), was only used by the s390-ccw-virtio-4.2 machine,
> which got removed. Remove it as now unused.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/boards.h | 7 -------
>   hw/core/machine.c   | 3 ---
>   2 files changed, 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



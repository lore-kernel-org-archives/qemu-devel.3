Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE46C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJu6D-0001Fs-La; Tue, 27 May 2025 09:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJu6C-0001Fa-7j
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJu68-0006Ls-2T
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748351519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHKxc5nfasUEG2+1eqnzlUAnWhZUtYise2kTgHplEI0=;
 b=X3rGGb7lXXzflzrn4LwHsoXD4hZx91uy77qQ36ZSYCK8owJcjizPDW2rzSuZGgXF/0B2tM
 AyCJfeVe2ugg07+kd3wTljaVA3VCOzyrD8mSDyWTFCmkGj+20Tqb6h9qe5fH0d454c3VyB
 wHwJzjgTIA6hXCGClCjdHsIdR7NHcpw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-1vtLrJM4OgeNfSreSpNrvw-1; Tue, 27 May 2025 09:11:57 -0400
X-MC-Unique: 1vtLrJM4OgeNfSreSpNrvw-1
X-Mimecast-MFC-AGG-ID: 1vtLrJM4OgeNfSreSpNrvw_1748351516
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442e0e6eb84so21839895e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748351515; x=1748956315;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHKxc5nfasUEG2+1eqnzlUAnWhZUtYise2kTgHplEI0=;
 b=KQ0XJvjxyaVEGKAuu3W0tGs5vKmsmnH1+ghLnsSV7NptpZOGXlSEJrfVzApnrR7Xfc
 NUvixa5fi5Wc6QRwgrtR2148F8X7+TRh8DEyDdpAyJLDW1mfpHnFo2I9mpQMq3WV22yU
 oAmgXsAKHGBswMlOOAhHkI9vkfivNxfwXIw4pwly/zvoXezrHB2/79tnEAMC79y31D6X
 SPzzbWuSvdfHghok/Ar4Z2vzpWg3hC85itzqfW+jNxyiL9FO0ixGb7Ra4JOAVLs/kOBj
 cY54trUPITgmcXd1vLYUzJaTCz4fFtg5bJHLnqFfJzw0BXRxqeIgyIoaAUr6BFBIhbRq
 wUeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjYia1p2gbmwL4L/oKqrU3zyG9v8aYSop0BczmgWQnIpIm6uNtK4C6JHDYIafMyidrq7Sypl3W8ObZ@nongnu.org
X-Gm-Message-State: AOJu0Yw2H4ZZ4HRK70dk7j0BmKn8hQUhP+sdZ2RE3mhrTVOUJKxT/hMi
 aqZZ0eDQhoA6jo3cGjMSL4CT5XL7hHQLc96/uSghY3wQAU1NQqYFs0bSW3JqqyrTm/IxhaULVnM
 z633OOhNFHp199ActpzZD2jsaPRsTjgTUlMzSZ7csSZxExvOWH/SaohWXY+CERsEV
X-Gm-Gg: ASbGncuncewWLomvjokwn5POGOG4xy8k0jylfOT9rCbqvuQ859FocR4cnMFJ9qzVkzP
 6Yy0CpxyQ3/Ow9seGNO59Jy9q8cxgKV3MCiM+hleJPe1wUu5MZqZwZdqkR4lwD0FXU3E6V3m/W4
 7OXk9LrnfEEWvl/NG2nMJnx5OsqNHq+WJ9YskQV5Z3fcQOplh1mqEVzzBE5KyGgjARcDG2a1QX8
 pBPldNJWt1K6ejjwjbqEISx+27cO3VKY1TfsUhxUQr9ifdHYhB6XYMMx1nZXixndtUgIv0p9x83
 dRxAuHMyMjNx+w67gpvQULFJ/P5M5ew4UgqXvz5H7eMrUZwsyHtXHSVY9cc=
X-Received: by 2002:a05:600c:8712:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-44fcca51e1cmr34010725e9.17.1748351515435; 
 Tue, 27 May 2025 06:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0H7ly/sdw4yfNcpbXffu4WKGLi7x+ZGFNH/vo9jsnRV5fNxqZawOd4Yp+6V6+8ZRmZcbMXw==
X-Received: by 2002:a17:907:9706:b0:ad2:3d34:e2a4 with SMTP id
 a640c23a62f3a-ad85b1ce8d4mr1153657466b.30.1748351504011; 
 Tue, 27 May 2025 06:11:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1fe4fa6sm263863135e9.16.2025.05.27.06.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 06:11:43 -0700 (PDT)
Message-ID: <ee464d7c-9b77-4aa7-9afa-627e497c7581@redhat.com>
Date: Tue, 27 May 2025 15:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] ARM Nested Virt Support
Content-Language: en-US
To: Miguel Luis <miguel.luis@oracle.com>, Marc Zyngier <maz@kernel.org>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "gkulkarni@amperecomputing.com" <gkulkarni@amperecomputing.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <C10D9293-32F7-4834-9CEE-6AFD4BDBC30E@oracle.com>
 <86ldqidzyl.wl-maz@kernel.org>
 <822E77EF-9802-4F16-B8D4-A48F3A624151@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <822E77EF-9802-4F16-B8D4-A48F3A624151@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Miguel, Marc,

On 5/27/25 2:54 PM, Miguel Luis wrote:
>
>> On 27 May 2025, at 12:01, Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Tue, 27 May 2025 12:33:23 +0100,
>> Miguel Luis <miguel.luis@oracle.com> wrote:
>>> Hi Eric,
>>>
>>>> On 27 May 2025, at 06:24, Eric Auger <eric.auger@redhat.com> wrote:
>>>>
>>>> Now that ARM nested virt has landed in kvm/next, let's turn the series
>>>> into a PATCH series. The linux header update was made against kvm/next.
>>>>
>>>> For gaining virt functionality in KVM accelerated L1, The host needs to
>>>> be booted with "kvm-arm.mode=nested" option and qemu needs to be invoked
>>>> with: -machine virt,virtualization=on.
>>> For the current kvmarm/next the guest also needs
>>> “kvm-arm.mode=nested” I believe.
>> No, unless you want the guest itself to be NV-capable.
Effectively you don't need "kvm-arm.mode=nested" except if you want want
multiple level of nesting.
>>
> Correct, I got carried away with some mode combinations. Maybe we should depict
> here more broadly how NV might be used with different mode combinations. I'll
> think about this further ahead.
>
> As far this series go I couldn't found any issue booting a L1 guest with
> virtualization=on and a L2 guest with virtualization=off.

on my end I tested with various untouched L2 guests (debian, fed, rhel)
in 4kB/4kB/4KB page size mode (host, L1, L2). Those configs were successful.

with 64kB/64kB/64kB configs I am less lucky atm. One one machine I
cannot boot L1 with virtualization=on. On the other I can boot L1 but
cannot boot L2.

Trying my best to debug a little bit further with my setup. Anyway if
somebody else can try 64kB configs, it would help to confirm whether
there are pending issues. I don't think they are related to this qemu
integration series though.

Thanks

Eric
>
> Miguel
>
>> M.
>>
>> -- 
>> Without deviation from the norm, progress is not possible.
>



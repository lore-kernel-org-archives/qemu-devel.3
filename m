Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8587C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wglnj-000810-3B; Mon, 06 Jul 2026 12:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wglnh-00080l-Ec
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wglnf-0001HH-Mo
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783353842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VNjLI0A8NcFIBd7U7+y7eNwuQt2QPbbUxsuBkg47UpQ=;
 b=D+Bf/l5i3L+RZt0j/u6zhnTs70KeGQKbrg9ysniaZzPDuTACU6NM8RFxcFpLJPvizCk27q
 QS7lXznkYP91B2P0ac/tegCcnX2KoVHkGx8dFnMFJiUlNmLYkdBfc+UmgmQfv9/WrGQjhW
 +r7P6dpclQu4SanoYK244BQcNJg9a4I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-bD_ITY_eNby_JBqy09G7nw-1; Mon, 06 Jul 2026 12:04:00 -0400
X-MC-Unique: bD_ITY_eNby_JBqy09G7nw-1
X-Mimecast-MFC-AGG-ID: bD_ITY_eNby_JBqy09G7nw_1783353839
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493b54823bdso24779575e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783353839; x=1783958639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VNjLI0A8NcFIBd7U7+y7eNwuQt2QPbbUxsuBkg47UpQ=;
 b=FCR8SbGT6Qe5yw5HmjF3omQ8RQ23I1wqo/DG5iYrzpJMi7mTFYpqwYxLI8HvAO41NR
 1+mrm/BPuN9kMsCedkGfwEbgMC9hU+eKW1sabjvWisZRw2pO/AgVuVcnWRhXH8k/6EUt
 1RPAeiGmOVCUQAiEWwz+zjg9/M0S0M9KGGVhIb7X1Pv5CfsB81BuxAIzPVWplFiOr2+r
 Vfx4pbJPYvbvrdHFLAsSZkC5VAQl8cXzCkl61jut7s75m3aHTKGO05fsj+flWB9z112r
 qB+vMDcAVQ4pxe9u7mjfZuLYkkvnBkyNcvHsb2mHYg3LGWma07lbeFUlHJ2jrFEttY8i
 14Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783353839; x=1783958639;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNjLI0A8NcFIBd7U7+y7eNwuQt2QPbbUxsuBkg47UpQ=;
 b=Qu1vK2h8ktvv/Qj5vU4mnVLOJQ9Wej6fMojI7/d6mRd4sVQ6yFk98AtezQMIioMfS5
 RXzr0Xza4b4rv+zP8XAyRcrp2bG8Od5PzuP0AyuT2xoQIpM7RBDfDTn7ytP0w5jmlUyy
 2hUU0N5XIGZnTb9lj6eHSveKiImf+I46f/JIjfdugvvMU9SuAFCCpPDVgA5eSrXFLUG/
 kd3o89HEt6k2ZET7pWgMu4KliTuTH/5HVBGi/Tnz3mjbab0axxkAl51cZjqMeKlK4MAO
 OG8ZGKEzXAS6LKcSGOhvrZSdk/AWH3WOfXQwK9w2Yq9h/GKxeg8OYZ7TSTxj7fJiNIMK
 yRfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQNEMNRkVYmw2dl8BEwQv3+PzYZwtsrn/w8rn11YkTiheHyWKFlvNRoSJeijHmmNLy47ju7XoSFpwb@nongnu.org
X-Gm-Message-State: AOJu0YyeWs9FgcRiAFpbvCL+tmAbaYUfItaU5a+z7uWfJJ6QYUq9bV1Z
 GNgL3RbmD2wuqSKdOMQ43L3pk8b7HI/MrtDc3yGb/JG/92+jcgDmXVeBI2Tlpq8fcZ9LTTiK9s8
 e/yHHY0BHFLFXleMphjHS4DVfnDenZLwHwYA9bbSw4IVwJaINrXBd/PJI
X-Gm-Gg: AfdE7ckZNWymafK6IuMfTgHiWCiPLDExzQxxNHLerNvlt8Qka5IPDrKcYANHIQaXd79
 ElRRlTwnMAHX0v3qd0plMmgT/pe+aZySGk27nSuV6Hxg0IYQ34PsM0gVlBqQ2q1CwU+VgrG1ACR
 jPYoqImO9VYZxI9ixmjCv5eM04ZZP4BSMLj7BH4ecCL2Dai3o2+Q8kVd0eZxkYnDKfaNt6WMDDU
 4PMhlYyJDz6uSyUx3f+Q9tGPi4iX+TyGb7OPLhj0+f9S16WHSYtySEFbGd+l+x4AYynz0ceCEFa
 XWPmV98jriea1ypDjao8d9Iq1i9uI2ZGr+NCI8K7GpnXqY3M2dPkNVFofbkDaFFLm1f+1RUFqOm
 NsxLBtJSnrxV5ep7V/CNDw0a48tmLggiVzXtTaz9vxzxWlpTu5Xkm
X-Received: by 2002:a05:600c:1993:b0:492:6f5c:fd8c with SMTP id
 5b1f17b1804b1-493decec719mr13696265e9.15.1783353839293; 
 Mon, 06 Jul 2026 09:03:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1993:b0:492:6f5c:fd8c with SMTP id
 5b1f17b1804b1-493decec719mr13695695e9.15.1783353838787; 
 Mon, 06 Jul 2026 09:03:58 -0700 (PDT)
Received: from ?IPV6:2a01:599:b25:5a4f:b2c0:73a9:e739:6ad4?
 ([2a01:599:b25:5a4f:b2c0:73a9:e739:6ad4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef183e7sm457156005e9.2.2026.07.06.09.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 09:03:58 -0700 (PDT)
Message-ID: <79cffc2a-a161-4fff-a61e-5acd9c22348c@redhat.com>
Date: Mon, 6 Jul 2026 18:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: OpenSBI docker image RISC-V crosstool gcc URLs 404
To: Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, philmd@mailo.com
References: <5be16244-7148-4691-8ee2-669a71b0a1a4@redhat.com>
 <mhng-FD339FD6-9FC0-4E9C-9303-6F4211BB5A7A@Palmers-MacBook-Pro.local>
 <CAEUhbmVFZW3CFNxYKhoiVg9Xz_ZtOCJZR==Bf_4jjpbZX9hRfQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAEUhbmVFZW3CFNxYKhoiVg9Xz_ZtOCJZR==Bf_4jjpbZX9hRfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 06/07/2026 17.57, Bin Meng wrote:
> On Fri, Jul 3, 2026 at 12:27 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Thu, 02 Jul 2026 05:12:47 PDT (-0700), thuth@redhat.com wrote:
>>> On 02/07/2026 12.30, Stefan Hajnoczi wrote:
>>>> Hi,
>>>> The docker-opensbi job has started failing because the crosstool gcc
>>>> URLs in .gitlab-ci.d/opensbi/Dockerfile are not working:
>>>>
>>>> #8 [3/4] RUN wget -O -
>>>> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz
>>>> | tar -C /opt -xJ
>>>> #8 0.510 --2026-07-02 10:11:48--
>>>> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz
>>>> #8 0.511 Resolving mirrors.edge.kernel.org
>>>> (mirrors.edge.kernel.org)... 142.0.200.124, 2605:f480:58:1:0:1994:3:14
>>>> #8 0.579 Connecting to mirrors.edge.kernel.org
>>>> (mirrors.edge.kernel.org)|142.0.200.124|:443... connected.
>>>> #8 0.643 HTTP request sent, awaiting response... 404 Not Found
>>>> #8 0.805 2026-07-02 10:11:49 ERROR 404: Not Found.
>>>> #8 0.805
>>>> #8 0.805 xz: (stdin): File format not recognized
>>>> #8 0.805 tar: Child returned status 1
>>>> #8 0.805 tar: Error is not recoverable: exiting now
>>>>
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/15145227587
>>>>
>>>> Maybe it's time to upgrade to a newer gcc version that is still available?
>>
>> There's been a kernel.org bug that dropped some files, so maybe they'll
>> just come back?
>>
>> https://status.linuxfoundation.org/incidents/3y1k8b4ky71t
>>
>>> Remind me, why do we build the openbsi image in the *QEMU* CI at all? We
>>> don't do that for any other subprojects in the roms/ folder, do we?
>>
>> I remember messing with this at some point, but it's been a long time so
>> I don't know why we'd be doing it this way vs another.  It's possible
>> this is just because there's no standard RISC-V platform, so we have to
>> build firmware images for each (which would make firmware distribution
>> more complicated).
>>
> 
> The CI job to build OpenSBI was suggested by Philippe, with the reason
> to follow what we built EDK2 bios (commit 71920809ceabed) at that
> time.
> 
> https://lore.kernel.org/qemu-devel/f92f1ec7-ac03-a012-f232-32c533beb9d2@redhat.com/
> 
> Given the EDK2 job has been dropped in commit 690ceb71, I believe we
> should drop the OpenSBI job too. I can prepare a patch.
Sounds like a good idea, thanks!

  Thomas



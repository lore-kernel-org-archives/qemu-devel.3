Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19189CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 13:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI5EU-0008O0-43; Sun, 09 Nov 2025 08:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1vI5EP-0008NK-CC
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:13:21 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.hoo.linux@gmail.com>)
 id 1vI5EN-00042t-74
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:13:20 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3418ac74bffso1514614a91.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 05:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762693997; x=1763298797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OfDQxu4PTKXAX6elo3fXzK6uknO3jb95Pg6WelKywY8=;
 b=FpglP/kVDRjXkgJC1qzGWipq+p7HTbg7/3r+TewMk8Z1scOFNt3locSLVvv7VYIcRY
 KPethcR+mLkudX4YAkAvlJMOns50YAsaEiRnRgWq0fBDcCQgJgJ7sM8MqMjrs0zj2dsF
 CXP2IP2fN0QI1R6qk/571WXtnRH/kkLFXNe7pNtPfrgNJhHkj07t054LshB8TGhv3jKQ
 t1CHMA71ye10h9Qlz7ZQtXN1bK3hjM+Bb9DgJgj/MwsY2hC61tW7pX07ovP6Y4ClQPlX
 avaKM4JZGjGJP8X13CZyl3Aksqz6EjCLBWa2ikebm0xuS5Wj9ZdpzxlnBfh02U70sVLP
 8+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762693997; x=1763298797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OfDQxu4PTKXAX6elo3fXzK6uknO3jb95Pg6WelKywY8=;
 b=M7Oo+7KBaiE5kvlobeWblKPth+JMDhATZWOfyL26f6eQAvxvNvD1u2Zz80s7oSXGLh
 82OzeDJQeLhO0w+VzS9sKKVYaRBhfGkMwLSHyfOqbcsVyBBsxkISQam8GF7xRBbOaN9J
 K6dRCbLC9cKj0PZQpfvJ7YL29JUMu8d0J5zayUPk/4H5l9HFbb76NCWUKCpFqakOQHZZ
 6k/9u2lJ91qyeElhP5YmEiDZnj5qW5/MB3NxVxwwYGNonDlVMSGHOiue1AGBGlIHbz4a
 oZ88xFtYlF8hwUhZTpVBvCRXKkfCA4eOpgyp/MbuK20AOVNpYcwXmPTD2tTagtbqRVIx
 Z4uQ==
X-Gm-Message-State: AOJu0Yzv/9N/2hlYh84QOaB4jW18JL8T9+D6sxmhj5B7pG2nqpTRr/67
 135lN0B1+Q/EJdQwy7zI781p3wRSApxknkLWpdv2iiSfp5Zq7Gm2vdai
X-Gm-Gg: ASbGncvnbtO11Z+uvfSR2mU7J7emrs7mqBAJwU5ZWJfcRaVI6oy+9QZ/O0pup5zhAd6
 EOmLkkqpE71E64fJmjFUViGnGAwcnVNJD2Q0rVRgo66ueLXi0H/p0T66H9wFDsZngeocsKiVmBE
 KcP3IurLv9blY9aRbISlFTJffGFY00OwczhE5YAkfY/nnuPCZ2ahiaqbr0NehAFkhSoJX62CZtd
 lOsQh87z51CpMp5nM9VINWnGW3h7c+Il07U5TN0DJw+/xUrC4xCA1VSIQvMZMqZ85KVE5jQNbvM
 GLdv4NfiW3tgftTKZ8EQEPP8czgKMtgc7OcJ4bSTWZS7xydrh0aoesdBZImIIoujOyDVqw3LrBj
 B6fbn5uJcyuAg6Cj7DccAlqGZ8soVeTeqIoBpXM5Jpk/8UjaUKL2OxYmPCscYnVhMiyV8o3UaCK
 TqUKXRiHAnbjXdlnIDMKPkUQfasGFQ6jaMYVgAve12Oaj4RXH7ongUS0WFoC0RUjE0htHJETEsy
 2X769/rqcyZKfguyf1k7lhY6ag=
X-Google-Smtp-Source: AGHT+IGJ5Dfb2B4Eh+kxRjfSAVWZTyBZNcR1CAkV/tNeFz9ZwBPXFKR1Cj8uWLbE8MHs4IczyUKCmA==
X-Received: by 2002:a17:90b:5844:b0:32e:6fae:ba52 with SMTP id
 98e67ed59e1d1-3436cb7a982mr7032415a91.6.1762693996674; 
 Sun, 09 Nov 2025 05:13:16 -0800 (PST)
Received: from [172.27.236.36]
 (ec2-13-250-3-147.ap-southeast-1.compute.amazonaws.com. [13.250.3.147])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34370ec58d9sm4284695a91.6.2025.11.09.05.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 05:13:16 -0800 (PST)
Message-ID: <9535cd2e-239a-4002-be5b-b7c7fa85f081@gmail.com>
Date: Sun, 9 Nov 2025 21:13:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: vsock support for communication between guests
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org
References: <1943ea16-c3cb-4442-be72-5719026ee13a@gmail.com>
 <pkglizwznrfj6fm7tdyew4tzmomgtp2cetxwfj2fx7ge4vtwhv@kdlj2jdxqheo>
Content-Language: en-US
From: Robert Hoo <robert.hoo.linux@gmail.com>
In-Reply-To: <pkglizwznrfj6fm7tdyew4tzmomgtp2cetxwfj2fx7ge4vtwhv@kdlj2jdxqheo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=robert.hoo.linux@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/6/2025 10:32 PM, Stefano Garzarella wrote:
> On Fri, Oct 10, 2025 at 09:00:21PM +0800, Robert Hoo wrote:
>> Hi,
>>
>> Does vsock support communication between guests?
>> From man page, and my experiment, seems it doesn't.
>> But why not?
>>
> 
> It depends, vhost-user vsock device, supports it.
> See 
> https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#sibling-vm-communication
> 
> The vhost-vsock in-kernel device doesn't support it.
> 
> The main problem is that vsock is designed for host<->guest communication, so 
> implementing a guest<->guest communication is possible, but requires more 
> configuration (e.g. some kind of firewall, etc.) and also an extension to the 
> address (see the required
> `.svm_flags = VMADDR_FLAG_TO_HOST` in the link).
> 
> The easy way to do that with vhost-vsock, is to use socat in the host to 
> concatenate 2 VMs (some examples here: 
> https://stefano-garzarella.github.io/posts/2021-01-22-socat-vsock/)
> 
> Cheers,
> Stefano
> 
Nice, thanks Stefano. It sounds ideal for my VM <--> VM communication 
requirement. I'll read the doc carefully later.

BTW, I also found your vsock-bridge 
(https://github.com/stefano-garzarella/vsock-bridge); but seems its last commit 
was 5 yrs ago. It's not recommended, is it?


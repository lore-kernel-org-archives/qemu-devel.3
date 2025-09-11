Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18622CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 15:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwj7W-00050m-Sy; Thu, 11 Sep 2025 11:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwj7U-00050U-UO
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwj7S-0000cy-TE
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757604113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HbnNvqoU+xrhKnuTknwwcJKWZSzJ/gF++tijL7ozYSo=;
 b=b/NDTTPwjEdvbu1oZOsMDy9PEg8AmSXBw7jHlWkhOtgHfNxHlZWATXt6eAB4IZpVim4lsH
 5l2tJRLuU9OjehI3MZ5dJyznsvsih2TVLw2UceSOY9+PqFu88XVhVeulE7zgK38Oofuh81
 mo7ROmkZkMCJSXd0+mtwTW1lCxklszs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-PvZQoB2UOF2LclYaCKRiHQ-1; Thu, 11 Sep 2025 11:21:51 -0400
X-MC-Unique: PvZQoB2UOF2LclYaCKRiHQ-1
X-Mimecast-MFC-AGG-ID: PvZQoB2UOF2LclYaCKRiHQ_1757604110
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3df9f185b82so321077f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 08:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757604110; x=1758208910;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbnNvqoU+xrhKnuTknwwcJKWZSzJ/gF++tijL7ozYSo=;
 b=BW0Ng4T0KjMQFXdphsFHPelwEyzqBFIo0nQioAYIyywf1Nnxk4D5UmMkLF6hIeTDyT
 xqBL9TnLtYvvDQ9SWi2N8STUiZDFbZCg3rbJ0nPmqxgAf7D4rRgnSnd6ky4uw+Ul8MKI
 blZa/XoRiDPlZlE9oX5M52t1fAZEcqjcg9xjb0BRfTREWu2qBH77pS1c4lJgJwJJZEVM
 LGrNNg7+l9pBdGSZJqPIfwKxZOzYRkqCzcWKDSGmkjG+wLbIza3k5LHA4lIL+Ft8CUU7
 F1X/fryv/s0vL+Hf9YXcHbv+3ULLZRBM+ofYodjUAQUNjgqZ9Ea3R9z7w4F7qB9mkpPB
 j6Pg==
X-Gm-Message-State: AOJu0YwLlzVwWoWDJUe+GkIV1Lr8h3dlNE+NtTyQKqOV5bSZKh3z8c5j
 nsZHI+S/FKQvSkGl/OnTzxD44mWMd10zdUVW9Me8Sfr1lI0t+dKj+SYdjoidD1fpttzRd6W8dCs
 QvxBws7DY+gn3vmto6Y3eBKbq1OiljNlRWFXwqaQbkYfPc0myfAUw0xYt
X-Gm-Gg: ASbGncvNCvcWndkSFziSl/2ndqXI9C6Uk3VcUaKym/gFSrEa6W+DdrAIpcog2zEF1RK
 RxlhPKlcpTqBDl9xalkS/jAdWobukVivh63CbQ77FeJgH4Epcc47cV5AFa6qRbM/ZHrUf6ChsN4
 zjfjezhjkc/R6bE+4KMQrWqP7O7KBfubHJRehyvPWkrZTgJH0YmVMwa2su2kKMqdIKxdwicjP7i
 4pkxRX1w3jybRSblkAmaHq2YAy+RBC/8h+StdskCLi1daWqHDyfDqNS79tL6xug1teODq8B6iYw
 sVXXVp43cvugJ9t2qmH7BUnwjbT6qMdLP6t13jMViccvr7NwxDEIrDUIqteasIxCJIDHsX7U+MU
 Y9HyVQbN8iYBr5MueaXcHDqGJoztFSWOXf1ccNey4jKI=
X-Received: by 2002:adf:a448:0:b0:3e7:4701:d1ca with SMTP id
 ffacd0b85a97d-3e74701d6e2mr9328541f8f.17.1757604110149; 
 Thu, 11 Sep 2025 08:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIuKs6ENDmz2JzfHw8kgUL7A8BrL2gkhJChCmmeakp6xd9MQt1SWlarEk+RWpnqThTFT3zzw==
X-Received: by 2002:adf:a448:0:b0:3e7:4701:d1ca with SMTP id
 ffacd0b85a97d-3e74701d6e2mr9328503f8f.17.1757604109743; 
 Thu, 11 Sep 2025 08:21:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3e760790154sm2977363f8f.27.2025.09.11.08.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 08:21:49 -0700 (PDT)
Message-ID: <17ac0ef9-1c10-4f84-be24-b0f25c7e78fb@redhat.com>
Date: Thu, 11 Sep 2025 17:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/26] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>, Cornelia Huck
 <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250911025906-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250911025906-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/11/25 08:59, Michael S. Tsirkin wrote:
> On Thu, Aug 07, 2025 at 04:39:25PM +0200, Magnus Kulke wrote:
>> Hey all,
>>
>> This is the third revision of a patch set implementing an accelerator
>> for the MSHV kernel driver, exposing HyperV to Linux "Dom0" hosts in various
>> scenarios. Thank you for the feedback so far. Since the last revision we
>> incorporated feedback from the last review and identified further areas for
>> performance fixes, notably in the irqfd handling. I'm looking forward to your
>> comments.
>>
>> Best regards,
>>
>> magnus
> 
> 
> So regarding merging plans. Did you guys get in touch
> with Sunil? That's the easiest smoothest path, through
> an existing maintainer.

There's hardly any code shared with WHPX; I am on vacation this week but 
I'll do a final review and merge it soon.

Paolo



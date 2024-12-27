Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B79AE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 05:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR2nq-0004lg-6X; Fri, 27 Dec 2024 00:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tR2nn-0004lT-CX
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 00:22:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tR2nl-0001n1-61
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 00:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735276938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gnzCYjvZ0SK1/D1ua0pGqrzpwbbQSzU6tkCgDXJYUNw=;
 b=G+uovQqszvCTFbE6XMQAR+ft3inTY/MBzyLuTf27AuAzVAHQaKrKt2hrU7XYRaE5QsoCr3
 Pn2V6eY4n3DyAA8sV299P3T6VPkPbDL134a3aOB9Re5JezdZtweJxrijR0TlEHPMy70Hh+
 BSn+qjci2T/xuTSaFewBYkwjG5XZ89o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-V15VKLvOM0GpEDG8A7UrWA-1; Fri, 27 Dec 2024 00:22:16 -0500
X-MC-Unique: V15VKLvOM0GpEDG8A7UrWA-1
X-Mimecast-MFC-AGG-ID: V15VKLvOM0GpEDG8A7UrWA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso52246315e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 21:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735276934; x=1735881734;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnzCYjvZ0SK1/D1ua0pGqrzpwbbQSzU6tkCgDXJYUNw=;
 b=FJEekb2sBRDwsE3k7eoUlRHtmq+vmvETSuheBzkBq6MZYiVGYEBCdzeD8HT9xFhvq3
 ZVFf58W7IpQc1wis9Sg5pkclBw5iphZatCp7zVKVt5dUF0yGvlxX6Hkih5WgNmrZe6C3
 gU+ANgmIE6X30vd4c7DEsh5HlkgAIbk9dLGfHR+hkxOQ2dWVOp7XjffzlxnwvgIZiyKY
 8994QZPDzwYtvHim0YTBwmz+kPwl/tSuBNNK5n3JKphjXIm469RDPjtR1w2VVCMNdDm/
 vs2jVFvGcJdmvD92i3vGMFj0iLA4INK9wj/Xi9fUdQP5pI9u3pHqP4cRP6GVWkSStli3
 eerw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTrkTjxMiqU3eMP7jB9Mt+lcOx7V8C2kpFGK5ewFZltRk+1d5N/1fg1VkhQeKcCmhFzreKs3gFxMM2@nongnu.org
X-Gm-Message-State: AOJu0YxeanJDR2x0CAVRnXLOd1fav4idOKhJRoE8arigGZiLYqI+XcmV
 NniVpkFSi7aAhk6MsVleJ5QGBfm+otLuplGuiBtJXZzvmV9OP4pxe0ZNiY9HTwxEuDWJgvgXLmb
 8JhHoXNR/YymyXD7QxCOUwX0SStCikoe4g8rRbaYjV2eVhu3nH/GW0Du1pFib
X-Gm-Gg: ASbGnctIfdCzbA9TByk9WVpIaY6cUz1vlJo+CNszbB0UUMe3z+iANKnt4CtEPl+/XOf
 4QmpIAUXJL6+iBIa+CSsXeuPuVvuhZikNQwlT6KkU/TY5INhS98NffuzyQha4akTnXEZgBW+mVZ
 vxaqu8JXY/WDzzpNKQKp7zSr/2li+cY+IQo5F/e1Nw9pIzBth0q0qu5vpOpGE7u49F1vxDHrohx
 b7YjCahyHqgL9Xln5+BBe2kdpRXV6+fciwB+pHC3mD1QyOaXyQofIN32hA=
X-Received: by 2002:a05:600c:3b23:b0:436:4708:9fb6 with SMTP id
 5b1f17b1804b1-43668b5e02dmr187424265e9.20.1735276934330; 
 Thu, 26 Dec 2024 21:22:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGINiLVG87w2TVEBWoMCC99Nc8RPhqut62McLWt7qeg4AUzAiF0MbgilSwkg4cG6nQbXyuCrw==
X-Received: by 2002:a05:600c:3b23:b0:436:4708:9fb6 with SMTP id
 5b1f17b1804b1-43668b5e02dmr187424115e9.20.1735276933879; 
 Thu, 26 Dec 2024 21:22:13 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43661218f43sm255538675e9.19.2024.12.26.21.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 21:22:13 -0800 (PST)
Message-ID: <e2e7e609-d198-4dba-8ac4-4e748c4bc35c@redhat.com>
Date: Fri, 27 Dec 2024 06:22:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why pycotap is mandatory for building qemu?
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>
References: <d7560eaa-aa57-4aae-88e8-3a15aa40e11e@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <d7560eaa-aa57-4aae-88e8-3a15aa40e11e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/26/24 18:39, Michael Tokarev wrote:
> Hi!
> 
> What's the reason to require python-pycotap when configuring qemu?
> It does not look like an essential part of build procedure, but used
> to run tests only, no?
> 
> While this python module is shipped with qemu, but for downstream
> distributions these are usually stripped off the source tarball.
The reason is simply that it's a very small dependency, and not worth 
the complication of installing it in pyvenv/ on demand.

Paolo



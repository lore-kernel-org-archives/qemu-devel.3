Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E466BD16810
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 11:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veANt-0003ss-3g; Fri, 09 Jan 2026 06:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veANr-0003sh-Q4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veANp-0006b9-W6
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 06:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767957020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wRXG+pyj1vAmJaRVg8fwxQbRsqtEbEydEJkqifcNPuY=;
 b=aGuupwjioOr0utqlCTBzX9Cu1vet98d8NHFcTpbFoUp6rb0KnnCpqCxjfCeq7dYOjBZmcE
 1Lk7+dj0KC3d3j1fW5uioR3icaREwTNaIcsT8/KdtliZk4e1f4FzIIWXgfsa7S8CHk1VsX
 3Iale0bsT4tCv+0vhJKjb7jOeHR64FI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-t2aH2Te2PDeeCCjxVDulnQ-1; Fri, 09 Jan 2026 06:10:19 -0500
X-MC-Unique: t2aH2Te2PDeeCCjxVDulnQ-1
X-Mimecast-MFC-AGG-ID: t2aH2Te2PDeeCCjxVDulnQ_1767957018
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325cc15176so1965430f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 03:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767957018; x=1768561818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wRXG+pyj1vAmJaRVg8fwxQbRsqtEbEydEJkqifcNPuY=;
 b=WyZdWLp/lm97m5v+Dp3EOVYFS1v10+pTRn74nSEHRi9TllJsxFKfBsoMQRxsYlvw/1
 4ayIhRASxR7+hVZQXFZgGDsJn1WpYYD8l7p7HglV7Hw+QllL6trO+O3Z7ysPcTog824Z
 NyOxl7PryleyNzgaVz++CIuDT+iKMVlfZo1dvtrwF/Zs7QudMkIaWSSm1/CrztM30wsx
 kOqiXHi9+H77w7Mp+vjbkHXh0r9LhyonHlh27tVjcmM23KxuOgW7s7XXC2ZV236KoWLT
 hW4kep4S4UTz0+wln/U8t+8Z1BqyZWQoUaU7ccdtcF66OQSdL5n00e3XKUI8XWOxdDl/
 MYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767957018; x=1768561818;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wRXG+pyj1vAmJaRVg8fwxQbRsqtEbEydEJkqifcNPuY=;
 b=lwWKyQI9U2q3WH26JbTv4jiBaColVhCj3c81Ck042IHw1vbOnx35mgAi2GeCOp08eJ
 hqwEKljx2EmSuDr+CMT8NlFIszZHSNaCMUJbpguGkgndgAZ0SBxoIkmndQrx3Yv46Xwo
 hRfc6KKsV2rFRX/DN2DE1tMTM4ukKSrqkLGL0m0S5KrtvHo6pN1TWQkl7+x44sbaAhiQ
 O/g/nBjF5DVca9zlsjtIjPAaCuINKGP/Q25CK/VXnh9s1LT9BmF5t2bm/WP7sLDswqb2
 5QjWRTW6uomCrQQMlFitd1GYCdsOv4gw9yA876xn78FJO1Wuzvuadmr3JDAqt/nFmxCv
 s5Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuCwpt5Qwx4Y0m55QvwCJOcs8E/ji16IRhGvOvioGa6GZNIO+NKSqVliRN2LaRnCAdLj3paD7ghHqx@nongnu.org
X-Gm-Message-State: AOJu0YwfKOUb6WA0gjSoljzvLtY/89XQa1t2WKSZ/SCZD/7AZmONPHrv
 JwCC/g0D+SmGB+xhRp7g77eXkQclcbXRsp0wMoeOeyF/IULLbJroRatNJB9MXWjss4e/AN2hDgu
 afpjJ4b0UreqKTsRnCLwjA5qbldBILYsR0IdzpcjyTGh7T8UTGBR1N32N
X-Gm-Gg: AY/fxX6RHegCyFDZ05TdfsNNybJoLjpn8xMvFn8LrEZRtcuZWRCWQ4vepRldRmcQxzt
 bAwl7C23LF4b5h8jB81cc+yhI6US1eX030g5vUJqM1xiWmZKuNJMdtOacyZ9y/JklOLbWVaX5c9
 34zpP6s9mQpF8JR2Fu4lbc6sPBrRt8LLsnmCkmh2nTCVA9pVyMUcpExnpVO4KJ6vZsgrLyr3jmm
 Bqj/u9E7eZj443aa7wAe4VHLvKb7RDqoMytb3tjEdJCT3YF1ZY3XyyQOJG+DoCtWTF8e4RSxp4V
 4uPbR9pHvc36wkyJfLDZEzD/LSV6/QFIl7Ejh1LUMARv01gbqvYnAN6AtJ8ykqzbBtKLiRQAdmw
 vkQxFsU+wKb2BYIHB+njbpqNVBJCjz9r1BMx2R7vFf11hqANf0N9btXmOqN45hA1Z4uXG9XRW4y
 avA3WAHH2YZ3QVUA==
X-Received: by 2002:a05:6000:40cd:b0:432:84ee:186f with SMTP id
 ffacd0b85a97d-432c379dc44mr11612355f8f.33.1767957017737; 
 Fri, 09 Jan 2026 03:10:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG43kCQoUwZHU3q4aQ5yARJ9lebuQ8nHAnMHgUUYx9SErez6kil1+VlSi+BpZMN0mN1DEAivQ==
X-Received: by 2002:a05:6000:40cd:b0:432:84ee:186f with SMTP id
 ffacd0b85a97d-432c379dc44mr11612334f8f.33.1767957017277; 
 Fri, 09 Jan 2026 03:10:17 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ede7esm21771888f8f.32.2026.01.09.03.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 03:10:16 -0800 (PST)
Message-ID: <f30d20ff-ca96-48eb-b837-b3332ef4559e@redhat.com>
Date: Fri, 9 Jan 2026 12:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/50] Remove 32-bit host support
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
References: <3b5ddc4e-f631-4412-9fd6-ebbf49c55ab2@redhat.com>
 <afa3adb6-a94d-4ed8-b5fb-50071b5d4b22@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <afa3adb6-a94d-4ed8-b5fb-50071b5d4b22@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/9/26 11:34, Kohei Tokunaga wrote:
> Hi Paolo,
> 
>  > > Long has it been threatened, but here we are at last.
>  > >
>  > > 32-bit host support was deprecated with the 10.0 release, and so
>  > > with the 11.0 release we may remove it.  Phil already did some
>  > > cleanup in 10.2, removing support for mips32 and ppc32 within tcg.
>  >
>  > What is the situation with wasm?  If I understand correctly, wasm32
>  > really is a 64-bit target from the TCG point of view, because it has
>  > 64-bit registers internally (similar to x32).
> 
> Currently, wasm32 compilation is treated as a 32bit target with support 
> only
> for 32bit guests. 64bit guest support would require additional patches to
> TCG, as discussed in the earlier attempt.
> (e.g. https://patchew.org/QEMU/ 
> cover.1747922170.git.ktokunaga.mail@gmail.com/).
> 
> As an alternative approach, there is a patch set for 64bit compilation
> support using wasm64 target, which doesn't require the additional TCG
> patches. QEMU can still run on wasm32 engines (e.g. Safari) by relying on
> the Emscripten's feature to lower the output binary to wasm32.

What is the performance of lowered 64-bit vs. the TCG_VADDR_BITS 
approach?  Also, Emscripten's -sMEMORY64=2 is okay for TCI but it would 
not work for TCG; you'd still need TCG_VADDR_BITS to be able to produce 
wasm32 at runtime, which makes -sMEMORY64=2 only a stopgap.

So I think we should go for TCG_VADDR_BITS anyway.  It's surprisingly 
*un*invasive.

I assume wasm32 has CONFIG_ATOMIC64?

Paolo

> https://patchew.org/QEMU/cover.1767886100.git.ktokunaga.mail@gmail.com/
> 
> I've rebased this series on the recent tree yesterday.
> 
> Regards,
> Kohei
> 
> 
> 
> 



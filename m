Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F57CFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 07:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQKak-0005q7-Mk; Tue, 02 Dec 2025 02:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vQKai-0005pE-LT
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 02:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vQKah-00037b-0U
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 02:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764659665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UccSMp6iYP53arg9sjByOFiKvWdoCUfBWp63aUb2Hok=;
 b=CYrroW+BtdLzDD4/nk0RRJkaNAo7Kyfo6vFL/Zj1YST8cqfvky+LvIXt7Ti/cNhyf7tkKW
 xmQ7abTXbisLX9kuAUFuX1TE6F96MXxJiolyTO9zN8eCv/fddvjnKmQ9ebhjVvWkmsOutf
 oCnMJMM+JTnT3xSJMFAcgtqRee8kJL0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-tcT_F6tHOGa6LJUMmgTXpA-1; Tue, 02 Dec 2025 02:14:23 -0500
X-MC-Unique: tcT_F6tHOGa6LJUMmgTXpA-1
X-Mimecast-MFC-AGG-ID: tcT_F6tHOGa6LJUMmgTXpA_1764659662
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b70b1778687so339581666b.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 23:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764659662; x=1765264462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UccSMp6iYP53arg9sjByOFiKvWdoCUfBWp63aUb2Hok=;
 b=ZGbMu9g+xsUiboYKYfPd+E8n9Yywc6KgVreoROb9asZYmKzISjGLZSGKu1zM+DlK7P
 +IrSwDoCsB4uqQUZVI/zuZnf8Dqx1b3axm3OF0Ua2Q/zTXdB2T9qCXCT1rn+RoxSKSPa
 2mn28RykcPzdDLu1d5xo0NuIISqUWrR3k/Vyf8gRCz2wEJHjk6uLKYa6Dy5GzCSHy9l/
 p4opPeBahWUKI/vlwtAJmMQfokekBcsrd78N1ZMiApjJR0fclJBCsPv1ArSAXOgeH+NJ
 wAp9l2tqqtaQK9fnFCUoWj4j7U04qHUWQpcK5rE6o+6hruNupUpb/dY0KdQeLmwFFtdv
 ROMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764659662; x=1765264462;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UccSMp6iYP53arg9sjByOFiKvWdoCUfBWp63aUb2Hok=;
 b=AI34O/OueE2f+kPtvVWRZ/jEQAIQzW82eIPe5Ex5Fdc3ryjdM1d+c0AudN+K1GbuPh
 KHemfVHgQCK8tSDaRd87n94oHtWZv3d++Vxh4mtg3Thl0p+sioK2jbrGh9mu8sDh7ZGu
 Jn2zTqBkoDO5OZd9VPrDknOj8Aaw7dTuM2v8tnzaIdRzodKKngzGQoYoU6YqsqKD/UCm
 AtffsZM+qM+mU6cfZB1KNp4WNwKBCl9zkH/YCwg3S1lZBYqhDK2R2Wf4mut2rXLbBSmP
 CRBT2cwXGtDiUzpkV+EuOmqoMcdToT47AEIovfIKwKuCR24wdElhkpKOJpxVlccuqS+8
 gVkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaQcTnGcaF2uxEKQT9oZSgBSEYJeslEdv5ykzfVwLdcjHCjt4PdPkJuTyHgVLuR09WEv7i7jrfJC54@nongnu.org
X-Gm-Message-State: AOJu0YzKy/B4DKxwcbjtAsZ1ABHEsUtkJORRMx43Y3fditYZyXKmY/rZ
 ubhrdJDyF6xL6WfG1oe89O57hcW6y7uDnXoE60SDAClKDbSf/ZywAyH1Kq3c++XCb97l/AJchzS
 Tz3rwr3FmbmvnwAwhJ3f1s6ek4Z6wKSKtqTAjJ/1fEpMAqhDGIcUH5MNs
X-Gm-Gg: ASbGncvwzYV8gOzXFBvJFLnrp+kt5LYTSaJkrXox9/Y8AvVbS5iz5D3zG8+Pcrr3st2
 18wF2NEwNX6l7OMeDjHngyhQ/ahGiyabrY+m4X9u1QKAQNjGU5Y1lBgcCyk+lENKFQb0J7VK8Ux
 WuuEyrQCwg4tTPmEyhR64Kcuz8mIIryAP71vhkzDrHmATTXNR+0+wHsNT7y2BoaNnRAPv/TL4Pr
 Si14+hjs+R5JQYAK6E48ffU9+ysO9AVnvofLVHxkw8V2669ZyiqpcyPucgEXU3LAo+UXkWA5wxt
 Gr6OZUYQ/p7igK9ahYk9Io4Obxr2NidXPZoQWX/quf0m3lfJ1WjHBeq8c6v+g113T2JJzEOD+Yj
 dvjii5w==
X-Received: by 2002:a05:6402:1d4f:b0:639:ffb5:3606 with SMTP id
 4fb4d7f45d1cf-64555d2631amr37113788a12.33.1764659662400; 
 Mon, 01 Dec 2025 23:14:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/HS46XeSHrBKYTsH57eUQPalvpdzey5pC5JvRQWknjw3hJhNAfYVaZy1ahA3Ksp48+Fke9A==
X-Received: by 2002:a05:6402:1d4f:b0:639:ffb5:3606 with SMTP id
 4fb4d7f45d1cf-64555d2631amr37113767a12.33.1764659662012; 
 Mon, 01 Dec 2025 23:14:22 -0800 (PST)
Received: from [192.168.0.5] ([47.64.115.41]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751035c2fsm14808391a12.17.2025.12.01.23.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 23:14:21 -0800 (PST)
Message-ID: <95dd7914-8e58-42e7-9988-cd7822f17bca@redhat.com>
Date: Tue, 2 Dec 2025 08:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options.hx: Replace deprecated -M example
To: dave@treblig.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru,
 laurent@vivier.eu
Cc: jak@jak-linux.org, qemu-devel@nongnu.org
References: <20251202005740.299524-1-dave@treblig.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251202005740.299524-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 02/12/2025 01.57, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> The -M option was deprecated by -machine in 2011 by 80f52a669
> and isn't actually documented in the manpage, but is still used in
> one of the examples.  Replace it by -machine.
> -M still gets used all over the place in other docs, and I'm
> not sure I realised it was deprecated until Julian pointed out it
> wasn't actually documented.

-M is not mentioned in docs/about/deprecated.rst, so no, it's not officially 
deprecated. And I think it's a nice short hand feature for an option that is 
used very often, so I also don't think that we should ever remove it. Thus I 
think it would be better to simply add it back to qemu-options.hx instead.

  Thomas



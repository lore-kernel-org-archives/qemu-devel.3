Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1C5D609A3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 06:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGBYV-0004zT-4x; Wed, 27 Nov 2024 01:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGBYR-0004zC-NK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 01:29:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGBYQ-0003mq-62
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 01:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732688976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VOhPJEMxNUU191p4W6N24jE9gGwh7lQr5jXgzxCg6yE=;
 b=g6N4eR7DkKjw6Ru1r02wIwi04Q2RRoZgIRjWItIdAw2Uu7OKffF5ojMk9XuYI1QeXyAlNH
 uqUvSdRORnViVw8HQSgEuzPWgUXmYlB3oG+L54W39luqXshadxHHO6DcOYu76nYni0Hr3E
 ZPuke9k0z6isHLzscrHcbYRmtC5bS3g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-wfznukOMO7uCCoFD9ehEYQ-1; Wed, 27 Nov 2024 01:29:34 -0500
X-MC-Unique: wfznukOMO7uCCoFD9ehEYQ-1
X-Mimecast-MFC-AGG-ID: wfznukOMO7uCCoFD9ehEYQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434a6483514so13185685e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 22:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732688973; x=1733293773;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VOhPJEMxNUU191p4W6N24jE9gGwh7lQr5jXgzxCg6yE=;
 b=T2WA2mBK2Rm7LlaGxw4hboalCGJ9AEkLEWAP8ikRUYyidZec6eTtKuH/NefXzYmaDT
 uBIIOCLLnO+bEqDtPIqaQuBbqwdlL0c55a3kejCV3uIlpcGw6jHEhr09KOcErMq1F+KK
 ZH/UuhDR2qFXS0LeifS0f7M02X/kT2VqotryIdG4ocqHH6i+VMYZP5HQPcCxo91NwE/T
 lkEl5PhBp9deLSSAsZxej6G/P6nxgfWbtX3xA3xVCw6+eFfLX9AU+IhPsRlhnGvXufbx
 M0eE+Gap+VtBML8xuuajMiZ4Q/1VJAkY765+VEJl3rxOy3TK4kFSN/oX/x7KVJUJZDo4
 Cb1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL/K2Y6ISdmzjG11AffIycESq8lBkxrkPW+tz+ZIcCUaY3Y0s5ZUyAZuVwUzqkBMl9Fn9JPesTW6o7@nongnu.org
X-Gm-Message-State: AOJu0YzRjzZ8jjIlJ0xL5ILWnMJW5TVsmso/Pc65BcJSol+YBUZsKR7n
 bk4mJM3Ur5HBXjop0FQhEjrK9BUs8aa8mqOgQHKJuIbyCoRAGFWo9HQ6TMAjQhqh3OB/OJziqL7
 bBaL7002k0c0Ym+jPSHkstyWVXxtKTb2FsKkgk5ZY8NfNsQz3dxLh
X-Gm-Gg: ASbGnctbqUzq/R7LttvjJi2bvlGcxpkiardqC6XFgD1k8hlO0PRiVo8Vk+gOTAtBlSY
 nyztKzdBcFn+5Kp8eAQNO2j3tvLnmi0CDVvZEngYvW0tmgPE/Zt0RzmhKR6SYqVaoKdp07P/SMz
 i8YZD8ezof3Np/+fMBxh+T65ty8mmZ+DMoI7avuvkcP+tLZlsIBcWIWea/1+wQMDlz13boXVvsh
 KbtmPHdw0SgunG1mseLAcD+x/rkdmhrBuv2W8smWzcOmgtMMCUnOnTTxDGf1OjkGNxfIBXERUcg
 PgSKhw==
X-Received: by 2002:a05:600c:4fc1:b0:434:a29d:6c71 with SMTP id
 5b1f17b1804b1-434a9df0385mr14462195e9.27.1732688973673; 
 Tue, 26 Nov 2024 22:29:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdUaO1H3aLaU+MO/kKFEGmxgvBvVt6kja/XySG3f9RxuwzYKtTbnedx+o4Kw5185tKJOUKKg==
X-Received: by 2002:a05:600c:4fc1:b0:434:a29d:6c71 with SMTP id
 5b1f17b1804b1-434a9df0385mr14462065e9.27.1732688973326; 
 Tue, 26 Nov 2024 22:29:33 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7d1a90sm10376095e9.32.2024.11.26.22.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 22:29:32 -0800 (PST)
Message-ID: <ce5825ff-53f5-4cf9-aa6d-e0d28639e664@redhat.com>
Date: Wed, 27 Nov 2024 07:29:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
 <7c62e46b-26c8-48e7-b8ec-b7478146a8d1@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <7c62e46b-26c8-48e7-b8ec-b7478146a8d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 26/11/2024 23.54, Richard Henderson wrote:
> On 11/26/24 11:52, Thomas Huth wrote:
>> I think we want to continue to maek failing downloads as test failures, 
>> otherwise we'll never notice when an asset is not available from the 
>> internet anymore (since SKIPs just get ignored).
> 
> I disagree.  Download failures are not rare.

That's not what I said / meant. Sure, servers can have hiccups and downloads 
can fail, but that's what we have the cache for. So having a working cache 
is essential.

OTOH, if you simply mark tests as SKIP if the download fail, we'll likely 
miss if an asset vanishes completely, since some people already have it in 
their cache and the remaining people will likely just ignore skipped tests.

  Thomas



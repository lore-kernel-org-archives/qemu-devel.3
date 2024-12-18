Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486D4E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrZ1-0007jN-Fn; Wed, 18 Dec 2024 05:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrYr-0007ib-W5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:45:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrYp-00056q-D6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734518744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=501tyJIPyTh+rYUdRL/jI48Nipd3Dv8ighqq8gy6OGU=;
 b=fT0YDyaLTrJrVnD7cnigh5DfeGxAEfDjh8N3jnBX5pOMCTDx+Gnp+NCYoQl7IJ8aWJ5YyD
 ipoDYQnhKhaIQNcdj0TlqEJ8J7IqvX0mfvIxCiZpMftwzUv6R/JLfKxz4O6dUDH3MYd1sA
 oAcifdDVZcbuM4SB/pii7dLPfdlYlt8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-8mU296ViPYixeHR7EbP4VQ-1; Wed, 18 Dec 2024 05:45:42 -0500
X-MC-Unique: 8mU296ViPYixeHR7EbP4VQ-1
X-Mimecast-MFC-AGG-ID: 8mU296ViPYixeHR7EbP4VQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so18728635e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734518741; x=1735123541;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=501tyJIPyTh+rYUdRL/jI48Nipd3Dv8ighqq8gy6OGU=;
 b=XkVgc5kM4uQ9jEjiv0IuAv+/DvGNaaQSySteHNetmIZ8t84SO5UvhktCe34UK/TRGN
 H5J3UpzqDtxctvhtuZM5orHn07QuDBC12RJw0cZg8RNAmBsTUgBQtNYERuyFJoTJTKz9
 WrazVsArQqDOkqFKGI12uY71zlJWuw+4RzlhtjnCTYLh6ZIbZu7G51PaYyZw4a6mE7bl
 9HNXkwEujfYNB0ObQqDcXrQIvXeHEV9BcCxFTNjo+XrQ16QUFfHTsLftEPrXA09OkIBe
 gq5SGkqnjmyaQaGEmeaE+bX4WpmpClX2P/A7FyJquoxSqeZnd7viywa11oBr4QGUr77J
 FvYg==
X-Gm-Message-State: AOJu0YxuswTfoM79eG+WcSX0F3lJ01WDAjHBfO3vWkmKwL8OzcpW2hAl
 qwclFULjfhmElfDrbuqxCCZ8woQjL2vqb8SgFM7BY4CPXl/kHKfyjRFf8Y7aDfx+YsI7IKbL4mo
 CisHeihth+EQupXf1HAAVm68lfgDwbjX+p9qrofRy2n815l2MBw0+
X-Gm-Gg: ASbGncuZC7RwBTIua9iuJpAGb1VEEU/7hUY3kZqjxhzIotw1CYlzxhrYLrS508Ywddr
 ec9gkijYvLSDXSbf4D13QvWV82oMKlq7i/v2RMZlSnYHb5gDT/EaC3psQ7PCFaIKGjRP877pmMN
 ccV9nTI5sT3rUQCsNWz4kX3ze76sV4MzwGr/t3bRPonCgYmX3pu3jxb8W5hjt6H/lW/kw6t+7+8
 leTIL2LiBMfOswDJZTuzOYd/hVWfX+4iuO7Te+QTWmrstqHuEjCGHmJ5E4gzmQ9clZHs4z8pD7I
 JnB895JoE3RE
X-Received: by 2002:a05:600c:4fd3:b0:434:fddf:5c13 with SMTP id
 5b1f17b1804b1-4365536faa3mr19286725e9.14.1734518741360; 
 Wed, 18 Dec 2024 02:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/m+DxURddz39vus51uUDG63vLvWzECUsJWpSBdiNcuF/hjTwJb/lh4Xj7npiSTLV1Es8k/A==
X-Received: by 2002:a05:600c:4fd3:b0:434:fddf:5c13 with SMTP id
 5b1f17b1804b1-4365536faa3mr19286385e9.14.1734518740950; 
 Wed, 18 Dec 2024 02:45:40 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-186.web.vodafone.de.
 [109.42.49.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119d7sm16263095e9.20.2024.12.18.02.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:45:40 -0800 (PST)
Message-ID: <92fcd473-588b-4981-9f14-b802a9e6aa84@redhat.com>
Date: Wed, 18 Dec 2024 11:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Disallow libnfs v6 to fix the broken macOS
 build
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Lieven <pl@dlhnet.de>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
References: <20241218065157.209020-1-thuth@redhat.com>
 <Z2Kmo_Kixrun1mAl@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z2Kmo_Kixrun1mAl@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/12/2024 11.40, Daniel P. Berrangé wrote:
> On Wed, Dec 18, 2024 at 07:51:57AM +0100, Thomas Huth wrote:
>> The macOS build in our CI is currently broken since homebrew
>> updated libnfs to version 6 - and that version apparently comes
>> with a big API breakage. Disallow that version for now to get the
>> broken CI job working again. Once somebody had enough time to
>> adapt our code in block/nfs.c, we can revert this change again.
> 
> NB This isn't limited to macOS. We've already been broken by
> this in Fedora:
> 
>    https://lists.nongnu.org/archive/html/qemu-block/2024-12/msg00151.html
> 
> other distros will no doubt break too soon enough.

Ah, that discussion was on qemu-block, not on qemu-devel, that's why I 
didn't notice it :-/ Thanks for the pointer!

  Thomas



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D6ED75BC8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 06:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE18w-00077M-EH; Thu, 21 Nov 2024 01:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tE18v-000779-GS
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 01:58:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tE18t-00005i-UM
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 01:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732172298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0L8hWkMftFngYzsfQVpgiM1tFQLsV/0GyZINI/ydjlA=;
 b=BP8FyCUkC5JpjSecmtI1Ij/JescKt+YsBrx8N7BF9U7mi6izBkzO+6c0NtZvsq0HVcUAVQ
 eeOEM4VTEOyIq9WDFG2j1323BgfsZ0oEn1UrO6tsZdheiZ/D8iCHkiADstWWkFQ+weOflS
 07TDferOISJ2lwNAU/ewAsPAK09F4Qo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-nj7YHkOAOtyuipCl-FjamA-1; Thu, 21 Nov 2024 01:58:16 -0500
X-MC-Unique: nj7YHkOAOtyuipCl-FjamA-1
X-Mimecast-MFC-AGG-ID: nj7YHkOAOtyuipCl-FjamA
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5cffa805c94so353131a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 22:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732172295; x=1732777095;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0L8hWkMftFngYzsfQVpgiM1tFQLsV/0GyZINI/ydjlA=;
 b=aaz59jClYq0wuR2SDIwX6q1Y8JLxCDeAYXl9nJRvM9pkKU+hSMWdDuUmAWfetAtfwt
 6N+qKQMangda0rLWoGqFf1nqQyL6T3bWHi19xxzfQxhuTE7ysT/mVI6Bl7e91io1P76+
 Wbox8UOBTgSiZTT6sId+GGxRDTB1JGSOM7NPcdVnVHYV7j8kRrjqeMzGsq2rHonTcVM4
 N3tE/J47um6DLov9tSwKWFSiH8hwFcIwI8jnnzKxe2M3L07qULqdI7htC1Bmfti7c+eD
 kl+VpF5+p5PqNLjLKa7MbtfgcEF3hpufbRrcENR589wr5YadGzh/dTFuin+soHJ0p0zo
 33rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2dw+7lH5FfT3ZaEm1aQ4+BFjHZoguth0WMjR2rIbzdJqwSI9dKujKbHpbVJgtCp0lxLSfVIcOTxox@nongnu.org
X-Gm-Message-State: AOJu0YwTMrzD5o3Q5WyAxjeeGgMaH71Xoo3QUdtQUyPRhge3HsAi7jIA
 JtI3tFblm+Ous7Cc8Q21vVxDVPcJsmwnYNS4Q3MH0/gdIpItqRniRNCWfwxIgud4vbqpqrsL0Ce
 O3yRxsDcXJuejyXNazurTsFEA7aBPfla+PPn90n2U/5PC0g27z82m
X-Gm-Gg: ASbGncsAQvacPyPQOTgnmrj7uJ/qIe3EBIXy8Kf9bnKiqh+uvmS3sDO4zyMWRSPlyEu
 GoAzZ+bHpZWiIOEZouxYJUW0bLeKFFO9YMbUoXbS2QLrGMFinhvk+BO/CFvMTG5hgheq7W9QT1q
 Ny+EJXD4+J3XiM5oD+K9tVSEKGd+Dwm7qm6bvvQBOCCAxAbIm5HlI60eMnfs9D0N3aeLTn4AerN
 yLKgq3LrZFWwLddbkC+zKgVdOWn5G0AoyzUoeA2IBNvQbpVL46Y6SAeIk9BvtTu61/Mjiqm72NI
 akg=
X-Received: by 2002:a17:906:dac2:b0:a9e:45e6:42cb with SMTP id
 a640c23a62f3a-aa4dd55226emr614192366b.18.1732172295285; 
 Wed, 20 Nov 2024 22:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNiQp07DJSQcGkxRWorofLn/wUW0iEiYAXLo8pnaOA0mKEnl2LnaYHKiHCExD33hAE6US8iw==
X-Received: by 2002:a17:906:dac2:b0:a9e:45e6:42cb with SMTP id
 a640c23a62f3a-aa4dd55226emr614190966b.18.1732172294998; 
 Wed, 20 Nov 2024 22:58:14 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa4f4319b8bsm43558066b.142.2024.11.20.22.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 22:58:14 -0800 (PST)
Message-ID: <412194e0-dd17-44f3-a01f-1ba5a9131d6b@redhat.com>
Date: Thu, 21 Nov 2024 07:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] tests/functional: logs details of console
 interaction operations
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-13-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241119150519.1123365-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On 19/11/2024 16.05, Daniel P. Berrangé wrote:
> When functional tests go wrong, it will often be related to the console
> interaction wait state. By logging the messages that we're looking for,
> and data we're about to be sending, it'll be easier to diagnose where
> tests are getting stuck.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/cmd.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index cbabb1ceed..76a48064cd 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -85,6 +85,8 @@ def _console_interaction(test, success_message, failure_message,
>           vm = test.vm
>       console = vm.console_file
>       console_logger = logging.getLogger('console')
> +    test.log.debug(f"Console interaction success:'{success_message}' " +

I have to admit that I had to read the message twice to really understand 
it. Since the message starts with "Console interaction success", I thought 
that this message means that we successfully matched a string already.

So maybe rather change the text to read:

  Console interaction: success_msg=... failure_msg=...

?

  Thomas



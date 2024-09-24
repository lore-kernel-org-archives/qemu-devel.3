Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5704ECF9C71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 07:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st0LN-0003UL-Jd; Tue, 24 Sep 2024 03:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1st0LF-0003Ry-6v
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 03:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1st0LD-0006Jk-7a
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 03:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727164330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NN8pCjexG3MR0hIRbXlnctnnZmN40fcUFrW2OUbddL4=;
 b=Ckc7qG6aqZY7IVz7o0wRhjh5xbbQ7pvSAXj483vrm5D8JqjusynNRm1zeq4tH4YqUWJ2EH
 0osoxwX/Ob5CjgkgJeq7HK7+l8U9kAbKxxzTYncDW7tVSpzJYKzLAMMs66FSqH8tcOoZ6B
 WNRmXary0N3a9jbgcxdP+5YtMRm314M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-nA7ay7k3NqmGSICsAEaNoA-1; Tue, 24 Sep 2024 03:52:08 -0400
X-MC-Unique: nA7ay7k3NqmGSICsAEaNoA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb940cd67so48325775e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 00:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727164327; x=1727769127;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NN8pCjexG3MR0hIRbXlnctnnZmN40fcUFrW2OUbddL4=;
 b=xRRcJeAVNA+WSqBDhQ6O9MPc6dDUv6OiFuyVfOU3wM1iOd9iFYD3II+y5NwAfM6GeA
 nXTMGLmDD11ji9NQB57n/0vmO74uhVlVDvjDL08WgH9Q0dmh3EjOHjkMkH6JLle8+xCd
 pZWlCDsL0cn+TFk7ZesdtvTOMBvy4bsEvUCjxC5COvatCTcRga90G074neTDqZj+3grX
 qZu0c5YDyOon45iFNGa1HppJgQhvNTTgMvEisuAhiLWSukE8bZv1wo4wYLgbkAQPi8TU
 ZLF8fyY/BHIM+IyLedAMNZ0/t+Ff9xM6qpIb7nVPzNlS7jBHQhwueQ5AOIfavLtBvjs0
 c81A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7HCbEa7Bf4Zx22LgIe9aB+TH5QSdKayexDGqYH1K9TsSx+4+nRNCakfqQsWVtDage06rLlk1i86f5@nongnu.org
X-Gm-Message-State: AOJu0YzwLCAzQaciMyZIkaH+wJB+zrPH5um9wHaFof9mLfiB4j6E5Nja
 z79nLpmFdKX+BGOH6+ubdI2eesoYVT2HAJcJPc5yX+Frl7jc+74Ph76YjnxwvxU2xNUe8ZKYB+t
 sluujhxu7JxQE2GH/dUPUR+9C9LTONRFKpaWSeb6Zx/yKpfl8KH4c
X-Received: by 2002:a05:600c:1d12:b0:42c:c401:6d6f with SMTP id
 5b1f17b1804b1-42e7ac4b294mr153688835e9.16.1727164327073; 
 Tue, 24 Sep 2024 00:52:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4CzvIH/KCUfaQPfzxjXz+1LxnAfKrc+4hbp0FO2iVNWfFgCFaeKAOg1/eljDLeg2lxr814Q==
X-Received: by 2002:a05:600c:1d12:b0:42c:c401:6d6f with SMTP id
 5b1f17b1804b1-42e7ac4b294mr153688505e9.16.1727164326597; 
 Tue, 24 Sep 2024 00:52:06 -0700 (PDT)
Received: from [10.202.148.89] (nat-pool-brq-u.redhat.com. [213.175.37.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2f9883sm848636f8f.88.2024.09.24.00.52.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 00:52:05 -0700 (PDT)
Message-ID: <f556beca-2a9a-4d8d-9c87-f2c6aaed40a9@redhat.com>
Date: Tue, 24 Sep 2024 09:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
To: Eric Blake <eblake@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 qemu-block@nongnu.org
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
 <20240328141342.GK7636@redhat.com> <20240922195122.GK5140@redhat.com>
 <pgpowzixuswmhxdjo2gl2anpavklksbsevgmhvq4ljy3wam5hh@djuiesky7nvw>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <pgpowzixuswmhxdjo2gl2anpavklksbsevgmhvq4ljy3wam5hh@djuiesky7nvw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/09/2024 18.03, Eric Blake wrote:
> On Sun, Sep 22, 2024 at 08:51:22PM GMT, Richard W.M. Jones wrote:
>> On Thu, Mar 28, 2024 at 02:13:42PM +0000, Richard W.M. Jones wrote:
>>> On Thu, Mar 28, 2024 at 03:06:03PM +0100, Thomas Huth wrote:
>>>> Since version 2.66, glib has useful URI parsing functions, too.
>>>> Use those instead of the QEMU-internal ones to be finally able
>>>> to get rid of the latter. The g_uri_get_host() also takes care
>>>> of removing the square brackets from IPv6 addresses, so we can
>>>> drop that part of the QEMU code now, too.
>>>>
> 
>>>>   
>>>> -    p = uri->path ? uri->path : "";
>>>> +    p = g_uri_get_path(uri) ?: "";
>>>>       if (p[0] == '/') {
>>>>           p++;
>>>>       }
> 
>>> Looks ok,
>>>
>>> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
>>
>> Or maybe not.  This caused a regression in the nbdkit test suite (when
>> we use qemu-img from 9.1).  It seems the exportname part of the NBD
>> URI gets munged:
>>
>> https://gitlab.com/qemu-project/qemu/-/issues/2584
> 
> To be more specific, it looks like
> g_uri_get_path("./name//with//..//slashes") is getting munged to
> "name/slashes".  That is, glib is blindly assuming that ./ and XXX/../
> can be dropped, and // can be simplified to /, which may be true for
> arbitrary file names but not true for abitrary URIs (since URIs have
> application-specific semantics, which may not match path name
> traversal semantics).  Looks like we need to report a bug to glib,
> and/or see if glib's URI functions have a flag for turning off this
> unwanted munging.
> 
> Or we may just want to document this corner case change as
> intentional.

Ok ... so how bad is this for NBD? Can we go along with the odditiy or is 
this breaking some real world NBD scenarios?

... in the worst case, we have to revert the patch ...

  Thomas



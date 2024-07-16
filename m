Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47B8C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 21:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTpXe-0005wz-4q; Tue, 16 Jul 2024 17:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTpXa-0005vq-LM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:16:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTpXY-0004dI-Pe
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:16:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so48354555e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721164611; x=1721769411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q73bjHDDMOePFIH4er+/8JN2abdwD0pFh7+cOTS0NC8=;
 b=lscb3Jl1N1YcWEuRQi6vJUZeJUBEjKLh3yTx90l9OhM8EMT87i0LCGp9nP//TffGMl
 mOvRTMTIitm6h0rIjnjVftDoA801UR4n98pWZlfIaAj+W1UCjhGotJzvObSv/tNQBz4T
 2ao8658KZMsaVt+cTJx4vghGffHB/imRl5g5o+EeAQ+731lA9lDQcgXI/rMqopoVaZJ7
 ufwA8Dq4gqF0dJ21zs3I/wk+P1TTgclShw18urQzYn6YBtAmycsmztMIvEzkMPQP40HU
 nztbQRvr8lz8MRVtlfv+6cVQe9lqLwU62F7iJOicGbNWQfzcWxjI7zj7rEyRrMzhrwT3
 RS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721164611; x=1721769411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q73bjHDDMOePFIH4er+/8JN2abdwD0pFh7+cOTS0NC8=;
 b=aHQGWPbiV/vhMgQfaprpUqGKXOlMQL7N8QaAVXaTfjBt8TURrn9YPGqd3eqhr8RQmB
 wxmBdASKlAPGLjKu3B4DUpkDzxrra0uEzvHCCTG6aNXaONoth6686fQ2YZz2LMuIk3Cl
 AljlDw41UeNS3vFLdimNEC79NMI2K304kfbxzWE3GREkqTR4BSMH2tWtFXL6bmVQ1nzC
 MpMFhBA/xNbeY6DVftK14gX/A8v4Hge9TyrujSg8Xo7khtvcFX9Bi8Wtjjq30YwnR2f5
 +lFoOYEDhtRUOoXpnSS4DF5Y9vAttBnyj0lvz96tPWT/rn5EiicqK7u61aZCUbtFclYX
 Z87A==
X-Gm-Message-State: AOJu0YxfFairvmgkucuJ1XQ375SO30eWwxPoyX6/uAUFc7InIfikOKdl
 wp4P1f1QIuc3lDLGRb8ErWyz69LoYONxgL60RMsgoZX2fpTVdTUImDpq4jt9I4w=
X-Google-Smtp-Source: AGHT+IH1xmKPpyAMbLNM3g0or1/+qOIwX6yswK+tT5y6vf9fN6DXHbTsAzWsomX3/P8XBzsCuMOg/g==
X-Received: by 2002:a05:600c:3548:b0:426:6f87:65fc with SMTP id
 5b1f17b1804b1-427ba6872f1mr31474165e9.17.1721164610695; 
 Tue, 16 Jul 2024 14:16:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427bb99a23dsm28509015e9.1.2024.07.16.14.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 14:16:50 -0700 (PDT)
Message-ID: <056b70a6-7040-46cb-9e88-3724a0671a65@linaro.org>
Date: Tue, 16 Jul 2024 23:16:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] qapi/machine: Clarify query-uuid value when none has
 been specified
To: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Michael Tsirkin <mst@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240711112228.2140606-1-armbru@redhat.com>
 <20240711112228.2140606-4-armbru@redhat.com>
 <CAFn=p-Zv9e7MFhpGK=PssPYGbe7Q3R-A0CAdYEMbtaY60ATWrw@mail.gmail.com>
 <87v815i4t5.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87v815i4t5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 16/7/24 20:12, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On Thu, Jul 11, 2024, 7:22 AM Markus Armbruster <armbru@redhat.com> wrote:
>>
>>> When no UUID has been specified, query-uuid returns
>>>
>>>      {"UUID": "00000000-0000-0000-0000-000000000000"}
>>>
>>> The doc comment calls this "a null UUID", which I find less than
>>> clear.  Change it to "an all-zero UUID".
>>>
>>
>> Technically it's a "nil UUID";
>> https://datatracker.ietf.org/doc/html/rfc9562#name-nil-uuid
>>
>> If you wanted to be pedantic, you could say "the nil UUID (all zeroes) is
>> returned"

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



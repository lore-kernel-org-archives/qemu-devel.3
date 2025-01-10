Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B8EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWABw-0007l4-5V; Fri, 10 Jan 2025 03:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWABu-0007kj-L3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:16:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWABq-0007bb-AF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:16:25 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so13013735e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736496980; x=1737101780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kv7FKYaMN/WUvTocOgd+87qkT+pqaT6mSOki8l9byUQ=;
 b=Tv4fULWSneHFKExxbTy4hwe7lkT1fDw8UOaGk75uJTD7NIaluTl9oY2Iplj8bDDE21
 52acNiX5V+RZ2MDUM0TgGDdIhAdRUjVnWv7h8OG9nOAcq4MPypANdAONavCqrUIfMPiY
 2P5bXxgbVp0vIDn/A+4r6NFd97js1w6urs7GV/X80plkP8Bzy6zIfenQgJgeFynUiWj0
 8CfMbELf7XIIn49K3F0MDKMq01Ditkx6q0tKuhqmVyWJw2uSPrPi3VbUzWU7JNFQnt9X
 D+W1ajsgSQUoaYYf/g+j1xdROficNg8F6rPM0HJBkJ2X4I5Ww1bkuhec+gye9wyTHoWc
 ljnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736496980; x=1737101780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kv7FKYaMN/WUvTocOgd+87qkT+pqaT6mSOki8l9byUQ=;
 b=YHk+B8l+yC10j9nobiMg4QZxY1KbyFc7O3mPjKkq2tJ0TA1xqNn8s3n63BrCrvHdI9
 NfOKLvdCMENO2QDkAyQPObtC+iWLlBuxyO9Aipvfyq3YfGuKh4EeDLBdrrmYeJCugEHd
 2zVNnXbxbuTXt8/KACN4myhOzfUckeIdUDlXTzuF6ha5/W9uyMsGtO0vFwmo4dsj+MQe
 25DQodG6jlC8Yxp0He9FESlpxU5gUSn8lvyPS2qJ8S6CvrIQ/rDwAcMhC5DzE3miEHRp
 tmrFBb6dUpNIfJYkTXQkYw+aCHGTZbWkimgrvfMaNSCxTVNyDwtZdJgflt8f7eYbPI7I
 Ydlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyydSbQh6PduVt16cCGyfjpXsoyIozDLi9fPkmIGZlPUVU9qDpCILBb16w26XT5EmAICY6o1BSZ/LH@nongnu.org
X-Gm-Message-State: AOJu0YxTjfoRWWnQQQN92LnBWkKDFxhQXHO4iEnAoNd3Pr8wZDdFnq83
 Mz1D7+m/AXIOvv94HJ/K/laCjcRHkJypWzq+YSoEsjutFIB1TEuUkkWHhYtYgyIHL76Gp/TT5NS
 C9bQ=
X-Gm-Gg: ASbGncvkEpb3iwKIaLLvJeHpcSnFSjKuwQhU+xo2yJ6uDv1c+gVyROlTutH2A5nNzBZ
 alhd7ieXYgV9PPiUczCMoM1rVME3l5qLqct9AsJkoPDBk7FIqIvVbOfAyGhD0GRBrF2PsT4r01w
 3PVTQ56xwGFkKYIDoAWbTh95+FCMTDDUdHIdnDxiXpaNGdkEEVgh2KN3Uy7Q9wZm3Zj+z1XhMSt
 UaUJdJraTb9eGYbqe6LKjpWIk/9BA/yQbRT5gBmJCpwxAg/mRtZ8QaaDwAaccyvWtA5knrqPPqT
 dsoQrW+rMmeOCmnrstOGKX+TZJs=
X-Google-Smtp-Source: AGHT+IFVGQx2dSjVmPRIlM+jesEk6scS9hu8M0GdFRKVQxW47gkq6Hxm/JvalF9ICQZy0vXxVeGaqg==
X-Received: by 2002:a05:600c:3149:b0:434:9fac:b158 with SMTP id
 5b1f17b1804b1-436e2680c4amr79831195e9.1.1736496980317; 
 Fri, 10 Jan 2025 00:16:20 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d46sm44133015e9.25.2025.01.10.00.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 00:16:19 -0800 (PST)
Message-ID: <73307130-f03e-413d-98fb-7e6c05383851@linaro.org>
Date: Fri, 10 Jan 2025 09:16:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xen: do not use '%ms' scanf specifier
To: David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Anthony PERARD <anthony@xenproject.org>, qemu-devel@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
References: <20250107093140.86180-1-roger.pau@citrix.com>
 <20250107093140.86180-3-roger.pau@citrix.com> <Z3-sJMXpiFUoATHz@l14>
 <974ab6743d168d34babd458fe5e2e7766bb280b4.camel@infradead.org>
 <Z3__eDp4hShe79Pl@macbook.local>
 <17c134258de9517b677f08a865394f8075d67bdf.camel@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <17c134258de9517b677f08a865394f8075d67bdf.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 10/1/25 09:08, David Woodhouse wrote:
> On Thu, 2025-01-09 at 17:55 +0100, Roger Pau Monné wrote:
>> On Thu, Jan 09, 2025 at 11:25:13AM +0000, David Woodhouse wrote:
>>> On Thu, 2025-01-09 at 11:59 +0100, Anthony PERARD wrote:
>>>>
>>>>>        char label[32];
>>>>>        XenDevice *xendev = NULL;
>>>>>        XenConsole *con;
>>>>> @@ -550,7 +551,10 @@ static void xen_console_device_create(XenBackendInstance *backend,
>>>>>            goto fail;
>>>>>        }
>>>>>    
>>>>> -    if (xs_node_scanf(xsh, XBT_NULL, fe, "type", errp, "%ms", &type) != 1) {
>>>>> +    node_path = g_strdup_printf("%s/type", fe);
>>>>> +    type = qemu_xen_xs_read(xsh, XBT_NULL, node_path, NULL);
>>>>> +    g_free(node_path);
>>>>
>>>> I feel like we want "xs_node_read()" which would be similair to
>>>> xs_node_vscanf() but would simply return the result of
>>>> qemu_xen_xs_read(). This would avoid the need format of the node path in
>>>> several place in the code. But it's OK like that as well.
>>>
>>> If you look at the other callers of qemu_xen_xs_read(), it looks like
>>> the majority of them create the path with snprintf and then pass it in.
>>> Or with g_strdup_printf(), pass it in, then free it afterwards.
>>>
>>> So perhaps qemu_xen_xs_read() should be a printf-style function too,
>>> with its last arg(s) being the node name.
>>
>> I just went with Anthony suggestion and introduced xs_node_read(), as
>> I didn't want to play with qemu_xen_xs_read().  Not that I think the
>> suggestion is not valid, just seemed more work than what I wanted to
>> do right now.
> 
> Makes sense. Something like this¹?
> 
> char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
>                     Error **errp, unsigned int *len,

Maybe switch len <-> errp arg order.

>                     const char *node_fmt, ...)
>      G_GNUC_PRINTF(5, 6);
> 
> There's a %ms in hw/xen/xen-block.c too, btw. Did you catch that one?
> 
> 
> ¹ https://git.infradead.org/?p=users/dwmw2/qemu.git;a=commitdiff;h=percentms;hp=bc6afa1c711da5b4f37c9685a812c77b114d84cb



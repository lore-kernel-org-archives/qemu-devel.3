Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606FEC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkyb-0000zY-5s; Mon, 24 Mar 2025 12:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkyO-0000jW-Ev
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:48:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkyM-0001fk-Q3
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:48:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso32524065e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742834901; x=1743439701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M3kLz5QA+Me9h1P4LhRBBfUBthLUgOvcuveXzpKHQfc=;
 b=kp9NF5i8LgAeGN0pe/83i3xlUYHbWYbxS3Bz0VwVSdEKkxDZrlzPFMyuuahHnSO0Sx
 0PMkL4tNK7feRpx97GT/D/6+EQX4fS0oSUiU/QdFfO5K1K6YeA9lXzHnFc7FW2qqrFqQ
 s6k+ib0ma4Bykq5xSPqZPGe4yVSLa9OyiK7zDtC7oTyaNmJkEcRXsxzbPtJ9UOCS8r94
 z7IQjehv+R2UOEVOt9zoO+GtywZbVSmPsgPdPnXdOFp0OHutdC5JdFwtcrASF2IpCnnZ
 W+lCTEN4haVYnDkpzvseGfW6fmH+bls93PoO7nPB/MKZrTksbCw7eqjO3lpUcbUPo9Az
 QYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742834901; x=1743439701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3kLz5QA+Me9h1P4LhRBBfUBthLUgOvcuveXzpKHQfc=;
 b=FpJqtbYqfOd9eyiYpxbUPUCZBvIKa0SX3APKvkqxI4ixXgFpYpj3DU0QMjeLrWIpud
 LyyL5FUXvBt50hj5p3swjKWirsHjl1sxeEODuJYiApQXxEffKugC2u6pcoPdoNNnjGlX
 La9iwCAmF7IyGsB3zDFDTYnkRABvK7VLDHWmWPfAq7CcxRvSEuprtYPxL2fSQjDwpvTo
 dPCE5xEpFS1xD45GkwjWD8dis763ezVlZn9yLzUGP3Xg+mHgLBIr/s/Pryzj/IqHm0cz
 MIjUKflIZ0dwWmqfmtbjjEg0HXm29yIrGPKarrjMQJ//HnuyRFZhcO1ceIB/sWZWyjKg
 XNIQ==
X-Gm-Message-State: AOJu0YwtqSSMQand7no1wIGRXKw1d4yNzv8srjmdc6nVKVok84ava9mZ
 l8KA5tiTWa2ORMpBed4tQbOzsttfagIJkOP0oUs/Xrqmi+X9FzI0q9UPt/P2rco=
X-Gm-Gg: ASbGncswvm2Ki4irpaIop7wvBNynAn6Nw5SIxFUFwQ9EdeQXefuOmoVIcVmhqiXUNB3
 oXL2qGvtONBO/BE7NImx+7/XLmJ366XJu69yOeh4+YXybzJ0kz4fAtPIN9KAkTCcQ/EinHjFLwl
 sMUmnVgXvM+Kt00/TasE+QDRj2JfUF6dIZHR1nt4LheWq0b2gI0BsObLdDiDnRVQUal/rgmQYCv
 HBazlGn6LBCc42zlE9PXZRR6GivwidfPtyvBsXr9D/NGlc8FQboeayUdL6YYtkGuLRWBP+rIXgN
 N6CWkc7hO2ITs8zMrO7HDxZ7PQ6VXEm8vMQvwRjkRoPlfpnoFGnk9IbqNlePBVnFaThHFZQYJqV
 FGxHFAUajkUHWRUdjVw==
X-Google-Smtp-Source: AGHT+IFZuJd5u122scc68qWPXakzu7Kb45j9PxCgln7UGrvXlgNtI50Ez6l5xSieSmCGzDPTrs+tfA==
X-Received: by 2002:a05:6000:1acb:b0:391:4095:49b7 with SMTP id
 ffacd0b85a97d-3997f91d52amr13988660f8f.25.1742834900899; 
 Mon, 24 Mar 2025 09:48:20 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f995789sm11587165f8f.17.2025.03.24.09.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 09:48:20 -0700 (PDT)
Message-ID: <d66fd0b7-38d8-439f-b550-095b131098a5@linaro.org>
Date: Mon, 24 Mar 2025 17:48:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/vl: Tidy up break in QEMU_OPTION_machine case
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250323230006.36057-1-philmd@linaro.org>
 <Z-EhXQExJlSof5rT@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z-EhXQExJlSof5rT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 24/3/25 10:09, Daniel P. Berrangé wrote:
> On Mon, Mar 24, 2025 at 12:00:06AM +0100, Philippe Mathieu-Daudé wrote:
>> The break in the QEMU_OPTION_machine case is mis-placed.
> 
> I think that's largely a bikeshed colouring question. If you
> look at other places in the outer switch using a block in
> the case, eg
> 
>     case FOO:
>        {
>           .....
>        }
> 
> or
> 
>     case FOO: {
>           .....
>     }
> 
> they'll also have 'break' inside the '{}', so either this patch
> should change all, or change none.

OK, none then! Thanks :)

> 
>>
>> Not a big deal, since producing the same outcome, but
>> suspicious, so put it in the correct place.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/vl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)




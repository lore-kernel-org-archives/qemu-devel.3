Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBECDC9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJBX-00019v-8m; Mon, 12 Jan 2026 09:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfJBK-0000yw-5w
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfJBI-00006X-KH
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768229168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MA+BgEBmIIGGSnma+OrhFMOnmvIFLgbsTwHwEQKiBps=;
 b=fYMie7LDd81EtHVw1gjHwg2O8pSIUuuJ5HKlQ9Kh4S38rnS/ILwuW4TgG8uUzODKqKFstM
 MWCkYbSGYWlw0SaPw/+xVKPEdSo96XQWZb3PZVpE9v7u5GgzSjvzjRnFhe5WRW7rX8GFGQ
 EtKgfSK3e92kBceNgMHzlxyBKO4LpWQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-mwO_mq8PPS6692cbUQVObQ-1; Mon, 12 Jan 2026 09:46:06 -0500
X-MC-Unique: mwO_mq8PPS6692cbUQVObQ-1
X-Mimecast-MFC-AGG-ID: mwO_mq8PPS6692cbUQVObQ_1768229165
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fcb6b2ebso4049665f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768229165; x=1768833965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MA+BgEBmIIGGSnma+OrhFMOnmvIFLgbsTwHwEQKiBps=;
 b=LVgjOonbTAQvL4e/9bAiGn+S7mJ9b2UkeTXqLSMJajp5wiJNdrfTfHfbqVf+2vXLAf
 QjjgQ5dAw1U2nbnnz3Sv9Jhixo1diMSBebdi292GepJ0mYmfDPPTmJ0nFOUnewo3agu8
 7D/t5pcwpmWP8DzW029wCx9JuoUH4uhFzQ1+31/cWLKlxSXMj4EtEgTFoXZUBmbfKPRJ
 obznNIdz6ANyN8gGCKPgy4UMfBbKFa31XJnDUFUmgLBHfrcAIJUM/n3g22VnZk2+Zpgn
 yoGlDPAhs/vc6Xy6GPeQOKVdmj4EzhkP9KxiITsSwHnCuDWYD24SD1PJ4beJCj4ElNLi
 OpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229165; x=1768833965;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MA+BgEBmIIGGSnma+OrhFMOnmvIFLgbsTwHwEQKiBps=;
 b=TA3I6VNdJ+tkdM0C85nC1nS9Lthnyen0FL35U6IBmPb2hyUA5hnJ+HepL3+xELkoKg
 LvHYXhPYZ+JFR8zgsmJd0y9O+14zhbgz/jyRIvUfw06JQ4dQGP7t08fJbZSLHrlbuWd3
 pBtmSQunmgsKd/8Ua9MUZddD1E9Fhnib2mRhM0ZTDtMYAnjwm7ZqNtwwSN0K2UFtynFe
 2CcCRlGaeXT2sCY46zdrVSLT/mTTeB69IWgFRCSnkZf6Fve2GVvC+BETSjXI8Bc8H1Yi
 D5mht0ffxlxXYzhq7BA04ZeMd5fqr6TqsCeQsjJWFnPwnjbPhfp/SwZY2nzt5VkmrcNq
 xBLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdh4FegPnqoOwFWKNL4g8a97PhmdRXrtAGiM+OUY2o2YQDeQlpjCQHev0fPKIRjPEZk8ESBOnVvpWX@nongnu.org
X-Gm-Message-State: AOJu0YzSZViR2Y6B4Qj4cuAkn8MjuK91p8vgEThUuuBGHza7KnAHBh+i
 rGz56HnQJW39X3DDDDMI5C+B6YWO0x5JIcJdRjDdJyJshwtQa8+jF3Ges19mPxK+aP54R+d1hx2
 vxg9/st95By0TqdxhBRGZXaQ9GasCRCOkX9EK3pS7m3/owwprcfWmNao8
X-Gm-Gg: AY/fxX5kdUMpxtev9CvKmC2g+FiKXosEL4Je6uZZI3zBgBdoOFf3RG0S1tWCB5EeUVh
 p1SRaVpRHbiW1OxgWvcWOgw1dLxapl5mmkQVEXczjzidRBDMqPsSPoQMFOQHw8M2LGvKFoQYltH
 beQHZvT00ziNE543t22nnzb1L8XuNDkwtqlkWNYSJk6BNSQ+2zVCHblV7J6IEd76aRzcdCa9YtP
 rrBk52SHYaBetABWhpX1xR4PtbnlUn1cz5FJZvj07Ez07j1cTuJbgdJLIczYY2XNguY/OzF3Q4A
 UyD1jEqFadQLd8sEl4tN778jBDY1EbRFq8M9i4fAms0NDvX3wrgczbjW5PaAbgNuWZm1wU9sh1y
 rS36ZpVQ=
X-Received: by 2002:adf:cd81:0:b0:432:c37c:d831 with SMTP id
 ffacd0b85a97d-432c37cd9c7mr17723437f8f.1.1768229165237; 
 Mon, 12 Jan 2026 06:46:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETtwWPdB6SYdWkCs91YzHGlOfB1HB0bI4EufEQyKvBVlZKo+0WYrjkOyZqG28PEXe++hesvg==
X-Received: by 2002:adf:cd81:0:b0:432:c37c:d831 with SMTP id
 ffacd0b85a97d-432c37cd9c7mr17723406f8f.1.1768229164786; 
 Mon, 12 Jan 2026 06:46:04 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9afsm41371475f8f.24.2026.01.12.06.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 06:46:04 -0800 (PST)
Message-ID: <b0e2720f-806e-4f3b-8e35-de33e96eebd6@redhat.com>
Date: Mon, 12 Jan 2026 15:46:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Re-enable the MAX78000FTHR machine in
 qemu-system-arm/aarch64
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jackson Donaldson <jcksn@duck.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20251218214306.63667-1-philmd@linaro.org>
 <CAFEAcA-vKfpDQJws5m7C1H_N2taPmGXE=gH8hRFxHH7L3u+w=w@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-vKfpDQJws5m7C1H_N2taPmGXE=gH8hRFxHH7L3u+w=w@mail.gmail.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/01/2026 15.42, Peter Maydell wrote:
> On Thu, 18 Dec 2025 at 21:43, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Unfortunately while rebasing the series registering the
>> ARM/Aarch64 machine interfaces and getting it merged as
>> commit 38c5ab40031 ("hw/arm: Filter machine types for
>> qemu-system-arm/aarch64 binaries") we missed the recent
>> addition of the MAX78000FTHR machine in commit 51eb283dd0e.
>> Correct that.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Tested-by: Thomas Huth <thuth@redhat.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3248
>> Fixes: 38c5ab40031 ("hw/arm: Filter machine types for single binary")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/max78000fthr.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Applied to target-arm.next, thanks.
> 
> Should we cc stable? (My feeling is 'yes'.)

The bug went into 10.2, so I'd say "yes".

  Thomas



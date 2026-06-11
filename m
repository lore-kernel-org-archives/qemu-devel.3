Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F1ECD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXkSp-0003k3-4y; Thu, 11 Jun 2026 14:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wXkSm-0003jg-Fe
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wXkSl-0002sh-1H
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781203748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tgwf+mpwEnrSFTrxZ7HbnVYhySd6W7lXhagpSCyASwo=;
 b=M6/S1+5FUu7E21TzHgAJ6By5B063WB+4m+oYLxKmSrD1nd7TNdeUILkyFMz8YLTpYMVveD
 Y9yrDRF7QQenTV/ESQoLri3S5qdKUTc6aFyPxzVmKv1pLAytsTUTUL0kils7P2Jxy7sX4/
 aBP8u0lTY0cTYUba4UNestIOeHbiByk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-mRQ9WGPRNkyUD_tTWKBhQg-1; Thu, 11 Jun 2026 14:49:07 -0400
X-MC-Unique: mRQ9WGPRNkyUD_tTWKBhQg-1
X-Mimecast-MFC-AGG-ID: mRQ9WGPRNkyUD_tTWKBhQg_1781203746
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef66cc579so58894f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781203746; x=1781808546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tgwf+mpwEnrSFTrxZ7HbnVYhySd6W7lXhagpSCyASwo=;
 b=qehnw0hYOU/qoHwWGh1Cx6z7JgpGxm/kS0WUtQObG6C68i19AyL44Ad8lojp+0vBXI
 bE3eLhn29WLD1uVYS1jJUar76mqmoiQzCfotQteeO+gHNLUHej8dHXONYKuKdjcDrdXS
 jcEbrjJYxrIHNhq7JUauqShdUCtLcvj3kn4tLqUs98hW8Zm99QIKQXZ/3NvS+7iwuW/O
 oWcsDAT8CG0yDySHvhK0CrkZqy15kXLCjHt34flQPemZrVMdogVmi5WpKjguH3if3sdp
 +rnDUDwKmaxp2MQf3qMnws9rfRiRH+c2W28UDz2KBIiYu2WaBzEuKPpQsQOtmwHpre/s
 Ljdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781203746; x=1781808546;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgwf+mpwEnrSFTrxZ7HbnVYhySd6W7lXhagpSCyASwo=;
 b=P/2+i9tat1hdVRz7rP5s7Cfnf09MKNiYjVgfOdXkGSQmnvVejTr++rjBMsKUIcPACN
 /JjiMl9DqNQ6cVc5ZGH1ZlriSD9/dbrYKcb3+cmj6oyWE02sKoCx4yBj3CaufknhV5eJ
 BW/hfVgHRZXTWugmyDJvIEROHsYqdhIgHdPr81h90xGm8YNILP5dafiyVvM+hWV8SDqj
 Dl2V2UxyRY0T6JSmv/CNAJ3ryDPU9JDLPRyqPcRNruvuqoytEkERY0oOka/2u3v3tX2P
 eUB6c8eItHpWef3B2sy2j7LCLxJiZPyHgnqO84XZ31UCOPLmgVZkKJx+0l8Cv5vF/s9Y
 vLAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ87zZZt86LQVQtDzR+QEuIP19vP4gXZo0FLlwOBMECI1+bsDZTjVdAziDObQ/yaZKwQ2iS7K5FowlsI@nongnu.org
X-Gm-Message-State: AOJu0YxV+/FNQmn/CIjzXgjO5BrvYgXnxNYsK0d92A47oKnrN85M+Knp
 NjjyTGfkkGeWZDJ5gnD5bKwY8jxRRHd+PZ3JlvjNxvVLionVX5i8+3AQsh1kZWq/qk11EkqA+2q
 GMHfgZ5V7lTyVlQcLY/utONH+xrEjtoIvxQRsZTShs6TElTiAdHp8ZEic
X-Gm-Gg: Acq92OGfa0P/QD6Bc8md3y5ei9HFA3BisfZ63NFKr1Q8GNal2CZbhIwHjcwKcQCPHTX
 ps/ZgtjurdoNnujppe/byy8yu938xDjcHTGyEjhj4+FZmnESxG9bBhJKEuLecbBGWS3nG0wfR1W
 A/nVQyDYaamRhIfcG44D05iq/AOpb4LWu1dFdtzXEGzQCCqXAvYaYcekZ/ze/SfgzZ5EGmfXo21
 qAg9QhYN13hAHJIUMv7Ejqxb+IpzaAuXAEgm16KGVELXWSaiWfhV8zugppXM/Un2wgOM7B/hLPB
 swdWpQfMrUYmXpYBuOLzC4WahCOQmDUVuqIYgJy3l3lCEysbTbk2joCfgDPXbLdEJND5kEQrYIS
 PyV8LrcV748U0lSB6Plw=
X-Received: by 2002:a05:6000:240f:b0:45e:da57:be33 with SMTP id
 ffacd0b85a97d-460677a646emr6208336f8f.23.1781203746197; 
 Thu, 11 Jun 2026 11:49:06 -0700 (PDT)
X-Received: by 2002:a05:6000:240f:b0:45e:da57:be33 with SMTP id
 ffacd0b85a97d-460677a646emr6208309f8f.23.1781203745840; 
 Thu, 11 Jun 2026 11:49:05 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c0c2239sm1017669f8f.7.2026.06.11.11.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 11:49:04 -0700 (PDT)
Message-ID: <544ac437-5dfd-4cf0-8332-16cf8bd56260@redhat.com>
Date: Thu, 11 Jun 2026 20:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: allow pylint to introspect cv2
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260611162536.2184620-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260611162536.2184620-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/06/2026 18.25, Alex Bennée wrote:
> To fix:
> 
>    qemu-test.test_pylint "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83: I1101: Module 'cv2' has no 'imread' member, but source is unavailable. Consider adding this module to extension-pkg-allow-list if you want to perform analysis based on run-time introspection of living objects. (c-extension-no-member)"

Which pylint version are you using? I don't get this with my pylint here 
(version 4.0.4)...

  Thomas


> Manually running python3 showed I could indeed import cv2 and call
> those functions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/pylintrc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
> index 049c3e76f12..c4c5237aa9d 100644
> --- a/tests/functional/pylintrc
> +++ b/tests/functional/pylintrc
> @@ -82,3 +82,5 @@ disable=bad-inline-option,
>   
>   # Minimum lines number of a similarity.
>   min-similarity-lines=20
> +
> +extension-pkg-allow-list = cv2



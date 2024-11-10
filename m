Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E247D12D43
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 15:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAA3r-0004Qi-SH; Sun, 10 Nov 2024 10:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAA3q-0004QS-Ap
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:41:10 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAA3o-0005Ld-O4
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:41:10 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso603866466b.1
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 07:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731253267; x=1731858067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1S5xAyQc1S8upCAYCNAQa1+4EBVyDOUdqP3WVWWG9OM=;
 b=jK0SqHTechgqq1/pSvenmyMbeVGMcrOhhy0WRpbJdP/cSGTBGoW0sZWK/4TOGrZOGZ
 C848FCO2OoKqK4L/+gtAB4Ln470+gwV8iBHwJzwmU52Km8TTgteWDPHqyXdk+LAvCMFU
 7IxQlVeMAvV4PBl9T06I8ROspgWDS27T8RvIz7J+ogRUKDVXsjIg7libquA/q9npN7+3
 Z8+YufttuA9rga2eNSiczYERMOo74IY7N6VTo5zcFxfp2emsySdlHdOyjNKnRXecSJPz
 LZC8LQSlxmUHD11vV1+EGVFE6AOYFmoT70/ZIxlqzLBiQKn3e1ZsvfX29bnOnvmkinwM
 6bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731253267; x=1731858067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1S5xAyQc1S8upCAYCNAQa1+4EBVyDOUdqP3WVWWG9OM=;
 b=TRhfbk0IkeWyO9NtROxxGiyaiqXh0Y760Us/NhIj4Mh1b7epDxW4USAr7xPlkGPh67
 m2PurB9p1c6e6VpP0se7diQTHCKDzNsAyCIqIjfo9WCHPcHWkQspXc9CKIV6sGuDKYX2
 JTw4z60PJdGmNMvwW7uAw1Q5PKGW38LSsoFI04Gvpnup9Lm6XulNleDjIw6fxt1aLYmW
 gSyKD6J2KIC3zWV3VWVhD2u+f7VvKjUh0SmhDIXGajTYuq+nIX4wT5dXFx8bTEP3m3z/
 Y2UTaTs0CCp+ZGcWROkXVzox8hz4Y93ZtQO7wdV3oR9AFEWZoGBDdGryfagIyb7Mbtio
 8kFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0dbggFdqu4CQn7jAUQ2+589GW20BoIZzr/dpB1GSKNywj9xwLMgNWmu8ulnXhyCZxCoR8eMrBZ4Uj@nongnu.org
X-Gm-Message-State: AOJu0YySyD6VL6TrX4G63LIeGXApYUlI4BKBNbNiigzpStLGaV2GS5SR
 Z6WbDs0uMzmyHlwn+5gppVq3QbW6Mk3cGsYY6YjshqR8AgfgyihfI+tCd1iwb7xn3/j9FNSMYhN
 IjSI=
X-Google-Smtp-Source: AGHT+IGFN0mETRGoS/1Hdqry2Wapz0Jz/N3bYQKm2ixEziI8FHBQPfLm9eA9uh3jalS8N/gT8hVxDw==
X-Received: by 2002:a17:907:80e:b0:a9e:b5d0:e5c with SMTP id
 a640c23a62f3a-a9ef003347amr845561866b.61.1731253267297; 
 Sun, 10 Nov 2024 07:41:07 -0800 (PST)
Received: from [192.168.69.126] (cnf78-h01-176-184-27-70.dsl.sta.abo.bbox.fr.
 [176.184.27.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a19267sm484321066b.33.2024.11.10.07.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 07:41:06 -0800 (PST)
Message-ID: <688233c4-2ea3-4f60-9bc0-13fa0812b62d@linaro.org>
Date: Sun, 10 Nov 2024 16:41:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] usb/msd: Add status to usb_msd_packet_complete()
 function
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20241110034000.379463-1-npiggin@gmail.com>
 <20241110034000.379463-2-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241110034000.379463-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 10/11/24 03:39, Nicholas Piggin wrote:
> This is a convenience change that accepts a status when completing a
> packet.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/usb/dev-storage.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



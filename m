Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9D3D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3s9-0002E7-Gz; Sun, 11 Jan 2026 17:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3s6-00027c-RV
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:25:18 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3s3-0001cF-Sk
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:25:17 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-34c1d98ba11so4594971a91.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768170313; x=1768775113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+CCFLvfHluJFdfCNdY2F37e7Xb8TpmPuEJpC0XV0SKE=;
 b=tJ9WEbbdSRzod7E76sXBg9bT21LjDwUgN5rVpegr508ZuGac7ZBuP5QNSVB2L7Tnkq
 rVklVGzC4BD18/s9Haj37nHesTPYFry5rO4CVuwFN7RP2PVFiaQFjJ5mqMohWV6OeoJF
 bWsG6SuJLf/LpG0PD3IoMu58qPN8dfqKTeKKmU83NNFyH8u3eeZseMGXE2XlRL1xIPSH
 iBs7R4U/fS53YygCVda3Jfwlig1EkW3iLz1Zf2a0NfqAV/qNnVtFzmIgdslAlRz9oAXS
 gYRlBKQn43Azz4i4ukzNe9n+X2ZmSbACQqnFw3crfAlvmRtTpBrpP2q+GpqDVKHsqI/t
 w8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768170313; x=1768775113;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+CCFLvfHluJFdfCNdY2F37e7Xb8TpmPuEJpC0XV0SKE=;
 b=r3m9sxdSWUvyYqwJe3zS+mcPqKEKdN+pOj0S7ZnoTcRrlHZURMx2egmrbIZLrJU6WD
 ShFU9jolbVtjszcjJuNSUWjsdt3OMJFMHB46mPN131YL4DP8f8UL8avPGFjmUlcILoYZ
 tj47XOT8y+lS8b6nNlAz8u7go+qyO+9MIKZSiyXWMJmM3kJ6Op3tAxB0hcouyEg5bek6
 Yoj1bPpfZzErkiOor4MY4lnXcVkEPqTdlR1eQwCJ/HiegUhWYi5tr9ubW+7uA1UArvTH
 GgDrTMSr8wkfSOyNzLD0KmlE4n+L0MHGF3dzJzpryMGAInYCfsdovWgnZcP/5INM8pXE
 PCqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5B6Y8ZNSDoH8AMz3uVh0zogX8eNhhvZtH4lSp4NIKOBJ9nXc1/0BzCljaG7wTkwvoo3MT/u0d7wWx@nongnu.org
X-Gm-Message-State: AOJu0YzDk0bVmbmdI1rWgq4rGWLfEvoQYrCFJyfNMZPvGM4SFtW8QDVV
 UMscwVya3aq8m9NPU6gpEajPm2KetpdH6k5i4Y+p9eeoFBvam47F0DmU2B5iI62V1cc=
X-Gm-Gg: AY/fxX4iDYyxx00wDTsg4OTfppOd2vj37CSW2lrif+0vFXhaGBvBtea5VovZ5pz3fDR
 D1TP/BTRzj+ubMq7RUyYqS3xwC6L4GvRWY0OrLhIyB/thurI5YRYzq57ZMaaZqvuO7I40R9JBB2
 K6oyKHP0ndGkJpnaVV6fwuM4HTIjkbG04j0zHNENbwadBQyBzA+SoNhohZbxQdt0XSrVTpwElHu
 tWd4lKDwK6Iq2HpmLVbJTAzd0rY0EO8qMxlmxl6H4jcEPum+WvNsnHOxD8F2oX3hc8sJapZKcWG
 zUXxONCKn8UdMmJZ21YLM/303CPck33Qj6oGFSDWXPsPivIILvvZPlRqWVV1CKzdF56rN7Cp2or
 FopIB31MaQNWhLRd9DAIXLYHa6p3eguChJe7RngEWIGo94hNkCmc1FZqZp7ryJYVGroluQyxmmM
 3apmJXd/I6fEn1tRcH42WcLusHLJj1BYjIdtsQ
X-Google-Smtp-Source: AGHT+IHyQaB2TR8KUea3SwwlIMzHSwtllB9aJOT/IlmVcHuuN2dZk3FyzfHO6W+DjewnRiM05QQM9g==
X-Received: by 2002:a17:903:1a6b:b0:24b:24dc:91a7 with SMTP id
 d9443c01a7336-2a3ee4b22d5mr142288635ad.45.1768170313100; 
 Sun, 11 Jan 2026 14:25:13 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c5ce06sm153925935ad.44.2026.01.11.14.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 14:25:12 -0800 (PST)
Message-ID: <6b6eca04-376b-4601-8049-0f4f4282215e@linaro.org>
Date: Mon, 12 Jan 2026 09:25:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/24] util: don't skip error prefixes when QMP is
 active
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-17-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108170338.2693853-17-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 1/9/26 04:03, Daniel P. Berrangé wrote:
> The vreport() function will print to HMP if available, otherwise
> to stderr. In the event that vreport() is called during execution
> of a QMP command, it will print to stderr, but mistakenly omit the
> message prefixes (timestamp, guest name, program name).
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   util/error-report.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


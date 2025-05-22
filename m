Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62492C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 06:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHz66-00053L-2V; Thu, 22 May 2025 02:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHz64-00052q-SN
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:08:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHz63-00061s-1e
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:08:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22e16234307so67277915ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 23:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747894082; x=1748498882;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1/zbCeClAfxLgAhFNJwlJvnFHsn5ox5S+Nz8tMBzj9U=;
 b=ZkePzB3A8PiflMTHHTv8tgREAPsl16Knt03mbI70j6C5htRAIQAFMKXafNNSNoXl6C
 auh4U+DMlGDm4wtXrBisweK5MBvoBTVmbhPJl8iiUhJdC6LJV1RrrFEKsm87pAbh8iY7
 HVS6zm5xAIoz5kFxUQefSG9XqELbZ9RtSOzqsKjWfnDgDrxY2hPdaZkC3HpbnNXINFp/
 i9iwesmQ8CmL0FEKLFFqifLuQjPml8uoX0O0Uu1v5xExUnnN8m+GofqbidRKQ0G5uwI8
 8fdJnPmoS5+hS6vUHhVEGPiukXoBTzXMGEiX8z4ttJBXV0r5/tpU244YxVm6aHY8tTKH
 2DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747894082; x=1748498882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1/zbCeClAfxLgAhFNJwlJvnFHsn5ox5S+Nz8tMBzj9U=;
 b=abEzSJewBreg4EvAEqxNvgJSnxLl8h57qS10pYArEHnZij8pAjD78I6e8xuFPmiAGA
 VoOQrBaNYydC/ZB/mt6upVb4r/g6ibI3Jsoen0eIEAJlSoG1bmyNZQY32N0/NzTRbIQL
 FgynTVgWANN15NR4SFUB1ofIHvaqQAOpynIV3Yi2TI8JUNAoXoMO02813HcBMW9Wnxnq
 pthaNm7G+vgZmqEoNNjzYvWHFzKK3KuOAH444syqsqZrTMMiyIe7Nps2y25q102apQjq
 gF2c+cPJO4tCvCBJKQYaVSJpiX3bpl8/BWeBzcXOocXDnxE/ElJRYBsFZVxWvo5uj86V
 JkWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX28g9sKMBnzNoCwONaN1XX1IcdEydvSIG9ltUCUPzQMdJaDRSFmC71nmuX55FRBiipW0HQxdNsFj3M@nongnu.org
X-Gm-Message-State: AOJu0YxKn8laugst5FHQ6EpFYqwZcE4ogwQt3AJc6rd73r96zw85E3vz
 rLz9TeF0T3n33iSBAtc83bjFbl0EijEuueq0MjH16cyd5jngavAndk0yvNpNxl/4J7o=
X-Gm-Gg: ASbGncv3ta8qwYysiDBkff9cN1AhRXmsHPoQtHRTKmbHL2RKPYnyDNkoH67aYc20pFf
 x66T5BD8C06NVV9aJQdNVC+EB4/PDHv9VMG5HDAJsf2RPfedYoh7GXpkUcr4hDm5UPU0KrJ2tLN
 3quujHiohxsyvfL1oBDCezchw8NXxk2a6qy+IwZ8BlHRUBo2aVPrWouUttOgkzN85oL7LLz+lkD
 CToJEaAAFQctzy3z18qMrblO6LnGM8XltFCu7pP8vtLIvER2XSVQXlvnnantPxHZIX6aDfLJMfU
 o9DUmJXl1VIQJqEiVu0eWTmZB+NnH2ed79bN/yVDGOf+nHQ1LSDMCkqI7NoNKA==
X-Google-Smtp-Source: AGHT+IE3FVxFNCag2LpCvus0IyKip1VOr6LBz2pMT21bNPBHqu/FOw9nn4kFDMvwf+D00GnTfU35MA==
X-Received: by 2002:a17:903:41d2:b0:232:108b:7bf4 with SMTP id
 d9443c01a7336-232108b7d59mr222539455ad.6.1747894081621; 
 Wed, 21 May 2025 23:08:01 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ed571esm102120095ad.248.2025.05.21.23.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 23:08:01 -0700 (PDT)
Message-ID: <e6af12bd-1c36-4e50-8bae-d8d80cad13a0@daynix.com>
Date: Thu, 22 May 2025 15:07:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/20] include/exec: fix assert in size_memop
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-17-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250521164250.135776-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/22 1:42, Alex Bennée wrote:
> We can handle larger sized memops now, expand the range of the assert.
> 
> Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> v2
>    - instead of 128 use 1 << MO_SIZE for future proofing
> v3
>    - fix comment, 1 << MO_SIZE goes to 1024
> ---
>   include/exec/memop.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index 407a47d82c..e934bde809 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
>   static inline MemOp size_memop(unsigned size)
>   {
>   #ifdef CONFIG_DEBUG_TCG
> -    /* Power of 2 up to 8.  */
> -    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
> +    /* Power of 2 up to 1024 */
> +    assert((size & (size - 1)) == 0 && size >= 1 && size <= (1 << MO_SIZE));

You missed the following thread:
https://lore.kernel.org/qemu-devel/eec76ce0-c3ca-48ed-befe-e0930d4a39d9@linaro.org/

I think you need to check the replies to the previous versions of this 
series. There are several comments not addressed.

>   #endif
>       return (MemOp)ctz32(size);
>   }



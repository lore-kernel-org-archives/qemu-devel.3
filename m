Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB310D25028
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vejO8-0001DD-OE; Sat, 10 Jan 2026 19:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vejO7-0001CQ-2a
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:32:59 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vejO5-0003VH-MG
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:32:58 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29f30233d8aso36534505ad.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768091576; x=1768696376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oD4BcbZk8IYKp0SVu2wSUJp0m+wO0lpUKsdj9dq4SRk=;
 b=woOXzPFVor8fw9tcPoicqAydZIm9Wo6m/EU9e/5odYj0nYH8R/pcLlw8nzL7FJtTY4
 k6ugl5AmYzUQ2AuWUY1Q6ISYfuxv9N/uNbJ29NciiZccCLkL+s2YcgIgd774npqMWSko
 Hgc0tN9Y06xLTDXq5K9LolMV4nYK5G8mVuyUSlze7tWawRknpImnMmOOfgHMFFyWqkSl
 D2CPhiAEFtWvs+PSVbtpS+8oo7Tr8aGJqp6kZb29J7asnx9FASco4UL7b9Ktsg/yqsSm
 nLPtrFmTHGUFgBeYpJYzU7bA+kYJuYwwtBlmaMFB5iQO9jtjSQR4TcfPzp2Q6iTMQg1v
 Gj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768091576; x=1768696376;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oD4BcbZk8IYKp0SVu2wSUJp0m+wO0lpUKsdj9dq4SRk=;
 b=iaNbtG9I3IVW9+EcZOBDDiQwTtEOyXAhIrTD8Frvhkt6dFFFwxR59hqJebppAzlG5Y
 gGlqWeC2y9SFqNPUOZQiJaqwTXIzLAPXJEdTAEOoYp5+vYQ48q46olOXQeZIjlyrdQcV
 k9gVSdHXe7xQPvOao5bvQpygX29AyfwKx4N4l7R/k94derGLQjWb+OQPGd4jazIO0z73
 lxVYzhRxkYPrs7vkOYSNesj1JrWNk78nE/JihVcq0kr5eNTOcaSzCTRrVA9Rp6nB3ltL
 d2bSbX24FYLMYgXE8oDNEP3cFXrmdykcIRqxlel1TWPE6lVEQ6/Wqhpd/FHwp8WzNWLl
 QMPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVudQyALAhtykuLFHNnnxD5x/aob0j4b5tw9YYA+QWyfx3pSfOu7uLbeivTnOZkkt4s8mBDDj9Zuypu@nongnu.org
X-Gm-Message-State: AOJu0YwDJ16VvVzGm3cxe/QI5QjgPf5pyF0DeH2KZFE4ucTscHFFtgdN
 vzdYxxTt0HAxnXppS+fwiBcDM8atzG3DN/NGpv4Iy37bfZv8Erypt+suK3vzBTseHhQ=
X-Gm-Gg: AY/fxX7/ahRmNlfxCC5WsYFKI99uMnARsapvNDY1I7owScFwh7Rp4P0hcNMQDaJdjVW
 LbuOzjQwAe/9NGCHhI4TnzQUeuH4ISG2c3bd0tEiBZaiDx8S29MenjqpU51urfCk4lV1KvrDKt/
 MiAL4bKwaZBQfJ2IbQFFNFPE/fHcpFO2e9GXbprm2Z5+xQDyQcPzsJhFAtLuNc+4ZEr+YONDdTF
 fJ/WdIJm43hcL3JVeOV2N9By7W0Pq/GHOI/xQs+UMztjI5lCHNDn/gLftjkkP+MG0QHzvADL+av
 wm4ExrwvPR2J/jYqIkmODBdVPBXauI9G15DpWBPRUiKXxarlKI3vZf0TP1gFazDk5S5tGYUaLn8
 vjJx3SKHmMKxg1FdOTiOqDllNpLTmhye/2UXpkUuZOiBuDg7svcGu72RtHsMAeFc4kBLIDxwk6c
 N1l0f5eb4DB7wdGbpQaiWBq8w0LA==
X-Google-Smtp-Source: AGHT+IHADXwFT7leGz/jNpMF/FcN3e03cwP4d7bmLfxbGWoqPmvNTPKFTn/nbiU136YMURI7iMzHQg==
X-Received: by 2002:a17:90b:2ec3:b0:34f:62e7:4cec with SMTP id
 98e67ed59e1d1-34f68b4c743mr11508264a91.5.1768091576169; 
 Sat, 10 Jan 2026 16:32:56 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28fa85sm13642942a12.5.2026.01.10.16.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:32:55 -0800 (PST)
Message-ID: <f20f1db8-5dfb-4a0f-9192-4053cf9a85b6@linaro.org>
Date: Sun, 11 Jan 2026 11:32:47 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] system/memory: Extract 'qemu/ldst_unaligned.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, BALATON Zoltan
 <balaton@eik.bme.hu>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org
References: <20260109063504.71576-1-philmd@linaro.org>
 <20260109063504.71576-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109063504.71576-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/9/26 17:35, Philippe Mathieu-Daudé wrote:
> Unaligned memcpy API is buried within 'qemu/bswap.h',
> supposed to be related to endianness swapping. Extract
> to a new header to clarify.
> 
> Suggested-by: Paolo Bonzini<pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                   |  1 +
>   include/qemu/bswap.h          | 62 +-------------------------------
>   include/qemu/ldst_unaligned.h | 67 +++++++++++++++++++++++++++++++++++
>   accel/tcg/translator.c        |  1 +
>   hw/display/ati_2d.c           |  1 +
>   hw/display/sm501.c            |  2 +-
>   hw/remote/vfio-user-obj.c     |  1 +
>   hw/vmapple/virtio-blk.c       |  1 +
>   net/checksum.c                |  1 +
>   ui/vnc-enc-tight.c            |  1 +
>   util/bufferiszero.c           |  2 +-
>   11 files changed, 77 insertions(+), 63 deletions(-)
>   create mode 100644 include/qemu/ldst_unaligned.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


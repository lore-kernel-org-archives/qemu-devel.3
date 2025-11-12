Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF65CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBFM-0008Py-Ix; Wed, 12 Nov 2025 08:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB9D-0004qh-Qq
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:44:32 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJB9C-0001XO-Bg
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:44:31 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47755a7652eso6136405e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762955068; x=1763559868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w2pYehjot5a+vJndL1qg4zCnwAxwJw8EchglYUXgf5s=;
 b=welrszPnm0pfg0UOWaLwO8rjqL2JDd44uIAj77Q/sK5/lUPGPWIyHS5BNAs+1SnZOJ
 9D+yXxa3q3qy+KGlqMYKtGxKMhEc9h6un3v8XXsJTkF73u8EoPd9OMF+BILoi1LcT9Tv
 SZisj0jLyWYJCDHQWr/n+QrsFCudVe0MrYP59ILqO2S2cY9NvKLJQws4iaMkJ6zVJKx3
 Po5xUw+gQqOcvh21YougjkoUZndRB3E1ti0NrawNw2BmutKqzPKqwNyaXGn4+sCu6Hq2
 a+x6bozQ3y2svfGF82yeIw1RgZbfHcu1L0S5KknXFiUpNqr04SnA4VvhWm/Vw/bko71L
 1u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762955068; x=1763559868;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w2pYehjot5a+vJndL1qg4zCnwAxwJw8EchglYUXgf5s=;
 b=nxzmQgUKi6FAchvbaaKRlISCV6BvgAw9iC3+QFCuw6z2w3ahWSp3aDy6y93XfLO3jw
 QbLtYEqM1YFnDvO+vV9fZYwbSTMejHt7OebwIY13EcOZ8tUHxhXeKT82vBXfsi36mzoh
 DIBe5QPrE3cKAYAQZFCFcgli+crdZFsyfhRCRcplYfimkDBSr8dCkIpYp/2iSaYVBxI1
 sgVgsuuWWQ/03rpAtNMxveFw9mjceB+RVkDg5wZx7d8hz2lnvMSQTWDfK4CvhKoCEhaD
 uPkHoSWk8tZgszbjpKaUWaaN6ETQxQKAIiscsNqmavaHay+JtaPVED5biaWVSAO0MmNL
 M8Pw==
X-Gm-Message-State: AOJu0YySGuKDgVMLz3xw7QQCcPMgFkSua4tR7828/Z0pbX2g2jZh15+n
 4SZMhPdsVz2y63boayhu2J6njNwga2jm7mQs9CPoMQau7J59NB/KNhuoJnGUFvDW61+wRuRyTx2
 /Wf+fVg5A2A==
X-Gm-Gg: ASbGncuRxTjdtXpri0fjEDZA6+qb1/TT0qTCVEKP6iJxuCjYN58doW2J3SxuFaTql50
 qrUeNbIw23TxB/6KE1Hr4jaxTiIe8ScY4FrdHDoWFe9d+tWfz99TFQt8S+j4xARUUH7o9sLL0vt
 sD9fFKKw8p8/PhYqHCJpFMduj3Hzqe0nQQeWkYRufNQYIeArmXtceCwa9RaZZJspHMDl7Te94aM
 kfiGhjWXIkUiRdGBycVyVBJG443a2xmov1tLPnLXbNKkW5DOA4MGjODtnuqJON9IWAb38vEaF4M
 BN9vN0kn20OO9htMOdnG2/XiWz+6ovb+Fss/jwY7jUuR2g/9K7M6T89+cDxJxg0FsN0MlfiFb7T
 4q5BfXijB1B250lmVbJyZtYhmv5whpSb3Gm2e189PbxY/Kte4O8pph3y7ObFTTiKN1lQZpeyUer
 IP2MJgUGK+ptyOcMqnlYhnoMOUiMvgR9cvJ1bwd/yqlX43di4Z
X-Google-Smtp-Source: AGHT+IG8ORgZKGk2q52rLAKT62DMTxYURr9HSdJimmTKih9XAKqTSX2XOB0JFGdO/w99zN1ZEzK0kA==
X-Received: by 2002:a05:600c:3b1a:b0:471:989:9d7b with SMTP id
 5b1f17b1804b1-477870c4f26mr27523395e9.21.1762955068239; 
 Wed, 12 Nov 2025 05:44:28 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e953e3sm36183325e9.14.2025.11.12.05.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 05:44:27 -0800 (PST)
Message-ID: <d11f69a5-c2f7-4e77-9ed9-97905139009d@linaro.org>
Date: Wed, 12 Nov 2025 14:44:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] chardev: Improve @docstring and clarify
 qemu_chr_write() uses
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251112134143.27194-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251112134143.27194-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Missing review: 1, 2, 6, 8, 10

On 12/11/25 14:41, Philippe Mathieu-Daudé wrote:
> v3:
> - Addressed Marc-André & Daniel comments
> - Document qemu_chr_fe_write()
> - Rename replay arguments


> Philippe Mathieu-Daudé (10):
>    chardev/char-fe: Improve @docstrings
>    chardev/char-io: Add @docstrings for io_channel_send[_full]()
>    chardev/char: Improve ChardevClass::chr_write() docstring
>    chardev/char: Document qemu_chr_write[_all]()
>    chardev/char-pty: Do not ignore chr_write() failures
>    chardev/char: Allow partial writes in qemu_chr_write()
>    chardev/char: Preserve %errno in qemu_chr_write()
>    chardev/char: Document qemu_chr_fe_write()'s return value
>    hw/char: Simplify when qemu_chr_fe_write() could not write
>    system/replay: Rename some method parameters



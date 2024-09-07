Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D01FE6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 05:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smoF2-0005Ec-Qw; Sat, 07 Sep 2024 01:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoF0-000591-Le
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:44:10 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoEy-0002Ev-UU
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:44:10 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-535be093a43so3416530e87.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725687847; x=1726292647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k+Zlek4apZ4VyrT45AYjtL63X8tbo9Es2cXYzekzebk=;
 b=uxv+6vuNHkZMMEffFHmwC00gEHXo98t5rCgIDI3pUTlVDin5kf8tF80ze24RafvJFk
 unnYbnU6mTY/EHjH25CHXE988OCZa10M7RNANc8o8Kru3ofm8kFRspCQlI9+wyE5L8ds
 0os+7UxoYB/5xmSlecF3cCRdmyFdemd65WiB19j+WFtJcMNFuCQn+jki2w+qZ+GWGxoe
 /tjWhL4t9NgPybBqChwAw4zm4Hsyd7nyKtGJw+9krFXHyG+yYj/WQGCrbLzp4UgVUO6l
 NLnG8KA7SMM1nPhfNIZOYAOe85qEfJbscgZZ8i4NKsUNo0eOdcQx/lOY/Ak8yYBmA5oc
 9JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725687847; x=1726292647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k+Zlek4apZ4VyrT45AYjtL63X8tbo9Es2cXYzekzebk=;
 b=bhwerCFmaVUKXpJwwxpbApY/mlguTRSCMx7P60mk8AW9MTDyA3WMcVxAM8dyWr6ton
 aqFLVbzAy55Tnsv7HBqoGHFTOqGEmuxzeYAnEOh9EeLO2XlxlLHQfcxhUt+7Jm70nGaf
 RmYpiyOuyIIxbulvKSarlvrtlihB54DH9g+G3u8Kh/G0/Vw7SbBTJH1nki05pBOROYF3
 1Xw3rxLXkoZCxJg+noxG1OwcwSkeyQY+oZu6BKgVGhsE1Qa7lT7wzdP9GVG9qaPIraG2
 fuO7Srw2SwvELMcuXPmA6k9zKxY40dGc7etoVXVoDL7d1qCLRtLsY9+5+PDohw6YTG4T
 xBPw==
X-Gm-Message-State: AOJu0YxExhv71/yYYWnAEfdW9zTVrk8sDuvXinqj3B+vJS0p4GBr3EMy
 CtECHDYaOu/RUG4l/DoMFxdbTSFaEAaLR0z4blxr47BrVwPlQmUWZgf+8D8toX8=
X-Google-Smtp-Source: AGHT+IFwyCW2haS6QRJMdF1KIVJT3B2v9h/v5GazZd5F+zU8yk3ZjX0hJ/JrASex8KaqH+aSGwSz8Q==
X-Received: by 2002:a05:6512:39c8:b0:535:6cef:ffb8 with SMTP id
 2adb3069b0e04-5365881366emr2873684e87.54.1725687847027; 
 Fri, 06 Sep 2024 22:44:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ced20csm30698766b.172.2024.09.06.22.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 22:44:06 -0700 (PDT)
Message-ID: <bcc9a7e8-6257-47d1-94d6-767ab3f1e786@linaro.org>
Date: Sat, 7 Sep 2024 07:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/virtio-sound: fix heap buffer overflow
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240901130112.8242-1-vr_qemu@t-online.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240901130112.8242-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/9/24 15:01, Volker Rümelin wrote:
> Currently, the guest may write to the device configuration space,
> whereas the virtio sound device specification in chapter 5.14.4
> clearly states that the fields in the device configuration space
> are driver-read-only.
> 
> Remove the set_config function from the virtio_snd class.
> 
> This also prevents a heap buffer overflow. See QEMU issue #2296.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2296
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>   hw/audio/trace-events |  1 -
>   hw/audio/virtio-snd.c | 24 ------------------------
>   2 files changed, 25 deletions(-)

Patch queued, thanks.


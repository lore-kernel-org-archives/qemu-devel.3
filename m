Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9E5FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrKJ-0003aI-6l; Mon, 04 May 2026 07:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJrKH-0003Zg-VW
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:19:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJrKG-00049h-7U
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:19:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso28785815e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 04:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777893538; x=1778498338; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EWkhdjd8w9JPIG9/QFaza7FS/udKEtwbZEkSffwJoQE=;
 b=sxqEk38DRMmqz4bkUpsPLMfTfFjmxqCaoeg03w+tizDAJlY3DyYsBXX5fD7JfEOJT+
 1kOtHa/gc50PTRxDTpKcA4r27H56Rg+66q4Fb2Yfhl+sZX8ZOe+PnUK1lpqL9Xm/5LzN
 ZMAtypic+Kvb41tLdI0jLk0v/6eHtSNZemGAnVdA3yedRG7on9hT4ZKYlUAJJSniOn2n
 4kBjoWYVHOd82F0GTQ0QXZjwhrD5VfB6wx6gxhT4HQF1bmqIVlgLfxCcE8cqUCVsrgrx
 wbHgQ663kXbzfN5BJO1KM20pxeKr2Gvm0K8I/aMC/L++IqgFRsGQ4TtObNfZsxaAhWht
 NJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777893538; x=1778498338;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EWkhdjd8w9JPIG9/QFaza7FS/udKEtwbZEkSffwJoQE=;
 b=G/esIPoaT87hrMrbGzynYgOcVR3iEq9ULiK+BKsBk94qoP6cTI9LhtlexXC4ij8L99
 blZQgWUAbz7ZAlgbNkS1p6vyZY7MODOEmKCSJTB3L6z9O+hlPlP4/v52x8JzojNno7bJ
 RH+hyCFxxdPfI0d3I7UVGwSF3MD/YcAO9TZVjJAMtTSjs9kcKFd6xxVgIiRVHqZb8O9M
 4gsCetKKqQ1aY1omAa2oSm6DLoKhe7UjMHN49i+6F04dZr8GMRdrbn7XOgORnsMUiIIM
 MYnhk0qCcxqxQo5QMioAowXzhwXAPnYSES9qAfCS+WLKsQGtx+PIeoyYvj3z/oFz2QDn
 PBUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hnLdR7Kb2Vs3O7bTUBs3U4qOLPHe8jIUXJJb3DR/6lDho1ccGEzybM5fTl/uoRBm2c/1uUZkUcueE@nongnu.org
X-Gm-Message-State: AOJu0Yz83gsEMvWYDulj9eAtMeEUbZ5jD0KbHdEbVdAVTSoGbV3MmE5q
 INqbbRcFGUx1sl/ykLTyQqjjEz8xb49QCbIxYFX4IA3ZqLXOKvJ+dWXNJhKmBQIRXXg=
X-Gm-Gg: AeBDiesEZHtWySFiOUIQ+R0Sf0G9JaKSifP1xO79JujKvf9lV5ITR+cLfH85/4pLgWn
 pOukG8YT0K0y+78XZIZj+Zphu/6DH/wuxHZhU5mhtZcboxbLUGpRsblcpJcr/L7f7hdSzQ0EUrQ
 StBU969Hq6TfA3wKvilQ/wBvwEh/zd7rDjO+FqBr01wLHZ++j7913FsVwi+hOd63OOijd97+ZEI
 DOYwMYtJfkjZxSeb0Bc3wjzoK2eK9Ycx3o94VgBrrzzIUdYjws6ZhBz9VJjyVRiPYGxVp5CGFIZ
 TfXswGo/wZXVc1x4MK6Cr34+dD9Uznn9FQLDFCDiPZidGSp6jxAUS8O/ThldZEUeW29PBmsDs3I
 t9urpsEHjY2cLa+puHqjhP8qB752X6NCg5+tUylpgIzphYZKPgLf3mnjnbgTdE8uwKJHWfTUGN5
 asgI6KQN103IHeEQ9AmfDTpTRFNGk5Zx85Nqa34ZNMSJ5alLR6nzpVejNz5IYXtG+1Pi4e8xet4
 LVCzqKoXqPwGq0=
X-Received: by 2002:a05:600c:46d1:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-48a988ca441mr148430985e9.29.1777893537695; 
 Mon, 04 May 2026 04:18:57 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba865fsm240434095e9.10.2026.05.04.04.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 04:18:57 -0700 (PDT)
Message-ID: <67a45038-e4bb-48f8-af08-af0d5c308ece@linaro.org>
Date: Mon, 4 May 2026 13:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Zhao Liu <zhao1.liu@intel.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <20260504025342.1452605-9-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260504025342.1452605-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/5/26 04:53, Jamin Lin wrote:
> When 64-bit addressing is supported, the Linux EHCI driver programs the
> segment register to zero. See ehci_run function:
> https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c
> 
> The driver comment also notes that descriptor structures allocated from
> the DMA pool use segment zero semantics.
> 
> Descriptor memory is allocated using the DMA API. The platform driver
> configures a 64-bit DMA mask so memory can be allocated above 4GB.
> See ehci_platform_probe function:
> https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platform.c
> 
> On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.
> As a result, descriptor addresses constructed directly from the guest
> EHCI registers do not match the actual system address used by the
> controller when fetching queue heads (QH) and queue element transfer
> descriptors (qTD).
> 
> Add a ctrldssegment-default property so platforms can provide a
> descriptor address offset when constructing descriptor addresses.
> This allows systems where DRAM resides above 4GB to access EHCI
> descriptors correctly.
> 
> The default value is zero, so existing machines are not affected.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/usb/hcd-ehci.h | 5 ++++-
>   hw/usb/hcd-ehci.c | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 8e6a8cdfb0..3d57e1de5f 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -264,6 +264,7 @@ struct EHCIState {
>       uint32_t maxframes;
>       bool migrate_fetch_addr_64bit;
>       bool caps_64bit_addr;
> +    uint32_t ctrldssegment_default;
>   
>       /*
>        *  EHCI spec version 1.0 Section 2.3
> @@ -322,7 +323,9 @@ struct EHCIState {
>       DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \
>                        ehci.migrate_fetch_addr_64bit, true), \
>       DEFINE_PROP_BOOL("caps-64bit-addr", _state, \
> -                     ehci.caps_64bit_addr, false)
> +                     ehci.caps_64bit_addr, false), \
> +    DEFINE_PROP_UINT32("ctrldssegment-default", _state, \
> +                       ehci.ctrldssegment_default, 0)

ctrl-ds-segment-default and ctrl_ds_segment_default?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



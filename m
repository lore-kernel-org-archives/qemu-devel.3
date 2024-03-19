Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDDEC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmT0D-0000q8-Q8; Tue, 19 Mar 2024 02:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSzy-0000Xe-4K
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:31:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSzw-00063z-M9
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:30:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4146562a839so1544245e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829854; x=1711434654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Bb+GXmBWHdatwI7O6RV1jb3mbhh0LofMjw/ebApDRY=;
 b=G0fVK9xNaKPeQfzAln7OvA9hpTjuesk/NosfTMPiGeaa7Wr+MabiAHtwifXvAnN3Su
 aq6wKboM4FU0vne69GTswpTSZiWz5VTdGtgNbLKVnm+uo11EzMY5e9u0UzaVBxXneWFP
 13DW/kX/uS3nUAVBTxZb89UZn9VVCw8IbPBKf5aSdsTtecun4l6kpZ7PaC1FDExGZ7dn
 9LsWuA4yY+uljHP8opWtd80NSPWXVK+2JSk2+PYlo9nfWYe06uhTbRWfVYd3YU8kNn61
 7Xf6/+3XPizO6HEqL98eIDXGOfvrDsDrTrRw0ckmw62VvRuMOBbXtCu6rKBYNeWrGkft
 clqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829854; x=1711434654;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Bb+GXmBWHdatwI7O6RV1jb3mbhh0LofMjw/ebApDRY=;
 b=XkRbtoCzI1eBXWbnznTrsZD0GNTPVdaCVdrBFQSezGGNCqlX1P3TjWMbeZpNug4asv
 esPv3humL3c6WQKuiRg4Fpf+5Kq7Cxz16b5YtrD2+DwjO3hCbLawR7XYR5MgUaST3DyH
 nV+IkAKB+KEn/vx3jsY7hhC6whbYaahB86wfA+SzsHuZB3rgfcZrCKu0KVIVPc81P/BF
 /vj8jzUtHqPczBXDoSejTQlQX9rSPmRhaHxHPm0Q7Q3SmEQkkz5qUDge0dQ5vrgkY7Yc
 VDtG+pZSZgijXRYti2Z/42kDyiJOwLkelywTgfRIbpzTDs2uZ6fDev+k/cXXN6gPMTFy
 k9KA==
X-Gm-Message-State: AOJu0YzR/o4XG6IgSpj6FWr/W4Spxte/mEBVl3r+wIkJVdA+WbR9Q6tM
 1I6PSxOKI3etnWw5BAlSIS4XUZoIQoU2tsKte6sILVRWDAScwVM+QiihKgfbab6AAu1aBNaROal
 8
X-Google-Smtp-Source: AGHT+IEf3EgCEFRDrTbkWIeTqlrPKdlViLL6wAv3vxKa8y3Wl1BVTeo+z7rO+JBeWfuBgjoR25r1Tg==
X-Received: by 2002:a05:600c:35ca:b0:414:1a5:2085 with SMTP id
 r10-20020a05600c35ca00b0041401a52085mr1124795wmq.31.1710829854308; 
 Mon, 18 Mar 2024 23:30:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a05600c470f00b004128fa77216sm20446328wmo.1.2024.03.18.23.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 23:30:53 -0700 (PDT)
Message-ID: <3e5aec48-0849-4f24-8c5c-4e109aef0329@linaro.org>
Date: Tue, 19 Mar 2024 07:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 0/8] target/microblaze: Sprint housekeeping
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
References: <20240319062855.8025-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240319062855.8025-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

s/sprint/spring/ in Subject ;)

On 19/3/24 07:28, Philippe Mathieu-Daudé wrote:
> Cleanups while trying to remove non-essential target_ulong uses.
> 
> Last use is in helper_stackprot(), but I couldn't figure what
> to do there yet.
> 
> Philippe Mathieu-Daudé (8):
>    target/microblaze: Use correct string format in do_unaligned_access()
>    target/microblaze: Use hwaddr/vaddr in cpu_get_phys_page_attrs_debug()
>    target/microblaze: Widen vaddr in mmu_translate()
>    target/microblaze: Use 32-bit destination in gen_goto_tb()
>    target/microblaze: Restrict 64-bit 'res_addr' to system emulation
>    target/microblaze: Rename helper.c -> sys_helper.c
>    target/microblaze: Move MMU helpers to sys_helper.c
>    target/microblaze: Widen $ear to 64-bit



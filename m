Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29FDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrnJ-0004QG-2t; Mon, 03 Nov 2025 05:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrnH-0004PH-5l
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:28:11 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrnC-0005gW-Kj
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:28:09 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-429c8632fcbso1239809f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762165679; x=1762770479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D221FhhK2V5kC5d1+uqYPCAzQRDlac2I97Ad+ttgngc=;
 b=mlLgnqrLxY/R1LXPaKXrGHz0zBhixcK4EUb0xyKrJxHhAp7yDiEY2/hplwBpZ3E644
 HzuYVjtcEuc00qgXbTDd6JW76ph2q3SNYwRH3k/78wZcxrv4cpSkool0r2sdS4ZVK+Tg
 q8xhq+fq8YMrE4xTh0A9zE7PWfZ/xLYHaV6Dypc9mcehzf3RX0KUB2O4QCHO04oAnVTm
 2T6icgvTVPCEzJExGaLtKZZdKJ6aTB7icIFdLpsvKXeiouurSFf3E/XYEe+yYtU3miM9
 XRwH96O+TBRhkZgNwZ/LITN+zbMKoucm70zD2IpypW/oFZeoIO33B51YzgAk5pQTDhA/
 8IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165679; x=1762770479;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D221FhhK2V5kC5d1+uqYPCAzQRDlac2I97Ad+ttgngc=;
 b=OgRLAOUD+tHhy74sgVF7KVHSMG3PbMlk5NxUJEJ5Ir4qrEgMe++SAWsPbmv2uEwtxD
 GBtiU0T1pLr93j/tdgcLWNsMPcdttvFiaFN12ITKJBDmAVBnTKc+33p2z1/Cxe4U3rGB
 DvxPTF8bFVDeKLHf+AJkzXSwR/y7E3bnMHRxydD0zg9jVGoeTmxmqlReXWfJ1ehYmkV8
 8PesfzIl3t+KOk/hsJdqXTUrfJn7pvxeOptGyMDIv+uufEHW7qRshtfnK33R3mxyb8Gb
 HBdhQVKEsDMx+Qf5JgREv+dYdgLjmQiZUWzMRxGSsX3J1qF0ko/uBWP44TUiI8R6d71f
 6SfQ==
X-Gm-Message-State: AOJu0YwtHR8lGxbUVmXCv6/9nnZbvELiftXjiJRymo9fXuxLxiCFFvEs
 zQUjRKD1TGuwknRU2dKT2Pd7baS+oR33akU24OoD0jzz7qK9v0lOTyu5GXDCMSrJbTRJy3mpSnt
 5Kb88+3J059YT
X-Gm-Gg: ASbGncsLNKjifNtzjf2QbtExRpyo4j/vbP645DYFK4WvLF92JNyG1NM5BvLyVQlg+Mu
 9wnsitBLvyAad8uqDiif8Mbrfy/V+/HLqkZJr7bKI7dkw86uFgcqlF7gi8CNAvAAsmycOfIRviU
 COVPnkpiLpyfs/a1vsRAwe5+YZecQRx0nUVl0nGSrqU2A94V8vxVOuQi2VRAVknprvwaN9PEpRL
 usoqYkdQhYP1a0FMD+KRBd+A25vcl9z4KGc9V8A3jB27dbBigqXsORDSR9E1EBHEkRXl+euVDE6
 puY4/abaAKBadLElqk1kIJ81F0hDTorgJim5Qy67gF3CYBkT0hxIgJSD7UYxf7Wu3yhZ2KV4igN
 nrT/gSbV59Z34l/SL/H754+fMsKBSWFWYCJNsjO5HWovKkEEfikjBeKHk2m/ZGox7nq5ZNXCjrp
 JxaWbYcbVMCN5+zvEnRie0KRvVIOr7Mf8/tAN0P86qkukLOcjhdzx40qv6qtmHhA==
X-Google-Smtp-Source: AGHT+IHHXdm1gS9kCwzYp1pBzJQfCixGM9LpBTCaHtYt38EcGqnWUEPcC2IoMjHzkmyO9NWFoZu5DQ==
X-Received: by 2002:a05:6000:2082:b0:426:ff8f:a0a3 with SMTP id
 ffacd0b85a97d-429bd6adbc3mr9514163f8f.34.1762165679342; 
 Mon, 03 Nov 2025 02:27:59 -0800 (PST)
Received: from [172.18.178.65] (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429d2952653sm6288036f8f.8.2025.11.03.02.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 02:27:58 -0800 (PST)
Message-ID: <862b1b6a-239a-4818-aa72-8907aaf68912@linaro.org>
Date: Mon, 3 Nov 2025 11:27:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Remove unused VMSTATE_UINTTL_EQUAL[_V]() macros
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Anton Johansson <anjo@rev.ng>
References: <20251016160313.25751-1-philmd@linaro.org>
 <aPEYshE-INpg42Me@x1.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aPEYshE-INpg42Me@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 16/10/25 18:09, Peter Xu wrote:
> On Thu, Oct 16, 2025 at 06:03:13PM +0200, Philippe Mathieu-Daudé wrote:
>> The last use of VMSTATE_UINTTL_EQUAL() was removed in commit
>> 16a2497bd44 ("target-ppc: Fix CPU migration from qemu-2.6 <->
>> later versions"), 9 years ago; remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> queued, thanks.
> 

Thank you :)


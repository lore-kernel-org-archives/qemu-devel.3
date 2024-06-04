Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A6DC27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 21:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEbed-0006Ku-3I; Tue, 04 Jun 2024 17:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEbea-0006K0-Je
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 17:25:12 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEbeW-0005KM-6l
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 17:25:09 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f938c18725so1019510a34.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717536306; x=1718141106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=++SrMhiO+2NKmLCHBjNS0W1uJPK4CB8krJQjN8QwedE=;
 b=a2OkC03l8t0tCxQynJ4tzsXF5ACzDaeXaO3Wp2CNkuxJsbSMcaauZg7xBAuFP0svwi
 WmBoOC7ZwfM2iFNSuyghQRYjGkU+iFzITOfEcMSDeOuNCSQ4wLuOHyy0cK32yKOvnUUu
 cu+2eqGDAhqYIKNXN3IC1rHHFT/dCr+Ed6w+t8VAXE0vwMLLQF0FWqulfKzSGQu8K6Jz
 LXGxZu/JCtdbnVmhsAN+NZQA9RI9ZPKqRCYtd/0oZ1ExIJy1QdZupx0dgIJrfjPdbMYJ
 JC67cH3uxCDe4K2z6zkeezyZsdD3eCIgzypwkT/Au4qLKActexHjx5KJL28mlQTNhZpz
 L8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717536306; x=1718141106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=++SrMhiO+2NKmLCHBjNS0W1uJPK4CB8krJQjN8QwedE=;
 b=poEF60fi8mKJwBnn/oy/Lc/1DaUUg48hz0+KXum9y2BAoxMFYIveC5UPD3CnyCY9nP
 lBUqgEwEjdD5Iuvn5T/pDMGcL4PMGGh28ecNcvv4IS9nE7F8xUSzhnVhIdHDilXN8j3A
 kqLjUtMrNSPtMKf7PPPqs86T6H95i+YQ+jjOudGwv9UrjCU40oUtnXPQqSeWFdhcKdzQ
 6/hDnUf1bHpAj+YJfRepTR+pCSeLH/9+nvwclJnCBQXmX4ewNX/x0QSRMs/fquvbrkli
 n3AscG1WEB/SQGp3BpsOku81LmIluVch3VuN3W8Ry2007E4O5IWYLXcXPc2U4SfpQEeK
 ly9A==
X-Gm-Message-State: AOJu0YwqirmnM1TpZzCvgYti0rc8e5HRd++dJoPSrY00vE1vhTp88LLs
 +/5lSkn/ybV7G31Wnzk12pIqfGK3JpjrbhtD5m1lSPZ6uHgdxso4rKbL/ncsB+H3AhaZKtorWqv
 T
X-Google-Smtp-Source: AGHT+IGHSadT/214KcaLQzHItx/4r3PKNPVUrcygM1tvn94PHlt9rmYYaCHjBQBcNYVP5gfjPVsbYA==
X-Received: by 2002:a05:6830:4a1:b0:6f9:392d:27f9 with SMTP id
 46e09a7af769-6f9437d9815mr674206a34.35.1717536306250; 
 Tue, 04 Jun 2024 14:25:06 -0700 (PDT)
Received: from ?IPV6:2607:fb90:4563:8160:6b05:9785:70c3:4f26?
 ([2607:fb90:4563:8160:6b05:9785:70c3:4f26])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f931333b7dsm895064a34.42.2024.06.04.14.25.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 14:25:05 -0700 (PDT)
Message-ID: <f677349f-cf68-4189-86bc-f16d69a3f891@linaro.org>
Date: Tue, 4 Jun 2024 16:25:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] Misc HW / accel patches
To: qemu-devel@nongnu.org
References: <20240604095609.12285-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 6/4/24 04:55, Philippe Mathieu-Daudé wrote:
> The following changes since commit 3ab42e46acf867c45bc929fcc37693e327a35a24:
> 
>    Merge tag 'pull-ufs-20240603' ofhttps://gitlab.com/jeuk20.kim/qemu  into staging (2024-06-03 08:18:14 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/hw-misc-accel-20240604
> 
> for you to fetch changes up to 7c2397643c1e025c157bab95088b3b480f0d98ae:
> 
>    usb: add config options for the hub and hid devices (2024-06-04 11:53:43 +0200)
> 
> Following checkpatch.pl error ignored:
> 
>    ERROR: suspect code indent for conditional statements (7, 10)
>    #95: FILE: disas/microblaze.c:718:
>            if ( ((((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask) & 0xE000) == REG_PVR_MASK) {
>    +          snprintf(tmpstr, sizeof(tmpstr), "%s%u", pvr_register_prefix,
> 
>    total: 1 errors, 0 warnings, 79 lines checked
> 
> ----------------------------------------------------------------
> Misc HW & accelerators patch queue
> 
> - Use async exit in debugexit model (Thomas)
> - Fixed bug reading xlnx_dpdma descriptor (Peter)
> - Initialise plugin state before vCPU/thread creation (Alex)
> - Few sprintf() calls removed (Richard & Philippe)
> - Few deprecated QMP events removed (Philippe)
> - Housekeeping in Xen (Edgar & Philippe)
> - Split USB HID/HUB & update MAINTAINERS (Gerd)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~



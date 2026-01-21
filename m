Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF738C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 23:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vihh2-0005za-Ki; Wed, 21 Jan 2026 18:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vihh0-0005n5-1L
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 18:32:54 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vihgw-00075b-Pn
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 18:32:52 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-88fcc71dbf4so2937526d6.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 15:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769038369; x=1769643169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dboFZxlxkDVdz1GjeKmzx+efzynfnRNfI5yFjMCdVMc=;
 b=jwsPDrwx4AyIGCLEfyIilfErAxhGNcz67Cp4vraDlx57v3zjaWlKhl8CMR5GFVbS8L
 DDtGAUvmaaG1VbTNNmeKpAMJRLTqYgLKyw3PjQPhYa6pECl9DgmujK1tSDtQigjtxP4J
 HIxu6zEvMbHv0OzQEPU+nBVmpl1x4UI3P76gYCv5gCws6MicW7M0CXR5SBDVVX9TJz0O
 jf6IcodhNLDoSDCyfAxWfLjuK7Un2wzkrZTIkLKxbUtCxepwGFutfFRn3t9L/eSetoe5
 khaAXtiQEhj5Kfm0x8tdhK7rtTnvrstUEbdk1eUrt5gb50BcNP732CqcWj/v59ReUVLC
 8cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769038369; x=1769643169;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dboFZxlxkDVdz1GjeKmzx+efzynfnRNfI5yFjMCdVMc=;
 b=hNY0cJA7MoRHcXlJnS96Hl2t+fYDhw9g1bQb9zMXh1Ozcu51/sN6TH90N6uaLVmTPS
 jc+iKomAtktdAlqbH/lB1KTe8EAXlUWuErcS+/p0kIqC7nSzWUFQfPkkFoX4efeK1Vzi
 RjXO0atMDv2eXw7h+GVHdkeHrGUVcE6ar7w3vDIhZZx5Tak/ctWqUDn3B62ud57IdpnK
 DCd1LscKmdhDGi/4QReShgQ6aemlZIDAZRRuQB9+ukojVH88/moqnt10OjEPQm56u7ZB
 pd/Se/057uHuTCNGo6zfCUBvslPOSLjMAVS963olg02LS6C29k9t9Fz4FcaXYenGLWAM
 yZyg==
X-Gm-Message-State: AOJu0YyHxmfkUcCGoVzGjcqrAG7WM4pCDBeEDBy4NqM+OHsOUqKGogtZ
 0NFWsqZ8YuJv/CYq+rUQ2zHpngSMnNnKKr1kYXVkV2mT+Ia7vJeBpCttB5yM8mfvrIp6+Lp8Msc
 tE8MkG+g=
X-Gm-Gg: AZuq6aLBuGMfiNUcpdZakC+9Bu+qcKObPOG6wdj7oiKcEb18Mt5RLGgi1oEujOZfAmf
 TGakibx4eH77LLmR1mdzUEcoiiFVmUrd/eCPOeK3eg2qrNj3msJyRNTrFWcGOLXNrkhONvnC7UD
 du2FqlV3xJuwJwN/zNray1lKAFOyBPucNgms6CFc04ntURnFdxVpX+5NvkFINZ5EGGU84Q3+KUQ
 NdRdh0JNlZqVt+zAj7DJzFL4XlsIsaicN0DQNDxEmTbIByvID0gySqsGsWLrWa6QXadXPkbx/Ec
 Re1YwYLcwuA1f6baOO7PnToBkrHwC5hlNrlrXNqWL20w2C2bSgLR1TqavhIsIG8ndKc8iunD5kD
 do3i9Q5+Soayb+S3FYgWDZy2wb8JXuF4cUErjWVLpr3Nc/9xLoApXqit9TkpztTK7idO99/7EnF
 tMwc86sXXvyD7AtvvIOeHgrVMFguonjCaZ30Ewy0A5IZ53zlWq7nI=
X-Received: by 2002:ad4:5def:0:b0:880:461d:2e19 with SMTP id
 6a1803df08f44-894638fe732mr112653436d6.42.1769038369290; 
 Wed, 21 Jan 2026 15:32:49 -0800 (PST)
Received: from [10.244.221.227] ([172.59.190.48])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71d5b93sm1325923685a.23.2026.01.21.15.32.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 15:32:48 -0800 (PST)
Message-ID: <5e24b786-0bd2-4bcb-94f5-cb235b9031d7@linaro.org>
Date: Thu, 22 Jan 2026 10:32:41 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pc-bios/optionrom: Use 32-bit linker emulation for the
 optionroms
To: qemu-devel@nongnu.org
References: <20260121074819.29396-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260121074819.29396-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/21/26 18:48, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Without this linker flag, the linking fails on NetBSD v10.1 with:
> 
>   ld: i386 architecture of input file `multiboot.o' is incompatible with i386:x86-64 output
>   ld: i386 architecture of input file `multiboot_dma.o' is incompatible with i386:x86-64 output
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/optionrom/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index 30d07026c79..e6674a76e73 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -36,7 +36,7 @@ config-cc.mak: Makefile
>   	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
>   -include config-cc.mak
>   
> -override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
> +override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds,-m,elf_i386
>   
>   pvh.img: pvh.o pvh_main.o
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9C4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ57d-0004Je-5U; Wed, 12 Nov 2025 02:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ573-00043E-HF
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:18:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ570-00062G-1q
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:17:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so3495495e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 23:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762931868; x=1763536668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TloOU0/vz5LrdO/wwCE7MeVV3UbSMtg5CQYqYg1VoVE=;
 b=UWStPfY+J54n7FLpp9EvmDMJEzNae/MHoUFirEto59YZjTAhuwDBRpK3p58lZ8fzZ+
 rY4iS1oxOPCFH9roAw8ACUl+sKbxsA0cpG+wiJKiNW1l104eidnU7kx2FloRZw+Mwg4G
 17x4QjiOeKSm5oBaVQSsajSfC+UTib3UAoH6V2HjdS1ZVfwieX8OvoLBL4XoRN3KKjjM
 f6Il4rDWeIl632uENOsG8vDdGAnSEk+bkU8LDUU7iUL3VivgKKkdv0MyY+JS65KlDRFt
 j3q0SplKvkXOAv1FPfYeZon5zWgHEp4sOMrSHT9aJbAPuPiFRe+6dbduUc1dQAdxZxMz
 k3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762931868; x=1763536668;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TloOU0/vz5LrdO/wwCE7MeVV3UbSMtg5CQYqYg1VoVE=;
 b=NG452AHvD5T1feCY8WjrpwFzJMDloT6J4tH2634mYDc2tkCNb2TuGen6mtu/B4waO4
 Ne2dllBmYUeXggxj9lWxvFQEu6r0MzqSSRnCMKfOfCnFP7ntyclfDBcfJrTzHnrDcbAi
 0fVWUlYMxmVMUbodOjIkQFzw6iaR4xY0z+VagXLplNtHP99vbOWAZgxGqN25jHLua44G
 k7cT9CeVkMicmAZ/KAm0oGWtmn+VwmUWNQIF+nUm27vw7e7iGjAofRX1wFbO2WunAoI+
 FaYVKWQCL+tefx5tM+e34b+4gpHrCTlqlv90BPa9eHn/SJG+tiQsMnj/GGls3xF+2OPO
 JGUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmOcLVOBUK5atEZ8DcWPyDULE4/Mte87tT8aEqr5XfEYvClWqZOPb7e7UfqEFbcTXXaPM1SwlFFQFc@nongnu.org
X-Gm-Message-State: AOJu0YyGHg5KRc6w4DJhxEpcyQdnX0IPcAFEGXq04b4me3CbTeGw5XBg
 e2k8Fp7TQpx1L6yvNmnRxFVwHbaC2cFk02pqyIhjCcRGfIOVuXXjO6UNlPcxtxdCZR4=
X-Gm-Gg: ASbGncvyL9n6IILpIgDns8Qhu63hGyqozJxBIc/ES6yS590544g/KCB7E2v2We+fSw+
 ArYXimQ1F7sbpQPOXYXl9VgGiAvkTfI8sH2Ixer+rut7kA+cLGt+pl9FZCuPFhdMcGdCdnD+XK4
 TBtUi1qnvyvrSvvS2W96tr+/N1YpDeK1YCuQdgafi9H0DbRaOg0q99BFcbu9VLwfUGraWFRWN6s
 vEiI55DguVDcUtBwUkA6VVZrgwB80gb5M0/BhyheVMnFZ7JHzuNMhjm4SrLOHB4cbWrDZAHOfF1
 M4WvVpUvJrRaL1Wg8dT3iSbhg9DVKoq3WV0gfO3R/QyYYhS1WcZqlxETSHjZzkImcfrjFmqfpy5
 8sBLzbuli7TkfDltLVa+7aCEYMD+qLfM3dlq1Cdt4p6l8M6M0bxLV2yNvJizyFol++8wKVlgSnj
 XWxyagw+wWbxQhaqEFiaS1wkbv+2Dleun+GwQGpuFYzBk1fDuU
X-Google-Smtp-Source: AGHT+IEmX1rzwNDfMDV0zxHXc8d7k9O7ai6+g6wGt/GNem/uhDsA8iFWRxYSnHUZNuKwscGRTC7dSA==
X-Received: by 2002:a05:600c:4f54:b0:477:1622:7f78 with SMTP id
 5b1f17b1804b1-477870bfd6cmr13829915e9.40.1762931868158; 
 Tue, 11 Nov 2025 23:17:48 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e43c2fsm19241675e9.6.2025.11.11.23.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 23:17:47 -0800 (PST)
Message-ID: <0c9716c9-6037-4abb-bd59-1929d0cc46d4@linaro.org>
Date: Wed, 12 Nov 2025 08:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd: Remove unused header includes in ssi-sd.c
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>, QEMU <qemu-devel@nongnu.org>
References: <20251110104311.1640772-1-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110104311.1640772-1-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/11/25 11:43, Bin Meng wrote:
> Remove these header files which are not used by ssi-sd.c
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> 
> ---
> 
>   hw/sd/ssi-sd.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9762CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Pmo-0004cx-6O; Thu, 02 Oct 2025 16:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pmj-0004bF-El
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:20:18 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PmZ-0006ZV-8s
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:20:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-27edcbcd158so18408615ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436399; x=1760041199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BxmsvznYL2u9Al4bWLuThZGF8R5OQ7AJ6I2xqMndPIk=;
 b=mnpd3Wy8B8dCzSA3bBDbto3BSsIJI4CWJVi290N2kMmfFP64gIIBDVun0/s4/mUTq2
 9mRZm1F7DHR9YJ/y3A6ppCugrdb+3Q0Qtag6zrZb17kEmjUH0TYY8bg9xSXe4d6A6LNa
 U172BLuayLVofceqCC/r4MeBHMwZj5KHx3DXiW2htJ/kUji/nzzfMvLcwV9cJoLqCWwx
 fapdjd3LN4gT9Vl/33t0bBtl8vj39lkmC90S6V9iQjbRshA8XL2g9/dlY53zy0q1VuGX
 n9byMy1f44KB729vxbdO/osTVvcd7xXcBwmgHzaU+zo0rtoXWYMFe8n1EbHOSbr6BtNS
 +NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436399; x=1760041199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BxmsvznYL2u9Al4bWLuThZGF8R5OQ7AJ6I2xqMndPIk=;
 b=jLXXkB0ubVFKNI7nftii7SX6FbXOapzRhO81b9Cbmca1uNev6Kd0jeKNOGtxYpyD+A
 R7SxnaNHKdWaSBpOg9jHR43OzQoCiBasWSp8ONnmZw42Bcr/Yj+hJy4d8CnkgNR1fvJf
 fjnAiPG+eB0EUe4BCOO1fSYPoQSeg+6SEILGbmfy8lzwGNAwZOaq1XW/5JcDnrZcULol
 ysTrOpflK40Aq2X1vXsWa13C69whaVD5zuPs4GG4Xxik4ovp5OsrNbxRTDL/qGdPV9WP
 VgE7CpU4Mg+10vKbb9ByggnSLdQBv40O12zuXFTzCVa1BBfazNTqUPZjKEsB1O6+R43w
 nzxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSzgOtsyFX9KeHha+p2gpqTJs4iojbtG9tmZYO7ke92Ae113gz/mvKD8VN9G8pWoq/eWZ+jKTsC9cp@nongnu.org
X-Gm-Message-State: AOJu0YzANmpikOdzUvR8SWO5S043ncFrrf523voPSIElyXjWzFtNMebd
 6z0zXCF2ad6YzojKAZNj/zArvswOQnxszpHwLNshH78NeXwI1yPj46qvDXGeBYP6464=
X-Gm-Gg: ASbGncvEIo1Bf7qwOKtedpMq9tUVSfjYCmw6hBhBK41npCtAk5dVjd49YsNWRURZm/5
 mpHC58stmuNVYw/wzA3eg+2g8pn/+XJMOEyJc/XDawImZya2BmubL6EUiMXZWgWxYy0QpzONg3F
 3QAvSWTbuh5/qDJKfw0pMPm5qiky0a8dHCeNnswHy48cNIE+OKbDtW7vadNl21Cm73zNxHh5H5i
 cZWPa3tPrhuqhMTyQtFEiHNJv529fcinl3i9UwzUnFqwQZgZik+baEvLdyFvz8l8Q6T3aEcriRo
 w38yPwqa7ovRPHjRl/NL7V4hz5lwhIFP1aoF9N5/o4jUWbUF3uJQa9RLnKPkR5G/KyySKVIRHgm
 gS+aMQDA8ZQ1S69YOOO0jMewzbBymOUyU9fF9/itkOCLKCEy3ajTnAzCEuK107qo=
X-Google-Smtp-Source: AGHT+IEhv7J8tY17boH9YrkyZ2xuDDcZ4w9teZi28+D+0X2UDU+o28VVp2xjG1hu/R2bVJYdriIRyw==
X-Received: by 2002:a17:903:19ec:b0:28e:9427:68f8 with SMTP id
 d9443c01a7336-28e9a513284mr6818295ad.1.1759436399110; 
 Thu, 02 Oct 2025 13:19:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm28655565ad.102.2025.10.02.13.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:19:58 -0700 (PDT)
Message-ID: <4f35cf5f-8435-4b9e-bf31-c120154d4cf7@linaro.org>
Date: Thu, 2 Oct 2025 13:19:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/33] target/riscv: Fix size of trigger data
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-29-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-29-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/1/25 12:33 AM, Anton Johansson wrote:
> mcontext is at most 14 bits in size with the H extension, fix to 16
> bits. trigger_cur indexes into tdata*[RV_MAX_TRIGGERS] which holds 2
> elements, fix to 8 bits.
> 
> Note, the cpu/debug VMSTATE version is bumped, breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h     | 10 +++++-----
>   target/riscv/machine.c | 12 ++++++------
>   2 files changed, 11 insertions(+), 11 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



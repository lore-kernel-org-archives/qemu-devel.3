Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DBBC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rje1S-000089-CM; Mon, 11 Mar 2024 07:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rje1Q-00007n-JX
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:40:48 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rje1O-0000wd-50
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:40:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e8e9a4edaso1847740f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710157243; x=1710762043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZfOtYV9hdCVRM7UBgjaaMiBQl3+zit+nVokq7wgPBbA=;
 b=riStKX3HwLfIBW5Me6sM3FXm93OvFzTvEHCzcIgYJpakigOP1W7fa5McRNyKnIi5hu
 6l2nmPBmjbpn6TWPwub0e/ukyMSVE46HyilwtwzNxcNOvbzUd8QVFE875TuMZCTNr/X9
 F53uLgQBpCxfP9heWwarQGvLRxMCAq+0STguJta8+GKuIkLPV47mrm32eHEu4R+b8MEj
 dS6F7iGOTBpyFgT477rGgZUlV9bqRa8ndO/jR/qpbgxmtiNIWWkPx3R7HNRI8L29GCDu
 0OfbX2soQM82Uc7F268DXD6XxjqJa2tF1eFGU6GvdjqCikduf26//MZ9EhW7HD0RvuuU
 gfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710157243; x=1710762043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfOtYV9hdCVRM7UBgjaaMiBQl3+zit+nVokq7wgPBbA=;
 b=c30FJEYl/dffOfWLkRvOwsidPuGNW60M12GXg3Hy0H+ISkHYRymoHjquK1lvia2xUi
 C2juLu+QoRxhO10mwgppq4n1bteKxpTmD4z2lLdP8j1WdPir/paLkkdBoHDW0KVj+Czi
 cyJcKfziSFGiw742bd/5zIhj6cGue0nms3TeKllAKb6haunbtDAgGXCXDZ0fmfTO+x4R
 +CacnaZWy5mThOvjMjPCrzB+FELImku0HTXvGgV7yHpVhP9kfXs7NG8RKXddO1wNP36w
 jXK64GOrj3e8gmkZLXmicXrCNGT3SDobVWtDdwqa7uGzUhKUWhiymYkXMTMC9qOFyvNT
 FQrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRbLMBP1yeCAOiqOUKxSkslGmLivpMvrEVJBgFDabazXBs6xxEDypkx+l8gRmmwuWyMEt3p7WjQOAQz2pp+5lklVy5yU0=
X-Gm-Message-State: AOJu0YzRX7fyYxPqeMgUaie3AKzCGP+w08oJe2gsgCicGSqt/xjbj2oG
 dCY3xh9dkKhD+OgxmSguV9/zyixgbsMKMw6vvFGG8PijzK3zKOumE/8YJIIC4UQ=
X-Google-Smtp-Source: AGHT+IG3YGgId1XF2QpslQhgj7JAXWJDY1lC5nHZsMjZn6WjxxIPfDv2wKJCKCQrBMBsesTyLNEopA==
X-Received: by 2002:a5d:404d:0:b0:33d:d15b:9789 with SMTP id
 w13-20020a5d404d000000b0033dd15b9789mr87405wrp.65.1710157242727; 
 Mon, 11 Mar 2024 04:40:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a5d424c000000b0033e48db23bdsm6239299wrr.100.2024.03.11.04.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 04:40:42 -0700 (PDT)
Message-ID: <752e3d2b-1834-4f6d-9764-3d7e951409c4@linaro.org>
Date: Mon, 11 Mar 2024 12:40:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/core: Cleanup unused included headers in
 cpu-common.c
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
 <20240311075621.3224684-2-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311075621.3224684-2-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 11/3/24 08:56, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Remove unused headers in cpu-common.c:
> * qemu/notify.h
> * exec/cpu-common.h
> * qemu/error-report.h
> * qemu/qemu-print.h
> 
> Tested by "./configure" and then "make".

This isn't often enough. The safest way to catch implicit
includes is to add #error in them and compile the source.

> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/core/cpu-common.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 0108fb11dbc8..4bd9c70a83f1 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -22,14 +22,10 @@
>   #include "qapi/error.h"
>   #include "hw/core/cpu.h"
>   #include "sysemu/hw_accel.h"
> -#include "qemu/notify.h"
>   #include "qemu/log.h"
>   #include "qemu/main-loop.h"
>   #include "exec/log.h"
> -#include "exec/cpu-common.h"

Watch out, "exec/cpu-common.h" is implicitly included:

$ git diff -U0
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6346df17ce..27961bacc6 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -2,0 +3 @@
+#error

$ ninja libcommon.fa.p/hw_core_cpu-common.c.o
In file included from ../../hw/core/cpu-common.c:34:
In file included from include/hw/boards.h:6:
In file included from include/exec/memory.h:19:
include/exec/cpu-common.h:3:2: error:
#error

I'll keep it for now. No need to repost.

>   #include "exec/gdbstub.h"
> -#include "qemu/error-report.h"
> -#include "qemu/qemu-print.h"
>   #include "sysemu/tcg.h"
>   #include "hw/boards.h"
>   #include "hw/qdev-properties.h"



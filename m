Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DEEC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzOS-00053X-OJ; Tue, 25 Feb 2025 13:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzOO-0004gB-PQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:10:53 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzON-0003GD-2Z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:10:52 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22185cddbffso1123975ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740507049; x=1741111849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8qgZm/0SGTAFR8pdYZ4FWK314BGa+SHO/xYxPh49gmI=;
 b=BM3Yw13eFK/vOjMb+Wzm7aTn2ijphsi/iZkttUeRmHQ61W9tCqbUZONUOxwxsqLPGS
 l+R1dTrbCnxKOBBiQjv6WlFZdwpDlDMVYEcsP6wh43brBj2dFsTChMdrQndSDG5rXDTB
 YupItL9KH4ND8NI1VUqqbsiBsp9PXsCd2iAsVBdf4oXdpzNGMk98UJPJBwj+NkjtE4vs
 DEKIjaxAT6YQDM9LE3D7QvEwIKqyjRdmkIMl+48dqIOMRjWyM75LrUipI7As1HWCeMWt
 bOf/SnrjGG3PBdWetIVhoio8m/7hcoGJVsUz5k+1GRMjeijZRcyb7UJXwWo1P5Ad/jg8
 6NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740507049; x=1741111849;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8qgZm/0SGTAFR8pdYZ4FWK314BGa+SHO/xYxPh49gmI=;
 b=AnlcAkUmvHuzslGq4JsqHR7MGRTIdkpMt8nrbmIrfigyDOypIt7/lymzS0iXqLUjXh
 IjDQQJ9yW9B9V2OvpBaCZAw7RsYQUSu1ZAHxPdU/vOaRNVSJb+457IJSFLXL1vrv5gTc
 XKHZkQ9diXxF2a6jL+2AVyyznMkIhxmDFVv6my3oh8YSEFaPMhGKTndnfqu+jBXM8Mcz
 KnPDB21jAQl1pd8mM4x1g0daNcsMbTNmGQkE4skg8wQqvFLfx7t4OI4ajV1HwBE1mcSI
 8kphBrYa4qBfhB7wqgE4YOrN3WHfnQ4de1ppf7+9hJsYt1glfv0r4xdxuFkqOSa66D6B
 QUvg==
X-Gm-Message-State: AOJu0YxsIbX+7PC7fyi2TQtNRW4U7+NZLwYK2usx5zxdekA3l5aG958b
 2A1UzyewAxTFbIeLZ/Ba7+qYrPpyydVsZ7qjjn14NkPESfEhmLE6OS8dX/1/nLTKmjTeQ63V6u/
 i
X-Gm-Gg: ASbGnctdUpqj16Yn7eQt/yiJis22N1d2T4vhG9Tw90BOt0ZxxrXv7SYQkpdq6suQbzR
 J2ZKMpk425dxmgDPaOQxDS51WOzWoflcOx3zZKSyn2FKlu5UJlMkhwfZbdKcXwI2HTRDxv39dh5
 FrbAzMGCoQv0aB5tiyYifOY8ufur2LKVRxB8QCDjJRUjRwVDincWeVZwxZyGxrXowROem+Cb5p7
 raWcgH7Bi2eSyZUOVl5YSa5tCTuel/XV2lqwuy9Z0o0qj+KSLQYvcSynCpE/cg2yEnlfIugfxmh
 ria8VpgBVRqBihUCMPyp7jeRwU9uKcfLdyRiYzDC5wfsw4jHaCzNIibgwyqPX3SEf/BnAuCUx1r
 f0pXBydc=
X-Google-Smtp-Source: AGHT+IEEKIKD+WLvCB8jTQcO4HI78tRVhex2W6xaNZaviB3dYtUNCCg+mrCMWQZr+Xt2UcMTsNS/CQ==
X-Received: by 2002:a05:6a00:a8d:b0:732:56a7:a935 with SMTP id
 d2e1a72fcca58-7341411dffamr43909985b3a.12.1740507049238; 
 Tue, 25 Feb 2025 10:10:49 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a81edaesm1890428b3a.149.2025.02.25.10.10.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:10:48 -0800 (PST)
Message-ID: <20653fc7-057f-4da9-ac73-0414c2fc1c0e@linaro.org>
Date: Tue, 25 Feb 2025 10:10:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] include/qemu: plugin-memory.h doesn't need
 cpu-defs.h
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/25/25 03:08, Alex Bennée wrote:
> hwaddr is a fixed size on all builds.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/plugin-memory.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
> index 71c1123308..6065ec7aaf 100644
> --- a/include/qemu/plugin-memory.h
> +++ b/include/qemu/plugin-memory.h
> @@ -9,7 +9,6 @@
>   #ifndef PLUGIN_MEMORY_H
>   #define PLUGIN_MEMORY_H
>   
> -#include "exec/cpu-defs.h"
>   #include "exec/hwaddr.h"
>   
>   struct qemu_plugin_hwaddr {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


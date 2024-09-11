Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FF8EE01FD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCkT-0002zO-Ot; Tue, 10 Sep 2024 22:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCkR-0002ye-0y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:06:23 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCkN-0000g3-W0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:06:22 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7d7a9200947so2560476a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 19:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726020378; x=1726625178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NWgVOdvybBWNmfXjZpUQna1coAtugbOITXrm7KFf4h8=;
 b=LVuMp/Wgp4w7PP5sp7CU1Dz3V0WqBGM/+NIgA8i2Gh/hLUj1fVVQ0FXcduAM8vNMQZ
 LSnP9AAfTYe+1vASji1O0n20aIbd0aOwzeXCLivHRJ3j7a99uFc22dDdHRtXfinkfIuH
 eWl5d7zVITMU7bb6zhmmBrpmSih1Tswj4GB78fyt4MtWDUkNjWaz7xaDuhgctLZxndt3
 29IWNIEJsliSWzsXukutzzAIFhIZ9d/MOJdHYXjAi18MVKgikLkknguC/KjtvuCcnjlM
 Cc1U3rsivjgqTcfFAicmY+zqrHil7rRUk8L3nemLoJ+3OsexNY01GCCEf81rVpXZP0sC
 hW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726020378; x=1726625178;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWgVOdvybBWNmfXjZpUQna1coAtugbOITXrm7KFf4h8=;
 b=Eop8H2/8GPbkLZ02l2XgE8faI3E5wfiTnzuFwJJnMNeudbCJkd7XYtJL4Ur+K972q9
 me0L7YzQyA5iJ1LGIfIBF19Emhyr+DWmVmjbpQU/jIkuENR6VIbVUTEZeHL3AguH+Aq/
 9SOcLBoI6K6z+IZpgjb1d69832BFaGhSFHbu1cqbHBzS6wki0DqtZBp5UzLtrvuLZVWG
 fzg8aa1lcN0iAbIzZl19m1Qsz4GmDlyEipB+GJ5yZGJ2g/6ArKPynOnQKu/BliNBPhNo
 i23Npjit2Zf34j+k/d4GljfiH74ClBBb4sZasq1bgA0/ZtCISp9jAgoHlIXhQOoc6+w6
 EpMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLY0LqNqCDfbP0iR7oE7IXaf/xWybdkJ2butpYRPV6tjTc0Cjy+rR38Eku08coSExUIIHbxHFBCiKn@nongnu.org
X-Gm-Message-State: AOJu0YzMcL4Xd0lXLjJmPBCK3lrJOk49N+3gbUcm0a1kjHZcOrlnqrvX
 NgSW82lVqyV8S9S4kYsZL1ydsArVtecxkHDFJnoMKOeRsA7FuJ9GCIXwOJPnOIM=
X-Google-Smtp-Source: AGHT+IE7eInnUXsTvN5Lxp3eERwqAUfQiRhMwfhaUjpkqjKVTIaVzdwbMmI83TK1aP0G0punihbu0Q==
X-Received: by 2002:a17:902:dac9:b0:206:e2e4:57c6 with SMTP id
 d9443c01a7336-2074c623321mr37291865ad.36.1726020377598; 
 Tue, 10 Sep 2024 19:06:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2073cfa19ccsm24912505ad.16.2024.09.10.19.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 19:06:17 -0700 (PDT)
Message-ID: <8cbd1448-7c8e-4257-ae6c-da5bbbc5e4ff@linaro.org>
Date: Tue, 10 Sep 2024 19:06:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/39] hw/net: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/net/i82596.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/i82596.c b/hw/net/i82596.c
> index 6cc8292a65a..cd416a00ffa 100644
> --- a/hw/net/i82596.c
> +++ b/hw/net/i82596.c
> @@ -282,7 +282,7 @@ static void command_loop(I82596State *s)
>           case CmdDump:
>           case CmdDiagnose:
>               printf("FIXME Command %d !!\n", cmd & 7);
> -            assert(0);
> +            g_assert_not_reached();
>           }
>   
>           /* update status */

Ug, printf.  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


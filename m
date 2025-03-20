Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C00C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 23:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvP7y-0000gX-Uc; Thu, 20 Mar 2025 19:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvP7t-0000gD-NT
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 19:16:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvP7r-0007Ch-1Y
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 19:16:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-225a28a511eso29952625ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742512592; x=1743117392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=URAuVZ7OQwb3r5JXLEi5CekGxkjmBrf+UIBPloOFsCs=;
 b=sp3Sp4NLZLsvt9GvP0zpi5cgC48UNHG/WY85V40yFQvBPQAR4O/vhTRz2L4CV0+9Te
 Djf8jKUFmukRA/P6Fl5DKZgvytlq5kTY0kwcsLLSJcTS5Aw9Ap8RJJ3QqCn+KHNU72Up
 /a5wPK4N0TRYL4NcQVFrYx6EMdYRqzwGma1Yh/swZWaW6KGtNBiRQQaAMquvKs6LFitK
 XwewUmWF0VjOEbg019Up1RptWStSRTSsHTCM3WfitbdS7PbgsqLgFmH98pwvTF5ePeFe
 7mo/jCeHtdqu1IjCiMMqb9s/NksG4ZwyB6fZTR1y/w37u5xyF2Q+Q6FH/YseFfQwiF/0
 qiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742512592; x=1743117392;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=URAuVZ7OQwb3r5JXLEi5CekGxkjmBrf+UIBPloOFsCs=;
 b=cx8IMH9ZUcOLVWu0CL/PfpBtMR30G0UQ3bTNv4s6uu8cSVXHtiPjqATWot/un5BYgH
 wJiLBdhrZN3/s7K76no4ga9dvyBopgBCNRGzsB4MilViuT8x+1EQwOKWLZqXunu7desK
 sOZE5Q2ZtRsIpqOzqmWnsRXjflQINtxOwlhObCyXLNFHQzHBJpQZa2qADHcmd/K7vi1O
 lTqxpk84Zny/tNP2WlkzX52Iahup40Alqhd3OhBLqUZriX71iN6BqdYt6hR3wA5HmuKX
 ZpBqsjTtsvWMH0W1U/dEwbeq5gZ/IokyA9+nIm8xVjUltWU+gOTCcmHE1PkXxF7R5Cit
 V9mQ==
X-Gm-Message-State: AOJu0YylrwpV+R6BmE9ZsGdQNpi3B6JdOFsINix5JfGqg1/Dc31xkvXl
 asBbX1PrlDZKLgpK6tgWOPFo37mdGQMncHsuU6nV6eZmUb7tGJkAEJZE+uvMbkr3vUi27+WF4CO
 X
X-Gm-Gg: ASbGncsyE7f+zi8g6V4dCgrJNP/x8Mn6nYbvikE7NRW0VjmsBzJlk/Tlpt/44i/NNc+
 bgYT5IUKhkG3wit+H2rpRvBUapXBSZD5pfp5y7fnFwqx+JMOrVI1qZIiIf5TmgaN1mO+lFbm5Xc
 XBYgDt0zd39ccooarZmJVuBaCs11NYA3eBBhIfd4K2nZWHVYuYI1ffquQZ85L5zCJyOsUuVbTfG
 hKzKXamPjtqK6GJc5z9NIvlTzLd/8YqRgVA3quft0i54UXWVBD5Q3vYokzAZscCpaNATBGNy0a8
 y0JkgRgVSBwnuCH8sfOMwAWmQOTUFWhl1naaI5xp7hc/i69Ly+iHecw9dgj2XF/6mdUA8wKANnF
 NM4OzdHtv
X-Google-Smtp-Source: AGHT+IE+R/7oTEgyoCHuWNo8V5kidPexznriY5Bi/ncfWCTrZ8Etz9tdY92bE9Z2NtK2/cDnPC4KDA==
X-Received: by 2002:a05:6a00:3392:b0:736:57cb:f2b6 with SMTP id
 d2e1a72fcca58-7390599ed9emr1829287b3a.12.1742512592050; 
 Thu, 20 Mar 2025 16:16:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390618efd0sm420148b3a.174.2025.03.20.16.16.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 16:16:31 -0700 (PDT)
Message-ID: <f95a49d5-4fd1-4c6a-85ff-1b5bacd1f0bd@linaro.org>
Date: Thu, 20 Mar 2025 16:16:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix resource leaks in gen-vdso
To: qemu-devel@nongnu.org
References: <20250219100336.1696758-1-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250219100336.1696758-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/19/25 02:03, Daniel P. Berrangé wrote:
> + cleanup:
> +    free(buf);
> +
> +    if (outf &&
> +        fclose(outf) != 0)
> +        ret = EXIT_FAILURE;
> +    if (inf &&
> +        fclose(inf) != 0)
> +        ret = EXIT_FAILURE;
> +    return ret;

Modulo the lack of braces here, the patch looks fine.


r~


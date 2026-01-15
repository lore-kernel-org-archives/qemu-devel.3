Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70408D4114A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 09:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgJQV-0007d6-K2; Thu, 15 Jan 2026 04:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgJQU-0007Vq-1H
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:13:58 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgJQS-0004WX-EW
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:13:57 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-350fe1f8ea3so287843a91.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 01:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768468435; x=1769073235; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BE8+BVwCItbVkZ+HzotK323QDwEeEnvUm7FqChLvWRc=;
 b=Ys1Xctf372fVGWlMcnXAZXz1F/m7NsK6tPFvlMsnlVDE5kym77wWEUM+DyvccQ/1fF
 9BpP1XUGuAGYIsLnTA4QzhhbFRt98jQq3+hK2ko7VQlDfCvrhGlY22bNWyvgvpWl1CuP
 sx1CxgBC4ltSmcZbG5jozztuaWNrWrZh8Q21Ki9tSYV5Bn3HxNkyWWlGvnzQHCYBwVhQ
 p97IdeNwVbV9gdNY3HHOZM/tgdEKUbNxEMfhST7OG5vbZFr1PZwzTjKa1EAyt753Kg7S
 VsUWdC3Hah8QgflAkBaQjQ/o/F17Q9373h+UIxbq7BSpMhmbtK6Zaadz9AzJyLru22bd
 LX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768468435; x=1769073235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BE8+BVwCItbVkZ+HzotK323QDwEeEnvUm7FqChLvWRc=;
 b=wEE+qYD+Bi4P4AJf06aLlEJuQuElOKD8aLngstmjkUh1kUH35U/X84SE6QywBXJWn5
 U/+FMSCPgS8aQ51s/I1vl4wz/3ZktJawTxIqXOoiSZ37peuE7MbODuQOeKes8aMJrwcV
 7qotAXis26MB/TC6Wao5uPpPCcUQaqU9vqwEI+mTm/1MCOKCNXWiMZB3SwRdzu84X3Ua
 fgiHuGUBQUHDlcaObFd9XFrdbDzOY6qVVnzx7fM6vT5EvQy3XpQbQ/e3IvSRYRipW8r+
 VV79o1AKNX9XBXAFRBU1nsOXIa971B4DMhPStEL+SxrW0NYW/SI9BJl9860tkn0wXajF
 aJxQ==
X-Gm-Message-State: AOJu0YxHEwmmjas0ob21ieD87JAsg7b8GcT8lNN+sO77l7ygCCD/mO75
 UpSsdrfbouB1FdlM8DyBbNmXQh9tv//Qckhy7twgryJb9c1SxRUaZCYyUQnN3FgLs2E=
X-Gm-Gg: AY/fxX7xZn+3z4185DD2kRKBqUzPLGqvXWnw2OD0YKnckRYUNw9wH7vf8QQU02+gsDO
 UBFLZkaiB0iVuev9eNMv4cb+QEpsB2A7UCLjbss+BJUWoqiAz/4k1+76SZuDycjRc+NrzYK0mgm
 7NASDvM+avi75XY87amWWIw7AftahZsph4Yq/mVnlcmarHFhi7a6KcBIghf98CFakoHgiNfjNjl
 ArixspW8lv8P5OkZ916WRwFrRWPNWiEMAHl3LbVsw1QTolDStrzVpLxfvgcdaUTzAvQhAZziKew
 P6mMn8/TlU/3Siy8/8f45ww9hHWMhHik1rxdqKOs3SYaTgdJ9mMSOae43zP1U5rgG+czToU5u9I
 lzhj+8pQpVhVzEZZO60m1QjMvbjEJBIvpla43KmJhRQoEnp7Hm9+brXMoTBGno1NN5p6aj6St1e
 lpVDpnKf55YmBKNZCk4oxbuXn/zrwPcIHipFmgcPjRVf9o01q9o6mF
X-Received: by 2002:a17:90b:3e4b:b0:341:8b2b:43c with SMTP id
 98e67ed59e1d1-3510b12676emr4963671a91.18.1768468434908; 
 Thu, 15 Jan 2026 01:13:54 -0800 (PST)
Received: from sifive.com ([136.226.240.171]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35267809f4esm1505246a91.9.2026.01.15.01.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 01:13:54 -0800 (PST)
Date: Thu, 15 Jan 2026 17:13:51 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 03/18] fpu/softfloat: Add convert operations(bf16, fp32)
 for OFP8 data types
Message-ID: <aWibknGSdddSeJD5@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-4-max.chou@sifive.com>
 <ef2b8965-9c7a-4b81-a6cb-3cd387a71472@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef2b8965-9c7a-4b81-a6cb-3cd387a71472@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1032.google.com
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

On 2026-01-10 14:20, Richard Henderson wrote:
> I suggest you pass that as a bool parameter to bfloat16_to_float8_e4m3 etc.
> This would then be handled as part of round-and-pack, maybe a separate step,
> maybe via float_round_nearest_even_max.
> 

Thanks for the suggestion!
Will replace the format saturate flag by a bool parameter of convert
function at v2.

> I'm not sure what to do with arm_althp vs ocpfp.  It seems like they have a
> couple of things in common.  Perhaps we should decompose these to separate
> behavior flags.
> 
> 
> r~

I agree that we should decompose these to seperate behavior flags. I
will try to introduce some behavior flas (liked no infinity, maximum
normal pattern, etc.) at v2.

rnax


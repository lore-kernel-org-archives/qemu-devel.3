Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0ADCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDj8U-0002lE-0v; Tue, 28 Oct 2025 08:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDj8Q-0002kd-BM
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:49:10 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDj8M-0006vB-1t
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:49:08 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-592f22b1e49so5431146e87.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761655743; x=1762260543; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t6l883tFJpAQf8YAlHanMOkQlY/AtsD2XxeUSoX88Sc=;
 b=ThTLNkrwEs5Yen6WrEdqi7V3mBeBMMy39V0a7KFi6f+1kFGNsrZa1ZnXJZ32lm5ZNi
 RU5xpG7lYT8Qrk5MLxiSm7MYo5lPBVhSwGwANzh1A6U6K88ksNPsW6+xwnDZhSpjvlbe
 WKAlJNUvy9mrFm/E993t9L6K7WrWkvAqgHu7C/+zD5Wg4Gm0D27T2O58qXPyktfC+QME
 2uDlxOm8pV5tW5spjQkighTfhTPLa/c/S3DQvkzlOyGZ2cYHreofyHc9tEFSjVG4Xn5Y
 efMs/p1+gVaqmsNuHoGLf04tYdci0w2oVtVM8FzpOVc2LhC6x8zrYHHH79quhLngacjJ
 PFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761655743; x=1762260543;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t6l883tFJpAQf8YAlHanMOkQlY/AtsD2XxeUSoX88Sc=;
 b=N2AeCDjm2kGQQIb0HBHrCCAFZIPepze70yUpqrroaAmxmQiLm5dfv/1frbyNxofQvv
 z3KwxId449rk5lx68W7eS/623qRdPnBvTDH2Acc3H3xKP6LIAyx4tuhBUbPgKik455br
 JME1/kEq9hRZzIfaEAW2IAGykOtVwt208xDasjnz5WLdUl66m7Q5zpf9kE8oTcYPoWAw
 b28Id0HJ4OP09m5I0N/FyREZDLwvVleLqlcjrjE39iGGb0EKrKokpvdqyL77DdSdQQbk
 ExGXcx5bU12KCd7tP7E6izApBI6Oi/egWYkYaLAtaYpe+qXw1jC2Jn4ZRmsd8Bcxvplu
 MUKw==
X-Gm-Message-State: AOJu0YyGB8Iaq6LQtSPppTQ4pa1EIdxiVOaW2/gdUS53blNsAzvgCh0u
 xXMwwfFIaZ5E4L0wgG8MujAfgxgUEtoT1fTUjRrkfohkTM+0bvN4txsi
X-Gm-Gg: ASbGncv618wMJvoJRQlKAriNCOGLt99E+2P41QVIOqN9T5owmY766Ou9gRZ24sJWiVK
 kFcW2Ly3iR39WWkzCkuFv3mwX0Ls3TtJ3NqSdkXbalnoAMPox3pVuedL2MLUxGSxIksh179CSKB
 8Y7hIZzgsA63X/c9a0+xYG55isu47pOswQwgwaLZiihg86xSMOFj1NsOb9wrD5aPRDxQeLCjiIq
 AjeuAhvMgpJYyLj7a9lTQW5IXC8PLYOjF1/YUQeyp9HNo4lyrNNcNTp80e4vbH7r8QvcdUCF8S4
 jmoLLBcbR6qVSgp5gkXKAQs6Lh7VPcKDXmOOiPNRNFt5873uI8uOIShDJ4ydr6JjQBtt2ukXKC3
 +exlQx4OAy6MNiHBR34po64G7ruH6643LLQEeWE0BmBgCC8aRoSB10FdFOvLU4Pfqu3pJv8nKrD
 uB4q4QYzgRPMr1JYN1Ak4FO92Cgrn3Q/Uvwk2m
X-Google-Smtp-Source: AGHT+IHC3k1jTGxJ5IBzuBvL4mcg9tubmk9jzGOT+Qf3FcXQ/5a9ChnBIHTlFax2lPAaLyfudoR2Rg==
X-Received: by 2002:a05:6512:3b10:b0:592:fcf7:a178 with SMTP id
 2adb3069b0e04-5930e997c5bmr1359279e87.6.1761655742772; 
 Tue, 28 Oct 2025 05:49:02 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59301f41bf3sm3007997e87.20.2025.10.28.05.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 05:49:01 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:49:00 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>,
 xen-devel@lists.xenproject.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 2/3] hw/xen: Replace target_ulong by agnostic
 target_long_bits()
Message-ID: <aQC7vCX4OHElpfDD@zapote>
References: <20251022140114.72372-1-philmd@linaro.org>
 <20251022140114.72372-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022140114.72372-3-philmd@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Oct 22, 2025 at 04:01:12PM +0200, Philippe Mathieu-Daudé wrote:
> Both are equivalent:
> 
>   target_long_bits()
> 
>   sizeof(target_u?long) * BITS_PER_BYTE
> 
> Prefer the former which is target-agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/xen/xen-hvm-common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index 258014370e1..b40ae0b3af0 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -2,8 +2,8 @@
>  #include "qemu/units.h"
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
> +#include "qemu/target-info.h"
>  #include "qapi/error.h"
> -#include "exec/target_long.h"
>  #include "exec/target_page.h"
>  #include "trace.h"
>  
> @@ -455,7 +455,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
>                         req->addr, req->data, req->count, req->size);
>  
>      if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
> -            (req->size < sizeof (target_ulong))) {
> +            (req_size_bits < target_long_bits())) {
>          req->data &= MAKE_64BIT_MASK(0, req_size_bits);
>      }
>  
> -- 
> 2.51.0
> 


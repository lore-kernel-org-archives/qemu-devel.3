Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1BCFF886F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 20:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJdQh-0004jL-TY; Sun, 03 May 2026 16:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1wJbd7-0008NJ-NU
 for qemu-devel@nongnu.org; Sun, 03 May 2026 14:33:26 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1wJbd4-0005BM-UR
 for qemu-devel@nongnu.org; Sun, 03 May 2026 14:33:25 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6530287803cso3320085d50.1
 for <qemu-devel@nongnu.org>; Sun, 03 May 2026 11:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777833201; cv=none;
 d=google.com; s=arc-20240605;
 b=bI2aUN0hOeMwt+Bw3e/NJyeLMm8AzEfzVGEASSnT8jVUsu6YcZiMnkJK8VisaX961J
 qBmOx+7pJnolIMMQtLhvHESxtMT4bYbZg+NDLmRIPQE+8rOTkswcVv0FOFVDr+lJfZXn
 2s09HAvkEx2IYzkeQaAmDNL4F62/FIKuE+YgXiWhAgwr4Z+ApT0Y3balD25+NaK2lBfE
 TlM1jL+zK3CjK168W09KI0OFPa/2EMCIUtqsjjF8CXYfYoG8uE8wey6UBHVbbWJzQQ+J
 0TXk+bK0CfLGGImny4WFBr4SiPbkgTwVgyO1W3b3uOQcIY+h30/GPs2Jm/cQKlArGpft
 nmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TQwmtJXdJsTguNKyFsay641bo2QWAvsULO/Qh88a3VE=;
 fh=u5CRSVc4Lc+SwTZca0vEbo2XafINvI2D/5Ij2LWtY2s=;
 b=E4ygtNFcM64QByTALvm6YCCVVkk255/dwYBvGhaXJmaG2Twj8jYmsn9mDbVUIF9fcr
 zW00YT7mKZSVj32CNTC1Hr5sWzk60CJB+LThWjEROzLGrnB0LW7tZfVAOcELelDDnqA1
 DlxC7NolxYKn9/ivBJGiRknwgxoPNRYoTtQUsLyhInt5SuBtFHkmB8mkHEud0P7tTWH7
 z/l/r+wk9wEYXVj3mS0QwuViI8ZeCSIngOWHKkOEOneusJP8gIKax51hXucNECR4bzVM
 pYQQc+OdF8k/PbSwolLyeOVkkDiqicuSa6sv5a/fUSTb8vfM6hEi6tRsWi+YUCM23XSm
 u01w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=summations-net.20251104.gappssmtp.com; s=20251104; t=1777833201; x=1778438001;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQwmtJXdJsTguNKyFsay641bo2QWAvsULO/Qh88a3VE=;
 b=kfqsIBi1axv0AYmoAXh7dNajo1Q9xbs6V6Jo1OxN6idp7r1bmT1bE01XkgUKN0O80w
 IPFVW1S7xEgS6kgNuI9Cppckf3tvbf1pq6Kj5EiQOztETQVp6XkDS87ewcn5EmILfYmR
 BmxH8jWe+D858ATMTyxZbdaqs8RBDFS3RiuPvUErQz8NImWqLP30GhS1iBTSxLfggsIs
 VAzYjJsUynyIjcoKZg2GKuYcw0snBa3Z8IMJyOxTNBFWFM9+vCQJWDJ3SpAmdglibaz8
 jiTL3f0vJ7yjXX92coaT6lNf6o/z+7K9UpjIGtoattG58VPCZwvV/pSMTtp5wvsaroNK
 /TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777833201; x=1778438001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TQwmtJXdJsTguNKyFsay641bo2QWAvsULO/Qh88a3VE=;
 b=M5KmCNyDEThYw+EUSVO2DhD0+RR3pDpYHGn0bOm4nHKeHN6gaGLISWxxAZ7yJyCMnR
 Y4mFPjIK9KlVVzDqQrJYHnix8rdaFK4sXkn3XGxmWELoDS83gGOlsWjaYAFnCBtWo0m2
 LtrJCzuA8AkceB78Ap1cK7rtFRed2fL3ZZx1fm69wUl+YbOs9GBWnUeXSU/sYkgcHY/j
 CVBZL8byQs20ifJiKWcUtslOGIWZgk0kQTuP+Z7lesPyaAmuZ/lLn7RMCmrTzFXJD7fI
 5MhPd7yJzk7gDahfrANkKNgKU7GrCKJVi5zUx9uTGi5xxCShOUaPHDBuBZYNGEiJoKif
 9q2A==
X-Gm-Message-State: AOJu0Yyhb84zsmVEovqKIx6u0IdM0gulJ9b9cDCm9E/3plYPOoSPxqaF
 yx1EiLcGLcImehpRBu4w7rFSVzVjJ8U+x5xzVNuqSnPhm1SaLwblYe6dPKdeII5OBnTnTD/Kjlt
 wVtdflioxbWL+qSP6mGu3PEc+ZLx1PraAE+rZarRjv9g=
X-Gm-Gg: AeBDievGkevQZ8ZrVe6XJpR6V9A/MXyvDGjSPBx9Kuf+GZPNxP0oFyp10lT/HiBLI77
 MK9IgjatCmJdiS/j/OqEy8aM2F3wYK5exWwHHCBKbVJlwzNtrbWVZvwBWVjRGIh8dPZlI1ylKDP
 y/mu4/UpR1eGpVrjhc5cdhKvUHFtq9U42Lg6Tu7mWmvruprZxmwFv+KrywH6dnmb5OBXp4fzmLI
 eym4s8PqGzXHymfWtp2346WlrRdAsgrQeUAK9dTSs3PQP2Dd6tEnXoNTdxg9pOZX8ZH8s8gOWJu
 lPU9mx8ymndkkqWcVsAvII45bjPwCRGSJMRDhELPwjV62FGk/A==
X-Received: by 2002:a05:690e:bcb:b0:655:5fb4:d275 with SMTP id
 956f58d0204a3-65c3da0c982mr6615483d50.1.1777833200935; Sun, 03 May 2026
 11:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-5-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-5-zhiwei_liu@linux.alibaba.com>
Date: Mon, 4 May 2026 00:03:09 +0530
X-Gm-Features: AVHnY4Jf7ahS7tLVoZ9KwTvztbuH22MPKBQA17NL8aaPUCNUS6kkoCr-tpBTQQo
Message-ID: <CABdD5x=Gu59WtQdmxLRc7vgEryVDX9DfPynWhP8oeZA6C8xWZQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] target/riscv: Implement SMMPT fence instructions
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, alistair23@gmail.com, daniel.barboza@oss.qualcomm.com, 
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=rahul@summations.net; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2026 16:28:35 -0400
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
Reply-to:  Rahul Pathak <rahul@summations.net>
From:  Rahul Pathak via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhiwei

On Thu, Apr 9, 2026 at 12:55=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> This patch completes the SMMPT implementation by adding support for the
> new fence instructions: `mfence.spa` and `minval.spa`.
>
> According to the specification, these instructions act as memory ordering
> fences for MPT updates. In QEMU's TCG model, this is conservatively
> implemented by flushing the entire TLB, which ensures that any subsequent
> memory accesses will re-evaluate permissions and see the effects of any p=
rior
> MPT modifications.
>
> The instructions are privileged and will cause an illegal instruction
> exception if executed outside of M-mode.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/insn32.decode                    |  2 ++
>  .../riscv/insn_trans/trans_privileged.c.inc   | 30 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6e35c4b1e6..84cec57daf 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -120,6 +120,8 @@ sret        0001000    00010 00000 000 00000 1110011
>  mret        0011000    00010 00000 000 00000 1110011
>  wfi         0001000    00101 00000 000 00000 1110011
>  sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> +mfence_spa  1000011    ..... ..... 000 00000 1110011 @sfence_vma
> +minval_spa  0000011    ..... ..... 000 00000 1110011 @sfence_vma
>

SMMTT spec version 0.49 mentions them as mfence.pa and minval.pa

Thanks
Rahul


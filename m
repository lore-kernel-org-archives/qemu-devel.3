Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F7FCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPb17-0003eI-4L; Wed, 20 May 2026 03:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPb0S-0003Zd-W5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:06:24 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPb0Q-0007EK-M0
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:06:16 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso3077919eec.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779260772; x=1779865572; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AHVypqN4bpVt55wueAlXRAEcRd3u6WTdMa3MYoLo8Ps=;
 b=QRBznan0qTIox1QmWOuD0/fES1IASfqGVb0C2siAx9J1NETvV8wTzyrK8R6hS0wufd
 AV6tlNCMpT85vZRCJMuHpJqj2SF06qwL1M28vIzPnxB36jH8kYfD5MkTYKOeG2ulA+K5
 GEH9IGPAhoFGtPlCOZi6hSs/uZrTksODhN6opVyLjNnFylN34rjPiNtQocKlxSIHEA+6
 acfPEQsj/jo6oqnzCNJ3c3dUiJ8Ue8dkhxYBxQKS7Jddm6k84GkB0HSEfiImrSJ4juCz
 8RC/9GSVQVqCvY/XM7sccz6rFV8ts4S3MjlgJWGahn/ryMoM+GME7xJ1SacCM2GgBuyE
 ocrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779260772; x=1779865572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHVypqN4bpVt55wueAlXRAEcRd3u6WTdMa3MYoLo8Ps=;
 b=CJOn51Osj8Am7TOBz/UvVwaByjgj9A+GO7Qn2xK3wF9GtI/DQImxDyyzE9p+JvsbxT
 +Oud7FHpZcZLPccfZZxPaCKIrK7g8vPx2CR3UKHUQ+LhCvOVSRTfWlP/y8D4Njf08kiC
 4SJ6i3+sAX2u9mxFVnvPvd13nY609AnRDqnCtK70b+awhBg0sQLjHXkVcyCTsqTGiIHc
 PvawQhYWVwwWTijT2psLP+J91jNLNMCGa0EW4AT4rFZy7Z8cfR23lQ6zbE4wVqOzlmeW
 csGD5yw+lMdzPKlRKWez/jn1RLc5n2AT48TsjE7CY0zJ2LO66tWx/VE2WKaOvsihDBVM
 Ya2g==
X-Gm-Message-State: AOJu0YwoZvRyscSwSH3rsRQFjL/BqoZa8tensUQ23s5HL8rln2uTlsn6
 JBnsVq+BktO4EJ4OJH2+jWtgjPeMnFmA3R0AvYbxDhcjgSm4qxVByliz
X-Gm-Gg: Acq92OEH/kmI40Hx90B15sIQb5T5sMk6fV6vL9kGbXoF8wR8k+163+GpY2xKkqOeybG
 kpIU5cxXXCafiw5TJoH5OsRqtti4M3RzMeO8zzHfFB7XMpClLN07s/y79DWnoEIWHrFTmmZ8bC9
 FxJ+JMCzoe9vS+Xd33MfacB/wrjaZdK+PGmmGFIDA1mHPDJ/+mx14aX1120zKjQWXY4HTjxS0/c
 FLU2wYtYPze1PWczJiGIYUPenZ1pmPWgV+ctoU3kzZZKOAZPqjB50ouaB2wG4vsZf4Zv+IBMPbr
 B95j3Mf0zAPbxq1vwjtkniBwVXGfJNZ6ekzJ5GFJlh4eJltnvfzw2JjubmvHR1lh/dNBP5NQSG/
 lwXaQX3Ty17ZdCpZHB0Ptj2FGIK9jQi2ng2QgBsMSBPPwJ5LC7IDSdy9cEeGiuENS8TcyvvtKVk
 YjcLwHe2nGbXADuVNJOPVQXWkR0JZsVCp8Yx0g+0gldDntlCS3Za/GrubFn64=
X-Received: by 2002:a05:7300:3212:b0:2ef:e4:c912 with SMTP id
 5a478bee46e88-3026050ce16mr11829793eec.9.1779260772157; 
 Wed, 20 May 2026 00:06:12 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6c3sm22632730eec.19.2026.05.20.00.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:06:11 -0700 (PDT)
Date: Wed, 20 May 2026 15:06:09 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 2/2] target/riscv: Improve PMP address alignment
 readability
Message-ID: <ag1dVm-bG_bOJwJC@ChaodeMacBook-Pro.local>
References: <20260520063606.36600-1-jay.chang@sifive.com>
 <20260520063606.36600-3-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520063606.36600-3-jay.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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

On Wed, May 20, 2026 at 02:36:06PM +0800, Jay Chang wrote:
> Replace manual bit manipulation for better readability:
> 
> - TOR: Use ROUND_DOWN() to clear lower bits
> - NAPOT: Use deposit64() to set lower bits
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/pmp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 8adf7c9719..58a8923d0d 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -247,8 +247,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>      case PMP_AMATCH_TOR:
>          /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
>          if (g >= 1) {
> -            prev_addr &= ~((1ULL << g) - 1ULL);
> -            this_addr &= ~((1ULL << g) - 1ULL);
> +            uint64_t granule = 1ULL << g;
> +            prev_addr = ROUND_DOWN(prev_addr, granule);
> +            this_addr = ROUND_DOWN(this_addr, granule);
>          }
>          if (prev_addr >= this_addr) {
>              sa = ea = 0u;
> @@ -641,13 +642,14 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>          case PMP_AMATCH_TOR:
>              /* Bit [g-1:0] read all zero */
>              if (g >= 1 && g < TARGET_LONG_BITS) {
> -                val &= ~((1ULL << g) - 1ULL);
> +                uint64_t granule = 1ULL << g;
> +                val = ROUND_DOWN(val, granule);
>              }
>              break;
>          case PMP_AMATCH_NAPOT:
>              /* Bit [g-2:0] read all one */
>              if (g >= 2 && g < TARGET_LONG_BITS) {
> -                val |= ((1ULL << (g - 1)) - 1ULL);
> +                val = deposit64(val, 0, g - 1, -1ULL);
>              }
>              break;
>          default:
> -- 
> 2.48.1
> 


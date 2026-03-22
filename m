Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D5AFC72AE
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 06:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Ci1-0006PQ-0P; Sun, 22 Mar 2026 02:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4Chz-0006P6-VD
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 02:54:47 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w4Chy-0006AU-JK
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 02:54:47 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2c0ea57fea7so3730616eec.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774162485; x=1774767285; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lR4Lg5WMiC3gZZ1RZp8LEYhSlBo/OHfy5DCH0SCfqHQ=;
 b=a4rOiamPlOrbalogjrE7+zZUPc6Qk8FNHUA8sGrqgYCiv1C1j7QLmQY4xDSj1SHXGB
 GQZwjR5QqZPHD6zqA5YMMRsr3DFVl7xnk4eDc3rsnX6hCpajUvxU+Lp27WcXtCfjbqKm
 K6r/1ndQDRM+VfVxGr6Snd30PSKL/gvfJL6bfkTMttWfmc2Vu1U78aZLIyOJSKvGHTqI
 jay0/aXM2U04HnYlr3cgGfLqCpc91nvJeIaFc9sJY/bAmE6CjZEE60Q987ylgmeiietl
 ZuxbzgXo1jzomB69wdAaxPjrh4q3N4V4Bgifg+WbteWQU2E/GvW4fMaNSwU1iW7PzPvY
 Lrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774162485; x=1774767285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lR4Lg5WMiC3gZZ1RZp8LEYhSlBo/OHfy5DCH0SCfqHQ=;
 b=lniwBh3WjX2eu3608Je7cO+XoEMLmqBrmFWPlRpecuoP3ubOq1FRVCzs/1lHkpcBb8
 jwXlQw23XOXmj/NRIa6VPoEqTz807w6E1nz7lNWt97b981bQRCtUxC2Vu68mN4rByQ7S
 /ac/HbqHbIMyOZVZjsFU2L4tArX+gMlSuX+2KL8Iv3aT3aYC3KVsItiobq5wOibA2z/Z
 LJN7c617e3AZwGk2nGH2h7xVr1RmuXdcclVApG31tITDzGuETPLg+gJXtSrkPntUgqRk
 9andzY7q6c0kJWE5j8TV1ToDVMppRimvNTJ0kCc2we/bVi4TjB4oftiDMW/T3KGkFM1B
 xR1Q==
X-Gm-Message-State: AOJu0YyIS+zHWdN5ztDwo8OTo/wdgsdezNFmef08HQSyopiOwCPgcORS
 6IkAi9WMPXUZ4XvQn9I2h1jDMlvyB71ZGnt4i4MLzMAUbb0aAq0HblC6
X-Gm-Gg: ATEYQzxbyjVoi5bG0++VzoFuS5HZMyNzJxQbCUGEpLWg2aJiBm8xcC5axoFzPZA09xJ
 baRatPTlOL/DCdcFoswlDXC5snutT2XfhyJ5uLfHmb5ze/aQe/siF/9ObVFJMcTYKVe/XWd/TxS
 XUNiZhXqVzdJBNr/NqSpQy32hZ1ESbKzqgeldEiKlkdpGo6pp5YXwdK6RTVYZxUXO5+kiDrQz15
 G/cTn7AUM5Z/7S/mfHQ7AnQOj2uxyEADna/cKtKAge9TI6bgwYrUpeuTuvCXfoj0AWRbQpJeCdM
 93WziFfcPxVV9JR5rEatwDl0MyGGP32yseFbq4XGYAInA8IgKgXLl1QsN6vU16pAgafmeWS3q7N
 IcQXXgeEbO2u7izKe4TZH7tjDUcW6IBINDqfzNN1j386MhBM1qzm/K/j9TZdQMoz00iKlx47C4A
 dRGGLGZAUHPAiqpW30YJ1eIlaexBiUkjllelpLUmhByvy6lq1G9p1AiADI+0NrwFBwqb8Kwzk49
 nOEZDaq6BEiji74xFa08/uGAbYBi1s=
X-Received: by 2002:a05:7023:b14:b0:128:bd5b:61f6 with SMTP id
 a92af1059eb24-12a726dd98emr3161154c88.35.1774162484738; 
 Sat, 21 Mar 2026 23:54:44 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b2d673asm10851401eec.24.2026.03.21.23.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 23:54:44 -0700 (PDT)
Date: Sun, 22 Mar 2026 14:54:31 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 2/3] linux-user: Fix unlock_user API usage
Message-ID: <ab-Q2znE0qdtTRsT@ZEVORN-PC.localdomain>
References: <20260321004836.500390-1-npiggin@gmail.com>
 <20260321004836.500390-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321004836.500390-3-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Mar 21, 2026 at 10:48:35AM +1000, Nicholas Piggin wrote:
> Fix errors in unlock_user() calls:
> - unlock_user() with len=1 instead of len=written
> - unlock_user() with len=1 instead of len=0
> - unlock_user() with len=0 instead of len=1
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  linux-user/linuxload.c | 2 +-
>  linux-user/syscall.c   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
> index 85d700953e..79416a94c9 100644
> --- a/linux-user/linuxload.c
> +++ b/linux-user/linuxload.c
> @@ -19,7 +19,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src, unsigned long len)
>          return -TARGET_EFAULT;
>      }
>      memcpy(host_ptr, src, len);
> -    unlock_user(host_ptr, dest, 1);
> +    unlock_user(host_ptr, dest, len);
This fixes the writeback -- old code had 0 which meant
no flush at all, so getsockopt results were silently
lost under CONFIG_DEBUG_REMAP.

Minor observation: getsockopt returns actual bytes in
lv, so using lv rather than len would be more precise.
That said, the swap loop above also uses len, so this
is consistent with the existing code.
>      return 0;
>  }
>  
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7832a1aba5..13b8bd9ed3 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2989,7 +2989,7 @@ get_timeout:
>              if (put_user_u32(lv, optlen)) {
>                  return -TARGET_EFAULT;
>              }
> -            unlock_user(results, optval_addr, 0);
> +            unlock_user(results, optval_addr, len);
>              break;
>          }
>  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
> @@ -4006,7 +4006,7 @@ static inline abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
>          __put_user((*host_array)[i], &array[i]);
>      }
>      g_free(*host_array);
> -    unlock_user(array, target_addr, 1);
> +    unlock_user(array, target_addr, nsems * sizeof(unsigned short));
>  
>      return 0;
>  }
> @@ -7888,7 +7888,7 @@ static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
>      host_sevp->sigev_notify = tswap32(target_sevp->sigev_notify);
>      host_sevp->sigev_notify_thread_id = tswap32(target_sevp->_sigev_un._tid);
>  
> -    unlock_user_struct(target_sevp, target_addr, 1);
> +    unlock_user_struct(target_sevp, target_addr, 0);
Right. This function only reads from target, so
copy=0 (no writeback) is the correct semantic.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
>      return 0;
>  }
>  
> -- 
> 2.51.0
> 
> 


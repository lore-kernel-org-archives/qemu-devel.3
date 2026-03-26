Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570E7109E557
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5e53-000209-KF; Thu, 26 Mar 2026 02:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5e4y-0001yX-8y
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:20:29 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5e4w-0000aK-Gu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:20:27 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c742b9b7727so190185a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 23:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774506025; x=1775110825; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uKJ2G65+6Az6+JvUTRTolTiEc6IYP2qfOIB7SaIBEnY=;
 b=W4eJv+KcmKi6fXzjfDwTC9Hu790KwuB8A2tWmBgAZ6nxz0bGgEmEoZs2KLU5s0MvHR
 /ETJKkkOvA8Nidwq5HDqLIBbuqbvLq/2r71WfQUVOZfUb5gXCsavEk3ZOQx0/SxDLw81
 z3KVBHrOT47OjwPDK6wn2Vox0XeiBSIyRtox2QZSbGsZY41xCqS448Uzp5k9Oe1T7/1I
 RzV1aCcREEjpTPAAeTcsr1NIFfYHAG83ycpOe3MNYOp6yyTwnNDEi5pbL+s+75De+n5Z
 8VEYiS3rcQPCBd4xu9xXIgT0sY2529bJvpGV2hoQzQLwDJX/7QmQ1QopLw+xQapiqaSQ
 dwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774506025; x=1775110825;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uKJ2G65+6Az6+JvUTRTolTiEc6IYP2qfOIB7SaIBEnY=;
 b=kBG7NM98cJXlI/TscLQPqGdKBkH+MKdkhYRv9ZML7DlqHzz9/n/Y3YCXiGnvuSyi/b
 D67A7yMEpCM0ZueLfFqmQoxMesZApWFAPISViv4ZFh/M02E1/NJt5ixGoKrdhT3JvP9M
 M5rrEoM4uWHZhRBXlsv3VyWaZIMu9gtxaeSj5jb0KxoyjA0gCZgZBqILvyPUeVaMulo1
 na9pZT0Qgs4cQONaCNIP5DAU5q+icIO+nN5ZkdgKqJwuyAjZlU//SuOKMphY3JEpJq6r
 t5pVUI/E51RVG91uVdEO2ctCF+YhuOor3H35tFPe8eR1Js/b2JmDr97FAafv8B8Yzx2j
 yuMQ==
X-Gm-Message-State: AOJu0YyZ0YpU2zrdMpR3/lofMh68TPdvbEh9BURYpm+P7cB+4R4M00mv
 2LHMyhzyA08XUzaVieFqAj3LrXyobBvANd6zsaZ+Tp7dYfBaugF1gUNe
X-Gm-Gg: ATEYQzwgUIOxfgP5HUrg5YhEj021Xt6XWjzjnSFe2IxRIC9lkduZTlXGuYsYHa8S3nG
 poSKxO3I+cdd1TPnIYG0OHRoNchbvVjaR4sB1nhLfdjgf5umE7e/NmEECn5ruimLIkaMFgot/qR
 YOJMQLKT4qIkU2VkgryzgteGJ0LmmHBhM4wsekBvDkwRjN8oHe87ztZlTNG9K+rhX0S1xD6DvZw
 3PU6gP9NWLmcOJW+qIgaxldzPO32JcsAaDzY06chDFaQ0cZ0mANus5xsHiBx/yI3+VAfF0EDbN+
 JSxTPugP4zBUloD/UuR2niXoSZc9X7HaRlKIOs3NHc6T05mEU+JiCLmklc4zEoD2sZWX+/P39QG
 EN1k7gbzkP/4rYOPiZONp88M9Gdej4IR1Uh4A5/jhlU5emcz6PkbxXUYPo3gc0ji1q71LobNDap
 StpQvS9rQ1OXbiFfSUlRsIT5esa/3oSIvkjg15q121frShbqJ9SLlIcbgicExK2/HJ
X-Received: by 2002:a05:6a20:4307:b0:39c:4e62:b843 with SMTP id
 adf61e73a8af0-39c7354cbd9mr507784637.10.1774506024649; 
 Wed, 25 Mar 2026 23:20:24 -0700 (PDT)
Received: from localhost (103.95.112.190.qld.leaptel.network. [103.95.112.190])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm1197650a12.21.2026.03.25.23.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 23:20:23 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:20:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH 2/3] linux-user: Fix unlock_user API usage
Message-ID: <acTL0apZ1s0UO5Xs@lima-default>
References: <20260321004836.500390-1-npiggin@gmail.com>
 <20260321004836.500390-3-npiggin@gmail.com>
 <CAKmqyKMifRr3bhRrApJEzRTi5UvHsr8TF7uOeOP-+nJL7fU6Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMifRr3bhRrApJEzRTi5UvHsr8TF7uOeOP-+nJL7fU6Ng@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

On Wed, Mar 25, 2026 at 11:46:45AM +1000, Alistair Francis wrote:
> On Sat, Mar 21, 2026 at 10:50 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Fix errors in unlock_user() calls:
> > - unlock_user() with len=1 instead of len=written
> > - unlock_user() with len=1 instead of len=0
> > - unlock_user() with len=0 instead of len=1
> 
> Can you explain what the errors are and why this fixes them?
> 
> At least to me (I don't know the linux-user stuff very well) I don't
> understand what is being fixed here

Yeah I should explain a bit better in the changelog.

When CONFIG_DEBUG_REMAP=n, lock_user just validates the guest
pointer is within the guest address space and gives you a pointer
to host address that can be used with __get_user() etc. And
unlock_user does nothing, which is why it accumulated all these
errors.

With CONFIG_DEBUG_REMAP=y, they allocate a separate area of
memory for the host to work in, and that's the host pointer you
get to work with. The lock is supposed to say if it reads the
memory and if so it is copied in to your temp area. The unlock
says the length written to and it copies it out from temp area
back to guest image. End result is guest memory updates from
syscalls don't take effect.

The APIs are a bit clunky, might be able to be improved with
minor changes. Biggest help would be to run DEBUG_REMAP=y from
time to time in CI.

Thanks,
Nick

> 
> Alistair
> 
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  linux-user/linuxload.c | 2 +-
> >  linux-user/syscall.c   | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
> > index 85d700953e..79416a94c9 100644
> > --- a/linux-user/linuxload.c
> > +++ b/linux-user/linuxload.c
> > @@ -19,7 +19,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src, unsigned long len)
> >          return -TARGET_EFAULT;
> >      }
> >      memcpy(host_ptr, src, len);
> > -    unlock_user(host_ptr, dest, 1);
> > +    unlock_user(host_ptr, dest, len);
> >      return 0;
> >  }
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 7832a1aba5..13b8bd9ed3 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -2989,7 +2989,7 @@ get_timeout:
> >              if (put_user_u32(lv, optlen)) {
> >                  return -TARGET_EFAULT;
> >              }
> > -            unlock_user(results, optval_addr, 0);
> > +            unlock_user(results, optval_addr, len);
> >              break;
> >          }
> >  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 2, 0) */
> > @@ -4006,7 +4006,7 @@ static inline abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
> >          __put_user((*host_array)[i], &array[i]);
> >      }
> >      g_free(*host_array);
> > -    unlock_user(array, target_addr, 1);
> > +    unlock_user(array, target_addr, nsems * sizeof(unsigned short));
> >
> >      return 0;
> >  }
> > @@ -7888,7 +7888,7 @@ static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
> >      host_sevp->sigev_notify = tswap32(target_sevp->sigev_notify);
> >      host_sevp->sigev_notify_thread_id = tswap32(target_sevp->_sigev_un._tid);
> >
> > -    unlock_user_struct(target_sevp, target_addr, 1);
> > +    unlock_user_struct(target_sevp, target_addr, 0);
> >      return 0;
> >  }
> >
> > --
> > 2.51.0
> >
> >
> 


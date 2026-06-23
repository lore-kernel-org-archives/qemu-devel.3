Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53550CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6B4-00039U-AA; Tue, 23 Jun 2026 14:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6Aa-00037k-Cm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc6AW-0001rZ-5C
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8453bcf7276so210346b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782240497; x=1782845297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LpCAXpD+MkKgnvvBW8R+UzYze+YwiyF0BSaFVwLMmxk=;
 b=kvmYgXXCXXXAFviVwEetKIDXqpNZ7utWPjNDh6Rvx6N06M86ZaIql7g4RIUl9aXrMM
 QjdsH3BnFbs9Sg+3pcoKSRzqGKJQ8zZIN8vAjJ5ZiADDKnVeVlm4WZu6I6M+foxfKs4T
 dQVrYJggT6G49nNdU6zBocNZtto0DeukDYkcbU8bwXKg6JviIqhgY/rQLJAhTCXGVvCw
 w+g+5uYjSxPe22pow20Aluo3unCDqncLHv9grAOkeJjJS7yhelfBeUR4o93L4tx8kFO6
 1yNWf0Fv5YYiXQj9js3RsAl4KX/x3nYBypWwW1sA2JMEcmkrVJyy13eNMPQU44F5XWlD
 2MJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782240497; x=1782845297;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LpCAXpD+MkKgnvvBW8R+UzYze+YwiyF0BSaFVwLMmxk=;
 b=YD5YwaLtry78GfeYCGbjbkRj2QrFFnbjo2YKQ8wxOOjUa0GRrP4tlAPzZmlxPL7tau
 W0pWuXRnRDJA1DU6A/nchgYlnUMAGCgRIaxnCLLyatw721FaL5Wr5fw/LM0Q2S7h3lFi
 oqe6LZ12njWFFLbGrYJLVTtvRL6KuVLGWbdzSw0KSyh46Xz64QNI+hIWKOrB5LZrtjBn
 QIoVWHbEc/pOEn3D6hndzlwbDwhvyPSNh8DgYApEP1lfVSiHxNHi7ERFJt+oxiHuZP75
 oknVxqouAuKQt1b0AtVAPKG0iLQRjCXnOp/ODh79ieuF18DcWH/SCSsFOI+HJNM4dB9a
 tJFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xv64RCIG2B2MZJa2KOtwkyvDGIS2EJeYiSKJKeeyfVQ2vD7Oq5LCal10T7QRwXSNIufZVAYqCYD7Q@nongnu.org
X-Gm-Message-State: AOJu0YxK4uBpnnRq5OmYSCkxjD5N/wedNS3+LsFbtqJe7ksUWfTL/Rmw
 oZBQu3ZH45dsdKw7oWUbuJzKsLvO4j3piMTKh0tSpBWoAbvwqHlMhK6jQ9wwoKZnw/I=
X-Gm-Gg: AfdE7cmhruEJbS2J3TKifBIM1qymNQZX9t+L+kA4SDeV1P9kS4jBvZfDp2BtmpgDi5Z
 XwI8kZsCcgRddlm5fAQsqYKTmAuNVOFKJPnV7worEIl01gleATigkTma9D/cTsrbnZyYM8iMejb
 N0F/f3h1e7866fdsWPvCVGhoE0rilEsIUsNHGWff5/KF1uYyIY92JKoAikl2A1UClsgHm7UrOv6
 t+rXyRG3Nj3csFgO+pJs0TlBlOn8xXe7ZpB8V9dvELWCy/Oeh1+XEKPpA9iyS7rAhv3QuD1Hlj7
 jAMd17As0TmXgmxLQWQpo0uAofipR6LwQpxf+MpJbwtliI3ZvHZoPaa3MRpGDG8Gh8XYCDjefRH
 zbagkfxdFN1ouBTSUwD/g2bBM+5cBxL1fe9MSqTu/g3Hx8rmee/Oj2HD3hSHEHjuKoi9y5Uwfx/
 4+YpQNTp5OAMZ8suoaVCvDQl1tZTpbZRyERkqIZEtRTaIifIjzuoxODMIQWg==
X-Received: by 2002:a05:6a00:bc10:b0:841:dcb5:e6f9 with SMTP id
 d2e1a72fcca58-845a2abdademr331349b3a.11.1782240497250; 
 Tue, 23 Jun 2026 11:48:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564d8d13dsm11238386b3a.23.2026.06.23.11.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 11:48:16 -0700 (PDT)
Message-ID: <b1e6df25-5edb-4041-98ca-7beb1102487f@linaro.org>
Date: Tue, 23 Jun 2026 11:48:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/40] bsd-user: Add poll, lseek, pipe, and swap system
 call shims
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stacey Son <sson@FreeBSD.org>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-8-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-8-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/20/26 21:19, Warner Losh wrote:
> Add do_bsd_poll, do_bsd_lseek, do_bsd_pipe, do_bsd_swapon,
> do_freebsd13_swapoff, and do_bsd_swapoff to bsd-file.h. Also add
> target_pollfd structure to syscall_defs.h and include poll.h in
> os-syscall.c.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Assisted-by: Claude Opus 4.6 (1M context)
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-file.h           | 136 +++++++++++++
>   bsd-user/freebsd/os-syscall.c |   1 +
>   bsd-user/syscall_defs.h       | 458 ++++++++++++++++++++++++++++++++++++------
>   3 files changed, 534 insertions(+), 61 deletions(-)
> 
> diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
> index 7ef9470c4e..0fefc07232 100644
> --- a/bsd-user/bsd-file.h
> +++ b/bsd-user/bsd-file.h
> @@ -55,6 +55,10 @@ ssize_t safe_pwrite(int fd, void *buf, size_t nbytes, off_t offset);
>   ssize_t safe_writev(int fd, const struct iovec *iov, int iovcnt);
>   ssize_t safe_pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset);
>   
> +int safe_ppoll(struct pollfd *fds, nfds_t nfds,
> +               const struct timespec *restrict timeout,
> +               const sigset_t *restrict newsigmask);
> +
>   /* read(2) */
>   static abi_long do_bsd_read(abi_long arg1, abi_long arg2, abi_long arg3)
>   {
> @@ -925,4 +929,136 @@ static abi_long do_bsd_undelete(abi_long arg1)
>       return ret;
>   }
>   
> +/* poll(2) */
> +static abi_long do_bsd_poll(abi_long arg1, abi_long arg2, abi_long arg3)
> +{
> +    abi_long ret;
> +    nfds_t i, nfds = arg2;
> +    int timeout = arg3;
> +    struct pollfd *pfd;
> +    struct target_pollfd *target_pfd;
> +    struct timespec ts, *pts = NULL;
> +
> +    target_pfd = lock_user(VERIFY_WRITE, arg1,
> +            sizeof(struct target_pollfd) * nfds, 1);
> +    if (!target_pfd) {
> +        return -TARGET_EFAULT;
> +    }
> +    pfd = alloca(sizeof(struct pollfd) * nfds);

We shouldn't be using alloca (or even g_malloc) with a parameter controlled by the guest.

Do you want to diagnose EINVAL for nfds > RLIMIT_NOFILE before first use?


> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index 0612be8bbb..833c7509e3 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -42,26 +42,6 @@ struct target_ipc_perm {
>   #define TARGET_IPC_SET  1   /* set options */
>   #define TARGET_IPC_STAT 2   /* get options */
>   
> -/*
> - * sys/shm.h
> - */
> -struct target_shmid_ds {
> -    struct  target_ipc_perm shm_perm; /* peration permission structure */
> -    abi_ulong   shm_segsz;  /* size of segment in bytes */
> -    int32_t     shm_lpid;   /* process ID of last shared memory op */
> -    int32_t     shm_cpid;   /* process ID of creator */
> -    int32_t     shm_nattch; /* number of current attaches */
> -    target_time_t shm_atime;  /* time of last shmat() */
> -    target_time_t shm_dtime;  /* time of last shmdt() */
> -    target_time_t shm_ctime;  /* time of last change by shmctl() */
> -};
> -
> -#define N_BSD_SHM_REGIONS   32
> -struct bsd_shm_regions {
> -    abi_long start;
> -    abi_long size;
> -};
> -
>   /*
>    * sys/sem.h
>    */
> @@ -93,6 +73,26 @@ struct target_semid_ds {
>       target_time_t   sem_ctime;  /* times measured in secs */
>   };
>   
> +/*
> + * sys/shm.h
> + */
> +struct target_shmid_ds {
> +    struct  target_ipc_perm shm_perm; /* peration permission structure */
> +    abi_ulong   shm_segsz;  /* size of segment in bytes */
> +    int32_t     shm_lpid;   /* process ID of last shared memory op */
> +    int32_t     shm_cpid;   /* process ID of creator */
> +    int32_t     shm_nattch; /* number of current attaches */
> +    target_time_t shm_atime;  /* time of last shmat() */
> +    target_time_t shm_dtime;  /* time of last shmdt() */
> +    target_time_t shm_ctime;  /* time of last change by shmctl() */
> +};
> +
> +#define N_BSD_SHM_REGIONS   32
> +struct bsd_shm_regions {
> +    abi_long start;
> +    abi_long size;
> +};
> +
>   /*
>    * sys/msg.h
>    */
> @@ -118,23 +118,26 @@ struct target_msgbuf {
>       char        mtext[1];   /* body of message */
>   };
>   
> +/*
> + * sched.h
> + */
> +struct target_sched_param {
> +        int32_t sched_priority;
> +};
> +
>   /*
>    *  sys/mman.h
>    */
>   #define TARGET_MADV_DONTNEED            4       /* dont need these pages */
>   
> -#define TARGET_FREEBSD_MAP_RESERVED0080 0x0080  /* previously misimplemented */
> -                                                /* MAP_INHERIT */
> -#define TARGET_FREEBSD_MAP_RESERVED0100 0x0100  /* previously unimplemented */
> -                                                /* MAP_NOEXTEND */
> -#define TARGET_FREEBSD_MAP_STACK        0x0400  /* region grows down, like a */
> -                                                /* stack */
> -#define TARGET_FREEBSD_MAP_NOSYNC       0x0800  /* page to but do not sync */
> -                                                /* underlying file */
> +#define MAP_TYPE 0xf
>   
> +/* XXX These are needed by mmap.c until it is updated to match blitz */
> +#define TARGET_FREEBSD_MAP_RESERVED0080 0x0080
> +#define TARGET_FREEBSD_MAP_RESERVED0100 0x0100
> +#define TARGET_FREEBSD_MAP_STACK        0x0400
> +#define TARGET_FREEBSD_MAP_NOSYNC       0x0800
>   #define TARGET_FREEBSD_MAP_FLAGMASK     0x1ff7
> -
> -/* XXX */
>   #define TARGET_BSD_MAP_FLAGMASK         0x3ff7
>   
>   /*
> @@ -142,8 +145,6 @@ struct target_msgbuf {
>    * sys/timex.h
>    */
>   
> -typedef abi_long target_freebsd_suseconds_t;
> -
>   /* compare to sys/timespec.h */
>   struct target_freebsd_timespec {
>       target_time_t   tv_sec;     /* seconds */
> @@ -165,12 +166,75 @@ struct target_freebsd__umtx_time {
>   
>   struct target_freebsd_timeval {
>       target_time_t       tv_sec; /* seconds */
> -    target_freebsd_suseconds_t  tv_usec;/* and microseconds */
> +    target_suseconds_t  tv_usec;/* and microseconds */
>   #if !defined(TARGET_I386) && TARGET_ABI_BITS == 32
>       abi_long _pad;
>   #endif
>   };
>   
> +/* compare to sys/timex.h */
> +struct target_freebsd_ntptimeval {
> +    struct target_freebsd_timespec  time;
> +    abi_long    maxerror;
> +    abi_long    esterror;
> +    abi_long    tai;
> +    int32_t     time_state;
> +};
> +
> +struct target_freebsd_itimerspec {
> +    struct target_freebsd_timespec it_interval;
> +    struct target_freebsd_timespec it_value;
> +};
> +
> +struct target_freebsd_timex {
> +    uint32_t    modes;
> +    abi_long    offset;
> +    abi_long    freq;
> +    abi_long    maxerror;
> +    abi_long    esterror;
> +    int32_t     status;
> +    abi_long    constant;
> +    abi_long    precision;
> +    abi_long    tolerance;
> +
> +    abi_long    ppsfreq;
> +    abi_long    jitter;
> +    int32_t     shift;
> +    abi_long    stabil;
> +    abi_long    jitcnt;
> +    abi_long    calcnt;
> +    abi_long    errcnt;
> +    abi_long    stbcnt;
> +};
> +
> +/* Maxiumum of 32 active POSIX timers allowed at any one time. */
> +extern int g_posix_timers[32];
> +
> +#define TIMER_MAGIC 0x0caf0000
> +#define TIMER_MAGIC_MASK 0xffff0000
> +
> +/*
> + * sys/event.h
> + */
> +struct target_freebsd11_kevent {
> +    abi_ulong  ident;
> +    int16_t    filter;
> +    uint16_t   flags;
> +    uint32_t   fflags;
> +    abi_long   data;
> +    abi_ulong  udata;
> +};
> +
> +struct target_freebsd_kevent {
> +    abi_ulong  ident;
> +    int16_t    filter;
> +    uint16_t   flags;
> +    uint32_t   fflags;
> +    int64_t data;
> +    abi_ulong  udata;
> +    uint64_t  ext[4];
> +};
> +
>   /*
>    *  sys/resource.h
>    */
> @@ -219,6 +283,154 @@ struct target_freebsd__wrusage {
>       struct target_freebsd_rusage wru_children;
>   };
>   
> +/*
> + * sys/socket.h
> + */
> +
> +/*
> + * Types
> + */
> +#define TARGET_SOCK_STREAM      1   /* stream socket */
> +#define TARGET_SOCK_DGRAM       2   /* datagram socket */
> +#define TARGET_SOCK_RAW         3   /* raw-protocol interface */
> +#define TARGET_SOCK_RDM         4   /* reliably-delivered message */
> +#define TARGET_SOCK_SEQPACKET   5   /* sequenced packet stream */
> +
> +
> +/*
> + * Option flags per-socket.
> + */
> +
> +#define TARGET_SO_DEBUG         0x0001  /* turn on debugging info recording */
> +#define TARGET_SO_ACCEPTCONN    0x0002  /* socket has had listen() */
> +#define TARGET_SO_REUSEADDR     0x0004  /* allow local address reuse */
> +#define TARGET_SO_KEEPALIVE     0x0008  /* keep connections alive */
> +#define TARGET_SO_DONTROUTE     0x0010  /* just use interface addresses */
> +#define TARGET_SO_BROADCAST     0x0020  /* permit sending of broadcast msgs */
> +#define TARGET_SO_USELOOPBACK   0x0040  /* bypass hardware when possible */
> +#define TARGET_SO_LINGER        0x0080  /* linger on close if data present */
> +#define TARGET_SO_OOBINLINE     0x0100  /* leave received OOB data in line */
> +#define TARGET_SO_REUSEPORT     0x0200  /* allow local address & port reuse */
> +#define TARGET_SO_TIMESTAMP     0x0400  /* timestamp received dgram traffic */
> +#define TARGET_SO_NOSIGPIPE     0x0800  /* no SIGPIPE from EPIPE */
> +#define TARGET_SO_ACCEPTFILTER  0x1000  /* there is an accept filter */
> +#define TARGET_SO_BINTIME       0x2000  /* timestamp received dgram traffic */
> +#define TARGET_SO_NO_OFFLOAD    0x4000  /* socket cannot be offloaded */
> +#define TARGET_SO_NO_DDP        0x8000  /* disable direct data placement */
> +
> +/*
> + * Additional options, not kept in so_options.
> + */
> +#define TARGET_SO_SNDBUF        0x1001  /* send buffer size */
> +#define TARGET_SO_RCVBUF        0x1002  /* receive buffer size */
> +#define TARGET_SO_SNDLOWAT      0x1003  /* send low-water mark */
> +#define TARGET_SO_RCVLOWAT      0x1004  /* receive low-water mark */
> +#define TARGET_SO_SNDTIMEO      0x1005  /* send timeout */
> +#define TARGET_SO_RCVTIMEO      0x1006  /* receive timeout */
> +#define TARGET_SO_ERROR         0x1007  /* get error status and clear */
> +#define TARGET_SO_TYPE          0x1008  /* get socket type */
> +#define TARGET_SO_LABEL         0x1009  /* socket's MAC label */
> +#define TARGET_SO_PEERLABEL     0x1010  /* socket's peer's MAC label */
> +#define TARGET_SO_LISTENQLIMIT  0x1011  /* socket's backlog limit */
> +#define TARGET_SO_LISTENQLEN    0x1012  /* socket's complete queue length */
> +#define TARGET_SO_LISTENINCQLEN 0x1013  /* socket's incomplete queue length */
> +#define TARGET_SO_SETFIB        0x1014  /* use this FIB to route */
> +#define TARGET_SO_USER_COOKIE   0x1015  /* user cookie (dummynet etc.) */
> +#define TARGET_SO_PROTOCOL      0x1016  /* get socket protocol (Linux name) */
> +
> +/* alias for SO_PROTOCOL (SunOS name) */
> +#define TARGET_SO_PROTOTYPE     TARGET_SO_PROTOCOL
> +
> +/*
> + * Level number for (get/set)sockopt() to apply to socket itself.
> + */
> +#define TARGET_SOL_SOCKET       0xffff  /* options for socket level */
> +
> +#ifndef CMSG_ALIGN
> +#define CMSG_ALIGN(len) (((len) + sizeof(long) - 1) & ~(sizeof(long) - 1))
> +#endif
> +
> +/*
> + * sys/socket.h
> + */
> +struct target_msghdr {
> +    abi_long    msg_name;       /* Socket name */
> +    int32_t     msg_namelen;    /* Length of name */
> +    abi_long    msg_iov;        /* Data blocks */
> +    int32_t     msg_iovlen;     /* Number of blocks */
> +    abi_long    msg_control;    /* Per protocol magic (eg BSD fd passing) */
> +    int32_t     msg_controllen; /* Length of cmsg list */
> +    int32_t     msg_flags;      /* flags on received message */
> +};
> +
> +struct target_sockaddr {
> +    uint8_t sa_len;
> +    uint8_t sa_family;
> +    uint8_t sa_data[14];
> +} QEMU_PACKED;
> +
> +struct target_in_addr {
> +    uint32_t s_addr; /* big endian */
> +};
> +
> +struct target_cmsghdr {
> +    uint32_t    cmsg_len;
> +    int32_t     cmsg_level;
> +    int32_t     cmsg_type;
> +};
> +
> +/*
> + * mips32 is the exception to the general rule of long-alignment; it
> + * unconditionally uses 64-bit alignment instead.
> + */
> +#if defined(TARGET_MIPS) && TARGET_ABI_BITS == 32
> +#define TARGET_ALIGNBYTES   (sizeof(abi_llong) - 1)
> +#else
> +#define TARGET_ALIGNBYTES   (sizeof(abi_long) - 1)
> +#endif
> +
> +#define TARGET_CMSG_NXTHDR(mhdr, cmsg, cmsg_start) \
> +                               __target_cmsg_nxthdr(mhdr, cmsg, cmsg_start)
> +#define TARGET_CMSG_ALIGN(len) (((len) + TARGET_ALIGNBYTES) \
> +                               & (size_t) ~TARGET_ALIGNBYTES)
> +#define TARGET_CMSG_DATA(cmsg) \
> +    ((unsigned char *)(cmsg) + TARGET_CMSG_ALIGN(sizeof(struct target_cmsghdr)))
> +#define TARGET_CMSG_SPACE(len) \
> +    (TARGET_CMSG_ALIGN(sizeof(struct target_cmsghdr)) + TARGET_CMSG_ALIGN(len))
> +#define TARGET_CMSG_LEN(len) \
> +    (TARGET_CMSG_ALIGN(sizeof(struct target_cmsghdr)) + (len))
> +
> +static inline struct target_cmsghdr *
> +__target_cmsg_nxthdr(struct target_msghdr *__mhdr,
> +                     struct target_cmsghdr *__cmsg,
> +                     struct target_cmsghdr *__cmsg_start)
> +{
> +    struct target_cmsghdr *__ptr;
> +
> +    __ptr = (struct target_cmsghdr *)((unsigned char *) __cmsg +
> +        TARGET_CMSG_ALIGN(tswap32(__cmsg->cmsg_len)));
> +    if ((unsigned long)((char *)(__ptr + 1) - (char *)__cmsg_start) >
> +        tswap32(__mhdr->msg_controllen)) {
> +        /* No more entries.  */
> +        return (struct target_cmsghdr *)0;
> +    }
> +    return __ptr;
> +}
> +
> +/*
> + * netinet/in.h
> + */
> +struct target_ip_mreq {
> +    struct target_in_addr   imr_multiaddr;
> +    struct target_in_addr   imr_interface;
> +};
> +
> +struct target_ip_mreqn {
> +    struct target_in_addr   imr_multiaddr;
> +    struct target_in_addr   imr_address;
> +    int32_t                 imr_ifindex;
> +};
> +
>   /*
>    * sys/stat.h
>    */
> @@ -434,6 +646,152 @@ struct target_freebsd_flock {
>   /* user: vfork(2) semantics, clear signals */
>   #define TARGET_RFSPAWN (1U << 31)
>   
> +/* sys/specialfd.h */
> +enum target_specialfd_type {
> +    TARGET_SPECIALFD_EVENT         = 1,
> +};
> +
> +struct target_specialfd_eventfd {
> +    unsigned int initval;
> +    int flags;
> +};
> +
> +/*
> + * FreeBSD thread and user mutex support.
> + */
> +
> +/* sys/thr.h */
> +#define TARGET_THR_SUSPENDED    0x0001
> +#define TARGET_THR_SYSTEM_SCOPE 0x0002
> +
> +struct target_freebsd_thr_param {
> +    abi_ulong   start_func; /* thread entry function. */
> +    abi_ulong   arg;        /* argument for entry function. */
> +    abi_ulong   stack_base; /* stack base address. */
> +    abi_ulong   stack_size; /* stack size. */
> +    abi_ulong   tls_base;   /* tls base address. */
> +    abi_ulong   tls_size;   /* tls size. */
> +    abi_ulong   child_tid;  /* address to store new TID. */
> +    abi_ulong   parent_tid; /* parent access the new TID here. */
> +    int32_t     flags;      /* thread flags. */
> +    abi_ulong   rtp;        /* Real-time scheduling priority. */
> +    abi_ulong   spare[3];   /* spares. */
> +};
> +
> +/* sys/rtprio.h */
> +struct target_freebsd_rtprio {
> +    uint16_t    type;
> +    uint16_t    prio;
> +};
> +
> +typedef struct {
> +    CPUArchState *env;
> +    long parent_tid;
> +    pthread_mutex_t mutex;
> +    pthread_cond_t cond;
> +    pthread_t thread;
> +    sigset_t sigmask;
> +    struct target_freebsd_thr_param param;
> +} new_freebsd_thread_info_t;
> +
> +/* sys/utmx.h */
> +/* op code for _umtx_op */
> +#define TARGET_UMTX_OP_LOCK                 0
> +#define TARGET_UMTX_OP_UNLOCK               1
> +#define TARGET_UMTX_OP_WAIT                 2
> +#define TARGET_UMTX_OP_WAKE                 3
> +#define TARGET_UMTX_OP_MUTEX_TRYLOCK        4
> +#define TARGET_UMTX_OP_MUTEX_LOCK           5
> +#define TARGET_UMTX_OP_MUTEX_UNLOCK         6
> +#define TARGET_UMTX_OP_SET_CEILING          7
> +#define TARGET_UMTX_OP_CV_WAIT              8
> +#define TARGET_UMTX_OP_CV_SIGNAL            9
> +#define TARGET_UMTX_OP_CV_BROADCAST         10
> +#define TARGET_UMTX_OP_WAIT_UINT            11
> +#define TARGET_UMTX_OP_RW_RDLOCK            12
> +#define TARGET_UMTX_OP_RW_WRLOCK            13
> +#define TARGET_UMTX_OP_RW_UNLOCK            14
> +#define TARGET_UMTX_OP_WAIT_UINT_PRIVATE    15
> +#define TARGET_UMTX_OP_WAKE_PRIVATE         16
> +#define TARGET_UMTX_OP_MUTEX_WAIT           17
> +#define TARGET_UMTX_OP_MUTEX_WAKE           18
> +#define TARGET_UMTX_OP_SEM_WAIT             19
> +#define TARGET_UMTX_OP_SEM_WAKE             20
> +#define TARGET_UMTX_OP_NWAKE_PRIVATE        21
> +#define TARGET_UMTX_OP_MUTEX_WAKE2          22
> +#define TARGET_UMTX_OP_SEM2_WAIT            23
> +#define TARGET_UMTX_OP_SEM2_WAKE            24
> +#define TARGET_UMTX_OP_SHM                  25
> +#define TARGET_UMTX_OP_ROBUST_LISTS         26
> +
> +/* flags for UMTX_OP_CV_WAIT */
> +#define TARGET_CVWAIT_CHECK_UNPARKING       0x01
> +#define TARGET_CVWAIT_ABSTIME               0x02
> +#define TARGET_CVWAIT_CLOCKID               0x04
> +
> +#define TARGET_UMTX_UNOWNED                 0x0
> +#define TARGET_UMUTEX_UNOWNED               0x0
> +#define TARGET_UMTX_CONTESTED               (abi_ulong)(-1)
> +#define TARGET_UMUTEX_CONTESTED             0x80000000U
> +
> +/* flags for umutex */
> +#define TARGET_UMUTEX_ERROR_CHECK   0x0002  /* Error-checking mutex */
> +#define TARGET_UMUTEX_PRIO_INHERIT  0x0004  /* Priority inherited mutex */
> +#define TARGET_UMUTEX_PRIO_PROTECT  0x0008  /* Priority protect mutex */
> +
> +#define TARGET_UMUTEX_TRY           1
> +#define TARGET_UMUTEX_WAIT          2
> +
> +/* urwlock flags */
> +#define TARGET_URWLOCK_PREFER_READER    0x0002
> +#define TARGET_URWLOCK_WRITE_OWNER      0x80000000U
> +#define TARGET_URWLOCK_WRITE_WAITERS    0x40000000U
> +#define TARGET_URWLOCK_READ_WAITERS     0x20000000U
> +#define TARGET_URWLOCK_MAX_READERS      0x1fffffffU
> +#define TARGET_URWLOCK_READER_COUNT(c)  ((c) & TARGET_URWLOCK_MAX_READERS)
> +
> +/*
> + * sys/acl.h
> + */
> +#define TARGET_FREEBSD_ACL_MAX_ENTRIES          254
> +
> +/* vaild acl_type_t arguments */
> +#define TARGET_FREEBSD_ACL_TYPE_ACCESS_OLD      0x00000000
> +#define TARGET_FREEBSD_ACL_TYPE_DEFAULT_OLD     0x00000001
> +#define TARGET_FREEBSD_ACL_TYPE_ACCESS          0x00000002
> +#define TARGET_FREEBSD_ACL_TYPE_DEFAULT         0x00000003
> +#define TARGET_FREEBSD_ACL_TYPE_NFS4            0x00000004
> +
> +struct target_freebsd_acl_entry {
> +    uint32_t    ae_tag;
> +    uint32_t    ae_id;
> +    uint32_t    ae_perm;
> +    uint16_t    ae_entry_type;
> +    uint16_t    ae_flags;
> +};
> +
> +struct target_freebsd_acl {
> +    uint32_t            acl_maxcnt;
> +    uint32_t            acl_cnt;
> +    int32_t             acl_spare[4];
> +    struct target_freebsd_acl_entry  acl_entry[TARGET_FREEBSD_ACL_MAX_ENTRIES];
> +};
> +
> +/*
> + *  sys/uuid.h
> + */
> +
> +#define TARGET_UUID_NODE_LEN    6
> +
> +struct target_uuid {
> +    uint32_t    time_low;
> +    uint16_t    time_mid;
> +    uint16_t    time_hi_and_version;
> +    uint8_t     clock_seq_hi_and_reserved;
> +    uint8_t     clock_seq_low;
> +    uint8_t     node[TARGET_UUID_NODE_LEN];
> +};
> +
>   /*
>    * from sys/procctl.h
>    */
> @@ -475,21 +833,6 @@ struct target_procctl_reaper_kill {
>       uint32_t rk_pad0[15];
>   };
>   
> -/*
> - * sys/uuid.h
> - */
> -#define TARGET_UUID_NODE_LEN    6
> -
> -struct target_uuid {
> -    uint32_t    time_low;
> -    uint16_t    time_mid;
> -    uint16_t    time_hi_and_version;
> -    uint8_t     clock_seq_hi_and_reserved;
> -    uint8_t     clock_seq_low;
> -    uint8_t     node[TARGET_UUID_NODE_LEN];
> -};
> -
> -
>   #define safe_syscall0(type, name) \
>   type safe_##name(void) \
>   { \
> @@ -537,22 +880,15 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
>       return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
>   }
>   
> -/*
> - * sys/socket.h
> - */
> -struct target_sockaddr {
> -    uint8_t sa_len;
> -    uint8_t sa_family;
> -    uint8_t sa_data[14];
> -} QEMU_PACKED;
> -
> -struct target_in_addr {
> -    uint32_t s_addr; /* big endian */
> -};
> -
>   #define safe_ioctl(...) safe_syscall(SYS_ioctl, __VA_ARGS__)
>   #define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
>   
> +struct target_pollfd {
> +    int32_t fd;         /* file descriptor */
> +    int16_t events;     /* requested events */
> +    int16_t revents;    /* returned events */
> +};
> +
>   /* So far all target and host bitmasks are the same */
>   #undef  target_to_host_bitmask
>   #define target_to_host_bitmask(x, tbl) (x)
> 

How much of the syscall_defs.h sync is related?


r~


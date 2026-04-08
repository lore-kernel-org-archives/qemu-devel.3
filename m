Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2444F10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYGs-0004qj-RM; Wed, 08 Apr 2026 15:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wAYFY-0003Jc-Ux
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:07:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wAJMc-00008c-TN
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 23:14:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82cf83bf375so2364941b3a.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 20:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775618037; x=1776222837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eN0XT8CmTyToGaSu23qPJxNwe3iqDjG9RzrkLZpHRYE=;
 b=jL19Mk+yHV9rNtOcbYSAG1vjkXPxqf+/Xr7EX/xl26p1WMm3plRhni/X1tkSx4TRYR
 8Sbh9zM3qqRf58ZGOmMclcB748dZnBYn1mzPSceS9BSGoLvyy/DF+e72JOXHpa7tj/1M
 RdU/mkYKpsJbgZXGOVoKPazN5Bq07vGKhnNdROH82Bx+HsilVEkrPnv/lLM+ARLd6BOu
 lyeFfHNK55xZIgMGBFz+gMqwl2twdp14+YRoQVOssGLIg71+DkxlRjLWcixU7OirQdaW
 RozlWiMzSmHmATcjKstqqssFHjD8bGlsaNqUeLVrDyR/TI9TJVr8kT/dHZuvoGLz4+J1
 ULfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775618037; x=1776222837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eN0XT8CmTyToGaSu23qPJxNwe3iqDjG9RzrkLZpHRYE=;
 b=qOh43OHKlCi91UFVLsmrH6Zd8xQdThkQbPL9JUvpPzoMqxGFbUYs6VtmN/4Em9UWQj
 UaPCqNoMLgT2LQk8v/UesI3z4Eu/Qfp5E3Et3seWa9Gi+GRjjNOkw5rhJce2bGTV3p/l
 SVoWhQQzcMlXQ/xcCd3bCjTB1poevx1j9kdmSQO4mfuqP+g5kFljUXZ2KegG95AadvOW
 LGo4D2iEH431PvaZAfkRtsYqoPhru9UU8Tw0HszPkGoiZOxeW+GeA6oR4zApial6ufPx
 9Da+0A2DJBqL4xA8wsiXduNDO+dnp3ag6388nclMA3w2YjjQhXIZn0KwYFpvqvmVPMR9
 x+Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPxgRPzrfBnkWdiggIiHHG0PoSgLsG2+qcjF6jsvJHLNRIB8a9y3oVPV4PF17EqTwO72LHiltjN5hP@nongnu.org
X-Gm-Message-State: AOJu0YzORaPeN05A8ImfGoy7esKSpSJekBJOCOWdKx5SoAALThoEl1EQ
 7GtMlhkhnlSsvIoziPXpA5luvBkEP9ZGlaLqhkfRDwHZn32h1XYaI+QB
X-Gm-Gg: AeBDiett0xEPasrHcAoDLYjCH0fq9z5TlGR7jtJwnR7aXZWK/ZcuWEir0rzmMwKOccp
 tn1HMueIBbagWaRJr+uAJcN0wnSbBoyis1HAgmeT+kqk8YME98gykUx87N3oPtjVQ3sZLDfsMT2
 EI9Gk8vyu93UCDFYdZtzGycUHgHMW7Ar6afTNJD93Nh7O7E6BgfHJfkguIz4IvIRlQWmFIEswAx
 HwvqASNfLbFF7IAu/G9Qy8LDNkfQvmjKeZv7tzoaoMjyB0IGQMFWiT/twSiP1ogX04DH+gjKgoP
 fuXGcz0rtWjNBtE1xIoFMNwfasK/hFDnKDRYhxVFKa9TnEoL2SSP9QQ7zkfj+nQ6fzlohYw1OuL
 W7ZzBmQwNq86m8Ddhr/kjJo47UjJGQkNO46DtcQJDIsj/+AbsK4c0ub8YMTOVOJbTRCMGzgMa06
 529CtKkvpNkIey4XnPL7FKw0qznBTa7+bPJ10wUWalvA==
X-Received: by 2002:a05:6a00:1794:b0:82a:14aa:795f with SMTP id
 d2e1a72fcca58-82d0db6279fmr20047562b3a.35.1775618036819; 
 Tue, 07 Apr 2026 20:13:56 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82d59834b63sm3056853b3a.21.2026.04.07.20.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 20:13:56 -0700 (PDT)
Message-ID: <8a16db1b-459f-4553-a104-c6849b53c88a@gmail.com>
Date: Wed, 8 Apr 2026 12:13:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/ufs: Add idle operation
To: Jaemyung Lee <ldc.jml@gmail.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jaemyung Lee <jaemyung.lee@samsung.com>
References: <20260407-write_booster-v2-0-dd772bb30194@samsung.com>
 <20260407-write_booster-v2-3-dd772bb30194@samsung.com>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20260407-write_booster-v2-3-dd772bb30194@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x436.google.com
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


On 4/7/2026 7:23 PM, Jaemyung Lee wrote:
> When no I/O occurs, the UFS Device performs various internal operations.
> To emulate this, adds a timer that periodically checks the current I/O
> status of the device and call the ufs_process_idle() function when idle.
>
> Signed-off-by: Jaemyung Lee <jaemyung.lee@samsung.com>
> ---
>   hw/ufs/ufs.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/ufs/ufs.h |  2 ++
>   2 files changed, 61 insertions(+)
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 69f82ab462d135fe6cda479891f9d8f26d19be9a..5102d9bbab640faded69c93be73cbe319db68646 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -1801,6 +1801,59 @@ static void ufs_sendback_req(void *opaque)
>       ufs_irq_check(u);
>   }
>   
> +static void ufs_process_idle(UfsHc *u)
> +{
> +    /* Currently do nothing */
> +    return;
> +}
> +
> +static inline bool ufs_check_idle(UfsHc *u)
> +{
> +    return !u->reg.utrldbr;
> +}
> +
> +static inline bool ufs_mcq_check_idle(UfsHc *u)
> +{
> +    if (!u->params.mcq) {
> +        return true;
> +    }
> +
> +    for (int qid = 0; qid < ARRAY_SIZE(u->sq); qid++) {
> +        if (!ufs_mcq_sq_empty(u, qid)) {
> +            return false;
> +        }
> +
> +        /* internal ongoing MCQ request check */
> +        UfsSq *sq = u->sq[qid];

MCQ queues are non-NULL only for the qids that are actually created.
You must add a NULL check here.


> +        for (int i = 0; i < sq->size; i++) {
> +            if (sq->req[i].state != UFS_REQUEST_IDLE) {
> +                return false;
> +            }
> +        }
> +    }
> +
> +    for (int qid = 0; qid < ARRAY_SIZE(u->cq); qid++) {
> +        if (!ufs_mcq_cq_empty(u, qid)) {
> +            return false;
> +        }
> +    }

Checking only ufs_mcq_cq_empty() is not sufficient.
You should also check:
u->cq[qid] && !QTAILQ_EMPTY(&u->cq[qid]->req_list)

> +
> +    return true;
> +}
> +
> +#define UFS_IDLE_TIMER_TICK 100 /* 0.1s */
> +static void ufs_idle_timer_cb(void *opaque)
> +{
> +    UfsHc *u = opaque;
> +    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
> +
> +    if (ufs_check_idle(u) && ufs_mcq_check_idle(u)) {
> +        ufs_process_idle(u);
> +    }
> +
> +    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
> +}
> +
>   static bool ufs_check_constraints(UfsHc *u, Error **errp)
>   {
>       if (u->params.nutrs > UFS_MAX_NUTRS) {
> @@ -1863,6 +1916,7 @@ static void ufs_init_hc(UfsHc *u)
>       uint32_t cap = 0;
>       uint32_t mcqconfig = 0;
>       uint32_t mcqcap = 0;
> +    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT);
>   
>       u->reg_size = pow2ceil(ufs_reg_size(u));
>   
> @@ -1959,6 +2013,9 @@ static void ufs_init_hc(UfsHc *u)
>        * dynamically
>        */
>       u->temperature = UFS_TEMPERATURE;
> +
> +    timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
> +    timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
>   }
>   
>   static void ufs_realize(PCIDevice *pci_dev, Error **errp)
> @@ -1986,6 +2043,8 @@ static void ufs_exit(PCIDevice *pci_dev)
>   {
>       UfsHc *u = UFS(pci_dev);
>   
> +    timer_del(&u->idle_timer);
> +
>       qemu_free_irq(u->irq);
>   
>       qemu_bh_delete(u->doorbell_bh);
> diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
> index 13d964c5ae5ec430a98b2ef71987cb9279e9a317..b5f040302129f4d02732ddd20ef82eb33c41922a 100644
> --- a/hw/ufs/ufs.h
> +++ b/hw/ufs/ufs.h
> @@ -148,6 +148,8 @@ typedef struct UfsHc {
>       UfsCq *cq[UFS_MAX_MCQ_QNUM];
>   
>       uint8_t temperature;
> +
> +    QEMUTimer idle_timer;
>   } UfsHc;
>   
>   static inline uint32_t ufs_mcq_sq_tail(UfsHc *u, uint32_t qid)
>


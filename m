Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32538C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1epK-0006Zz-Fl; Wed, 02 Sep 2026 02:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x1epI-0006Zq-U0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:52:04 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x1epG-0000U2-Uv
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:52:04 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so744263a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788331921; x=1788936721; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=82vfeqBiEn94crLDGWMEgyAaHZ1yHV+XmGdWIbC1MN4=;
 b=bYTZDAiCW/5nLnFhdgnLTt3/OnWe5LWXKeJLKSy2DamBq5dHMs/79jVcfswhp8jgBH
 q5Q1djWCwAhhIOMj+rBzAu1++x+FWcOrFuFX408OXpYfabvlbO7MFhMvM4n+gg2ZW9AX
 lO5FKagVEBd2jt6tgnCLKq0MUCJJQamL+cQuk+nUogyb2M3+OoK9ZaGpqm9iPZ2JFpJ0
 UTThBECWGyV6hnlQo3QEgFn6+yyOcW4mfvsWtmWUPbS7H1eb58HHISSIonbCls5UKzVv
 nXbcdQnfqg6yAQr9bO/UCWA0nd536ynn6zvTOFHrA1f3lKIp9VOzQpt5h147QiMO0v1y
 u3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788331921; x=1788936721;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=82vfeqBiEn94crLDGWMEgyAaHZ1yHV+XmGdWIbC1MN4=;
 b=iipZ7bRHSb8W+p5yTMgJdVIc3sf39RPySZKb1DOXgK7GHy5PFZsaTWCu96q8ghJ2Ar
 7MJfHteESdOLdVfKHpgMIquDw9U/6Y7akyhdt30/WNw9CLGCHHma4hOC/hIjmJWnxZrZ
 qN0ISOzjcK0XFhY4N2sZGLWHdEnNwpyYq71dhFx+J56W3OZUcKEI1oSmW7ytMFfGYbO5
 5DcStoCRmN7sMQ3Iypb+yylojfBJnuqLXmNFfkdnO9aod/+lV11IysqpR0sBeeXX73Dk
 wNcT99mpoFIGR0e4kLHjjzwvnNvWIqRt3WrUnyN6Tvc5mBON0lrifcHt5JQq6Nv3FBcP
 OymQ==
X-Gm-Message-State: AFuF++n+8jBXwdp0ihqTGew6HoCaMmpg4WOEG/bHMaN75bUa8P1XGSRo
 raiqlXbgkCdjiQzj79DZzdBLUr77XjHLzugHZxNnNF/HFo44LOehkw1q
X-Gm-Gg: AYBFou3EbOxTDhESULXA3HquPzumV4v5lsZsZvXLvwQVImoaQKoAjo7TEe5/aiALbZ+
 DsdtKgPRCUXU0iSQQHkjVkIOa6fiNAbQLHfGiOD7iG53ftGJuBBGt5tucS3SPYm3/oYzWs3rLlB
 CgRmxuNaN2ZdtKU9CLZzZoJmAyfgc/19iRyprYNxE/FW4QIEkzAH15R536Y8MfcVdkmynX8pGLd
 Lfw5OkcAY/HlsUl8DlkEBNwTBIM8wdYpegF36fhzJh1wN1nxJKlXmcMs47hgZH1b8V0eAcQKBCx
 N1vWqdj4X4CzbTVRrV7rkveKR4ZtfbzoxYHWelMjiCRk3JTyiAfZyX0s0vVSYef1rOOo7NdPik1
 wJG/xFOZ1h4Uwsep+ZeCFyqbHKrtqoor28CZ3qfVud5VeDt8PZJqJCgUm4qyLmIfrLulNUHRbKl
 XAOH9wfiJLjjQh2URDEnv01yiQf8PmR78/P7kHOHncEV+rwj9Sg81fJz8kHa+WYxg29EzuKt16g
 h8NcV8=
X-Received: by 2002:a17:90b:4407:b0:398:9bd4:d13 with SMTP id
 98e67ed59e1d1-39aee219427mr3976751a91.18.1788331921036; 
 Tue, 01 Sep 2026 23:52:01 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae0f2a321sm3970831a91.7.2026.09.01.23.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 23:52:00 -0700 (PDT)
Message-ID: <456f7344-0d8c-49ab-8d3c-5652e4ba7d48@gmail.com>
Date: Wed, 2 Sep 2026 15:51:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ufs: Reset controller and MCQ state on HCE transition
 to 0
To: Stanley Jhu <stanleyjhu@google.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, Jinyoung Choi <j-young.choi@samsung.com>
References: <CAE14pdd_8whV+A_2qpujNTS+zeCes8M0e53LfN_zLY+v7iKPcw@mail.gmail.com>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <CAE14pdd_8whV+A_2qpujNTS+zeCes8M0e53LfN_zLY+v7iKPcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102e.google.com
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

Hi Stanley,

Thanks for your contribution.


On 9/1/2026 10:03 PM, Stanley Jhu wrote:
> According to the JEDEC Universal Flash Storage Host Controller Interface
> (UFSHCI) specification (Section 5.2.1 "Host Controller Enable"):
> when Host Controller Enable (HCE) transitions from 1 to 0, a host
> controller reset is initiated. The host controller shall abort all
> active transfers, return internal state machines to idle, and de-assert
> all interrupts.
>
> Currently, QEMU's UFS emulator only clears HCS and HCE registers upon
> HCE=0, leaving internal state active. Specifically:
> - Outstanding SCSI requests in the block layer are not purged.
> - Active bottom halves (doorbell_bh and complete_bh) remain scheduled.
> - Allocated MCQ Submission and Completion Queues (sq and cq) are not freed.
> - Dynamic MCQ queue registers and legacy UTRL request states remain stale.
>
> Implement ufs_hce_reset() to:
> 1. Purge outstanding SCSI requests for all logical units via
>     scsi_device_purge_requests().
> 2. Cancel active bottom halves (doorbell_bh and complete_bh).
> 3. Clear standard request list slots and release SGLs via
>     ufs_clear_req().
> 4. Free allocated MCQ queues and clear dynamic queue registers while
>     preserving static capability offsets.
> 5. De-assert interrupts via ufs_irq_check().
> 6. Add a trace_ufs_hce_reset() trace event.
>
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
> ---
>   hw/ufs/trace-events |  1 +
>   hw/ufs/ufs.c        | 64 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
>
> diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
> index 00e263c7ba..1eb85c6978 100644
> --- a/hw/ufs/trace-events
> +++ b/hw/ufs/trace-events
> @@ -14,6 +14,7 @@ ufs_process_uiccmd(uint32_t uiccmd, uint32_t
> ucmdarg1, uint32_t ucmdarg2, uint
>   ufs_mcq_complete_req(uint8_t qid) "sqid %"PRIu8""
>   ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t
> size) "mcq create sq sqid %"PRIu8", cqid %"PRIu8", addr 0x%"PRIx64",
> size %"PRIu16""
>   ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq
> create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
> +ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ
> and request lists"
>
>   # error condition
>   ufs_err_dma_read_utrd(uint32_t slot, uint64_t addr) "failed to read
> utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index a8e2df8087..b729b247f1 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -679,6 +679,69 @@ static bool ufs_mcq_delete_cq(UfsHc *u, uint8_t qid)
>       return true;
>   }
>
> +static void ufs_hce_reset(UfsHc *u)
> +{
> +    int i;
> +
> +    trace_ufs_hce_reset();
> +
> +    /* 1. Purge outstanding SCSI requests for all logical units */
> +    for (i = 0; i < UFS_MAX_LUS; i++) {
> +        if (u->lus[i] && u->lus[i]->scsi_dev) {
> +            scsi_device_purge_requests(u->lus[i]->scsi_dev, SENSE_CODE(RESET));

The UFS SCSI bus has no .cancel callback. The reference returned by 
scsi_req_new() is released only from ufs_scsi_command_complete(), so
a cancelled request would leak that reference.

> +        }
> +    }
> +
> +    /* 2. Cancel active Bottom Halves */
scsi_device_purge_requests() calls blk_drain(), which may run pending 
BHs. Please stop the request-producing BHs before
the purge and make sure they cannot be scheduled again while the reset 
is in progress. Note that an MCQ CQ BH may reschedule an SQ BH.
> +    if (u->doorbell_bh) {
> +        qemu_bh_cancel(u->doorbell_bh);
> +    }
> +    if (u->complete_bh) {
> +        qemu_bh_cancel(u->complete_bh);
> +    }
> +
> +    /* 3. Reset standard request list slots and doorbells */
> +    for (i = 0; i < u->params.nutrs; i++) {
> +        ufs_clear_req(&u->req_list[i]);
> +        u->req_list[i].state = UFS_REQUEST_IDLE;
> +    }
> +    u->reg.utrldbr = 0;
> +    u->reg.utmrldbr = 0;
> +    u->reg.is = 0;

Please clear UTRLCNR and UTRLRSR as well.


> +
> +    /* 4. Free MCQ Queues and reset MCQ dynamic registers */
> +    if (u->params.mcq) {
> +        for (i = 0; i < ARRAY_SIZE(u->sq); i++) {
> +            if (u->sq[i]) {
> +                ufs_mcq_free_sq(u->sq[i]);
> +                u->sq[i] = NULL;
> +            }
> +        }
> +        for (i = 0; i < ARRAY_SIZE(u->cq); i++) {
> +            if (u->cq[i]) {
> +                ufs_mcq_free_cq(u->cq[i]);
> +                u->cq[i] = NULL;
> +            }
> +        }
> +
> +        /* Clear dynamic queue configuration without touching static offsets */
> +        for (i = 0; i < ARRAY_SIZE(u->mcq_reg); i++) {
> +            u->mcq_reg[i].sqattr = 0;
> +            u->mcq_reg[i].sqlba = 0;
> +            u->mcq_reg[i].squba = 0;
> +            u->mcq_reg[i].sqcfg = 0;
> +            u->mcq_reg[i].cqattr = 0;
> +            u->mcq_reg[i].cqlba = 0;
> +            u->mcq_reg[i].cquba = 0;
> +            u->mcq_reg[i].cqcfg = 0;
> +        }
> +        memset(&u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
> +    }
> +
> +    /* 5. De-assert IRQ */
> +    ufs_irq_check(u);
> +}
> +
>   static void ufs_write_reg(UfsHc *u, hwaddr offset, uint32_t data,
> unsigned size)
>   {
>       switch (offset) {
> @@ -696,6 +759,7 @@ static void ufs_write_reg(UfsHc *u, hwaddr offset,
> uint32_t data, unsigned size)
>               u->reg.hce = FIELD_DP32(u->reg.hce, HCE, HCE, 1);
>           } else if (FIELD_EX32(u->reg.hce, HCE, HCE) &&
>                      !FIELD_EX32(data, HCE, HCE)) {
> +            ufs_hce_reset(u);
>               u->reg.hcs = 0;
>               u->reg.hce = FIELD_DP32(u->reg.hce, HCE, HCE, 0);
>           }
> --
> 2.43.0

There seem to be two possible approaches here:

1. Add the missing SCSI cancellation handling and stop the 
request-producing BHs before purging the requests.
2. Stop accepting new requests and defer the HCE reset until the 
in-flight requests complete normally.

The second approach looks simpler for now. HCE can remain set while the 
disable is pending and be cleared from
a BH once no request remains in flight.



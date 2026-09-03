Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE9FC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20bG-00070L-3y; Thu, 03 Sep 2026 02:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x20b5-0006zP-4m
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 02:06:51 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x20b3-0007ya-J0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 02:06:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d71ae3455aso28646425ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 23:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788415608; x=1789020408; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n2QkrzWcK3dEl6mbOrEDdNtuLGr9Tb7xEyw9xAtiXRs=;
 b=fqmdAHoDoNzZr+4XnO0x+lvoxBe2b4tpbS/mkv+sxh3cSuFpHYzqRhYWFhwenvtS8A
 MPztqmRDEdCzrihVvypF4qcRLnIkEtZyFxB3gc/SlW9I7mE6rtK5KmVCctXaCfSSQk3P
 sb2LPRmtmCfAHypKe6bb6sUIKmeL2xLWiEnaFoBLktL8DQLsdfXaCRmCv0dkeRC/k3nN
 0UjmCDnMcGL4Po+xli4kksql9DDok0mEYxiWvhok3U7+6JzAmzMhzfx8LxqUOkyJKrt6
 gPb9lilsd19VyxBJksxFz1CjGNCm90vmAdGJ3GuMFzh6n5Yy8V6xlk1KlCuqyW2Bx092
 mitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788415608; x=1789020408;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n2QkrzWcK3dEl6mbOrEDdNtuLGr9Tb7xEyw9xAtiXRs=;
 b=lF6rZLFfvI+I0VAeJPkESGXqEqxbXnegXXhqHTuJeMg0b+HkILGCTrkaS68IEYTm4d
 azkdY9Twec/hcWXSfzrR6NT4SxpWpoXaYEOYxn3xZ5DnTjUFm5Iu1wh3Ye8WUyK4GUYd
 PAutol6J1/EtRBS8XdnM5WvKJXwCv0bAQR6Xc55MMPx0q03g7vmD0ob8S8uRl/rFTUKi
 tEE6AdtTS5VBgm1iHpCpPWGgZUO3tRhbO6NozB52bAwUslKcw5rsn3+8jjKG4K8tCzF3
 gPKXdHgvI3WooGK74UKJ4Vz2XzV4lZGcKNqSQszDgqgTLr3rzUkHem3nSQSFrIOM8GWE
 W5wg==
X-Gm-Message-State: AFuF++l5ojBrf31o9tIrdFb5N/kJBDoWVrDMexmE38nQlUNlLxjZZREy
 GasrqtcBBuq54i4Ybpa9XsXQ713Nx5AeQvlOFgP4ZqYuDXtJftEOOFgx
X-Gm-Gg: AYBFou0uR8XokuGYc/NwaII2/0Apjvm4ib49KgkcjXMyQGBJdY6OuQ2mSay35+GWNa6
 Ze3f97ZlwEop+DMomL1gPESaccJnGaPPnte7nFKPxfD5pf9JsgNadAZn71iobo7D1OHWdAkBuqC
 3z5cFqqfVEJeFy6hSDeX7ZU1HTzMebPTp/+3T1BqROxrsxRP/pYQc/KI6K+I+/33CAIxcGyqDx/
 t+pRnD/SJ485EIdEHTmrPNa893YY5BHtUq5qDK/a6k+QbCv0wxaSJ2eCKJWBh5qINvEDjJZgMHk
 L8Z/n4WLmAfhDU1+OLXHO1eQKBSc8kddUU80DhEmZxTPlY5t9egJmKkEv4IqCIWC4Y613xhbEC0
 rPqLX04kehiGMej0W6fP7rde48fBaGWebhRk6eh1bXvn74Lvaijd1YigRjzl4Sy8m1X8ylBYx57
 wlyu/zMEZqfboxAUrnW1HZqqAo8yCV350yHS4TlEa2Yx/HOXeO+ADSeI2EQt7TpeRWUCRkqMIOE
 YPbLg==
X-Received: by 2002:a17:90b:5743:b0:398:bbe9:73af with SMTP id
 98e67ed59e1d1-39aedfdb0b1mr17569445a91.7.1788415607914; 
 Wed, 02 Sep 2026 23:06:47 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08cacba5sm3183530a91.12.2026.09.02.23.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 23:06:47 -0700 (PDT)
Message-ID: <21bbbab6-192b-4243-980e-4167b450c478@gmail.com>
Date: Thu, 3 Sep 2026 15:06:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/ufs: Reset controller and MCQ state on HCE
 transition to 0
Content-Language: ko
To: Stanley Jhu <stanleyjhu@google.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-devel@nongnu.org, Jinyoung Choi <j-young.choi@samsung.com>
References: <20260902081610.2290123-1-stanleyjhu@google.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20260902081610.2290123-1-stanleyjhu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x635.google.com
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


On 9/2/2026 5:16 PM, Stanley Jhu wrote:
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
> - Active bottom halves (doorbell_bh, complete_bh, and MCQ sq/cq BHs)
>    remain scheduled.
> - Allocated MCQ Submission and Completion Queues (sq and cq) are
>    not freed.
> - Dynamic MCQ queue registers, legacy UTRL request states, and status
>    registers (UTRLCNR, UTRLRSR) remain stale.
>
> Implement ufs_hce_reset() to:
> 1. Implement .cancel callback in ufs_scsi_info to properly unref
>     scsi_req and prevent reference leaks when SCSI requests are purged.
> 2. Cancel active bottom halves (doorbell_bh, complete_bh, and MCQ sq/cq
>     BHs) and guard them with a resetting flag before purging requests,
>     ensuring blk_drain() cannot run or reschedule request-producing BHs.
> 3. Purge outstanding SCSI requests for all logical units via
>     scsi_device_purge_requests().
> 4. Clear standard request list slots and release SGLs via
>     ufs_clear_req(), and clear doorbells and status registers (UTRLCNR,
>     UTRLRSR).
> 5. Free allocated MCQ queues and clear dynamic queue registers while
>     preserving static capability offsets.
> 6. De-assert interrupts via ufs_irq_check().
> 7. Add a trace_ufs_hce_reset() trace event.
>
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
> ---


Thank you for your contribution.

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>




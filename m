Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895B7CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGAaI-0008RH-Rt; Mon, 12 Oct 2026 03:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGAaH-0008R9-EE
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 03:36:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGAaF-00046X-RR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 03:36:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so13976075ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 00:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791790590; x=1792395390; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TvKb+X27ixgZRvVZUdHTUfiVxdA3FMBupHpvuG4tTVw=;
 b=pSbDcPBbAuC+HO4AiT7YVBb6CQ59K0cdpnLvpZcAzwN6JJjYtEQZQznkmLdNOdxBfA
 6PaywU/9N1QBYhM/PD1YBZivwrEOlMI9/8Vjq3Ej9EjUz3lj4Tv7UQR8XATeKtHTCWwo
 7L6uGoJqt1dJRrGaMjF6oW2Wp6k3XeBWVM8+R/8r9erIzR9ap22JQSzqZph9ufCFri60
 xEzNgQ/BrBH8qMg/pdskG8ne07xx8nYj8RT/QBCCoS5l2/u1G+kXDge0DMx4bYVu8XkL
 ZxO/j9lqpJYJ8ZvwTGdCp89Bp//rLU0oTSKMTEfG77AfHS4619Ig0iXtiyUaQW+wW+u3
 j64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791790590; x=1792395390;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TvKb+X27ixgZRvVZUdHTUfiVxdA3FMBupHpvuG4tTVw=;
 b=dhPNE1R8FcDMwCIl/pCsKnh6qHEmTmW9uK4lbSetUzlDBEOn4A0WzajydwupEO8i9O
 ip8LEnURH+fRxbYlV5ZTsu7zwwaVp4Ju4RxGuZrDeP6xbYd4S5l6s1q3uMZ9ICa2nE12
 upgupesdCHYCkIyHOsi900dGVm80OxZscSVaUMbe19FouFyQ6emlKX+w4YwwDD6AGjb5
 il168Jg8FMxTjKYlZ09SXn4VY44TADC48i6H6MEiliVN9dtn5f1/lUM+h8BHKcMLHEn8
 ezUKZ4ZmaZsH28MhhZB3hUej5i0eKn8BD6egAnzI1VtzbKWq6j7p6ni3sDBG0mUfiwoN
 Rr4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCn+nWoqvjCdFb8eBBBPunrQ7KH/roDJu8JWRz2CMlNu0kXFlhTI6M3Ls8k41L2REfWlpagvDI2cL1@nongnu.org
X-Gm-Message-State: AFq9FYLdQwyWy0EfXt0ClXVewrASuRH6Kn57B/gT8MbMeHbJaq560oJL
 W29IRIrlNK0/o49ZbhM3Uo9VbJ5DBkFvBlLK6gbVUUaV8JwEEvy46UwW
X-Gm-Gg: AYBFou3dp2a7eCoohLA7Y91fv/J6zQzLZ+RPFAJjOkXxPhHpTDXQJPacTHZO3M3PjTj
 nciNaKSWn/ueq5jVp5sVLiZEA/2/BfzdTC3Yk/YH4zYyrXqQh3ZJjKYWzqmEgNGFfKLz31cRbFJ
 ZFW6lmEp8L+rL6lO1wV5kR0ig33rkY6YT06eECX40GS0/S1hRnv1UKJT7hZr2MzgsrNAkPqHRyT
 LNObPCLXxgaWlm0Iz1cW6/p6q316ZOuiK3jRFDNahjW9GF41Of0DP4ZBKZJPNZ+XK+LIVaq6Iu1
 ax3M3/6c1pwTVpuGUAmGCti7pAq2agTZCrC5F1IrzHe22vxi9Uj43X6nm+uk5o2gFgStCUsNjh3
 E3QytjSnJC3kmgqCmooA/KZU+He0JYcreVKe6vgVGXXMY0Bx5L+m4fnvhTSE3DUV54mgcxoVT65
 nRXhk/KzGDdUYfWc3s23ZKDhtbOnzoSze/XkwuuLtrBWD15kPp/RWlkVammqWLrFbONbQqK1L+1
 Yf9ifEgQEhZ
X-Received: by 2002:a17:902:e551:b0:2df:8430:a580 with SMTP id
 d9443c01a7336-2e876ca7075mr54823985ad.45.1791790590206; 
 Mon, 12 Oct 2026 00:36:30 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8cb6sm40035825ad.60.2026.10.12.00.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:36:29 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 0/4] hw/ufs: Support MCQ runtime registers and Task
 Management Requests
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>, 
 stanleyjhu@google.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
In-Reply-To: <20261005110315.3327418-1-stanleyjhu@google.com>
References: <20261005110315.3327418-1-stanleyjhu@google.com>
Date: Mon, 12 Oct 2026 16:36:18 +0900
Message-Id: <179179057854.120480.12658123947732341847.b4-review@b4>
X-Mailer: b4 0.16.1-dev
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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

> This series adds support for Task Management Requests (TMR) and
> Multi-Circular Queue (MCQ) runtime status, interrupt, and queue cleanup
> operations in the QEMU UFS emulator.
> 
> Why:
> Linux UFS error recovery issues Task Management Requests (TMR) via the
> UTP Task Management Request List (UTMRL). In MCQ mode, the driver also
> uses per-queue operational registers (SQnRTC, SQnRTS, SQnCTI, CQnIS) to
> stop queues and clean up aborted tasks, and nullifies unfetched SQEs by
> setting Command Type to 0xF. QEMU does not yet model these paths or
> track per-request SCSIRequest pointers needed to cancel individual
> in-flight commands. Per-SQ interrupt status/enable bits (SQIS.SSS/SUS,
> SQIE, and IS.SQES) remain unmodeled.
> 
> What:
> - Patch 1: Track SCSIRequest in UfsRequest and cancel it in
>   ufs_clear_req().
> - Patch 2: Implement MCQ runtime operational registers and SQnRTC.ICU
>   cleanup.
> - Patch 3: Implement UTMRL doorbell and TMR handling (QUERY_TASK and
>   ABORT_TASK).
> - Patch 4: Skip nullified MCQ SQEs (CT = 0xF) and post CQEs with
>   UFS_OCS_ABORTED.
> 
> Differences from v3:
> - Report SQRTS.RTC (0..3) and preserve SQRTS.CUS across SQ_START (Jeuk)
> - Separate TMR rsp_header.response from output_param1 and gate IS.UTMRCS
>   on the UTMRD I-bit (Jeuk)
> - Drop non-spec MMIO configuration register resets in ufs_hce_reset()
> - Complete nullified MCQ SQEs (CT = 0xF) with UFS_OCS_ABORTED
> 
> Tested:
> Verified on QEMU ARM64 with qos-test and Linux guest MCQ TMR abort, SQ
> cleanup, and host reset.
> 
> Stanley Jhu (4):
>   hw/ufs: Track SCSIRequest and cancel pending requests in ufs_clear_req
>   hw/ufs: Support MCQ runtime interrupt and queue status registers
>   hw/ufs: Implement Task Management Request (TMR) handling
>   hw/ufs: Skip nullified MCQ submission queue entries with OCS_ABORTED
> 
>  hw/ufs/lu.c         |   8 ++
>  hw/ufs/trace-events |   2 +
>  hw/ufs/ufs.c        | 268 +++++++++++++++++++++++++++++++++++++++++++-
>  hw/ufs/ufs.h        |   1 +
>  include/block/ufs.h |  17 +++
>  5 files changed, 292 insertions(+), 4 deletions(-)
> 
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog

Thank you for your contribution.

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

-- 
Jeuk Kim <jeuk20.kim@samsung.com>


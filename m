Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7782CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZpc-0001Ym-02; Fri, 02 Oct 2026 05:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xCZpZ-0001VQ-5r
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:45:29 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xCZpW-0000HP-8w
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:45:28 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-3a4c8262465so2925753a91.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790934324; x=1791539124; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oaK1Iww8lvF5t8hxvFyuonSoWuZq1OdBhRc5xHfmq7o=;
 b=DhlYgZU46nKA+nHeEIpkkqkkl730FcyWL/GpKFiGS5gUxk2UBMVY7ngFOdsADLLJYi
 wrdecAEAszous9uyEQcRozU9xcTLFFx1b4QkILd7WPcxk7a/KmMxOZr1q/eYc0pZYvQh
 xXpU/2LAr4w52D/p0hLjtuvv09nYrvCnqrUIUtFszq4A0dEZ+/ToQIp9hIz1gOtMa8AF
 2Wlg+gO+1VWZaB2zdtl7z8kblwpQdkPo83g6j0IuL2HxMf2611OmRDZTb8qFDmLVUjiI
 kwFfrS2EQrisHcLCdFAWVskRn5tqiCZi6GbyyhyTWuZmAzh149CdNl3/7cuLOvUrT6gb
 ELhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790934324; x=1791539124;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oaK1Iww8lvF5t8hxvFyuonSoWuZq1OdBhRc5xHfmq7o=;
 b=tzXAfabS/L+/u1MOmPtB/mwY0SBmyHm5y6ghsBg/CojZKk60yIGeY9sVIIFX7Lkskq
 0yO/Sx65iMRp+vbOoyAznShRZMpWfEiuNnWvJIEN2v6BDujMylqjkS4bzwoZ2eM07o09
 AIqSwlvbmYkVdE4wirKtRPxCpsJ9wm9FgAA2NRQ8P/d4u/QNOKpTrA+MbyXDGnzspqk1
 z3FctK2PQr2okXa1D22BR0GR93Vhzj7AM3CtmdPnpOKStbsnTH0/NVYY6X2wDr2GM7bJ
 eCcLE9DZk3NMDDXnbll+eh2sdduKyzIg1OoCke8kGx8MvLub5eMowNZlPm5uwU4AGOI6
 mCJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhqfk2mvAv3plkXeDkoaVwFWSQn9PxJ//wHbG3WUxSdPyAEkVxp0GNemweUe5HfMOGG3Db8c0Omqr6@nongnu.org
X-Gm-Message-State: AFq9FYJ8XDnh6fP6q6skY3FJkNSyRgobBwgFeZ4i1JU9fIzoIhikb9LQ
 S/GwtfqBMAzJKtyhNdwKm0tw0p5rb8l7a8TOy+kW5CW2VnRc/r3ix83Q
X-Gm-Gg: AYBFou3qbqG548D5xlCJqAVktVm7r/ppbYQgshjQC/EIggHULcmDUnApMPkF+wKLHYZ
 QPOGJykMzag5uaUl1xeRf0ZQwnSgqYyzkO7odD8OyHFPQM4Iw846gE7h4BCZL2i0evZYUu0k8x/
 nbycBicYweKjWxbCkOkTDYy6eS6fYNvukxJqe3BWloWIbpHWJYlNFEKOidI5V6BawEAolIvL38z
 Xq116cQNl2ZPaIKPCnJpZbFO0ELrVpV6p+Z1jH5K3l1MZfrllXitDjFECSnOggySylvRu+CDqt9
 MDCQIEeFzX8sUm3XuHYMuG/Sd2E6BvWORkUxzcuz7qWiJFawEcojPTNh9G2Kj8Xrz16S3f/OHhV
 HgPay/T7AwV5MU7kwlH+B/PVQeA+NvMk3E7W8yBSibqnJflZMETrS+F4k3O0kPRPvGRMnCU56MS
 sNpXBOA971HuQKshEhPRxqR5iDp7BfpT3TGKjncSO6dl6HMRlK1oug8M2MwKa0CxmOlWirAmMSH
 w==
X-Received: by 2002:a17:90b:48c7:b0:3a2:b4a6:92a7 with SMTP id
 98e67ed59e1d1-3a6ce830993mr2174526a91.47.1790934324037; 
 Fri, 02 Oct 2026 02:45:24 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f43a12c9sm9050919a91.2.2026.10.02.02.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:45:23 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] hw/ufs: Add experimental fault injection
 properties for task abort testing
To: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-devel@nongnu.org, 
 stanleyjhu@google.com
Cc: Brian Kao <powenkao@google.com>, j-young.choi@samsung.com
In-Reply-To: <20260909031229.1650315-2-stanleyjhu@google.com>
References: <20260909031229.1650315-1-stanleyjhu@google.com>
 <20260909031229.1650315-2-stanleyjhu@google.com>
Date: Fri, 02 Oct 2026 18:45:15 +0900
Message-Id: <179093431586.95788.6113334726548476720.b4-review@b4>
X-Mailer: b4 0.16.1-dev
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj2-x0f.google.com
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

> Add experimental properties x-hold-tag and x-hold-mode to ufs-pci and
> ufs-sysbus devices to facilitate end-to-end testing of host driver error
> handling, task aborts, and SCSI recovery routines.
> 
> When x-hold-tag is set to a specific tag (0..255), the controller holds
> the matching transfer request until a Task Management Request (TMR) targeting
> the held request is issued by the host driver. If x-hold-tag=0xfffffffe
> (UFS_HOLD_TAG_ANY), the controller intercepts the first READ_10/WRITE_10
> request with LBA >= 512, avoiding guest boot-time metadata requests. The default
> value is 0xffffffff (UFS_HOLD_TAG_NONE), which disables fault injection.
> 
> The x-hold-mode property controls how the held request and subsequent
> recovery are resolved:
> - "abort-success": TMR ABORT_TASK aborts the held request, clears its
>   state, and returns SUCCESS (COMPL).
> - "abort-failed": TMR ABORT_TASK returns TASK_MANAGEMENT_FUNC_FAILED.
> - "in-transition": TMR QUERY_TASK / ABORT_TASK completes the held request
>   successfully and returns COMPL (simulating a command completing in transition).
> - "timeout": TMR ABORT_TASK does not complete, triggering TMR timeout.
> 
> Both properties support runtime modification via QOM (e.g., QMP qom-set),
> enabling continuous fault injection testing within a single running VM.
> 
> Together with the companion Linux kernel patch:
>   "[PATCH] scsi: ufs: core: Add fault injection for task abort failures"
>   Link: https://lore.kernel.org/r/20260903235308.1240963-1-stanleyjhu@google.com/
> these changes provide a deterministic testbed for automated CI/CD validation
> across driver error recovery and emulation layers.
> 
> Based-on: <20260909031146.1646684-1-stanleyjhu@google.com>
> 
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
> ---
>  hw/ufs/trace-events |   3 +
>  hw/ufs/ufs-pci.c    |   4 +
>  hw/ufs/ufs-sysbus.c |   4 +
>  hw/ufs/ufs.c        | 289 +++++++++++++++++++++++++++++++++++++++++---
>  hw/ufs/ufs.h        |  54 +++++++++
>  5 files changed, 339 insertions(+), 15 deletions(-)
>
> diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
> index 5e5a54a3fb..a2c8f80811 100644
> --- a/hw/ufs/trace-events
> +++ b/hw/ufs/trace-events
> @@ -16,6 +16,9 @@ ufs_mcq_create_sq(uint8_t sqid, uint8_t cqid, uint64_t addr, uint16_t size) "mcq
>  ufs_mcq_create_cq(uint8_t cqid, uint64_t addr, uint16_t size) "mcq create cq cqid %"PRIu8", addr 0x%"PRIx64", size %"PRIu16""
>  ufs_write_mcq_op_reg(uint8_t qid, uint32_t offset, uint32_t data) "qid %"PRIu8", offset 0x%"PRIx32", data 0x%"PRIx32""
>  ufs_process_tmr(uint8_t func, uint32_t tag, uint8_t resp) "query_func 0x%"PRIx8", task_tag %"PRIu32", tm_resp 0x%"PRIx8""
> +ufs_inject_hold_req(uint8_t tag, uint32_t lba) "held command tag %"PRIu8", lba %"PRIu32""
> +ufs_set_hold_tag(uint32_t tag) "hold-tag set to 0x%"PRIx32""
> +ufs_set_hold_mode(const char *mode) "hold-mode set to %s"
>  ufs_hce_reset(void) "HCE 1 -> 0 reset: cancelling BHs, resetting MCQ and request lists"
>  
>  # error condition
> diff --git a/hw/ufs/ufs-pci.c b/hw/ufs/ufs-pci.c
> index 8abd7d98e3..fe6c497dc2 100644
> --- a/hw/ufs/ufs-pci.c
> +++ b/hw/ufs/ufs-pci.c
> @@ -72,6 +72,10 @@ static const Property ufs_pci_props[] = {
>                         0x400),
>      DEFINE_PROP_UINT32("wb-min-size", UfsPciState, ufs.params.wb_min_size,
>                         0x100),
> +    DEFINE_PROP_UNSIGNED("x-hold-tag", UfsPciState, ufs.params.x_hold_tag,
> +                         UFS_HOLD_TAG_NONE, ufs_prop_hold_tag, uint32_t),
> +    DEFINE_PROP("x-hold-mode", UfsPciState, ufs.params.x_hold_mode,
> +                ufs_prop_hold_mode, char *),

Could we use names such as `x-fault-inject-tag` and
`x-fault-inject-mode`, so their deliberate fault-injection purpose is clear?

>  };
>  
>  static const VMStateDescription ufs_pci_vmstate = {
> diff --git a/hw/ufs/ufs-sysbus.c b/hw/ufs/ufs-sysbus.c
> index 84de2e95ac..f0e4dfcd71 100644
> --- a/hw/ufs/ufs-sysbus.c
> +++ b/hw/ufs/ufs-sysbus.c
> @@ -45,6 +45,10 @@ static const Property ufs_sysbus_props[] = {
>                         0x400),
>      DEFINE_PROP_UINT32("wb-min-size", SysbusUfsState, ufs.params.wb_min_size,
>                         0x100),
> +    DEFINE_PROP_UNSIGNED("x-hold-tag", SysbusUfsState, ufs.params.x_hold_tag,
> +                         UFS_HOLD_TAG_NONE, ufs_prop_hold_tag, uint32_t),
> +    DEFINE_PROP("x-hold-mode", SysbusUfsState, ufs.params.x_hold_mode,
> +                ufs_prop_hold_mode, char *),
>  };
>  
>  static const VMStateDescription ufs_sysbus_vmstate = {
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index ca5f6f2e96..3bdfe5762e 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -15,6 +15,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "scsi/constants.h"
>  #include "hw/core/irq.h"
>  #include "trace.h"
> @@ -816,6 +817,14 @@ static void ufs_hce_reset(UfsHc *u)
>          memset(u->mcq_op_reg, 0, sizeof(u->mcq_op_reg));
>      }
>  
> +    if (u->held_req) {
> +        u->held_req = NULL;
> +        u->active_hold_tag = UFS_HOLD_TAG_NONE;
> +        u->params.x_hold_tag = UFS_HOLD_TAG_NONE;
> +    } else {
> +        u->active_hold_tag = u->params.x_hold_tag;
> +    }
> +
>      u->resetting = false;
>  
>      /* 5. De-assert IRQ */
> @@ -873,27 +882,95 @@ static void ufs_process_tmr(UfsHc *u, uint32_t val)
>              task_tag = be32_to_cpu(desc.upiu_req.input_param2);
>  
>              if (tm_func == UFS_QUERY_TASK) {
> -                UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
> -
> -                if (req) {
> -                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED;
> +                if (u->held_req && task_tag == u->active_hold_tag) {
> +                    if (u->hold_mode == UFS_HOLD_IN_TRANSITION) {
> +                        UfsRequest *hreq = u->held_req;
> +                        u->held_req = NULL;
> +                        u->active_hold_tag = UFS_HOLD_TAG_NONE;
> +                        u->params.x_hold_tag = UFS_HOLD_TAG_NONE;
> +                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
> +                        if (hreq) {
> +                            uint16_t data_seg_len =
> +                                sizeof(hreq->rsp_upiu.sr.sense_data_len);
> +                            hreq->rsp_upiu.sr.sense_data_len = 0;
> +                            hreq->rsp_upiu.sr.residual_transfer_count = 0;
> +                            ufs_build_upiu_header(hreq,
> +                                                  UFS_UPIU_TRANSACTION_RESPONSE,
> +                                                  0,
> +                                                  UFS_COMMAND_RESULT_SUCCESS,
> +                                                  0,
> +                                                  data_seg_len);
> +                            ufs_complete_req(hreq, UFS_REQUEST_SUCCESS);
> +                        }
> +                    } else {
> +                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED;
> +                    }
>                  } else {
> -                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
> +                    UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
> +
> +                    if (req) {
> +                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED;
> +                    } else {
> +                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
> +                    }
>                  }
>              } else if (tm_func == UFS_ABORT_TASK) {
> -                UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
> -
> -                if (req) {
> -                    ufs_clear_req(req);
> -                    req->state = UFS_REQUEST_IDLE;
> -                    if (ufs_mcq_req(req)) {
> -                        QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
> -                        qemu_bh_schedule(req->sq->bh);
> +                if (u->held_req && task_tag == u->active_hold_tag) {
> +                    if (u->hold_mode == UFS_HOLD_ABORT_FAILED) {
> +                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_FAILED;
> +                    } else if (u->hold_mode == UFS_HOLD_TIMEOUT) {
> +                        continue;
> +                    } else if (u->hold_mode == UFS_HOLD_IN_TRANSITION) {
> +                        UfsRequest *hreq = u->held_req;
> +                        u->held_req = NULL;
> +                        u->active_hold_tag = UFS_HOLD_TAG_NONE;
> +                        u->params.x_hold_tag = UFS_HOLD_TAG_NONE;
> +                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
> +                        if (hreq) {
> +                            uint16_t data_seg_len =
> +                                sizeof(hreq->rsp_upiu.sr.sense_data_len);
> +                            hreq->rsp_upiu.sr.sense_data_len = 0;
> +                            hreq->rsp_upiu.sr.residual_transfer_count = 0;
> +                            ufs_build_upiu_header(hreq,
> +                                                  UFS_UPIU_TRANSACTION_RESPONSE,
> +                                                  0,
> +                                                  UFS_COMMAND_RESULT_SUCCESS,
> +                                                  0,
> +                                                  data_seg_len);
> +                            ufs_complete_req(hreq, UFS_REQUEST_SUCCESS);
> +                        }
>                      } else {
> -                        u->reg.utrldbr &= ~(1 << req->slot);
> +                        /* UFS_HOLD_ABORT_SUCCESS or default */
> +                        UfsRequest *hreq = u->held_req;
> +                        u->held_req = NULL;
> +                        ufs_clear_req(hreq);
> +                        hreq->state = UFS_REQUEST_IDLE;
> +                        if (ufs_mcq_req(hreq)) {
> +                            QTAILQ_INSERT_TAIL(&hreq->sq->req_list,
> +                                               hreq, entry);
> +                            qemu_bh_schedule(hreq->sq->bh);
> +                        } else {
> +                            u->reg.utrldbr &= ~(1 << hreq->slot);
> +                        }
> +                        u->active_hold_tag = UFS_HOLD_TAG_NONE;
> +                        u->params.x_hold_tag = UFS_HOLD_TAG_NONE;
> +                        tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
> +                    }
> +                } else {
> +                    UfsRequest *req = ufs_find_req_by_tag(u, task_tag);
> +
> +                    if (req) {
> +                        ufs_clear_req(req);
> +                        req->state = UFS_REQUEST_IDLE;
> +                        if (ufs_mcq_req(req)) {
> +                            QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
> +                            qemu_bh_schedule(req->sq->bh);
> +                        } else {
> +                            u->reg.utrldbr &= ~(1 << req->slot);
> +                        }
>                      }
> +                    tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
>                  }
> -                tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL;
>              } else {
>                  tm_resp = UFS_UPIU_TASK_MANAGEMENT_FUNC_NOT_SUPPORTED;
>              }
> @@ -2327,6 +2404,42 @@ static void ufs_exec_req(UfsRequest *req)
>          return;
>      }
>  
> +    if (unlikely(req->hc->active_hold_tag != UFS_HOLD_TAG_NONE)) {

Could we move this and the other fault-injection paths (TMR, reset, and
property updates) behind `ufs_fault_inject_*()` helpers?  This would keep
test-only logic out of the normal UFS paths.

> +        if (req->hc->active_hold_tag == UFS_HOLD_TAG_ANY) {
> +            if (req->req_upiu.header.trans_type ==
> +                UFS_UPIU_TRANSACTION_COMMAND) {
> +                uint8_t op = req->req_upiu.sc.cdb[0];
> +
> +                if (op == READ_10 || op == WRITE_10) {
> +                    /*
> +                     * In 10-byte SCSI read/write commands (SBC-4), bytes 2..5
> +                     * encode the 32-bit Logical Block Address (LBA) in
> +                     * big-endian.
> +                     */
> +                    uint32_t lba = ldl_be_p(&req->req_upiu.sc.cdb[2]);
> +
> +                    /*
> +                     * Only intercept target I/O targeting LBA >=
> +                     * UFS_HOLD_MIN_LBA. Skips guest boot-time partition table
> +                     * and superblock scanning.
> +                     */
> +                    if (lba >= UFS_HOLD_MIN_LBA) {
> +                        req->hc->active_hold_tag =
> +                            req->req_upiu.header.task_tag;
> +                        req->hc->held_req = req;
> +                        trace_ufs_inject_hold_req(req->req_upiu.header.task_tag,
> +                                                  lba);
> +                        return;
> +                    }
> +                }
> +            }
> +        } else if (req->req_upiu.header.task_tag == req->hc->active_hold_tag) {
> +            req->hc->held_req = req;
> +            trace_ufs_inject_hold_req(req->req_upiu.header.task_tag, 0);
> +            return;
> +        }
> +    }
> +
>      switch (req->req_upiu.header.trans_type) {
>      case UFS_UPIU_TRANSACTION_NOP_OUT:
>          req_result = ufs_exec_nop_cmd(req);
> @@ -2947,8 +3060,140 @@ static void ufs_init_hc(UfsHc *u)
>  
>      timer_init_ms(&u->idle_timer, QEMU_CLOCK_VIRTUAL_RT, ufs_idle_timer_cb, u);
>      timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
> +
> +    u->active_hold_tag = u->params.x_hold_tag;
> +    u->held_req = NULL;
> +}
> +
> +static void ufs_prop_get_hold_tag(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    Property *prop = opaque;
> +    uint32_t *ptr = object_field_prop_ptr(obj, prop);
> +    UfsParams *params = container_of(ptr, UfsParams, x_hold_tag);
> +    UfsHc *u = container_of(params, UfsHc, params);
> +
> +    visit_type_uint32(v, name, &u->active_hold_tag, errp);
> +}
> +
> +static void ufs_prop_set_hold_tag(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    Property *prop = opaque;
> +    uint32_t *ptr = object_field_prop_ptr(obj, prop);
> +    uint32_t val;
> +
> +    if (!visit_type_uint32(v, name, &val, errp)) {
> +        return;
> +    }
> +
> +    *ptr = val;
> +    UfsParams *params = container_of(ptr, UfsParams, x_hold_tag);
> +    UfsHc *u = container_of(params, UfsHc, params);
> +    u->active_hold_tag = val;

Since the tag can be changed at runtime via `qom-set`, `active_hold_tag` may
be updated while `held_req` still points to the previous request.  A later
match would then silently overwrite `held_req`; is that intentional?

-- 
Jeuk Kim <jeuk20.kim@samsung.com>


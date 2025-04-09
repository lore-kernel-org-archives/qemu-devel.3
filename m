Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE94AC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 09:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2RIW-0006VL-8K; Wed, 09 Apr 2025 05:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u2RIT-0006Tk-Jn
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 05:00:37 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u2RIR-0007MO-JD
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 05:00:37 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 6AC2F151C4D00;
 Wed,  9 Apr 2025 11:00:31 +0200 (CEST)
Message-ID: <8f64ff0d-c2e8-47c5-a02d-df211e45e78e@lauterbach.com>
Date: Wed, 9 Apr 2025 11:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] mcd: Implement register/memory access
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com, Eric Blake <eblake@redhat.com>
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <20250310150510.200607-14-mario.fleischmann@lauterbach.com>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <20250310150510.200607-14-mario.fleischmann@lauterbach.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1744189231444
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Just found out that in the call stack of address_space_rw, the len
argument eventually becomes the access width, if applicable. I wasn't
aware of that because GDB's 'm' and 'M' packets don't pose any
requirements on the access width ("the stub is free to use byte
accesses, or not") and therefore the gdbstub couldn't make advantage of
that.

MCD does have the field tx->access_width, so a v2 of this patch will
call the memory access functions repeatedly, with
len = tx->access_width (if set)

On 10.03.2025 16:11, Mario Fleischmann wrote:
> In MCD, all accesses to register or memory are issued over transaction lists.
> This commit implements three types of transactions:
> 
> * register access
> * logical memory access (with MMU)
> * physical memory access (no MMU)
> 
> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
> ---
>  mcd/libmcd_qapi.c  | 128 +++++++++++++++++++++++++++++++++
>  mcd/libmcd_qapi.h  |  14 ++++
>  mcd/mcdserver.c    | 176 ++++++++++++++++++++++++++++++++++++++++++++-
>  mcd/mcdstub_qapi.c |  26 +++++++
>  qapi/mcd.json      |  83 +++++++++++++++++++++
>  5 files changed, 425 insertions(+), 2 deletions(-)
> 
> [...]
> 
> diff --git a/mcd/mcdserver.c b/mcd/mcdserver.c
> index 116fbfaa30..837c0276e7 100644
> --- a/mcd/mcdserver.c
> +++ b/mcd/mcdserver.c
> @@ -1081,11 +1081,183 @@ mcd_return_et mcd_qry_trig_set_state_f(const mcd_core_st *core,
>      return g_server_state.last_error->return_status;
>  }
>  
> +static mcd_return_et execute_memory_tx(mcdcore_state *core_state, mcd_tx_st *tx,
> +                                       mcd_mem_type_et type)
> +{
> +    MemTxResult result;
> +
> +    /* each address space has one physical and one virtual memory */
> +    int address_space_id = (tx->addr.mem_space_id - 1) / 2;
> +    AddressSpace *as = cpu_get_address_space(core_state->cpu, address_space_id);
> +
> +    hwaddr addr = tx->addr.address;
> +    hwaddr len = tx->num_bytes;
> +    void *buf = tx->data;
> +    bool is_write;
> +
> +    if (tx->access_type == MCD_TX_AT_R) {
> +        is_write = false;
> +    } else if (tx->access_type == MCD_TX_AT_W) {
> +        is_write = true;
> +    } else {
> +        core_state->custom_error = (mcd_error_info_st) {
> +            .return_status = MCD_RET_ACT_HANDLE_ERROR,
> +            .error_code = MCD_ERR_TXLIST_TX,
> +            .error_events = MCD_ERR_EVT_NONE,
> +            .error_str = "tx access type not supported",
> +        };
> +        core_state->last_error = &core_state->custom_error;
> +        return core_state->last_error->return_status;
> +    }
> +
> +    if (type & MCD_MEM_SPACE_IS_PHYSICAL) {
> +        MemTxAttrs attrs = {
> +            .secure = !!(type & MCD_MEM_SPACE_IS_SECURE),
> +            .space = address_space_id,
> +        };
> +        result = address_space_rw(as, addr, attrs, buf, len, is_write);
> +    } else if (type & MCD_MEM_SPACE_IS_LOGICAL) {
> +        int ret = cpu_memory_rw_debug(core_state->cpu, addr, buf, len,
> +                                      is_write);
> +        result = (ret == 0) ? MEMTX_OK : MEMTX_ERROR;
> +    } else {
> +        core_state->custom_error = (mcd_error_info_st) {
> +            .return_status = MCD_RET_ACT_HANDLE_ERROR,
> +            .error_code = MCD_ERR_TXLIST_TX,
> +            .error_events = MCD_ERR_EVT_NONE,
> +            .error_str = "unknown mem space type",
> +        };
> +        core_state->last_error = &core_state->custom_error;
> +        return core_state->last_error->return_status;
> +    }
> +
> +    if (result != MEMTX_OK) {
> +        core_state->custom_error = (mcd_error_info_st) {
> +            .return_status = MCD_RET_ACT_HANDLE_ERROR,
> +            .error_code = is_write ? MCD_ERR_TXLIST_WRITE : MCD_ERR_TXLIST_READ,
> +            .error_events = MCD_ERR_EVT_NONE,
> +            .error_str = "",
> +        };
> +        snprintf(core_state->custom_error.error_str, MCD_INFO_STR_LEN,
> +                 "Memory tx failed with error code %d", result);
> +        core_state->last_error = &core_state->custom_error;
> +        return core_state->last_error->return_status;
> +    }
> +
> +    tx->num_bytes_ok = tx->num_bytes;
> +    core_state->last_error = &MCD_ERROR_NONE;
> +    return core_state->last_error->return_status;
> +}


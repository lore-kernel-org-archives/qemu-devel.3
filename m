Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6796C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 18:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH5AW-0006FC-WF; Mon, 19 May 2025 14:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uH5AH-0005vw-VY
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:24:45 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uH5AC-0000pW-HY
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:24:41 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 7AA971CC08A9E;
 Mon, 19 May 2025 20:24:33 +0200 (CEST)
Message-ID: <b9ba52b5-d369-407e-be0a-1a8d977b119f@lauterbach.com>
Date: Mon, 19 May 2025 20:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] mcd: Implement memory space query
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-12-mario.fleischmann@lauterbach.com>
 <swi6gh.1haj3eq3z930i@linaro.org>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <swi6gh.1haj3eq3z930i@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1747679073510
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

Thank you for taking the time to review this patch!

On 19.05.2025 12:00, Manos Pitsidianakis wrote:
> On Wed, 30 Apr 2025 08:27, Mario Fleischmann <mario.fleischmann@lauterbach.com> wrote:
>> Support three main memory space types:
>>
>> * Physical memory
>> * Logical memory (MMU)
>> * GDB Registers
>>
>> Use custom memory type to mark memory spaces as secure
>>
>> V=1 QTEST_QEMU_BINARY="./qemu-system-arm -M virt,secure=on -cpu cortex-a15" tests/qtest/mcd-test
>>
>> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
>> ---
>> mcd/mcd_qapi.c         |  22 +++++
>> mcd/mcd_qapi.h         |   2 +
>> mcd/mcd_server.c       | 199 ++++++++++++++++++++++++++++++++++-------
>> mcd/mcd_stub.c         |  44 +++++++++
>> qapi/mcd.json          | 199 +++++++++++++++++++++++++++++++++++++++++
>> tests/qtest/mcd-test.c |  79 ++++++++++++++++
>> tests/qtest/mcd-util.c |  20 +++++
>> tests/qtest/mcd-util.h |   3 +
>> 8 files changed, 534 insertions(+), 34 deletions(-)
>>
>> diff --git a/mcd/mcd_qapi.c b/mcd/mcd_qapi.c
>> index a1122f2..85428e2 100644
>> --- a/mcd/mcd_qapi.c
>> +++ b/mcd/mcd_qapi.c
>> @@ -125,3 +125,25 @@ mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info)
>>
>>     return unmarshal;
>> }
>> +
>> +MCDMemspace *marshal_mcd_memspace(const mcd_memspace_st *mem_space)
>> +{
>> +    MCDMemspace *marshal = g_malloc0(sizeof(*marshal));
>> +
>> +    *marshal = (MCDMemspace) {
>> +        .mem_space_id = mem_space->mem_space_id,
>> +        .mem_space_name = g_strdup(mem_space->mem_space_name),
>> +        .mem_type = mem_space->mem_type,
>> +        .bits_per_mau = mem_space->bits_per_mau,
>> +        .invariance = mem_space->invariance,
>> +        .endian = mem_space->endian,
>> +        .min_addr = mem_space->min_addr,
>> +        .max_addr = mem_space->max_addr,
>> +        .num_mem_blocks = mem_space->num_mem_blocks,
>> +        .supported_access_options = mem_space->supported_access_options,
>> +        .core_mode_mask_read = mem_space->core_mode_mask_read,
>> +        .core_mode_mask_write = mem_space->core_mode_mask_write,
>> +    };
>> +
>> +    return marshal;
>> +}
>> diff --git a/mcd/mcd_qapi.h b/mcd/mcd_qapi.h
>> index 45b3ac4..822870c 100644
>> --- a/mcd/mcd_qapi.h
>> +++ b/mcd/mcd_qapi.h
>> @@ -25,6 +25,8 @@ MCDServerInfo *marshal_mcd_server_info(const mcd_server_info_st *server_info);
>>
>> MCDCoreConInfo *marshal_mcd_core_con_info(const mcd_core_con_info_st *con_info);
>>
>> +MCDMemspace *marshal_mcd_memspace(const mcd_memspace_st *mem_space);
>> +
>> mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
>>
>> mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info);
>> diff --git a/mcd/mcd_server.c b/mcd/mcd_server.c
>> index 83ffa4f..77b28cf 100644
>> --- a/mcd/mcd_server.c
>> +++ b/mcd/mcd_server.c
>> @@ -12,6 +12,10 @@
>> #include "qemu/cutils.h"
>> #include "mcd_api.h"
>> #include "hw/boards.h"
>> +#include "exec/tswap.h"
>> +
>> +/* Custom memory space type */
>> +static const mcd_mem_type_et MCD_MEM_SPACE_IS_SECURE = 0x00010000;
>>
>> static const mcd_error_info_st MCD_ERROR_NOT_IMPLEMENTED = {
>>     .return_status = MCD_RET_ACT_HANDLE_ERROR,
>> @@ -48,37 +52,45 @@ static const mcd_error_info_st MCD_ERROR_NONE = {
>>     .error_str = "",
>> };
>>
>> -/* reserves memory for custom errors */
>> -static mcd_error_info_st custom_mcd_error;
>> -
>> /**
>>  * struct mcdcore_state - State of a core.
>>  *
>> - * @last_error: Error info of most recent executed function.
>> - * @info:       Core connection information.
>> - * @open_core:  Open core instance as allocated in mcd_open_core_f().
>> + * @last_error:    Error info of most recent executed core-related function.
>> + * @custom_error:  Reserves memory for custom MCD errors.
>> + * @info:          Core connection information.
>> + * @open_core:     Open core instance as allocated in mcd_open_core_f().
>> + * @cpu:           QEMU's internal CPU handle.
>> + * @memory_spaces: Memory spaces as queried by mcd_qry_mem_spaces_f().
>>  *
>>  * MCD is mainly being used on the core level:
>>  * After the initial query functions, a core connection is opened in
>>  * mcd_open_core_f(). The allocated mcd_core_st instance is then the basis
>>  * of subsequent operations.
>> + *
>> + * @cpu is the internal CPU handle through which core specific debug
>> + * functions are implemented.
>>  */
>> typedef struct mcdcore_state {
>>     const mcd_error_info_st *last_error;
>> +    mcd_error_info_st custom_error;
> 
> This patch LGTM overall (though I'm still not familiar with MCD itself, 
> it's new to me) but this change feels unrelated to this patch. Maybe 
> introduce custom_error field back in the patch that adds mcdcore_state 
> and don't create the custom_mcd_error static in the first place? This'd 
> also reduce the amount of diff lines in patches.
> 
> This is just a suggestion, I realise it means more work for you, so feel 
> free to ignore it.

I tried to only include changes in the patches that are necessary for
the current use case but I guess in this case and the one from
  [PATCH v2 07/20] mcd: Implement target initialization API
assuming _some_ future use case will result in a more explanatory patch
series overall... I'll see what I can do!

[...]

>> @@ -613,8 +686,66 @@ mcd_return_et mcd_qry_mem_spaces_f(const mcd_core_st *core,
>>                                    uint32_t *num_mem_spaces,
>>                                    mcd_memspace_st *mem_spaces)
>> {
>> -    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
>> -    return g_server_state.last_error->return_status;
>> +    uint32_t i;
>> +    mcdcore_state *core_state;
>> +
>> +    if (!core || !num_mem_spaces) {
>> +        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
>> +        return g_server_state.last_error->return_status;
>> +    }
>> +
>> +    core_state = find_core(core->core_con_info);
>> +    if (!core_state || core_state->open_core != core) {
>> +        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
>> +        return g_server_state.last_error->return_status;
>> +    }
>> +
>> +    g_assert(core_state->memory_spaces);
>> +
>> +    if (core_state->memory_spaces->len == 0) {
>> +        core_state->custom_error = (mcd_error_info_st) {
>> +            .return_status = MCD_RET_ACT_HANDLE_ERROR,
>> +            .error_code = MCD_ERR_NO_MEM_SPACES,
>> +            .error_events = MCD_ERR_EVT_NONE,
>> +            .error_str = "",
>> +        };
>> +        core_state->last_error = &core_state->custom_error;
>> +        return core_state->last_error->return_status;
>> +    }
>> +
>> +    if (*num_mem_spaces == 0) {
>> +        *num_mem_spaces = core_state->memory_spaces->len;
>> +        core_state->last_error = &MCD_ERROR_NONE;
>> +        return core_state->last_error->return_status;
>> +    }
>> +
>> +    if (start_index >= core_state->memory_spaces->len) {
> 
> The first memory space gets an index of len + 1 == 1, since it's 
> mentioned earlier that 0 is reserved, so if start_index is 1 should we 
> not be failing here? Or am I misunderstanding something? Is start_index 
> 0-based and mem_space_id 1-based?

Yes, this a gotcha from the MCD API...

/**
 * mcd_qry_mem_spaces_f() - Function querying the available memory
                            spaces for a particular component.
 *
 * @core:        [in] A reference to the core the calling function
                      addresses.
 * @start_index: [in] Start index of the requested memory spaces. This
                      refers to an internal list of the target side
                      implementation.
 * ...
 */

As an example, it should be possible that the server manages memory
spaces with the IDs [5, 4, 1, 3] internally. start_index = 0 would then
point to the memory space with ID 5.

I will add a comment for it in the source code and in the commit message.

[...]

>> diff --git a/mcd/mcd_stub.c b/mcd/mcd_stub.c
>> index c49fcb4..5d749c4 100644
>> --- a/mcd/mcd_stub.c
>> +++ b/mcd/mcd_stub.c
>> @@ -379,3 +379,47 @@ MCDErrorInfo *qmp_mcd_qry_error_info(uint32_t core_uid, Error **errp)
>>     result = marshal_mcd_error_info(&error_info);
>>     return result;
>> }
>> +
>> +MCDQryMemSpacesResult *qmp_mcd_qry_mem_spaces(uint32_t core_uid,
>> +                                              uint32_t start_index,
>> +                                              uint32_t num_mem_spaces,
>> +                                              Error **errp)
>> +{
>> +    MCDMemspaceList **tailp;
>> +    MCDMemspace *ms;
>> +    mcd_memspace_st *memspaces = NULL;
>> +    bool query_num_only = num_mem_spaces == 0;
>> +    MCDQryMemSpacesResult *result = g_malloc0(sizeof(*result));
>> +    mcd_core_st *core = NULL;
>> +
>> +    if (retrieve_open_core(core_uid, &core) != MCD_RET_ACT_NONE) {
>> +        g_stub_state.on_error_ask_server = false;
>> +    }
>> +
>> +    if (!query_num_only) {
>> +        memspaces = g_malloc0(num_mem_spaces * sizeof(*memspaces));
>> +    }
>> +
>> +    result->return_status = mcd_qry_mem_spaces_f(core, start_index,
>> +                                                 &num_mem_spaces, memspaces);
>> +
>> +    if (result->return_status == MCD_RET_ACT_NONE) {
>> +        result->has_num_mem_spaces = true;
>> +        result->num_mem_spaces = num_mem_spaces;
>> +        if (!query_num_only) {
>> +            result->has_mem_spaces = true;
>> +            tailp = &(result->mem_spaces);
>> +            for (uint32_t i = 0; i < num_mem_spaces; i++) {
>> +                ms = marshal_mcd_memspace(memspaces + i);
>> +                QAPI_LIST_APPEND(tailp, ms);
>> +            }
>> +        }
>> +    }
>> +
>> +    if (!query_num_only) {
>> +        g_free(memspaces);
> 
> Who is responsible for freeing result and memspaces (if 
> (query_num_only)) in this function? Could you accompany every g_malloc* 
> with a comment that explains the resource's lifetime?

Since, every qmp_mcd_* function follows a similar structure, would a
comment at the top of mcd_stub.c suffice?

Function arguments and return values are freed by the QAPI
infrastructure, i.e. qmp_marshal_mcd_qry_mem_spaces and
qmp_marshal_output_MCDQryRegGroupsResult in
build/mcd/mcd-qapi-commands.c

For MCD server functions, the ownership of arguments is defined by the
MCD API with the server stub being the caller of the function.
Therefore, the memspaces array needs to be freed by qmp_mcd_qry_mem_spaces.


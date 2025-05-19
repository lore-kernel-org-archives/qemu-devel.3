Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B8DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 10:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGxII-0004u4-TK; Mon, 19 May 2025 06:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uGxIH-0004tt-5b
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:00:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uGxID-0003H4-Ey
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:00:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so45512385e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747648819; x=1748253619; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sLCG6pNtQGk+wWWMQbAd29IyHaHQVq/rmWQd3yOQ8CM=;
 b=wQul+/y7/1jU1Pc0bFheJ3AvKA8iWgYtsBa4RMQsf8IIX9nI8/xCDnEocEJXlU5i5Y
 YJrn8LIFiVLXUkYNT3jxGdWo+X0lmzJ383nAUnBeDdA2TQngEe30d6/z30FfdWI77A9l
 YjQTlOm2Ss1f18aW7QylsEVMgg2c6qR7MBmrPw11Ulhk5j95Dgu4Vo4bf9UUm3cg6bhi
 THohLY6MtvbDbZ9Hqr0acsMAHfSWazGMNG3hhqam6esPvKQFQjEK4KknUWk0iBX3Unw/
 IzgKHNqazGN/wPWWYxpiWwIlavQJ0HQcarNsvBIJwkzXc8V4jkaWxMuG1M5ZlI6368hk
 HUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747648819; x=1748253619;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLCG6pNtQGk+wWWMQbAd29IyHaHQVq/rmWQd3yOQ8CM=;
 b=E4Gt6QTnjsNvHLqAKKuwzJ4d4J9igm1qcToFskUvKHWh++8QVfRARPye94JRtM8Rzi
 2ZVU4w3jvBmViYy0BT5ZuTLivsbEvAGozFc2qdScNTJDCwenKnzr9jIzrHWw4YHag4e3
 zIZr8lVcUJ1aGjloAKUhzAzBQX8ZSM1TYXX9SC6LnoZmp7R1o9CtrnPmKLxYGw6bIMrS
 YUWUo1gIQPOi9Wo3lTtggVSG6k27iqNTRfBpb/CAEMFcbg9A2udXTAMdoL+LRtz4JCiC
 4TUfS9OdLG2J5ne7KAkS0Uy9BTlk5K9gRv4lsIu97v5o2bIHc1h37XbhCrbQuY7gEQcR
 mHyw==
X-Gm-Message-State: AOJu0YxrLCeRB5G/K9fr3ZjJtm3ehHpPTwr18DgwmYlGEmpCk7G9L0XW
 qY0QymJsFnG8l8xJU3hiFJkTSgo9A5+4x3F6evpShajH/+AMh4WGWIoujuIrWq9h60mJqrQry08
 bKTOlO04=
X-Gm-Gg: ASbGncsNk2WjWh/PjooQ18nfSdYeAG4PoB402cjJ1PJSvgOUZqQacPtUIHTTQvQjMXN
 Hd5qkC8A0P0ecDSzxWS1UgB6p+1aw7qFSEdfmEezZd50MM0El+PIRWBJlJ4x/PEaVQEJLVe2Pj/
 WCIVk1Xn52nk6pRibNY7oaXV4MEjAjahkCYih+qg9ufAq0YkvWC6z/KtPfds0orXFygnh4Hmvz2
 eIMtfIeo84aua/LO3iHG5qXo1PV8XuPTRLNkJcpWqIbTvYfvGHDUx7JqaULP5yjHk7/Le+cCAsf
 32zp8ftCr3UyUbVC4wGqDgH/Z1/+vq28L9NM5w5VITfbV++xxPizqVskap/GRxGLz6icuUxpACe
 1i8Grxv9yRgxELw==
X-Google-Smtp-Source: AGHT+IE1VIduSG2EueI62EyeAhlJr6LvLbD6XQa1/j4STst5T4vorOm74OzlzLJx6qOsc9fyItP1Ug==
X-Received: by 2002:a05:600c:1e1c:b0:43c:fffc:7855 with SMTP id
 5b1f17b1804b1-442feffb6damr124901555e9.15.1747648818847; 
 Mon, 19 May 2025 03:00:18 -0700 (PDT)
Received: from meli-email.org (adsl-1.37.6.162.tellas.gr. [37.6.162.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd5107f8sm130285155e9.16.2025.05.19.03.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 03:00:18 -0700 (PDT)
Date: Mon, 19 May 2025 12:41:28 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: Re: [PATCH v2 11/20] mcd: Implement memory space query
User-Agent: meli/0.8.12
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-12-mario.fleischmann@lauterbach.com>
In-Reply-To: <20250430052741.21145-12-mario.fleischmann@lauterbach.com>
Message-ID: <swi6gh.1haj3eq3z930i@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

On Wed, 30 Apr 2025 08:27, Mario Fleischmann <mario.fleischmann@lauterbach.com> wrote:
>Support three main memory space types:
>
>* Physical memory
>* Logical memory (MMU)
>* GDB Registers
>
>Use custom memory type to mark memory spaces as secure
>
>V=1 QTEST_QEMU_BINARY="./qemu-system-arm -M virt,secure=on -cpu cortex-a15" tests/qtest/mcd-test
>
>Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
>---
> mcd/mcd_qapi.c         |  22 +++++
> mcd/mcd_qapi.h         |   2 +
> mcd/mcd_server.c       | 199 ++++++++++++++++++++++++++++++++++-------
> mcd/mcd_stub.c         |  44 +++++++++
> qapi/mcd.json          | 199 +++++++++++++++++++++++++++++++++++++++++
> tests/qtest/mcd-test.c |  79 ++++++++++++++++
> tests/qtest/mcd-util.c |  20 +++++
> tests/qtest/mcd-util.h |   3 +
> 8 files changed, 534 insertions(+), 34 deletions(-)
>
>diff --git a/mcd/mcd_qapi.c b/mcd/mcd_qapi.c
>index a1122f2..85428e2 100644
>--- a/mcd/mcd_qapi.c
>+++ b/mcd/mcd_qapi.c
>@@ -125,3 +125,25 @@ mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info)
> 
>     return unmarshal;
> }
>+
>+MCDMemspace *marshal_mcd_memspace(const mcd_memspace_st *mem_space)
>+{
>+    MCDMemspace *marshal = g_malloc0(sizeof(*marshal));
>+
>+    *marshal = (MCDMemspace) {
>+        .mem_space_id = mem_space->mem_space_id,
>+        .mem_space_name = g_strdup(mem_space->mem_space_name),
>+        .mem_type = mem_space->mem_type,
>+        .bits_per_mau = mem_space->bits_per_mau,
>+        .invariance = mem_space->invariance,
>+        .endian = mem_space->endian,
>+        .min_addr = mem_space->min_addr,
>+        .max_addr = mem_space->max_addr,
>+        .num_mem_blocks = mem_space->num_mem_blocks,
>+        .supported_access_options = mem_space->supported_access_options,
>+        .core_mode_mask_read = mem_space->core_mode_mask_read,
>+        .core_mode_mask_write = mem_space->core_mode_mask_write,
>+    };
>+
>+    return marshal;
>+}
>diff --git a/mcd/mcd_qapi.h b/mcd/mcd_qapi.h
>index 45b3ac4..822870c 100644
>--- a/mcd/mcd_qapi.h
>+++ b/mcd/mcd_qapi.h
>@@ -25,6 +25,8 @@ MCDServerInfo *marshal_mcd_server_info(const mcd_server_info_st *server_info);
> 
> MCDCoreConInfo *marshal_mcd_core_con_info(const mcd_core_con_info_st *con_info);
> 
>+MCDMemspace *marshal_mcd_memspace(const mcd_memspace_st *mem_space);
>+
> mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
> 
> mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info);
>diff --git a/mcd/mcd_server.c b/mcd/mcd_server.c
>index 83ffa4f..77b28cf 100644
>--- a/mcd/mcd_server.c
>+++ b/mcd/mcd_server.c
>@@ -12,6 +12,10 @@
> #include "qemu/cutils.h"
> #include "mcd_api.h"
> #include "hw/boards.h"
>+#include "exec/tswap.h"
>+
>+/* Custom memory space type */
>+static const mcd_mem_type_et MCD_MEM_SPACE_IS_SECURE = 0x00010000;
> 
> static const mcd_error_info_st MCD_ERROR_NOT_IMPLEMENTED = {
>     .return_status = MCD_RET_ACT_HANDLE_ERROR,
>@@ -48,37 +52,45 @@ static const mcd_error_info_st MCD_ERROR_NONE = {
>     .error_str = "",
> };
> 
>-/* reserves memory for custom errors */
>-static mcd_error_info_st custom_mcd_error;
>-
> /**
>  * struct mcdcore_state - State of a core.
>  *
>- * @last_error: Error info of most recent executed function.
>- * @info:       Core connection information.
>- * @open_core:  Open core instance as allocated in mcd_open_core_f().
>+ * @last_error:    Error info of most recent executed core-related function.
>+ * @custom_error:  Reserves memory for custom MCD errors.
>+ * @info:          Core connection information.
>+ * @open_core:     Open core instance as allocated in mcd_open_core_f().
>+ * @cpu:           QEMU's internal CPU handle.
>+ * @memory_spaces: Memory spaces as queried by mcd_qry_mem_spaces_f().
>  *
>  * MCD is mainly being used on the core level:
>  * After the initial query functions, a core connection is opened in
>  * mcd_open_core_f(). The allocated mcd_core_st instance is then the basis
>  * of subsequent operations.
>+ *
>+ * @cpu is the internal CPU handle through which core specific debug
>+ * functions are implemented.
>  */
> typedef struct mcdcore_state {
>     const mcd_error_info_st *last_error;
>+    mcd_error_info_st custom_error;

This patch LGTM overall (though I'm still not familiar with MCD itself, 
it's new to me) but this change feels unrelated to this patch. Maybe 
introduce custom_error field back in the patch that adds mcdcore_state 
and don't create the custom_mcd_error static in the first place? This'd 
also reduce the amount of diff lines in patches.

This is just a suggestion, I realise it means more work for you, so feel 
free to ignore it.

>     mcd_core_con_info_st info;
>     mcd_core_st *open_core;
>+    CPUState *cpu;
>+    GArray *memory_spaces;
> } mcdcore_state;
> 
> /**
>  * struct mcdserver_state - State of the MCD server
>  *
>- * @last_error:  Error info of most recent executed function.
>- * @open_server: Open server instance as allocated in mcd_open_server_f().
>- * @system_key:  System key as provided in mcd_open_server_f()
>- * @cores:       Internal core information database.
>+ * @last_error:   Error info of most recent executed function.
>+ * @custom_error: Reserves memory for custom MCD errors.
>+ * @open_server:  Open server instance as allocated in mcd_open_server_f().
>+ * @system_key:   System key as provided in mcd_open_server_f()
>+ * @cores:        Internal core information database.
>  */
> typedef struct mcdserver_state {
>     const mcd_error_info_st *last_error;
>+    mcd_error_info_st custom_error;
>     mcd_server_st *open_server;
>     char system_key[MCD_KEY_LEN];
>     GArray *cores;
>@@ -134,13 +146,13 @@ mcd_return_et mcd_initialize_f(const mcd_api_version_st *version_req,
>         version_req->v_api_minor <= MCD_API_VER_MINOR) {
>         g_server_state.last_error = &MCD_ERROR_NONE;
>     } else {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_GENERAL,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "incompatible versions",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>     }
> 
>     return g_server_state.last_error->return_status;
>@@ -160,13 +172,13 @@ mcd_return_et mcd_qry_servers_f(const char *host, bool running,
>                                 mcd_server_info_st *server_info)
> {
>     if (start_index >= 1) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_PARAM,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "QEMU only has one MCD server",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>         return g_server_state.last_error->return_status;
>     }
> 
>@@ -214,13 +226,13 @@ mcd_return_et mcd_open_server_f(const char *system_key,
>     CPUState *cpu;
> 
>     if (g_server_state.open_server) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_CONNECTION,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "server already open",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>         return g_server_state.last_error->return_status;
>     }
> 
>@@ -253,6 +265,8 @@ mcd_return_et mcd_open_server_f(const char *system_key,
>             },
>             .last_error = &MCD_ERROR_NONE,
>             .open_core = NULL,
>+            .cpu = cpu,
>+            .memory_spaces = g_array_new(false, true, sizeof(mcd_memspace_st)),
>         };
>         pstrcpy(c.info.core, MCD_UNIQUE_NAME_LEN, cpu_model);
>         g_array_append_val(g_server_state.cores, c);
>@@ -265,24 +279,24 @@ mcd_return_et mcd_open_server_f(const char *system_key,
> mcd_return_et mcd_close_server_f(const mcd_server_st *server)
> {
>     if (!g_server_state.open_server) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_CONNECTION,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "server not open",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>         return g_server_state.last_error->return_status;
>     }
> 
>     if (server != g_server_state.open_server) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_CONNECTION,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "unknown server",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>         return g_server_state.last_error->return_status;
>     }
> 
>@@ -333,13 +347,13 @@ mcd_return_et mcd_qry_systems_f(uint32_t start_index, uint32_t *num_systems,
>     }
> 
>     if (start_index >= 1) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_PARAM,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "QEMU only emulates one system",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>         return g_server_state.last_error->return_status;
>     }
> 
>@@ -381,13 +395,13 @@ mcd_return_et mcd_qry_devices_f(const mcd_core_con_info_st *system_con_info,
>     }
> 
>     if (start_index >= 1) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_PARAM,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "QEMU only emulates one machine",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>         return g_server_state.last_error->return_status;
>     }
> 
>@@ -431,13 +445,13 @@ mcd_return_et mcd_qry_cores_f(const mcd_core_con_info_st *connection_info,
>     }
> 
>     if (start_index >= g_server_state.cores->len) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_PARAM,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "start_index exceeds the number of cores",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>         return g_server_state.last_error->return_status;
>     }
> 
>@@ -471,6 +485,59 @@ mcd_return_et mcd_qry_core_modes_f(const mcd_core_st *core,
>     return g_server_state.last_error->return_status;
> }
> 
>+static mcd_return_et query_memspaces(mcdcore_state *core_state)
>+{
>+    g_array_set_size(core_state->memory_spaces, 0);
>+
>+    mcd_endian_et endian = target_big_endian() ? MCD_ENDIAN_BIG
>+                                               : MCD_ENDIAN_LITTLE;
>+
>+    for (uint32_t i = 0; i < core_state->cpu->num_ases; i++) {
>+        AddressSpace *as = cpu_get_address_space(core_state->cpu, i);
>+
>+        int secure_flag = 0;
>+        if (core_state->cpu->num_ases > 1) {
>+            int sid = cpu_asidx_from_attrs(core_state->cpu,
>+                                           (MemTxAttrs) { .secure = 1 });
>+            if (i == sid) {
>+                secure_flag = MCD_MEM_SPACE_IS_SECURE;
>+            }
>+        }
>+
>+        const char *as_name = as->name;
>+        const char *mr_name = as->root->name;
>+
>+        mcd_memspace_st physical = {
>+            /* mem space ID 0 is reserved */
>+            .mem_space_id = core_state->memory_spaces->len + 1,
>+            .mem_type = MCD_MEM_SPACE_IS_PHYSICAL | secure_flag,
>+            .endian = endian,
>+        };
>+        strncpy(physical.mem_space_name, mr_name, MCD_MEM_SPACE_NAME_LEN - 1);
>+
>+        g_array_append_val(core_state->memory_spaces, physical);
>+
>+        mcd_memspace_st logical = {
>+            .mem_space_id = core_state->memory_spaces->len + 1,
>+            .mem_type = MCD_MEM_SPACE_IS_LOGICAL | secure_flag,
>+            .endian = endian,
>+        };
>+        strncpy(logical.mem_space_name, as_name, MCD_MEM_SPACE_NAME_LEN - 1);
>+
>+        g_array_append_val(core_state->memory_spaces, logical);
>+    }
>+
>+    mcd_memspace_st gdb_registers = {
>+        .mem_space_id = core_state->memory_spaces->len + 1,
>+        .mem_space_name = "GDB Registers",
>+        .mem_type = MCD_MEM_SPACE_IS_REGISTERS,
>+        .endian = endian,
>+    };
>+    g_array_append_val(core_state->memory_spaces, gdb_registers);
>+
>+    return MCD_RET_ACT_NONE;
>+}
>+
> mcd_return_et mcd_open_core_f(const mcd_core_con_info_st *core_con_info,
>                               mcd_core_st **core)
> {
>@@ -490,25 +557,29 @@ mcd_return_et mcd_open_core_f(const mcd_core_con_info_st *core_con_info,
> 
>     core_id = core_con_info->core_id;
>     if (core_id > g_server_state.cores->len) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_PARAM,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "specified core index exceeds the number of cores",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>         return g_server_state.last_error->return_status;
>     }
> 
>     core_state = &g_array_index(g_server_state.cores, mcdcore_state, core_id);
>     if (core_state->open_core) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_CONNECTION,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "core already open",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>+        return g_server_state.last_error->return_status;
>+    }
>+
>+    if (query_memspaces(core_state) != MCD_RET_ACT_NONE) {
>         return g_server_state.last_error->return_status;
>     }
> 
>@@ -540,19 +611,21 @@ mcd_return_et mcd_close_core_f(const mcd_core_st *core)
>     }
> 
>     if (core_state->open_core != core) {
>-        custom_mcd_error = (mcd_error_info_st) {
>+        g_server_state.custom_error = (mcd_error_info_st) {
>             .return_status = MCD_RET_ACT_HANDLE_ERROR,
>             .error_code = MCD_ERR_CONNECTION,
>             .error_events = MCD_ERR_EVT_NONE,
>             .error_str = "core not open",
>         };
>-        g_server_state.last_error = &custom_mcd_error;
>+        g_server_state.last_error = &g_server_state.custom_error;
>         return g_server_state.last_error->return_status;
>     }
> 
>     g_free((void *)core->core_con_info);
>     g_free((void *)core);
>     core_state->open_core = NULL;
>+    core_state->cpu = NULL;
>+    g_array_set_size(core_state->memory_spaces, 0);
> 
>     g_server_state.last_error = &MCD_ERROR_NONE;
>     return g_server_state.last_error->return_status;
>@@ -613,8 +686,66 @@ mcd_return_et mcd_qry_mem_spaces_f(const mcd_core_st *core,
>                                    uint32_t *num_mem_spaces,
>                                    mcd_memspace_st *mem_spaces)
> {
>-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
>-    return g_server_state.last_error->return_status;
>+    uint32_t i;
>+    mcdcore_state *core_state;
>+
>+    if (!core || !num_mem_spaces) {
>+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
>+        return g_server_state.last_error->return_status;
>+    }
>+
>+    core_state = find_core(core->core_con_info);
>+    if (!core_state || core_state->open_core != core) {
>+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
>+        return g_server_state.last_error->return_status;
>+    }
>+
>+    g_assert(core_state->memory_spaces);
>+
>+    if (core_state->memory_spaces->len == 0) {
>+        core_state->custom_error = (mcd_error_info_st) {
>+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
>+            .error_code = MCD_ERR_NO_MEM_SPACES,
>+            .error_events = MCD_ERR_EVT_NONE,
>+            .error_str = "",
>+        };
>+        core_state->last_error = &core_state->custom_error;
>+        return core_state->last_error->return_status;
>+    }
>+
>+    if (*num_mem_spaces == 0) {
>+        *num_mem_spaces = core_state->memory_spaces->len;
>+        core_state->last_error = &MCD_ERROR_NONE;
>+        return core_state->last_error->return_status;
>+    }
>+
>+    if (start_index >= core_state->memory_spaces->len) {

The first memory space gets an index of len + 1 == 1, since it's 
mentioned earlier that 0 is reserved, so if start_index is 1 should we 
not be failing here? Or am I misunderstanding something? Is start_index 
0-based and mem_space_id 1-based?

>+        core_state->custom_error = (mcd_error_info_st) {
>+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
>+            .error_code = MCD_ERR_PARAM,
>+            .error_events = MCD_ERR_EVT_NONE,
>+            .error_str = "start_index exceeds the number of memory spaces",
>+        };
>+        core_state->last_error = &core_state->custom_error;
>+        return core_state->last_error->return_status;
>+    }
>+
>+    if (!mem_spaces) {
>+        core_state->last_error = &MCD_ERROR_INVALID_NULL_PARAM;
>+        return core_state->last_error->return_status;
>+    }
>+
>+    for (i = 0; i < *num_mem_spaces &&
>+         start_index + i < core_state->memory_spaces->len; i++) {
>+
>+        mem_spaces[i] = g_array_index(core_state->memory_spaces,
>+                                      mcd_memspace_st, start_index + i);
>+    }
>+
>+    *num_mem_spaces = i;
>+
>+    core_state->last_error = &MCD_ERROR_NONE;
>+    return core_state->last_error->return_status;
> }
> 
> mcd_return_et mcd_qry_mem_blocks_f(const mcd_core_st *core,
>diff --git a/mcd/mcd_stub.c b/mcd/mcd_stub.c
>index c49fcb4..5d749c4 100644
>--- a/mcd/mcd_stub.c
>+++ b/mcd/mcd_stub.c
>@@ -379,3 +379,47 @@ MCDErrorInfo *qmp_mcd_qry_error_info(uint32_t core_uid, Error **errp)
>     result = marshal_mcd_error_info(&error_info);
>     return result;
> }
>+
>+MCDQryMemSpacesResult *qmp_mcd_qry_mem_spaces(uint32_t core_uid,
>+                                              uint32_t start_index,
>+                                              uint32_t num_mem_spaces,
>+                                              Error **errp)
>+{
>+    MCDMemspaceList **tailp;
>+    MCDMemspace *ms;
>+    mcd_memspace_st *memspaces = NULL;
>+    bool query_num_only = num_mem_spaces == 0;
>+    MCDQryMemSpacesResult *result = g_malloc0(sizeof(*result));
>+    mcd_core_st *core = NULL;
>+
>+    if (retrieve_open_core(core_uid, &core) != MCD_RET_ACT_NONE) {
>+        g_stub_state.on_error_ask_server = false;
>+    }
>+
>+    if (!query_num_only) {
>+        memspaces = g_malloc0(num_mem_spaces * sizeof(*memspaces));
>+    }
>+
>+    result->return_status = mcd_qry_mem_spaces_f(core, start_index,
>+                                                 &num_mem_spaces, memspaces);
>+
>+    if (result->return_status == MCD_RET_ACT_NONE) {
>+        result->has_num_mem_spaces = true;
>+        result->num_mem_spaces = num_mem_spaces;
>+        if (!query_num_only) {
>+            result->has_mem_spaces = true;
>+            tailp = &(result->mem_spaces);
>+            for (uint32_t i = 0; i < num_mem_spaces; i++) {
>+                ms = marshal_mcd_memspace(memspaces + i);
>+                QAPI_LIST_APPEND(tailp, ms);
>+            }
>+        }
>+    }
>+
>+    if (!query_num_only) {
>+        g_free(memspaces);

Who is responsible for freeing result and memspaces (if 
(query_num_only)) in this function? Could you accompany every g_malloc* 
with a comment that explains the resource's lifetime?


>+    }
>+
>+    g_stub_state.on_error_ask_server = true;
>+    return result;
>+}
>diff --git a/qapi/mcd.json b/qapi/mcd.json
>index 7219056..214933e 100644
>--- a/qapi/mcd.json
>+++ b/qapi/mcd.json
>@@ -147,6 +147,74 @@
>     'core-id'        : 'uint32' } }
> 
> 
>+##
>+# @MCDMemspace:
>+#
>+# Structure type containing information about a memory space.
>+#
>+# @mem-space-id:             ID of this memory space, ID 0 is reserved.
>+# @mem-space-name:           Unique name of the memory space.
>+# @mem-type:                 Type of the memory space.
>+# @bits-per-mau:             Bits per minimum addressable unit (MAU). The
>+#                            minimum addressable unit of a memory is defined as
>+#                            the size in bits of its basic block that may have
>+#                            a unique address. For example for a byte
>+#                            addressable memory this value would be set to '8'
>+#                            according to the 8 bits of a byte block.
>+# @invariance:               The total number of bytes in a memory word, which
>+#                            is @bits-per-mau divided by 8, consists of groups
>+#                            of "invariant" bytes. These groups can be arranged
>+#                            in Big Endian or Little Endian order.
>+#                            For example an @invariance of '2' and '64'
>+#                            @bits-per-mau, a Little Endian word are
>+#                            represented as b0 b1 b2 b3 b4 b5 b6 b7.
>+#                            In contrast to this, a Big Endian word is
>+#                            represented as b6 b7 b4 b5 b2 b3 b0 b1.
>+# @endian:                   Endianness of this memory space. Can be overriden
>+#                            by @endian of a MCDMemblock.
>+# @min-addr:                 Minimum address of this memory space.
>+# @max-addr:                 Maximum address of this memory space.
>+# @num-mem-blocks:           Number of memory blocks in this memory space. Each
>+#                            memory space may have a certain number of memory
>+#                            blocks. Memory blocks contain additional
>+#                            information pertaining to the intended purpose of
>+#                            the memory. This information may be used as a hint
>+#                            for memory data representation within a tool's
>+#                            memory view. This field specifies the number of
>+#                            memory blocks present in this memory space.
>+# @supported-access-options: Supported memory access options (OR'ed bitmask).
>+#                            Can be overriden by @supported-access-options of a
>+#                            MCDMemblock.
>+# @core-mode-mask-read:      Mask of core modes for which read accesses are
>+#                            impossible. A set bit indicates that read accesses
>+#                            are denied in this mode. Bit 0 represents core
>+#                            mode '1', bit 31 represents core mode '32'. Can be
>+#                            overriden by @core-mode-mask-read of a MCDMemblock.
>+# @core-mode-mask-write:     Mask of core modes for which write accesses are
>+#                            impossible; a set bit indicates that write
>+#                            accesses are denied in this mode. Bit 0 represents
>+#                            core mode '1', bit 31 represents core mode '32'.
>+#                            Can be overriden by
>+#                            @core-mode-mask-write of a MCDMemblock.
>+#
>+# Since: 9.1
>+##
>+{ 'struct': 'MCDMemspace',
>+  'data': {
>+    'mem-space-id'            : 'uint32',
>+    'mem-space-name'          : 'str',
>+    'mem-type'                : 'uint32',
>+    'bits-per-mau'            : 'uint32',
>+    'invariance'              : 'uint8',
>+    'endian'                  : 'uint32',
>+    'min-addr'                : 'uint64',
>+    'max-addr'                : 'uint64',
>+    'num-mem-blocks'          : 'uint32',
>+    'supported-access-options': 'uint32',
>+    'core-mode-mask-read'     : 'uint32',
>+    'core-mode-mask-write'    : 'uint32' } }
>+
>+
> ##
> # == Target Initialization API
> ##
>@@ -878,3 +946,134 @@
> { 'command': 'mcd-qry-error-info',
>   'data': { 'core-uid': 'uint32' },
>   'returns': 'MCDErrorInfo' }
>+
>+
>+##
>+# @MCDQryMemSpacesResult:
>+#
>+# Return value of @mcd-qry-mem-spaces.
>+#
>+# @return-status:  Return code.
>+# @num-mem-spaces: The number of returned memory spaces. In case the input value
>+#                  of @num-mem-spaces is '0', this is the number of all
>+#                  available memory spaces for the selected core.
>+# @mem-spaces:     Memory space information.
>+#
>+# Since: 9.1
>+##
>+{ 'struct': 'MCDQryMemSpacesResult',
>+  'data': {
>+    'return-status'  : 'uint32',
>+    '*num-mem-spaces': 'uint32',
>+    '*mem-spaces'    : [ 'MCDMemspace' ] }}
>+
>+##
>+# @mcd-qry-mem-spaces:
>+#
>+# Function querying the available memory spaces for a particular component.
>+#
>+# @core-uid:       Unique identifier of the open core as returned by
>+#                  @mcd-open-core.
>+# @start-index:    Start index of the requested memory spaces. This refers to
>+#                  an internal list of the target side implementation.
>+# @num-mem-spaces: Number of memory spaces, information is requested of. If it
>+#                  is set to '0', no memory space information is returned but
>+#                  the number of all available memory spaces for the selected
>+#                  core.
>+#
>+# Returns: @MCDQryMemSpacesResult
>+#
>+# Since: 9.1
>+#
>+# .. qmp-example::
>+#    :title: Arm TrustZone
>+#
>+#     -> { "execute": "mcd-qry-mem-spaces",
>+#          "arguments": { "core-uid": 1,
>+#                         "start-index": 0,
>+#                         "num-mem-spaces": 20 } }
>+#     <- {
>+#          "return": {
>+#              "mem-spaces": [
>+#                  {
>+#                      "mem-space-id": 1,
>+#                      "bits-per-mau": 0,
>+#                      "mem-space-name": "system",
>+#                      "endian": 0,
>+#                      "max-addr": 0,
>+#                      "mem-type": 16,
>+#                      "core-mode-mask-write": 0,
>+#                      "core-mode-mask-read": 0,
>+#                      "supported-access-options": 0,
>+#                      "invariance": 0,
>+#                      "num-mem-blocks": 0,
>+#                      "min-addr": 0
>+#                  },
>+#                  {
>+#                      "mem-space-id": 2,
>+#                      "bits-per-mau": 0,
>+#                      "mem-space-name": "cpu-memory-0",
>+#                      "endian": 0,
>+#                      "max-addr": 0,
>+#                      "mem-type": 32,
>+#                      "core-mode-mask-write": 0,
>+#                      "core-mode-mask-read": 0,
>+#                      "supported-access-options": 0,
>+#                      "invariance": 0,
>+#                      "num-mem-blocks": 0,
>+#                      "min-addr": 0
>+#                  },
>+#                  {
>+#                      "mem-space-id": 3,
>+#                      "bits-per-mau": 0,
>+#                      "mem-space-name": "secure-memory",
>+#                      "endian": 0,
>+#                      "max-addr": 0,
>+#                      "mem-type": 65552,
>+#                      "core-mode-mask-write": 0,
>+#                      "core-mode-mask-read": 0,
>+#                      "supported-access-options": 0,
>+#                      "invariance": 0,
>+#                      "num-mem-blocks": 0,
>+#                      "min-addr": 0
>+#                  },
>+#                  {
>+#                      "mem-space-id": 4,
>+#                      "bits-per-mau": 0,
>+#                      "mem-space-name": "cpu-secure-memory-0",
>+#                      "endian": 0,
>+#                      "max-addr": 0,
>+#                      "mem-type": 65568,
>+#                      "core-mode-mask-write": 0,
>+#                      "core-mode-mask-read": 0,
>+#                      "supported-access-options": 0,
>+#                      "invariance": 0,
>+#                      "num-mem-blocks": 0,
>+#                      "min-addr": 0
>+#                  },
>+#                  {
>+#                      "mem-space-id": 5,
>+#                      "bits-per-mau": 0,
>+#                      "mem-space-name": "GDB Registers",
>+#                      "endian": 0,
>+#                      "max-addr": 0,
>+#                      "mem-type": 1,
>+#                      "core-mode-mask-write": 0,
>+#                      "core-mode-mask-read": 0,
>+#                      "supported-access-options": 0,
>+#                      "invariance": 0,
>+#                      "num-mem-blocks": 0,
>+#                      "min-addr": 0
>+#                  }
>+#              ],
>+#              "return-status": 0,
>+#              "num-mem-spaces": 5
>+#          }
>+#        }
>+##
>+{ 'command': 'mcd-qry-mem-spaces',
>+  'data': {
>+     'core-uid'      : 'uint32',
>+     'start-index'   : 'uint32',
>+     'num-mem-spaces': 'uint32' },
>+  'returns': 'MCDQryMemSpacesResult' }
>diff --git a/tests/qtest/mcd-test.c b/tests/qtest/mcd-test.c
>index 9596309..b63a905 100644
>--- a/tests/qtest/mcd-test.c
>+++ b/tests/qtest/mcd-test.c
>@@ -399,6 +399,84 @@ static void test_open_core(void)
>     mcdtest_quit(&qts);
> }
> 
>+static void test_qry_core_info(void)
>+{
>+    QTestStateMCD qts = mcdtest_init(QEMU_EXTRA_ARGS);
>+    MCDQryCoresResult *cores_query = open_server_query_cores(&qts);
>+
>+    MCDCoreConInfoList *core_head = cores_query->core_con_info;
>+    for (uint32_t c = 0; c < cores_query->num_cores; c++) {
>+        q_obj_mcd_qry_mem_spaces_arg qry_mem_spaces_args;
>+        q_obj_mcd_close_core_arg close_core_args;
>+        MCDQryMemSpacesResult *qry_mem_spaces_result;
>+        MCDCloseCoreResult *close_core_result;
>+
>+        MCDCoreConInfo *core_con_info = core_head->value;
>+        q_obj_mcd_open_core_arg open_core_args = {
>+            .core_con_info = core_con_info,
>+        };
>+        MCDOpenCoreResult *open_core_result =
>+            qtest_mcd_open_core(&qts, &open_core_args);
>+        g_assert(open_core_result->return_status == MCD_RET_ACT_NONE);
>+        g_assert(open_core_result->has_core_uid);
>+
>+        if (verbose) {
>+            fprintf(stderr, "[INFO]\tCore %s #%d\n",
>+                                core_con_info->core,
>+                                core_con_info->core_id);
>+        }
>+
>+        qry_mem_spaces_args = (q_obj_mcd_qry_mem_spaces_arg) {
>+            .core_uid = open_core_result->core_uid,
>+            .start_index = 0,
>+            .num_mem_spaces = 0,
>+        };
>+
>+        qry_mem_spaces_result = qtest_mcd_qry_mem_spaces(&qts,
>+                                                         &qry_mem_spaces_args);
>+        g_assert(qry_mem_spaces_result->return_status == MCD_RET_ACT_NONE);
>+        g_assert(qry_mem_spaces_result->has_num_mem_spaces);
>+        g_assert(qry_mem_spaces_result->num_mem_spaces > 0);
>+
>+        qry_mem_spaces_args.num_mem_spaces =
>+            qry_mem_spaces_result->num_mem_spaces;
>+        qapi_free_MCDQryMemSpacesResult(qry_mem_spaces_result);
>+        qry_mem_spaces_result = qtest_mcd_qry_mem_spaces(&qts,
>+                                                         &qry_mem_spaces_args);
>+        g_assert(qry_mem_spaces_result->return_status == MCD_RET_ACT_NONE);
>+        g_assert(qry_mem_spaces_result->has_num_mem_spaces);
>+
>+        if (verbose) {
>+            MCDMemspaceList *ms_head = qry_mem_spaces_result->mem_spaces;
>+            for (uint32_t i = 0;
>+                 i < qry_mem_spaces_result->num_mem_spaces; i++) {
>+                MCDMemspace *ms = ms_head->value;
>+                if (verbose) {
>+                    fprintf(stderr, "\tMemory Space: %s (#%d)\n"
>+                                    "\t              Type: 0x%x\n",
>+                                    ms->mem_space_name,
>+                                    ms->mem_space_id,
>+                                    ms->mem_type);
>+                }
>+                ms_head = ms_head->next;
>+            }
>+        }
>+
>+        qapi_free_MCDQryMemSpacesResult(qry_mem_spaces_result);
>+        close_core_args.core_uid = open_core_result->core_uid;
>+        close_core_result = qtest_mcd_close_core(&qts, &close_core_args);
>+        g_assert(close_core_result->return_status == MCD_RET_ACT_NONE);
>+
>+        qapi_free_MCDCloseCoreResult(close_core_result);
>+        qapi_free_MCDOpenCoreResult(open_core_result);
>+        core_head = core_head->next;
>+    }
>+
>+    qapi_free_MCDQryCoresResult(cores_query);
>+    qtest_mcd_exit(&qts);
>+    mcdtest_quit(&qts);
>+}
>+
> int main(int argc, char *argv[])
> {
>     char *v_env = getenv("V");
>@@ -411,5 +489,6 @@ int main(int argc, char *argv[])
>     qtest_add_func("mcd/open-server", test_open_server);
>     qtest_add_func("mcd/qry-cores", test_qry_cores);
>     qtest_add_func("mcd/open-core", test_open_core);
>+    qtest_add_func("mcd/qry-core-info", test_qry_core_info);
>     return g_test_run();
> }
>diff --git a/tests/qtest/mcd-util.c b/tests/qtest/mcd-util.c
>index 53694d9..225cbad 100644
>--- a/tests/qtest/mcd-util.c
>+++ b/tests/qtest/mcd-util.c
>@@ -269,3 +269,23 @@ MCDCloseCoreResult *qtest_mcd_close_core(QTestStateMCD *qts,
> 
>     return unmarshal;
> }
>+
>+MCDQryMemSpacesResult *qtest_mcd_qry_mem_spaces(
>+    QTestStateMCD *qts, q_obj_mcd_qry_mem_spaces_arg *args)
>+{
>+    Visitor *v;
>+    QObject *marshal;
>+    QDict *arg, *resp;
>+    QObject *ret;
>+    bool ok;
>+    MCDQryMemSpacesResult *unmarshal;
>+
>+    MARSHAL_ARGS(q_obj_mcd_qry_mem_spaces_arg);
>+
>+    resp = qtest_mcd(qts, "{'execute': 'mcd-qry-mem-spaces',"
>+                          "'arguments': %p}", arg);
>+
>+    UNMARSHAL_RESULT(MCDQryMemSpacesResult);
>+
>+    return unmarshal;
>+}
>diff --git a/tests/qtest/mcd-util.h b/tests/qtest/mcd-util.h
>index 5e7c3ca..bff9600 100644
>--- a/tests/qtest/mcd-util.h
>+++ b/tests/qtest/mcd-util.h
>@@ -51,4 +51,7 @@ MCDOpenCoreResult *qtest_mcd_open_core(QTestStateMCD *qts,
> MCDCloseCoreResult *qtest_mcd_close_core(QTestStateMCD *qts,
>                                          q_obj_mcd_close_core_arg *args);
> 
>+MCDQryMemSpacesResult *qtest_mcd_qry_mem_spaces(QTestStateMCD *qts,
>+    q_obj_mcd_qry_mem_spaces_arg *args);
>+
> #endif /* TEST_MCD_UTILS_H */
>-- 
>2.34.1
>
>

--
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd


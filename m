Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21B1C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 10:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7YUn-0000h9-IF; Thu, 16 May 2024 06:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7YUk-0000gr-KP
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:37:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7YUi-0001oV-0q
 for qemu-devel@nongnu.org; Thu, 16 May 2024 06:37:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34db6a299b8so5929236f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715855869; x=1716460669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g0rlW62V9YfKv7QJLBQk2FfaZrGvkiPRXRRoMvcn2sE=;
 b=akLuxCj+gENHMllooDY7xLC8aQfKwv/NVuigm+xaMlDjQW5PT0rZUHQ0Lg44qa0SHR
 fGovNkKowMKdXNAeLDWAsPcL6bkYUV//uScYrRO/oPAoWg8bu2MZ8clsMiCD8cRZvxn8
 Tfv8AQIc345MiZ4+ITfsP410s8+dbuY/Ve8eLlVhfrXX6DRIqryXv2endZjkHJ+Wl9MY
 K5o3uo13kh5i5iBKeVJt2JHZwre4pr3Viy9aBI0pkXFikJUzxSOPX6MJ+YTivzgo+W/U
 UjoIFB+CldcltoEvMbEnSpdL+dsogGr04D2wnyWFG9a/rPjzLJ+/VeuF+vyzmM5LNjXn
 x6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715855869; x=1716460669;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0rlW62V9YfKv7QJLBQk2FfaZrGvkiPRXRRoMvcn2sE=;
 b=MuuYQx8lT8/UpHDmjhV+wYksL4ZeRGEEJShGcpsHFphGiEyT+Xwdh/51ULT5xxfgeh
 Id+MyP1ExkXyCvOqpCuE9JYMLRpFd0GNOXe8Nen5X6zIOA5cOV/hBHovYDKasJzWv91N
 86OpBXXYe6OD8A2bpgASKOW4czznndMX1VLdSYdJSSrw1b+34d+yzLROygVcYyKwzGwW
 BlcZU+tKoSnFw4j9x2tsU/oU3uXiyB5loKRqJGLlqF0u0dGDYvj5+Zv73vF1gqeFdzT4
 L+nhq05fCytk2yip8Ll5pWLqCxCvApyT+5iKi6ZTni6k3RNDAzYrJm9sWTTOZVFs0Ah4
 UcMQ==
X-Gm-Message-State: AOJu0YzPj2jskiSwigNUytDaCvESQqmUPttvTtCoOEA8eFz4HxO09JnA
 aeuq2uq29CVivDXjaZTOGFiETUsVA7HzlwxDgOgNJXMMUu0g9SbKN7P4ZXg5dUyHnSWfvKglYvj
 o
X-Google-Smtp-Source: AGHT+IE/2CCPuUTdG6yLTsTvOvVf9xxvISfdvT/ZhbN/1YYOuzu375LuzWeMkePsZ8sjPkPslhwOlQ==
X-Received: by 2002:a05:6000:bc9:b0:34a:e69b:494e with SMTP id
 ffacd0b85a97d-3504a636433mr13180323f8f.23.1715855868579; 
 Thu, 16 May 2024 03:37:48 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a5bsm18547742f8f.36.2024.05.16.03.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 03:37:48 -0700 (PDT)
Message-ID: <f4ee8cce-2f5f-458a-ace1-f4b2aa3cb224@linaro.org>
Date: Thu, 16 May 2024 12:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] gdbstub: Add support for target-specific stubs
To: Gustavo Romero <gustavo.romero@linaro.org>
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
 <20240515173132.2462201-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
In-Reply-To: <20240515173132.2462201-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 15/5/24 19:31, Gustavo Romero wrote:
> Currently, it's not possible to have stubs specific to a given target,
> even though there are GDB features which are target-specific, like, for
> instance, memory tagging.
> 
> This commit introduces set_query_supported_arch,
> set_gdb_gen_query_table_arch, and set_gdb_gen_set_table_arch functions
> as interfaces to extend the qSupported string, the query handler table,
> and set handler table per target, so allowing target-specific stub
> implementation.
> 
> Besides that, it moves GdbCmdParseEntry struct, its related types, and
> gdb_put_packet to include/exec/gdbstub.h so they are also available in
> the target-specific stubs.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   gdbstub/gdbstub.c      | 108 +++++++++++++++++++++++------------------
>   gdbstub/internals.h    |  22 ---------
>   gdbstub/syscalls.c     |   1 +
>   include/exec/gdbstub.h |  86 +++++++++++++++++++++++++++++++-
>   4 files changed, 147 insertions(+), 70 deletions(-)


> @@ -1645,6 +1608,13 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
>       gdb_put_strbuf();
>   }
>   
> +/* Arch-specific qSupported */
> +char *query_supported_arch = NULL;

Please declare query_supported_arch as static.

> +void set_query_supported_arch(char *query_supported)
> +{
> +    query_supported_arch = query_supported;
> +}
> +
>   static void handle_query_supported(GArray *params, void *user_ctx)
>   {
>       CPUClass *cc;
> @@ -1684,6 +1654,11 @@ static void handle_query_supported(GArray *params, void *user_ctx)
>       }
>   
>       g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
> +
> +    if (query_supported_arch) {
> +        g_string_append(gdbserver_state.str_buf, query_supported_arch);
> +    }
> +
>       gdb_put_strbuf();
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Although I'd rather split in 3 as:

1/ Expose API

-- >8 --
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 32f9f63297..34121dc61a 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -109 +108,0 @@ void gdb_put_strbuf(void);
-int gdb_put_packet(const char *buf);
@@ -169,21 +167,0 @@ void gdb_init_gdbserver_state(void);
-typedef enum GDBThreadIdKind {
-    GDB_ONE_THREAD = 0,
-    GDB_ALL_THREADS,     /* One process, all threads */
-    GDB_ALL_PROCESSES,
-    GDB_READ_THREAD_ERR
-} GDBThreadIdKind;
-
-typedef union GdbCmdVariant {
-    const char *data;
-    uint8_t opcode;
-    unsigned long val_ul;
-    unsigned long long val_ull;
-    struct {
-        GDBThreadIdKind kind;
-        uint32_t pid;
-        uint32_t tid;
-    } thread_id;
-} GdbCmdVariant;
-
-#define get_param(p, i)    (&g_array_index(p, GdbCmdVariant, i))
-
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index eb14b91139..7bf189d7f3 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -147 +147,85 @@ extern const GDBFeature gdb_static_features[];
-#endif
+typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
+
+typedef enum GDBThreadIdKind {
+    GDB_ONE_THREAD = 0,
+    GDB_ALL_THREADS,     /* One process, all threads */
+    GDB_ALL_PROCESSES,
+    GDB_READ_THREAD_ERR
+} GDBThreadIdKind;
+
+typedef union GdbCmdVariant {
+    const char *data;
+    uint8_t opcode;
+    unsigned long val_ul;
+    unsigned long long val_ull;
+    struct {
+        GDBThreadIdKind kind;
+        uint32_t pid;
+        uint32_t tid;
+    } thread_id;
+} GdbCmdVariant;
+
+#define get_param(p, i)    (&g_array_index(p, GdbCmdVariant, i))
+
+/*
+ * cmd_startswith -> cmd is compared using startswith
+ *
+ * allow_stop_reply -> true iff the gdbstub can respond to this command 
with a
+ *   "stop reply" packet. The list of commands that accept such response is
+ *   defined at the GDB Remote Serial Protocol documentation. see:
+ * 
https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
+ *
+ * schema definitions:
+ * Each schema parameter entry consists of 2 chars,
+ * the first char represents the parameter type handling
+ * the second char represents the delimiter for the next parameter
+ *
+ * Currently supported schema types:
+ * 'l' -> unsigned long (stored in .val_ul)
+ * 'L' -> unsigned long long (stored in .val_ull)
+ * 's' -> string (stored in .data)
+ * 'o' -> single char (stored in .opcode)
+ * 't' -> thread id (stored in .thread_id)
+ * '?' -> skip according to delimiter
+ *
+ * Currently supported delimiters:
+ * '?' -> Stop at any delimiter (",;:=\0")
+ * '0' -> Stop at "\0"
+ * '.' -> Skip 1 char unless reached "\0"
+ * Any other value is treated as the delimiter value itself
+ */
+typedef struct GdbCmdParseEntry {
+    GdbCmdHandler handler;
+    const char *cmd;
+    bool cmd_startswith;
+    const char *schema;
+    bool allow_stop_reply;
+} GdbCmdParseEntry;
+
+#define get_cmd_parsers(p) (&g_array_index(p, GdbCmdParseEntry, 0))
+
+/**
+ * set_gdb_gen_query_table_arch() - set a table to handle arch-specific 
query
+ * packets
+ */
+void set_gdb_gen_query_table_arch(GdbCmdParseEntry *table, int size);
+
+/**
+ * set_gdb_gen_set_table_arch() - set a table to handle arch-specific set
+ * packets
+ */
+void set_gdb_gen_set_table_arch(GdbCmdParseEntry *, int size);
+
+/**
+ * set_query_supported_arch() - set arch-specific features in qSupported
+ * features
+ */
+void set_query_supported_arch(char *);
+
+/**
+ * gdb_put_packet() - put string into gdb server's buffer so it is sent
+ * to the client
+ */
+int gdb_put_packet(const char *buf);
+
+#endif /* GDBSTUB_H */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b3574997ea..fc72f03c8a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -923,37 +922,0 @@ static int cmd_parse_params(const char *data, const 
char *schema,
-typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
-
-/*
- * cmd_startswith -> cmd is compared using startswith
- *
- * allow_stop_reply -> true iff the gdbstub can respond to this command 
with a
- *   "stop reply" packet. The list of commands that accept such response is
- *   defined at the GDB Remote Serial Protocol documentation. see:
- * 
https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
- *
- * schema definitions:
- * Each schema parameter entry consists of 2 chars,
- * the first char represents the parameter type handling
- * the second char represents the delimiter for the next parameter
- *
- * Currently supported schema types:
- * 'l' -> unsigned long (stored in .val_ul)
- * 'L' -> unsigned long long (stored in .val_ull)
- * 's' -> string (stored in .data)
- * 'o' -> single char (stored in .opcode)
- * 't' -> thread id (stored in .thread_id)
- * '?' -> skip according to delimiter
- *
- * Currently supported delimiters:
- * '?' -> Stop at any delimiter (",;:=\0")
- * '0' -> Stop at "\0"
- * '.' -> Skip 1 char unless reached "\0"
- * Any other value is treated as the delimiter value itself
- */
-typedef struct GdbCmdParseEntry {
-    GdbCmdHandler handler;
-    const char *cmd;
-    bool cmd_startswith;
-    const char *schema;
-    bool allow_stop_reply;
-} GdbCmdParseEntry;
-
diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index 02e3a8f74c..ee9a16495e 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -20,0 +21 @@
+#include "exec/gdbstub.h"
---

2/ Refactor query/set handlers in preparation of target specific

-- >8 --
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index fc72f03c8a..1bb35167d4 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1855,3 +1855,3 @@ static void handle_gen_query(GArray *params, void 
*user_ctx)
-    if (!process_string_cmd(get_param(params, 0)->data,
-                            gdb_gen_query_set_common_table,
-                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+    if (process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_set_common_table,
+                           ARRAY_SIZE(gdb_gen_query_set_common_table)) 
== 0) {
@@ -1863,2 +1863,2 @@ static void handle_gen_query(GArray *params, void 
*user_ctx)
-                           ARRAY_SIZE(gdb_gen_query_table))) {
-        gdb_put_packet("");
+                           ARRAY_SIZE(gdb_gen_query_table)) == 0) {
+        return;
@@ -1865,0 +1866,3 @@ static void handle_gen_query(GArray *params, void 
*user_ctx)
+
+    /* Can't handle query, return Empty response. */
+    gdb_put_packet("");
@@ -1874,3 +1877,3 @@ static void handle_gen_set(GArray *params, void 
*user_ctx)
-    if (!process_string_cmd(get_param(params, 0)->data,
-                            gdb_gen_query_set_common_table,
-                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+    if (process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_set_common_table,
+                           ARRAY_SIZE(gdb_gen_query_set_common_table)) 
== 0) {
@@ -1882,2 +1885,2 @@ static void handle_gen_set(GArray *params, void 
*user_ctx)
-                           ARRAY_SIZE(gdb_gen_set_table))) {
-        gdb_put_packet("");
+                           ARRAY_SIZE(gdb_gen_set_table)) == 0) {
+        return;
@@ -1884,0 +1888,3 @@ static void handle_gen_set(GArray *params, void 
*user_ctx)
+
+    /* Can't handle set, return Empty response. */
+    gdb_put_packet("");
---

3/ Introduce target specific handlers

-- >8 --
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 1bb35167d4..a6b2200fc3 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1610,0 +1611,7 @@ static void handle_query_thread_extra(GArray 
*params, void *user_ctx)
+/* Arch-specific qSupported */
+static char *query_supported_arch = NULL;
+void set_query_supported_arch(char *query_supported)
+{
+    query_supported_arch = query_supported;
+}
+
@@ -1649,0 +1657,5 @@ static void handle_query_supported(GArray *params, 
void *user_ctx)
+
+    if (query_supported_arch) {
+        g_string_append(gdbserver_state.str_buf, query_supported_arch);
+    }
+
@@ -1730,0 +1743,10 @@ static const GdbCmdParseEntry 
gdb_gen_query_set_common_table[] = {
+
+/* Arch-specific query table */
+static GdbCmdParseEntry *gdb_gen_query_table_arch = NULL ;
+static int gdb_gen_query_table_arch_size = 0;
+void set_gdb_gen_query_table_arch(GdbCmdParseEntry  *table, int size)
+{
+    gdb_gen_query_table_arch = table;
+    gdb_gen_query_table_arch_size = size;
+}
+
@@ -1822,0 +1845,9 @@ static const GdbCmdParseEntry 
gdb_gen_query_table[] = {
+/* Arch-specific set table */
+static GdbCmdParseEntry *gdb_gen_set_table_arch = NULL;
+static int gdb_gen_set_table_arch_size = 0;
+void set_gdb_gen_set_table_arch(GdbCmdParseEntry *table, int size)
+{
+    gdb_gen_set_table_arch = table;
+    gdb_gen_set_table_arch_size = size;
+}
+
@@ -1866,0 +1898,7 @@ static void handle_gen_query(GArray *params, void 
*user_ctx)
+    if (gdb_gen_query_table_arch &&
+        process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_table_arch,
+                           gdb_gen_query_table_arch_size) == 0) {
+        return;
+    }
+
@@ -1888,0 +1927,7 @@ static void handle_gen_set(GArray *params, void 
*user_ctx)
+    if (gdb_gen_set_table_arch &&
+        process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_set_table_arch,
+                           gdb_gen_set_table_arch_size) == 0) {
+        return;
+    }
+
---

Regards,

Phil.


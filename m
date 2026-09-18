Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96CAC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7R6O-0000wQ-Bp; Fri, 18 Sep 2026 01:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7R6M-0000qF-E1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 01:25:34 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x7R6I-0002S8-AU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 01:25:33 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f6c7a4aso36926366b.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789709128; cv=none;
 d=google.com; s=arc-20260327;
 b=ixBfmFn9aA+6wZx++aRlu9ex39m67kGqeUEF2c7jE8JsOOqZfMAzACTQfDr9hz+srb
 TxXfqn6dRUxUKJbNoyZOLt0ze+0crP0ECOSKve+yIOSs001Cd+lUFTD2R6EjYQjTB6DB
 Nn7LNBJ4IC6MzX2s6IW1VD1QXEwyHxrLbePWfeqWB8abSRCjjUquCLAirokxvhsWvmCG
 a59rVpQa+6aeg6r8F8JsPQftFz2oJUzqpRDTsrB+jO7sJxfn6Bl/1dd9IATnSCC8Gimj
 c/DsVvxnsoLpfKooQMLQ0ZBwQszJi343d7f+hfb4lvHSA3RxONFhYHk1MwnV9nFADzTV
 V34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=efITi2X39yNNk4TzF8aQbbC/3YWgOVgx51Pl9lU4DGw=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=KmFPAaIkENJY+lc98oaIN4cfk2sn/W4E8grJAjOrhXz09WKPxj1L3SR1VqtHLlNshH
 RoI0TV0KzkD6QFy+2H9YSa9D3M9r7sh0K8hJ9N9/sshViStigUcuvXfmQrg9stDTOCxi
 q+2o18lD5rv843evioCWq6zEBRiDp3DkTLn3+J66gU9JjZb1VwIJIsNfhOiGA202DyKD
 sSoyiY8+sWXjEDI+8i7VSVgBpBBOdw0gQ7xbRyptrrehTeZNvHmXztWbbLnyxVxWJKAI
 f9Bip25/DI40vP+PU4nP6IWeVTrIzu82DrAMiJ73MSD32S3qr3X0wTsxgTh9Kw+1zkxr
 ubuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789709128; x=1790313928; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=efITi2X39yNNk4TzF8aQbbC/3YWgOVgx51Pl9lU4DGw=;
 b=rFCqL0OdwMVEMEFs3/aUYSXG9HHCC6zkNp4+EUmEB4cGpEQqp5VUYhtcSsopIW3mGP
 OyOL/Bw2GoGX769LQrNbT3oxz3pUp/UFDaLatPgMGrey09zKrc8XwrLP/A9Il5Ory3DW
 JV9BNSN4L2VtDxHmVxoC5aCVxPlpyQzDQZpbR5L6lvvMNIbaqILTxiXnndO3cFQHb4/v
 PodMca2asqk0EXrv0agyjG4f9VW5xlKjMLgMRbvRrQGMs2eSV7Ae3cGm/1//U/XPcHOG
 rnIv6Au5ApmF0eEERcynGzjjKRBxw6EuaxkFGG+SLjeBgr2sRgQi92EWNJC1QD+maDQX
 9AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789709128; x=1790313928;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=efITi2X39yNNk4TzF8aQbbC/3YWgOVgx51Pl9lU4DGw=;
 b=1EZMJ31wrWDddYLG1SvKe+Qffq6WmuMsOotOPQCEB1kV4tVa822ijMg2azOtu9f3hN
 TA+eGYb49xc+ILFAgHw+042zHBRf9psPsMqRQsMxyRctECbME4tmDqOYbNHbcaBOwypw
 ZF3Ivm0YvAg4OVK9Bu2ldVWNdZ/6OmFGmYT9pUezp3VdiiHFMWEzw0jghFQGiITXJY9V
 /qfVdPITuTLqOaFjnjHAtI4K8/9JSDHkkzkAZuMN3De49Xan5k109PAto3UuzQ4hZdEH
 9DBlAp7MN+/AhrUnLIoGHP614Bc+RCJJ3g1xiIF592KloAnebb6AfZ+IMqe8zFmhIJGV
 NQkA==
X-Gm-Message-State: AFuF++lXU1KtOMLXp7aFOsVHemi8+FaAmd13ZkUAJLkB+DZel6aLfF0w
 YKnv85ZOmYOlYKuYl14RnP5QI3DriixaXBzNbqlIP7tRWejMMfyIa0KKE4ZDW1F4rJizyHDkJ2G
 1NS3E5DnwvCGLR9C0Nx4Jg+v7uGewjmQ=
X-Gm-Gg: AYBFou26R45JxTTqLwjX+VxtGWZ0+ij3Z5drjkZMFOwppeSphsVy6S7O/gEBk6Zrzoz
 7S1e9o11cyEQb1DqDbhWYk3As+fydkFKFvpS6vCsiMpLWZFWFHww8jCLqJM4qam3QlSawCOzqX9
 AZSRRNgiEuI3sjYFW7JohyGRWPLV8T9kHC2utVxgUrBPyyqvId8MlsPnNGB2PD4Pmx9lTG/1YsQ
 hGQA3AFLs4/eCumdrXXh77C3appTyLvR+Kt1OHD5/XNa7BU/6z+SVXw/jFx/9m64Hy8Ora24L3t
 QLOuWiCksfWWRWHfrG1ivyhvpb8X0ovaWZFcvxwzYh4Z7xxmFYcPMbw=
X-Received: by 2002:a17:907:5cb:b0:c21:450d:cd7e with SMTP id
 a640c23a62f3a-c2a15788ea4mr133923366b.9.1789709127336; Thu, 17 Sep 2026
 22:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-4-luoyonggang@gmail.com>
 <724e2043-fbd3-4c1d-85b3-a2e6056b9ec8@linaro.org>
In-Reply-To: <724e2043-fbd3-4c1d-85b3-a2e6056b9ec8@linaro.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2026 13:25:13 +0800
X-Gm-Features: AcwNN1Um9YTSrKh8LVV5yEZSdL4irOPB7UUKOakayR9d0eIPsrF4SgQpBeyY72Y
Message-ID: <CAE2XoE_E1HSrKfz3mEjr-EQiv35=h+80HTyyUYoQ03hEfTr6BQ@mail.gmail.com>
Subject: Re: [PATCH 03/21] accel/tcg: add helper raise_excp
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c946c6065bbb2066"
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000c946c6065bbb2066
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:01=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:
>
> (1) Put the comment before the implementation, not the header.
> That avoids whatever you're concerned about vs patch 2.
>
> (2) Don't pass an extra argument that changes behavior like this.
> Better to have two separate functions, each doing one thing.
>
> (3) Maybe better to place the functions in cpu-exec-common.c, so that
> the compiler can see all the definitions at once.
>
>
> r~

 accel/tcg/gen-helpers.c          |  27 ++++++++
 accel/tcg/meson.build            |   1 +
 include/accel/tcg/gen-helpers.h  |  37 ++++++++++
 include/exec/helper-gen-common.h |   2 +
 include/exec/helper-impl.h       | 146
+++++++++++++++++++++++++++++++++++++++
 5 files changed, 213 insertions(+)

diff --git a/accel/tcg/gen-helpers.c b/accel/tcg/gen-helpers.c
new file mode 100644
index 00000000000..212f08cf844
--- /dev/null
+++ b/accel/tcg/gen-helpers.c
@@ -0,0 +1,27 @@
+/*
+ * Shared TCG helpers implemented with IMPL_HELPER_FLAGS_*.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "accel/tcg/cpu-loop.h"
+#include "accel/tcg/getpc.h"
+#include "exec/helper-impl.h"
+
+static G_NORETURN void helper_raise_excp(CPUArchState *env, uint32_t
exception)
+    __attribute__((noinline))
+{
+    cpu_loop_exit_excp(env_cpu(env), exception, 0);
+}
+
+IMPL_HELPER_FLAGS_2(raise_excp, TCG_CALL_NO_WG, noreturn, env, i32)
+
+static G_NORETURN void helper_raise_excp_restore(CPUArchState *env,
+                                                 uint32_t exception)
+    __attribute__((noinline))
+{
+    cpu_loop_exit_excp(env_cpu(env), exception, GETPC());
+}
+
+IMPL_HELPER_FLAGS_2(raise_excp_restore, TCG_CALL_NO_WG, noreturn, env, i32=
)
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 002aa8f4588..3f9afcc5f1d 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -7,6 +7,7 @@ tcg_ss =3D ss.source_set()
 tcg_ss.add(files(
   'cpu-exec.c',
   'cpu-exec-common.c',
+  'gen-helpers.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
   'tb-maint.c',
diff --git a/include/accel/tcg/gen-helpers.h
b/include/accel/tcg/gen-helpers.h
new file mode 100644
index 00000000000..19787d6de24
--- /dev/null
+++ b/include/accel/tcg/gen-helpers.h
@@ -0,0 +1,37 @@
+/*
+ * Shared TCG gen_helper_* APIs implemented with IMPL_HELPER_FLAGS_*.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ACCEL_TCG_GEN_HELPERS_H
+#define ACCEL_TCG_GEN_HELPERS_H
+
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
+#include "tcg/tcg.h"
+
+/**
+ * gen_helper_raise_excp:
+ * @env: CPU env (tcg_env)
+ * @exception: EXCP_* or target trap number
+ *
+ * Shared TCG exception raise without unwind. Body is helper_raise_excp
+ * in accel/tcg/gen-helpers.c. Exits via cpu_loop_exit_excp with
+ * host_pc 0.
+ */
+void gen_helper_raise_excp(TCGv_env env, TCGv_i32 exception);
+
+/**
+ * gen_helper_raise_excp_restore:
+ * @env: CPU env (tcg_env)
+ * @exception: EXCP_* or target trap number
+ *
+ * Shared TCG exception raise with GETPC() unwind. Body is
+ * helper_raise_excp_restore in accel/tcg/gen-helpers.c. Exits via
+ * cpu_loop_exit_excp.
+ */
+void gen_helper_raise_excp_restore(TCGv_env env, TCGv_i32 exception);
+
+#endif
diff --git a/include/exec/helper-gen-common.h
b/include/exec/helper-gen-common.h
index 834590dc4e5..16548830ec8 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -11,4 +11,6 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H

+#include "accel/tcg/gen-helpers.h"
+
 #endif /* HELPER_GEN_COMMON_H */
diff --git a/include/exec/helper-impl.h b/include/exec/helper-impl.h
new file mode 100644
index 00000000000..d2797e5e6a7
--- /dev/null
+++ b/include/exec/helper-impl.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Implement a TCG helper in one .c file: static helper_info_* plus
+ * gen_helper_*. Same arguments as DEF_HELPER_FLAGS_N. Write
+ * HELPER(name) beside the invocation.
+ */
+#ifndef EXEC_HELPER_IMPL_H
+#define EXEC_HELPER_IMPL_H
+
+#include "tcg/tcg.h"
+#include "tcg/helper-info.h"
+#include "exec/helper-head.h.inc"
+
+#define IMPL_HELPER_FLAGS_0(name, flags, ret)                           \
+static TCGHelperInfo glue(helper_info_, name) =3D {                       =
\
+    .func =3D HELPER(name), .name =3D stringify(name),                    =
  \
+    .flags =3D flags | dh_callflag(ret),                                  =
\
+    .typemask =3D dh_typemask(ret, 0)                                     =
\
+};                                                                      \
+void glue(gen_helper_, name)(dh_retvar_decl0(ret))                      \
+{                                                                       \
+    tcg_gen_call0(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret));            \
+}
+
+#define IMPL_HELPER_FLAGS_1(name, flags, ret, t1)                       \
+static TCGHelperInfo glue(helper_info_, name) =3D {                       =
\
+    .func =3D HELPER(name), .name =3D stringify(name),                    =
  \
+    .flags =3D flags | dh_callflag(ret),                                  =
\
+    .typemask =3D dh_typemask(ret, 0) | dh_typemask(t1, 1)                =
\
+};                                                                      \
+void glue(gen_helper_, name)(dh_retvar_decl(ret)                        \
+    dh_arg_decl(t1, 1))                                                 \
+{                                                                       \
+    tcg_gen_call1(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
+                  dh_arg(t1, 1));                                       \
+}
+
+#define IMPL_HELPER_FLAGS_2(name, flags, ret, t1, t2)                   \
+static TCGHelperInfo glue(helper_info_, name) =3D {                       =
\
+    .func =3D HELPER(name), .name =3D stringify(name),                    =
  \
+    .flags =3D flags | dh_callflag(ret),                                  =
\
+    .typemask =3D dh_typemask(ret, 0) | dh_typemask(t1, 1)                =
\
+              | dh_typemask(t2, 2)                                      \
+};                                                                      \
+void glue(gen_helper_, name)(dh_retvar_decl(ret)                        \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
+{                                                                       \
+    tcg_gen_call2(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
+                  dh_arg(t1, 1), dh_arg(t2, 2));                        \
+}
+
+#define IMPL_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)               \
+static TCGHelperInfo glue(helper_info_, name) =3D {                       =
\
+    .func =3D HELPER(name), .name =3D stringify(name),                    =
  \
+    .flags =3D flags | dh_callflag(ret),                                  =
\
+    .typemask =3D dh_typemask(ret, 0) | dh_typemask(t1, 1)                =
\
+              | dh_typemask(t2, 2) | dh_typemask(t3, 3)                 \
+};                                                                      \
+void glue(gen_helper_, name)(dh_retvar_decl(ret)                        \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
+{                                                                       \
+    tcg_gen_call3(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
+}
+
+#define IMPL_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)           \
+static TCGHelperInfo glue(helper_info_, name) =3D {                       =
\
+    .func =3D HELPER(name), .name =3D stringify(name),                    =
  \
+    .flags =3D flags | dh_callflag(ret),                                  =
\
+    .typemask =3D dh_typemask(ret, 0) | dh_typemask(t1, 1)                =
\
+              | dh_typemask(t2, 2) | dh_typemask(t3, 3)                 \
+              | dh_typemask(t4, 4)                                      \
+};                                                                      \
+void glue(gen_helper_, name)(dh_retvar_decl(ret)                        \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
+    dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
+{                                                                       \
+    tcg_gen_call4(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
+                  dh_arg(t1, 1), dh_arg(t2, 2),                         \
+                  dh_arg(t3, 3), dh_arg(t4, 4));                        \
+}
+
+#define IMPL_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)       \
+static TCGHelperInfo glue(helper_info_, name) =3D {                       =
\
+    .func =3D HELPER(name), .name =3D stringify(name),                    =
  \
+    .flags =3D flags | dh_callflag(ret),                                  =
\
+    .typemask =3D dh_typemask(ret, 0) | dh_typemask(t1, 1)                =
\
+              | dh_typemask(t2, 2) | dh_typemask(t3, 3)                 \
+              | dh_typemask(t4, 4) | dh_typemask(t5, 5)                 \
+};                                                                      \
+void glue(gen_helper_, name)(dh_retvar_decl(ret)                        \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
+    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
+{                                                                       \
+    tcg_gen_call5(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
+                  dh_arg(t4, 4), dh_arg(t5, 5));                        \
+}
+
+#define IMPL_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)   \
+static TCGHelperInfo glue(helper_info_, name) =3D {                       =
\
+    .func =3D HELPER(name), .name =3D stringify(name),                    =
  \
+    .flags =3D flags | dh_callflag(ret),                                  =
\
+    .typemask =3D dh_typemask(ret, 0) | dh_typemask(t1, 1)                =
\
+              | dh_typemask(t2, 2) | dh_typemask(t3, 3)                 \
+              | dh_typemask(t4, 4) | dh_typemask(t5, 5)                 \
+              | dh_typemask(t6, 6)                                      \
+};                                                                      \
+void glue(gen_helper_, name)(dh_retvar_decl(ret)                        \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
+    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
+{                                                                       \
+    tcg_gen_call6(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
+                  dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6));         \
+}
+
+#define IMPL_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
+static TCGHelperInfo glue(helper_info_, name) =3D {                       =
\
+    .func =3D HELPER(name), .name =3D stringify(name),                    =
  \
+    .flags =3D flags | dh_callflag(ret),                                  =
\
+    .typemask =3D dh_typemask(ret, 0) | dh_typemask(t1, 1)                =
\
+              | dh_typemask(t2, 2) | dh_typemask(t3, 3)                 \
+              | dh_typemask(t4, 4) | dh_typemask(t5, 5)                 \
+              | dh_typemask(t6, 6) | dh_typemask(t7, 7)                 \
+};                                                                      \
+void glue(gen_helper_, name)(dh_retvar_decl(ret)                        \
+    dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
+    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
+    dh_arg_decl(t7, 7))                                                 \
+{                                                                       \
+    tcg_gen_call7(glue(helper_info_,name).func,                         \
+                  &glue(helper_info_,name), dh_retvar(ret),             \
+                  dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
+                  dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),          \
+                  dh_arg(t7, 7));                                       \
+}
+
+#endif /* EXEC_HELPER_IMPL_H */

Do you mean doing like this?


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000c946c6065bbb2066
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJyPjxicj5PbiBGcmksIFNlcCAxOCwgMjAyNiBhdCA5OjAx4oCvQU0g
UmljaGFyZCBIZW5kZXJzb24gJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkLmhlbmRlcnNvbkBs
aW5hcm8ub3JnIj5yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPC9hPiZndDsgd3JvdGU6PGJy
PiZndDs8YnI+Jmd0OyAoMSkgUHV0IHRoZSBjb21tZW50IGJlZm9yZSB0aGUgaW1wbGVtZW50YXRp
b24sIG5vdCB0aGUgaGVhZGVyLjxicj4mZ3Q7IFRoYXQgYXZvaWRzIHdoYXRldmVyIHlvdSYjMzk7
cmUgY29uY2VybmVkIGFib3V0IHZzIHBhdGNoIDIuPGJyPiZndDs8YnI+Jmd0OyAoMikgRG9uJiMz
OTt0IHBhc3MgYW4gZXh0cmEgYXJndW1lbnQgdGhhdCBjaGFuZ2VzIGJlaGF2aW9yIGxpa2UgdGhp
cy48YnI+Jmd0OyBCZXR0ZXIgdG8gaGF2ZSB0d28gc2VwYXJhdGUgZnVuY3Rpb25zLCBlYWNoIGRv
aW5nIG9uZSB0aGluZy48YnI+Jmd0Ozxicj4mZ3Q7ICgzKSBNYXliZSBiZXR0ZXIgdG8gcGxhY2Ug
dGhlIGZ1bmN0aW9ucyBpbiBjcHUtZXhlYy1jb21tb24uYywgc28gdGhhdDxicj4mZ3Q7IHRoZSBj
b21waWxlciBjYW4gc2VlIGFsbCB0aGUgZGVmaW5pdGlvbnMgYXQgb25jZS48YnI+Jmd0Ozxicj4m
Z3Q7PGJyPiZndDsgcn48YnI+PGJyPsKgYWNjZWwvdGNnL2dlbi1oZWxwZXJzLmMgwqAgwqAgwqAg
wqAgwqB8IMKgMjcgKysrKysrKys8YnI+wqBhY2NlbC90Y2cvbWVzb24uYnVpbGQgwqAgwqAgwqAg
wqAgwqAgwqB8IMKgIDEgKzxicj7CoGluY2x1ZGUvYWNjZWwvdGNnL2dlbi1oZWxwZXJzLmggwqB8
IMKgMzcgKysrKysrKysrKzxicj7CoGluY2x1ZGUvZXhlYy9oZWxwZXItZ2VuLWNvbW1vbi5oIHwg
wqAgMiArPGJyPsKgaW5jbHVkZS9leGVjL2hlbHBlci1pbXBsLmggwqAgwqAgwqAgfCAxNDYgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyPsKgNSBmaWxlcyBjaGFuZ2Vk
LCAyMTMgaW5zZXJ0aW9ucygrKTxicj48YnI+ZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9nZW4taGVs
cGVycy5jIGIvYWNjZWwvdGNnL2dlbi1oZWxwZXJzLmM8YnI+bmV3IGZpbGUgbW9kZSAxMDA2NDQ8
YnI+aW5kZXggMDAwMDAwMDAwMDAuLjIxMmYwOGNmODQ0PGJyPi0tLSAvZGV2L251bGw8YnI+Kysr
IGIvYWNjZWwvdGNnL2dlbi1oZWxwZXJzLmM8YnI+QEAgLTAsMCArMSwyNyBAQDxicj4rLyo8YnI+
KyAqIFNoYXJlZCBUQ0cgaGVscGVycyBpbXBsZW1lbnRlZCB3aXRoIElNUExfSEVMUEVSX0ZMQUdT
XyouPGJyPisgKjxicj4rICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXI8YnI+KyAqLzxicj4rPGJyPisjaW5jbHVkZSAmcXVvdDtxZW11L29zZGVwLmgmcXVvdDs8YnI+
KyNpbmNsdWRlICZxdW90O2FjY2VsL3RjZy9jcHUtbG9vcC5oJnF1b3Q7PGJyPisjaW5jbHVkZSAm
cXVvdDthY2NlbC90Y2cvZ2V0cGMuaCZxdW90Ozxicj4rI2luY2x1ZGUgJnF1b3Q7ZXhlYy9oZWxw
ZXItaW1wbC5oJnF1b3Q7PGJyPis8YnI+K3N0YXRpYyBHX05PUkVUVVJOIHZvaWQgaGVscGVyX3Jh
aXNlX2V4Y3AoQ1BVQXJjaFN0YXRlICplbnYsIHVpbnQzMl90IGV4Y2VwdGlvbik8YnI+KyDCoCDC
oF9fYXR0cmlidXRlX18oKG5vaW5saW5lKSk8YnI+K3s8YnI+KyDCoCDCoGNwdV9sb29wX2V4aXRf
ZXhjcChlbnZfY3B1KGVudiksIGV4Y2VwdGlvbiwgMCk7PGJyPit9PGJyPis8YnI+K0lNUExfSEVM
UEVSX0ZMQUdTXzIocmFpc2VfZXhjcCwgVENHX0NBTExfTk9fV0csIG5vcmV0dXJuLCBlbnYsIGkz
Mik8YnI+Kzxicj4rc3RhdGljIEdfTk9SRVRVUk4gdm9pZCBoZWxwZXJfcmFpc2VfZXhjcF9yZXN0
b3JlKENQVUFyY2hTdGF0ZSAqZW52LDxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQzMl90IGV4Y2Vw
dGlvbik8YnI+KyDCoCDCoF9fYXR0cmlidXRlX18oKG5vaW5saW5lKSk8YnI+K3s8YnI+KyDCoCDC
oGNwdV9sb29wX2V4aXRfZXhjcChlbnZfY3B1KGVudiksIGV4Y2VwdGlvbiwgR0VUUEMoKSk7PGJy
Pit9PGJyPis8YnI+K0lNUExfSEVMUEVSX0ZMQUdTXzIocmFpc2VfZXhjcF9yZXN0b3JlLCBUQ0df
Q0FMTF9OT19XRywgbm9yZXR1cm4sIGVudiwgaTMyKTxicj5kaWZmIC0tZ2l0IGEvYWNjZWwvdGNn
L21lc29uLmJ1aWxkIGIvYWNjZWwvdGNnL21lc29uLmJ1aWxkPGJyPmluZGV4IDAwMmFhOGY0NTg4
Li4zZjlhZmNjNWYxZCAxMDA2NDQ8YnI+LS0tIGEvYWNjZWwvdGNnL21lc29uLmJ1aWxkPGJyPisr
KyBiL2FjY2VsL3RjZy9tZXNvbi5idWlsZDxicj5AQCAtNyw2ICs3LDcgQEAgdGNnX3NzID0gc3Mu
c291cmNlX3NldCgpPGJyPsKgdGNnX3NzLmFkZChmaWxlcyg8YnI+wqAgwqAmIzM5O2NwdS1leGVj
LmMmIzM5Oyw8YnI+wqAgwqAmIzM5O2NwdS1leGVjLWNvbW1vbi5jJiMzOTssPGJyPisgwqAmIzM5
O2dlbi1oZWxwZXJzLmMmIzM5Oyw8YnI+wqAgwqAmIzM5O3RjZy1ydW50aW1lLmMmIzM5Oyw8YnI+
wqAgwqAmIzM5O3RjZy1ydW50aW1lLWd2ZWMuYyYjMzk7LDxicj7CoCDCoCYjMzk7dGItbWFpbnQu
YyYjMzk7LDxicj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9hY2NlbC90Y2cvZ2VuLWhlbHBlcnMuaCBi
L2luY2x1ZGUvYWNjZWwvdGNnL2dlbi1oZWxwZXJzLmg8YnI+bmV3IGZpbGUgbW9kZSAxMDA2NDQ8
YnI+aW5kZXggMDAwMDAwMDAwMDAuLjE5Nzg3ZDZkZTI0PGJyPi0tLSAvZGV2L251bGw8YnI+Kysr
IGIvaW5jbHVkZS9hY2NlbC90Y2cvZ2VuLWhlbHBlcnMuaDxicj5AQCAtMCwwICsxLDM3IEBAPGJy
PisvKjxicj4rICogU2hhcmVkIFRDRyBnZW5faGVscGVyXyogQVBJcyBpbXBsZW1lbnRlZCB3aXRo
IElNUExfSEVMUEVSX0ZMQUdTXyouPGJyPisgKjxicj4rICogU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb3ItbGF0ZXI8YnI+KyAqLzxicj4rI2lmbmRlZiBBQ0NFTF9UQ0dfR0VOX0hF
TFBFUlNfSDxicj4rI2RlZmluZSBBQ0NFTF9UQ0dfR0VOX0hFTFBFUlNfSDxicj4rPGJyPisjaWZu
ZGVmIENPTkZJR19UQ0c8YnI+KyNlcnJvciBDYW4gb25seSBpbmNsdWRlIHRoaXMgaGVhZGVyIHdp
dGggVENHPGJyPisjZW5kaWY8YnI+Kzxicj4rI2luY2x1ZGUgJnF1b3Q7dGNnL3RjZy5oJnF1b3Q7
PGJyPis8YnI+Ky8qKjxicj4rICogZ2VuX2hlbHBlcl9yYWlzZV9leGNwOjxicj4rICogQGVudjog
Q1BVIGVudiAodGNnX2Vudik8YnI+KyAqIEBleGNlcHRpb246IEVYQ1BfKiBvciB0YXJnZXQgdHJh
cCBudW1iZXI8YnI+KyAqPGJyPisgKiBTaGFyZWQgVENHIGV4Y2VwdGlvbiByYWlzZSB3aXRob3V0
IHVud2luZC4gQm9keSBpcyBoZWxwZXJfcmFpc2VfZXhjcDxicj4rICogaW4gYWNjZWwvdGNnL2dl
bi1oZWxwZXJzLmMuIEV4aXRzIHZpYSBjcHVfbG9vcF9leGl0X2V4Y3Agd2l0aDxicj4rICogaG9z
dF9wYyAwLjxicj4rICovPGJyPit2b2lkIGdlbl9oZWxwZXJfcmFpc2VfZXhjcChUQ0d2X2VudiBl
bnYsIFRDR3ZfaTMyIGV4Y2VwdGlvbik7PGJyPis8YnI+Ky8qKjxicj4rICogZ2VuX2hlbHBlcl9y
YWlzZV9leGNwX3Jlc3RvcmU6PGJyPisgKiBAZW52OiBDUFUgZW52ICh0Y2dfZW52KTxicj4rICog
QGV4Y2VwdGlvbjogRVhDUF8qIG9yIHRhcmdldCB0cmFwIG51bWJlcjxicj4rICo8YnI+KyAqIFNo
YXJlZCBUQ0cgZXhjZXB0aW9uIHJhaXNlIHdpdGggR0VUUEMoKSB1bndpbmQuIEJvZHkgaXM8YnI+
KyAqIGhlbHBlcl9yYWlzZV9leGNwX3Jlc3RvcmUgaW4gYWNjZWwvdGNnL2dlbi1oZWxwZXJzLmMu
IEV4aXRzIHZpYTxicj4rICogY3B1X2xvb3BfZXhpdF9leGNwLjxicj4rICovPGJyPit2b2lkIGdl
bl9oZWxwZXJfcmFpc2VfZXhjcF9yZXN0b3JlKFRDR3ZfZW52IGVudiwgVENHdl9pMzIgZXhjZXB0
aW9uKTs8YnI+Kzxicj4rI2VuZGlmPGJyPmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvaGVscGVy
LWdlbi1jb21tb24uaCBiL2luY2x1ZGUvZXhlYy9oZWxwZXItZ2VuLWNvbW1vbi5oPGJyPmluZGV4
IDgzNDU5MGRjNGU1Li4xNjU0ODgzMGVjOCAxMDA2NDQ8YnI+LS0tIGEvaW5jbHVkZS9leGVjL2hl
bHBlci1nZW4tY29tbW9uLmg8YnI+KysrIGIvaW5jbHVkZS9leGVjL2hlbHBlci1nZW4tY29tbW9u
Lmg8YnI+QEAgLTExLDQgKzExLDYgQEA8YnI+wqAjaW5jbHVkZSAmcXVvdDtleGVjL2hlbHBlci1n
ZW4uaC5pbmMmcXVvdDs8YnI+wqAjdW5kZWYgwqBIRUxQRVJfSDxicj7CoDxicj4rI2luY2x1ZGUg
JnF1b3Q7YWNjZWwvdGNnL2dlbi1oZWxwZXJzLmgmcXVvdDs8YnI+Kzxicj7CoCNlbmRpZiAvKiBI
RUxQRVJfR0VOX0NPTU1PTl9IICovPGJyPmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvaGVscGVy
LWltcGwuaCBiL2luY2x1ZGUvZXhlYy9oZWxwZXItaW1wbC5oPGJyPm5ldyBmaWxlIG1vZGUgMTAw
NjQ0PGJyPmluZGV4IDAwMDAwMDAwMDAwLi5kMjc5N2U1ZTZhNzxicj4tLS0gL2Rldi9udWxsPGJy
PisrKyBiL2luY2x1ZGUvZXhlYy9oZWxwZXItaW1wbC5oPGJyPkBAIC0wLDAgKzEsMTQ2IEBAPGJy
PisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLzxicj4rLyo8
YnI+KyAqIEltcGxlbWVudCBhIFRDRyBoZWxwZXIgaW4gb25lIC5jIGZpbGU6IHN0YXRpYyBoZWxw
ZXJfaW5mb18qIHBsdXM8YnI+KyAqIGdlbl9oZWxwZXJfKi4gU2FtZSBhcmd1bWVudHMgYXMgREVG
X0hFTFBFUl9GTEFHU19OLiBXcml0ZTxicj4rICogSEVMUEVSKG5hbWUpIGJlc2lkZSB0aGUgaW52
b2NhdGlvbi48YnI+KyAqLzxicj4rI2lmbmRlZiBFWEVDX0hFTFBFUl9JTVBMX0g8YnI+KyNkZWZp
bmUgRVhFQ19IRUxQRVJfSU1QTF9IPGJyPis8YnI+KyNpbmNsdWRlICZxdW90O3RjZy90Y2cuaCZx
dW90Ozxicj4rI2luY2x1ZGUgJnF1b3Q7dGNnL2hlbHBlci1pbmZvLmgmcXVvdDs8YnI+KyNpbmNs
dWRlICZxdW90O2V4ZWMvaGVscGVyLWhlYWQuaC5pbmMmcXVvdDs8YnI+Kzxicj4rI2RlZmluZSBJ
TVBMX0hFTFBFUl9GTEFHU18wKG5hbWUsIGZsYWdzLCByZXQpIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+K3N0YXRpYyBUQ0dIZWxwZXJJbmZvIGdsdWUoaGVscGVy
X2luZm9fLCBuYW1lKSA9IHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4r
IMKgIMKgLmZ1bmMgPSBIRUxQRVIobmFtZSksIC5uYW1lID0gc3RyaW5naWZ5KG5hbWUpLCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+KyDCoCDCoC5mbGFncyA9IGZsYWdzIHwg
ZGhfY2FsbGZsYWcocmV0KSwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPisgwqAgwqAudHlwZW1hc2sgPSBkaF90eXBlbWFzayhyZXQsIDApIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+
K307IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4r
dm9pZCBnbHVlKGdlbl9oZWxwZXJfLCBuYW1lKShkaF9yZXR2YXJfZGVjbDAocmV0KSkgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPit7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoHRjZ19nZW5fY2FsbDAoZ2x1ZSho
ZWxwZXJfaW5mb18sbmFtZSkuZnVuYywgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgXDxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtnbHVlKGhlbHBlcl9pbmZv
XyxuYW1lKSwgZGhfcmV0dmFyKHJldCkpOyDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+K308YnI+Kzxi
cj4rI2RlZmluZSBJTVBMX0hFTFBFUl9GTEFHU18xKG5hbWUsIGZsYWdzLCByZXQsIHQxKSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPitzdGF0aWMgVENHSGVscGVySW5mbyBn
bHVlKGhlbHBlcl9pbmZvXywgbmFtZSkgPSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFw8YnI+KyDCoCDCoC5mdW5jID0gSEVMUEVSKG5hbWUpLCAubmFtZSA9IHN0cmluZ2lmeShu
YW1lKSwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPisgwqAgwqAuZmxhZ3Mg
PSBmbGFncyB8IGRoX2NhbGxmbGFnKHJldCksIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgLnR5cGVtYXNrID0gZGhfdHlwZW1hc2so
cmV0LCAwKSB8IGRoX3R5cGVtYXNrKHQxLCAxKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
K307IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4r
dm9pZCBnbHVlKGdlbl9oZWxwZXJfLCBuYW1lKShkaF9yZXR2YXJfZGVjbChyZXQpIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgZGhfYXJnX2RlY2wodDEsIDEp
KSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBcPGJyPit7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoHRjZ19nZW5fY2FsbDEoZ2x1ZShoZWxwZXJfaW5m
b18sbmFtZSkuZnVuYywgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4r
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtnbHVlKGhlbHBlcl9pbmZvXyxuYW1lKSwg
ZGhfcmV0dmFyKHJldCksIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGRoX2FyZyh0MSwgMSkpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPit9PGJyPis8YnI+KyNkZWZpbmUgSU1QTF9I
RUxQRVJfRkxBR1NfMihuYW1lLCBmbGFncywgcmV0LCB0MSwgdDIpIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8YnI+K3N0YXRpYyBUQ0dIZWxwZXJJbmZvIGdsdWUoaGVscGVyX2luZm9fLCBu
YW1lKSA9IHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4rIMKgIMKgLmZ1
bmMgPSBIRUxQRVIobmFtZSksIC5uYW1lID0gc3RyaW5naWZ5KG5hbWUpLCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+KyDCoCDCoC5mbGFncyA9IGZsYWdzIHwgZGhfY2FsbGZs
YWcocmV0KSwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBcPGJyPisgwqAgwqAudHlwZW1hc2sgPSBkaF90eXBlbWFzayhyZXQsIDApIHwgZGhfdHlwZW1h
c2sodDEsIDEpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfCBkaF90eXBlbWFzayh0MiwgMikgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPit9OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+K3ZvaWQgZ2x1ZShnZW5faGVscGVyXywgbmFtZSko
ZGhfcmV0dmFyX2RlY2wocmV0KSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8
YnI+KyDCoCDCoGRoX2FyZ19kZWNsKHQxLCAxKSwgZGhfYXJnX2RlY2wodDIsIDIpKSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPit7IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoHRjZ19nZW5fY2Fs
bDIoZ2x1ZShoZWxwZXJfaW5mb18sbmFtZSkuZnVuYywgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtnbHVlKGhl
bHBlcl9pbmZvXyxuYW1lKSwgZGhfcmV0dmFyKHJldCksIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRoX2FyZyh0MSwgMSksIGRoX2FyZyh0MiwgMikp
OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+K308YnI+Kzxicj4rI2Rl
ZmluZSBJTVBMX0hFTFBFUl9GTEFHU18zKG5hbWUsIGZsYWdzLCByZXQsIHQxLCB0MiwgdDMpIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+K3N0YXRpYyBUQ0dIZWxwZXJJbmZvIGdsdWUoaGVscGVy
X2luZm9fLCBuYW1lKSA9IHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4r
IMKgIMKgLmZ1bmMgPSBIRUxQRVIobmFtZSksIC5uYW1lID0gc3RyaW5naWZ5KG5hbWUpLCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+KyDCoCDCoC5mbGFncyA9IGZsYWdzIHwg
ZGhfY2FsbGZsYWcocmV0KSwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBcPGJyPisgwqAgwqAudHlwZW1hc2sgPSBkaF90eXBlbWFzayhyZXQsIDApIHwg
ZGhfdHlwZW1hc2sodDEsIDEpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgIMKg
IMKgIMKgIMKgIMKgfCBkaF90eXBlbWFzayh0MiwgMikgfCBkaF90eXBlbWFzayh0MywgMykgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4rfTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPit2b2lkIGdsdWUoZ2VuX2hlbHBlcl8sIG5hbWUpKGRo
X3JldHZhcl9kZWNsKHJldCkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJy
PisgwqAgwqBkaF9hcmdfZGVjbCh0MSwgMSksIGRoX2FyZ19kZWNsKHQyLCAyKSwgZGhfYXJnX2Rl
Y2wodDMsIDMpKSDCoCDCoCDCoCDCoCBcPGJyPit7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoHRjZ19nZW5fY2FsbDMoZ2x1ZShoZWxw
ZXJfaW5mb18sbmFtZSkuZnVuYywgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtnbHVlKGhlbHBlcl9pbmZvXyxu
YW1lKSwgZGhfcmV0dmFyKHJldCksIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGRoX2FyZyh0MSwgMSksIGRoX2FyZyh0MiwgMiksIGRoX2FyZyh0Mywg
MykpOyDCoCDCoCDCoCDCoCBcPGJyPit9PGJyPis8YnI+KyNkZWZpbmUgSU1QTF9IRUxQRVJfRkxB
R1NfNChuYW1lLCBmbGFncywgcmV0LCB0MSwgdDIsIHQzLCB0NCkgwqAgwqAgwqAgwqAgwqAgXDxi
cj4rc3RhdGljIFRDR0hlbHBlckluZm8gZ2x1ZShoZWxwZXJfaW5mb18sIG5hbWUpID0geyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPisgwqAgwqAuZnVuYyA9IEhFTFBFUihu
YW1lKSwgLm5hbWUgPSBzdHJpbmdpZnkobmFtZSksIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgXDxicj4rIMKgIMKgLmZsYWdzID0gZmxhZ3MgfCBkaF9jYWxsZmxhZyhyZXQpLCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+KyDCoCDC
oC50eXBlbWFzayA9IGRoX3R5cGVtYXNrKHJldCwgMCkgfCBkaF90eXBlbWFzayh0MSwgMSkgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGRoX3R5cGVt
YXNrKHQyLCAyKSB8IGRoX3R5cGVtYXNrKHQzLCAzKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGRoX3R5cGVtYXNrKHQ0LCA0KSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+K307IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rdm9pZCBn
bHVlKGdlbl9oZWxwZXJfLCBuYW1lKShkaF9yZXR2YXJfZGVjbChyZXQpIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgZGhfYXJnX2RlY2wodDEsIDEpLCBkaF9h
cmdfZGVjbCh0MiwgMiksIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+KyDCoCDCoGRoX2FyZ19kZWNsKHQzLCAzKSwgZGhfYXJnX2RlY2wodDQsIDQpKSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPit7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoHRjZ19nZW5f
Y2FsbDQoZ2x1ZShoZWxwZXJfaW5mb18sbmFtZSkuZnVuYywgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgXDxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtnbHVl
KGhlbHBlcl9pbmZvXyxuYW1lKSwgZGhfcmV0dmFyKHJldCksIMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRoX2FyZyh0MSwgMSksIGRoX2FyZyh0Miwg
MiksIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGRoX2FyZyh0MywgMyksIGRoX2FyZyh0NCwgNCkpOyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+K308YnI+Kzxicj4rI2RlZmluZSBJTVBMX0hF
TFBFUl9GTEFHU181KG5hbWUsIGZsYWdzLCByZXQsIHQxLCB0MiwgdDMsIHQ0LCB0NSkgwqAgwqAg
wqAgXDxicj4rc3RhdGljIFRDR0hlbHBlckluZm8gZ2x1ZShoZWxwZXJfaW5mb18sIG5hbWUpID0g
eyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPisgwqAgwqAuZnVuYyA9IEhF
TFBFUihuYW1lKSwgLm5hbWUgPSBzdHJpbmdpZnkobmFtZSksIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgLmZsYWdzID0gZmxhZ3MgfCBkaF9jYWxsZmxhZyhyZXQp
LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
KyDCoCDCoC50eXBlbWFzayA9IGRoX3R5cGVtYXNrKHJldCwgMCkgfCBkaF90eXBlbWFzayh0MSwg
MSkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGRo
X3R5cGVtYXNrKHQyLCAyKSB8IGRoX3R5cGVtYXNrKHQzLCAzKSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGRoX3R5cGVtYXNrKHQ0LCA0KSB8IGRo
X3R5cGVtYXNrKHQ1LCA1KSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPit9OyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+K3ZvaWQgZ2x1ZShn
ZW5faGVscGVyXywgbmFtZSkoZGhfcmV0dmFyX2RlY2wocmV0KSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFw8YnI+KyDCoCDCoGRoX2FyZ19kZWNsKHQxLCAxKSwgZGhfYXJnX2Rl
Y2wodDIsIDIpLCBkaF9hcmdfZGVjbCh0MywgMyksIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoGRo
X2FyZ19kZWNsKHQ0LCA0KSwgZGhfYXJnX2RlY2wodDUsIDUpKSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPit7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoHRjZ19nZW5fY2FsbDUoZ2x1ZShoZWxw
ZXJfaW5mb18sbmFtZSkuZnVuYywgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtnbHVlKGhlbHBlcl9pbmZvXyxu
YW1lKSwgZGhfcmV0dmFyKHJldCksIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGRoX2FyZyh0MSwgMSksIGRoX2FyZyh0MiwgMiksIGRoX2FyZyh0Mywg
MyksIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGhfYXJn
KHQ0LCA0KSwgZGhfYXJnKHQ1LCA1KSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj4rfTxicj4rPGJyPisjZGVmaW5lIElNUExfSEVMUEVSX0ZMQUdTXzYobmFtZSwgZmxh
Z3MsIHJldCwgdDEsIHQyLCB0MywgdDQsIHQ1LCB0NikgwqAgXDxicj4rc3RhdGljIFRDR0hlbHBl
ckluZm8gZ2x1ZShoZWxwZXJfaW5mb18sIG5hbWUpID0geyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBcPGJyPisgwqAgwqAuZnVuYyA9IEhFTFBFUihuYW1lKSwgLm5hbWUgPSBzdHJp
bmdpZnkobmFtZSksIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKg
LmZsYWdzID0gZmxhZ3MgfCBkaF9jYWxsZmxhZyhyZXQpLCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+KyDCoCDCoC50eXBlbWFzayA9IGRoX3R5
cGVtYXNrKHJldCwgMCkgfCBkaF90eXBlbWFzayh0MSwgMSkgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBcPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGRoX3R5cGVtYXNrKHQyLCAyKSB8IGRoX3R5
cGVtYXNrKHQzLCAzKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPisgwqAgwqAgwqAgwqAg
wqAgwqAgwqB8IGRoX3R5cGVtYXNrKHQ0LCA0KSB8IGRoX3R5cGVtYXNrKHQ1LCA1KSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBcPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IGRoX3R5cGVtYXNr
KHQ2LCA2KSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+K307IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgXDxicj4rdm9pZCBnbHVlKGdlbl9oZWxwZXJfLCBuYW1lKShkaF9yZXR2YXJfZGVjbChy
ZXQpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgZGhfYXJn
X2RlY2wodDEsIDEpLCBkaF9hcmdfZGVjbCh0MiwgMiksIGRoX2FyZ19kZWNsKHQzLCAzKSwgwqAg
wqAgwqAgwqAgXDxicj4rIMKgIMKgZGhfYXJnX2RlY2wodDQsIDQpLCBkaF9hcmdfZGVjbCh0NSwg
NSksIGRoX2FyZ19kZWNsKHQ2LCA2KSkgwqAgwqAgwqAgwqAgXDxicj4reyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPisgwqAgwqB0Y2dfZ2VuX2Nh
bGw2KGdsdWUoaGVscGVyX2luZm9fLG5hbWUpLmZ1bmMsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7Z2x1ZSho
ZWxwZXJfaW5mb18sbmFtZSksIGRoX3JldHZhcihyZXQpLCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJy
PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkaF9hcmcodDEsIDEpLCBkaF9hcmcodDIsIDIp
LCBkaF9hcmcodDMsIDMpLCDCoCDCoCDCoCDCoCDCoFw8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGRoX2FyZyh0NCwgNCksIGRoX2FyZyh0NSwgNSksIGRoX2FyZyh0NiwgNikpOyDCoCDC
oCDCoCDCoCBcPGJyPit9PGJyPis8YnI+KyNkZWZpbmUgSU1QTF9IRUxQRVJfRkxBR1NfNyhuYW1l
LCBmbGFncywgcmV0LCB0MSwgdDIsIHQzLCB0NCwgdDUsIHQ2LCB0NylcPGJyPitzdGF0aWMgVENH
SGVscGVySW5mbyBnbHVlKGhlbHBlcl9pbmZvXywgbmFtZSkgPSB7IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoC5mdW5jID0gSEVMUEVSKG5hbWUpLCAubmFtZSA9
IHN0cmluZ2lmeShuYW1lKSwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPisg
wqAgwqAuZmxhZ3MgPSBmbGFncyB8IGRoX2NhbGxmbGFnKHJldCksIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgLnR5cGVtYXNrID0g
ZGhfdHlwZW1hc2socmV0LCAwKSB8IGRoX3R5cGVtYXNrKHQxLCAxKSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgZGhfdHlwZW1hc2sodDIsIDIpIHwg
ZGhfdHlwZW1hc2sodDMsIDMpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoCDC
oCDCoCDCoCDCoCDCoHwgZGhfdHlwZW1hc2sodDQsIDQpIHwgZGhfdHlwZW1hc2sodDUsIDUpIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgZGhfdHlw
ZW1hc2sodDYsIDYpIHwgZGhfdHlwZW1hc2sodDcsIDcpIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+K307IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
XDxicj4rdm9pZCBnbHVlKGdlbl9oZWxwZXJfLCBuYW1lKShkaF9yZXR2YXJfZGVjbChyZXQpIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgZGhfYXJnX2RlY2wo
dDEsIDEpLCBkaF9hcmdfZGVjbCh0MiwgMiksIGRoX2FyZ19kZWNsKHQzLCAzKSwgwqAgwqAgwqAg
wqAgXDxicj4rIMKgIMKgZGhfYXJnX2RlY2wodDQsIDQpLCBkaF9hcmdfZGVjbCh0NSwgNSksIGRo
X2FyZ19kZWNsKHQ2LCA2KSwgwqAgwqAgwqAgwqAgXDxicj4rIMKgIMKgZGhfYXJnX2RlY2wodDcs
IDcpKSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPit7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoHRjZ19nZW5fY2FsbDcoZ2x1ZShoZWxwZXJf
aW5mb18sbmFtZSkuZnVuYywgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtnbHVlKGhlbHBlcl9pbmZvXyxuYW1l
KSwgZGhfcmV0dmFyKHJldCksIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+KyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGRoX2FyZyh0MSwgMSksIGRoX2FyZyh0MiwgMiksIGRoX2FyZyh0MywgMyks
IMKgIMKgIMKgIMKgIMKgXDxicj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGhfYXJnKHQ0
LCA0KSwgZGhfYXJnKHQ1LCA1KSwgZGhfYXJnKHQ2LCA2KSwgwqAgwqAgwqAgwqAgwqBcPGJyPisg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkaF9hcmcodDcsIDcpKTsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4rfTxicj4rPGJy
PisjZW5kaWYgLyogRVhFQ19IRUxQRVJfSU1QTF9IICovPGJyPjxicj5EbyB5b3UgbWVhbiBkb2lu
ZyBsaWtlIHRoaXM/PGJyPjxicj48YnI+LS08YnI+wqAgwqAgwqAgwqAgwqDmraToh7Q8YnI+56S8
PGJyPue9l+WLh+WImjxicj5Zb3Vyczxicj7CoCDCoCBzaW5jZXJlbHksPGJyPllvbmdnYW5nIEx1
bzwvZGl2Pg0K
--000000000000c946c6065bbb2066--


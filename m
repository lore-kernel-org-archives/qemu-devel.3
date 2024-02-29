Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED276C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfkpw-0005WF-5o; Thu, 29 Feb 2024 13:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfkpt-0005Vn-KD
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:08:50 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfkpr-0000Yd-Ey
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:08:49 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412a9e9c776so14774245e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709230125; x=1709834925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+odfJJmGUBVs3NL339q+/zPmH/YzwxLQbAHyvq40fc=;
 b=WDjhRwf8vEGWWQBbB8/MRusYotCvOlVkU+4g4BK081z72hO/jSxx5mKBHfCWdyoFEH
 NCm3X9YfPPWnPjSikBKMwJF9LbXOV0XD7LJNkDc1t9KNR+B+bhrWX/IqudCb4HyXbhOw
 POiAUYFIdPqzcgl6BNA3l5CFn8TH6zu4GWNA5OAZqce8bzmSrJWM+XwTlffrT8XvXLuk
 FOQwSgRUUgLsPXZ3oPrL+QfODo6kEiKxrtQFMhLn+Z4LeNJv9QOBJ4j5GFNQf7+oGv0s
 8EdyDeCiWJE6DyLEKdJXNYmAXqCZaXjgr7Xe74lz7Kw7CmWIuhlgml21dYaIV0UUvpO8
 laDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709230125; x=1709834925;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+odfJJmGUBVs3NL339q+/zPmH/YzwxLQbAHyvq40fc=;
 b=SjB/ZGB7cjZ1d/DWZFWhelMP/gdYzSX+sD6bFpyjrfombvljEadLzu1a7zOXh2AnUr
 w2LPPSQMs3G9HWHhEvWEpvzhzyXdkWUxH53CLdSwHAkxTzVqPcS5/GkZR5QUXQ/WukK+
 C42vHJK/VIvOGQ+XqfzBp+A6ajiueJNZlq5uPGr3tEnx6g7oCFswavkdBHW3KIYjJwDa
 k1yHYdMQZKYhqaae7ne/bPJepQwlLHEQZfFT5fs1+XFXqJvrxeTyeSb7C0kz9ohoNzMl
 hkYqW89Ixqo2yypWriHt+Q2X2AG2a6lvgCNwfgpU8XVCjwdAtMw47OCndehhvRA/96uk
 591A==
X-Gm-Message-State: AOJu0Yxo/oyrTZH7fqJFTT4SSBldtSP3NNG3oIIZEZDqBXUGk7DPRjEF
 mC0naGhVTbKKNPIAzVxdGm828v8KW2Im9twPXk/gOyNMNS+keUKVLITeztY/Lc0=
X-Google-Smtp-Source: AGHT+IHxcSKV3t+eGPW/aMLIkKIl/h2LV5Y4ozscWvqsiRPBUZODXWIF4nUqzyEdSzzaQN+RnQYpQw==
X-Received: by 2002:a5d:6303:0:b0:33e:11d7:1a95 with SMTP id
 i3-20020a5d6303000000b0033e11d71a95mr2729870wru.27.1709230125185; 
 Thu, 29 Feb 2024 10:08:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s15-20020a7bc38f000000b004128f1ace2asm5788296wmj.19.2024.02.29.10.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 10:08:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 784BD5F7A7;
 Thu, 29 Feb 2024 18:08:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Luc Michel <luc.michel@amd.com>
Subject: Re: [PATCH v6 06/12] tests/plugin/mem: migrate to new per_vcpu API
In-Reply-To: <20240229052506.933222-7-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 29 Feb 2024 09:25:00 +0400")
References: <20240229052506.933222-1-pierrick.bouvier@linaro.org>
 <20240229052506.933222-7-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 18:08:44 +0000
Message-ID: <87y1b35ej7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Reviewed-by: Luc Michel <luc.michel@amd.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/plugin/mem.c | 46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
> index 44e91065ba7..b650dddcce1 100644
> --- a/tests/plugin/mem.c
> +++ b/tests/plugin/mem.c
> @@ -16,9 +16,14 @@
>=20=20
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>=20=20
> -static uint64_t inline_mem_count;
> -static uint64_t cb_mem_count;
> -static uint64_t io_count;
> +typedef struct {
> +    uint64_t mem_count;
> +    uint64_t io_count;
> +} CPUCount;
> +
> +static struct qemu_plugin_scoreboard *counts;
> +static qemu_plugin_u64 mem_count;
> +static qemu_plugin_u64 io_count;
>  static bool do_inline, do_callback;
>  static bool do_haddr;
>  static enum qemu_plugin_mem_rw rw =3D QEMU_PLUGIN_MEM_RW;
> @@ -27,16 +32,16 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
>      g_autoptr(GString) out =3D g_string_new("");
>=20=20
> -    if (do_inline) {
> -        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", inlin=
e_mem_count);
> -    }
> -    if (do_callback) {
> -        g_string_append_printf(out, "callback mem accesses: %" PRIu64 "\=
n", cb_mem_count);
> +    if (do_inline || do_callback) {
> +        g_string_printf(out, "mem accesses: %" PRIu64 "\n",
> +                        qemu_plugin_u64_sum(mem_count));
>      }
>      if (do_haddr) {
> -        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_cou=
nt);
> +        g_string_append_printf(out, "io accesses: %" PRIu64 "\n",
> +                               qemu_plugin_u64_sum(io_count));
>      }
>      qemu_plugin_outs(out->str);
> +    qemu_plugin_scoreboard_free(counts);
>  }
>=20=20
>  static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t memin=
fo,
> @@ -46,12 +51,12 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plu=
gin_meminfo_t meminfo,
>          struct qemu_plugin_hwaddr *hwaddr;
>          hwaddr =3D qemu_plugin_get_hwaddr(meminfo, vaddr);
>          if (qemu_plugin_hwaddr_is_io(hwaddr)) {
> -            io_count++;
> +            qemu_plugin_u64_add(io_count, cpu_index, 1);
>          } else {
> -            cb_mem_count++;
> +            qemu_plugin_u64_add(mem_count, cpu_index, 1);
>          }
>      } else {
> -        cb_mem_count++;
> +        qemu_plugin_u64_add(mem_count, cpu_index, 1);
>      }
>  }
>=20=20
> @@ -64,9 +69,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct =
qemu_plugin_tb *tb)
>          struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
>=20=20
>          if (do_inline) {
> -            qemu_plugin_register_vcpu_mem_inline(insn, rw,
> -                                                 QEMU_PLUGIN_INLINE_ADD_=
U64,
> -                                                 &inline_mem_count, 1);
> +            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
> +                insn, rw,
> +                QEMU_PLUGIN_INLINE_ADD_U64,
> +                mem_count, 1);
>          }
>          if (do_callback) {
>              qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
> @@ -117,6 +123,16 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plug=
in_id_t id,
>          }
>      }
>=20=20
> +    if (do_inline && do_callback) {
> +        fprintf(stderr,
> +                "can't enable inline and callback counting at the same t=
ime\n");
> +        return -1;
> +    }
> +
> +    counts =3D qemu_plugin_scoreboard_new(sizeof(CPUCount));
> +    mem_count =3D qemu_plugin_scoreboard_u64_in_struct(
> +        counts, CPUCount, mem_count);
> +    io_count =3D qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, =
io_count);
>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>      qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>      return 0;

You need the following to keep check-tcg working:

modified   tests/tcg/Makefile.target
@@ -168,7 +168,7 @@ RUN_TESTS+=3D$(EXTRA_RUNS)
=20
 # Some plugins need additional arguments above the default to fully
 # exercise things. We can define them on a per-test basis here.
-run-plugin-%-with-libmem.so: PLUGIN_ARGS=3D$(COMMA)inline=3Dtrue$(COMMA)ca=
llback=3Dtrue
+run-plugin-%-with-libmem.so: PLUGIN_ARGS=3D$(COMMA)inline=3Dtrue
=20
 ifeq ($(filter %-softmmu, $(TARGET)),)
 run-%: %

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


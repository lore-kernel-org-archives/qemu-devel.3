Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831A9CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 18:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH4yC-00016x-SA; Thu, 06 Nov 2025 13:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1vH4y7-00016d-4G
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 13:44:24 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1vH4y4-0003hg-Te
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 13:44:22 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b719ca8cb8dso277593966b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 10:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762454659; x=1763059459; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dliXUtXyDUESoe+5EnrivXiNFZZUf89xHzNP2/xdQTU=;
 b=wOcPKpl7leVgOjYrh9Brz/CvPjqaRrKvbq4jWjjQAhcNcdXEqjPDVl8BM7FPT0/P7a
 yfjNOnsNmxdvMXIQcJH9L2vAu84BYq/S/2PoT7tnmBUlYnXxCZH/DbIDSZdQn7xhWRIN
 jIq5p4JZYlS+eHhNGo/QpdCo3AFkFVRULZdK3OFq2bN7d6n4vPGjtOI6qSj42wN11j+M
 /4QUgKo86Rrrvs6EtZrUM7PHsbUeUleiirz8oghibudY1gpzKbF6XfYHEMUzFXEhWZV1
 1Nhar6zekc728KgieWoJkEafv/0yoCQBguYBaVCR83IqMU89gZgo2YurqZpuxxieuvUa
 XITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454659; x=1763059459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dliXUtXyDUESoe+5EnrivXiNFZZUf89xHzNP2/xdQTU=;
 b=Rveev/LPwmx1P8Hibjyf3wnBpNgvBTFN8D8lVduy4gW3ZR4zxRMGmjfmejzFBkrM0X
 8q0C1lfVzTy8dJbvMRYP2+pX9Aa7BRTNg+11NBLEMByJxAMmF/OFaymhLNz5/X/IfWgO
 P+QkBFTh5DDEo9raIooNaI44/1sT9WdF/Ayk2aMk+aYPWSVX7H7x7RLrKAhbNeFRN23p
 JTBXTqPVqdParyhonT3TwwDfQ4/HK0uGIKiAcXte6tBLNmZLj7m23j8lKEm0zXYjds8o
 aF+zq7iBMXlhQYxFt+UuWI/xgo7DdK4iqIWXazrQMEP1EZnSQiOfXeoTGkDEM+jpbXB6
 vHug==
X-Gm-Message-State: AOJu0YzJnE6hXULK/DdtbZJQrChnl/LWIXOyCYtcx71tnIGbncKY3hYM
 P9gUPzZETmvW0WmP3HVjCo7WqNeb71LhDJkP8gL/9CHbWIxs2+A/tUGO5Eyhxmlnt2v3zTgEORw
 9rqLk6O6FNp3C4sExUmLSxzrxGVlV5jdxaoGmIRjtsPpEI/J5vTrY19YGqrc=
X-Gm-Gg: ASbGncvSQ/BOgzLrh4wKujB9Siwu+/y1/iYn1Qo4nrxvSe/Z47HAiCO4Fbp3k0FyFZo
 HLDlU+3x+ePDlc+EzS4YHOGlM8uM1/S9RH7yUpQnGpaG3Dwt7mTysYQaopuZaTyi7ObfI3foNcK
 k0IEAbF0Tfhff+a3m61N05p+WqzH9fqkWQVxfqLGoGKvTTgrkewjmZCxeYOpK0W2atLsNZI2e/D
 6VTKV0ea6HoMh8G/zbepOhuMrn8LjUlJCeotzO0boW5O+QiWgQWZ75bLm3yXBTVaQ7pEZjvBRld
 OL/wWgoErGp34W0=
X-Google-Smtp-Source: AGHT+IHb7ytWFbZte9t5xgvofRF14rifFQIui14x0+J5M8ctehrRlSQAn1+BZ9EcQXqgXFRTFDh0V1wpU8gKes9G+mc=
X-Received: by 2002:a17:907:3fa5:b0:b3f:a960:e057 with SMTP id
 a640c23a62f3a-b72c090e626mr25432966b.31.1762454658671; Thu, 06 Nov 2025
 10:44:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHUE=o-aypvXPxZXssD8nMJm+Qa9Nsp1HRcNVbC27tNkpV75fg@mail.gmail.com>
 <20251014003008.2520701-1-navidem@google.com>
 <20251014003008.2520701-2-navidem@google.com>
In-Reply-To: <20251014003008.2520701-2-navidem@google.com>
From: Navid Emamdoost <navidem@google.com>
Date: Thu, 6 Nov 2025 10:44:06 -0800
X-Gm-Features: AWmQ_blfPC4sbYdqHXdPOR5p25SaPTpnk6maHu2TubHITumE6-TLu3nk69vAGtE
Message-ID: <CAGXevkhGhKbrQRVb6euaNWA-a+zCfz8K6NnToVOwFd8iQK3Mgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tests/qtest/fuzz: Add generic fuzzer for VNC
To: qemu-devel@nongnu.org, alxndr@bu.edu
Cc: berrange@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zubin Mithra <zsm@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=navidem@google.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Friendly ping.

On Mon, Oct 13, 2025 at 5:30=E2=80=AFPM Navid Emamdoost <navidem@google.com=
> wrote:
>
> Add a new generic fuzz target for the QEMU VNC server. This target
> exercises both the standard VNC protocol and the VNC-over-WebSocket
> transport layer, increasing coverage of a primary remote attack surface.
>
> To support parallel fuzzing (e.g., with oss-fuzz), the VNC unix
> socket paths are generated dynamically. The fuzzer harness inspects the
> command line for placeholders and replaces them with unique paths
> created by mkstemp() before execution.
>
> ---
>
> This new target increases code coverage in the VNC subsystem
> and related networking and I/O code.
> The baseline coverage below was generated by running all existing fuzz
> targets with the oss-fuzz corpus. The new target shows significant gains:
>
> -------------------------------------------------------------------------=
---
> File                       New Target                Baseline        Chan=
ge
> -------------------------------------------------------------------------=
---
> vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        +336
> keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         +91
> net-listener.c             76/198 (38.4%)       3/198 (1.5%)         +73
> channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        +54
> qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        +44
> vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         +41
> dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         +25
>
> Signed-off-by: Navid Emamdoost <navidem@google.com>
> ---
>  tests/qtest/fuzz/fuzz.c                 | 65 +++++++++++++++++++++++++
>  tests/qtest/fuzz/generic_fuzz_configs.h |  5 ++
>  2 files changed, 70 insertions(+)
>
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index ca248a51a6..b77c3ceb2b 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -126,6 +126,46 @@ static FuzzTarget *fuzz_get_target(char* name)
>      return NULL;
>  }
>
> +/*
> + * Global variables to hold the unique socket paths for cleanup.
> + */
> +static char g_vnc_socket_path[sizeof("/tmp/qemu-vnc.XXXXXX")];
> +static char g_vnc_ws_socket_path[sizeof("/tmp/qemu-vnc-ws.XXXXXX")];
> +
> +/*
> + * atexit() handler to clean up both socket files.
> + */
> +static void cleanup_vnc_sockets(void)
> +{
> +    if (g_vnc_socket_path[0] !=3D '\0') {
> +        unlink(g_vnc_socket_path);
> +    }
> +    if (g_vnc_ws_socket_path[0] !=3D '\0') {
> +        unlink(g_vnc_ws_socket_path);
> +    }
> +}
> +
> +/* Helper function to find and replace a placeholder in a GString */
> +static bool replace_socket_placeholder(GString *cmd_line, const char *pl=
aceholder,
> +                                       const char *path_template, char *=
global_path_out)
> +{
> +    char *placeholder_ptr =3D strstr(cmd_line->str, placeholder);
> +    if (placeholder_ptr) {
> +        int fd;
> +        strcpy(global_path_out, path_template);
> +        fd =3D mkstemp(global_path_out);
> +        if (fd =3D=3D -1) {
> +            perror("mkstemp failed");
> +            return false;
> +        }
> +        close(fd);
> +
> +        gssize pos =3D placeholder_ptr - cmd_line->str;
> +        g_string_erase(cmd_line, pos, strlen(placeholder));
> +        g_string_insert(cmd_line, pos, global_path_out);
> +    }
> +    return true;
> +}
>
>  /* Sometimes called by libfuzzer to mutate two inputs into one */
>  size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
> @@ -213,6 +253,31 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, ch=
ar ***envp)
>      g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
>                             getenv("QTEST_LOG") ? "" : "-qtest-log none")=
;
>
> +    /*
> +     * For the VNC fuzzer, we replace placeholders for both the standard
> +     * and WebSocket VNC listeners with unique socket paths.
> +     */
> +    if (strcmp(fuzz_target->name, "generic-fuzz-vnc") =3D=3D 0) {
> +        bool success =3D true;
> +        success &=3D replace_socket_placeholder(cmd_line, "VNC_SOCKET_PA=
TH",
> +                                              "/tmp/qemu-vnc.XXXXXX", g_=
vnc_socket_path);
> +        success &=3D replace_socket_placeholder(cmd_line, "VNC_WS_SOCKET=
_PATH",
> +                                              "/tmp/qemu-vnc-ws.XXXXXX",=
 g_vnc_ws_socket_path);
> +
> +        if (!success) {
> +            exit(1);
> +        }
> +
> +        /* Check that placeholders were actually found and replaced */
> +        if (g_vnc_socket_path[0] =3D=3D '\0' || g_vnc_ws_socket_path[0] =
=3D=3D '\0') {
> +            fprintf(stderr, "ERROR: VNC fuzzer is missing a socket place=
holder\n");
> +            exit(1);
> +        }
> +
> +        /* Register a single cleanup handler for both sockets */
> +        atexit(cleanup_vnc_sockets);
> +    }
> +
>      /* Split the runcmd into an argv and argc */
>      wordexp_t result;
>      wordexp(cmd_line->str, &result, 0);
> diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/g=
eneric_fuzz_configs.h
> index ef0ad95712..bd2d875dd8 100644
> --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> @@ -247,6 +247,11 @@ const generic_fuzz_config predefined_configs[] =3D {
>          .args =3D "-machine q35 -nodefaults "
>          "-parallel file:/dev/null",
>          .objects =3D "parallel*",
> +    },{
> +        .name =3D "vnc",
> +        .args =3D "-machine q35 -nodefaults "
> +               "-vnc vnc=3Dunix:VNC_SOCKET_PATH,websocket=3Dunix:VNC_WS_=
SOCKET_PATH",
> +        .objects =3D "*",
>      }
>  };
>
> --
> 2.51.0.760.g7b8bcc2412-goog
>


--=20
Thank you,
Navid.


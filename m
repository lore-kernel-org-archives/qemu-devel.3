Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73A1CF885B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 20:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swpC5-0003pQ-Pp; Fri, 04 Oct 2024 16:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swpC0-0003p3-Hq
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:46:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swpBy-0001M8-SL
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:46:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so24816855e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728074785; x=1728679585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvR+aBbQl/+Tjy/eMK8lMJRH0Adf7wY+DE8N8NrqNrA=;
 b=N2asHO6HTRYxwBjbgl1miquzIB7r/rEuG6fZ+5JR/s19rJBh8yrkJJ8SjoStDZ3yKY
 vv2WG8CmhPcjx8esFAWO5/2jh0XDn+4InA5r+IASdkuwDB26KRAorhp4hm7f9cSswjBo
 UrnAG2vmIp8tIEr3blLxLzOy+oEyBQoLnVRS9Wcw5ob+vkk452sRqkhLFimFN/V6IRq0
 ZcOYg/WhvhTZIvGju0pQdAfDPsnK/GvksgERmFjskBWO43s7l3iUs7lEAwgNKb/2DXvC
 KYLGjIU8JBlTeVUsAwO65a85ieorzP+y2EWMvlJ+jich4WWcRMhFZmiA/BT+GCrLtIlY
 2sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728074785; x=1728679585;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvR+aBbQl/+Tjy/eMK8lMJRH0Adf7wY+DE8N8NrqNrA=;
 b=r1ntW4kFy7CWJKnANHan0SK1qCkupi2Po83dSnq6cs+w7pGVq3wj4qweZ2Vb8ND38D
 2ZzEmA9Cw7i2eALbWwwm7vdMqjDBdhQGiNf3dc+5UO3ihQNeMA7DW/fWO+Uda43fHskC
 s/OFTAR/dU+Vc7FwvQwSM2JHczHK3+S25r8HPqQNaHMcwUSG44f9Dnq9NH9bHA0eEQnS
 bqUE2SRKWWE3+jOwWMuZzG+dlcxcxUrH367/RSaktsOjg9cegSO+f3sYV/odobwMUTLw
 8h660O/2thxX58VOo6QgaX5IlJo2tPxJQjaJeVDmke2n89qj5Z97DoFTOKi1pEVyfsWf
 SLrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1gaqt93fxDLhev9xt/u6n37PDCppWeAF+nHs1fN4GwglkiS5RYCCxQK8bGv06e7OR3ZI4MwNNZVn4@nongnu.org
X-Gm-Message-State: AOJu0Yzeu7ccfjQYMC5v4spOXXiv4KMZLtvM2zoGiv+6okbfe0DOtNs4
 5XiHpPu5/ZFWTeLfe7LZTarYHkRXWE8eQEGsIO7c6qvee8jdb72FAfOS2Qh+23g=
X-Google-Smtp-Source: AGHT+IFn565o9IQYiuyKjupRhmbFvstq8YNeeMA3ZkRVPtUvbwMly1RHyJPRfj5CwdX3IWf4H/+4Vw==
X-Received: by 2002:a5d:58f8:0:b0:37c:cfba:d16b with SMTP id
 ffacd0b85a97d-37d0e7bb22emr2631372f8f.44.1728074785053; 
 Fri, 04 Oct 2024 13:46:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a992e784666sm39054866b.100.2024.10.04.13.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 13:46:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B49345F876;
 Fri,  4 Oct 2024 21:46:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: richard.henderson@linaro.org,  pbonzini@redhat.com,  philmd@linaro.org,
 slongfield@google.com,  komlodi@google.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] gdbstub: Fix wrong CPUState pointer in breakpoint
 functions
In-Reply-To: <20240906225451.1039718-2-roqueh@google.com> (Roque Arcudia
 Hernandez's message of "Fri, 6 Sep 2024 15:54:50 -0700")
References: <20240906225451.1039718-1-roqueh@google.com>
 <20240906225451.1039718-2-roqueh@google.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 04 Oct 2024 21:46:23 +0100
Message-ID: <87v7y71tr4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Roque Arcudia Hernandez <roqueh@google.com> writes:

> In the context of using the remote gdb with multiple
> processes/inferiors (multiple cluster machine) a given breakpoint
> will target an specific inferior. If needed the remote protocol will
> use the packet 'H op thread-id' with op =3D 'g' to change focus to the
> inferior we want to insert/remove the breakpoint to, for instance
> 'Hgp3.3' and not 'Hcp3.3'.
>
> This is supported by the documentation of the H packets:
>
>  > 'H op thread-id'
>  > Set thread for subsequent operations ('m', 'M', 'g', 'G',
>  > et.al.). Depending on the operation to be performed, op should be
>  > 'c' for step and continue operations (note that this is
>  > deprecated, supporting the 'vCont' command is a better option),
>  > and 'g' for other operations.

Can we better comment:

    CPUState *c_cpu; /* current CPU for step/continue ops */
    CPUState *g_cpu; /* current CPU for other ops */

in GDBState?

>
> This can also be verified in the GDB source code file gdb/remote.c.
> Functions remote_target::insert_breakpoint and
> remote_target::remove_breakpoint will eventually call
> remote_target::set_general_thread if it needs to change the process
> focus and not remote_target::set_continue_thread.
>
> This can be seen around a comment that says:
>
>       /* Make sure the remote is pointing at the right process, if
>          necessary.  */
>
> Google-Bug-Id: 355027002
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  gdbstub/gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index d08568cea0..98574eba68 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1148,7 +1148,7 @@ static void handle_insert_bp(GArray *params, void *=
user_ctx)
>          return;
>      }
>=20=20
> -    res =3D gdb_breakpoint_insert(gdbserver_state.c_cpu,
> +    res =3D gdb_breakpoint_insert(gdbserver_state.g_cpu,
>                                  gdb_get_cmd_param(params, 0)->val_ul,
>                                  gdb_get_cmd_param(params, 1)->val_ull,
>                                  gdb_get_cmd_param(params, 2)->val_ull);
> @@ -1172,7 +1172,7 @@ static void handle_remove_bp(GArray *params, void *=
user_ctx)
>          return;
>      }
>=20=20
> -    res =3D gdb_breakpoint_remove(gdbserver_state.c_cpu,
> +    res =3D gdb_breakpoint_remove(gdbserver_state.g_cpu,
>                                  gdb_get_cmd_param(params, 0)->val_ul,
>                                  gdb_get_cmd_param(params, 1)->val_ull,
>                                  gdb_get_cmd_param(params, 2)->val_ull);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089EAC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 16:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTP2a-0002qi-J7; Fri, 26 Jan 2024 11:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTP2S-0002jz-QE
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 11:26:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTP2Q-0001SP-RS
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 11:26:44 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33926ccbc80so403063f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706286401; x=1706891201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYVNmQ94qljFnvpsh5pbVBuKz2UJ8nA5SnjJYBRVJkc=;
 b=ostwKVRVPXBvwsjBzvh3TOSw7sfB39xSezvYVs9tby3djaPfFxmHUo6WM5OHGJsHAX
 Go3Jbz8heC8wkSZv1IzpG3gZ4E5gn5wqkCJFrSbNEyfKtcRYfUMTJkTXMXzdjDyek3vD
 BsA4s236H0p7lvgqDOkkva6VjwcqEDdt6a4dvsN7XPF1Iylm6jpfRGJv3MRmPkYks457
 XZv8Ik/o9fnjjfuIXlxBVDbzoMATxk6kJrnXzu4uzq344ZUUVCiwbwsq14imwfLxS0OO
 AYSsKxhDerH30Dp8koqkZA4j/W/pS5WAEazhbPHQxCkFi/0pkwwMhH0JhbiAhSMRfMCf
 wstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706286401; x=1706891201;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hYVNmQ94qljFnvpsh5pbVBuKz2UJ8nA5SnjJYBRVJkc=;
 b=Hu8pf4zdCnjDCApMIOjTqzyoKU21WDHlxlT4q9eUKfNUUJxxSYKObtk2dmgxuQxDr2
 /S/HtYm455EL0/yWOrhDnnoOmGPZrpugDodG5Lj1rdD5FXcmlgZpstgd7nFml9k+o4r7
 Jxa+ocAdTsiUZv/A6Cz3Fy0J331fXJyuY1xtc7bW//YYKl7zDdLUaSUSFiwX4knqNwrY
 QW8XYxxL3lP6UPBjFxldxHT88H9jP0prpPsOkKbzRGpLC1c81h0jp1NFHAgEcXlzfX+9
 qCGJHQvYNsdaL1KqR56feg+9Mh9Rnk8ejvB15H509hCW1edqFCgWuwQi2yteSU3K+x69
 VZKA==
X-Gm-Message-State: AOJu0YzaR+5GRIkTgAdVEujBhzYPtPRdRQ+uJhORvlwVZruAOWk0KVYP
 0gKouvyJ7XmJ926cZ4nT+CCK11+UeK/hpML7/Nlx9WfuBrzFlpe/xt7Cu7zZ/Q4=
X-Google-Smtp-Source: AGHT+IHnm16pSLgRTkPcbyY0DBnVClZsuAglhzcugUvyKkX/kcqmSYWTftlVTxny7ctYEbkzEBE4zA==
X-Received: by 2002:adf:cc88:0:b0:339:35a4:7ca9 with SMTP id
 p8-20020adfcc88000000b0033935a47ca9mr1942130wrj.31.1706286401032; 
 Fri, 26 Jan 2024 08:26:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k11-20020adfe3cb000000b0033838c2c169sm1565022wrm.108.2024.01.26.08.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 08:26:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57E7E5F78A;
 Fri, 26 Jan 2024 16:26:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 11/14] plugins: remove non per_vcpu inline operation
 from API
In-Reply-To: <20240118032400.3762658-12-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 18 Jan 2024 07:23:56 +0400")
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-12-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 26 Jan 2024 16:26:40 +0000
Message-ID: <87y1ccqcvz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

> Now we have a thread-safe equivalent of inline operation, and that all
> plugins were changed to use it, there is no point to keep the old API.
>
> In more, it will help when we implement more functionality (conditional
> callbacks), as we can assume that we operate on a scoreboard.
>
> Bump API version as it's a breaking change for existing plugins.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  include/qemu/qemu-plugin.h | 59 ++++----------------------------------
>  plugins/api.c              | 29 -------------------
>  2 files changed, 6 insertions(+), 82 deletions(-)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 55f918db1b0..3ee514f79cf 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -51,11 +51,16 @@ typedef uint64_t qemu_plugin_id_t;
>   *
>   * The plugins export the API they were built against by exposing the
>   * symbol qemu_plugin_version which can be checked.
> + *
> + * Version 2:
> + * Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
> + * Those functions are replaced by *_per_vcpu variants, which guarantees
> + * thread-safety for operations.
>   */
>=20=20
>  extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>=20=20
> -#define QEMU_PLUGIN_VERSION 1
> +#define QEMU_PLUGIN_VERSION 2

I think technically the adding new API bumps this, the deprecating the
old version bumps:

  QEMU_PLUGIN_MIN_VERSION

to the same.

>=20=20
>  /**
>   * struct qemu_info_t - system information for plugins
> @@ -311,25 +316,6 @@ enum qemu_plugin_op {
>      QEMU_PLUGIN_INLINE_ADD_U64,
>  };
>=20=20
> -/**
> - * qemu_plugin_register_vcpu_tb_exec_inline() - execution inline op
> - * @tb: the opaque qemu_plugin_tb handle for the translation
> - * @op: the type of qemu_plugin_op (e.g. ADD_U64)
> - * @ptr: the target memory location for the op
> - * @imm: the op data (e.g. 1)
> - *
> - * Insert an inline op to every time a translated unit executes.
> - * Useful if you just want to increment a single counter somewhere in
> - * memory.
> - *
> - * Note: ops are not atomic so in multi-threaded/multi-smp situations
> - * you will get inexact results.
> - */
> -QEMU_PLUGIN_API
> -void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
> -                                              enum qemu_plugin_op op,
> -                                              void *ptr, uint64_t imm);
> -
>  /**
>   * qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu() - execution inlin=
e op
>   * @tb: the opaque qemu_plugin_tb handle for the translation
> @@ -361,21 +347,6 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct q=
emu_plugin_insn *insn,
>                                              enum qemu_plugin_cb_flags fl=
ags,
>                                              void *userdata);
>=20=20
> -/**
> - * qemu_plugin_register_vcpu_insn_exec_inline() - insn execution inline =
op
> - * @insn: the opaque qemu_plugin_insn handle for an instruction
> - * @op: the type of qemu_plugin_op (e.g. ADD_U64)
> - * @ptr: the target memory location for the op
> - * @imm: the op data (e.g. 1)
> - *
> - * Insert an inline op to every time an instruction executes. Useful
> - * if you just want to increment a single counter somewhere in memory.
> - */
> -QEMU_PLUGIN_API
> -void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn =
*insn,
> -                                                enum qemu_plugin_op op,
> -                                                void *ptr, uint64_t imm);
> -
>  /**
>   * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inl=
ine op
>   * @insn: the opaque qemu_plugin_insn handle for an instruction
> @@ -599,24 +570,6 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_pl=
ugin_insn *insn,
>                                        enum qemu_plugin_mem_rw rw,
>                                        void *userdata);
>=20=20
> -/**
> - * qemu_plugin_register_vcpu_mem_inline() - register an inline op to any=
 memory access
> - * @insn: handle for instruction to instrument
> - * @rw: apply to reads, writes or both
> - * @op: the op, of type qemu_plugin_op
> - * @ptr: pointer memory for the op
> - * @imm: immediate data for @op
> - *
> - * This registers a inline op every memory access generated by the
> - * instruction. This provides for a lightweight but not thread-safe
> - * way of counting the number of operations done.
> - */
> -QEMU_PLUGIN_API
> -void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
> -                                          enum qemu_plugin_mem_rw rw,
> -                                          enum qemu_plugin_op op, void *=
ptr,
> -                                          uint64_t imm);
> -
>  /**
>   * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem a=
ccess
>   * @insn: handle for instruction to instrument
> diff --git a/plugins/api.c b/plugins/api.c
> index 132d5e0bec1..29915d3c142 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -101,16 +101,6 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qem=
u_plugin_tb *tb,
>      }
>  }
>=20=20
> -void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
> -                                              enum qemu_plugin_op op,
> -                                              void *ptr, uint64_t imm)
> -{
> -    if (!tb->mem_only) {
> -        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
> -                                  0, op, ptr, 0, sizeof(uint64_t), true,=
 imm);
> -    }
> -}
> -
>  void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>      struct qemu_plugin_tb *tb,
>      enum qemu_plugin_op op,
> @@ -140,16 +130,6 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct q=
emu_plugin_insn *insn,
>      }
>  }
>=20=20
> -void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn =
*insn,
> -                                                enum qemu_plugin_op op,
> -                                                void *ptr, uint64_t imm)
> -{
> -    if (!insn->mem_only) {
> -        plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_I=
NLINE],
> -                                  0, op, ptr, 0, sizeof(uint64_t), true,=
 imm);
> -    }
> -}
> -
>  void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>      struct qemu_plugin_insn *insn,
>      enum qemu_plugin_op op,
> @@ -179,15 +159,6 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_pl=
ugin_insn *insn,
>                                  cb, flags, rw, udata);
>  }
>=20=20
> -void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
> -                                          enum qemu_plugin_mem_rw rw,
> -                                          enum qemu_plugin_op op, void *=
ptr,
> -                                          uint64_t imm)
> -{
> -    plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE=
],
> -                              rw, op, ptr, 0, sizeof(uint64_t), true, im=
m);
> -}
> -
>  void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
>      struct qemu_plugin_insn *insn,
>      enum qemu_plugin_mem_rw rw,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


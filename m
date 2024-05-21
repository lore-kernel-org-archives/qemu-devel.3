Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8BCC25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OrY-0001Ti-LZ; Tue, 21 May 2024 08:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9OrT-0001Mi-6f
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:44:59 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9OrR-0004Es-4S
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:44:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e37503115so6125676a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716295495; x=1716900295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ydUjq1x2tHe91ZfF3XRmtjobpywxygD653gDPcLnBqc=;
 b=erVPjj9KGPtxXJTwO0MVGb9n1fjMGwBq0cR7dTVw8PrH8pNxc5NnVpHOdvoRxdrTSU
 lOoCQkSAOWV3mBBfJ7V+dt8pE4+vWRj2TghDW+8RjYSwccxAJ9WHiwkmGMWtli4bXsnD
 pu3IX39glXekvmjNB42xrGB42LQZ6ME+ab+VZEy+yoXc5N3asK0ja29izDL+u7DYOdhe
 2JQmh0/aBhMzqXtzloz3zjBBw4cmUEnDfBCeIsFX0CP3mdbQtPoeDsYzLMFjMYvJDM7E
 2H8hWkjBTX8H+U0CMmzDAuIQyWoE2V0Rh2/F25idxf44G+Knz8U9gqKh9zYNJgvkgFDg
 lXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295495; x=1716900295;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydUjq1x2tHe91ZfF3XRmtjobpywxygD653gDPcLnBqc=;
 b=F783sVRv4TPDXmCPqRhsUx6rEmi1PbO0D23N3GRYsk8H2n/JghWA3OB6LSp65+nAbH
 pGDOddzv+OG00ElUU6L0/uxY2khR1HMpYG+KKkI6AP5UP93FWh4J4d2knneXckfq5Sig
 gU9RnOyY+45/XTX9FfyCADQ1Tv6Z/oeZAToanNInYEOi8ZMZQG7w8ti3sMFGwHX83xoA
 aNiclm+WTiLtYb2FmyiDbKR0yUomhXZFvf09vHST4DOJjeUtIpgT/Ts7+EI51TMdrOVd
 j4e4JJooLVeYTPDblXLZ034ipMWq5sm2Ffe70EIxsl3OjhE+B16VRWp4s8qfTLD44MLC
 mhLQ==
X-Gm-Message-State: AOJu0YxPhfApb3dGJIwq3EbOPq+od+gPRcWNr8hPb8d4dFJUEdIv++Tw
 OLs/cUa/kCykfJxtT2Ktu7mmx3Vw44oyvouRfl9gcYIy5w3RP6uE4owFG7P3x5k=
X-Google-Smtp-Source: AGHT+IF1Wzf0FP7a5yB88Y0TriuHu8WP/TqVTkLjBRmHAf6gn6wtPe1IUa+HaLOHkRWmutx7VExwyA==
X-Received: by 2002:a50:c055:0:b0:56b:8153:54f7 with SMTP id
 4fb4d7f45d1cf-5734d67b708mr20812151a12.30.1716295495177; 
 Tue, 21 May 2024 05:44:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574ea09b972sm9599851a12.47.2024.05.21.05.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 05:44:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2D0005F8B0;
 Tue, 21 May 2024 13:44:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <qemu-arm@nongnu.org>,  <maz@kernel.org>,
 <jean-philippe@linaro.org>,  <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>,  <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>,  <imammedo@redhat.com>,
 <andrew.jones@linux.dev>,  <david@redhat.com>,  <philmd@linaro.org>,
 <eric.auger@redhat.com>,  <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>,  <mst@redhat.com>,  <will@kernel.org>,
 <gshan@redhat.com>,  <rafael@kernel.org>,  <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>,  <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>,  <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>,  <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>,  <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>,  <jiakernel2@gmail.com>,
 <maobibo@loongson.cn>,  <lixianglai@loongson.cn>,  <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>,  <linuxarm@huawei.com>,  Shaoqin Huang
 <shahuang@redhat.com>
Subject: Re: [PATCH V10 7/8] gdbstub: Add helper function to unregister GDB
 register space
In-Reply-To: <20240520233241.229675-8-salil.mehta@huawei.com> (Salil Mehta's
 message of "Tue, 21 May 2024 00:32:40 +0100")
References: <20240520233241.229675-1-salil.mehta@huawei.com>
 <20240520233241.229675-8-salil.mehta@huawei.com>
Date: Tue, 21 May 2024 13:44:54 +0100
Message-ID: <87seybibax.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Salil Mehta <salil.mehta@huawei.com> writes:

> Add common function to help unregister the GDB register space. This shall=
 be
> done in context to the CPU unrealization.
>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> ---
>  gdbstub/gdbstub.c      | 13 +++++++++++++
>  hw/core/cpu-common.c   |  1 -
>  include/exec/gdbstub.h |  6 ++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index b3574997ea..1949b09240 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -617,6 +617,19 @@ void gdb_register_coprocessor(CPUState *cpu,
>      }
>  }
>=20=20
> +void gdb_unregister_coprocessor_all(CPUState *cpu)
> +{
> +    /*
> +     * Safe to nuke everything. GDBRegisterState::xml is static const ch=
ar so
> +     * it won't be freed
> +     */
> +    g_array_free(cpu->gdb_regs, true);
> +
> +    cpu->gdb_regs =3D NULL;
> +    cpu->gdb_num_regs =3D 0;
> +    cpu->gdb_num_g_regs =3D 0;
> +}
> +
>  static void gdb_process_breakpoint_remove_all(GDBProcess *p)
>  {
>      CPUState *cpu =3D gdb_get_first_cpu_in_process(p);
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 0f0a247f56..e5140b4bc1 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -274,7 +274,6 @@ static void cpu_common_finalize(Object *obj)
>  {
>      CPUState *cpu =3D CPU(obj);
>=20=20
> -    g_array_free(cpu->gdb_regs, TRUE);

Is this patch missing something? As far as I can tell the new function
never gets called.

>      qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
>      qemu_mutex_destroy(&cpu->work_mutex);
>  }
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index eb14b91139..249d4d4bc8 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -49,6 +49,12 @@ void gdb_register_coprocessor(CPUState *cpu,
>                                gdb_get_reg_cb get_reg, gdb_set_reg_cb set=
_reg,
>                                const GDBFeature *feature, int g_pos);
>=20=20
> +/**
> + * gdb_unregister_coprocessor_all() - unregisters supplemental set of re=
gisters
> + * @cpu - the CPU associated with registers
> + */
> +void gdb_unregister_coprocessor_all(CPUState *cpu);
> +
>  /**
>   * gdbserver_start: start the gdb server
>   * @port_or_device: connection spec for gdb

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


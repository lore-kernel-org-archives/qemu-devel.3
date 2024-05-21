Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5BFC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 15:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9RK8-0006JS-Ra; Tue, 21 May 2024 11:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9RK6-0006Ii-NS
 for qemu-devel@nongnu.org; Tue, 21 May 2024 11:22:42 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9RK4-00028y-Lr
 for qemu-devel@nongnu.org; Tue, 21 May 2024 11:22:42 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-574b3d6c0f3so9765423a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716304958; x=1716909758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fkV/uxRIlVl+pCSAeNBHiiaGEz3fSr7ZOuqes28Jmjo=;
 b=BEsoAYfKoVcuVlaaGXT+pvYGjSbUdADPHAMP74kvxwZ6S+2JvRYRa+sGmloNOurF1y
 1lQuuiRo878UUY6dbAeeUSqG/KreOvgXYfBmh5nk9F3kMHK/pcnQNH7Pw6ABUBlpnHmt
 FzJZ8QRPQgRu42xHb6uTDx0PYqz7UzxoFqa3dCdm7dUCzczO6DHI4NMLFqt+sIisbYtu
 kMsyUlveTkQsLmxQsyvNx4y9wu85Q+lmD0oCnTXGk7qqNpTb0NqTkE7RBspZ7j+Da+Oy
 pj+2X4IEoqbv/Nd7g6ltYDDOfkhZDMHMvl6KrrvSAYbX4AEYo+dRjfI6Y+JwU50uCIdx
 r5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716304958; x=1716909758;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkV/uxRIlVl+pCSAeNBHiiaGEz3fSr7ZOuqes28Jmjo=;
 b=Sz9Rhd3Gi7FyOH28k01wEhZTE1pFMfTfaH6r52S4+kkM7UuqNHZynewDKVdfwMmo0h
 6sBLTBz1g2OvpyHfnMenwnwNAEPGlbdeJKMMWPi5teGzcXLr6q0IzwlZod3n5rVOnm00
 rr76f8IT0v0X4JeDk1lUrZM7EsJGm1vhUqaq0uJ9NlDiVMQl5crL9jZFv97igEpx2UPL
 kmcUolg55+ztx1xB8LCOyMUbd9cJC/PBAtMuQOOMEhKRM2wEwutSKObTNGIJ7R/9XvkY
 sgVQzM+N6lS7DgxL9PhqpYCD1rCARHR9PcN7v3N2HNuIlhSrpkviibh0XvzwpmbxEF80
 b4aw==
X-Gm-Message-State: AOJu0YyEB8QC4sihm3epHItADdOsv3EM8hd8vXFPxkySulXp1hl3Todp
 /F1oQXZ7X2Tq4931FPQXND4Lt1OqCsfTQAAdcVE+q7nk3Xbc6hxqUMj/tiIQc5s=
X-Google-Smtp-Source: AGHT+IF/GPUFtiLDwsNf+YItYAiAUsdpSAUqO8ZqeQ5MX7KZitIBQw0Rzh/NpLwQ6MzrflcA1xEbJA==
X-Received: by 2002:a17:907:7619:b0:a5c:dc7e:bc3f with SMTP id
 a640c23a62f3a-a5cdc7ebd44mr1057736766b.43.1716304958240; 
 Tue, 21 May 2024 08:22:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1787c6ffsm1622523466b.49.2024.05.21.08.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 08:22:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 583B95F8B0;
 Tue, 21 May 2024 16:22:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>,  "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>,  "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>,  "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,  "imammedo@redhat.com"
 <imammedo@redhat.com>,  "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,  "philmd@linaro.org"
 <philmd@linaro.org>,  "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,  "pbonzini@redhat.com"
 <pbonzini@redhat.com>,  "mst@redhat.com" <mst@redhat.com>,
 "will@kernel.org" <will@kernel.org>,  "gshan@redhat.com"
 <gshan@redhat.com>,  "rafael@kernel.org" <rafael@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,  zhukeqian
 <zhukeqian1@huawei.com>,  "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,  "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>,  "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,  "npiggin@gmail.com"
 <npiggin@gmail.com>,  "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 Linuxarm <linuxarm@huawei.com>,  Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PATCH V10 7/8] gdbstub: Add helper function to unregister GDB
 register space
In-Reply-To: <00d3d97d51df449a88b771174b37f979@huawei.com> (Salil Mehta's
 message of "Tue, 21 May 2024 14:55:13 +0000")
References: <20240520233241.229675-1-salil.mehta@huawei.com>
 <20240520233241.229675-8-salil.mehta@huawei.com>
 <87seybibax.fsf@draig.linaro.org>
 <00d3d97d51df449a88b771174b37f979@huawei.com>
Date: Tue, 21 May 2024 16:22:37 +0100
Message-ID: <87frubi402.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Salil Mehta <salil.mehta@huawei.com> writes:

> Hi Alex,
>
>>  From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>  Sent: Tuesday, May 21, 2024 1:45 PM
>>  To: Salil Mehta <salil.mehta@huawei.com>
>>=20=20
>>  Salil Mehta <salil.mehta@huawei.com> writes:
>>=20=20
>>  > Add common function to help unregister the GDB register space. This
>>  > shall be done in context to the CPU unrealization.
>>  >
>>  > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>  > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>  > Reviewed-by: Gavin Shan <gshan@redhat.com>
>>  > Tested-by: Xianglai Li <lixianglai@loongson.cn>
>>  > Tested-by: Miguel Luis <miguel.luis@oracle.com>
>>  > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>>  > Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>>  > ---
>>  >  gdbstub/gdbstub.c      | 13 +++++++++++++
>>  >  hw/core/cpu-common.c   |  1 -
>>  >  include/exec/gdbstub.h |  6 ++++++
>>  >  3 files changed, 19 insertions(+), 1 deletion(-)
>>  >
>>  > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c index
>>  > b3574997ea..1949b09240 100644
>>  > --- a/gdbstub/gdbstub.c
>>  > +++ b/gdbstub/gdbstub.c
>>  > @@ -617,6 +617,19 @@ void gdb_register_coprocessor(CPUState *cpu,
>>  >      }
>>  >  }
>>  >
>>  > +void gdb_unregister_coprocessor_all(CPUState *cpu) {
>>  > +    /*
>>  > +     * Safe to nuke everything. GDBRegisterState::xml is static cons=
t char
>>  so
>>  > +     * it won't be freed
>>  > +     */
>>  > +    g_array_free(cpu->gdb_regs, true);
>>  > +
>>  > +    cpu->gdb_regs =3D NULL;
>>  > +    cpu->gdb_num_regs =3D 0;
>>  > +    cpu->gdb_num_g_regs =3D 0;
>>  > +}
>>  > +
>>  >  static void gdb_process_breakpoint_remove_all(GDBProcess *p)  {
>>  >      CPUState *cpu =3D gdb_get_first_cpu_in_process(p); diff --git
>>  > a/hw/core/cpu-common.c b/hw/core/cpu-common.c index
>>  > 0f0a247f56..e5140b4bc1 100644
>>  > --- a/hw/core/cpu-common.c
>>  > +++ b/hw/core/cpu-common.c
>>  > @@ -274,7 +274,6 @@ static void cpu_common_finalize(Object *obj)  {
>>  >      CPUState *cpu =3D CPU(obj);
>>  >
>>  > -    g_array_free(cpu->gdb_regs, TRUE);
>>=20=20
>>  Is this patch missing something? As far as I can tell the new function =
never
>>  gets called.
>
>
> Above was causing double free because eventually this free'ng of 'gdb_reg=
s' is being
> done in context to un-realization of ARM CPU. Function ' gdb_unregister_c=
oprocessor_all'
> will be used by loongson arch as well. Hence, I placed this newly added f=
unction
> in the arch agnostic patch-set=20
>
> https://lore.kernel.org/qemu-devel/20230926103654.34424-1-salil.mehta@hua=
wei.com/
>
> Another approach could be to keep it but make above free'ing as condition=
al?
>
> /* in case architecture specific code did not do its job */
> if (cpu->gdb_regs)
>     g_array_free(cpu->gdb_regs, TRUE);

No I don't object to moving it to a function. But I would expect the
patch that adds the function and plumbs it in to also be the patch that
removes the inline call. Otherwise the tree will be broken in behaviour
between patches.

Just make it clear in the header that the series needs the pre-requisite
patches.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


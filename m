Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE61C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 08:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u24du-00013H-U1; Tue, 08 Apr 2025 04:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u24ds-00012l-BB
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:49:12 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u24dp-00032D-Uo
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 04:49:12 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so1032792566b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744102147; x=1744706947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8fKpS/BZxvDUaXcTBnvNRo2eg6SXvO0HykJSyaUB+o=;
 b=Stjjp9vdrbbrujoU/1B5e9V3IqVBY/2CssPo5wTtvDDG6gfORpEK7NVLQ91GO+1MwV
 Z+m5V4IQWutPeytP+FSUu88v6j1PwNIZg0312YtIZqicpoVA0Z6a/Qs3HhXOXGSE1fC8
 9G7Lt4uclLygWiFemGePyXs0kcTy0A+rIjuGkQpz+6T4XCOjMcosRKwsDHNG1seftQKP
 Cv7SKT7lmpj5FKQZ0T1fbwtBy4Gg1gfL7Wj/vHRUsgEPBjIIljFV8cypMEfA0mlTT5ox
 /rXvso6Y7/w+9JyGEPpzCtYVoYFSxV6/+MEjmHiazs4exY/edHXpc5AIMdvJWRyBF6FV
 6lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744102147; x=1744706947;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W8fKpS/BZxvDUaXcTBnvNRo2eg6SXvO0HykJSyaUB+o=;
 b=Y/OcmgiK1otj94Fam/vY9rYXmsr+y/Bzx/KEDkOxNDAnN5LLpNegoEu01fb7XEKsBJ
 lrL5h9sbNVhsg6YaHrHKPlKAArQPQsZvUbkNHh2vaH2oowzvvnJ1BYMUigIKXsog3HrL
 nwZOJAqFIgPMnpu+a/s7T1w9NDgqxOUj0d1VTw1Vf7HNp4SXe2+SkU+W0cXpJv1fzREF
 MvwJTl6s/P322w/tnJWfdJPcOPvbvg6CmrEMyHNYx1UHVnI14Vmfr4j5eOMpQLPZO2l3
 9GTlmKFwicEJU2q2JHxBGGQPtUEjwfGyTNqqe1P/u2DUFvoS36SW/+fPjju+r7oKMJLS
 Fb0w==
X-Gm-Message-State: AOJu0YwcegJxaC3LdHbc73TZKLIVh0P/RB0yiEKnLTBtFbHfc+vIVuIX
 fXK27nygVvoomY7ksNMIiJWeA5xUAZiOBVa6uH5pOW0O+xd7agu+x1Q+8SoYvKU=
X-Gm-Gg: ASbGncuui4YBA0GuriTRAp1IQGI5ScEJ6V/kC+Hcagx0jM1q2wuWDbjmtLLPHOQGvLr
 8ellgoDUCBDmG1c11SeuySFHMjKqKDo0KKLf6zNShk2EEEoegrHJKp9CdbFnojp1+hvw5C5eIR2
 JXk33LkhQV0BNCfBvtUF86PfOQQ8aB2T7MERM2AsRET0dZcbpnMJzHoFGHTUxPgiI3EwuDnz0O8
 km9Ru9OMyxNdXd70tH4S+hgcKfB6QjicT59YZkS5At734ej8VyLwJSfDqOzhET/gEpRUZEHILBM
 jziHZhBfoPzlc18IzdK8iR2/6XcbWaMbWpXkhhmWMTB2WJ8=
X-Google-Smtp-Source: AGHT+IEc1AU71cOim5pSccTLhRC8LGzlsRQ6bzE8a/Fv1svUX3KTxCvHkzNrJ59HnARkF89VAh7LWQ==
X-Received: by 2002:a17:907:7f90:b0:abf:19ac:771 with SMTP id
 a640c23a62f3a-ac7d185479bmr1664409866b.2.1744102146832; 
 Tue, 08 Apr 2025 01:49:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe996f5sm892842966b.64.2025.04.08.01.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 01:49:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6006B5F8FD;
 Tue,  8 Apr 2025 09:49:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mark Burton <mburton@qti.qualcomm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Alwalid Salama
 <asalama@qti.qualcomm.com>,  Laurent Vivier <laurent@vivier.eu>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 1/2] accel/tcg: add get_virtual_clock for TCG
In-Reply-To: <84ECF705-6BC3-42C7-9F37-D0C81DFCAF7D@qti.qualcomm.com> (Mark
 Burton's message of "Tue, 8 Apr 2025 08:20:40 +0000")
References: <20250403113851.4182190-1-alex.bennee@linaro.org>
 <20250403113851.4182190-2-alex.bennee@linaro.org>
 <84ECF705-6BC3-42C7-9F37-D0C81DFCAF7D@qti.qualcomm.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Apr 2025 09:49:05 +0100
Message-ID: <87frijhwce.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mark Burton <mburton@qti.qualcomm.com> writes:

> In principle I like this, but=20
> 1/ throughout the API can we please make everything consistent sure that =
all registrations take a handle (void *) and all callbacks functions pass t=
hat handle (and the ID)
>  - right now, some things do, some things dont, and this specific case
> seems to take a handle on registration, but does not provide it on
> callback (!)

The handle is something the plugin should have already. The plugin id is
needed so the framework knows who to deliver the callback back to.

>
> (This is the current implementation :
> typedef int64_t (*qemu_plugin_time_cb_t) (void);
> ...
> QEMU_PLUGIN_API void qemu_plugin_register_time_cb(qemu_plugin_id_t id, co=
nst void *handle, qemu_plugin_time_cb_t cb);
> )
>
> 2/ The current implementation makes use of the callback _ONLY_ in the
> case of single TCG =E2=80=94 it=E2=80=99s most interesting when we have M=
TTCG enabled

Ahh - as I said compile tested only ;-)

I can fix that for v2.


> (and I see no reason not to provide the same mechanism for any other
> accelerator if/when anything in QEMU requests =E2=80=99the time=E2=80=99.

That would mean making a clear separation in plugins for things that are
"events" which we do do from other hypervisors and "instrumentation"
which can only be done under TCG.


>=20
>
> Cheers
> Mark.
>
>
>> On 3 Apr 2025, at 13:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>=20
>> WARNING: This email originated from outside of Qualcomm. Please be wary =
of any links or attachments, and do not enable macros.
>>=20
>> Rather than allowing cpus_get_virtual_clock() to fall through to
>> cpu_get_clock() introduce a TCG handler so it can make a decision
>> about what time it is.
>>=20
>> Initially this just calls cpu_get_clock() as before but this will
>> change in later commits.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> accel/tcg/tcg-accel-ops.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>=20
>> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
>> index d9b662efe3..1432d1c5b1 100644
>> --- a/accel/tcg/tcg-accel-ops.c
>> +++ b/accel/tcg/tcg-accel-ops.c
>> @@ -197,6 +197,11 @@ static inline void tcg_remove_all_breakpoints(CPUSt=
ate *cpu)
>>     cpu_watchpoint_remove_all(cpu, BP_GDB);
>> }
>>=20
>> +static int64_t tcg_get_virtual_clock(void)
>> +{
>> +    return cpu_get_clock();
>> +}
>> +
>> static void tcg_accel_ops_init(AccelOpsClass *ops)
>> {
>>     if (qemu_tcg_mttcg_enabled()) {
>> @@ -212,6 +217,7 @@ static void tcg_accel_ops_init(AccelOpsClass *ops)
>>             ops->get_virtual_clock =3D icount_get;
>>             ops->get_elapsed_ticks =3D icount_get;
>>         } else {
>> +            ops->get_virtual_clock =3D tcg_get_virtual_clock;
>>             ops->handle_interrupt =3D tcg_handle_interrupt;
>>         }
>>     }
>> --
>> 2.39.5
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


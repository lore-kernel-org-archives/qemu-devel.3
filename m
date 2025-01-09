Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13578E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVsy7-0000Bt-OF; Thu, 09 Jan 2025 08:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVsxz-0000BM-AH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:52:57 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVsxw-00054C-UD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:52:54 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d932eac638so1638437a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 05:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736430771; x=1737035571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvy0VENa5Diwm1HhcIeb35ikQ6Fx8DFs181q2yHXLf0=;
 b=iDpYPrnd9zSZpBFwZ5Wx8oBChMcPPjs9pKTYWqKB3AR0IDH2FtJvOHYp7hLrELHWtC
 C3GAbnvs2Mvc1ku48ko+GQwIzybAFJQPl8VMT/nXXTA4f81BOUzd85JYHf+Xdl/9dJwd
 8E7nbSnyDCrylmCUZqMYIjX2ckcdzQw80zcXMvIUF6oMBUN9sx4eDfxz6oxeahzNwz0F
 qbQTfUxjW2gAnUaFA9XmBqeEuHDsqWAm1ts2qwbbx9cKl1mjGgWYbfuLuyf4Xwr2FfY5
 TnA8b/3M2pmhzdYrfStBJenK5EO3G4LgJZINtpvV3q+CpG5v12KpPjcNhXVAmQRwOPqg
 +psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736430771; x=1737035571;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cvy0VENa5Diwm1HhcIeb35ikQ6Fx8DFs181q2yHXLf0=;
 b=OLz+5hZa7eCdkj/+sGffM5jW3eSIkPExkWKmm5j1V0I5zeet9sulLTJmKtbJ1AG7T1
 x5egGlnAAH2uv+80WGOOtls3ATde/MXV8dxUpVd3GzFqLAyby6KkY7Zeyb4I9H2zzp0a
 coW6PzNMoqjLzerd74Te2PUstH2FehnnkjvqnowP7sAe4Ya/Mg9KDJcpxzQG4SWGPcWn
 4roZL5lxlU+xM8LBnIZ7mcUS4vU/L77OoP0LwSuJXVkIhYo8ibqgmPFu1eOq94UybQV2
 P/CsSQ0QzIBXyFk3tUv9X04KHH7uijFn8DCMDfs3YbDn6svNG7PUwe9m1VhNXFX3QWYQ
 cIgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx44PaVhChBwnbT0Pk1KZujESZtCRsc2p2o6mzdEPixU0LwWcJcHFQQjMkehBtQPmfDirpJdzh0syL@nongnu.org
X-Gm-Message-State: AOJu0YyAJf15aZzVD4QedVVvG7CH2GjGSYzXE8lahSeperx48HjzmeNx
 LjvSU8K2Kq5XHK9e8GXtNDwzkVEVzU300motvArMP3R5gAIE7nyIR2YGSBEAszs=
X-Gm-Gg: ASbGnctwLdR62Ko7tQVaRM6E+dOmMw5e3Bai7WO84UTYR0JjmSSZL9QDbrVw7oaiZMu
 1XYAKpfJbEvjHqcsS8rk4TWVabGWW579YWm9aIzKQzxM0qLsOF0xPRPo8K3ieeXQFwMvqYpt0lu
 r6vbzPGyYKHD2A4hCAfXz5EbB4VWOJFEG5IO9qWplmamfnAp6LlepQoA+CfiJmKHPXBViqmb8rF
 e4O+CafAkejcIkIS9Qb2fqkaA3qYetXdMfYlkB+i6vHjYdX+Ko5MPo=
X-Google-Smtp-Source: AGHT+IERLZwVIuxaathVyWD6Tj/9OZd8ryKZwKJvF0NxEnbmpPgFusmdv3haCYlcZ3RedDS+EyFo9w==
X-Received: by 2002:a17:907:7e9b:b0:aae:bd4c:2683 with SMTP id
 a640c23a62f3a-ab2abdbe9famr606556566b.49.1736430770683; 
 Thu, 09 Jan 2025 05:52:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90da11esm75433866b.69.2025.01.09.05.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 05:52:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 300275F75D;
 Thu,  9 Jan 2025 13:52:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Julian Ganz <neither@nut.email>,  qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 01/11] plugins: add types for callbacks related
 to certain discontinuities
In-Reply-To: <6f182c71-2600-4bbf-ab4c-985ed7e99f71@linaro.org> (Pierrick
 Bouvier's message of "Wed, 4 Dec 2024 14:45:24 -0800")
References: <cover.1733063076.git.neither@nut.email>
 <5e624b7244f1b0b294b28cd513aab04b6b294b1d.1733063076.git.neither@nut.email>
 <6f182c71-2600-4bbf-ab4c-985ed7e99f71@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 13:52:49 +0000
Message-ID: <87wmf46qmm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Hi Julian,
>
> thanks for the update!
> Comments below.
>
> On 12/2/24 11:26, Julian Ganz wrote:
>> The plugin API allows registration of callbacks for a variety of VCPU
>> related events, such as VCPU reset, idle and resume. However, traps of
>> any kind, i.e. interrupts or exceptions, were previously not covered.
>> These kinds of events are arguably quite significant and usually go hand
>> in hand with a PC discontinuity. On most platforms, the discontinuity
>> also includes a transition from some "mode" to another. Thus, plugins
>> for the analysis of (virtualized) embedded systems may benefit from or
>> even require the possiblity to perform work on the occurance of an
>> interrupt or exception.
>> This change introduces the concept of such a discontinuity event in
>> the
>> form of an enumeration. Currently only traps are covered. Specifically
>> we (loosely) define interrupts, exceptions and host calls across all
>> platforms. In addition, this change introduces a type to use for
>> callback functions related to such events. Since possible modes and the
>> enumeration of interupts and exceptions vary greatly between different
>> architectures, the callback type only receives the VCPU id, the type of
>> event as well as the old and new PC.
>> ---
>>   include/qemu/plugin.h      |  1 +
>>   include/qemu/qemu-plugin.h | 43 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 44 insertions(+)
>> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>> index 9726a9ebf3..27a176b631 100644
>> --- a/include/qemu/plugin.h
>> +++ b/include/qemu/plugin.h
>> @@ -59,6 +59,7 @@ union qemu_plugin_cb_sig {
>>       qemu_plugin_udata_cb_t           udata;
>>       qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
>>       qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
>> +    qemu_plugin_vcpu_discon_cb_t     vcpu_discon;
>>       qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
>>       qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
>>       qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index 0fba36ae02..9c67374b7e 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -154,6 +154,49 @@ typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_p=
lugin_id_t id,
>>   typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
>>                                               void *userdata);
>>   +
>> +/**
>> + * enum qemu_plugin_discon_type - type of a (potential) PC discontinuity
>> + *
>> + * @QEMU_PLUGIN_DISCON_INTERRUPT: an interrupt, defined across all arch=
itectures
>> + *                                as an asynchronous event, usually ori=
ginating
>> + *                                from outside the CPU
>> + * @QEMU_PLUGIN_DISCON_EXCEPTION: an exception, defined across all arch=
itectures
>> + *                                as a synchronous event in response to=
 a
>> + *                                specific instruction being executed
>> + * @QEMU_PLUGIN_DISCON_HOSTCALL: a host call, functionally a special ki=
nd of
>> + *                               exception that is not handled by code =
run by
>> + *                               the vCPU but machinery outside the vCPU
>> + * @QEMU_PLUGIN_DISCON_ALL: all types of disconinuity events currently =
covered
>> + */
>> +enum qemu_plugin_discon_type {
>> +    QEMU_PLUGIN_DISCON_INTERRUPT =3D 1,
>> +    QEMU_PLUGIN_DISCON_EXCEPTION =3D 2,
>> +    QEMU_PLUGIN_DISCON_HOSTCALL =3D 4,
>> +    QEMU_PLUGIN_DISCON_ALL =3D 7
>> +};
>
> Matter of style, but would be better to use:
>
> enum qemu_plugin_discon_type {
>      QEMU_PLUGIN_DISCON_INTERRUPT =3D 1 << 0,
>      QEMU_PLUGIN_DISCON_EXCEPTION =3D 1 << 1,
>      QEMU_PLUGIN_DISCON_HOSTCALL =3D 1 << 2,
>      QEMU_PLUGIN_DISCON_ALL =3D -1
> };
>
<snip>

Is this really a bit field though? If you will only report type of
discontinuity at a time a simple 0 based enum with
QEMU_PLUGIN_DISCON_MAX would be simpler.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


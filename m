Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39837C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPwY-0001cz-4R; Wed, 12 Mar 2025 13:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPwT-0001cE-Th
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:32:31 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPwS-0004jk-At
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:32:29 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6e8fb83e137so1390896d6.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741800746; x=1742405546; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcEnJOtJMXJymFhT0PNheZz6JgQLgZuJDDzJ9zNbEN4=;
 b=SXuDHXuylvv2fW3I928C4N0dEjeiieGGLqMg1UqlZZ6Xrp1oDHka3mZfTlKwVYDlcP
 PLQhmyO7qoTjgR6b+qxcbTkRRF2L3mO4nyuCSpQGHqWo/brGAAx2zU8QM0OBQjRNemvC
 JrrERuFvLmjkunSqXPl33R67Elfk3JyTLlEhJ0OtaLXRKz+a3x77b+80REojQK2WSHqp
 yc0dFgbweQ3FXo5V6o/KbODeBF+nLyQJPrrQ8Ik5a6ZMuc1rXmzAOakNkmp9QboxCEBI
 Ge6XJXadA4AtvBerw1aEA78QwoJGoEqrERWMzi13jtGprWwzMb1BBzAIgUbePmVz2IP/
 Upmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741800746; x=1742405546;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcEnJOtJMXJymFhT0PNheZz6JgQLgZuJDDzJ9zNbEN4=;
 b=hMgG6n4YzaoE4uxTp1ceU3P1jV12Mt0kKLVTzdm49y+SCJFP2fFI+215GBEk1tMQ9M
 QxVSPBjcRfSBagJwayM7N0R0NdN/M2HUWUlmQRixIkidaThcIwrlN+vfoBeWJdvaFAj3
 Ym0yfjaMNe2Z3y1cLe2wzJtZv9JvlzsLh7hQ2ydxcQeN9/gyu7YJkSU76IahU3YQpsrS
 WMIchvoJIldlSyBEd21kVnypq7NQOLW2FxQwr5Bs8iFKZETwOW3I1/ZnyuhX3/pTFZYk
 HSh0Lozd2RI/9zww6E+aLJQXkPgPiuKJKghrO/l0jTOoGdzRNgGwGDgxZ+IUp0g4MYR8
 e+lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuBsGm2wa6zBBy+h+nCtCBVEFG+lswMidQYZopRVdJyS0LXi94BIoQiq4w8Qye/fy6ZCgfDWCnP/8w@nongnu.org
X-Gm-Message-State: AOJu0YztJYySBIzpTQRyOMDdzQaj8W2M+Fh2HwzaPjdrt3Ufb0VdFD+Y
 nPGUZ6u50wTV/BCeh8nRrtI003uDDD4zOZClbI0aIAYKl59r70Fk
X-Gm-Gg: ASbGnct7s33Cyh8j0I9SGW2lwOG04juPyEOWD8a5MBjILU8oV3T2HnYdc7bTIXkgq3f
 6AuXacekS+PIG2T7BbTtw5tjrKmSl9LzLmzWv0tpsuXeEi/v0gSe9H4/ZI1RSWIs+mU8v/eLFru
 540Mg8xVoKWOJpLJtxJMMTgu+uksBV9YcN2VQCfLhM6Qm7bymJSBkl4hRkLKP7NyhSvoUW+vNf9
 gDpR1defdJFiSZ9SSY5fgWr9WJqCQW8MHNYiJqDd1VT3rxaMktnPMpocPGqQJ5KR+n+PkEs8O/q
 GSkDBZR2wBA7AEb3NXNlZ7O1m4vy9ExjJJxnpciB5W5uXeSrMIqdBxeWcv2S6Q4r8O/ph8BmRw=
 =
X-Google-Smtp-Source: AGHT+IGCOmgdfM/94awCZ7P2V+NB8cVlsetk12Lyw1jd+r3fh/SpUiJXKwnfVcAXBxwc1kr1Ff7XUw==
X-Received: by 2002:a05:6214:c48:b0:6e8:ea17:8587 with SMTP id
 6a1803df08f44-6e900682e29mr321603766d6.42.1741800746555; 
 Wed, 12 Mar 2025 10:32:26 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:9cc3:cdb3:7013:e1db])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f70a446dsm86940276d6.56.2025.03.12.10.32.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Mar 2025 10:32:26 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>,
 "'Michael Lambert'" <mlambert@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-39-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-39-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 38/38] target/hexagon: Add hex_interrupts support
Date: Wed, 12 Mar 2025 12:32:24 -0500
Message-ID: <011b01db9374$b8982630$29c87290$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgIuSTFFtPKxSjA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250312-2, 3/12/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>; Michael Lambert
> <mlambert@quicinc.com>
> Subject: [PATCH 38/38] target/hexagon: Add hex_interrupts support
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/hex_interrupts.c
> b/target/hexagon/hex_interrupts.c new file mode 100644 index
> 0000000000..fd00bcfb9a


> +bool hex_check_interrupts(CPUHexagonState *env) {
> +    CPUState *cs =3D env_cpu(env);
> +    bool int_handled =3D false;
> +    bool ssr_ex =3D get_ssr_ex(env);
> +    int max_ints =3D 32;
> +    bool schedcfgen;
> +
> +    /* Early exit if nothing pending */
> +    if (get_ipend(env) =3D=3D 0) {
> +        restore_state(env, false);
> +        return false;
> +    }
> +
> +    BQL_LOCK_GUARD();
> +    /* Only check priorities when schedcfgen is set */
> +    schedcfgen =3D get_schedcfgen(env);
> +    for (int i =3D 0; i < max_ints; i++) {
> +        if (!get_iad_bit(env, i) && get_ipend_bit(env, i)) {
> +            qemu_log_mask(CPU_LOG_INT,
> +                          "%s: thread[%d] pc =3D 0x%x found int =
%d\n", __func__,
> +                          env->threadId, env->gpr[HEX_REG_PC], i);

Don't use %d - use PRI* instead.  Several instances ...





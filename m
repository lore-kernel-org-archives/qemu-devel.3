Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C376C021B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpcGq-0001zA-OH; Tue, 04 Mar 2025 19:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpcGj-0001wV-C3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:05:49 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpcGf-0001g8-QU
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:05:47 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-471f16f4b73so59376681cf.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741133144; x=1741737944; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Aa5g0+SuPacrX7XzRHcQ/gvwzlJQIemA+FvLCBVMXY=;
 b=Zk+AiD4vM7zSROqQNPKtBGiaRS0JMPAjjAIQtBRSYNre/BRYCF+3a23S3q6uLa+iwM
 +iFmMw5b4oEgbaiNGSulvoepDLffSyeVUA7B5JgO0FcwPA5hf63Kft2/qrbYsNq3lZpj
 qk/IEv0Hbh+qCHXx+afcTOl7kxJ4kT7r/uZjVVaPRTQjyQfFRY0hiXWrPt8/zFttKJR1
 HtZCzQ5tYEBkNDS34qLNOMTirPo0P5BYaTvHpGV/nSVt6n1cGOsn+eC31TVbRe2STHNT
 kETFckQou12dfvSOa1Fn8dMAO/0tt/P9QoImjyFc1zj00mFt+D3kKcdRJJ6OMTIAbk3u
 szrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741133144; x=1741737944;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Aa5g0+SuPacrX7XzRHcQ/gvwzlJQIemA+FvLCBVMXY=;
 b=PMDNUZZLb0u19QWww96gtYzCZOl9nwljU2vjb+k3UgYLWckef/qZOjvrcRm5O/ECCQ
 WO/Tpusg4uEFj7RcPEOQV2MYtBkudmkl23oUovkeP7mIpYjCNKVQZJhyyTr6EvE7OWPn
 BWAP7KQOJYoMrpVWYLCM7ZIMBjnezHpapurKWEOef9+yoDP5xmd2KFEGZ0o18oTs4qkF
 G+BjflgwyFB0XtftAkrL3lIaNXI5BpQGfJGx6HS8i8PKLnY8YudgiINFnDOD/OVTYH44
 X5s2aAGNzZ7EablEI/pLfnZCI9wGZsLcuSa5hS1ll+2BHuXK3loauTNpe156aBsCmXz7
 xdpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFrZEROvTMxwtgoY1omrwUN3QUn0yRYAwpuq/ZGxSoDej5Qi9ZT3jzqTjDz7CfMfq/dYzTFylbbIbh@nongnu.org
X-Gm-Message-State: AOJu0Yzg1gCFdJIN3iEsXh+I721R4M/MTdnYtnoB/w2KYnMJC57qa6CL
 1ojz71gR5hql+lJhnirCwPa0Z3xJXmgqGL7eVUcxy/YqIrdogxYe
X-Gm-Gg: ASbGncsJHZh3jbT0lLFmKtpd3uOWxketHrMRZsQnEDB1ar1Ya1aGSuaclWlmkbCmhse
 7L1fMEQgb8mi85Ai3qxH5hG9qwYjhOmQSIz0bx+bV1ybTH9y6/OGeFhA+IYDG3ot+Y/bPO4lgzx
 4biW6dt+Oce3VfrsO1NBLCs/EYNgI1k3TtVHgQommsig/4gqFHxjATOC++61beCQQBAI+wBjMCx
 JzyEMQCn7eqlzh00SiEQ6vvi9Z24SoNv8L9jLuVWArl2EQfTijdouh+i2IPwkhyiQ2aHs1spI6D
 izPi7XbGZ1YVcZRUXLOgxVhzFpFWSKdUCOx1UaHzR5/JmmGC5IEof9oCOOC1HOj+rn5wK2lqm+4
 tzpw1EOo=
X-Google-Smtp-Source: AGHT+IFGWP+KxhXRHgke3P3S+fiCmkdAZMQ0yax8Fhx96QLCfxJNhxfKT9FJYo4tiyF+y3mBRFusGg==
X-Received: by 2002:a05:620a:2790:b0:7c2:49d5:2b25 with SMTP id
 af79cd13be357-7c3d8e46654mr171584685a.10.1741133144367; 
 Tue, 04 Mar 2025 16:05:44 -0800 (PST)
Received: from DESKTOPUU50BPD (syn-174-097-131-055.res.spectrum.com.
 [174.97.131.55]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976da594sm72609656d6.107.2025.03.04.16.05.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Mar 2025 16:05:43 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@linaro.org>,
 <richard.henderson@linaro.org>,
 "'Brian Cain'" <brian.cain@oss.qualcomm.com>, <qemu-devel@nongnu.org>
Cc: <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-35-brian.cain@oss.qualcomm.com>
 <3329ec67-3bf3-425d-b15c-ba77cd8bcd30@oss.qualcomm.com>
 <014701db8d5a$8a1ad930$9e508b90$@gmail.com>
 <d18103eb-b07e-4017-8c27-6bc8f5585360@linaro.org>
In-Reply-To: <d18103eb-b07e-4017-8c27-6bc8f5585360@linaro.org>
Subject: RE: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
Date: Tue, 4 Mar 2025 18:05:41 -0600
Message-ID: <016101db8d62$5644ea30$02cebe90$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQLrtTt/AcPvtVgCvPo6dgIOVP6gsqJGyZA=
X-Antivirus: Norton (VPS 250304-10, 3/4/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x834.google.com
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
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Sent: Tuesday, March 4, 2025 5:58 PM
> To: richard.henderson@linaro.org; ltaylorsimpson@gmail.com; 'Brian =
Cain'
> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
> Cc: quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; alex.bennee@linaro.org;
> quic_mburton@quicinc.com; sidneym@quicinc.com; 'Brian Cain'
> <bcain@quicinc.com>
> Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
>=20
> Hi Taylor,
>=20
> On 5/3/25 00:09, ltaylorsimpson@gmail.com wrote:
> >
> >
> >> -----Original Message-----
> >> From: Brian Cain <brian.cain@oss.qualcomm.com>
> >> Sent: Monday, March 3, 2025 10:24 AM
> >> To: qemu-devel@nongnu.org
> >> Cc: richard.henderson@linaro.org; philmd@linaro.org;
> >> quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> >> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> >> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> >> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> >> Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
> >>
> >>
> >> On 2/28/2025 11:28 PM, Brian Cain wrote:
> >>> From: Brian Cain <bcain@quicinc.com>
> >>>
> >>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >>> ---
> >>>    target/hexagon/sys_macros.h |   8 +--
> >>>    target/hexagon/op_helper.c  | 104
> >> ++++++++++++++++++++++++++++++++++++
> >>>    2 files changed, 108 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/target/hexagon/sys_macros.h
> >>> b/target/hexagon/sys_macros.h index 3c4c3c7aa5..e5dc1ce0ab 100644
> >>> --- a/target/hexagon/sys_macros.h
> >>> +++ b/target/hexagon/sys_macros.h
> >>> @@ -143,11 +143,11 @@
> >>>    #define fDCINVIDX(REG)
> >>>    #define fDCINVA(REG) do { REG =3D REG; } while (0) /* Nothing =
to do
> >>> in qemu */
> >>>
> >>> -#define fSET_TLB_LOCK()       g_assert_not_reached()
> >>> -#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
> >>> +#define fSET_TLB_LOCK()       hex_tlb_lock(env);
> >>> +#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
> >>>
> >>> -#define fSET_K0_LOCK()        g_assert_not_reached()
> >>> -#define fCLEAR_K0_LOCK()      g_assert_not_reached()
> >>> +#define fSET_K0_LOCK()        hex_k0_lock(env);
> >>> +#define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
> >>>
> >>>    #define fTLB_IDXMASK(INDEX) \
> >>>        ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(env_archcpu(env)-
> >>> num_tlbs)) -
> >>> 1)) diff --git a/target/hexagon/op_helper.c
> >>> b/target/hexagon/op_helper.c index 702c3dd3c6..f3b14fbf58 100644
> >>> --- a/target/hexagon/op_helper.c
> >>> +++ b/target/hexagon/op_helper.c
> >>> @@ -1184,6 +1184,110 @@ void HELPER(modify_ssr)(CPUHexagonState
> >> *env, uint32_t new, uint32_t old)
> >>>        BQL_LOCK_GUARD();
> >>>        hexagon_modify_ssr(env, new, old);
> >>>    }
> >>> +
> >>> +static void hex_k0_lock(CPUHexagonState *env) {
> >>> +    BQL_LOCK_GUARD();
> >>> +    g_assert((env->k0_lock_count =3D=3D 0) || (env->k0_lock_count =
=3D=3D
> >>> +1));
> >>> +
> >>> +    uint32_t syscfg =3D arch_get_system_reg(env, =
HEX_SREG_SYSCFG);
> >
> > Minor nit - registers should be target_ulong type.
>=20
> Since Hexagon is only implemented using 32-bit registers, is it worth =
using
> target_ulong? (I'm trying to foresee heterogeneous emulation).
>=20
> Richard, any thought on this (whether a target implementing only 32
> *or* 64 bits should use target_[u]long).

It's just a hedge against the future in case Qualcomm ever builds a =
64-bit Hexagon.





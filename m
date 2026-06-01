Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FD0CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU8Ur-0006ap-P4; Mon, 01 Jun 2026 15:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wU8Uo-0006aR-RN
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:40:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wU8Uk-0004Au-Kp
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:40:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651HeHNL3128018
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 19:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JP3dFJ+dJQD+tGNvvDhnpq00hJ7CIFK46X8E5gZDcq4=; b=iDQ5YSYg3PqnURyG
 3eOdbtj2zebEUUFzdnEF+HxGfGu64w79DjjPt6s4PeS1+e/UEkgidUjyeKk2a6fU
 e+Zcshtio61AyTiiuDRfkFMrjrGKGWWuc8FeQD4fnl+kseYU8bY8+v5GSDp9TbKs
 4qyVeoWQzaJY2YFyanzpUfDlWk/tipH2XyQktEAwyqUCgRHZz/lTn52Ir3e9ARya
 6JLqgjZlpLu+2I1BDfafwXAAV24iNPzZznaEjTM44Lb3prYo93mDCHk5UJMBs01L
 NkuS7hOp7KTbdkWvZ3qBX8BDkPYRykwDhdb/nwwTwpsnqJA3KdCZRt68AM0dQ/rM
 Ldn6aw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh90126uw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:40:14 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-135de949041so18447629c88.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780342813; cv=none;
 d=google.com; s=arc-20240605;
 b=dHd+oWJ0fnjpn419RYoeI/R6tsffzqXyym+Pc6I6vskS++kSG8wT5fzjToIJg+RFWZ
 c/Fa1LXc1kRgKZ6onm3ubzBGsAKBC7co9mZUdtqSFoA7C80Pl2dONEarjpWbV3ekzZRV
 eMk5uvGsHmz5P4VQa+VdpWD52mxrwdp1D1NHRlNyd7GtS+1XVs4wSwcnRy/t2zX3qKBJ
 AWz1NRp/RvE8J0hIg+SZWPad/jWsvdVZoMjm2v3ie9WoANInxEozMXQb49Gc8/Ul3mVs
 HuL7tFJ5+spmW6X6VTfAm3rOQNmzAvMm9tpuu9K1jIBDz/tZXktZlA57AGIEBJMDPvJr
 W65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JP3dFJ+dJQD+tGNvvDhnpq00hJ7CIFK46X8E5gZDcq4=;
 fh=foLOILhaym1wQmqWOB6iskjY0Oe70TwWPY9QrSoNz+A=;
 b=GSlE+n1zapFQeYHzQrjKhHU5vlo1guY503W7UMv3fOBxgud4lfdc/+k1FFMs0UxMbR
 jcr5Fhjf8pBYhdos0n4xN/xYJ509fjH2Ij3tH2jiHDO72fKvZqyP4UfaNVy6e31aULnw
 tuYL01umikG7gMgIYFgfV32gJubgDIpJq8pykUWBV4Qhg2BoH15oRsbBIGecJcUAX0Gl
 go1rLKEnatMtM1ZAnJ/+/x4dPa/D9GuOcsvOULxzhRXRbblCnUvIJ1KAZ6KP9lZNQBzN
 3htE1np8qZZ3flikYGsiWH1ZqllHU855NPNkLcQAefQn674XWJMtQzdDp3MzlbApIKLA
 KvZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780342813; x=1780947613; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JP3dFJ+dJQD+tGNvvDhnpq00hJ7CIFK46X8E5gZDcq4=;
 b=Or+mxHywLey/pX6TfPrDYBUjZb077arckY7UZkGgpx07fJv61HZQlS7Nw6Az5N/hzc
 r01WW948ovxmlkXQHBsvC9l97B2gMLXx+0SEp2GGwGXewPWGmPHl40eleKbZLRGvcFm/
 hXxOJ15FZbf9GdCUGqmfDSYu+mK3dLKuO48m4Wdk59VnYWvtpaeBvxIEuQj3nB0qJ1uh
 RgzpI2nWEx7yUCyvabCv+LtwILDyj//ygnw8AuHMsmQnpFdkhBHfqK6xtgW6HFzJx73H
 +R70KNl3U7Qb4wNDq/T4TOWh7r8QdP/YGPX+7SGb6t5SBOkcjJZGQDgCnZmDeUSynAl5
 t/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780342813; x=1780947613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JP3dFJ+dJQD+tGNvvDhnpq00hJ7CIFK46X8E5gZDcq4=;
 b=s6VBNl298YV3C39VUZkZ16Pdxhz2+D2MoeJQbmp5lZfsWSah5zzkE2xxeMofhAFmH/
 FnBTtoU6+eV/U9e2GMfDiynJqGKBMIgToZJlrNk+4nIU8m6UUznrR4S7LDgaIlnAqC/l
 UrpuS9iScBgAcLuXQS979vzyQ/rRm72JMVdlCFS2kSaF9o5HMilTBUrXrJNMbrcql5qn
 r0MU+jbqTb6ldLmdtmew9Fy26rSbaiSRCjdn0ZsJcB//8GB3xpQXWuRRwcBnv53c7eGF
 f21lq6nworOE9uZXNK5SuTAbexHskR49RNsrd0ykG9gnoqvML38ScZyZtnkgRVYqmfck
 6RcQ==
X-Gm-Message-State: AOJu0YwBJe6UiCekBmSlo5M/t0v5KGXRlRM2mYX6IPpOGXdL5E27mhQc
 lwG82oPOoh92oUq55A6RUd0YTpMYpE0NfpWhA1YxtlMhmXUTS6z9whKgaqvfvjCIA5CDPNYcIhq
 7/4/sQXgHdrjNK/4bfrH1mzOLQNZ2LLNdLZ/CCoq2aJSfDIUHBiYBT9uQ2YcKGqbgIczUm4rPuz
 qZPx7bmQywWv6Tq3FSaLBzHOtXzRqRpVsi
X-Gm-Gg: Acq92OHtQAtHSbgkgZogiaG/+04QmQ960iCbvpUwe8rsnEAcFNvVqe3KIO2gvokuujH
 Xo/NWbxg3NPrRfXFjOP71D7hUuafW/scmVJ6/UT7B40lH6FK9OocPuaoxyenmq1o0N0izkNHBj4
 NUZix5qdw3TjrRY88boAVua4Xbn1Un1cFEw6T0vg5RbZRxK7qg4PgpXwbr92iS9azzTtCUdYqx8
 J8aK2mVPAucqhq+ig==
X-Received: by 2002:a05:7022:438d:b0:136:fac0:84dc with SMTP id
 a92af1059eb24-137d3bf3c50mr5527051c88.3.1780342813291; 
 Mon, 01 Jun 2026 12:40:13 -0700 (PDT)
X-Received: by 2002:a05:7022:438d:b0:136:fac0:84dc with SMTP id
 a92af1059eb24-137d3bf3c50mr5527026c88.3.1780342812757; Mon, 01 Jun 2026
 12:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
 <20260529215806.608770-16-brian.cain@oss.qualcomm.com>
 <1835eaa9-c9ca-45b7-a5de-3ac653aa535e@oss.qualcomm.com>
In-Reply-To: <1835eaa9-c9ca-45b7-a5de-3ac653aa535e@oss.qualcomm.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 14:39:53 -0500
X-Gm-Features: AVHnY4ITQmkm9GFBSA8WGMohdfzwWKcf3UiM3dmfT4yRqENRyOiBDHl069un_Ec
Message-ID: <CAEqNhNbqCk0VJ=_pj4F3BNTXimA6G=voMcD3CieASCmOFOSYNQ@mail.gmail.com>
Subject: Re: [PATCH v5 15/28] target/hexagon: Implement setprio, resched
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=H6nrBeYi c=1 sm=1 tr=0 ts=6a1de01e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=oHbzb-AD6tYY2X2EoCgA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: uK7IYKd7fy_Vs2I714ULUAC3wxCMHN7N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE5MiBTYWx0ZWRfX6npMK/OKg7DS
 xNmHYZnoDZha/ZtcE+6WkFamW+Ia0sbxP9a2eZqhNUYorY2RLHcc23BGUafTFNKSlEwKckccPTr
 oUW4186nUf+4KyNlJCnfCnD5wJHiTO9hQyiYEPU4vXsr3ZwBXgBDCrgZrhhwLaoKRnHy4GIDmOU
 Fp+yrrnznIEepsPScfWkFwkqaWPK+wvDOKzivXxKVnqo69tBI36TlI0H9rxz7vEt/8D5WhTi0Rn
 w5F7P8GwC4N3qzltl98GOIOvi5zmkmzrUtKn5WEM3JCqeyrjYkx3b+jwRaJ02dURBCjbT3dCVSm
 CM/2RYoKErW+eTPY3uj0By7AQ/hzl/SlfRoIIuhB20fyqLrFgsSw1aFx227kBY7HGE9/2H0LOB1
 l7njLCDS/8yAtVEIfXXPrhQLXMfqsCC3h8XNAiPtROkDHMumCbM4vagcXoSFwJzSVl4nbKUZFef
 5JOHOCvwsTCWUkSOveg==
X-Proofpoint-GUID: uK7IYKd7fy_Vs2I714ULUAC3wxCMHN7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010192
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 1, 2026 at 2:23=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 5/29/2026 2:57 PM, Brian Cain wrote:
> > From: Brian Cain <bcain@quicinc.com>
> >
> > The hardware-assisted scheduler helps manage tasks on the run queue
> > and interrupt steering.
> >
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >  target/hexagon/op_helper.c | 77 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> > index 64f1fb2043f..82062a2f802 100644
> > --- a/target/hexagon/op_helper.c
> > +++ b/target/hexagon/op_helper.c
> > @@ -1589,6 +1589,64 @@ static void hexagon_wait_thread(CPUHexagonState =
*env, uint32_t PC)
> >      cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> >  }
> >
> > +static inline QEMU_ALWAYS_INLINE void resched(CPUHexagonState *env)
> > +{
> > +    uint32_t schedcfg;
> > +    uint32_t schedcfg_en;
> > +    int int_number;
> > +    CPUState *cs;
> > +    uint32_t lowest_th_prio =3D 0; /* 0 is highest prio */
> > +    uint32_t bestwait_reg;
> > +    uint32_t best_prio;
> > +    HexagonCPU *cpu;
> > +
> > +    BQL_LOCK_GUARD();
> > +    qemu_log_mask(CPU_LOG_INT, "%s: check resched\n", __func__);
> > +    cpu =3D env_archcpu(env);
> > +    schedcfg =3D cpu->globalregs ?
> > +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SCHEDCFG,
> > +                               env->threadId) : 0;
> > +    schedcfg_en =3D GET_FIELD(SCHEDCFG_EN, schedcfg);
> > +    int_number =3D GET_FIELD(SCHEDCFG_INTNO, schedcfg);
> > +
> > +    if (!schedcfg_en) {
> > +        return;
> > +    }
> > +
>
> Is that really a noop in this case?
> Or should it trigger an exception if sched is not enabled?

It's a noop, the scheduler has no effect when SCHEDCFG_EN is disabled.

> > +    CPU_FOREACH(cs) {
> > +        HexagonCPU *thread =3D HEXAGON_CPU(cs);
> > +        CPUHexagonState *thread_env =3D &(thread->env);
> > +        uint32_t th_prio =3D GET_FIELD(
> > +            STID_PRIO, thread_env->t_sreg[HEX_SREG_STID]);
> > +        if (!hexagon_thread_is_enabled(thread_env)) {
> > +            continue;
> > +        }
> > +
> > +        lowest_th_prio =3D (lowest_th_prio > th_prio)
> > +            ? lowest_th_prio
> > +            : th_prio;
> > +    }
> > +
> > +    bestwait_reg =3D cpu->globalregs ?
> > +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_BESTWAIT,
> > +                               env->threadId) : 0;
> > +    best_prio =3D GET_FIELD(BESTWAIT_PRIO, bestwait_reg);
> > +
> > +    /*
> > +     * If the lowest priority thread is lower priority than the
> > +     * value in the BESTWAIT register, we must raise the reschedule
> > +     * interrupt on the lowest priority thread.
> > +     */
> > +    if (lowest_th_prio > best_prio) {
> > +        qemu_log_mask(CPU_LOG_INT,
> > +                "%s: raising resched int %u,"
> > +                " cur PC 0x%" PRIx32 "\n",
> > +                __func__, (unsigned)int_number, env->gpr[HEX_REG_PC]);
> > +        SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTWAIT_PRIO, ~0);
> > +        hex_raise_interrupts(env, 1 << int_number, CPU_INTERRUPT_SWI);
> > +    }
> > +}
> > +
> >  void HELPER(wait)(CPUHexagonState *env, uint32_t PC)
> >  {
> >      BQL_LOCK_GUARD();
> > @@ -1697,8 +1755,27 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState =
*env, uint32_t reg)
> >      g_assert_not_reached();
> >  }
> >
> > +/*
> > + * setprio/resched - hardware-assisted scheduler helpers for managing
> > + * the run queue and interrupt steering.
> > + */
> >  void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t p=
rio)
> >  {
> > +    CPUState *cs;
> > +
> > +    BQL_LOCK_GUARD();
> > +    CPU_FOREACH(cs) {
> > +        HexagonCPU *found_cpu =3D HEXAGON_CPU(cs);
> > +        CPUHexagonState *found_env =3D &found_cpu->env;
> > +        if (thread =3D=3D found_env->threadId) {
> > +            SET_SYSTEM_FIELD(found_env, HEX_SREG_STID, STID_PRIO, prio=
);
> > +            qemu_log_mask(CPU_LOG_INT,
> > +                          "%s: tid %" PRIu32 " prio =3D 0x%" PRIx32 "\=
n",
> > +                          __func__, found_env->threadId, prio);
> > +            resched(env);
> > +            return;
> > +        }
> > +    }
> >      g_assert_not_reached();
> >  }
> >
>


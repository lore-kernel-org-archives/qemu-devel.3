Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC53C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3Qu-0006FP-IL; Mon, 17 Aug 2026 15:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1ww3Qr-0006FF-Nw
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:55:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1ww3Qo-00073H-0b
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:55:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIQj903107917
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KTFGER1WYIa
 X/Hvj+lYses3GUIgYxht3Wrk9IJ36Mec=; b=U278K/n1RTsuUiZBlB+eq4Uut/n
 k+JYzbMUVAbRMfu0oYmqStdbt5RwhcpE+odMNNSird0tCILRMwG60wPPW4aHQWiA
 LLz6NTpC7cwWJcGfIy+/MlRHtzwOBasOhWyW0+saIO0gCLB0d8IHQfg04wxoHQ4M
 wYr3v5CXdDHToMj2Cf2gAFD1wePB5YBamYdskv8BZ0a2OcRQ8bHZk3ybufgcC+A2
 YRz7nw7AwCGAYQcsneEc5WQcCymCUVmKKppD97iY7Ucig4cOOyiU381FMIQMVny8
 b5fHBCfWZ5Ao3N2/XvlFEIx6etnAe6lm35Wa+xMgwrDju5R5hRSXo1GrP2w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615gs1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:55:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb5cc1e139bso2832225a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786996534; x=1787601334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KTFGER1WYIaX/Hvj+lYses3GUIgYxht3Wrk9IJ36Mec=;
 b=hK3TwqVlULxliCPOQiYKn33awcRFkISg2UWsjR1hiS7v+Y4kD988xKTw1JPb3FjFoW
 bQ9XSaZeGBsc3TWX8mrwyNTn1j0I6fHDSPkc8eTVpTNX6CSOVkCeB9kKw3uMg6Yd69DA
 CWpDE3EO2B7NExpZtKxoXhWowRMeVgy93Lb6z0fYEzducMaxLCU7VTw79lgPQQUi7og4
 LQdyU/XMJ18xroEmBBokLWtf2FymKdeAYE4q1h7YyTqBg6G0xoTiGtPfEe/wPZb3IL2a
 xMuh3gNGLx1lzZXfDaimSqRyT5bm5DAKvsLAs6Ngj22hl0V01IOseL0GdgAe1TCYtKQF
 jCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786996534; x=1787601334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KTFGER1WYIaX/Hvj+lYses3GUIgYxht3Wrk9IJ36Mec=;
 b=hZ0mTXtt4IS8tRSQhFY24i2/IhMXvSavrLfpzgLAA+N4H7uEf3DYRh12U9cWw+2ad7
 bu8k9tfcKrLxaBqNYl4pyW8r+QXzG31ag8i2UlMovHhYQv9KSe9Ad10/wuqGin7zoPXU
 RFABah9LpBdV5Gl7aGjWIod3r8xf3gdaay8BqvoRl9TYYJAsheQwRsqCRj+BbKRhnLt+
 Z3klNzxK43eYwWs/xIobm+WlWPZ2Zxx1iDEAeQqENyrpElA9cnQ1GGLAAig79KohJpNj
 kwKv2ypbEu4Q5J2SBIPtbnLuh7sKZgKJlFPmFTgePQ14j8uQ2Wg1W9wLnKcQvhlGOF0o
 jPkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIV9iAZG6e0QSaYJmFIQ5zLRDBnV5926DTzP0pho3MtBx+NWH6NlYLjIIds6NCii9+b3+r3tWdJXpD@nongnu.org
X-Gm-Message-State: AOJu0YxBO8ispMxWdhBl5fGVKQu6+p1rO4Nw2l9v0P5lKM0x9Ogaebes
 Sscklw3CkEiHaElunAGEN+kfAfFQ1SMXQhLE145JzeJSAVszCW+HOaLFQtLhz9fr4336JOsF52U
 /zkZe6TtMnFG6a7JBpQBQUflUBeSQjtQJ/xUU+RSS++BmjpHeioNIFAPLbQ==
X-Gm-Gg: AR+sD100knLmjhN8f6uEN8eISVwUR0xdvm4it/XFslqMXHy9OZksDsZoXGlvcbYY8To
 g0u8GG9SdMf59e7xva/HgjBUb204Qibj8ATPn16WvfZu6Mda7TpnixnA4KZ096nHyB6YanGrniB
 L3AO3oe9nYxz6v3p/aM1HpxZ/vBm0dk2DVc82KboULqSyJkQZyBvjPmMMihNsPfHja02qTqG5qS
 ag/x1Jgk4npQ1+8J2M/4FW7OYIV0qAv1Dj9qW5FSPAl7g/MRvzLqBJ65DJkFfyBxfy8pNcd5o45
 Ccg0zj0Zl9IfFuzyCrQH3R829aiXR0qP8h6MDxS2IV4lO5EF/U/vHow/osIjhwFB7E6u5p6j7mt
 OGTYvzHEgnMqNfqzjfFofMaqmEtX5CamOpbIBI8K2nPZDndAWbiWgZE10OXl5kb0=
X-Received: by 2002:a05:6a20:7f92:b0:3cc:9618:f51a with SMTP id
 adf61e73a8af0-3cc9619062cmr14512977637.8.1786996534217; 
 Mon, 17 Aug 2026 12:55:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f92:b0:3cc:9618:f51a with SMTP id
 adf61e73a8af0-3cc9619062cmr14512941637.8.1786996533771; 
 Mon, 17 Aug 2026 12:55:33 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm16859590eec.9.2026.08.17.12.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:55:33 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: philmd@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
Subject: Re: [PATCH v3 10/13] target/hexagon: add COREDUMP semihosting
 operation
Date: Mon, 17 Aug 2026 12:55:30 -0700
Message-Id: <20260817195530.3274625-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <5ce3a94f-2706-479e-98df-527e21efea8c@oss.qualcomm.com>
References: <5ce3a94f-2706-479e-98df-527e21efea8c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eRTLV6mAkDzpeYU22UG1ijqBkJCpXsup
X-Proofpoint-ORIG-GUID: eRTLV6mAkDzpeYU22UG1ijqBkJCpXsup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MiBTYWx0ZWRfX11Sc330ar5pk
 puhfjhYwy3Vk1m3FzKIBvkW/0vwBrc0fwFPEQk8B4sMCHTSIdvrQRBQFVSMmPl1RBxS1bp3zisd
 kkktfZxtj3hnOyY0VdG/1x7mU5BxqAWxwLQdoULepcZ1HHuvJw94mnkGyS/BRnTfHxTOvwK4zyH
 e3Cj4i45jjyrOU4hxtDNrLBtI+vx4g/ZtmbAgCe8cch610UG20PQ80c/Q3w+SH54NdyUeH7Rsow
 GBKyuK7RqLnMXRu61gY8g7KsMz6/9S7GjUkyyGHdcnIOJisZc1rDDevAO2qQgdDsjhLIG40itj3
 0eDvVkdtEaCxPyq3NoYU68QhzK5qqZfojSLjQxhpZb/2YcqzPqNEscyzEZ3dacNGcgJe6B87Lzl
 cD5MQVZmJj2PlGWXrZaVQJzMgeC+MEctgKGDnRwesywn0WfD8Q7N3ZoN91l9BzH+5f0GBks2JOD
 QEKfVuWU/UilcpPnU0g==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a836736 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=MccaekPpnXH7EKpJXG8A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MiBTYWx0ZWRfX7pifxJX8Yg52
 7c53V3d0SqluXUhMXh5r+SLevcC+Jf3fcIAL1mJwdyRzCHw6U4i0mxIITvTnp19zSwouMngoirF
 NtDLWQdboAe5IB4/1/n1oGr3NjsPGw8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170152
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On Mon, 17 Aug 2026 06:34:54 +0200 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com> wrote:
>
> On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> > Baremetal Hexagon programs invoke SYS_COREDUMP (0xCD)
> > through semihosting to dump CPU state on a fatal exception.
> > Implement the handler to decode the SSR cause field and
> > print the full register file, matching hexagon-sim behavior.
> > 
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> > ---
> >   target/hexagon/internal.h |   1 +
> >   target/hexagon/cpu.c      |   2 +-
> >   target/hexagon/hexswi.c   | 143 ++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 145 insertions(+), 1 deletion(-)
> 
> 
> > diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> > index e6b2ac1939d..06c378c5e02 100644
> > --- a/target/hexagon/cpu.c
> > +++ b/target/hexagon/cpu.c
> > @@ -232,7 +232,7 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum)
> >       print_qreg(stdout, env, regnum, false);
> >   }
> >   
> > -static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
> > +void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
> >   {
> >       HexagonCPU *cpu = env_archcpu(env);
> >   
> > diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> > index 6efc00fedf9..564a11e557a 100644
> > --- a/target/hexagon/hexswi.c
> > +++ b/target/hexagon/hexswi.c
> > @@ -162,6 +162,145 @@ static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
> >       common_semi_cb(cs, ret, err);
> >   }
> >   
> > +static void coredump(CPUHexagonState *env)
> > +{
> > +    uint32_t ssr = arch_get_system_reg(env, HEX_SREG_SSR);
> > +    FILE *f = qemu_log_trylock();
> > +
> > +    if (!f) {
> > +        return;
> > +    }
> > +
> > +    fprintf(f, "CRASH!\n");
> > +    fprintf(f, "I think the exception was: ");
> > +    switch (GET_SSR_FIELD(SSR_CAUSE, ssr)) {
> > +    case 0x43:
> > +        fprintf(f, "0x43, NMI");
> > +        break;
> > +    case 0x42:
> > +        fprintf(f, "0x42, Data abort");
> > +        break;
> > +    case 0x44:
> > +        fprintf(f, "0x44, Multi TLB match");
> > +        break;
> > +    case HEX_CAUSE_BIU_PRECISE:
> > +        fprintf(f, "0x%x, Bus Error (Precise BIU error)",
> > +                HEX_CAUSE_BIU_PRECISE);
> > +        break;
> [...]
> 
> Should this be moved within hexagon_dump() instead? That information
> seems available and useful there.

Hmm, we could extract this out of coredump() if there are other users, but I don't
think it would be useful at hexagon_dump()... This info is only meaningful right
after an exception. In a generic cpu_dump_state() call, SSR could be 0 or even
hold the value of the last exception, so "CRASH, I think the exception was..."
would be misleading there.


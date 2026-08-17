Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63126C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2Pt-0007dX-PY; Mon, 17 Aug 2026 14:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1ww2Pt-0007dO-2d
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:50:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1ww2Pr-0005GC-F3
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:50:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIR5r83143191
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 18:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MuSoWf3Prau
 VYCh1RrzW0SfSnmrxqS63sPsmRV8N+Gg=; b=eEu6MDeXxVe550QblDWcpY7S0mQ
 tDSP5zB/e6cQ8SWZMRNm+YnACWn2w6TIUtMZqLCkIAj10VyU3LGs1GoDk3MFnLfD
 NzG8aBlkfLGtprGqwARJqAtTucynJ403NF1X6VXW0pYqf/+L+sA+pMCNvzUJ9ZVL
 UmxW4iDAOhl85oWcCozHz62PBDcVcw2fYYlsZcgDhl2LIY6+TVhI1GK9Jzj2NTry
 nzyag05nP1d4Wq4ihq+ybD6SMMPw8QvewSOGrBf1rozBb80/PDt5/QNYCDjulUfa
 Y6+WfSGYFUuTK33L08RWrQutS2Z04HhoWrGLAdPu6/MyC8oEgNi3vF4odbw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wrejtue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 18:50:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so59569555ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786992631; x=1787597431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MuSoWf3PrauVYCh1RrzW0SfSnmrxqS63sPsmRV8N+Gg=;
 b=IIYlm2tn2IIHbIhkOyKQxw83SjKWX8O76UjnCALDWGMHhviVA4TziYQvjaLrcsP4Dw
 8srS9VamUPc8IOtPABQRGgX/Dx1IxewqAp12IGYuGFt9djZtg8fuKDJltqLgHlyRRBwm
 rzq0VjW+ZqORpmOPrO/+O3NzCv73JMW/we1igXYxocxTdRxPQPI5KrXZqNfwsN7S2/JN
 PBzeu/51ItoYIKQoCz9c6rnVWt9Wccf94eURURMbshjxZsH8LUa1HnUg4tQyHwv8dHvb
 OzfBmwX0OHhjLoqXonOb3Z4uE/JLdBCb9y97/dPxrHB9K1Sy+JU/sTxFOYQuQ0J+nTzk
 +r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786992631; x=1787597431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MuSoWf3PrauVYCh1RrzW0SfSnmrxqS63sPsmRV8N+Gg=;
 b=Er2s7WLiqlmLLnx+HOSZcUZBFi2CnmqyvGQ8oxuC2rvrx0EtYN6/3IPZZ95PC2FiVn
 kk6lcspsS8X0C+oE9xGu2uOLCH6HDj6UK8wwTzBPHU1Zo91f23kI49g7Nx2SbESlPFGd
 GN4EG5V0eJXDK+Qvd7ZNYJpvHHAe6tGAF+6b7CCdMwO6/0sF4qdJzk5EQQU0WYV63BNN
 GvueCU3sJHjJ2TVDItznbp3tfinyqDloZOxhK1snHIuVnangzN6bUAuvuQDQeP3AXndQ
 uOjOU+hP0kUaLYpSw1f399IHTphGVEORrCGKw2CqnUcuH2XkbqS7YIlkOfNMmhz8UR3J
 PMtw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOzJW70H6pZ8dRRERtrwTAsktzxgI+D3mhcTr9AKv2+J7/2KMWNAHBNyUeKbLZy4e85t2/z5Fkyukd@nongnu.org
X-Gm-Message-State: AOJu0YytHWsc9FyNhE24TcWRmCDKCdZsX78N1wCWo+Exd2kqXb5IXIgf
 vUCfJDtj1Gg66i4XkfKE9GaPFSgiajmSHYVNGMBmsNRmDVAe7dksq4xsjmmiHAaKSPqGCpGWq61
 0zoQ1nY9pV6oqun2d5l0COnC81ZhkAxpYh+Kz8o41/75VMdj+FFD7VLaBLA==
X-Gm-Gg: AR+sD10MMFuaSl9aKaXsFD6tzVcHrQFIPdjWbfBA+6vgP/ZcHUViGjAicxAIpMQ4DNV
 7su30Ce1Ua8tLzSyIUss8+1kqXSvc+R25wG7Ggg6aS4fJa5HEw0b99iColZ8bJhneDCmZsbKU9+
 urFOHAXTXUXGTxdDHvt/aVIuPQD3q2A6sZEe5ZrKOdfsWg/1iHxIMS/ZuALrOWemSVi5JFBSEx1
 qxFW9smzP3r3weTLmraN8zWtYgGnpORLnX42iXPdBmQcbx+t5JcsfedkQQPh7Xhcum0nmcdLnwQ
 BAClLf3KB6LpP5MC0SqfK4pLjntHpYrUVkxbyMRnelvEceD6C8pOXHTKXaP00QvjawcFeF6ZgXq
 OxCiCFumUqzj6kevLNU6bKz3VJeMJ6r5RV4EabfZOUzoyuDpX63Dv1sr7S38vfqU=
X-Received: by 2002:a17:903:22ca:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2d3b06e91c4mr300711495ad.0.1786992631120; 
 Mon, 17 Aug 2026 11:50:31 -0700 (PDT)
X-Received: by 2002:a17:903:22ca:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2d3b06e91c4mr300710855ad.0.1786992630614; 
 Mon, 17 Aug 2026 11:50:30 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c898ce3sm8697657eec.27.2026.08.17.11.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:50:30 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: philmd@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, pbonzini@redhat.com
Subject: Re: [PATCH v3 07/13] target/hexagon: add semihosting support
Date: Mon, 17 Aug 2026 11:50:28 -0700
Message-Id: <20260817185028.3215488-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <bfe5d191-734a-43e2-9c2e-96196c4e2aa8@oss.qualcomm.com>
References: <bfe5d191-734a-43e2-9c2e-96196c4e2aa8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FqI1OWrq c=1 sm=1 tr=0 ts=6a8357f8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=2BDBtiAS9YdESnSQLKsA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: z8L9oyDVToJn6rHuuZy5tXL_v-qUys-H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NCBTYWx0ZWRfX1shtjl8ma5sQ
 Cu9gaWTvJTXeOraG8Bh8945kSFEuNOjrxa20qsTduVMbZ+wZQdIJ74867ys0LSoStVV0r7iCv2E
 R7jFNRMTCQelhWUksqKlyJ9IefkRrHRyGdf712jx8JjAmEeCsX6uLmZLZSyq74/lBjZhbPYIiPt
 ODVhN+ilAyky5IFVLHw+jv6jkufDckfKJ180Le0U93OOHvdNEJxSqp6cBoYU5EgwFQ3pPa6W5Eo
 VovKF/iQZ7TB3S5BoNV1Bke/mS08OQVxjaC+1UNzQwxiVl0E0R5gVbEBaPEs33ReqrAD9lx5+Ba
 EZM3wzScpBopzvfHE7hSPtGlCGpWyFncm+yirV8WasRbhpA0fOJnjLaIsFyIdE4G398CJVu8RB3
 F9/1SNm3m+mZMfRqOjUguVi/pRb8uN4aGp7F4ILyJOr3OchdJIP2vHwrD6eFGVmF2kfqpCCI/qn
 oeExCVriABA7j1LZPQA==
X-Proofpoint-GUID: z8L9oyDVToJn6rHuuZy5tXL_v-qUys-H
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NCBTYWx0ZWRfXzVwCmSL9YZXA
 d1A7aDSTOZUDi50ph/UVcpBWOQczwBNjPcIqNduWev855W26sYyAMdfpEMfSC6TCRKvWjB0xtqQ
 dWbKKFNDTae0zJFpWqiGzcNZC5yYXU4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On Mon, 17 Aug 2026 06:23:03 +0200 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com> wrote:
>
> Hi Matheus,
> 
> On 20/7/26 19:41, Matheus Tavares Bernardino wrote:
> >
> > diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
> > index 52065ab3b22..3a8ff17812b 100644
> > --- a/hw/hexagon/Kconfig
> > +++ b/hw/hexagon/Kconfig
> > @@ -2,6 +2,7 @@ config HEX_DSP
> >       bool
> >       default y
> >       depends on HEXAGON
> > +    select ARM_COMPATIBLE_SEMIHOSTING
> 
> Here we select explicitly ...
> 
> >   
> >   config HEX_VIRT
> >       bool
> 
> 
> > diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> > index 59cb09c1070..69f01bd2f70 100644
> > --- a/target/hexagon/meson.build
> > +++ b/target/hexagon/meson.build
> > @@ -262,6 +262,9 @@ hexagon_softmmu_ss.add(files(
> >       'machine.c',
> >   ))
> >   
> > +hexagon_softmmu_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
> > +                       if_true: files('common-semi-target.c'))
> 
> ... so optionally including this file is odd. If we still want it
> optional, then we need stubs for symbols with external linkage.

Oops, this was likely a copy-paste error from target/arm/meson.build. I'll
include the file unconditionally instead, thanks for the heads up.


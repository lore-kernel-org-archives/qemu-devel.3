Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A8ECA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCh55-0007Ln-Dp; Fri, 02 Oct 2026 13:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCh52-0007Fr-N9
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:29:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCh50-0004qP-RL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:29:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692H604q2984645
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 17:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DF4raEuczcpLRhkN3es64eO707hzznPNYFO78qmec0E=; b=QfOjU/bakFYMH/M8
 y9BR1/GfPCJ3PvTqNC8DjmJaYi9qpf2lfZw6EysgWWFrDl5lRrltvHkYvPgY6nhy
 Fq9G2xA/daUQClszo3qb/UPWNtJFmMTVAKFBvMHee5w0znp5sg2Bz8FRr8dfeqBu
 09xIX44I48ux3g/XkhzuyRG8y1owRIU66MMfwKKlGuuMTOrMhZqPPZH0goM3reCm
 xNzDLzQ0uVLnOgrlVq5LSK899PQMJLPpbVM4jfczqLQAi0GArf3gqjgYa/jQ6iB4
 dvRSaUt6QV6dHyB7fEYpTrce1vPmtMQq+vnBLYSWOIEGlXJ+jDnhlBZx1vWWEGLW
 4lJ9XA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mtq3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 17:29:52 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4b2d1eb484aso12426575b6e.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 10:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790962190; cv=none;
 d=google.com; s=arc-20260327;
 b=R0P36wmMHzItPIYqD29/4bNFOdqoIyKkh3CqZXDGcMnGInUNzDNP5BCP7A27AUGXNG
 n1YoJ5IWQwzSTMhhj0/w1qI+Z/HoCrKKC+DqiW0UdMGie0FTVDf0IaftHdkzk9fjAn2Y
 kbilG0EQbWi/uDZj1U03tPqIZhWZ85SW92/PWy1yG9eWjJgIBTabVDrsDR6KegljxMrK
 ksTAV5Ug2GFpyjvKZPqOwpZfkFcGPobxJDuAKWKf7ebNMjtgfs6mifksEzb7QG/aDCc6
 gIyxPAKbVWR5EeH7II6Ar+Nkwm7L+MKOz918BrVjMLkE8YnvY27am8S3znZUxdNWOR7m
 cx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DF4raEuczcpLRhkN3es64eO707hzznPNYFO78qmec0E=;
 fh=TFjMkRNqP21Fcsv+AAyRbG5AJWNBCgqZWGulVX2uu78=;
 b=nr36w10FwX9aitIpymTaQsbeIZYvh09fCv/kALi+dx3ASrIxAkDw3aFYhKlBgd4ZEV
 vWjm86ynVfEWs+G1tRFtUOxtDQHX8/wAm+MnsIi2kO9LkFtyPV9iIFThN+bjP3grp/7k
 yO9q3oWkoOdJVvVrxigCyPlWyl90dcoQHpeC6i4/wGTeUEtBQzS+Pt5kyqC+euv/wwls
 tERczhC6Iq85yoFzs6GTJJ0cIwWMc1buuNnmAzbj6i518lKk+4sX+woSywIM7Xe5TrDL
 YobDLMY3PXjXP3HxdpBR1DGdTffxmHAGC1/6z1XYI3sZ2DSSdCUPhDMZ4iJ1wC5AssbA
 R/WA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790962190; x=1791566990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DF4raEuczcpLRhkN3es64eO707hzznPNYFO78qmec0E=;
 b=HV8UxwlSlULlGBAGFg4OjmfsyhSEwowpESSUJ2ecjP93OknAvrghDkueYoKMfskGVz
 +upbZC+wv004OBXB1zctM90c1uwxo9Of2V4v8qw2y71YBtphIt9MWEpwlgAwrcJAdlrq
 lKBDWNHJShtRK1XKgBAbQVqItDQro4DflGe5LDbEM+UhWyxac/K1uAYVthbJDVriYvO/
 HM7mLVkyCTTep+uKGbc6DZIQWZcuH4ZvzdJd0WO/0T+yDJGivPERQn2hhvvTpiKnOAY9
 Tf6SMrj4OXVClzRmZQGwSkXKXH2lFmSJTcQRtJLn8DgkYshMC62XzcPwibiUA6CtAllj
 xBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790962190; x=1791566990;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DF4raEuczcpLRhkN3es64eO707hzznPNYFO78qmec0E=;
 b=kuGG2tDbVK+dNZAOfrHsgkTsPezuV4GFHha4XbMe5IHyQyzBQUzPNCrlh+HVMPg4tT
 nakc9Fqw43ssShUVBYHgR50Sv/C/XD57I3ocXkCE8FzfO7VeQTCuimiYKt3INwh7NyQb
 UJWXQkxoMeDhxsAIpqpt/vshIxhjMij1DEjbagt163Ppgtf7Ed2UNKLDNnyyei64n5n7
 omDzRVJLLXrVDdMVZ9kLD2Jo8i4i5Ttb/3KZO7KKN7IIXK111uI/48HhdaS0KSg9Sn0o
 eKkITtVGNghZUY1b1R7aj7cuYoWIc4LsYnF4a+1jh0LowgCtHvUNuBu6qNAoeIvhmR1f
 FDQQ==
X-Gm-Message-State: AFuF++luKCL4PknNJsW/qGFmX5dM93c18LlBRjkKzeH+sRPSyNfCrHjL
 at00U6nJu8+gR2DUHoGGoQJyVxBAY7wojA16WyC8aovAz4tHQ19ldOxEqkLFSgcn0moeaJ7BC/O
 MrnFKQUF8F5k4zrBiVpfqR0/m37xy6n36+H17/EQY117IRI5JBWKFHAEEaUW49UkeyUBLE9zATP
 Y0dxADz9G/UJLoz+dFcO/ty+X9MDAgf0K+
X-Gm-Gg: AYBFou3/SEfkTjGVv1Ce1mg2mYOiz9daTl40cVbQK94WWh6E/dLAH/+wp9wiUijBN66
 7Df9lZS8TB4jPY3jZA/kRFkmLH8hdowYg2bLks4bgS2103saLqgPcQoME30Ge35DZFOMXhXxBBi
 XZey5I2dQvcW6C0c7FzPOFGMe1d/EUN7rixMFiuYfx6jc29sA1lYwAsAJgm19Hft2XnhF9Obxiy
 cfPjD+4oxbFEGc7lQ==
X-Received: by 2002:a05:6808:1795:b0:4e8:2150:299 with SMTP id
 5614622812f47-4f679fe2a10mr133550b6e.23.1790962190184; 
 Fri, 02 Oct 2026 10:29:50 -0700 (PDT)
X-Received: by 2002:a05:6808:1795:b0:4e8:2150:299 with SMTP id
 5614622812f47-4f679fe2a10mr133524b6e.23.1790962189590; Fri, 02 Oct 2026
 10:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 12:29:38 -0500
X-Gm-Features: AclHuK8Uoyi4M5BL3cBMLLSPf108abrE4xgg4_Zj_45jFBbzKej-PPUZRkRnUfc
Message-ID: <CAJ+KCYPoCyR+2k=oN6Dh0-Kyi4sJD3SAghm7bzvitJAFk1gtmA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Hexagon: ll/sc fixes, emit TCG barriers, TLB locks
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2OSBTYWx0ZWRfX7J+F3hc1ulhk
 GmCYsOnWtVF+Gxc8DgQoWI+vJYABF/m8ksTt99MHnXkTGUeob4S/cEn5j95xcTpVUsn/MNr8hfs
 jUDgU2FFaQqZULgjWYYve1cdRujuMvw=
X-Proofpoint-ORIG-GUID: ncYixCvAdj0ga0Fd1Gahpm-ZRpVSN_RU
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abfea10 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=UWSghvUszEUKwdkCuWEA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: ncYixCvAdj0ga0Fd1Gahpm-ZRpVSN_RU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2OSBTYWx0ZWRfX2VChNU17CMQc
 TetTvmvxcBn617eaIYm2y/mOs+j1DPYOYt62W0ec56Ki7oa9h+pjdpnur3sD+HUkDRDkO0jCwtY
 sKWLGzq4a+7zVKPapOd0f25++ucEF4STMHdL0Y0wuIKI7bTotNg3GiX0pkd9dYelh1EtJ13912W
 NcygrOaMCQ3ZCzCiHXTISZkNHCQnxu0mzkti4OdirNvYmVocKaqD3iCata/FslhxaoULLLOV1UW
 +fuB+ET3+ZZEXbM+jm7sY8FoPcgQhrPjS9N/SrJFjNkg/nB8rG2zq/hmvN/8LoXAt0Ee7GBukAu
 qyY1i2NwgqYxlz/qqGal0H593f0WLkSNNHL5KxKdA9Bs923pCCP80KlfDoRtFXAXM6ybC38eXoT
 fAQOMEt6BDiR1i/kw0FHl5mxTXUI5rRiRUJpO1f/zX9cFXaEzHM4W6Qm/GLGYDox6fMFuWkiups
 SVDkSbIiDZEjR/NvL9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Sat, Sep 26, 2026 at 9:43=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> While preparing to enable MTTCG, audits and testing revealed gaps and
> bugs in our implementation.
>

Which tests revealed those gaps/bugs?

Commits LGTM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B06C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 15:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruwVi-0003Ki-3v; Thu, 11 Apr 2024 11:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1ruwVf-0003KD-Sg
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 11:38:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1ruwVe-0004wP-0Y
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 11:38:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43BC07SA001843; Thu, 11 Apr 2024 15:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=qc3xni4UjMOI1Bu8ABvn6DXr5RhO126T7+BLVEFsYP8=; b=Rc
 btHiajr6K2urfvAARc+MKBE5dB+Oi02RHPBos1OHjyTgZD+8YjmIkBLiGcuTpd0P
 wwXfC9KgfuW5sP+4S/+c320XT5bDJE5fogL7/49cDpuTO8EA3n++i9MgSo6rLCG7
 bke2M7eI7ALosKfSpm839bJoQpjxhQ3u1sKhY53f65gWDCbTFGLfbUTtsnhWZyJ7
 5cX6DNApMqqpdJsOgImC6LxoPW8wWd4KMl0yMuCjioj/lTYhY1enBoZ0p7gCud27
 dM8YupbGfk+/oVHhSzHQrYq4jmNjZr9yzn4s4IhZ/U3GAhg6c9jm379hjUO9t+4c
 Jgo560uDAkr2QjCfN9CA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe9jsaav8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 15:38:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BFcRWZ014702
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 15:38:27 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 08:38:27 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <martin@geanix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH] Makefile: fix use of -j without an argument
Date: Thu, 11 Apr 2024 12:38:04 -0300
Message-ID: <20240411153804.3849645-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <fb8c5aa0-d412-4ac0-b77b-64816d72a996@linaro.org>
References: <fb8c5aa0-d412-4ac0-b77b-64816d72a996@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: ox_KIsnJBZsQ0TcvGG_iropB1sXptO5e
X-Proofpoint-GUID: ox_KIsnJBZsQ0TcvGG_iropB1sXptO5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110114
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi, Philippe

On Thu, 11 Apr 2024 17:29:58 +0200 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org> wrote:
>
> Hi Matheus,
> 
> On 11/4/24 17:09, Matheus Tavares Bernardino wrote:
> > Our Makefile massages the given make arguments to invoke ninja
> > accordingly. One key difference is that ninja will parallelize by
> > default, whereas make only does so with -j<n> or -j. The make man page
> > says that "if the -j option is given without an argument, make will not
> > limit the number of jobs that can run simultaneously". We use to support
> > that by replacing -j with "" (empty string) when calling ninja, so that
> > it would do its auto-parallelization based on the number of CPU cores.
> > 
> > This was accidentally broken at d1ce2cc95b (Makefile: preserve
> > --jobserver-auth argument when calling ninja, 2024-04-02),
> > causing `make -j` to fail:
> > 
> > $ make -j V=1
> >    /usr/bin/ninja -v   -j -d keepdepfile all | cat
> >    make  -C contrib/plugins/ V="1" TARGET_DIR="contrib/plugins/" all
> >    ninja: fatal: invalid -j parameter
> >    make: *** [Makefile:161: run-ninja] Error
> > 
> > Let's fix that and indent the touched code for better readability.
> > 
> > Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > ---
> >   Makefile | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 183756018f..d299c14dab 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -142,8 +142,12 @@ MAKE.k = $(findstring k,$(firstword $(filter-out --%,$(MAKEFLAGS))))
> >   MAKE.q = $(findstring q,$(firstword $(filter-out --%,$(MAKEFLAGS))))
> >   MAKE.nq = $(if $(word 2, $(MAKE.n) $(MAKE.q)),nq)
> >   NINJAFLAGS = $(if $V,-v) $(if $(MAKE.n), -n) $(if $(MAKE.k), -k0) \
> > -        $(or $(filter -l% -j%, $(MAKEFLAGS)), $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
> > -        -d keepdepfile
> > +        $(if $(filter -j, $(MAKEFLAGS)) \
> > +	     ,, \
> > +	     $(or \
> > +	          $(filter -l% -j%, $(MAKEFLAGS)), \
> > +	          $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1)) \
> > +        ) -d keepdepfile
> >   ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
> >   ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
> >   
> 
> Apparently Martin sent the same patch (although not as nicely
> indented) and Paolo queued it:
> https://lore.kernel.org/qemu-devel/20240402081738.1051560-1-martin@geanix.com/

Actually, this patch is a follow-up to that one, fixing a feature that was
accidentally broken.


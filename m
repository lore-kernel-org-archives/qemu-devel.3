Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47584C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 13:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2tFq-0007I2-2L; Fri, 03 May 2024 09:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s2tFe-0007F2-GH
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:47:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s2tFc-0008Dx-K2
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:47:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443C0XUU024449;
 Fri, 3 May 2024 13:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=LOYughhNB5uUl0+Yn0OscPjCTIXV6iggsrBZMPDJ/2Y=; b=I0
 o9AIbEXswPcaDmQMWKP8Recnrc2UdmzXUzocZ8hH5oJL7TvbVLA7Q2nUTq6kNqCd
 g8aW4wDXSIhqjqnUz0CeZYtKElfxEkRr7mjVxZLbC8CegnfmPaqXLkGk9xI4NOJI
 Q40/uiHglZqY5jnl8rDcina0vAPClEzxqQLe2MC/HmTRZuFv1s2SMEVTdlHV2lTN
 IHIxHSKu8TjWXT81hsDKL5qNZ+RDZ0M33QTfABdcSjaA0PuK9tYw/0vlFc7foQFv
 iO0NPNjQGJsix4iGMbc2bS2qgrgVYSBzrkkmhPWyjm3UA0V3J+23DqtbT6NPd0CJ
 v2L3zUIXP0J07oldkecg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvawbjnq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 May 2024 13:46:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443DkteX006955
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 3 May 2024 13:46:55 GMT
Received: from mathbern-mac.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 3 May 2024 06:46:52 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <richard.henderson@linaro.org>
CC: <quic_mathbern@quicinc.com>, <qemu-devel@nongnu.org>, <bcain@quicinc.com>, 
 <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <ltaylorsimpson@gmail.com>, <laurent@vivier.eu>
Subject: Re: [PATCH v5] Hexagon: add PC alignment check and exception
Date: Fri, 3 May 2024 10:38:29 -0300
Message-ID: <20240503134635.78067-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <c5613f05-5cfe-4f8a-b5b2-0d62ea1cf808@linaro.org>
References: <c5613f05-5cfe-4f8a-b5b2-0d62ea1cf808@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 5o-KJtWChcT2iLyDhQ48xO5xVBmRLSvy
X-Proofpoint-ORIG-GUID: 5o-KJtWChcT2iLyDhQ48xO5xVBmRLSvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_09,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=783 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030098
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
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

On Thu, 2 May 2024 13:00:34 -0700 Richard Henderson <richard.henderson@linaro.org> wrote:
>
> On 5/2/24 12:20, Matheus Tavares Bernardino wrote:
> >
> > +
> > +void test_multi_cof(void)
> > +{
> > +    asm volatile(
> > +        "p0 = cmp.eq(r0, r0)\n"
> > +        "{\n"
> > +        "    if (p0) jump test_multi_cof_unaligned\n"
> > +        "    if (!p0) jump 1f\n"
> > +        "}\n"
> > +        "1: nop\n"
> 
> Does it work to write "jump 1f+1" or something?

Unfortunately no :( The assembler will align the address when encoding the
instruction. The only working examples I could think of is using a separated
file, like before, or manually encoding the instruction with a misaligned
address and place it with a `.word` directive... Any preferences, or other
suggestions?

> While it shouldn't matter, perhaps trap[01] would be better than nop here?

Ok!

> Also, the bike shed should be green. 

hehe :)


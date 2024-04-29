Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870B9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 18:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1VSm-0007iS-E8; Mon, 29 Apr 2024 14:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s1VSl-0007iJ-6C
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:10:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s1VSj-0001yh-6m
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:10:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43THeIem029617;
 Mon, 29 Apr 2024 18:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=24sarxMrfkzmkv4AhpAzVXJpdLV1xO3F8hNNgiYLuUo=; b=Ga
 PXle7yfo6TUsS8FfeCOrqaDRgwc8/NEfYxuEeKH8qV6mCbEriARs3bzCHqltGl1j
 em88fuOc9wJWhIKK9r3x3RKspWiwpBU/1paCqViHUiufvJjCT1xyQiah0yyWXxRR
 7TlWrpPVy0aMnNEITyjtrNsM0/MwZT6+rKama4Kzd3ew93bhkIM8h263VuF3KbX8
 vyxNSt6qPsRHsEVRQLAGeagCRT4Zq6gqUfLr0ncAYlIhaxv1WlBbYeWxKQnXY1qN
 TD9RSFuQIDzQmnqMtydfaeO+Oes0p3QKnR006wRBNDcnHWMXD7x9NXTX5hsvCXqe
 ncomD2BT2Uz+W+nh0maQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtg51r4vb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 18:10:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TIAgjC013601
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 18:10:42 GMT
Received: from mathbern-mac.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 11:10:40 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <ltaylorsimpson@gmail.com>
CC: <quic_mathbern@quicinc.com>, <qemu-devel@nongnu.org>, <bcain@quicinc.com>, 
 <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>
Subject: RE: [PATCH] Hexagon: add PC alignment check and exception
Date: Mon, 29 Apr 2024 15:02:14 -0300
Message-ID: <20240429181010.2160-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <028e01da9a44_b05d2940_11177bc0_@gmail.com>
References: <028e01da9a44_b05d2940_11177bc0_@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: OsBKPikrSKt6pi1QAaKrtXlIJ04IPdA-
X-Proofpoint-ORIG-GUID: OsBKPikrSKt6pi1QAaKrtXlIJ04IPdA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_16,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290117
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

Hi, Taylor

On Mon, 29 Apr 2024 09:51:16 -0500 <ltaylorsimpson@gmail.com> wrote:
>
> PS  You should also update the pkt_raises_exception function in translate.c
> to return true for packets that contain these instructions.  This will
> ensure that none of the machine state is changed before the check is
> complete.
 
Will do, thanks.

> > -----Original Message-----
> > From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > >
> > >
> > > --- a/target/hexagon/genptr.c
> > > +++ b/target/hexagon/genptr.c
> > > @@ -473,6 +473,7 @@ static void gen_write_new_pc_addr(DisasContext
> > 
> > You haven't added the check to gen_write_new_pc_pcrel.  It's not needed
> > there because the encoding guarantees the target is always aligned -
> right?
> > However, there is a call to gen_write_new_pc_addr inside that function.
> In
> > this case, we'll add a check that isn't necessary.  Consider adding a
> parameter
> > to indicate if the check can be avoided.

Actually, I had missed this spot and I think we do need the check at 
gen_write_new_pc_pcrel too. The added test `unaligned_pc_multi_cof.S` will
exercise it with a relative PC addr that is not aligned. I'll fix that, thanks. 

> > > a/tests/tcg/hexagon/Makefile.target
> > > b/tests/tcg/hexagon/Makefile.target
> > > index f839b2c0d5..02d7fff34c 100644
> > > --- a/tests/tcg/hexagon/Makefile.target
> > > +++ b/tests/tcg/hexagon/Makefile.target
> > > @@ -51,6 +51,19 @@ HEX_TESTS += scatter_gather  HEX_TESTS +> hvx_misc
> > > HEX_TESTS += hvx_histogram  HEX_TESTS += invalid-slots
> > > +HEX_TESTS += unaligned_pc
> > > +HEX_TESTS += unaligned_pc_multi_cof
> > > +
> > > +run-unaligned_pc: unaligned_pc
> > > +run-unaligned_pc_multi_cof: unaligned_pc_multi_cof run-unaligned_pc
> > > +run-unaligned_pc_multi_cof:
> > > +	$(call run-test, $<, $(QEMU) $< 2> $<.stderr,"$< on
> > > $(TARGET_NAME)"); \
> > > +	if [ $$? -ne 1 ] ; then \
> > > +		return 1; \
> > > +	fi
> > > +	$(call quiet-command, \
> > > +		grep -q "exception 0x1e" $<.stderr, \
> > > +		"GREP", "exception 0x1e");
> > 
> > We should also test endloop instructions.

Good idea, will do.


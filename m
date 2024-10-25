Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FC9D149CD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4OAa-0004pX-Bz; Fri, 25 Oct 2024 13:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1t4OAO-0004p6-Jv; Fri, 25 Oct 2024 13:32:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1t4OAN-0007nC-2w; Fri, 25 Oct 2024 13:32:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCHNKd004522;
 Fri, 25 Oct 2024 17:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZjgjzbtbBZzuRbBVzKz6bDVJAcjSqRyqDfv27QNlrxs=; b=VD+2+4HfEiNSSOIY
 FmyiIoPzXWp3MfiW5zLcsBx94TlQkgukqxKSrFVU8uHywazMBinnqdjqYu6DIXjD
 oYZS2SjaQb61C6KFCJmIIONnO3VM2jgi7QD/EeF0Mi0KtU+dG71Fr1iwWXvcBrob
 6VwGWmLQaqkU4JmIG5pioLb5BExjrNJyakTiwH4RU5uYCxlssm4IdRqThVSaZBJQ
 DM7xbWCfNLyv9RQwLjvdU8Z0Tpf8c8BuvD/8JL1hi8fQA++BhE0zyIv+CmL7mQqM
 kIq6T6LHRTHiC3r/w+ENE8VMn8qRgq2GSIU9kS5cdimrQOvIIlkosWIeleMZN4H5
 55silA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em689xvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 17:31:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PHVoda001132
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 17:31:50 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 25 Oct 2024 10:31:49 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <berrange@redhat.com>
CC: <quic_mathbern@quicinc.com>, <qemu-devel@nongnu.org>,
 <alejandro.zeise@seagate.com>, <clg@redhat.com>, <qemu-arm@nongnu.org>,
 <kris.conklin@seagate.com>, <jonathan.henze@seagate.com>,
 <evan.burgess@seagate.com>, <clg@kaod.org>, <peter.maydell@linaro.org>,
 <bcain@quicinc.com>, <sidneym@quicinc.com>
Subject: Re: qcrypto_ivgen mem leak and possible issue?
Date: Fri, 25 Oct 2024 14:31:39 -0300
Message-ID: <20241025173139.3277091-1-quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <ZxvGHesrhPlQri__@redhat.com>
References: <ZxvGHesrhPlQri__@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: RGdMu4vDRe8Wy1ujkRdfrmTCJNIkJv77
X-Proofpoint-GUID: RGdMu4vDRe8Wy1ujkRdfrmTCJNIkJv77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=854 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 25 Oct 2024 17:23:57 +0100 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com> wrote:
>
> On Fri, Oct 25, 2024 at 01:06:01PM -0300, Matheus Tavares Bernardino wrote:
> > Hi,
> > 
> > Since e3c07527f3 (crypto/hash: Implement and use new hash API,
> > 2024-10-08), we've been seeing a memory leak in two check-unit tests:
> > test-crypto-hash and test-crypto-ivgen. Looking a bit further to try and
> > plug the leak, I got a bit confused regarding how the result crypto
> > buffer is handled. Looks like we are allocating different sizes at two
> > different places, and I'm unsure if these places follow the same
> > convention or could be breaking expectations from one another...
> 
> There was a screwup in the commit you mention causing a memory leak. Can
> you check whether it reproduces after
> 
> commit dde538c9a76f328a92c532893e97e18785d57364

Thanks, Daniel. Yes, it is no longer reproducible after that commit :)


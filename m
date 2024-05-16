Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC659C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 19:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7gzm-0005lZ-48; Thu, 16 May 2024 15:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7gzd-0005jL-VY; Thu, 16 May 2024 15:42:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7gzT-0000ZY-V0; Thu, 16 May 2024 15:42:21 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GB15cp006187;
 Thu, 16 May 2024 19:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-type:in-reply-to; s=qcppdkim1; bh=OnUlYBuD
 8UjKSLFNZBxpwgTLeP+MqQOeusbC1aDUHL4=; b=Ud6Qwbb0FeZi+ge2+3pswrNc
 VjYhHsXHdkfcJBoet99Hp5vRnnP2OSsdniFzot83/ltTkUxg1UvBkRb4zEU6X4by
 AS2uiKC8Ds9fpSNWeL67DoirtS6mfTDMOF+CFtL71+AxiUWlXSjEienMozzA9u4d
 QQdSfS2L55dSt4xLTeLExfV/y1xbb7Y2jkiIzM+atyQDAyeGdkYoajqzMZ8feoWA
 dCu3ENHZQOayUMZ9u1eRjp2JW9qEzwzX6Ya9HlBn7YEV9uptXWQaXB7HX00tCKfi
 OSlE9lb4ihXXWSM4vewhyzUWxykpQCJkRSxpLGVd1D9uRJp3A2n9Aa1Pjmw5pA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y51tujvkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 19:42:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GJg6MY011490
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 19:42:06 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 May
 2024 12:42:01 -0700
Date: Fri, 17 May 2024 01:11:57 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: "Daniel P. Berrang?" <berrange@redhat.com>
CC: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <quic_tsoni@quicinc.com>, <quic_pheragu@quicinc.com>,
 <quic_eberman@quicinc.com>, <quic_yvasi@quicinc.com>,
 <quic_cvanscha@quicinc.com>, <quic_mnalajal@quicinc.com>
Subject: Re: [RFC/PATCH v2 03/12] hw/arm/virt: confidential guest support
Message-ID: <20240516194157.GA440762@quicinc.com>
References: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
 <20240516143356.1739402-4-quic_svaddagi@quicinc.com>
 <ZkYgeGSPxD_yt5oa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <ZkYgeGSPxD_yt5oa@redhat.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: YJfy-5VEm_NC79rR5vJlEN91NlZZ49R2
X-Proofpoint-GUID: YJfy-5VEm_NC79rR5vJlEN91NlZZ49R2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 mlxlogscore=886 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
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
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Daniel P. Berrang? <berrange@redhat.com> [2024-05-16 16:04:24]:

> On Thu, May 16, 2024 at 02:33:47PM +0000, Srivatsa Vaddagiri wrote:
> > This adds support to launch hypervisor-assisted confidential guests,
> > where guest's memory is protected from a potentially untrusted host.
> > Hypervisor can setup host's page-tables so that it loses access to guest
> > memory.
> > 
> > Since some guest drivers may need to communicate data with their host
> > counterparts via shared memory, optionally allow setting aside some part
> > of the confidential guest's memory as "shared". The size of this shared
> > memory is specified via the optional "swiotlb-size" parameter.
> > 
> > -machine virt,confidential-guest-support=prot0 \
> > 	-object arm-confidential-guest,id=prot0,swiotlb-size=16777216
> > 
> > The size of this shared memory is indicated to the guest in size/reg
> > property of device-tree node "/reserved-memory/restricted_dma_reserved".
> > A memory-region property is added to device-tree node representing
> > virtio-pcie hub, so that all DMA allocations requested by guest's virtio-pcie
> > device drivers are satisfied from the shared swiotlb region.
> 
> For reference, there is another series proposing confidential guest
> support for the 'virt' machine on AArch64 with KVM
> 
>  https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg02742.html
> 
> I've no idea how closely your impl matches the KVM proposed impl. ie
> whether we need 2 distinct "ConfidentialGuest" subclasses for KVM vs
> Gunyah, or whether 1 can cope with both.  If we do need 2 distinct
> subclasses for each hypervisor, then calling this Gunyah targetted
> object 'arm-confidential-guest' is too broad of an name.

Thanks for that pointer! Let me study the proposed KVM implementation and 
see how we can consolidate support for KVM and Gunyah hypervisors.

- vatsa


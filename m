Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63737C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lEO-0000QD-78; Thu, 24 Sep 2026 11:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1x9lEN-0000Py-3Y; Thu, 24 Sep 2026 11:19:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1x9lEL-0008Ae-CK; Thu, 24 Sep 2026 11:19:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC74Ac1011353; Thu, 24 Sep 2026 15:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:sender:subject:to; s=pp1; bh=Ggnh5bwdpn4cCO55ijDDXCt
 y8RQxsxhJmTkeBVJrdY0=; b=nTb75koTzbkLQp/d73HplRTM+Qwe4sT+jh9wQZN
 s2KH+DHXKVIoRmfkooxlG2sDt/rwFe5uvgigsBvqOgD9cqaIYRLo4X5ja5v2ukYq
 gYpSRAIfYjA4QASkwgbhL2ZOOE46ykKNlhuX++XsoerzKr5DfrMkPAYMRXaBWV/E
 NvF653nFTejwaGY9ZG/2b76UfHYvRGrKhdXV4+xntxqeUvEPFEz/sAWWXJ7dTY7S
 bWLwjnmru59eToEfKwkLEG9qx8X2+dPojm5/90b5YOrgXr/tmzVJ7fXGwmOU91hG
 VA/83qu1nPkEEew/2PjNQCSspK84lGoA2ICrlGBiaGCacrA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqs4hh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 15:19:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENkO42245511; Thu, 24 Sep 2026 15:19:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jxe9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 15:19:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OFJC4W40501686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 15:19:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82D122004B;
 Thu, 24 Sep 2026 15:19:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7168920043;
 Thu, 24 Sep 2026 15:19:12 +0000 (GMT)
Received: from vela (unknown [9.224.91.188])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 24 Sep 2026 15:19:12 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.5)
 (envelope-from <brueckner@linux.ibm.com>) id 1x9lE8-00000009HbU-0lOr;
 Thu, 24 Sep 2026 17:19:12 +0200
Date: Thu, 24 Sep 2026 17:19:12 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, brueckner@linux.ibm.com,
 borntraeger@de.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 david@kernel.org, iii@linux.ibm.com, richard.henderson@linaro.org
Subject: Re: [PATCH v3] s390x: Expose pv attribute in QOM
Message-ID: <arU_cEFXYeRtA21y@linux.ibm.com>
References: <20260924142846.157848-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924142846.157848-1-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab53f78 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=nZy19kRignTvS_rYd3gA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfX5jeHPedN3gNJ
 MZ5Mc3YQQVAnYWxSAMyHnICHUO9luMqCHOloYfcmp1AHKgv0UKvp1NVRo/KTALsm6x17RLjPZ9q
 idCqn7sbe78IA2/VrNTulDX4qWiKZDJ/Y0ievbmZglqoF411/l20uZ8O40V2k16YGa5Il+OkKcn
 /Fjdu54AwBN74DaxblskVU6cOb0ZNZ6pdd4JqM0boVtLws19R2r2SRxKnNaPhcgiVSq2VRJEwsz
 guGCXI+60mEgGhKJ5+dsMY2VZNz4YU7ebWY6kxTwpBmwWXobk/HIHjNZgSmxyQsu2Ua7X2OyVrY
 N3xj51+ERjL1COEHnANDsCiN1/xOi1SviJ4A3cKAYSYdOv89RIjVfB58x7bPF9SFt5MSMDkOH5Q
 BrK7z7XA10r+uT7juXXf5HsYx2ARZRHSMcs76a6rB4uIu7RA+FIqowGRiW0U0aJoiKFiBGkT/AX
 Xh93v1jTmtMxCUjEPrw==
X-Proofpoint-ORIG-GUID: uRENKsB6ooG6aa8330P99btSWM30rOMn
X-Proofpoint-GUID: uRENKsB6ooG6aa8330P99btSWM30rOMn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfX+5miCca18aXb
 UkthgwjbzZQ70fkSHmpFMhsZFmX/nkitF5Nb0l28d13LrhnaMaeJ1Bawhi7VzCXEXzbARUlc5Q5
 xGVbi1jSaLLJ1uMgX+oQeVv5WvOy+tQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240062
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 24, 2026 at 02:27:22PM +0000, Janosch Frank wrote:
> People doing VM management requested a way to query if a VM is in PV
> or not. So this patch exposes the runtime PV attribute which is true
> once the VM successfully made the switch into PV mode (according to
> KVM) and did not yet reboot to drop out of it.
> 
> This of course does never replace attestation, it's merely QEMU's view
> of the situation.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> CC: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>


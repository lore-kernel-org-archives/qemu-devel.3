Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1419CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6RKc-00064d-6m; Wed, 08 Oct 2025 06:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1v6RKW-0005wr-Ie; Wed, 08 Oct 2025 06:23:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1v6RKT-0004t7-1V; Wed, 08 Oct 2025 06:23:31 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5983gctO011678;
 Wed, 8 Oct 2025 10:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kHnlHd
 AtoaSFOwtK+F4SFpUjMtiM2v+/sEVz4RKNK7k=; b=Ktxc4nQM8W3lErdnJePeFp
 1Pahr1HGlQ/g+L5RWz/XGk+fC1PKi326CbGVMsBkKYzJA2Q60dEvIzNsEQy8pLhF
 xfsWXvZn/tnnfE89bMkNg3uEBeCdb/zzUiWRtNFrNk6dbP8VnorzaBl23XmsGkfs
 Shp6HTDWvilHpODscgt4fmB0pWdBvzj//f0umdBAFWJm5Fs1+nDM9qkBQpJWRvcJ
 36fb5LGwNuucUahZmo2Wf427dGO9HvsQLi72X/ArWbn2A6BPW9PYTMQyugz+RNLH
 gVGxlSuxGfAEK2uAaaiKE3sYMsaCVfTE84yGQO4b8FjKGBl4m3Ma1lFmrbyFY1lA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jua9cb6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 10:23:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5988hjeL019689;
 Wed, 8 Oct 2025 10:23:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kdwsg54j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 10:23:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 598ANIBZ10551798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Oct 2025 10:23:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E73420071;
 Wed,  8 Oct 2025 10:23:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B33420074;
 Wed,  8 Oct 2025 10:23:18 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown
 [9.155.208.219])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Oct 2025 10:23:18 +0000 (GMT)
Date: Wed, 8 Oct 2025 12:23:16 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, farman@linux.ibm.com, thuth@redhat.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] s390x/pci: set kvm_msi_via_irqfd_allowed
Message-ID: <20251008122316.5eda630a.pasic@linux.ibm.com>
In-Reply-To: <20251007205614.188365-1-mjrosato@linux.ibm.com>
References: <20251007205614.188365-1-mjrosato@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RCKFPas_fggvqzGze5pIU7DKh64ItP2D
X-Proofpoint-ORIG-GUID: RCKFPas_fggvqzGze5pIU7DKh64ItP2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX9wSHeaWbjvVW
 l4wHDsi+GB92DvWeJsl84zBbKTmTTX7p+tlBRC6Kf1tFIwNCSLam8N/PgRoRJUnW0lb8tc1uAwb
 OtcYVhbJGd2PVCJjTHIxyv17dcc071rsXk21cWIi+wRRD7Kij9gpDTitVLCRz58iTqsZJHolMtH
 Nyn0RvIJIvRZyKXkpfBDTpkhoYAO+O/XZlWIZaeQo5GMg2ifGzE93oK0DuodHR5gBFqsm9ZX2fN
 fvDaSxK95C5bpgozlwF1W2oovvScJ611Eu5TZ8stxlUgi4BAppT9VULjcO7nyGTILHeHaW31qBP
 DihrI4tlLUn1gwy9uOg8LD2H9L+IhLFvtoVXcFC8BdVe8aP1Yi4JExVgSiwYoLb+vYJUvuO7OTv
 A5M3D3mUXnUB7t4wfykQOs1QxRyTAg==
X-Authority-Analysis: v=2.4 cv=QdBrf8bv c=1 sm=1 tr=0 ts=68e63b9b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=bf3z2jQr7r-_6UqURtQA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  7 Oct 2025 16:56:14 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
> it.  This improves s390x virtio-pci performance when using kvm
> acceleration by allowing kvm to deliver interrupts instead of QEMU.
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>


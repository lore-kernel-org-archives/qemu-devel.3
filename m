Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37BECF2562
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 22:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLUcs-00049G-2e; Tue, 18 Nov 2025 17:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vLUcr-000494-04; Tue, 18 Nov 2025 17:56:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vLUcp-00027D-C6; Tue, 18 Nov 2025 17:56:40 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIHQFUh028553;
 Tue, 18 Nov 2025 22:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/yaEdk
 monNeqci6s4V2bnwkTcETtOTqL257eKXz7Fh0=; b=N+3oafNo18IcRVLQT0XjSH
 3CsNXlxri3ekiUwTKmLp2iLEZ6V3GFHn/0xZGVdRY1MPw8nYLu8J6F6C12Adegea
 SPB2lF9yt1RsJQCKD2Bzi1HKUomurPi4m3PeU/iQixPdwYG0/PGMhhVlbrZTYtSO
 yjGBnzZ62grn7/9Xj7ThXmr7EP/ZTtEGt/w+KCSuuzQ8GDTVro0HyBL7UAsVQSpk
 EHe8iUsghy2PCRxRcblASAOejVwtvBrtDb6ztNkBAxkUTqQhVfTNZJwWzvg0IPYY
 CfkSUrdsryxb0rQpFNu1e7p8RRenZ9OJEA0zFxPoazdIL5ql3BB9LS6nv/AIppWA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsn0ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 22:56:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIMTeIF005231;
 Tue, 18 Nov 2025 22:56:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bk5kmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 22:56:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AIMuUJc38273362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Nov 2025 22:56:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE5AF20043;
 Tue, 18 Nov 2025 22:56:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 317E420040;
 Tue, 18 Nov 2025 22:56:30 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.14.232])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 18 Nov 2025 22:56:30 +0000 (GMT)
Date: Tue, 18 Nov 2025 23:56:28 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand
 <david@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater	 <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
Message-ID: <20251118235628.5869f067.pasic@linux.ibm.com>
In-Reply-To: <8f90d4d7ea1c4ee8e088f5afb483587181278ebf.camel@linux.ibm.com>
References: <20251118093945.35062-1-thuth@redhat.com>
 <20251118130218.30d3da33.pasic@linux.ibm.com>
 <8f90d4d7ea1c4ee8e088f5afb483587181278ebf.camel@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PEOuGYAm_GHxNuylrBzEo7YHw5Hr3vSP
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691cf9a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Pm1AC5FQMR7C-oOkkdkA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: PEOuGYAm_GHxNuylrBzEo7YHw5Hr3vSP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzY7pUmQUTj1K
 Lk0VsuNwrg/9P/IXfM3399VRuF5cmaENoXIyWBgSB9xqTdjs+Vj5tDcze7RAjCW5L9s1V5gOTIt
 ch1L3cNQK+ULEDuIjMkBMi9qPrFWHZgBrJ5x7But5qjidSUG9PHwGIxyyP2YXWhPPWiZpWPqJNt
 6cHOAu2Z29GoVJcM8Yt3swqrrwiFg5oO/dZ+3PogWXFNJ6FLMjFfmRz9t1i+FWKwxAeaVvaVCkt
 +lZRw8re0CyW2BIvsAadSlB5z8soAWLWZJNcPqSrtSbA75ytCcgTVnkCKik+68OEDZoCGyJPM69
 uj2r335bDfcUJ9PkHUnhuRC1Qa1Ca8jnDLhMMI7tlOQD7j5PkLVbRW5NbsG7+LU0M/lRm39qzbA
 gFUh3rO/SzmtNt+102AVjoWppHJ6Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 18 Nov 2025 10:19:56 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> > So I think it would really make sense to prevent passing through
> > virtio-ccw devices with vfio-ccw. Eric what is your take?  
> 
> It's true that the only -supported- use case is passthrough DASD, and we allow other device types to
> be passed through. The only ones we fence off are what we know aren't going to work, like FCPs.

I think we can add virto-ccw to that known to not work list ;)

> IIRC
> we'd talked a few years ago about a plan for a more detailed allow-list of passthrough devices and
> configurations, but that fell off the back of the todo list. Short of dusting all that off, I don't
> know that blocking virtio-ccw from vfio is going to buy us anything that Thomas' patch doesn't
> already provide.

See your comment form later today :)

Would prevent ending up with a most likely dysfunctional device at best.

Regards,
Halil


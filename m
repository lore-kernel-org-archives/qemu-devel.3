Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E86CEDD97
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLMdP-0005Oo-GB; Tue, 18 Nov 2025 09:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vLMdC-0005Nl-9c; Tue, 18 Nov 2025 09:24:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vLMdA-0006Wq-2S; Tue, 18 Nov 2025 09:24:30 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI57Av6011537;
 Tue, 18 Nov 2025 14:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JhnW4M
 2n9ie9OmIq7GryB0Jfq8C/uUu3RJLcXv/4DO4=; b=oluksGq6fMIXgfdl/BxwBZ
 JTM/475HCseyq9qKY7wBM0Wl5TnSeeQ6jpv71D/TlLbCcw/KaHuzUAa9x0B/KJ7m
 Iacp6CEGnqOACPzmUq536cMoQwyQZOzw1JS9ePrH5S+od/F2dvqIXeVKvr6CPDNm
 C9W6Zg8z3UuIbWQH+Y+s3MWm80PyaPPy2fJCKrh1YZIhzVWFAp+ga9R+q+0DcnnV
 HMXA/ty0m5K9qT/n2iOlzkarB9AHcGBSoBYeFMSkEBcLz1l9Llfpq/USPKMAXRHU
 bBau41cgbV2B6MU3TbGLYb+ZhEovJzGP2O8aZlvHdg71vI/JwXpX3Ix1LvMaLEjA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1b7mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 14:24:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AICInda006954;
 Tue, 18 Nov 2025 14:24:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af62jb9rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 14:24:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AIEOD5P60424492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Nov 2025 14:24:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09A962004E;
 Tue, 18 Nov 2025 14:24:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B340E20043;
 Tue, 18 Nov 2025 14:24:12 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown
 [9.155.208.219])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Nov 2025 14:24:12 +0000 (GMT)
Date: Tue, 18 Nov 2025 15:24:11 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand
 <david@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
Message-ID: <20251118152411.37a06f7a.pasic@linux.ibm.com>
In-Reply-To: <50f79156-dd93-40c4-831e-66e558531be8@redhat.com>
References: <20251118093945.35062-1-thuth@redhat.com>
 <20251118130218.30d3da33.pasic@linux.ibm.com>
 <50f79156-dd93-40c4-831e-66e558531be8@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691c8191 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mkMtH7XpAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=23i2Y_J-8Cmu_NqU6hwA:9
 a=CjuIK1q_8ugA:10 a=WtO8poqlptoA:10 a=I9Slk6e--tAXHahELIuT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: RWm1KHo_JjO2qOqQ7AELOY14-3RrooHT
X-Proofpoint-ORIG-GUID: RWm1KHo_JjO2qOqQ7AELOY14-3RrooHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0ULVbyPtdZ3r
 MjgWB4RGWrxb0NJoC0kq+hHXhJW1fzwzoWvwcV+pUZs2ADxXAugad4Nct3iM9dF0F87G/vbC3ei
 5PUBBegAZ+VDnkAKy8e6y9DbWrZ+iwsdrhbdIuLo4o/PCAB3zSlisNDLOKlWFVWZkeVaGNDPo/w
 V4ojAmM8GQsYGPPj5ldz5DidOR2wfbwWTLS1FC3GCtklN6Xj7coMLlrrUstzlmacJDNYisfnI9J
 x1n3c5mcoB5iejVJwmtCGWSe4/odNUptDCLL+gVrRBbYHrA8vSVO1WfSvLvuDIbeJo3EMs/GgA6
 7qF3cvxWq2ME3A00F2E1R2Rzj8Y3PpbTNixr++X9rCDQMGuktKQzvJaYLf99MLHU6wcXRKQblz9
 A/VHFCZFmhr+QYq14WhGv01OzkvOdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
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

On Tue, 18 Nov 2025 13:28:19 +0100
Thomas Huth <thuth@redhat.com> wrote:

> > But I would argue that the L3 guest didn't do anything wrong.  
> 
> That's the point - the L3 guest just sees a virtio device, so we should not 
> punish it with program exceptions just because it tried to send a 
> notification for the device.

I understand. But if from the L3 guests perspective it looks like the
notification happened just fine, it isn't exactly good either.

> 
> > Pass-through of virtio-ccw devices is simply not implemented yet
> > properly. And even  if we were to swallow that notification silently,
> > it would be effectively loss of initiative I guess.  
> 
> I think the current patch does the right thing: It returns an error value to 
> the guest (just like we're doing it in other spots in this function 
> already), so the guest sees that error value and then can finally give up on 
> using the device.

Hm, the -EINVAL is put into GPR2 which is 'Host Cookie' according to the
virtio specification:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-2260002

Unfortunately, I did not find any words in the spec according to which
GPR2 can be used to indicate errors. There does seem to be handling in
the linux driver for that. It basically says negative is bad, but I can't
see that in the spec. It just says "For each notification, the driver
SHOULD use GPR4 to pass the host cookie received in GPR2 from the previous
notification."

Maybe we want to update the spec to reflect what is in the filed.

But I agree it won't get any nicer than L3 guest giving up on the device
and resetting it. Which is an impact as well.

> 
> > So I think it would really make sense to prevent passing through
> > virtio-ccw devices with vfio-ccw.  
> 
> That could be a nice addition on top (in another patch), but we have to fix 
> handle_virtio_ccw_notify() anyway to avoid that the L3 guest can crash QEMU, 
> so it's certainly not a replacement for this patch, I think.

I agree, it should be a different patch.

I think adding some detail on the error handling via GPR2 to the
commit message could benefit the cause. But I don't insist. As I have
said I'm on board with the patch.

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Regards,
Halil



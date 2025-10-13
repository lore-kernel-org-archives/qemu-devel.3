Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B1CCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8FCJ-0004Ai-Ue; Mon, 13 Oct 2025 05:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v8FCF-0004AP-TV; Mon, 13 Oct 2025 05:50:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v8FC9-00083v-IP; Mon, 13 Oct 2025 05:50:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CLF8ta007315;
 Mon, 13 Oct 2025 09:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=JLna1f5NF3OqASXf5TH9oWDUCCRAwn
 ZGK4JAgyx6CYI=; b=qHPoK1clevuMVh94IoNqHJ+BYqks4aJXQIZRDgHXnk6CxE
 0NEJMnHuMMDOv3/+MqwYrNqoIkXfiidzxLJFAjMA/AUmCXGQ05dSGCW4nQPmk44E
 1liZRiqtSHTjBUKOxcuk5z8tSnL1durMzj/XwjXvBGyRfKD0m9MdDDsHvyMWTknF
 WfwhrErt7a7Ch7zlzhEQl0rgmHreSDerNY8WJeQx8fn9Mn+1+q4jcNWSc3MQT3Nx
 FNB3IcL/S6y2warwZlLXe7ZlYeTHFxtdMwT394FuL2xKCVsshfZl6aZzXPQOLjFc
 gIRy93XFwavLBIuAq3Afe98zLs3sWeOl1MJ+ICKA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qevyqydd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 09:50:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59D9kR9a003950;
 Mon, 13 Oct 2025 09:50:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qevyqydb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 09:50:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59D9mvfU003603;
 Mon, 13 Oct 2025 09:50:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xxn9mt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 09:50:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59D9o8sE38732160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 09:50:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D93D5200B6;
 Mon, 13 Oct 2025 09:50:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 489FF200B7;
 Mon, 13 Oct 2025 09:50:07 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.21.93])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 13 Oct 2025 09:50:07 +0000 (GMT)
Date: Mon, 13 Oct 2025 15:20:04 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: harshpb@linux.ibm.com, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/ppc/pnv: Improve kernel/initrd load failure error
 messages
Message-ID: <aOzLTADP_N8b2WS2@linux.ibm.com>
References: <20251007091214.403430-2-vishalc@linux.ibm.com>
 <CAFEAcA8VWKEy3XVo3b9pTg-jCAD2oA7=dFbOSRL3q+WRUoNBpA@mail.gmail.com>
 <aOyj5p2xzoxCyYZC@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOyj5p2xzoxCyYZC@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z4QufeF6fyajdyeQH4KYI-yZCuF_GrXD
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68eccb57 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=_PDwZefUnsPwwmOXU7IA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXxAkUlEFkaYh0
 GpxlQ47/K8hwIuO0WV5/2Flb2FvDfEQnDBPmG8BqTkea4cXxcN160SweQGjl5QrHM5sFwBIVP4H
 S++9q7yueDUwZSs8z468uvm7qHaGR78XX3iRxLebIHtonL4UtiveG8aE71P9TOolnwF4Iup3Riw
 W2gLiW6Mxut3iJi5j5U7mB9fwXvyd8MQvyGub4zwXNXWhjkyZDIIhCTr5Wjjdbu4pD6KwyaXgjX
 vHrTUUg1f1qEhFEFCswSJg8yTWseqEFnOrZDwcklv1BYoQy5zIt/ZA4y1v/ICYOXWzWRPwhITae
 L21atwdj28tvvBZ1aOKanjfj8H6Gw5rmBVU5WC+WK6c8I3b+rVNeUnXoIlTwhWaFkc9hwe3pN62
 Vjo6Xh/y0saubTOnQwUy0Iyx5DE1jQ==
X-Proofpoint-GUID: uzshxRtsSlSPUJQRDhKezRwJ7VYVrDA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

+ harshpb@linux.ibm.com

On Mon, Oct 13, 2025 at 12:31:58PM +0530, Vishal Chourasia wrote:
> On Tue, Oct 07, 2025 at 02:29:52PM +0100, Peter Maydell wrote:
> > On Tue, 7 Oct 2025 at 13:59, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> > >
> > > When QEMU fails to load the kernel or initrd image, it previously emitted
> > > a generic error message such as:
> > >
> > >   qemu-system-ppc64: Could not load kernel 'vmlinux'
> > >
> > > This provides little context on why the failure occurred, which can make
> > > debugging difficult, especially for new users or when dealing with large
> > > images.
> > >
> > > The new messages also include the configured size limits (in MiB) to help
> > > users verify that their image files are within acceptable bounds.
> > 
> > >          if (kernel_size < 0) {
> > >              error_report("Could not load kernel '%s'",
> > >                           machine->kernel_filename);
> > > +            error_report(
> > > +                "Possible reasons: file not found, permission denied, or size "
> > > +                "exceeds the maximum supported limit (%ld MiB).",
> > > +                KERNEL_MAX_SIZE / 1024 / 1024);
> > >              exit(1);
> > >          }
> > 
> > Rather than printing a list of reasons why the load might
> > have failed, I think it would be better if we enhanced
> > the error handling in load_image_targphys() and friends
> > (i.e. use Error), so that these functions can report back
> > to the caller exactly why they failed and then the caller
> > can give that error message to the user. That way we can
> > improve the error reporting for every board that uses
> > these load functions.
> Hello Peter,
> 
> Wouldn't it be better to print the error inside the function itself.
> 
> Thanks
> vishalc
> > 
> > thanks
> > -- PMM
> > 
> 


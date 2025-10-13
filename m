Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE06CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 07:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8CZd-0002EG-4M; Mon, 13 Oct 2025 03:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v8CZb-0002Ab-02; Mon, 13 Oct 2025 03:02:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v8CZS-0002WH-Tx; Mon, 13 Oct 2025 03:02:22 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CMPhMQ007148;
 Mon, 13 Oct 2025 07:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Tui+o87vrOLHn4WGClzo7wx+izWhxM
 w50xwAzVn40X8=; b=g5mmkq/zwm8mXJ4M5xMX+PGLaAmaj3X3FcLTHrUQJ+Kqis
 Sqv6ybJ1OgZ1CPA7cBFYxy9/1ia2HoGMT3vbJrQbwqkGiLQM3L1q8ZC9DENZEkPf
 eUpC4xGcFwNDVkR1fk2PEuEapWh4NANSDR4CQ1DijhFF+P3CpO3dXGgvgDn7dxfb
 rkUD9ViCtFzHgP7hYrP//YLmQ2uGbIgsbaHl5J6+TUz6cMnS04twBrLT1Y+2slr+
 zsHLjK8kT64nQKaKv4W4R9e30G6opAZHJVqKj+AC3OSivSmlu97NhcCvz574EXhA
 5pqDjKB3l6lHNaxkirmNUFdqsdhNgswjWnZZ3XBg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8ffse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 07:02:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59D70YeZ017472;
 Mon, 13 Oct 2025 07:02:07 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8ffsc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 07:02:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59D1tTHC015052;
 Mon, 13 Oct 2025 07:02:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sj4d8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 07:02:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59D722lY31981890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 07:02:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99B85200F4;
 Mon, 13 Oct 2025 07:02:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1064E2010C;
 Mon, 13 Oct 2025 07:02:01 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.21.93])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 13 Oct 2025 07:02:00 +0000 (GMT)
Date: Mon, 13 Oct 2025 12:31:58 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.ibm.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/ppc/pnv: Improve kernel/initrd load failure error
 messages
Message-ID: <aOyj5p2xzoxCyYZC@linux.ibm.com>
References: <20251007091214.403430-2-vishalc@linux.ibm.com>
 <CAFEAcA8VWKEy3XVo3b9pTg-jCAD2oA7=dFbOSRL3q+WRUoNBpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8VWKEy3XVo3b9pTg-jCAD2oA7=dFbOSRL3q+WRUoNBpA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CySVlY4sZoM8gV4Z2YZr_xVg-_-NtlU2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX0vxD9T3uIqG9
 tR0xgxjlwbma43fY2hzp1YLcE5i2NcLbBcdIQcUoRjncDhtFuVyxo2MQASOk4jVJ1ID4AcsVcHV
 5YqcTwX19qOGjO/jpesi4bCgp6DuRZPf5B+/Z1ZDB+JMMASq6OhgBO42xo7JSxVtuAZiTU1YtcI
 JflCvt/m90B/l5ZuniUcuc6syFNWFHO//zslk2IOlrNZT/8epG1qvatJXHHXnzBsJdwNwqgPuvM
 ccm/7ml2kzquIxH1YppNBigTjetS+0aQtRHG7OvssYdZt5mbUc4l7+1/cBkA5co+P9i4cJQ05nR
 lZ3Iuks5TaJjFTMMks7Bzj4N8QaKFNdNRncrZj+23sXm++tHAs+H9daJK5pBF2B9rqbwBVsyEaI
 IIQxmB4PG4B8DF/A7a0uosWDkNyb7A==
X-Proofpoint-GUID: BD18msN6j4ov8Cm0MoBzVBqYf3f64Leg
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68eca3ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=zuM0ofxTe5cFuCWjBz8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Tue, Oct 07, 2025 at 02:29:52PM +0100, Peter Maydell wrote:
> On Tue, 7 Oct 2025 at 13:59, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> >
> > When QEMU fails to load the kernel or initrd image, it previously emitted
> > a generic error message such as:
> >
> >   qemu-system-ppc64: Could not load kernel 'vmlinux'
> >
> > This provides little context on why the failure occurred, which can make
> > debugging difficult, especially for new users or when dealing with large
> > images.
> >
> > The new messages also include the configured size limits (in MiB) to help
> > users verify that their image files are within acceptable bounds.
> 
> >          if (kernel_size < 0) {
> >              error_report("Could not load kernel '%s'",
> >                           machine->kernel_filename);
> > +            error_report(
> > +                "Possible reasons: file not found, permission denied, or size "
> > +                "exceeds the maximum supported limit (%ld MiB).",
> > +                KERNEL_MAX_SIZE / 1024 / 1024);
> >              exit(1);
> >          }
> 
> Rather than printing a list of reasons why the load might
> have failed, I think it would be better if we enhanced
> the error handling in load_image_targphys() and friends
> (i.e. use Error), so that these functions can report back
> to the caller exactly why they failed and then the caller
> can give that error message to the user. That way we can
> improve the error reporting for every board that uses
> these load functions.
Hello Peter,

Wouldn't it be better to print the error inside the function itself.

Thanks
vishalc
> 
> thanks
> -- PMM
> 


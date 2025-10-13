Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E3FCCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8GCM-0005v9-O4; Mon, 13 Oct 2025 06:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v8GCJ-0005uo-3E; Mon, 13 Oct 2025 06:54:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v8GCF-0000Ct-5K; Mon, 13 Oct 2025 06:54:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNFtHN018669;
 Mon, 13 Oct 2025 10:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=J/VWSN
 fiXzJGSjQtqbYbnvS1keS14NqGpFrXYOws2Cw=; b=qX9IlPgk5SPru/EQ2+z3Gg
 LO01qao2noSbMPi9XBhNQ+Ux1tCumWhVsF/bEtULLNA61Xoq6W8gxtNZ7SAAcEq7
 /KidszCxAOCJj8jvEYNhFrWfJTAI0jE7pNMhBUi2Z+tG8uAnTinhY/l5fDu5316O
 jx64l+V4/iWJD4L5TOqKh5uX9L1xeFo71DByPclqMQyj+WxjF5fIHMkg1O/+8R84
 Wd0T+ngEAIkYbtsckBTcmIe9fFoh12jOv51vwlWi6+T7o77rPwg6qBazANEaWy47
 6Yz7CMQxQctbT5Y21wkuQJEjC57wu+KqkdPj5z5oKB+iNr4gI8KrdloC3rKseCxg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr0hrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 10:54:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59DAlvEO021188;
 Mon, 13 Oct 2025 10:54:23 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr0hrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 10:54:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59D97QgM015194;
 Mon, 13 Oct 2025 10:54:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jrwmjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 10:54:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59DAsLEI26804824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 10:54:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E09875805A;
 Mon, 13 Oct 2025 10:54:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1BFD5803F;
 Mon, 13 Oct 2025 10:54:19 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Oct 2025 10:54:19 +0000 (GMT)
Message-ID: <dd607d02-fa3d-4560-86e7-6c2903799234@linux.ibm.com>
Date: Mon, 13 Oct 2025 16:24:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/pnv: Improve kernel/initrd load failure error
 messages
To: Aditya Gupta <adityag@linux.ibm.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: npiggin@gmail.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20251007091214.403430-2-vishalc@linux.ibm.com>
 <CAFEAcA8VWKEy3XVo3b9pTg-jCAD2oA7=dFbOSRL3q+WRUoNBpA@mail.gmail.com>
 <aOyj5p2xzoxCyYZC@linux.ibm.com>
 <CAFEAcA8zGH1sHL45WU=E2p4p0EizuOs3QRaniHW7ES-CQDPajg@mail.gmail.com>
 <5f414f58-f687-46c5-bcaa-32339ea9311e@linux.ibm.com>
 <CAFEAcA-s2ZUu2JFgyxSeYK8H3Rp7rVR4tCVDnMhdBHYn8E0OBA@mail.gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CAFEAcA-s2ZUu2JFgyxSeYK8H3Rp7rVR4tCVDnMhdBHYn8E0OBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ecda60 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=RvQfIQ7txzFNlZua1O4A:9 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: LJx93bmY3YxDX2daKvg9Sj6wf1ZcM72v
X-Proofpoint-ORIG-GUID: X3keB-mZe40xQ-cWPcO0jRjNZywnvMz6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfXxPIL3Z9bQsLV
 BYglD4Vh/rkb2EJ1UoHjY83h/rCe6y4TDIduBBCrU2CrbJZgdMIUeVWSA6UAyW644Su4ysb+I/A
 cPxO4XmOEibW+P+JOlKzmkHZjIuqwS6MxPKumXr431ggLTvriX8t9wcDxK2LLjE5bISXMJevVnx
 NjN5zKA8aPxRxmtA0v+g4dvK1ClgH2mvBadZrmyx9TDZxvfKYLPCPEbIYgXUqq06LIkr/7JNtIT
 pzXrR5Tf6Ap50paOOJB40aaWgNbN9YuREli15f/oXMF+qABH84qxlbxMhzR7rXcNAP0dFx7x0b7
 4VsFOsA5WJJIxf98q0rlHyU+YZ+BhcZ4kfhco8G9slIjWZRlOEDYwAK/6jNa+Ez4HJWNQ4DZWin
 NcKUX8Qpfwxlxct09dBYfjYtjcj/9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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



On 10/13/25 16:07, Peter Maydell wrote:
> On Mon, 13 Oct 2025 at 11:18, Aditya Gupta <adityag@linux.ibm.com> wrote:
>>
>> On 13/10/25 14:05, Peter Maydell wrote:
>>
>>> On Mon, 13 Oct 2025 at 08:02, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>>>> On Tue, Oct 07, 2025 at 02:29:52PM +0100, Peter Maydell wrote:
>>>>> On Tue, 7 Oct 2025 at 13:59, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>>>>> <...snip...>
>>>>>
>>>>> Rather than printing a list of reasons why the load might
>>>>> have failed, I think it would be better if we enhanced
>>>>> the error handling in load_image_targphys() and friends
>>>>> (i.e. use Error), so that these functions can report back
>>>>> to the caller exactly why they failed and then the caller
>>>>> can give that error message to the user. That way we can
>>>>> improve the error reporting for every board that uses
>>>>> these load functions.
>>>> Hello Peter,
>>>>
>>>> Wouldn't it be better to print the error inside the function itself.
>>> No, because some users of this family of load functions
>>> use a sequence of calls to handle different possible
>>> formats. We don't want the function to load file format A
>>> to print any errors if we're then going to continue and
>>> successfully load the file as format B.
>>>
>>> More generally, our usual coding practice for functions
>>> is that they use Error to tell the caller what went wrong,
>>> and it's the caller that then gets to decide whether they
>>> want to print an error and exit, tell the monitor about
>>> an error, or just continue to try something else instead.
>>
>> In that case, maybe we can have 'load_image_targphys' take an 'enum
>> LoadError*' ? Caller can pass that argument if interesting in handling
>> errors.
> 
> We have a standard way for functions to report errors with
> useful human readable strings attached. That's Error.
> We should just use our standard approach if we want to get
> better error messages here, rather than inventing an
> ad-hoc new thing.

Hi Aditya, Vishal,

Please see below commit for reference (there are many others doing 
similar work though):

commit aa77746602cdf7e29d588d100e27f34bd6e46226
Author: Arun Menon <armenon@redhat.com>
Date:   Thu Sep 18 20:53:39 2025 +0530

     migration: push Error **errp into 
loadvm_postcopy_handle_switchover_start()


Thanks
Harsh

> 
> thanks
> -- PMM


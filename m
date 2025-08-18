Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAE0CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 15:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo1Ng-0002QX-Dh; Mon, 18 Aug 2025 11:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uo1Nd-0002Q9-UL; Mon, 18 Aug 2025 11:02:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uo1Nb-0000Er-Bb; Mon, 18 Aug 2025 11:02:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IBDG4x004808;
 Mon, 18 Aug 2025 15:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=RD8q5PubOWEBbkBZOk/N9/kLD17r45VxzPz1ileX7Y0=; b=QYlVENw6EYj6
 wSSFCBBiPgxcRUhg3hUTZO8XnJoGLoYJl1spyCQ7JBjcHq53dYmkYB4M2n9pkghH
 5qxWrTjFOesO/lxiuS3ubmi0vHn7/NvCNVF/YXGdKCWKT6pLFWPQVp/zuhNFPpNj
 DHlzW92wMPblGZ9S0bGE1jodfxWj9PiDkfimnLC3bVvg2z5KI9l5BOAjgl2AiaY2
 Y6vd0qBsw94N1g3346zLvYFyeCn2Aiy4/gga/26GdlX9cGzANR68+nXlCWUN+muJ
 1F1Uu2tfdK8OKueIAXCEtXjLzI6MGtJG/RCKx9gBBBsWWO2eJ6jhoH49vZzrLncH
 Gi9M0IkVfg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3sn0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 15:02:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57IEpDc7012957;
 Mon, 18 Aug 2025 15:02:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhn3sn0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 15:02:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEpsM3014715;
 Mon, 18 Aug 2025 15:02:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48k5tmp7th-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 15:02:30 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57IF2TW830868100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 15:02:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B2B058054;
 Mon, 18 Aug 2025 15:02:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B04995805C;
 Mon, 18 Aug 2025 15:02:28 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Aug 2025 15:02:28 +0000 (GMT)
Message-ID: <018ca7f3da5e0d95f175291bf1825b3991d792a7.camel@linux.ibm.com>
Subject: Re: [RFC 0/3] Add IBM PPE42 support
From: Miles Glenn <milesg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 harshpb@linux.ibm.com
Date: Mon, 18 Aug 2025 10:02:28 -0500
In-Reply-To: <fe4e09ca-52bb-4af9-9a0b-49aac54d2a37@redhat.com>
References: <20250814223741.29433-1-milesg@linux.ibm.com>
 <fe4e09ca-52bb-4af9-9a0b-49aac54d2a37@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Z1eIL7Q_5MLYadHeJX4u12lTR_aKv4T
X-Authority-Analysis: v=2.4 cv=L6wdQ/T8 c=1 sm=1 tr=0 ts=68a34087 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=lvhskjxYYig5buZalUYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P4L6WpizyMHm4NKc_cLXySH_LxT9ScrR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX7KpSSeP/3OGt
 1ZlpFLvb3ZxrdCEEKAvJZi0PQMAyBw090LVu6p1beyblEtTXdLU1CzmI9UMd7iD1x/X0FTBPH1V
 x4aZ2B+b07yNEdZvKNExSEtl/PmtVEDoQQ9L8wT/ZIx5JFfIfkDwEE87pmepRVaxstWDhyjfzVD
 rsc9zvN7Zw5SfR3RHByQ2gWhRL7Xqz9L7Tb6N3MKO3kfGlEdgWusr7rkMwV8c6+ffu7uyaaCwPY
 um89IByK/wE8HuS/CNY3b6mphJzu1lScPwWDUqzPuUXzSRDAPu+sN9q0733605WvUcWbWE6JH/O
 dp+1eww5VwEcbPj9DSS+w3098QxxMd7JgrpJ/tqH0sBySYpRinuujA97DzoNHT/ShhBCX6/Heu1
 wLki7MfJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2025-08-18 at 09:48 +0200, Thomas Huth wrote:
> On 15/08/2025 00.37, Glenn Miles wrote:
> ...
> > I have some code that tests the instructions that are
> > specific to the PPE42.  It is a very basic test written
> > in assembly.  This can be found at:
> > 
> > https://github.com/milesg-github/ppe42-tests
> > 
> > There is also a prebuilt image there in the images
> > folder.
> > 
> > Building the image requires a forked version of an old
> > version of GCC, which can be found here:
> > 
> > https://github.com/open-power/ppe42-gcc
> > 
> > Even though everything that is necessary to build the
> > image is publicly available, it is not a simple task.
> > This is why I think it would be best to just use the
> > prebuilt image available on github instead of trying to
> > build it.
> 
> With the compiler being not available in the major distros, the idea with 
> the prebuilt image is better indeed.
> 
> > Also, there is currently no support for having console
> > output (this is also not supported in the actual HW).
> > All logging on actual hardware is done using in-memory
> > trace buffers that requires a special tool for translation
> > to a human readable format. Because of this, I'm thinking
> > this is not a good candidate for using the QEMU
> > "tests/functional" framework, which seems to rely a lot
> > on console output.
> > 
> > I do think it would be possible to use the qtest framework
> > to load the image and run it.
> > 
> > The existing test will cause a checkstop if it fails.
> > This leads to dumping the cpu registers, which aids in
> > debug.  There is currently no way to tell that the
> > test completed, other than checking the NIP address,
> > but this could be easily remedied by having the guest
> > code write some status to a fixed memory address and
> > then having the qtest code poll that memory address
> > to determine that the test completed within some reasonable
> > timeout period.
> > 
> > The one thing that I'm not sure about with using the
> > qtest framework is how to retrieve the image. If anyone
> > has suggestions or examples of that being done for a qtest,
> > please do share!
> 
> The qtest framework does not have any support for downloading images. I 
> think you're way better off using the functional framework for this. The 
> console output is just optional there, so if your image does not have any 
> serial console output, there are still other means of checking for success.
> 
> For example, if you can be sure that a successful test always ends up with a 
> certain NIP, you could use
> 
>   output = vm.cmd('human-monitor-command', command_line='info registers')
> 
> to check the current status of the registers and check the NIP there.
> 
> And assuming that a checkstop will cause a QMP event, you could likely also 
> use one of the event functions from python/qemu/machine/machine.py to check 
> for a failure while waiting for the right NIP.
> 
>   HTH,
>    Thomas
> 

Thanks for the tip, Thomas!  I will give that a try.

Glenn



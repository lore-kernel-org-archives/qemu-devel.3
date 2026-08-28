Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED875C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpbf-0002Kp-E4; Fri, 28 Aug 2026 01:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wzpbd-0002KY-SH; Fri, 28 Aug 2026 01:58:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wzpbc-0007YY-Cy; Fri, 28 Aug 2026 01:58:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S238TB515920; Fri, 28 Aug 2026 05:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=3UEvI46F3ibWvqFVFVhuT+GTlW6Ypb
 fklVTC4SYeCHI=; b=KGi53a3hrvZSCNq6piKdNt8NkmR4jwV5HLpyuIwXWjmTEx
 Por8pPBl6bQDcxFIZrNjRU+3bECNLlhWxgHfM09rBMxIvos7/ZFsa8g9IFjUIZUS
 u+K1WqnnLy3LEeIPbnEg5ZnPgAL1tppzudxaJIzwecS6BWxNxfCtE7Ri820oMkPl
 XLQ5lo2W8k1P7Ul78ImaKDYlfBey2pFCV409a0k5tGMnjkAoh75IJ3s4gizHMdSA
 g7P0xPzUiMHyPl95IEGswZgIABhhuOphBgQ8Syd6YuU+4AJp5T8yIJDJm4T595/A
 ZBlBhOOCCWqSoIZryavbcTVy20eenTXLKBkZkojg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jac2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 05:58:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uFZ5025820;
 Fri, 28 Aug 2026 05:58:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwmne1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 05:58:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S5wFTb29754008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 05:58:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6AFF20040;
 Fri, 28 Aug 2026 05:58:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2146520043;
 Fri, 28 Aug 2026 05:58:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.87.138.120])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 28 Aug 2026 05:58:13 +0000 (GMT)
Date: Fri, 28 Aug 2026 11:28:11 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/pci-host/pnv_phb4: fix guest-triggerable abort on
 8-byte config access
Message-ID: <apEjBVmbFW5lPkWf@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260805090530.1333997-1-nikhilks@linux.ibm.com>
 <501df67e-28d0-4630-b98a-769abb41086b@oss.qualcomm.com>
 <c21c72fc-672a-4674-a8d6-0b999502b4ad@linux.ibm.com>
 <19c3ff9e-6559-491d-a3f5-b1786db6b9da@oss.qualcomm.com>
 <eb8f5972-e494-483a-b093-5d67f64f70f8@linux.ibm.com>
 <42ab3e39-1397-422d-92c4-7b3fe68bf8dc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ab3e39-1397-422d-92c4-7b3fe68bf8dc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA0NSBTYWx0ZWRfX87f8IknlTiZC
 JpMjKc0Yq5dCuUkbV5mhVKFPLV7IzyZS1zBk5wnWUaWFSBoEyJET+aeECW1eiCvDjvwz3l/DLXk
 wNGxMVtzgRlblY6TpERPtx7HviJohRY=
X-Proofpoint-GUID: oshU6yvrsD-Jb3XDcdKmotSwDf6TcJlZ
X-Proofpoint-ORIG-GUID: oshU6yvrsD-Jb3XDcdKmotSwDf6TcJlZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA0NSBTYWx0ZWRfX7xxYQAcEX/wd
 8f+VXVrKYWRQqdw9N1mRtfbts2ROpLobkL+16G0HiNww6d1HQnVLzMrLKjbjI8rltS+r/j78w92
 lLGj3rqgnTOMQ6uceda1rytZNxcpBua+ricnyF1QSxjdQOnrj2quedDCV1gXKZm361o5tfCTjCK
 cVRB8epWSqJYwm9N+MbwA+dJXrQqYHa7FnzYuEmWrUQFmbFhaBa/tLkimpfwBP3/vkmwKUgxHeZ
 lzRhLBxaOuGhYzPoSYsCH8bhzktqPR339wpsztwt0M1e+7e8m0gYdrc3oMrqA0gIPu26HZFOxKl
 8MudBk8NlwhvDqmsg1ebs0YeKZhwK/1Be9WCQanb3K1nngYHRyk3EOSHAgn2bM8XT7nbR1fa/mB
 KwJ+tRWnk1UCeAP3DwW28g/SuiAkgMakyyp9l88JL36Zk7EU+RJdQpxXK9hAiBkn0MPZ61oz4AF
 Xd9IZiRSILvNr9TivrQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a91237c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pJA4Uj_2UJBf7QTsHOoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

cc +harsh +philippe +ppclist

On 26/08/28 10:28AM, Nikhil Kumar Singh wrote:
> Hi Harsh & Aditya,
> 
> Since Philippe noted he has no objection to the minimal fix, let's proceed
> with merging this patch as-is to get the immediate DoS resolved in stable.
> 
> Moving the config window to pci_host_data_le_ops requires a proper memory
> region overlay split. I will take that up and send it as a separate
> follow-up patch.

Sure, works with me, thanks for the fix. For the patch:

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

- Aditya G

> 
> Thanks and Regards,
> ~ Nikhil
> 


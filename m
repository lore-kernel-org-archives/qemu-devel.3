Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20FDD5E147
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 13:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVUhg-0001L8-GA; Tue, 16 Dec 2025 08:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vVUhG-00018F-5n; Tue, 16 Dec 2025 08:02:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vVUhC-0004mE-CQ; Tue, 16 Dec 2025 08:02:32 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG07rRO012092;
 Tue, 16 Dec 2025 13:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=5rAP7ge4knsM43U8caiXLWqJNp8wqE
 KtGo8C4H0D41Q=; b=AR532jU4OCv5Ml/m/LOTeOyXXRUZ1VNFaKfLQn+yyuuf1p
 L0NAIZ6Om/qIDX3xhGwBYHQ7zOhc9bDTtS4k9UwPrnZtB1kdjG8svFK5Xqbhp6lw
 Ns1J/Ig+zv4raMcc2g1ThqNiYu6lT68gY/wKxhqicCyDeWmplwEQ319QYTJtuF0q
 gB8bgA8Jka1vcFKWhOdSy1U2dA6sFEj0+krHx0FZ9V0wRBAlCRhPc9vKrcEAsx7P
 WHMV+6E9jmadQjjMNR4pl9JWraMxhePHWACiYthtmIw3dH6WLBY/tVXfKGgx+tVE
 z4QYbzS3oQiLWTObhGVbxvGzp61cBbWBPF5ODoLw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkxjhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 13:02:27 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGCwGmu018290;
 Tue, 16 Dec 2025 13:02:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkxjhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 13:02:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG9iDGi012800;
 Tue, 16 Dec 2025 13:02:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juy4a3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 13:02:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGD2Lln58458516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 13:02:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D11412004D;
 Tue, 16 Dec 2025 13:02:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E46D320049;
 Tue, 16 Dec 2025 13:02:19 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.209.67])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 16 Dec 2025 13:02:19 +0000 (GMT)
Date: Tue, 16 Dec 2025 18:32:18 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Subject: Re: [PATCH v2 0/7] hw/ppc: Snapshot support for several ppc devices
Message-ID: <dwzcnabnk3o6ikntfuzol3hhyec4xfbtovkdzgjqcwqlfem4e5@c6toidxmsqzf>
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215171813.1670241-1-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bl7hK9-pZ9XEhXz63j2tbQyGRT3l30ob
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=69415863 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=9s4DPD7zuaek111ihuUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: DEB3mBBp9iuwfYqAa77YVizTJvxW6mGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX5lrz92rbn3Yt
 YmED5H2Cvy1FEHKmdPdFmyDDxV09QxwQxILYmrYLjDZHuEJo51uFK6WOBP3udnIHNWAkLsaYP2o
 0EBPX0FmBp+33NJlPc/rRh2IfDTe9/rUY2sbEYjPPI/5KL8aFI9pQLdhKg62KA4ozsGHGQpX37I
 vKZyRODHToS1fSmu6RYmmkLEccl6E9vjM7khvTKU8R3+j278x8Z5eW29Z//YCEDEU3+SpXj72lm
 pEmC6jmKn8uJcQfkofqRRIw5kFxW0k9O/BZ7VEBVA1c//7Jm6PhZFFOW/lfvvecpaqYI33e8wEG
 aWyuooDk88Y8TPzMrqa0Mbk8X00VFG+27ylkPNimJPDGKDgHuX4JQdzJnlLXni1z63ePNPzEEfe
 MIlyW4ffmyGWOqluK5mH2jRQ+BqDFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/12/15 11:18AM, Caleb Schlossin wrote:
> Addressing comments from V1 review:
> 
> Updates in V2:
> - Added new patch set for PnvPsi support as it fits with the rest
> - Added vmstate support for Power8 and Power9 for LPC
> - Fixed pnv_core.c commit message
> 
> Tested:
> passed make check

Looks good to me.

Had one comment in PSI about #undef. With that sorted:

For the series:
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G



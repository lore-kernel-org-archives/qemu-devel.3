Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03427C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXklH-0006tq-9H; Wed, 07 Feb 2024 11:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1rXklD-0006tc-P5
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:26:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1rXklB-0003le-9u
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:26:55 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 417G2NUH030828; Wed, 7 Feb 2024 16:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rUb3FcMzuYRxe8g/qvn766zgWDWSXzicqWs4WSPiBcg=;
 b=o0ZLeWvJ+OMBUDMo8E7Vl3qp4nWc5AzwZWrTpRiOY4wHpy9HCV6+Ve7USykdXo8DOPJ8
 R6K1HScByZNk7dTXIztRyw6Xrf/Ub0DTn4WszQIJwaC4PAAIi7sspzuqqV9RxD4voPMn
 8E+6Jb1vPH95qvSnyawPEkJLTBywdLqhKCTMD24i2ckVypqkXgnEZV7U9ZtP8TRLqP+5
 ALBFyngHS0xWqnylgEX+VgY1fUrBbcTumgPoepI+E1lDkh71uZKtMRW/jXa8pR76q8Jk
 IJLFCAuIWB7Sc4gVbRqnfOo7+sL57Odv/qQV2d9NDXwpvcXDuwzFc8hsDKPb4zsRoUI5 Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4d1drqyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:26:48 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 417GPW9R018032;
 Wed, 7 Feb 2024 16:26:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4d1drqy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:26:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 417Du0ik005417; Wed, 7 Feb 2024 16:26:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akpn8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:26:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 417GQiU128836360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Feb 2024 16:26:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7438C20049;
 Wed,  7 Feb 2024 16:26:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5324A20040;
 Wed,  7 Feb 2024 16:26:44 +0000 (GMT)
Received: from [9.152.224.222] (unknown [9.152.224.222])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Feb 2024 16:26:44 +0000 (GMT)
Message-ID: <bf670821-38f3-463f-8ca8-118c520cd150@linux.ibm.com>
Date: Wed, 7 Feb 2024 17:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/39] tcg patch queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20240206032151.174516-1-richard.henderson@linaro.org>
 <CAFEAcA-HOfLk9RHQpR40xz98V5r7cG5Me7_Y=1ZSoFPpHXudWw@mail.gmail.com>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <CAFEAcA-HOfLk9RHQpR40xz98V5r7cG5Me7_Y=1ZSoFPpHXudWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wCrHmONLnj10wQ_Di0R2XhRvwWI99vgD
X-Proofpoint-ORIG-GUID: CWxgS5cpEF9IiqtG0hpDxqNrGtItBvC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_07,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxlogscore=806 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070121
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 06.02.24 um 22:24 schrieb Peter Maydell:
[..]
> Christian: this is on the s390x machine we have. Does the
> VM setup for that share IO or CPU with other VMs somehow?

Yes it does, this is a shared system. I will talk to the team if there is anything that we can do about this.


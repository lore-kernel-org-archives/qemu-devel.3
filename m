Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B452CA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 07:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoGmZ-0006cE-Ni; Tue, 19 Aug 2025 03:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uoGmT-0006ZN-Sf; Tue, 19 Aug 2025 03:29:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uoGmR-0007hd-9E; Tue, 19 Aug 2025 03:29:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IKjfER003035;
 Tue, 19 Aug 2025 07:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5lmCDN
 2X76jb8cQx0OlhpD7N7hJV+N+lqZRulF0Nk9U=; b=KUgcNExt1ca+7mlU9Nmep3
 wfWtzviJQc05ZY1ADKy5E2PzRGUlBUfWW9/g7DkF3iNAxt5ccWVzse+kuIi1X7pF
 k4130T9jtpu+NzkHWUKifA9fLAqnzePQzF003KjmvkBHFblpLIJoldUmepB8ieXE
 wq7LsZz+8On0ZNx/MI3Y2mGH/8/i2B3Ey0yYUFDdHZA9E7pa9kU6KwzfziCwRcdW
 9HdEzPtXy8/vcdWBHWOktdlDVpVROlkkHA7ol0DbVSeGP509eQVU/CDDp6i5ABwS
 Ua1U1QnAY1ntdgKNxXfWHM150x28lppbxUF5H/760uZQN+L80Dv+4Oaxw6xk1+IA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9wfgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 07:29:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57J79Iju006200;
 Tue, 19 Aug 2025 07:29:09 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9wfgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 07:29:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J5pAFN002750;
 Tue, 19 Aug 2025 07:29:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k6hm9216-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 07:29:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57J7T8q015467200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 07:29:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0289658061;
 Tue, 19 Aug 2025 07:29:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B65C58058;
 Tue, 19 Aug 2025 07:29:05 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Aug 2025 07:29:05 +0000 (GMT)
Message-ID: <fc6a4a14-1336-4b18-97fd-6426bb3a0960@linux.ibm.com>
Date: Tue, 19 Aug 2025 12:59:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/xics: Add missing call to register
 vmstate_icp_server
To: Fabiano Rosas <farosas@suse.de>, Fabian Vogt <fvogt@suse.de>,
 Gautam Menghani <gautam@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, peterx@redhat.com
References: <6187781.lOV4Wx5bFT@fvogt-thinkpad> <87zfbwvx39.fsf@suse.de>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <87zfbwvx39.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N50pF39B c=1 sm=1 tr=0 ts=68a427c6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=f7IdgyKtn90A:10 a=69wJf7TsAAAA:8
 a=Dks-dD9UBu4yhLIPhJEA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX98fDTQZtVCWF
 MfjhZm4tSS50YSJP9JRxLvcfoJCPDaSsmcFxUWYS7gs/wjbmsxnji6xM1L+br68PWduMcsm2377
 jrDmc43ogWM3mXwhOJ3g+mw7DNS8ubvo0mBJlEAo/b/Vwnx8wl4lgZRfQJhScRlR3bUnf986wx/
 UJfCmQFd+lmfuEvEYSakE4u0OClaJu39EyVj6oWUxdOJ8/j80n7IlgwLsYvPc6JQ8wsUJDIttjA
 Zgu3VPJTj7KXv3J3Yv+3gin/FHn+NC+U5vu30NVrPCTco4UCeEB1HwLfr2x3nAEuZClTpmUH9GS
 5rab8LsiYyiBwqD94+cQG58vn0cctuMcG3TcIqNjZW/wflDA3JFpdZm+UpwtrJIW5KB/SzqtmYr
 qvX3gG6g
X-Proofpoint-GUID: v9i26nkrSs4RbSNPmnGczzGz8x9vTPib
X-Proofpoint-ORIG-GUID: txrpmqw--4KXK2W6OFW1KeiwMrueByLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

+ Gautam, Glenn

Hi Fabian,


On 8/19/25 08:25, Fabiano Rosas wrote:
> Fabian Vogt <fvogt@suse.de> writes:
> 
> +CC Peter
> 
>> An obsolete wrapper function with a workaround was removed entirely,
>> without restoring the call it wrapped.
>>
>> Without this, the guest is stuck after savevm/loadvm.
>>
> 
> I'd note that this only affects guests that have actually negotiated
> XICS, so guests using ic-mode=xive are safe.

Since this affected only guests using XICS, would it be a better idea to 
mention this explicitly in commit log as well (?

> 
> With this patch, backward migration to QEMU versions >= 9.2 is
> broken. Which I can only assume is ok, since the hard break (vmstate
> gets rejected) is better than weird post-migration hangs.
> 
> If the PPC folks can spot a scenario where migration would provide
> reasonable results even without the emulated interrupt controller state
> being migrated, then we'll need a compat property for this.
> 
> Also, a 9.2 guest cannot move to a more recent QEMU version without a
> reboot. If this is an important scenario, then the new QEMU needs to
> provide some compatibility knob.

Gautam, Glenn - thoughts on above comments?

Thanks for the patch.

regards,
Harsh

> 
> Otherwise:
> 
> Acked-by: Fabiano Rosas <farosas@suse.de>
> Cc: qemu-stable@nongnu.org


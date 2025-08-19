Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B348CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNw8-0004n6-Qm; Tue, 19 Aug 2025 11:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uoNw5-0004j5-3O; Tue, 19 Aug 2025 11:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uoNw1-0003xy-Ag; Tue, 19 Aug 2025 11:07:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J8Mx3i015661;
 Tue, 19 Aug 2025 15:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=S5I/6C1HAFKIEnq9hndP5H8fxT/ik0FcZWGESTdW6RA=; b=eWvC7/ME4ExX
 snK/7g8wcXVl66apm2+hsKqCSYhFTrvEa/Y4tlb7Di8nZO+UBvxq6vCMB9Qb+xnB
 1W26TvFFtadiYRv1Uonhu1AU8pxweciqnysut839I0grBPPYQU9HxEqgXE0Gl93A
 6GLBhid77HZP54H+UazVfg3akPaZnZD0WwOTIgUNVY11nRPZr8/RTbbmBqS/AkrB
 GPMZBKi04i09B/Lr8EaE0VmlvsqqW5l+A8lKX91FXGif2RXq6hY8UKWS1VE84jZ6
 U6f3V36mP46SrnH9yGFFwj9oHvHGXOjEN/kMvqjvVCSjgAWuFn1o7OktR6NDmOow
 1nhKOCJ1jA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9yk5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 15:07:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57JEsmjT004488;
 Tue, 19 Aug 2025 15:07:31 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9yk5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 15:07:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JDKQBS011713;
 Tue, 19 Aug 2025 15:07:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k4auawu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 15:07:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57JF7TL432244432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 15:07:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8F3558063;
 Tue, 19 Aug 2025 15:07:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A5B65806A;
 Tue, 19 Aug 2025 15:07:29 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Aug 2025 15:07:29 +0000 (GMT)
Message-ID: <8c8ba4ac9f817d0d1a51684a8742627cdb4bc3c9.camel@linux.ibm.com>
Subject: Re: [PATCH] hw/intc/xics: Add missing call to register
 vmstate_icp_server
From: Miles Glenn <milesg@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Fabian Vogt <fvogt@suse.de>, Gautam Menghani
 <gautam@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, peterx@redhat.com
Date: Tue, 19 Aug 2025 10:07:29 -0500
In-Reply-To: <fc6a4a14-1336-4b18-97fd-6426bb3a0960@linux.ibm.com>
References: <6187781.lOV4Wx5bFT@fvogt-thinkpad> <87zfbwvx39.fsf@suse.de>
 <fc6a4a14-1336-4b18-97fd-6426bb3a0960@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N50pF39B c=1 sm=1 tr=0 ts=68a49334 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=69wJf7TsAAAA:8 a=t45X9u2Y8yns0VHvUQsA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfXxmCFB09/0yU4
 /REv4Rdb0bbSvjRzAuHqdCBXkPCG+5yk4KP2uU1NxQz8NFEVtCixLZiwqyH0jKbgZg82lWSDYcu
 cpKkjn7GhQ3nMiEpjw31PHro70GxTUM9czLR+Vv9PPc+8KE9/3wgNaIYmQ91vnwh7bNMYgfdCtW
 2fJ7F3nOyCx7wcuZ/Kvr7zdDG71/qidnYZUtW7Qg7feemptroCeKeXx0ZiI5G3bUrJyF4KQyZWK
 jcMRLz2s6Cmof2UvErC7gJ7vDNgw1WqwcAicd0SXZDg9ovSa7XzBEoSotltN+kDOz6DVXqvJKNv
 2Z9juZVNz0hVUk2fqHAcJpTCVvz/Lun8SLq4FHt7AMc+aGHNm7zOqzc+SZ0sId+CPxmtRVLvNDG
 RWmHFYVJ
X-Proofpoint-GUID: J3tbuF98jFxECi6NQbqDTTGR2tHMf9rq
X-Proofpoint-ORIG-GUID: jbrwBbjSlxtGtCjN6lCYzpq2j212Ak26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2025-08-19 at 12:59 +0530, Harsh Prateek Bora wrote:
> + Gautam, Glenn
> 
> Hi Fabian,
> 
> 
> On 8/19/25 08:25, Fabiano Rosas wrote:
> > Fabian Vogt <fvogt@suse.de> writes:
> > 
> > +CC Peter
> > 
> > > An obsolete wrapper function with a workaround was removed entirely,
> > > without restoring the call it wrapped.
> > > 
> > > Without this, the guest is stuck after savevm/loadvm.
> > > 
> > 
> > I'd note that this only affects guests that have actually negotiated
> > XICS, so guests using ic-mode=xive are safe.
> 
> Since this affected only guests using XICS, would it be a better idea to 
> mention this explicitly in commit log as well (?
> 
> > With this patch, backward migration to QEMU versions >= 9.2 is
> > broken. Which I can only assume is ok, since the hard break (vmstate
> > gets rejected) is better than weird post-migration hangs.
> > 
> > If the PPC folks can spot a scenario where migration would provide
> > reasonable results even without the emulated interrupt controller state
> > being migrated, then we'll need a compat property for this.
> > 

I don't know much about the XICS controller, but migration without
restoring the interrupt controller state seems pretty risky to me.  I
wouldn't recommend it.

Glenn

> > Also, a 9.2 guest cannot move to a more recent QEMU version without a
> > reboot. If this is an important scenario, then the new QEMU needs to
> > provide some compatibility knob.
> 
> Gautam, Glenn - thoughts on above comments?
> 
> Thanks for the patch.
> 
> regards,
> Harsh
> 
> > Otherwise:
> > 
> > Acked-by: Fabiano Rosas <farosas@suse.de>
> > Cc: qemu-stable@nongnu.org



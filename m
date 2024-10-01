Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B05CEACDB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveAn-00048n-Mx; Tue, 01 Oct 2024 10:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sveAM-0003CI-Qa; Tue, 01 Oct 2024 10:47:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1sveAK-0004a9-GH; Tue, 01 Oct 2024 10:47:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4917K5xD007351;
 Tue, 1 Oct 2024 13:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 wkwuqj3xo0sDlDS6NaBJ9C76OarCygB0435fFUMPiIg=; b=bl4KMKz0Tvagt7wc
 9166E9Wlg2G0RWN0R0S7yXDrNpaOoIYtQvHvRSvPuRLLejKB8VkKR0sx90NoDW8D
 j7t588U4bLYmEsQ+W/Ff7knIexvEt5w/MNr4kYINSir/YqdAr0gVs3+40cEsgU0d
 tbwD0dFtQ0BYxpMtLjDS7ibmGJhyPT/Kox0FVbB2HkNiDWPNen0Szhfpm93+dBqV
 9QyuleqgNuVre0rfSCRWyQtrTlwTNrN86oKUFHYD5+VouwemSunDamlD51oJPWwr
 SbUUJxV1CiHYd9DdIJkrKa1+P5XszMw+113k5fyb6AChgC79U03s++PJynUTIE6X
 oOB0mA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckj9wch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 13:31:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491DVeYg025888;
 Tue, 1 Oct 2024 13:31:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckj9wcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 13:31:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491CK4KV017852;
 Tue, 1 Oct 2024 13:31:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mvmrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 13:31:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 491DVZBP52822412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 13:31:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 697A72004D;
 Tue,  1 Oct 2024 13:31:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C43520040;
 Tue,  1 Oct 2024 13:31:34 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.3.72])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue,  1 Oct 2024 13:31:34 +0000 (GMT)
Date: Tue, 1 Oct 2024 15:31:32 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v1 07/14] s390x/s390-hypercall: introduce DIAG500
 STORAGE_LIMIT
Message-ID: <20241001153132.08b0dca9.pasic@linux.ibm.com>
In-Reply-To: <972044f1-62e4-4ac0-8b24-e0bb78770309@linux.ibm.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-8-david@redhat.com>
 <6636c963-228f-4bea-87c5-bd4f75521c75@redhat.com>
 <20240927200525.5a90f172.pasic@linux.ibm.com>
 <10165d22-c3e8-4db1-9874-8b63ca59afe9@linux.ibm.com>
 <20240930145712.526a1c79.pasic@linux.ibm.com>
 <972044f1-62e4-4ac0-8b24-e0bb78770309@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YD0iDV6GFGEJoQVXxgep0y-yVGcVseEe
X-Proofpoint-GUID: Pc_q931itZ8Div3LZoIGkwSqd3n1Xv4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_09,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=735 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 1 Oct 2024 11:15:02 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
[..]
> >> So 500+4 should probably not cause any harm apart from branch prediction
> >> going wrong the first 2 or 3 notifies.
> >>
> >> 502 will make kvm_s390_handle_diag larger.  
> > 
> > What do you mean by this last paragraph?
[..]

> gcc has logic for switch statements that decide about branch table or
> a chained compare+jump. I think due to spectre gcc now avoids indirect
> branches as much as possible but still a larger switch statement might
> kick the decision from inline compare/jump to a branch table.
> 
> I am not worried in this particular case this was more or less a
> "what could go wrong".

Hm, you did state that "502 will make kvm_s390_handle_diag larger". I
suppose now we agree that 502 would not make kvm_s390_handle_diag larger.
Right?

I understood that you prefer 500+4 over 502 because the latter would
make kvm_s390_handle_diag larger. Now that we have, I hope clarified,
that 502 would not make the switch larger, do you still prefer 500+4?

BTW your insights are very appreciated!

Regards,
Halil


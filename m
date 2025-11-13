Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C61DCD98DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 20:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJeBB-0002jF-RZ; Thu, 13 Nov 2025 15:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vJdvd-0000WU-HQ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 15:28:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vJdvZ-0006yF-A3
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 15:28:25 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADFV32d009088;
 Thu, 13 Nov 2025 20:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=J2oR07
 7o3g6sLTcg3wVZUV94ihgcNKVcW8kzXi4/+18=; b=D00fyVQ1gLWtmhx4khT89w
 IykIMNw8IA9wP9H0h+99Xj2uMyNJdcf02qma/C7uT9Dlwqs+sHmjAo440OoJR8+i
 zbpnJqzyh/NYXev551GVgDDoVUEq63La/2nRpPEAxKvsIejq8l+J6RfNFIH/pq+f
 GfXrpBb0255Mb6sqkqVlD4W98y9Ggy3Mv3RxTIqTpNIrVWWB6znyKyHiTsUF4SgE
 0LLsiINeWdRHxNUEF/von2BPOV6PL+LuK7BzhgIbRvCNBTofDZfzJhjoifNwCvFs
 Sr37Cn/JO+DtQmwbVnQaNj8NyblOd1Q173cznwx1QEiFxJyoy90HaN1iaPxxsMlw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7jb9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Nov 2025 20:28:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADJ2XgJ014779;
 Thu, 13 Nov 2025 20:28:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpkfw0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Nov 2025 20:28:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ADKSEf227918858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Nov 2025 20:28:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFA1758053;
 Thu, 13 Nov 2025 20:28:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E22A958043;
 Thu, 13 Nov 2025 20:28:12 +0000 (GMT)
Received: from [9.61.187.144] (unknown [9.61.187.144])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Nov 2025 20:28:12 +0000 (GMT)
Message-ID: <bb65bbe3-37b3-4e79-b662-82d33852e33b@linux.ibm.com>
Date: Thu, 13 Nov 2025 15:28:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 37/45] migration: multi-mode notifier
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Cedric Le Goater <clg@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-38-peterx@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20251003153948.1304776-38-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfXzs8BWDc9FSmY
 op/4mSAjZVjQxOzeyp06cfWVpGrzaVu1UVxkTQzvERYoVprUjRobAQ798ke00rTrDb3XGb2a3/6
 J1aeUm3VRkzhfn6M39vKPcQNEyBflF5i75eUg88mCKScU+FdMdI9iqt2/5Q7G3SgMq5JgzjqL9B
 yQs75JJ7y+auFyDSQ+aTDz+IS4wj9Iw6Ry1tXxrleTLe0ArPPPiccaIbLFD9/kUd1qVZIXZ9Jn7
 gtiST0qbl+QDL3+TDRYJjaSJIj0KpdTaFozmt0shT/Acq3qXLjip1NBe3dqOzMjP4p1ONva1D8A
 XT7fqNAYxEc+FB3/h2XlpJBQe2VpUuQJJd+4g3ZNv7vNbxKi4B/ABzLp+Zc9KeVco/RkYTz0pYI
 u3QB1Yf+9AbVehNAxBboPSQB1Y3AFQ==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69163f60 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=mSj3SbOExz9NMja2UvgA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: cpYC78q2Q57tTMaopJOfKwJu0PMbJZGi
X-Proofpoint-ORIG-GUID: cpYC78q2Q57tTMaopJOfKwJu0PMbJZGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 10/3/25 11:39 AM, Peter Xu wrote:
> From: Steve Sistare <steven.sistare@oracle.com>
> 
> Allow a notifier to be added for multiple migration modes.
> To allow a notifier to appear on multiple per-node lists, use
> a generic list type.  We can no longer use NotifierWithReturnList,
> because it shoe horns the notifier onto a single list.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Link: https://lore.kernel.org/r/1759332851-370353-2-git-send-email-steven.sistare@oracle.com
> Signed-off-by: Peter Xu <peterx@redhat.com>

...

>  void migration_remove_notifier(NotifierWithReturn *notify)
>  {
>      if (notify->notify) {
> -        notifier_with_return_remove(notify);
> +        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> +            migration_blockers[mode] =
> +                g_slist_remove(migration_state_notifiers[mode], notify);
> +        }
>          notify->notify = NULL;
>      }

Hi, we started noticing occasional crashes on detach of vfio-pci devices on s390x.

The pattern we used to reliably hit the issue is to attach/detach the same hostdev to a guest; crash usually happens on the second detach, sometimes the third. 

I did a bisect and it points to this patch.  This code isn't my area of expertise, but the change above looks wrong.

I tried the following diff and it resolves the crash for me at least:

diff --git a/migration/migration.c b/migration/migration.c
index c2daab6bdd..9e787749b2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1693,7 +1693,7 @@ void migration_remove_notifier(NotifierWithReturn *notify)
 {
     if (notify->notify) {
         for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
-            migration_blockers[mode] =
+            migration_state_notifiers[mode] =
                 g_slist_remove(migration_state_notifiers[mode], notify);
         }
         notify->notify = NULL;



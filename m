Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF225EDEBE3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUNW-0007x1-PD; Tue, 03 Mar 2026 13:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vxUNT-0007wO-Va
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:21:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vxUNR-0004x6-MT
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:21:51 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623ERi9R856129; Tue, 3 Mar 2026 18:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=yoPsxeUJs8SBTPp7K2AKooNsWxZCvK
 dY0ekocBbd0k4=; b=blkXltntETm9y6HQo7zd0SFm6ayDSnewIIMP3Bc3B4UQxy
 /nnHZBAZAosZfYqYvmn/8DR/ijlbzCp4u+iX322pOH6rv1S+6X+Z6fc3/Db3Pkk9
 llpV2jyezDuGy0EgshfuY3LLT9xQdvM3j4rWdRI7Vzxj7D7GAyw/TMBi3O/TDDY5
 NP9g/MiZ9sQGDD3w8LIBBTOq/cZae8dhBEKBOw062HfbSb3OK8I+nsVckdPMlmm/
 E2tlhZM+Bvz9b8ykAUBRNZ95cA1l1bSw3u5O4vcSprJdKdbMMa19jSon5xDUGCaz
 ZHRZhItP8pcMtOKziS2bi3JU5V+COkoDLa2MVAhw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbv04v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 18:21:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623HdOdG028952;
 Tue, 3 Mar 2026 18:21:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaps3nuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 18:21:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 623ILflq49873236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2026 18:21:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8213320043;
 Tue,  3 Mar 2026 18:21:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45E2420040;
 Tue,  3 Mar 2026 18:21:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.210.232])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  3 Mar 2026 18:21:38 +0000 (GMT)
Date: Tue, 3 Mar 2026 23:51:35 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, berrange@redhat.com,
 peterx@redhat.com, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] tests/functional/ppc64/pseries: Remove custom
 migration routine
Message-ID: <aacmGFEulGJA47nI@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260303173320.10942-1-farosas@suse.de>
 <20260303173320.10942-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303173320.10942-5-farosas@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: E6F1uK5-zMvdjJSb14NL6uPbNRlIv2IZ
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a726ba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=3uas-pzL17UqV6fx6mkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NiBTYWx0ZWRfX7sQOhN3WGhXd
 EmPZavJVnSHADK/HKc+4IQvE/sJAYGF3dPRC/kYS3WdDoErn8XPDSjOkeAw+UTbv9UK0d5qRxkp
 2N8gcfwzv5Hx5gt9wGRsPgCANmBS612JqdC8iFShzO5sbqdzGgZdJmCU8bbgumtHdEutbmBybXZ
 8Z1AZjVxqh2kohk2/+XqjlEKA1HZ4Qf37Y6cIfuJM2DNP5DbiKB6UJ5GT+H975ebkuMlx1OdjN/
 cE3XaVaqWRmzWfgRn1rx5B49GUW/y5xv4/grhC2CrrGCsEcPaYV1tCJkB8ghox+9QnuvfE/sxDX
 4hdu29DGMMfYttpkPZEhSJPiZSFg3MueBRyUcUBZGfuQE/lZ4ptAES1YnmToyWX6591fpk+87M5
 jPEdGwUuL4cOobt7fUIMFLRy6n2MvWdgXWX5wlb+zwlUQ1tq7QT6/qS6YJQBbg5ozB/Zt0YZ6e+
 ir/HVn16xZ9Al4iJsZA==
X-Proofpoint-GUID: VBJc4ZrS5A6pNktBvoxZjJoISYAXPGS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030146
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 26/03/03 02:33PM, Fabiano Rosas wrote:
> Don't implement a custom migration routine at PpcMigrationTest and
> instead reuse the generic one from MigrationTest.
> 
> This removes the dependency of PpcMigrationTest from
> PseriesMachine. Having one test import another causes unittest code to
> instantiate the imported test, resulting in the setup and teardown
> methods being invoked for the imported test class, even if no test
> from that class will be executed.
> 
> If run in parallel, the extra setup/teardown methods that result from
> importing can race with the ones from the actual test being executed
> and cause the following error:
> 
> File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
> shutil.rmtree(self.workdir)
> ...
> FileNotFoundError: [Errno 2] No such file or directory:
> '<SRC_DIR>/build/tests/functional/ppc64/.../test_migration_with_exec/scratch'
> 
> The PseriesMachine class is changed to inherit from MigrationTest so
> both the migration routines and the class attributes of PseriesMachine
> can be accessed without the need to instantiate another object.
> 
> Fixes: f4e34d0fd5 ("tests/functional: Add a OS level migration test for pseries")
> Reported-by: Aditya Gupta <adityag@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I don't see any issues with the tests now, and able to run them
parallely, thanks for fixing it !

Tested-by: Aditya Gupta <adityag@linux.ibm.com>

>      timeout = 90
>      KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
> @@ -116,11 +116,11 @@ def test_ppc64_linux_migration(self):
>          wait_for_console_pattern(self, console_pattern, self.panic_message,
>                                   vm=source_vm)
>  
> -        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
> +        self.migration_with_tcp_localhost_vms(dest_vm, source_vm);

nit: the ';', can ignore though

Thanks,
- Aditya G



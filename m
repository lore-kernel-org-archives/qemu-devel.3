Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E68D74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIIT-0001rl-EH; Fri, 23 Jan 2026 09:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjIIR-0001oK-MW
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:37:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjIIP-0002Vq-IW
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:37:59 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NE6TGL028553;
 Fri, 23 Jan 2026 14:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=Fvl2DjatW/86ucnVsTEkrTmy1SXY
 JrH4r2mSKEQUl4k=; b=FFFPG6ZL+hljEgfVy1Otw8iEY1GRMfB6XaF/5lhgDZRR
 h+dAMeYjiEIYfQ/cijHmgpU/KNxQU1vkjuafzJEJ4kiErIl84USnSHsqQlPB022E
 zhDot25dzIODyXtTdkPYr7GE4ccsqXd8y7QKEcC8MXZ8jIkM+hbGNy+JS20NZ9gd
 gTLWKagIz3L9UZWCiL8/iJLSPDV4x2y0JrP17/Ui8jbmDf1PIUArC+cBJdKf1bap
 QucA6R1tFPwPkXFbbKEzotxgWKNmxH8zxlNsEgNDbVkDT6UwFry9F0F+kVnRndAW
 w00nkxvte1k+CSjDDIxkJU1DTVoqSTLtM8ikMkHjrQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60f44ps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 14:37:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NDjRZC024614;
 Fri, 23 Jan 2026 14:37:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxas7vp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 14:37:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60NEbpLM31064506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jan 2026 14:37:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EA4920049;
 Fri, 23 Jan 2026 14:37:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41EDE2004B;
 Fri, 23 Jan 2026 14:37:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.49]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 23 Jan 2026 14:37:49 +0000 (GMT)
Date: Fri, 23 Jan 2026 20:07:47 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [REPORT] Double deletion of output directory in functional test
Message-ID: <aXOGKb88Yho2jb_o@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=697387c2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fbgizQ5cNnc3LavnoDgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hZpqg-h6vMccQFkaC5gAhIZk628CALZJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDExNSBTYWx0ZWRfX4vQMKfQ6J7Mk
 h5ZsklezMFhFyrnV22qWf3sj3kXqaR5zAN/ZseOQ4Vc3z5ArH6st7jzTkdMmIZzfs5+H76xcBNh
 WIbEVDuVObrbJfYUcxyUPSrfz+TnvPZbFAeqxf7Q+7y6FXbh9wid9/W1CeDCu7vwHY38b9pmHk0
 MOqk/Ugp4Daiog/MdCn9AKGUfmKlJIRYPQ0E1KizIU1xRwRUgsoL22c7WFw/4hfe7/h6MdQWq6f
 OvJYtlgHx2yQ3qb1PBju0xMN6hejSKKQAFkrg7YxYbJTq6/9wBzutd6Fo+9nlx4itJZdNpnoGHO
 u0cYE0Op5aNnglrkypPG4bFuMTIopju/+MR2slaKV4De3xMsmq1zZKcil+Xed4Cy82fdStQJW+4
 VZrlzKDo/GKVurge2OfeGJfOtP308OHQNQ2O8O9bGQWxqEkT8q55O0rrw1yBg1C+EwEz1LRqB94
 6nSjz3wqyf1bVUEmpBg==
X-Proofpoint-ORIG-GUID: hZpqg-h6vMccQFkaC5gAhIZk628CALZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Hello,

I notice a test failure with ppc64 functional tests, which only occurs when
tests are run in parallel ('make check-functional-ppc64 -j8').

I believe the issue might be with the generic migration testcase. The following
backtrace happens on error:

	Traceback (most recent call last):
	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 421, in tearDown
	    super().tearDown()
	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
	    shutil.rmtree(self.workdir)
	  File "/usr/lib64/python3.11/shutil.py", line 742, in rmtree
	    onerror(os.lstat, path, sys.exc_info())
	  File "/usr/lib64/python3.11/shutil.py", line 740, in rmtree
	    orig_st = os.lstat(path, dir_fd=dir_fd)
	              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	FileNotFoundError: [Errno 2] No such file or directory: '<SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_exec/scratch'

The core issue is that during setUp, the `self.workdir` is correctly created,
but during tearDown, the `self.workdir` is somehow already deleted, thus causing
shutil.rmtree to fail with directory doesn't exist.

Since this only occurs with parallel tests, I believe multiple subtests
are trying to remove the same dir ?

I haven't been able to figure exactly where the issue happens. Any ideas ?

Two possible workarounds:
1. `export QEMU_TEST_KEEP_SCRATCH=1`, this causes qemu to skip the shutil.rmtree
2. Have if condition (or try-except) around the shutl.rmtree to skip double
deletion issues.

Thanks,
- Aditya G

QEMU Commit Id: 2339d0a1cfac6ecc667e6e062a593865c1541c35

To reproduce issue:
	./configure
	make check-functional-ppc64 -j8

Log:
	$ make check-functional-ppc64 -j8
	
	>>> LD_LIBRARY_PATH=<SRC_DIR>/build/tests/tcg/plugins:<SRC_DIR>/build/contrib/plugins QEMU_TEST_GDB=/usr/bin/gdb PYTHONPATH=<SRC_DIR>/python:<SRC_DIR>/tests/functional MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MESON_TEST_ITERATION=1 G_TEST_SLOW=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 RUST_BACKTRACE=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 QEMU_BUILD_ROOT=<SRC_DIR>/build QEMU_TEST_QEMU_BINARY=<SRC_DIR>/build/qemu-system-ppc64 MALLOC_PERTURB_=145 QEMU_TEST_QEMU_IMG=<SRC_DIR>/build/qemu-img <SRC_DIR>/build/pyvenv/bin/python3 <SRC_DIR>/tests/functional/ppc64/test_pseries.py
	―――――――――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――――――――――
	stderr:
	Traceback (most recent call last):
	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 421, in tearDown
	    super().tearDown()
	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
	    shutil.rmtree(self.workdir)
	  File "/usr/lib64/python3.11/shutil.py", line 742, in rmtree
	    onerror(os.lstat, path, sys.exc_info())
	  File "/usr/lib64/python3.11/shutil.py", line 740, in rmtree
	    orig_st = os.lstat(path, dir_fd=dir_fd)
	              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	FileNotFoundError: [Errno 2] No such file or directory: '<SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_exec/scratch'
	
	Traceback (most recent call last):
	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 421, in tearDown
	    super().tearDown()
	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
	    shutil.rmtree(self.workdir)
	  File "/usr/lib64/python3.11/shutil.py", line 742, in rmtree
	    onerror(os.lstat, path, sys.exc_info())
	  File "/usr/lib64/python3.11/shutil.py", line 740, in rmtree
	    orig_st = os.lstat(path, dir_fd=dir_fd)
	              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	FileNotFoundError: [Errno 2] No such file or directory: '<SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_tcp_localhost/scratch'
	
	Traceback (most recent call last):
	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 421, in tearDown
	    super().tearDown()
	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
	    shutil.rmtree(self.workdir)
	  File "/usr/lib64/python3.11/shutil.py", line 742, in rmtree
	    onerror(os.lstat, path, sys.exc_info())
	  File "/usr/lib64/python3.11/shutil.py", line 740, in rmtree
	    orig_st = os.lstat(path, dir_fd=dir_fd)
	              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	FileNotFoundError: [Errno 2] No such file or directory: '<SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_unix/scratch'
	
	More information on test_migration.PpcMigrationTest.test_migration_with_exec could be found here:
	 <SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_exec/base.log
	 <SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_exec/console.log
	More information on test_migration.PpcMigrationTest.test_migration_with_tcp_localhost could be found here:
	 <SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_tcp_localhost/base.log
	 <SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_tcp_localhost/console.log
	More information on test_migration.PpcMigrationTest.test_migration_with_unix could be found here:
	 <SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_unix/base.log
	 <SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_unix/console.log
	
	(test program exited with status code 1)
	―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――



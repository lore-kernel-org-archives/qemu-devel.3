Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BF6C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 00:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX9Fw-0001mz-Q3; Mon, 05 Feb 2024 19:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX9Ft-0001mb-C7
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:24:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX9Fr-0003t9-Bc
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:24:05 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4160MJ4A025823; Tue, 6 Feb 2024 00:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=b5DDrymG6y6hoDXvZL54Cgzdaqfq/GvjB69xKDt3uAE=;
 b=CM1yYIrsx6cdZ3l42L0esYzMQul6Ld/joGIAmZt+yhtFDIX0HCTk9AI5DfpBtAOZOP2h
 iDs4HbcV1u5ATuJx2D5KwETn5NqhQRLPRVbto1AP9ytFFygffPzoHj/gjVCCs1nx+6Hq
 CdOKm3kMVYdcLJ2ENGjXfwqd8a8Hj8MgP35mJgxdHSlqvmJsNw91Ck4UHHm45QKTmWEX
 odo9TDPW8F7lPy8lKpme/SCNsCPfHCUBuB1fRW1U7PxuVGxCbspyNFyNccJ/o37FKj5u
 zkNFDkS/QQ5CR/QFz5fzEyDL2ylIYzniLkhHzqKY4JwdraRe+Zn7bxMq4khZzdynAPeA FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3a5n00x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:57 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4160NvbS029666;
 Tue, 6 Feb 2024 00:23:57 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3a5n00wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415LSC12016184; Tue, 6 Feb 2024 00:23:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h1u9vd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4160NsTH33816902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Feb 2024 00:23:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D6E720043;
 Tue,  6 Feb 2024 00:23:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FAB220040;
 Tue,  6 Feb 2024 00:23:53 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Feb 2024 00:23:53 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 4/4] meson: Link with libinotify on FreeBSD
Date: Tue,  6 Feb 2024 01:22:03 +0100
Message-ID: <20240206002344.12372-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206002344.12372-1-iii@linux.ibm.com>
References: <20240206002344.12372-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9xhiHaE8G1hRp09FCRAF30wKWnWA6H0w
X-Proofpoint-ORIG-GUID: CCzA9FhmBl0OyGswEa2r1B8G87yz9wnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060000
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

make vm-build-freebsd fails with:

    ld: error: undefined symbol: inotify_init1
    >>> referenced by filemonitor-inotify.c:183 (../src/util/filemonitor-inotify.c:183)
    >>>               util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive libqemuutil.a

On FreeBSD the inotify functions are defined in libinotify.so. Add it
to the dependencies.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 meson.build      | 23 +++++++++++++++++++----
 util/meson.build |  6 +++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index b5d6dc94a83..e5d6f2d057e 100644
--- a/meson.build
+++ b/meson.build
@@ -2367,60 +2367,72 @@ if rbd.found()
 endif
 if rdma.found()
   config_host_data.set('HAVE_IBV_ADVISE_MR',
                        cc.has_function('ibv_advise_mr',
                                        dependencies: rdma,
                                        prefix: '#include <infiniband/verbs.h>'))
 endif
 
 have_asan_fiber = false
 if get_option('sanitizers') and \
    not cc.has_function('__sanitizer_start_switch_fiber',
                          args: '-fsanitize=address',
                          prefix: '#include <sanitizer/asan_interface.h>')
   warning('Missing ASAN due to missing fiber annotation interface')
   warning('Without code annotation, the report may be inferior.')
 else
   have_asan_fiber = true
 endif
 config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
 
+have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
+have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
+inotify = not_found
+if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
+  # libinotify-kqueue
+  inotify = cc.find_library('inotify')
+  if have_inotify_init
+    have_inotify_init = inotify.found()
+  endif
+  if have_inotify_init1
+    have_inotify_init1 = inotify.found()
+  endif
+endif
+config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
+config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
+
 # has_header_symbol
 config_host_data.set('CONFIG_BLKZONED',
                      cc.has_header_symbol('linux/blkzoned.h', 'BLKOPENZONE'))
 config_host_data.set('CONFIG_EPOLL_CREATE1',
                      cc.has_header_symbol('sys/epoll.h', 'epoll_create1'))
 config_host_data.set('CONFIG_FALLOCATE_PUNCH_HOLE',
                      cc.has_header_symbol('linux/falloc.h', 'FALLOC_FL_PUNCH_HOLE') and
                      cc.has_header_symbol('linux/falloc.h', 'FALLOC_FL_KEEP_SIZE'))
 config_host_data.set('CONFIG_FALLOCATE_ZERO_RANGE',
                      cc.has_header_symbol('linux/falloc.h', 'FALLOC_FL_ZERO_RANGE'))
 config_host_data.set('CONFIG_FIEMAP',
                      cc.has_header('linux/fiemap.h') and
                      cc.has_header_symbol('linux/fs.h', 'FS_IOC_FIEMAP'))
 config_host_data.set('CONFIG_GETRANDOM',
                      cc.has_function('getrandom') and
                      cc.has_header_symbol('sys/random.h', 'GRND_NONBLOCK'))
-config_host_data.set('CONFIG_INOTIFY',
-                     cc.has_header_symbol('sys/inotify.h', 'inotify_init'))
-config_host_data.set('CONFIG_INOTIFY1',
-                     cc.has_header_symbol('sys/inotify.h', 'inotify_init1'))
 config_host_data.set('CONFIG_PRCTL_PR_SET_TIMERSLACK',
                      cc.has_header_symbol('sys/prctl.h', 'PR_SET_TIMERSLACK'))
 config_host_data.set('CONFIG_RTNETLINK',
                      cc.has_header_symbol('linux/rtnetlink.h', 'IFLA_PROTO_DOWN'))
 config_host_data.set('CONFIG_SYSMACROS',
                      cc.has_header_symbol('sys/sysmacros.h', 'makedev'))
 config_host_data.set('HAVE_OPTRESET',
                      cc.has_header_symbol('getopt.h', 'optreset'))
 config_host_data.set('HAVE_IPPROTO_MPTCP',
                      cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP'))
 
 # has_member
 config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
                      cc.has_member('struct sigevent', 'sigev_notify_thread_id',
                                    prefix: '#include <signal.h>'))
 config_host_data.set('HAVE_STRUCT_STAT_ST_ATIM',
                      cc.has_member('struct stat', 'st_atim',
                                    prefix: '#include <sys/stat.h>'))
 config_host_data.set('HAVE_BLK_ZONE_REP_CAPACITY',
                      cc.has_member('struct blk_zone', 'capacity',
@@ -4390,40 +4402,43 @@ if host_os == 'windows'
 endif
 summary_info += {'seccomp support':   seccomp}
 summary_info += {'GlusterFS support': glusterfs}
 summary_info += {'hv-balloon support': hv_balloon}
 summary_info += {'TPM support':       have_tpm}
 summary_info += {'libssh support':    libssh}
 summary_info += {'lzo support':       lzo}
 summary_info += {'snappy support':    snappy}
 summary_info += {'bzip2 support':     libbzip2}
 summary_info += {'lzfse support':     liblzfse}
 summary_info += {'zstd support':      zstd}
 summary_info += {'NUMA host support': numa}
 summary_info += {'capstone':          capstone}
 summary_info += {'libpmem support':   libpmem}
 summary_info += {'libdaxctl support': libdaxctl}
 summary_info += {'libudev':           libudev}
 # Dummy dependency, keep .found()
 summary_info += {'FUSE lseek':        fuse_lseek.found()}
 summary_info += {'selinux':           selinux}
 summary_info += {'libdw':             libdw}
+if host_os == 'freebsd'
+  summary_info += {'libinotify-kqueue': inotify}
+endif
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
 if host_arch == 'unknown'
   message()
   warning('UNSUPPORTED HOST CPU')
   message()
   message('Support for CPU host architecture ' + cpu + ' is not currently')
   message('maintained. The QEMU project does not guarantee that QEMU will')
   message('compile or work on this host CPU. You can help by volunteering')
   message('to maintain it and providing a build host for our continuous')
   message('integration setup.')
   if get_option('tcg').allowed() and target_dirs.length() > 0
     message()
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
 endif
 
 if not supported_oses.contains(host_os)
   message()
diff --git a/util/meson.build b/util/meson.build
index af3bf5692d8..0ef9886be04 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -87,40 +87,44 @@ if have_block or have_ga
   util_ss.add(files('thread-pool.c', 'qemu-timer.c'))
   util_ss.add(files('qemu-sockets.c'))
 endif
 if have_block
   util_ss.add(files('aio-wait.c'))
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))
   util_ss.add(files('hexdump.c'))
   util_ss.add(files('iova-tree.c'))
   util_ss.add(files('iov.c', 'uri.c'))
   util_ss.add(files('nvdimm-utils.c'))
   util_ss.add(files('block-helpers.c'))
   util_ss.add(files('qemu-coroutine-sleep.c'))
   util_ss.add(files('qemu-co-shared-resource.c'))
   util_ss.add(files('qemu-co-timeout.c'))
   util_ss.add(files('readline.c'))
   util_ss.add(files('throttle.c'))
   util_ss.add(files('timed-average.c'))
   if config_host_data.get('CONFIG_INOTIFY1')
-    util_ss.add(files('filemonitor-inotify.c'))
+    freebsd_dep = []
+    if host_os == 'freebsd'
+      freebsd_dep = inotify
+    endif
+    util_ss.add(files('filemonitor-inotify.c'), freebsd_dep)
   else
     util_ss.add(files('filemonitor-stub.c'))
   endif
   if host_os == 'linux'
     util_ss.add(files('vhost-user-server.c'), vhost_user)
     util_ss.add(files('vfio-helpers.c'))
     util_ss.add(files('chardev_open.c'))
   endif
 endif
 
 if cpu == 'aarch64'
   util_ss.add(files('cpuinfo-aarch64.c'))
 elif cpu in ['x86', 'x86_64']
   util_ss.add(files('cpuinfo-i386.c'))
 elif cpu == 'loongarch64'
   util_ss.add(files('cpuinfo-loongarch.c'))
 elif cpu in ['ppc', 'ppc64']
   util_ss.add(files('cpuinfo-ppc.c'))
 endif
-- 
2.43.0



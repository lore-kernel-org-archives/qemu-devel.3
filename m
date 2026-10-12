Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26B4CA9EC5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPuA-0005jZ-LZ; Mon, 12 Oct 2026 19:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu3-0005fU-93
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu1-0006Gx-Ck
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:59 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMiQQi2767894; Mon, 12 Oct 2026 23:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=8g5hC
 MLaziZjWn+8JMsZ3Y9zpfWMj7P/RzwSrO34/gY=; b=eFL43x2Uzp14XKwWZOl6G
 WWqg/brj2AfvXC984oymiGmJM5NLfy9zRcaGl3Fnt1CydoCZfdTuWJbrNH0UsUbn
 x/wNKQViYjlI/bxAw8EAC/ODwHnj3ZgQgnIM/SlN7L3YoJGnv6YqsmkW+pAfSEFh
 bHV6K0+vY5sxSDQrErZRG/3PcBqBRfk8zsYkvGMD+8pk1UvBzfubTkYk10bp0bOi
 WD14MzTOFwbd2728BQPzbRBlQuZMM2qz0rw9SQROHNhrROI/Uu0ksia7U9fvfItR
 JxZAyi4L5PZuvX4uOlsF52uHgkJOxxwQkR4JWQL9axh0pdT/Hdf7M4FuVbCvUqTm
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7ddgk6rs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpeAN015093; Mon, 12 Oct 2026 23:57:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:52 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHd025328;
 Mon, 12 Oct 2026 23:57:51 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-17; Mon, 12 Oct 2026 23:57:51 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 16/21] migration/cpr-luo: enable cpr-luo mode for target side
 retrieval
Date: Mon, 12 Oct 2026 23:56:12 +0000
Message-ID: <20261012235727.398133-17-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Authority-Analysis: v=2.4 cv=EeZd0/mC c=1 sm=1 tr=0 ts=6acd7400 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=JP3hYnA4LxdAF3hJH0IA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: UgPRK4MAM8Gb-43YjX7U4ykrcUZn-Iu1
X-Proofpoint-GUID: UgPRK4MAM8Gb-43YjX7U4ykrcUZn-Iu1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX2ICcz0a65YCC
 PuO1f2G3Gs32OejZ1h+Q8gCFMuqHE3vR51gSGz9q0MPspkN8bxheMbnPV2zFg4Rbs8cfmz5Ok0r
 TEAkya/LW38mDBsNxFhcYXcQqCBxcrF4bhJ/aXVLWRv+VahvlUUC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX9xkC1RixzgxK
 gu2FFg6NnGwkr49FSDcuWKkw7OizX3V79N/uRHk9Seiosd5IfosR3UNmxuaYBQRdokY4DdsGr8p
 y0NOrekTEvS7svkNA9EfRNMJ+HiJ+Ybib+YRJCaDV4wkZCDcayBsg3N0Z0AtREc/9XALRFFqcBB
 xw502Yqnmyesq5IZmIML7pUmhq+lVi0VuUnaSgQiTxutz/dt/Ygm9hJps+bFBZr7PdN+FjJOzit
 OySt3fFStXr6iXHo3BzwhP41j/z8r97A2QIGYPeHWZX7eoB+Ro2QVwshG6SP7OHWTXibtd1Q8bz
 ioZw5V2VJc6aUkkePrCYUcnza1SkqylVpLvgDSC2f4l7n9yF1f7R+mbnSCF4al7IvREL5sflo6L
 /3ly0e8eiRfgk3NmsRrhpLx2EJrh/jS1PB0XlOKWTYbC9uGJ44rK6DwuFucO4ySeh7NmHQDJbgi
 UTmBLJg1ahkx37j3CxhqKrf1fbwGjhPB+xsSAjmk=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As with cpr-exec and cpr-transfer, call the cpr-luo APIs to retrieve the
LUO session and its state memfd before device creation. After loading the
LUO CPR state, retrieve the preserved file descriptors by token.

Finish the LUO session after the incoming migration successfully loads.

Accept "-incoming cpr-luo:defer" for deferred incoming migration and
"-incoming cpr-luo:<URI>" to start an incoming migration immediately.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
The mode management in existing code may need cleanup. There are
duplicate cpr_set_incoming_mode(). There are unnecessary call of
migrate_mode().

 include/migration/cpr.h  |  2 ++
 migration/cpr-luo-stub.c | 10 ++++++++++
 migration/cpr-luo.c      | 35 +++++++++++++++++++++++++++++++++++
 migration/cpr.c          | 24 ++++++++++++++++++++----
 migration/migration.c    |  2 ++
 system/vl.c              |  9 +++++++++
 6 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 62426bd3e0..96529ab3a1 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -95,5 +95,7 @@ bool cpr_luo_persist_state(int session_fd, QEMUFile *f, Error **errp);
 bool cpr_luo_preserve_fds(Error **errp);
 bool cpr_luo_retrieve_fds(Error **errp);
 bool cpr_luo_save(QEMUFile *f, Error **errp);
+QEMUFile *cpr_luo_load(Error **errp);
+void cpr_luo_incoming_finish(void);
 void cpr_luo_abort(void);
 #endif
diff --git a/migration/cpr-luo-stub.c b/migration/cpr-luo-stub.c
index 04a5bd816a..22a7037c20 100644
--- a/migration/cpr-luo-stub.c
+++ b/migration/cpr-luo-stub.c
@@ -59,6 +59,16 @@ bool cpr_luo_save(QEMUFile *f, Error **errp)
     return cpr_luo_unsupported(errp);
 }
 
+QEMUFile *cpr_luo_load(Error **errp)
+{
+    cpr_luo_unsupported(errp);
+    return NULL;
+}
+
+void cpr_luo_incoming_finish(void)
+{
+}
+
 void cpr_luo_abort(void)
 {
 }
diff --git a/migration/cpr-luo.c b/migration/cpr-luo.c
index 1d112e7865..d9aba3bfc5 100644
--- a/migration/cpr-luo.c
+++ b/migration/cpr-luo.c
@@ -261,6 +261,41 @@ fail:
     return false;
 }
 
+QEMUFile *cpr_luo_load(Error **errp)
+{
+    char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+    int session_fd;
+
+    if (!cpr_luo_session_name(name, errp)) {
+        return NULL;
+    }
+
+    session_fd = cpr_luo_retrieve_session(name, errp);
+    if (session_fd < 0) {
+        return NULL;
+    }
+
+    cpr_state.luo_session_fd = session_fd;
+    return cpr_luo_input(session_fd, errp);
+}
+
+void cpr_luo_incoming_finish(void)
+{
+    struct liveupdate_session_finish finish = { .size = sizeof(finish) };
+    int session_fd = cpr_state.luo_session_fd;
+
+    if (cpr_get_incoming_mode() != MIG_MODE_CPR_LUO || session_fd < 0) {
+        return;
+    }
+
+    if (ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, &finish) < 0) {
+        warn_report("failed to finish LUO session: %s", strerror(errno));
+    }
+
+    close(session_fd);
+    cpr_state.luo_session_fd = -1;
+}
+
 void cpr_luo_abort(void)
 {
     int session_fd = cpr_state.luo_session_fd;
diff --git a/migration/cpr.c b/migration/cpr.c
index b91f2fdcd7..fdbb684798 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -391,11 +391,15 @@ bool cpr_state_load(MigrationChannel *channel, Error **errp)
         mode = MIG_MODE_CPR_TRANSFER;
         cpr_set_incoming_mode(mode);
         f = cpr_transfer_input(channel, errp);
+    } else if (cpr_get_incoming_mode() == MIG_MODE_CPR_LUO) {
+        mode = MIG_MODE_CPR_LUO;
+        f = cpr_luo_load(errp);
     } else {
         return true;
     }
+
     if (!f) {
-        return false;
+        goto fail;
     }
 
     trace_cpr_state_load(MigMode_str(mode));
@@ -405,23 +409,28 @@ bool cpr_state_load(MigrationChannel *channel, Error **errp)
     if (v != QEMU_CPR_FILE_MAGIC) {
         error_setg(errp, "Not a migration stream (bad magic %x)", v);
         qemu_fclose(f);
-        return false;
+        goto fail;
     }
     v = qemu_get_be32(f);
     if (v != QEMU_CPR_FILE_VERSION) {
         error_setg(errp, "Unsupported migration stream version %d", v);
         qemu_fclose(f);
-        return false;
+        goto fail;
     }
 
     if (!vmstate_load_vmsd(f, cpr_state_vmsd(mode), &cpr_state, 1, errp)) {
         qemu_fclose(f);
-        return false;
+        goto fail;
     }
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
         /* Set cloexec to prevent fd leaks from fork until the next cpr-exec */
         cpr_exec_unpreserve_fds();
+    } else if (mode == MIG_MODE_CPR_LUO) {
+        if (!cpr_luo_retrieve_fds(errp)) {
+            qemu_fclose(f);
+            goto fail;
+        }
     }
 
     /*
@@ -431,6 +440,13 @@ bool cpr_state_load(MigrationChannel *channel, Error **errp)
     cpr_state_file = f;
 
     return true;
+
+fail:
+    if (mode == MIG_MODE_CPR_LUO) {
+        cpr_luo_abort();
+    }
+
+    return false;
 }
 
 void cpr_state_close(void)
diff --git a/migration/migration.c b/migration/migration.c
index c8055a1d98..7c2bb982a5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -687,6 +687,8 @@ static void process_incoming_migration_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
+    cpr_luo_incoming_finish();
+
     if (runstate_is_live(migration_get_target_runstate())) {
         if (autostart) {
             /*
diff --git a/system/vl.c b/system/vl.c
index 468a9fc247..b40f4803e1 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1840,12 +1840,21 @@ static void incoming_option_parse(const char *str)
 {
     MigrationChannelType type = MIGRATION_CHANNEL_TYPE_MAIN;
     MigrationChannel *channel;
+    const char *uri;
     Visitor *v;
 
     if (!strcmp(str, "defer")) {
         channel = NULL;
     } else if (migrate_is_uri(str)) {
         migrate_uri_parse(str, &channel, &error_fatal);
+    } else if (strstart(str, "cpr-luo:", &uri)) {
+        cpr_set_incoming_mode(MIG_MODE_CPR_LUO);
+        if (!strcmp(uri, "defer")) {
+            channel = NULL;
+            str = "defer";
+        } else {
+            migrate_uri_parse(uri, &channel, &error_fatal);
+        }
     } else {
         v = qobject_input_visitor_new_str(str, "channel-type", &error_fatal);
         visit_type_MigrationChannel(v, NULL, &channel, &error_fatal);
-- 
2.43.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE247CD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAai-0006bp-VN; Mon, 01 Jun 2026 17:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAag-0006af-F5
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAae-0003qe-2d
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651HgGBL3001044; Mon, 1 Jun 2026 21:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vde4a1
 Q5tAOWSqewyxOrjeN6nP6oW09yMgbAqs+ewlo=; b=Yvbp7cQEppanDUo91nT5i6
 Rg66XM9A3kGAujWlowEiN1mQnZA+IUd8LZFuXwfnAFCTzCfC6n7lIaw/jak3tcRH
 GPqWNck7uWy1tQHJ/qIiCZ6Tmaz+mWSAS86OmuJtSbb05cdYXh+kJUVJkzYb3Sgn
 H55LLTJLYquoate6pHpi194ZhOemZATiLYktKTPeGoLSgH4pORTLn97FH6uZIOIh
 D6qj5SDworwlpHHdG9/EOIManbmTDdd/NDjLzCwYFXQepVHzIv8T2rGN93CB7gmC
 DICQ+mDuSTHjxzOkc51IVOVDst2Klg2/bKyd0quZLw8VadUx0EMApAao9it7pwzw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae2rxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Ls8vE002482;
 Mon, 1 Jun 2026 21:54:29 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh869q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsT6t28312066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AC7F5805D;
 Mon,  1 Jun 2026 21:54:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2D1358054;
 Mon,  1 Jun 2026 21:54:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 07/16] migration/vmstate: Add VMState support for GByteArray
Date: Mon,  1 Jun 2026 17:54:00 -0400
Message-ID: <20260601215410.517009-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1dff96 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=ZarguQuSfgdiQHUm4MgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CqPxD9w1V30pvbcmDopB5kaBsNHuIzyD
X-Proofpoint-ORIG-GUID: CqPxD9w1V30pvbcmDopB5kaBsNHuIzyD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfX0ghbEUAiY/2/
 bKOX8bEXzL+PDzJsb9tu9+ajXwcN8wQ7W5ICmiLOvueFw95kDzEH20H8lb2W89nIdeGYNYI7zHx
 o1JxjNYUwXnMH7AOIUqpFglfcU1WNUSiO2rfSdmblAoNo+kWyQQ5n/ktmLn1gA/mqJF8J+06FPp
 paWPme8ULfHTseX5MPOyYqeyxiga9gMM8B6vZ5loK+5LLSmDdvqgKZ0dyvqOjq5N1ja+EZcDPxZ
 8oopOxzzPRikL+lNMDCLPS/x5WoA3vgCnHHO1Z7X9migMikwNxurshGb964W331G6PKL9Cwhlyd
 MFxcm4LwpySmn2QTHFKtMXaO9nJ/kOrjPABnszCb7mqV5Kx10u8v/rb6/WOm/7kyGrHWoll9E8d
 ZvAj0KHwV12G2lTfIHUr2cBjkPbOQivz+u96M1ccS2M/lBwdZkp3eGrc2AA2KHVqhsa0VlAJ3Af
 WBDNyZEXdAe/qyWhO7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

In GLib, GByteArray is an object managed by the library. Currently,
migrating a GByteArray requires treating it as a raw C struct and using
VMSTATE_VBUFFER_ALLOC_UINT32. For example, see vmstate_vdba in
ui/vdagent.c

QEMU cannot pretend that GByteArray is a C struct and simply use
VMS_ALLOC to g_malloc() the buffer. This is because, VMS_ALLOC blindly
overwrites the data pointer with a newly allocated buffer, thereby
leaking the previous memory. Besides, GLib tracks the array's capacity
in a hidden alloc field. Bypassing GLib APIs leave this capacity out of
sync with the newly allocated buffer, potentially leading to heap buffer
overflows during subsequent g_byte_array_append() calls.

This commit introduces VMSTATE_GBYTEARRAY which uses specific library
API calls (g_byte_array_set_size()) to safely resize and populate the
buffer.

Signed-off-by: Arun Menon <armenon@redhat.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260423105733.113046-2-armenon@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/migration/vmstate.h | 10 ++++++++++
 migration/vmstate-types.c   | 28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 0a8a2e85a6..1b7f295417 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -308,6 +308,7 @@ extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
 extern const VMStateInfo vmstate_info_gtree;
 extern const VMStateInfo vmstate_info_qlist;
+extern const VMStateInfo vmstate_info_g_byte_array;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
 /*
@@ -957,6 +958,15 @@ extern const VMStateInfo vmstate_info_qlist;
     .start        = offsetof(_type, _next),                              \
 }
 
+#define VMSTATE_GBYTEARRAY(_field, _state, _version) {                   \
+    .name         = (stringify(_field)),                                 \
+    .version_id   = (_version),                                          \
+    .size         = sizeof(GByteArray),                                  \
+    .info         = &vmstate_info_g_byte_array,                          \
+    .flags        = VMS_SINGLE,                                          \
+    .offset       = vmstate_offset_pointer(_state, _field, GByteArray),  \
+}
+
 /* _f : field name
    _f_n : num of elements field_name
    _n : num of elements
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index ae465c5c2c..8c01215c25 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -924,3 +924,31 @@ const VMStateInfo vmstate_info_qlist = {
     .load = load_qlist,
     .save = save_qlist,
 };
+
+static int get_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field)
+{
+    GByteArray *byte_array = *(GByteArray **)pv;
+    uint32_t len = qemu_get_be32(f);
+
+    g_byte_array_set_size(byte_array, len);
+    qemu_get_buffer(f, byte_array->data, len);
+    return 0;
+}
+
+static int put_g_byte_array(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field, JSONWriter *vmdesc)
+{
+    GByteArray *byte_array = *(GByteArray **)pv;
+
+    qemu_put_be32(f, byte_array->len);
+    qemu_put_buffer(f, byte_array->data, byte_array->len);
+
+    return 0;
+}
+
+const VMStateInfo vmstate_info_g_byte_array = {
+    .name = "GByteArray",
+    .get  = get_g_byte_array,
+    .put  = put_g_byte_array,
+};
-- 
2.54.0



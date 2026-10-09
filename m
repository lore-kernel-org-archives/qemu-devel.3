Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3699BCA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFL5-0000gA-9l; Fri, 09 Oct 2026 14:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKt-0000Yd-1a; Fri, 09 Oct 2026 14:28:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKr-0001hD-Bs; Fri, 09 Oct 2026 14:28:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha4Xi3714688; Fri, 9 Oct 2026 18:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZRPgz6qR933JQAUhf
 JnauJMw5nsKnr1kch91eypDPkg=; b=Pa9/ionLOXWf07LDTRZw0Mz2FiGiYgETi
 7EDEXlJE/t4pIHETFvWJpBXozUZS5mm4KDkc9RS5pjpmgNTWCrLPQRqHeZw5v8M+
 6SboBQvZITxovw+rud74+mEWMZyHmMMV3S1n/SVlBfvETXfIQRGvuOxPFbPCIGu8
 Ud74WFsNhzQFU/LoQvjP6UkWOBPdwp8yHdm8Q44vMQNDNspPSfeqr/9hmFBZuR5h
 Wuzgfydwi3JI/oc9ygLbn8+R6uLKk5W0cDGN7QG4AcRFfbjYi8AaohIo829Qb/fv
 3mV9XrkeA684savzLm1He+mznnlRJx26WDr3HydwRLZ8n6AmMsDig==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74ter88f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8OIl4125988; Fri, 9 Oct 2026 18:28:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u45nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISjCs197260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1D385805A;
 Fri,  9 Oct 2026 18:28:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D55D958054;
 Fri,  9 Oct 2026 18:28:44 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:44 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 15/19] s390x/pci: Provide each zpci device with a unique stable
 bus "path"
Date: Fri,  9 Oct 2026 14:28:21 -0400
Message-ID: <20261009182825.148054-16-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QdWxz4K78jNG_kSja1XQyc3OUh6jD8g4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXwj4ES9EtUoEE
 07QJUtnEVbEeDmgheuRT8OjOq4EOxPhdPLaIkTcG45Myw0MoUFlAb0TEz07LHIoY179aHmeM75O
 loomHWUuYZvY4laU5aeAfB1Suwd9pbiKFyTbc7L+OUJTe1hU53rhxvseh5bgjuDQYNqCk0vdJH2
 1ufgQ9oIRREjIvyQtbUvkeckTPJQZoR6tHXjMlxIXuU90c10iKybvsvey3MK3aYcaYN9j8WHB6I
 wt3ieE+nbgwuUYaVplgx50+oSpu6lfQrZPxypggTJGsWJBMezhYxBgfErJEud/phzimqIcX0QWh
 LDjfHPvWVHaZkN1+EHwEsP+ob2UB3oyvRPc+u+VbNNWKA8kzsHdkxRmFw3yBXqq/1iZ+v7nwkM1
 9mwy33gm6sU1xGkwR7eQWrYZXzrKkRlql7aW6WaLvH8X6ld2ipZ0kwHmYi7ncagYEbMtFu2gPy7
 lttWoyqYOI9pxWHi3eA==
X-Proofpoint-GUID: QdWxz4K78jNG_kSja1XQyc3OUh6jD8g4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX8VRf9sM4DvZC
 nOMTzl8EItkRaOTPcycIfoIumlx8GFYPy1/fThbWiYr+6lCn5IV4+59CeV0mVrSbwI/V1NB+Uhg
 lD++0HDUeNgMkvsu4KxBWDIypJDNnlQ=
X-Authority-Analysis: v=2.4 cv=Nf1zRGD4 c=1 sm=1 tr=0 ts=6ac93260 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=X9i1E-zOIupQ93g3ad8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

This is necessary for the follow-on migration support. The new unique
UID-based bus "path" is used as part of idstr in the migration stream,
making idstr unique and instance_id always 0.

For migration to succeed, (idstr+instance_id) must match those generated
during QEMU start. Without unique idstr, QEMU will generate variable
instance_id to distinguish devices, and that instance_id can change
if a device is unplugged and plugged back, preventing migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-16-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 799e596fec..7dff771ee6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1474,10 +1474,33 @@ static const TypeInfo s390_pcihost_info = {
     }
 };
 
+/* Return a unique bus "path" for zpci device */
+static char *s390_pci_bus_get_dev_path(DeviceState *dev)
+{
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
+    return g_strdup_printf("uid-%04x", pbdev->uid);
+}
+
+static void s390_pcibus_class_init(ObjectClass *oc, const void *data)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->get_dev_path = s390_pci_bus_get_dev_path;
+}
+
 static const TypeInfo s390_pcibus_info = {
     .name = TYPE_S390_PCI_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(S390PCIBus),
+    /*
+     * Implement get_dev_path() to provide each zpci device with a unique
+     * stable UID-based bus "path". The "path" is used as part of idstr in the
+     * migration stream, making idstr unique and instance_id always 0.
+     * For migration to succeed, (idstr+instance_id) must match those generated
+     * during QEMU start. Without unique idstr, QEMU will generate variable
+     * instance_id to distinguish devices, and that instance_id can change
+     * if a device is unplugged and plugged back, preventing migration.
+     */
+    .class_init = s390_pcibus_class_init,
 };
 
 static uint16_t s390_pci_generate_uid(S390pciState *s)
-- 
2.56.0



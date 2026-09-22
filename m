Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B49C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96vF-0008SW-Vo; Tue, 22 Sep 2026 16:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tv-00082A-SL; Tue, 22 Sep 2026 16:15:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tq-0007ff-RQ; Tue, 22 Sep 2026 16:15:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI78RH1128992; Tue, 22 Sep 2026 20:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vRIXMRakBGJfbZE8Z
 DtYsNbMqHwAb87+JJN6vShZ2FI=; b=PZd2kWXoK/5jwxU21ku1uDFyZH5oQftAr
 kqEQeYkYOZ3v4d41AEPoKbMr9o2RdZMa6fEQ1S2JA+PNL4ZctfqLWwOUWubu7dvj
 HPxgw44u9qgOrYW5fK/xkG9leM4htpWdiSWDkcWh8PU9H+AiTwZAkb78t6yNRMrW
 tqoWR9GZXvaR5EMH2fSJmpduS9PUxCBkQsooVag1DwAPFmKYbBG3C+0W67M45Wg2
 +2Yss9WMjB9g+qhX7y07hM9Un8tffI4fjvuwjxpsjVafx5QbZ7QsKutPt7xQcxz/
 +jnyjyOq+wNmyvpM+jX4Pv9cjSBSy3lpBaeFEc0cbrAjWPZAFDpBQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs7sey-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHZhe4187977; Tue, 22 Sep 2026 20:15:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyb3ms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFRAl53477768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B918A20043;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DF272004D;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 679421615CA; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 5/9] vfio/ccw: Clear error object pointer after non-fatal
 errors
Date: Tue, 22 Sep 2026 22:15:21 +0200
Message-ID: <20260922201526.2383047-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
References: <20260922201526.2383047-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WuYEg3pJWr1ZmXxL5igA:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: KZViQFp_MZZT2lDtrOoarV87EXByY6sj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX2HXIC7ybk0BN
 Uui4/ppqjFur5iS9RBGe7iIY/MbNE4N/pwhnmMEvnTFTub35Zk7en59eH0Inn0xqpet5RiR+8iv
 U2Rdv7B3JlB+kccl0OqfoHSGWkw0A3X3v/elNdH6rkKVzqGYEGj9tOAMjMp7phkh9m3q6WLF1nw
 BpO9g2zhtGyyOcrPRAqEj2FzskkSRH/moDCAa9WiBLsofOlpkzwG6WKXya/A7c90GAc5BDs0AKU
 sToH43boWj5PRvuj9AnIG5h/nhBBNwYEhSi6niIMiVyK3iWNLenQaSEMsgN4I5tSc1QvW/AuoCi
 qseWZiSAuVMjqKMTCPj74fi/4+KTsYqMc+hv8VWOU18xACYdWD/PXfuxNRTajJ4UGAHdCjH7BY1
 4pbJGVN5SjsWeVxFk0/YBere7kadwcmD7ULdbvjZXx0WPV+Bg8oJgOWCd0YMuwOsAVF0638rmeu
 sYBpqaShHpjmpoAYiRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfXy6P/kkpdWaiW
 JoNZG8mOtnFN/7pk3w6t6XDh01mH894O+n/HFxrJCzr9BX0B/pXOXGENfVKTLKYfJbknvCs+KWY
 HxZj+kmtme90ZPifPTvon9weuK6j4d8=
X-Proofpoint-GUID: KZViQFp_MZZT2lDtrOoarV87EXByY6sj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220293
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Just like in vfio/ap, there is a non-fatal message that could be
generated, with a stale pointer in the error object variable.

Unlike vfio/ap, there is no secondary message that could attempt
to use it. Clear it in the same way, in case that ever changes.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/vfio/ccw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c3dc7c1962..8e29a3ae61 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -604,8 +604,10 @@ static void vfio_ccw_realize(DeviceState *dev, Error=
 **errp)
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operatio=
n.
+         * Clear the pointer, since the warning will release it.
          */
         warn_report_err(err);
+        err =3D NULL;
     }
=20
     return;
--=20
2.53.0



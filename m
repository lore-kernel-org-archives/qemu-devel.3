Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14355C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuaJX-0006uj-N4; Thu, 13 Aug 2026 14:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJM-0006uN-57; Thu, 13 Aug 2026 14:37:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuaJK-0005Au-Ek; Thu, 13 Aug 2026 14:37:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFWZi7860674; Thu, 13 Aug 2026 18:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=62am4XVDRKBWVOg7X
 xO6BdEY9fliZf1Y3J1890dXxR8=; b=pcKP1e8f3YQFLct78ZsYdu0atOPs77fJ2
 TiNmiEFUMeNq2yCcg8Q+EbcUqMv2kKsk07wJzJIzXZh37aV8yWMX4hPpvdoQ2Gxm
 uyvpC/AFjLEeP77/WqDTFQgpjQLKwx8yiccuF/JWYMunE8+flmBOreoX8mwXcIhA
 55tlMSXDexcoksj+Crh3qQlGsrgoeLOjcelrNMA8QgqwyetipYdqRc49MNUcrIpX
 lLnO1BKPTIpHSPLbpXE/c7c6AYna/Sn1WERNLvc5Z3kN6Y3uQSIiZq1m2B/bWto9
 Siw58XC2JTwBAyStw6amNelZJJsZy8fqpZFm65n6NxdkCSrvOYUKw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk09dfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DIQH7D003917;
 Thu, 13 Aug 2026 18:37:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqcchv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 18:37:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DIbg9026477190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 18:37:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 151742004D;
 Thu, 13 Aug 2026 18:37:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA54320043;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 13 Aug 2026 18:37:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id D0CAE161295; Thu, 13 Aug 2026 20:37:41 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 4/4] iotests/108: skip if fuse is unsuable
Date: Thu, 13 Aug 2026 20:37:40 +0200
Message-ID: <20260813183740.3503107-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813183740.3503107-1-farman@linux.ibm.com>
References: <20260813183740.3503107-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfX4xfB3Plrq9xV
 sargHCClGzPxqAKO3aR7QHdb/zwzjE4leug6gx+O0gMvgt8vLoV61J82DUw0D0PXvOVAHJkkLpN
 vqybxXZlCwJuROaPH8QoG4Q7QiT4XP2Iy5tldbqlDuXomTUMrxTUDdMUVP9qVyCCsBbyoUVzkrB
 EXtxCFHRWhN+Ld6LxRkMfq7ecrt5JvAH3eePx73SWL9MhDEjhQE2H4UVwrWCtIUsxdPkAa89jiM
 q9gLzw6V4Xyia9YPLcf7dRyc+kuwVyLi8WYpyug7nCezHCAEoKc9bf8kI/FwJz2Go9GTfeitk8h
 4biWySpLDTArGDIVqucw2TKbj0u/voV6wzJhtXpRGoCssIRd5UXOdF3oF5QypHeTXUpVgjPPc64
 xPnX4uSNoH55IkZBWyW9ZhLNjcvad5tW+yXiXMuJVpoFEvqgixugmm3UdYUIAVB2L7hAET9yzlz
 GGqBZNdxPOV3znk4Y4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzNCBTYWx0ZWRfX/wOANbGxjlbk
 RtqlJrygLtCPRaI8YT5tvaMs3PEYDH94WFm1XwhPvXs/WfOWv8HsvnkPbfAWtyEbkolNpGgUscl
 VmIkOeFCx3jeOAOuYQu12/9G8vFX4yY=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7e0efb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=g5ZYLniJXgBoyFi4TRgA:9
X-Proofpoint-GUID: tZCM8rJqdpxHtyjsZfenIky4nT-zGqNF
X-Proofpoint-ORIG-GUID: tZCM8rJqdpxHtyjsZfenIky4nT-zGqNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130134
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

It is possible that the ability to fusermount is restricted
to privileged users. Rather than waiting for this test to
perform a mount and subsequently fail, perform a dummy mount
early on and skip the tests if fuse is not usable.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qemu-iotests/108 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index bf808b3512..8dc725cf66 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -73,6 +73,23 @@ else
         _notrun 'Passwordless sudo for losetup or FUSE support required,=
 but' \
                 'neither is available'
     fi
+
+    # Test to see if fuse is usable or not (permissions, etc.)
+    export_mp=3D"$TEST_DIR/fuse-export"
+    touch "$export_mp"
+
+    response=3D$($QSD \
+        --blockdev null-co,node-name=3Dexport-node \
+        --export fuse,id=3Dfuse-export,node-name=3Dexport-node,mountpoin=
t=3D"$export_mp",allow-other=3Doff \
+        --pidfile "$TEST_DIR/qsd.pid" 2>&1)
+    if [[ $response =3D *"Failed to mount FUSE session to export"* ]]; t=
hen
+        _notrun 'FUSE support is not usable (permission error?)'
+    fi
+
+    if [ -f "$TEST_DIR/qsd.pid" ]; then
+        qsd_pid=3D$(cat "$TEST_DIR/qsd.pid")
+        kill -KILL "$qsd_pid"
+    fi
 fi
=20
 echo
--=20
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AA3CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFo2-0002pO-6F; Fri, 09 Oct 2026 14:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xFFnp-0002oY-FE; Fri, 09 Oct 2026 14:58:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xFFnn-0004aS-RI; Fri, 09 Oct 2026 14:58:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HaT9E3715576; Fri, 9 Oct 2026 18:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=q4ywSK0m6i7UkygM1NLsojaRf/nL0YcFAnFgwG/vN
 qk=; b=X49kyC15z0sX1rAKccrQYQQidoT3zBzdv1E0L2QPL18FuyLOvkvZ5csHX
 ZSFm2Jj7YmAyYx2mu4Au/g5+ywQ2g5USNvSzbH8aDZx4V7aMmE3JftUKD8yMiDi+
 WiizV84Qeuy7ai5eekqXix27kB6capdgnBhIBbSDr6IONtgGeFrjMezycgScviHd
 xRSRDALuIlziop+z1S+eQc4faBEaHO4VYuJddcGGaPvHIkLUgIU+C3WFwrcqQfgl
 YF/Mqxz6FkLCw/sFTAbKsUoFXGPeDzSDJM/ZFsms0rGonNoBVn/iH+GLwg7XSZDM
 M291vqaqgbvo5UbvA9qeks8AGr4pg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74terceq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:58:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8Fkx1142916; Fri, 9 Oct 2026 18:58:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd2epq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:58:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699IwaiJ17826538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:58:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6705B58055;
 Fri,  9 Oct 2026 18:58:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B674658043;
 Fri,  9 Oct 2026 18:58:35 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.ibm.com.com (unknown
 [9.67.47.107]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:58:35 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 0/2] s390: mark features that depend on deprecated features
 as deprecated
Date: Fri,  9 Oct 2026 14:55:57 -0400
Message-ID: <20261009185559.144750-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aKGQinA9JYapSHQ_TSNUQnLewHVE5SSH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NCBTYWx0ZWRfX5vdAh9lLhhEX
 378XRYoLM5Nl+lfeeTejAYbj4b/w3FUE1m2m5ZFMMmy+3QxgV8Ng1e6SakC7xhBq2SN0q1yAdo2
 46f2gnGAFnTP6qJJVoZPIWt9ppRLbmwUUSJz8mH4XWASenx0nMeNFTTCcPJrLSEDv61XAyk8B55
 EBlbyM2jGtyoIbW0usUH9iuNduCUJHmrDN5LFKkONGWfGj1mvj5J3AtEBqaDNt6HAKmpjWBc+1E
 aE66D+NdvOf8amjDrCC0gTBoUqKcM4kCkl+AWRh7vGWV5DvrcHEIc/2SHchvKv37jOgaY5mE355
 jJiINceMR9sH8saaHlzPd11xJSdQu7dyh08CFrazBoBvDixqTEWBvrpS0ZgIloRnanfZlogXxg4
 geqymu9xeVIFHqk911aWm8qEtQpKqcOGjVP8RXNJNDrneonz7R6vQ6ZlM9SXyxilTqESb+eoCNF
 fGyB+pFqMXhAluGJKiw==
X-Proofpoint-GUID: aKGQinA9JYapSHQ_TSNUQnLewHVE5SSH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NCBTYWx0ZWRfX7k7kAPqNFfQN
 jrQiSsjsntjgotp5zZ6dAsjHib78DntB65mvNb9GJlynF7Jc/Y4RLDlV06u/nc5P0wj7vIvGoiW
 SCLHr8TtDeSJE/qp70U0UCGVsxkjI2w=
X-Authority-Analysis: v=2.4 cv=Nf1zRGD4 c=1 sm=1 tr=0 ts=6ac9395e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Yii7PyyUOqtlikobaqoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

Changelog:
  v2
    - updated loop structure to restart and check if previous dependencies
       need to be accounted for
    - added fixes tag to patch #2

Description:

When the CPU model deprecated-features work was completed in QEMU, features that
have a dependency on a deprecated feature were not themselves marked deprecated.
This patch series corrects that oversight.

Specifically, ineff_nc_tx depends on te, which has been deprecated. When a user
starts a VM with deprecated features disabled, QEMU currently emits:

    warning: 'ineff_nc_tx' requires 'te'

With these patches, query-cpu-model-expansion includes ineff_nc_tx in the
deprecated-props array alongside the other deprecated features:

{
  "return": {
    "deprecated-props": [
      "ineff_nc_tx",
      "bpb",
      "te",
      "cte",
      "csske"
    ],
    "model": {
      "name": "gen17a-base",
      "props": { ... }
    }
  }
}

libvirt uses this response to determine which features to disable when the
deprecated_features=on|off attribute is set. With these patches, ineff_nc_tx
will be disabled along with the other deprecated features. The result can be
verified with virsh domcapabilities:

$ virsh domcapabilities --disable-deprecated-features \
    --xpath "/domainCapabilities/cpu/mode[@name='host-model']/feature[@policy='disable']"
<feature policy="disable" name="bpb"/>
<feature policy="disable" name="csske"/>
<feature policy="disable" name="cte"/>
<feature policy="disable" name="ineff_nc_tx"/>
<feature policy="disable" name="te"/>

Collin L. Walling (2):
  target/s390x: externalize feat dependency array
  target/s390x: mark feats dependent on deprecated feats as deprecated

 target/s390x/cpu_features.c | 139 ++++++++++++++++++++++++++++++++++++
 target/s390x/cpu_features.h |   4 ++
 target/s390x/cpu_models.c   | 133 ++--------------------------------
 3 files changed, 148 insertions(+), 128 deletions(-)

-- 
2.55.0



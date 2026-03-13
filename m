Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D499107BCE2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w18Uj-0007WT-Io; Fri, 13 Mar 2026 15:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w18Ue-0007Vc-0s; Fri, 13 Mar 2026 15:48:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w18Ub-00068t-Sg; Fri, 13 Mar 2026 15:48:19 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DHUqhs2308551; Fri, 13 Mar 2026 19:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=T0W2w+a6CqjN+Jfoi
 20FWBXudZvJshWpfzof790RDtg=; b=Z5l6QqP0hxWL7qzCGgZKW0zgRx7Z0RSO/
 EU55KsddNphfFZmWZUlYhzwGpu3GeOzMrf1rY2OUTgEjFENB4FPRoKvgBOqC5IyK
 d2QGqW/Vvo3GWU7j1orsb4Z5DIE66y2h1LYL/6DzmAl7IcxiRtAaGFbFvLQvcAcQ
 /5ZWTZX5tjotoMuWXmCviEBMe8OcKQnmY54LzV77u2/n+6tVf2OOFL3lI9Jb7oaP
 xouAmqZ8/Vcd8H3Y2dLmDKxkt0/IvA4EACz4shcj+6Bnu2B8k4+KDYwyStYtvfRW
 m9PcS9wUS9rWSr38Et0iU2ucWObzWewoorDNUypKicHHu+PmgX2AQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96h7bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 19:48:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DJ6s0P006036;
 Fri, 13 Mar 2026 19:48:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9r3d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 19:48:14 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DJmBAK59638134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 19:48:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01D552004B;
 Fri, 13 Mar 2026 19:48:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D18A720040;
 Fri, 13 Mar 2026 19:48:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 13 Mar 2026 19:48:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id B99EFE00F1; Fri, 13 Mar 2026 20:48:10 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 0/1] One additional boot reviewer
Date: Fri, 13 Mar 2026 20:48:09 +0100
Message-ID: <20260313194810.1844241-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313113424.15583-2-thuth@redhat.com>
References: <20260313113424.15583-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1NSBTYWx0ZWRfXzj44PMg3YEI3
 OnxVlgNsANS2ugki6FNLiKJVsZ4G0gq2EUXiJ95arRpC2SNZRyPVkwnLgB+vVib3dZnfF+JCJPt
 DjqAFfHOljd2CW0LRzHaU2UwggYRenUOzgKby0y05zoS49Ch80eHFUqwR72RIgEcKkzSWIv9cdl
 oND3zCx/yTxli4vIW2MztDTjiWmK10ARtft/IgOYADTD90ykKbaGX0A7PTqcmGw7aq6o36+G4LH
 QakBZ5IQvfDl1UV6OkqWs9yqWp6YcI7amefsn9qx5XPTT1ftz/UczvehvOgRlqQvRDpRMeAw2lk
 Asd5oLE5wYL63CHJWOMkrYH12B1cGObVAU/oPBg/rgLM6dgw3Qe2bpW6UiPTwOFU7mUn04Mix5/
 Un8Y5gPzwkI9l/Fbn8fBvoozcIDXYYZUpRoGP7YafoIEFCn2e7c2XvnPwzXkCyCAlAX20ll7E1J
 Fnizvyj1Z206DuxBswA==
X-Proofpoint-ORIG-GUID: RttX-BGyeaJY9ogFAibcOTRH2dXtYArP
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b469ff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=huORBVVj8Srulg7lObMA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-GUID: RttX-BGyeaJY9ogFAibcOTRH2dXtYArP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Thomas,

I mentioned offline that we might have one more person that could help
keep tabs on the boot code, beyond Matt and myself. Here it is, if there'=
s
still room for it...

Eric Farman (1):
  MAINTAINERS: Add another reviewer to s390x boot

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

--=20
2.51.0



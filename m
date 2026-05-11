Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85850CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRXC-0002Rb-Lg; Mon, 11 May 2026 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wMRWr-0001hv-BC
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:22:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wMRWo-0002ra-FA
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:22:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BAj2W04070439; Mon, 11 May 2026 14:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vLEXsqhvCpB9gj2w10/ep3IMmd0KJHRt5frhXfM4+
 Ic=; b=d+d/PcmTMR6s8w0tQ+F3BAv3ASK7SGKfb4oAeSVQz+61tyFOp9/TnPeJy
 XRhxVXVDaqZ6Bb60kr2DTOMYsGH2KnK0mR1ZG00c8mX6Tk09piZMb8O01blSWxLz
 2CE9Ti5QAcKJi03xCBrdePYJWxteZfiiwJP2RguqBuIsfj13O7z4SFchd0uJQCxE
 3zKgS98xlz1nZBWBmOFtiSkPAtN0cPvJmP3sTGmVScUIIj+FvwJH7PVehAIuh3cv
 z7AbWqTxPNMUyKc2mdGp7OjJDs78ybwwWptJ2SYPYOle9rJfzKLsqRdI+kB2/y0L
 8FQE70RnbDAFSUg7WLFB2Zbc4jEXA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdr6w4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:22:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BE9U56022191;
 Mon, 11 May 2026 14:22:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg5erf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 14:22:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BEMYD827263500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 14:22:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 010F158055;
 Mon, 11 May 2026 14:22:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6613E58063;
 Mon, 11 May 2026 14:22:33 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.226])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 14:22:33 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com, philmd@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 0/2] Improve handling of response buffer size in
 tpm_emulator
Date: Mon, 11 May 2026 14:22:16 +0000
Message-ID: <20260511142219.797048-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a01e62b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=0s17AUUPUcYwv1RGZiYA:9 a=ZXulRonScM0A:10
X-Proofpoint-GUID: GDtxhbYHnFfM15gEf9kt71STr-wOKy-_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NiBTYWx0ZWRfXwDdLHMAav1aE
 uit0RlD3nkIRPolOvbWp43BzdbpVeiH/vVcR1pIHFXEryfPVn0DOcZn0zjWKbemAeTPAo9NY7T0
 civzKLlflbLGOx+p8/jwC9JKSocdnG3vH3aEeLv6O499Go5Ja517z7EYThqUh+8EQkXtmBnrK9E
 +tq/v1xDLE7HK30JDlQztDcMg2KazMYP9fXahgajo8VBV9v+2qJb8OyJVAQyBWomYX5Z5UIvA/g
 2okqFiS0JfQPypQmiYBzGr/BGVEmxj7oYsrWwq719G/rwMenD/l/nm5L9aP20kUSy75aTEwjfnf
 kobVS6Cl1Iqr7+B98hV9mbOvAiwFKPzk9okhz2GM0bXBBHbn2zF5sAQSGYAeJr/QndOMpvjYWVm
 O8d8rNuRf/4r9W4HhNKlKhOynduBFFVpcI7jGfiJ+o+eUw8+g9hhuMglG6dXjFjvdDcEiSl432/
 go175JJPbR7bFPz18Kw==
X-Proofpoint-ORIG-GUID: GDtxhbYHnFfM15gEf9kt71STr-wOKy-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

This series addresses some issues with the handling of the negotiated
buffer size that the TPM frontends tell the tpm_emulator (swtpm) to use.
Also, it improves on limiting the number of bytes read from the packet
sent from swtpm.

   Stefan


Stefan Berger (2):
  tpm_emulator: Reject a buffer size different than what was requested
  tpm_emulator: Disconnect if response exceeds negotiated buffer size

 backends/tpm/tpm_emulator.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

-- 
2.53.0



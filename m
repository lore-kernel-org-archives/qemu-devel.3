Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67329CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeCt-0001H9-8x; Fri, 02 Oct 2026 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCh-0001CV-HE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCZ-0001nA-3H
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DZahb3589883; Fri, 2 Oct 2026 14:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DxcENW
 3KcCsWxsl4uaYUZg4pvpzJWSU7O7BBPrbv1Ng=; b=Mwae8Tp+KwAbheHreKMa6u
 TfiFlMHen3PXyugNhta0UcN/6QGuZfjTvyC5zrKR1DKIxFe35VGX5nKAIPRZNL+2
 4FJGH0UvTq+jeQohl+yBnbUBwfO62e6kiyTjBMhEfw+CL3zTzsrp6Xua6HKUK+f5
 7Fy4BbouCB5qLdWen4iygJn1fhjfthxEI1bbkT/vKt4OM1pRDElkwgSmJ9Pn7hJH
 mrAO2anG1G75i1BCZ58dX4svMdY9nnLtIJbheVxtw2w/7eisn4pgvRq4ox3BqiQE
 uu8uHLTAlrfd2+gfrLd60SKD0zoarBPcOSpfqNqNFsO6HUhDdDDJzfVR3BrAdxHA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4feraxw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DHV6S1296239; Fri, 2 Oct 2026 14:25:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pmjg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692EOhbZ54722904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 14:24:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BF4E5805D;
 Fri,  2 Oct 2026 14:25:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83DB65805A;
 Fri,  2 Oct 2026 14:25:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 14:25:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 03/10] tpm_emulator: Reject sending commands smaller than
 the request header
Date: Fri,  2 Oct 2026 10:25:09 -0400
Message-ID: <20261002142516.2063735-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142516.2063735-1-stefanb@linux.ibm.com>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abfbed9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=-V7DfVYgi2RuJlZc1c0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfXzDTa61AmL75n
 CSstE658E1snKp+TLJOrxZYH/h+15qsY88HY56J5UeZaFYleNfxCR4dl57SVyI4yzaJ9GIBF4Pd
 rkrEQfjO2Szd/K69KqWx1k39isr6v0c=
X-Proofpoint-ORIG-GUID: ksNSpIFnR1oppl-ADKkfRs2dXn7KIJLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX5anQ7rKEV1h6
 XUcAt2HUloE1JufAmY1fdygYfNyoc8nxzy+Mm21VSTQEWbwqlk0gPlvH6snyAieLph6cPwZCsIb
 qDI3xZWHa3u4S+4D/X7oDnk5jjS+WXSTXd6r+ZyZw5ZLLw9foXfBMEWUN9qrqJqZuttqLjRHtf9
 cpaqJhkB0Ir9PelzG3SJAJMVgdxbc2IrT5LizpkSlg2ihaFznbLLJdWoOXTosoAJXdk3RzP3sAw
 RZinJGAz7U9xfuJ2WQYOPF8e/bpnJyujuw0XvzPd+064hd3Gz08myE9wye1XmW4c7EhHEv/5ijv
 0YlLo9ck6kjHnvkmOtmtgkPwvIcAx564JjM3ReVKmeU0Trj8al0BhUvbRgLo9br5ffwszUfdyhf
 qDexNS8EJ9lvjkmaGEjdktUaembSn/UuNL1I6qQxvU4s47gXVBLX1VWWH8qZVkMtB46P7NCifWf
 wcQRh0gbeT78Q9J66zw==
X-Proofpoint-GUID: dwC0ugkrcNvxH7Dn3HUgHRt5EofjhXDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020056
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

Reject any TPM request from being sent to the TPM emulator that is shorter
than the size of the request header.

Fixes: f4ede81eed29 ("tpm: Added support for TPM emulator")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 9c95b4d878..0c9e32f36a 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -181,6 +181,11 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
     uint32_t to_read;
     ssize_t ret;
 
+    if (in_len < sizeof(struct tpm_req_hdr)) {
+        error_setg(errp, "tpm-emulator: invalid request size %u", in_len);
+        return -1;
+    }
+
     if (selftest_done) {
         *selftest_done = false;
         is_selftest = tpm_util_is_selftest(in, in_len);
-- 
2.55.0



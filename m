Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673F606A330
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g0AgFcgw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQYcM-00075h-Ak; Mon, 09 Nov 2026 18:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYcI-00073m-4t
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:17:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYcF-0008HK-JW
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:17:33 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LA3nK436069
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 23:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Dxs0YvnwDvO5S+XPcFbD6l
 OXasD5YuPdzHbwJlzawG0=; b=g0AgFcgwP4MtSQiCdxt1ISoAUVRbi5CSxUXYpI
 uWZM829CytKEv1TWhUViIG0WJpqApq1PqSQl+50e9dySlAMSCRKJe6xmJwE6wR/3
 XJ9jTpomV8y8Fch4kUtgkQxaNlICsYDV1VSH56eMSXvTCJNjIqkJr00ApXrT7Ktw
 YsUgzTk03h/QCbXHkHlKSwUqDM7FgDQVhxA7DJstI4oFMXiLBNelZyelwNRmtURS
 VTDmpUN6xUkcFPgx60kl+KTPLTEhQON81ciBW6dRa1q9UGFqz+5IT7I/GsR2x3I4
 U7BgKNkt9SwHToE6RGzOGRk+ydoEpv8IZwZTElGlVBNqncmw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcjae8w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 23:17:27 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9NHRua2509318; Mon, 9 Nov 2026 23:17:27 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 6A9NHRRx2509310
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 23:17:27 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id CA8A425178; Mon,  9 Nov 2026 15:17:26 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 0/3] target/hexagon: fix mttcg-related bugs
Date: Mon,  9 Nov 2026 15:17:23 -0800
Message-ID: <20261109231726.4062010-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: XNbIS3vuUkkqz05eLVcx0v0xMNDcOzcy
X-Proofpoint-ORIG-GUID: XNbIS3vuUkkqz05eLVcx0v0xMNDcOzcy
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af25487 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=68gcQpmAVwMFJMI-nd8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MiBTYWx0ZWRfX62pV/R2W86kO
 hQRYUNhiakLcO9KKLgi1nlq/oLBFVIYxJWBueieN22rNDDfgVMg7B8efPRkOu6Oed8RDFfe5gQK
 KXk3EKMYAD4aX7MQX5teRbmfFRhJngc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MiBTYWx0ZWRfX2GGomnbTYlGB
 3P8ZYFSif3Dpdg+q7zagJurAJjOsxcnq3J1qt4XsHv/FlUICJy7uXFqGNdAlWN/dV5cnCtB32p8
 RxOfKzPhM+zpJ5iIOxv65nhw9UGwGWq2vkxe31wI4kfrwoEqApycKF7pkk4aWGzc8a1/QGxcFUx
 lXxFGMg6U89t3+0K35eSPuBpkJ1voa2GLo3NU3mXpsFYaeZcKk4CdR298kwlQjaKo6fTqBTMP2c
 AZTCs9o8p1e3Ma9Bbj9n8/F/uOIBQCJIdXKYizsIa5dUf85wJS34BuhOE6XyY63mOsvi3Rq7sWj
 IoyAXSO/yfnfWvLxSo6nTIJTH/ppRKhB26snwlTxRqbSVXDzWArWr6PgB8YJFnZ3lTrYC5gOyVf
 HtTcmuk1L9uz+88F1mOil5pZr+UkapxkzQ4GgIrkpcxy/hLCvSh9w3MH48GU8GgayDWkufnCXOA
 3KIdFDUTdO11NpI3I4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Marco Liebel (3):
  target/hexagon: preserve guest event fault and CFI state
  target/hexagon: serialize TLB invalidation and IMASK access
  target/hexagon: leave stack exchange to virtual SPSWAP

 hw/hexagon/hexagon_tlb.c   |  1 +
 target/hexagon/genptr.c    | 17 +++++++++--------
 target/hexagon/hexswi.c    | 12 +++++-------
 target/hexagon/op_helper.c |  4 ++++
 target/hexagon/translate.c | 16 ++++++++++++----
 5 files changed, 31 insertions(+), 19 deletions(-)

-- 
2.43.0



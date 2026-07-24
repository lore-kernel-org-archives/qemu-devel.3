Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EEEC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFgR-0002mC-G3; Fri, 24 Jul 2026 09:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1wnFgB-0002im-LI; Fri, 24 Jul 2026 09:11:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1wnFg2-0004HJ-8J; Fri, 24 Jul 2026 09:10:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OCwHwS1776391; Fri, 24 Jul 2026 13:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:sender:subject:to; s=pp1; bh=8ZS5A67c7mqNInoNm+MkRDu
 pvqU+eN8i4bm4ZTCpfcQ=; b=G4yf/mMiaPi3fjsn5QCSUCqMJKHsuarfjYtMke9
 OZJKeNtC9/+bBrYnMj88+MRInY5aTZXoOo4ngpIV3HhMMj7E2P+dlv7ivE6CFkmd
 AwcBkfpSFVMkAq1f+m+2DMi+HEbSSSVHdOBUD+VLWlDnGjwjv+JRRsJuyc2R/h5X
 vVUa2MKXyIIv32E4SfW/Wmrs9CWsl1xOMqMLDrEOBEZgE/Vksvm+QsHzUKS0yFXk
 JPMFVPmnw7f7+Y1O9pY0wnf5r0and4APGojKQg4eX19Ppbjd6S3XWyHQQ3pbUFpe
 OCu6/RvQKcuw2VkYXzwENBCCH2vPiHEZ9gaqHJNpR8aEmtA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gm3uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 13:10:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OD4fGh003261;
 Fri, 24 Jul 2026 13:10:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahgy5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 13:10:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ODAmbc44564738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 13:10:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BBD220578;
 Fri, 24 Jul 2026 13:10:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00E3E2056E;
 Fri, 24 Jul 2026 13:10:40 +0000 (GMT)
Received: from vela (unknown [9.87.134.102])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 24 Jul 2026 13:10:39 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.4)
 (envelope-from <brueckner@linux.ibm.com>) id 1wnFfj-00000003x9p-2Cm7;
 Fri, 24 Jul 2026 15:10:39 +0200
Date: Fri, 24 Jul 2026 15:10:39 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, mhartmay@linux.ibm.com,
 david@kernel.org, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v1 1/1] target/s390x: Allow 2G hugepages guest backing
Message-ID: <amNkT9AjGbPwgXpO@linux.ibm.com>
References: <20260713155212.287444-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713155212.287444-1-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX077ZjE66KVsf
 gQ6CNpz5KtBdX/zc7hTkuGykELJcQZAR4UR8y7NIgQrLgwEVuTHeuPStCwXkIwMa6HwjK6+NT7G
 1rL8G6NCMvz9ezitmBUGr43t9HuuM6oHVdI4IMjHU8j8IFAXeA3NJ3sswCv3if0OfeM7BDSGXd9
 PCAHKV9VL+2Al1fA7Zox+2Jcz+vE2GLDwfucBF17m6CLQRexOFqABeP7b5z5KJYaAXm+0QIjhMm
 3rIHEUoryliqMg8Hzy/vY7yUskDuTCc/a21Ju7yTRsvwPuWGCz5J/+nv2L+yyHqzTsTFGkkafMS
 5bZMVs7JBPK2IuUqLC0YkpKHEMJcKBorC10Fi53NDkuTH3ECaSxyQR4zrfsIYI9LQ/V84wrvUgr
 94sGmyX0xrSBnQfcGfY+ZQ1ozl1zAZ6Cf7EMkSZkPsClnrNOoVE5NWOQskbtT3n00dFg4qQU86f
 sCNrMjzr//p0sb0jYrQ==
X-Proofpoint-GUID: Nt-NP926F0OsLFV6_oQM94G4P2X7fkJB
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a63645d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=y5kb3azYzRo2SqOjEfwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX0lTb9SM3erCA
 k1pFmGYJTKsJNI8CoFJb/XOADzotnpwUjxEpcG8VdLj3R5o9frbpPc6AZG5gBhnmj9zhI4SJEGh
 Xo5lvu3MVsGC4Yn2lgcTNyT6MP4Rb70=
X-Proofpoint-ORIG-GUID: Nt-NP926F0OsLFV6_oQM94G4P2X7fkJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240115
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Mon, Jul 13, 2026 at 05:52:12PM +0200, Claudio Imbrenda wrote:
> Allow mapping guest with 2G hugepages on hosts that support it.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>


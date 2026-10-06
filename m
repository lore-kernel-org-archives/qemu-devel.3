Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7CBCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5F-0005av-Pp; Wed, 07 Oct 2026 04:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xEHns-0006hQ-2h; Tue, 06 Oct 2026 22:54:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xEHnU-0004p9-8d; Tue, 06 Oct 2026 22:54:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696EZPE74058940; Tue, 6 Oct 2026 16:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Od1PUZ
 HKrpp1ge5U8KZedKBhXbOCHEwYSiqa+V0bdSQ=; b=dI4Y22CG61Ri9JyErqFxSg
 gEW6ugYy6ScLbTERX7WmBsYMZ9unQtvZlhh8wQEIjKCkNkhFSW5GyaGv4LM52naK
 7lxqkYEAMncInKokzRnd5NfS+JigWJRyoxJYK8H4cbH8ADe9F1ZDFjSYBk2Lm91X
 E+Ss7oLoHCy5F4nAg4TbuFQICoNYBK6FUkITLcPyhS3QH58oI+oTtthqK6QAOz8Q
 saWFDjtQsWhj2/5NyixGvmhyRWF+ZE9XCenTBWllxFyeEN2TJXUltOb0Bui5kw3Y
 5i/JPdYusi/Ruxv4a4LqZ4YWhTfgYxvqFBNsJYDn+Mo/gI+UaF6ccctP/9CyeBBg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74s785-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 16:45:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696EHYfG3343584; Tue, 6 Oct 2026 16:45:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8gak8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 16:45:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696GjHZL57934170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 16:45:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F0CD58066;
 Tue,  6 Oct 2026 16:45:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 246505804B;
 Tue,  6 Oct 2026 16:45:16 +0000 (GMT)
Received: from [9.61.15.56] (unknown [9.61.15.56])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 16:45:15 +0000 (GMT)
Message-ID: <459e4707-5975-4ea7-a40a-14d5acf309ca@linux.ibm.com>
Date: Tue, 6 Oct 2026 12:45:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 14/17] s390x/pci: Move ioat sanity checks into new
 function, add error message
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20261006001643.420929-1-kshk@linux.ibm.com>
 <20261006001643.420929-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261006001643.420929-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2DQTBPQNtBOAwXOUFQIvvSJnCe0AIGrp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2NiBTYWx0ZWRfX3YqTjK7CjHd3
 RqLmGzCmj/ZdEUaAcK0kmJxlPypDmWqvouS0HuxmpXIdTpTAmPkLJaqysed9U91XYd31le2WexH
 ES7PatoHHkqM3jJDOXsSV2zhwIhEXjg=
X-Proofpoint-GUID: 2DQTBPQNtBOAwXOUFQIvvSJnCe0AIGrp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2NiBTYWx0ZWRfX3ztUFRzC7H3P
 d0lIYVdvAjzLinezpusrEyJhDCpMSTQlUsnY4BSEcfyCvzs4H6P2jHHHWpmMjt24t9h/Mw1Y3RB
 NvP0opj6dAPDyTGk+fB1IwGIHywjk2KiDloKd7k9SqhoSeKueELSG1+y+VX7S+ewvyrs//swuqc
 4kLEvA6L+ziJ8t1h3BwlQaoBSKLC5wlIuCKgLXMyQEGn3b53N03vlzb7Sg6S9RbJ3fwi8U4+LO9
 9LSx/DcMHo+BYE0fQ8q5sfqBGlxfd/yb6ZDoP5M4aZfsYPZD0JwDw57Hh0i63zo+1lGm75CMPQj
 gn8ddrYJaBamq+v7K0ZFF0hx1utI6wYttSnKEir9uUvTIPr4yitINY9/O0wKSRBsjM6X2c1nvMa
 l34keViylVPsXz8wMbbTf8fpGFk8m2en76+pbSgZK6+7armJ8IYuk0sXMnwMETlDVdJXge/Fc7R
 EDF9+KRsB4yySQ5sTvA==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac5259f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=uXjbfB2GlpuXPimeogYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060066
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 10/5/26 8:16 PM, Konstantin Shkolnyy wrote:
> Extract the pba, pal and g_iota checks from reg_ioat() into a function.
> Make it external so that it can also be used in a follow up change.
> Provide a new error message to the path that didn't have it.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



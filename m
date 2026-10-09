Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3225ACA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 20:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFHLX-0002hG-KB; Fri, 09 Oct 2026 16:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xFHLW-0002gr-Av; Fri, 09 Oct 2026 16:37:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xFHLU-0007mu-UK; Fri, 09 Oct 2026 16:37:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699K5UEg1043512; Fri, 9 Oct 2026 20:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8H+Wcl
 YMMXC90oOahJmnFVUxVz296HGiyZuW2F4h8iU=; b=XrFrJOoMVY5os4oAPo3UJL
 /5huTwAz1vqsm6oBPJBn1BNw9ap0Zh6Mzs+PodcW/TDUsk8Ni6LxU3ivb+JT43s7
 tI6vZq9qEDRjZNNsOMhE5FJpJiUp7fV4n+PcyCwpP4bvq95zJ9WEUMKN55ogBRLh
 CjxZGiiVYhA5fuoj3wOBm4M7eMC8hF9NiMb2UvXiutzjg20dN7ih2jbwYV9hh+k7
 fEYDM3DTrmVDFLcMnC4TFQifeEtF4eWZPbOlfheqb671R7s/c4JN/yxugJXuhnH+
 aUrp+DMx3REZc57Pqj1r4e3cDoDr4FfAu5AVoiZAONtY2HH8sRqE8e9mOkLx0qHA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdrrdp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 20:37:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699K381N1401806; Fri, 9 Oct 2026 20:37:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6x1ya6n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 20:37:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699KbVmF12845806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 20:37:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E25F55805D;
 Fri,  9 Oct 2026 20:37:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E851258054;
 Fri,  9 Oct 2026 20:37:29 +0000 (GMT)
Received: from [9.61.169.201] (unknown [9.61.169.201])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 20:37:29 +0000 (GMT)
Message-ID: <181fe624-4d05-46e8-adaf-7d8a28ab37ea@linux.ibm.com>
Date: Fri, 9 Oct 2026 16:37:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/s390x: externalize feat dependency array
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
References: <20261009185559.144750-1-walling@linux.ibm.com>
 <20261009185559.144750-2-walling@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261009185559.144750-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JL6uIMKb c=1 sm=1 tr=0 ts=6ac9508c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ABRlNWfGXBEpqx2KECkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mDj2QtJzq-9VN6WS47MFXWXhS14p1NWU
X-Proofpoint-GUID: mDj2QtJzq-9VN6WS47MFXWXhS14p1NWU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4MiBTYWx0ZWRfXz5QjjNwed42t
 CL3D1qiYe9azX7+THK0PAX2Tq5+Znk8gKGggc+Os3W0c7jragKO/WM7GV2bKfsdPXnGc9fxOtvR
 UhimNlVAptt4Pa/6GaHdCgutcRfvhqc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4MiBTYWx0ZWRfX9uQtWit7I55J
 hCEwyGwjorbsjZAjU0GN02AMzeK2Nsl/f5Kl4CJC72SvfzEvCnkgLGfkoL/rlfZaiurjBXQCcsh
 uSo+3O6CwrPH92DXmoUar5xV2qPTmPUaA9Qs8ue9Ua1NMA1/8/Bl8HViBu8POcvIjomh+PLx61t
 SddNOKozENIpFRH58pDJDH7EExXF6gsepKrVMM91b+j2AyTg9WB3vchFfRkZirm0Rrdgn+1oJ6m
 qzmX0XUnpX7bf+lLpoNzxELodyIUIlVT3R2kqJWObjPgu2/nfXtUsPE7W1bdgLlUeXXTg1X4AEs
 fpc2yqcSWGOPgnma9A6Y4FsIz625iLS4oAZaWQau7jB/wxPj5dvbHBmRVUWkXV1oabM/gn7TPK5
 SOClGV8ze/yGq9W3c7wBUHpkwSaTna7sO5Jl12shbXFVFe3b25QV8UpTaO1ydeH5nrvB/20dTaB
 H3cpuNisCGMgkBLq7cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090082
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 10/9/26 2:55 PM, Collin Walling wrote:
> Move the feature dependency array (dep[][2]) from cpu_models.c to
> cpu_features.c, rename the array to s390_feat_deps, and externalize
> its length.
> 
> This will allow the array to be used between both files.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>




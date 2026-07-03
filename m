Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B15C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhhV-00026s-3Z; Fri, 03 Jul 2026 13:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhh9-00025Q-3X; Fri, 03 Jul 2026 13:28:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhh4-0001iq-GD; Fri, 03 Jul 2026 13:28:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJYPS3237925; Fri, 3 Jul 2026 17:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EnjHtg
 1y4sDwSsQNA1+mkaOKajjdL8tYOOhn2aU15D8=; b=PANXsC/31lM0vNPNi21SM2
 UXal5cBPO//7PyOgccAeiVgDR0PoYxM/3fZTWbJidkpdsbePEfR9Sbm2BUmyNo5j
 WQTn9oAZBCeT81YC5c58NobwzO0mEBxEs5RbmvbrOgfKl+td3/m4z4LnKYwNQRyU
 Pjebb12TUq0gghTc/C4EXcTv4EbjPO8u3P9AQ5q1zA2NKlhVK+C86CZFJRg5wpoV
 ONmGow9+wXv+1N7xHW3W+dQSX2mNhkR3kIPL2F6F6fjpavoajgCrd+MX66/rq+zj
 7dwEe+d3Jgp3ddVzSCz3MH6RJW0l4ACEGtd7PqSWoZutVV2OGtLwarBkWpd6M5bw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rffq7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:28:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663HJfXY003432;
 Fri, 3 Jul 2026 17:28:45 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhsrye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:28:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663HSiWG32899824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:28:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBA3958055;
 Fri,  3 Jul 2026 17:28:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6FEF5804E;
 Fri,  3 Jul 2026 17:28:41 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:28:41 +0000 (GMT)
Message-ID: <20eac55a-fbf6-4925-b985-5241b85315ec@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:28:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 29/33] pc-bios/s390-ccw: Handle true secure IPL mode
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
 <20260703170032.1893204-30-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260703170032.1893204-30-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47f14e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=TxIP-j2WU5fxC9swgMYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: p9M4o32JUpjv98I6X3M2SpsYYUbA0Mt_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfXxBKUOJDbGWaJ
 0U9/F2U1+vgzU/fkUbT6/lSRS5oPl0Q0EyRr6c8TVpRUGbku/mCLtDu2E5GOJnLiZRaFtUTyEc9
 uDGL/ifp1wiQdOO0f5U+zJm41Iw5kqa+uZ/lQ7OO3k3MLcySsAHTJxxs5gXr1AC+n5f3JKPhazc
 oQ4NFn4dCcs9/MqzoerS8/MqGiHqcuXMBA+xDKVpFcWRxh6plIbAvz/riYL9APH/QgOFKhgx0mN
 /a/ephvrBGV4+Uy5xnIf76xnlcCTxbaXgpPSX/SWDLOSbIWdkUlA2mgh2bvYk5a9oepRJcsuuHj
 frFmrJ7uOXFK6wOZOcvPyEC6lbd5e+IDqKvhNwFxJnSEE99w3OgIGEY7gOqVptc/64skyBIX/yg
 EWROQtCTqTMAt7xb6PSBqaU+f2Jnofa37CNW0Zh4ewEPv6Z5ixsfTwSWpkYqHMTvCYkOu8Y3K9A
 cQbChBTZYNOusJxkRgg==
X-Proofpoint-GUID: p9M4o32JUpjv98I6X3M2SpsYYUbA0Mt_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfXzQqC93ibLQfi
 JvK7LeOK77t/fv62niHgY5EtIftKeecJuPAuHZ0x3aOZp5s2ICDcNUY4aCSHzR2JJs2sCbpdK/+
 tEeZYAF1QGUjuFuTAuxsjzmqcKO5aUo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030173
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

On 7/3/26 1:00 PM, Zhuoying Cai wrote:
> When secure boot is enabled (-secure-boot on) and certificate(s) are
> provided, the boot operates in True Secure IPL mode.
> 
> Any verification error during True Secure IPL mode will cause the
> entire boot process to terminate.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities. If secure boot is enabled
> but no certificate is provided, the boot process will also terminate, as
> this is not a valid secure boot configuration.
> 
> Note: True Secure IPL mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>




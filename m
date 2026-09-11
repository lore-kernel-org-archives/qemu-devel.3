Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BE2C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53JS-0004Ts-Aw; Fri, 11 Sep 2026 11:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x53JO-0004TO-2R; Fri, 11 Sep 2026 11:37:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x53JL-0001IZ-Dz; Fri, 11 Sep 2026 11:37:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1WoS2143612; Fri, 11 Sep 2026 15:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=esfT4z
 d7fNL8YSXk8r9UKtK3mhLZs6rJQkSvPtgye4w=; b=RhAmsPqk7CNPJOnlfq1lP9
 MxBE5wRK5chl5Tdx90OLM+MuqTcmBQXNzOpgbpSOD7l9C3LHwKURd4SLT9nWadSG
 fTWfJc9mtW2/s/A9OeifSBFmuYJCMDCycMmhIin880W8z2m5JUZlbTpRu0HUEEv3
 U9wJE+KGejnxsal3WqQw/mG366qWZuu8CsTkHUb/Pb4XseiuX2GpJ/HYUt4bTMUA
 8cikdBRcsDcNEFoSZW5LYwInnDp4HXNHrVCJL5rBoOjaF6O/elNlbDU+89vA/Zwm
 PU/cqhPilEi2AgqD8EzMbww75+V2kYFiSBB8+uyjSmdTpz1tndsd1CapWUMDLNcg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8t4afu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:37:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEoCjY1817586; Fri, 11 Sep 2026 15:37:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvnrq4qs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:37:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFb1A32622104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:37:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDBF758052;
 Fri, 11 Sep 2026 15:37:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5893958045;
 Fri, 11 Sep 2026 15:37:00 +0000 (GMT)
Received: from [9.61.96.29] (unknown [9.61.96.29])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 15:37:00 +0000 (GMT)
Message-ID: <85cbd068-dfcc-4a43-a4ba-abe83273565b@linux.ibm.com>
Date: Fri, 11 Sep 2026 11:36:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-7-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxNyBTYWx0ZWRfX/qUDtPzrnkBQ
 Awh+fCHM1VN3NjeFm5kCDb3qkogvNseWfqZWxUf30/R/YrEoRyCvFFALq14EzOfH1BGq3DErk+R
 HESrN1kqVQpBql6dosutmfeLyu24/YQ=
X-Proofpoint-ORIG-GUID: 8hDJBuz1PE7NoDPH5h4e7QzzVxyzWFG-
X-Proofpoint-GUID: 8hDJBuz1PE7NoDPH5h4e7QzzVxyzWFG-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxNyBTYWx0ZWRfXzGdSCZBs7hdh
 KMiH2skL4NFNV8NK0fSHUactwFWEfmWZ2mgeOeu4VO9nD9DXJOfGq7iD4+a+6IHszfGnd7UUTQD
 iv4nrjjNYXbt5UleVnYNvEwlohTZg/zsbH0e9e4laU8Rzr9NVJmK1N0hm9GoLOvBkHzNUzrMz1W
 k2Pm/Up5OUYaUqK5qL8qf6Sa/kAMPH9ps9s22cc/loL1HpNxXHrye9hEMIwBymNDtue8XaXG8TG
 3HgjAbqsdpY2FVi8IbYvWtEcZ+ozdECwWVU965bszWj4jER3Kl6skmcLCxFcc8d2hRcrC2DIuwU
 OYTvbV4Y6UaT4/k91RLOFdFai2W0Oopx/cAHCe/o7X3kmv3UyeWStmwagcoozbhev+HJjghnBIK
 bJo8rQJ9+wyFCGbD5bcMuZrpUHxh5t69gwomOgIXCuNNkd7oyfMqHn4T5GKEjMmZLaXfUnCDkLP
 wJgRsWygCx6Mg2+dwEg==
X-Authority-Analysis: v=2.4 cv=PIGaavqC c=1 sm=1 tr=0 ts=6aa4201f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=hNTO0ZySSFXKkZstvnIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110217
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

On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> Add test coverage for virtio-net-pci network booting on s390x by
> including it in the PXE test suite. The test verifies that PXE
> network booting works correctly with virtio-net-pci devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Tested-by: Joshua Daley <jdaley@linux.ibm.com>

Realized I shared some findings off-list, but never included them here.

> ---
>  tests/qtest/meson.build | 1 +
>  tests/qtest/pxe-test.c  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 50a1a5272f..654e145fbe 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -289,6 +289,7 @@ qtests_aarch64 = \
>     'migration-test']
>  
>  qtests_s390x = \
> +  (slirp.found() ? ['pxe-test'] : []) + \

AFAICT this patch not only adds pci testing, but re-enables pxe-test for
virtio-net-ccw.  Sounds like this got accidentally removed along the way?

If that's the case I think this should be its own fix patch.

Alternatively, at least mention it in the commit subject/message.

>    qtests_filter + \
>    ['boot-serial-test',
>     'drive_del-test',
> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> index e85dec5a4e..bfa3b98cad 100644
> --- a/tests/qtest/pxe-test.c
> +++ b/tests/qtest/pxe-test.c
> @@ -60,6 +60,7 @@ static testdef_t ppc64_tests_slow[] = {
>  
>  static testdef_t s390x_tests[] = {
>      { "s390-ccw-virtio", "virtio-net-ccw" },
> +    { "s390-ccw-virtio", "virtio-net-pci" },

I noticed that if I attempt to run this test using a bios that is not
built with this series included, the virtio-net-pci test does not fail
gracefully.

Joy investigated, turns out instead of detecting the condition (no
suitable device found) the tests simply get killed by timeout; would be
good to detect this condition for s390x if possible.

Thanks,
Matt

>      { NULL },
>  };
>  



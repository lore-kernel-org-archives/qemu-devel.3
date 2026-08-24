Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806ADC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXj1-0007KH-2k; Mon, 24 Aug 2026 12:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wyXiz-0007Jm-0X; Mon, 24 Aug 2026 12:40:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wyXix-0008O3-8b; Mon, 24 Aug 2026 12:40:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OG1btr2373315; Mon, 24 Aug 2026 16:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eWmd3K
 sr+eYcwBBmT95QKVUstPjl7rCJ/2At2iDkc4c=; b=oLsATe/R5WVuIFKmZDSzTM
 wn5lq6PkW+vkGF4CaBlnBTREeh5IwC9d7uHR6B6xmnFQGCx5iBk0DOV7uikKvubZ
 vLNPgtYrTWQtX9ET4DSSIFoyJOIob6pnYuDN2s6uTXvMdopfu6mZCiaq9bWdB9zV
 S0YoPU/aSKHV1lDA8S8vkjQMhQeIDPo12oOmj22dsvTUEu5hOBQ7w6sr+cQ9wqLe
 CMeR45ToAoXSCpUwigr2rp8Wup2wYIY9RN7b0EWsDYH0TLXVKYB7QFsZ3PoDnYRP
 gM+hWL/CStbMAkn3R3nLBqLfmGDrBR0cTeE4KD20RGdb9yp9XiiQZl3T6X1R4BkA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4jqwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 16:40:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OGQKLD032555;
 Mon, 24 Aug 2026 16:40:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvya40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 16:40:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OGeVfh31064760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 16:40:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4851158045;
 Mon, 24 Aug 2026 16:40:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2242158052;
 Mon, 24 Aug 2026 16:40:30 +0000 (GMT)
Received: from [9.61.26.206] (unknown [9.61.26.206])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 16:40:30 +0000 (GMT)
Message-ID: <0e55b6cf-6953-42c8-9102-932aeaf3661c@linux.ibm.com>
Date: Mon, 24 Aug 2026 12:40:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] tests/functional/s390x/test_secure_ipl: Skip test
 if SIPL not supported by hypervisor
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-3-jdaley@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20260812152112.3330493-3-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OFqxIe3BToX-aRJj3lDxO0oOXwkU4Dec
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfX0wLNgFhF3W5t
 cy3GICT9OzxU1wg11NdoNq5nELI3Mh4q69Q43v9jmRaiRp+FOQFb6I0VIgzOrbRh/OOZf9AUHWA
 6gObCMOQTUhzLZGdQqMvT9La0z+r6ow=
X-Proofpoint-GUID: OFqxIe3BToX-aRJj3lDxO0oOXwkU4Dec
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c7401 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=KwKIQBDO4BPv--znDUcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfXz2unmGVCqdZ8
 xGW6DiTuEk9zEdOnwLjHEgoeChYH7Zj4BCg+aK3JF+y8JLMaRDqquQ7yAlsGYzB8WyRpnIFE/Fh
 IIAXNCl8sYKnr+kImbY43TKDJJxgAYWNJmND2v5LZFmcSAL0uO8V0TOPvqST5pejYWJsU4nohXZ
 rEw76pJFnnQsag4OoUoTZFyJekimsLghojZeaoHQRoXSLHdZ288fCMQi8e8uTa1JK1RkM6N/uaH
 KVorc2ek73W+LUHx3MfYBfPm04RUI8FB0ffqhKGpFYVrhDaCdAH1YqXLTAQ6uU01dbZCgdK1F2i
 /YoMqfbuuZVrr0MJC/gTXXe7/jHtfaiSIFXczxdiSPgtLQrjCSsljJrjZmfyw6Y9BaUSVaOdPbm
 Ri9ba5TpS2VCp7IRF9xNfx5e7H6aw2wxXpxQlyeEbmJKbfaxkCDQeMY+Y8GdyKrk9yokBGXeWpA
 FCtKHwgKG5cw12hz3ZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240139
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>

On 8/12/26 11:21 AM, Joshua Daley wrote:
> Currently, if secure IPL is not supported by the hypervisor, the test
> will fail because "Verified component" never appears. One must inspect
> the console log to observe the cause of the failure.
> 
> Add a check that skips the test if the host CPU model is missing the
> secure IPL facilities.
> 
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> ---
>  tests/functional/s390x/test_secure_ipl.py | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
> index 06fc93e404..5af36b91d8 100755
> --- a/tests/functional/s390x/test_secure_ipl.py
> +++ b/tests/functional/s390x/test_secure_ipl.py
> @@ -29,6 +29,22 @@ def __init__(self, *args, **kwargs):
>          self.cert_path = None
>          self.prompt = None
>  
> +    def _require_host_secure_ipl_support(self, vm):
> +        """
> +        Skip the test if the host CPU model does not expose the Secure IPL
> +        facilities (sipl, sclaf, cstore).
> +        """
> +        props = vm.cmd('query-cpu-model-expansion',
> +                       model={'name': 'host'},
> +                       type='full')['model']['props']
> +        missing = [f for f in ('sipl', 'sclaf', 'cstore')
> +                   if not props.get(f)]
> +        if missing:
> +            self.skipTest(
> +                f"Host CPU does not support Secure IPL: "
> +                f"missing feature(s): {', '.join(missing)}. "
> +                f"Secure IPL requires a z16+ host.")
> +
>      def _create_certificate(self, vm):
>          """Generate x509 certificate"""
>          exec_command_and_wait_for_pattern(self,
> @@ -107,6 +123,8 @@ def setup_s390x_secure_ipl(self):
>                           '-device', 'virtio-blk-ccw,drive=drive0,bootindex=1')
>          temp_vm.launch()
>  
> +        self._require_host_secure_ipl_support(temp_vm)
> +
>          # Initial root account setup (Fedora first boot screen)
>          self.root_password = 'fedora40password'
>          wait_for_console_pattern(self, 'Please make a selection from the above',



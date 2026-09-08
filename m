Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44868C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3wIE-0001zH-5Y; Tue, 08 Sep 2026 09:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x3wIC-0001yw-3P; Tue, 08 Sep 2026 09:55:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x3wI7-0005Ax-8P; Tue, 08 Sep 2026 09:55:18 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688D1cKZ829942; Tue, 8 Sep 2026 13:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4rai7g
 TNIKWUk7HhBpaAbE4TC4qfPJIe8dN3wcFYEMM=; b=k3IIemUie8M4C57aZFrXyz
 zvo3MlhREME11BN2ZIAUiL7ziMdBVm7jV0tx3yGlfNoPpnVaDdqgSv0XTg4T/vhT
 fRm9EJmFUNA0K/0CPy+t/SlGjY6/rDIQURagwCkB5EA7cCe20u4ypepsiCzkYuZu
 i1G0M5JaNrlTsp96Z70n1TyD3GInHHE8IwLC2FWqhjOtmE6XvJf+Py4FrUr4REDC
 ZWh8bNsXH3CSw2k0kwXpqDnhhzLfQ/C+b3wmkp0TRbEZRHwUSyjYu72Sh4/8X/WK
 3n25FG4YwXDq1Zo5f+QfDTf0PqUVwdx2prlWJu5kA1oJ27M3hnzDfGiH504N0XhA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj872pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 13:55:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688Dfhie001605;
 Tue, 8 Sep 2026 13:55:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdjv5s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 13:55:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688Dt6F831130218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 13:55:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFEC258062;
 Tue,  8 Sep 2026 13:55:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 214B158056;
 Tue,  8 Sep 2026 13:55:04 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  8 Sep 2026 13:55:04 +0000 (GMT)
Message-ID: <be273699-1b13-4322-8464-2d885e5c099c@linux.ibm.com>
Date: Tue, 8 Sep 2026 09:55:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hw/s390x/ipl: fix short SCSI loadparm buffer over-read
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-9-2b21e63974f3@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260906-nohmp-next-v1-9-2b21e63974f3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VvqQ7xoucm8oeF2Gu18i56KSqCD80p57
X-Proofpoint-ORIG-GUID: VvqQ7xoucm8oeF2Gu18i56KSqCD80p57
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa013bc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=hQ0H9E2K9RfbYFU5mVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfXww6C3zljSRAH
 AGUWtB60/FmGtc+Unsz5U1fD98bCUVBtIjuatHWs0tWpYxkJDvFx5j98UeiCTRuS7+5I7J52L35
 BEa3uVdGkInzlD6Gx//dmFUki90nHfQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0NSBTYWx0ZWRfXwsQJTBe5A7E4
 gJDN4heMt57K3OpXxWr2Z+9vr9u28DLhO8iJRPzdHtRnCjQn2cZsyMwAG6Uv2wzWfAMP1OJZGxI
 VfI3CvN0EHLmauHUwzZxq9kz2X8R7JFFlEZ9kcaLqfCDAEp/FakparrpinWb2ue4t2lqCn2iVId
 NK7RB1pRPzanToXsGeAOiDNg0zLQhctc7ph1jFL8O3fAa+QZA22xZXH3HR3JN+GN95hFHpRbOz8
 vH66eBi8N0phngC1j1MS4H5qvXpamokEHUCVBeqg5qOnOTkxQhizI717D7ft7Cv/vxA4KWqthD+
 senm5zWDXteS/9gHV83Ft1EHCRMNSHCttxWXVt7HRGMDZlK91Euyq0bB0rAVVmsEVRX3M7fR/aB
 gij7KIOxi39a5J1ImT4kEno2qNtFuB3w1+Foz/j9cdDjfI9D1dva4toa/ZoYWYT6ZTIAyVWKOX8
 PbD8piGxJgPX2jIAkEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 9/6/26 4:53 AM, Marc-André Lureau wrote:
> s390_build_iplb() initially points lp at the eight-byte CCW loadparm
> array. For SCSI devices, it can replace lp with a variable-length string
> returned by object_property_get_str().
>
> The following memcmp() still reads eight bytes. ASan reports
> buffer-overflow on value "3", when running test_scsi_loadparm
> func-s390x-boot_4k test.
>
> Check the fixed-size CCW loadparm for the 8-zero before the SCSI
> property can replace lp.
>
> Fixes: 429442e52d94 ("hw: Add "loadparm" property to scsi disk devices for booting on s390x")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

>   hw/s390x/ipl.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d59ed36c7839..e249d50b1ce3 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -549,6 +549,11 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>       if (ccw_dev) {
>           lp = ccw_dev->loadparm;
>   
> +        /* If the device loadparm is empty use the global machine loadparm */
> +        if (memcmp(lp, NO_LOADPARM, 8) == 0) {
> +            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
> +        }
> +
>           switch (devtype) {
>           case CCW_DEVTYPE_SCSI:
>               sd = SCSI_DEVICE(dev_st);
> @@ -583,11 +588,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>               break;
>           }
>   
> -        /* If the device loadparm is empty use the global machine loadparm */
> -        if (memcmp(lp, NO_LOADPARM, 8) == 0) {
> -            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
> -        }
> -
>           s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>           iplb->flags |= DIAG308_FLAGS_LP_VALID;
>   
>


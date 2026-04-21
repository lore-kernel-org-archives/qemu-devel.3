Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975A8F94CA3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 18:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFFPo-0006Je-Pv; Tue, 21 Apr 2026 14:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wFFPM-0006I0-At; Tue, 21 Apr 2026 14:01:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wFFPK-00009O-5Q; Tue, 21 Apr 2026 14:01:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LHoArS529198; Tue, 21 Apr 2026 18:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UsgVcS
 WBd3KZf3iE5NhxANDaZ6bADAFSUbwJfVam5rs=; b=DvXnY19ODe5xX8kWXfoUAz
 75ci5Fs1K5PFU4HgrfEukujfgBboedDi/ekLgKTMKQeBljGARPX0ighe1wEITmTh
 asb0BHK7ja3IsmjQCtQz1n09RKS5/V3jL97NN3KlW5xMF7DdvHLt2vNQ7wCtejwM
 o5xmUTYcx2DOw5eDQeGGB7YbqelTeebtgq/YbcZ7LFEckw6v93/2q9cDOrglt0CI
 N/PpG0K3Y/0HF5aSx3zr+XIK5qrw6zwhG6I/rwcOJZptReGVIFSaQlQ5f1+5hbJp
 rpQkmn4ePlh5eMWGQlDp+muNVsBshZmkVzYYw6tzLGH5pryBFtUPNASwS7j+E4Qg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6nn4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 18:01:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LHZOCr009878;
 Tue, 21 Apr 2026 18:01:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9k1s2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 18:01:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63LI0Zki11600542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 18:00:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 520435805A;
 Tue, 21 Apr 2026 18:01:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A2EC58052;
 Tue, 21 Apr 2026 18:01:00 +0000 (GMT)
Received: from [9.61.174.150] (unknown [9.61.174.150])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 18:01:00 +0000 (GMT)
Message-ID: <01fcaa3c-97f8-4572-98df-10669e835f19@linux.ibm.com>
Date: Tue, 21 Apr 2026 14:01:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] hw/s390x/ccw: Disable legacy virtio-pci by default
 (v11.1+)
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260420144759.2970726-1-jhkim@linux.ibm.com>
 <20260420144759.2970726-2-jhkim@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260420144759.2970726-2-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NyBTYWx0ZWRfX0Un3tiXPlN79
 h/saE+aV9oj7OvSoyZBZwiZG1lBObVuBchoqKd8rbIwSHMlt9glyPDNf3gj7BOnHLr9Ea4JipMX
 Dd0QghAFAxmUNegXszCQP2MkHs9RkrH7iyEZCskCqShSb5ffIUxzUdvGlLy5zO+yPLepjZal4u0
 rxeJqd5VWF5o8b22GUHHzZYXQCoWEpuTaMRFoVMZfiuCdTE38bCefhuHrF1c5/k8H360EKrTho7
 z1ECw0uT7aWAhKQi66toXXZ/z2FFP7EZ5YmZG5ghMCGwSTXQAPDIzFFoxB8IcvSR0Dv2we8XfGU
 kQqlhMa5Kzx01WYLExddGMYUkMzUp76HTGR7c4DqYhP8EvMFH9u3XGsoAY7k5Z/Z8D86CjZ1Huf
 XRB3AHhsNOsILKq/vIN6+nqOmY0H+9hIGR4AWln7aiUuljpyIDd592jtouJb33TIjtbJV5LKP1l
 00fpH8snpetpXHtGwVA==
X-Proofpoint-GUID: kPPHuEr8rjj5y0NI6AeolhxcXEyb9h18
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e7bb60 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=09yA2x9RGatdvKftA9EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kPPHuEr8rjj5y0NI6AeolhxcXEyb9h18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210177
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

On 4/20/26 10:47 AM, Jaehoon Kim wrote:
> On the s390 Linux kernel, IO_SPACE_LIMIT has been 0 since the initial
> zPCI implementation (commit cd24834130ac "s390/pci: base support"),
> making I/O BARs unusable.
> 
> However, when virtio-pci devices operate in transitional mode, QEMU
> unconditionally exposes the legacy interface via BAR0. This results in
> firmware warnings during PCI enumeration, such as:
> 
>   pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size
> 
> even though BAR0 is never usable on the s390 kernel.
> 
> Close this gap by disabling legacy virtio-pci support starting from
> machine version 11.1. This effectively makes virtio-pci devices
> non-transitional and prevents the creation of the unusable legacy I/O
> BAR.
> 
> This introduces s390x-specific global compatibility properties that
> set disable-legacy=on as the default for virtio-pci devices. Machine
> versions v11.0 and earlier set disable-legacy=off to maintain their
> original default behavior (legacy support enabled), ensuring VMs
> created with those versions continue to work identically.
> 
> Users can override the default on the command line if needed:
>   - On v11.1+: -global virtio-pci.disable-legacy=off (to enable legacy)
>   - On v11.0-: -global virtio-pci.disable-legacy=on (to disable legacy)
> 
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Code looks good to me:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

I also took the patch (along with 11.1 compat machine update) and did a
general regression of various virtio-pci devices with kvm-accelerated
s390x guests using s390-ccw-virtio-11.1.

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

Thanks Jaehoon!

> ---
>  hw/s390x/s390-virtio-ccw.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index cc768daeb0..4d35f9b10b 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -788,6 +788,21 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>      g_free(val);
>  }
>  
> + /*
> +  * S390x-specific global compatibility properties.
> +  *
> +  * On the s390 kernel, legacy virtio-pci is not usable because I/O BARs
> +  * are not supported (IO_SPACE_LIMIT is 0), and would only result in
> +  * unusable BARs and firmware warnings.
> +  *
> +  * Therefore, starting from v11.1, disable legacy virtio-pci by default,
> +  * while older machine types keep legacy behavior for compatibility.
> +  */
> +static GlobalProperty hw_compat_s390x[] = {
> +    { TYPE_VIRTIO_PCI, "disable-legacy", "on", .optional = true},
> +};
> +static const size_t hw_compat_s390x_len = G_N_ELEMENTS(hw_compat_s390x);
> +
>  static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -878,6 +893,9 @@ static const TypeInfo ccw_machine_info = {
>          const void *data)                                                     \
>      {                                                                         \
>          MachineClass *mc = MACHINE_CLASS(oc);                                 \
> +        /* Apply global s390x-wide default properties */                      \
> +        compat_props_add(mc->compat_props, hw_compat_s390x,                   \
> +                         hw_compat_s390x_len);                                \
>          MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
>          mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
>          mc->init = MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__);              \
> @@ -923,7 +941,15 @@ static void ccw_machine_11_0_instance_options(MachineState *machine)
>  
>  static void ccw_machine_11_0_class_options(MachineClass *mc)
>  {
> +    /*
> +     * Preserve v11.0 and older version behavior:
> +     * keep legacy virtio-pci enabled.
> +     */
> +    static GlobalProperty compat[] = {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "off" },
> +    };
>      ccw_machine_11_1_class_options(mc);
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>      compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>  }
>  DEFINE_CCW_MACHINE(11, 0);



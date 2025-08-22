Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2630CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSZO-0000C5-07; Fri, 22 Aug 2025 10:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1upSZJ-0000Ap-B1; Fri, 22 Aug 2025 10:16:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1upSZD-0007wV-Aa; Fri, 22 Aug 2025 10:16:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M9CKqX012122;
 Fri, 22 Aug 2025 14:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Fi+Ab3Zfd7AsiVm0oH7J4X4uKZMf+pBGmIdWC98fHjE=; b=o1/KSMxniylv
 vjoQgYjgUvABMcdoXiwwLc7TPXvISROhTBI8+xHa2bCnovV799fK4kh1b4wH1Yqy
 USCr6ihOmHCSycNJg6xThkonLHu/mY+N6dG5QxgZy6CusUwAP+9n8+1ohLd6YW1I
 E5mYNz1oNhiP/E2Z5VpvkrXy3P9l6pviIeEh2LdRRF4H5Dqvh649/RMOdFdfOlA3
 mqowWevZ6dKKEBGOGFcvkWPvUQnImOxTOv6G6n3G8vH4PT1vWWI6UygCxfY9hakr
 hrPfSo2EDPT1QlXNeMLCk1LMlrSwj9KVzy8vk0rA0Sz2bOxJ1mcHwYNTb/R3wMhI
 giI1SBTIGw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vpypf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 14:16:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCPmsP031902;
 Fri, 22 Aug 2025 14:16:21 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5ydmrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 14:16:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57MEGKmv29491760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Aug 2025 14:16:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DF5658059;
 Fri, 22 Aug 2025 14:16:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12B6F58058;
 Fri, 22 Aug 2025 14:16:20 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 Aug 2025 14:16:19 +0000 (GMT)
Message-ID: <1eee380615318374a4ab5fc5874d5b1906428997.camel@linux.ibm.com>
Subject: Re: [PATCH] hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
From: Miles Glenn <milesg@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
Date: Fri, 22 Aug 2025 09:16:19 -0500
In-Reply-To: <20250821154459.2417976-1-peter.maydell@linaro.org>
References: <20250821154459.2417976-1-peter.maydell@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KkVZ1rtlSfEh6qNw7gCxZAFhPkwRwc7z
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a87bb6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=cs6J414EKrr35_aV8MEA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX6czpAHgW0CeW
 qMqW27DrCoLzKF+sMqDi8Me61LLDXE+ZLpGZWz3aG3zAkCTUmUp1g8/YpmHywiq3Zgc764wP7IF
 9Pxc52q8UKnTHrEtoGR24hVSXvj9VQHwU83JG+uB1bAB83D5ZzlO8qm09QZAzy2J1DKOOtfL5y6
 hWTTIBFzYuCo0wNeg2HNBjJVXMMStErTawta9wcy1p/xnKQaiM3YyI1DZjhoH5Klqjur5IPDJzR
 q6ceiHCStSoVTOlJrpwUr+y22LJPVCd5B7IIPn93GfdBTUZ7ACCnA0bxsCDQymTXZmo6zbeeujE
 e1nwkY4Oau6+jY3LY0he+DBQB9DpYT5113NPeJV8+LfsVAJ0wfvBwvel+yovADposVcP7WHST7g
 JSOnOvLTfgOGv2Qdp6O+UB7TERqDWQ==
X-Proofpoint-ORIG-GUID: KkVZ1rtlSfEh6qNw7gCxZAFhPkwRwc7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2025-08-21 at 16:44 +0100, Peter Maydell wrote:
> In pca9554_set_pin() we have a string property which we parse in
> order to set some non-string fields in the device state.  So we call
> visit_type_str(), passing it the address of the local variable
> state_str.
> 
> visit_type_str() will allocate a new copy of the string; we
> never free this string, so the result is a memory leak, detected
> by ASAN during a "make check" run:
> 
> Direct leak of 5 byte(s) in 1 object(s) allocated from:
>     #0 0x5d605212ede3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (
> BuildId: 3d5373c89317f58bfcd191a33988c7347714be14)
>     #1 0x7f7edea57b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b68282
> 9a6913cf682d75)
>     #2 0x7f7edea6d4d8 in g_strdup (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x784d8) (BuildId: 1eb6131419edb83b2178b68282
> 9a6913cf682d75)
>     #3 0x5d6055289a91 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
>     #4 0x5d6055289a91 in qobject_input_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qo
> bject-input-visitor.c:542:12
>     #5 0x5d605528479c in visit_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qapi-visit
> -core.c:349:10
>     #6 0x5d60528bdd87 in pca9554_set_pin /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/gpio/pca9554.c:179:10
>     #7 0x5d60549bcbbb in object_property_set /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1450:5
>     #8 0x5d60549d2055 in object_property_set_qobject /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/qom-qobject.c:28:10
>     #9 0x5d60549bcdf1 in object_property_set_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1458:15
>     #10 0x5d605439d077 in gb200nvl_bmc_i2c_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:1267:5
>     #11 0x5d60543a3bbc in aspeed_machine_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:493:9
> 
> 
> Make the state_str g_autofree, so that we will always free
> it, on both error-exit and success codepaths.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/gpio/pca9554.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index de3f883aee9..eac0d23be34 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -174,7 +174,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>      PCA9554State *s = PCA9554(obj);
>      int pin, rc, val;
>      uint8_t state, mask;
> -    char *state_str;
> +    g_autofree char *state_str = NULL;
>  
>      if (!visit_type_str(v, name, &state_str, errp)) {
>          return;



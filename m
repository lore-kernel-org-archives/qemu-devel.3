Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9D8C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 13:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4K1Z-0005Fw-7r; Mon, 14 Apr 2025 09:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u4K1X-0005FT-KZ; Mon, 14 Apr 2025 09:38:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u4K1V-0006le-SY; Mon, 14 Apr 2025 09:38:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAej5d012665;
 Mon, 14 Apr 2025 13:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=l+sTelu54ZhzAs/roq+p/KbRP9WCWR
 IBpGRnrMxrcuE=; b=ThEoOXiLP1GVLwSet1jCWWPY6Dv9HP/OemiLmmWTOmv5RN
 1DL7hyNyJtHl6gVmQI7b/GlHeuXQEr/D3a7r6WuuUkO92rWuPehjSfCJbYsCWD3X
 qLGPEX74tBw3ptP5LDJEQhUhvxG22F6dyO+MMSmDUccc/Y83ByGVP6QE4reKWa1H
 Jlju1O3ELtg8AZLV51fa9lOneXso5jIod5vghMNVLbut9LO569hUmcTDg3A02mgb
 6+84avpknqbXvQbc+1orGpxXzzl+bxHlJSgJ+/yjIRiyF3/J0YhnONktfkm0/2Zm
 9smqAikt6ARfaaRd2MP06uEhmtvXkC+iMz+m6E0w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4610tp8tbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 13:38:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAgQxg024900;
 Mon, 14 Apr 2025 13:38:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gt6qrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 13:38:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53EDclbP29098700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 13:38:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45C6220049;
 Mon, 14 Apr 2025 13:38:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E93020040;
 Mon, 14 Apr 2025 13:38:47 +0000 (GMT)
Received: from osiris (unknown [9.155.199.163])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Apr 2025 13:38:47 +0000 (GMT)
Date: Mon, 14 Apr 2025 15:38:45 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Gautam Gala <ggala@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 2/3] target/s390x: introduce function when exiting PV
Message-ID: <20250414133845.61624-D-seiden@linux.ibm.com>
References: <20250411092233.418164-1-ggala@linux.ibm.com>
 <20250411092233.418164-3-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411092233.418164-3-ggala@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kqOBNv9efvZJ3su1jFU7mBGwtpkO7Lki
X-Proofpoint-ORIG-GUID: kqOBNv9efvZJ3su1jFU7mBGwtpkO7Lki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=794 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140098
Received-SPF: pass client-ip=148.163.158.5; envelope-from=seiden@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 11, 2025 at 11:22:32AM +0200, Gautam Gala wrote:
> introduce a static function when exiting PV. The function replaces an
> existing macro (s390_pv_cmd_exit).
> 
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> ---
>  target/s390x/kvm/pv.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> index 3a0a971f0b..b4abda2cef 100644
> --- a/target/s390x/kvm/pv.c
> +++ b/target/s390x/kvm/pv.c
> @@ -59,14 +59,15 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
>   */
>  #define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
>  #define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
> -#define s390_pv_cmd_exit(cmd, data)    \
> -{                                      \
> -    int rc;                            \
> -                                       \
> -    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
> -    if (rc) {                          \
> -        exit(1);                       \
> -    }                                  \
> +
> +static void s390_pv_cmd_exit(uint32_t cmd, void *data)
> +{
> +    int rc;
> +
> +    rc = s390_pv_cmd(cmd, data);
> +    if (rc) {

I am not sure if that violates Qemu coding style but you could inline the rc
variable here to reduce LoC.

> +        exit(1);
> +    }
>  }
>  
>  int s390_pv_query_info(void)
> -- 
> 2.49.0
> 
> 


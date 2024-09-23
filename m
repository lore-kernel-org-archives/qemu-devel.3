Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B4FCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 07:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssd5H-0007e6-76; Mon, 23 Sep 2024 03:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ssd5D-0007dU-O9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 03:02:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ssd5C-0000iP-8b
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 03:02:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MAbD5r003950
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 07:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:from:to:references
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=w
 TjxMdVHgWhF1HE9tdWWerhntVVyIxwoemYIuz4FMew=; b=eo9jZ4VhL7ksJMjeQ
 aMzh5tdQheS6mZhjok8jTeraRGFBHJadjnzcp863lYW7kHqnmmDzax6I/lBe9+nI
 YiQNW9+oHGgIhZgpcVeN8jDfAMYM1XZTXD0t6XSYTF8TcpBu90x3tmGGq1qXF6JB
 oKk5Q0IvpQ2YItxRFTpSvtzjr8yo3F8VA5G4rUU5uOJdIB0agJLP8tJxBrRDoMWQ
 ZI5/xmkQTxdk+uMdG4zKBbcj8n3GUYMTuG4duhC8pyjRh19GiofWmTXG6RFoTIqm
 KHAaoXp2VfClf4W02Kitmx5EkeJSkxWP7bHBH4DvdmhzXt0SFVfQmCHkXP2vxrq/
 Wvrvw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjjhxp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 07:02:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48N3iOKI012524
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 07:02:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fpn1yg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 07:02:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48N720eT35586694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 07:02:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2967A20049;
 Mon, 23 Sep 2024 07:02:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CD9420040;
 Mon, 23 Sep 2024 07:01:59 +0000 (GMT)
Received: from [9.109.199.38] (unknown [9.109.199.38])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 07:01:59 +0000 (GMT)
Message-ID: <2f2aaa21-a533-4249-9f6e-c1e01f3fd3c6@linux.ibm.com>
Date: Mon, 23 Sep 2024 12:31:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] typo: Fix description of '--disable-debug-info'
From: Aditya Gupta <adityag@linux.ibm.com>
To: qemu-devel@nongnu.org
References: <20240923065605.2170454-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240923065605.2170454-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -nEf7YzGvIqHa25iPc5dkhphyPNuzXZy
X-Proofpoint-GUID: -nEf7YzGvIqHa25iPc5dkhphyPNuzXZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230047
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

Seems there are more confusing option descriptions like:


+  printf "%s\n" '  --disable-install-blobs  install provided firmware 
blobs'
...
+  printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better 
performance)'


Should we change them ?


Thanks,

Aditya Gupta


On 23/09/24 12:26, Aditya Gupta wrote:
> The existing description of '--disable-debug-info' seems to have a typo.
>
> Later scripts/meson-buildoptions.sh does the following based on option:
>
> +    --enable-debug-info) printf "%s" -Ddebug=true ;;
> +    --disable-debug-info) printf "%s" -Ddebug=false ;;
>
> With above logic, the description should be 'Disable debug symbols...'
> instead of 'Enable debug symbols...', Fix the typo by replacing Enable
> with Disable.
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   scripts/meson-buildoptions.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index cfadb5ea86af..81c053a0fffa 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -12,7 +12,7 @@ meson_options_help() {
>     printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
>     printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
>     printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
> -  printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
> +  printf "%s\n" '  --disable-debug-info     Disable debug symbols and other information'
>     printf "%s\n" '  --disable-hexagon-idef-parser'
>     printf "%s\n" '                           use idef-parser to automatically generate TCG'
>     printf "%s\n" '                           code for the Hexagon frontend'


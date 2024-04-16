Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852E0C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 11:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwhP7-0007T8-8D; Tue, 16 Apr 2024 07:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rwhP4-0007Rj-7Z; Tue, 16 Apr 2024 07:55:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rwhP0-00034O-Id; Tue, 16 Apr 2024 07:55:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43GAwSpR018870; Tue, 16 Apr 2024 11:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BF+WWx2eyJpyEbVOTgr946Qb3Qp3BXMlMICw75obs9E=;
 b=NYbG5VSQNK3NWK2XLcpaQKTcDVi84vffP5V3A3TI7pWPdywGgw2Z+7gkEa7cvdGFrg1e
 dZE2AENcx2wRC5i/mqCDJ0yP16ATZYgM/gRAj1BD6nG8tle+hPmdrlU4uT7+92tpRkiS
 d5g5ul1+mwOVGaaOVSxSC6dz8GFSXhcZY16zci3tefJr6I29HLP/lPECPqJs0nfPR9AA
 6hNjeJO3xYKNFdZc2lbGMPDJRA0vMOGK+C3LJXEZCTLz9904fqg2XF/OMB+BptmskUH7
 Vr7vLIIYP4CPT71GngSr9eQU5HpyyH+EDvTSCSOm3ULl8wuGHEc0uOFbFL8rDnmy1Efg ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhr1rg3a1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 11:54:51 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GBspYI003700;
 Tue, 16 Apr 2024 11:54:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhr1rg39x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 11:54:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43G8fhhx027311; Tue, 16 Apr 2024 11:54:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg4ryx1hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Apr 2024 11:54:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43GBsl2729033166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2024 11:54:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFAC458067;
 Tue, 16 Apr 2024 11:54:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 666EE58062;
 Tue, 16 Apr 2024 11:54:47 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2024 11:54:47 +0000 (GMT)
Message-ID: <a860264b-e1e4-4d10-87f7-a95f0eee4e01@linux.ibm.com>
Date: Tue, 16 Apr 2024 06:54:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/qtest : Use `g_assert_cmphex` instead of
 `g_assert_cmpuint`
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20240414173349.31194-1-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20240414173349.31194-1-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z5-AnbfhOBMo_IJkUGSeHREa5Uef08ku
X-Proofpoint-ORIG-GUID: mG6XJ0J1cvqu1R3E9vwkLOx5-VCk8zTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160073
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 4/14/24 12:28, Inès Varhol wrote:
> The messages for assertions using hexadecimal numbers will be
> easier to understand with `g_assert_cmphex`.
>
> Cases changed : "cmpuint.*0x", "cmpuint.*<<"
>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/aspeed_fsi-test.c          |  20 ++--
>   tests/qtest/cmsdk-apb-dualtimer-test.c |   2 +-
>   tests/qtest/cmsdk-apb-watchdog-test.c  |   2 +-
>   tests/qtest/erst-test.c                |   2 +-
>   tests/qtest/ivshmem-test.c             |  10 +-
>   tests/qtest/libqos/ahci.c              |   4 +-
>   tests/qtest/microbit-test.c            |  46 ++++-----
>   tests/qtest/sse-timer-test.c           |   4 +-
>   tests/qtest/stm32l4x5_exti-test.c      | 138 ++++++++++++-------------
>   tests/qtest/stm32l4x5_syscfg-test.c    |  74 ++++++-------
>   10 files changed, 151 insertions(+), 151 deletions(-)
>
> diff --git a/tests/qtest/aspeed_fsi-test.c b/tests/qtest/aspeed_fsi-test.c
> index b3020dd821..f5ab269972 100644
> --- a/tests/qtest/aspeed_fsi-test.c
> +++ b/tests/qtest/aspeed_fsi-test.c
> @@ -63,22 +63,22 @@ static void test_fsi_setup(QTestState *s, uint32_t base_addr)
>           /* Unselect FSI1 */
>           aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x0);
>           curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
> -        g_assert_cmpuint(curval, ==, 0x0);
> +        g_assert_cmphex(curval, ==, 0x0);
>   
>           /* Select FSI0 */
>           aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x1);
>           curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
> -        g_assert_cmpuint(curval, ==, 0x1);
> +        g_assert_cmphex(curval, ==, 0x1);
>       } else if (base_addr == AST2600_OPB_FSI1_BASE_ADDR) {
>           /* Unselect FSI0 */
>           aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x0);
>           curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
> -        g_assert_cmpuint(curval, ==, 0x0);
> +        g_assert_cmphex(curval, ==, 0x0);
>   
>           /* Select FSI1 */
>           aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x1);
>           curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
> -        g_assert_cmpuint(curval, ==, 0x1);
> +        g_assert_cmphex(curval, ==, 0x1);
>       } else {
>           g_assert_not_reached();
>       }
> @@ -145,11 +145,11 @@ static void test_fsi0_getcfam_addr0(const void *data)
>       aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
>   
>       curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
> -    g_assert_cmpuint(curval, ==, 0x10000);
> +    g_assert_cmphex(curval, ==, 0x10000);
>       curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_STATUS);
> -    g_assert_cmpuint(curval, ==, 0x0);
> +    g_assert_cmphex(curval, ==, 0x0);
>       curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_READ_DATA);
> -    g_assert_cmpuint(curval, ==, 0x152d02c0);
> +    g_assert_cmphex(curval, ==, 0x152d02c0);
>   }
>   
>   static void test_fsi1_getcfam_addr0(const void *data)
> @@ -168,11 +168,11 @@ static void test_fsi1_getcfam_addr0(const void *data)
>       aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
>   
>       curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
> -    g_assert_cmpuint(curval, ==, 0x20000);
> +    g_assert_cmphex(curval, ==, 0x20000);
>       curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_STATUS);
> -    g_assert_cmpuint(curval, ==, 0x0);
> +    g_assert_cmphex(curval, ==, 0x0);
>       curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_READ_DATA);
> -    g_assert_cmpuint(curval, ==, 0x152d02c0);
> +    g_assert_cmphex(curval, ==, 0x152d02c0);
>   }
>   

aspeed-fsi-test changes looks good. Thanks

Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>




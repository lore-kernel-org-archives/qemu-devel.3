Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3035DCDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcnU7-0004OL-5o; Thu, 25 Jun 2026 13:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcnU4-0004O7-VU; Thu, 25 Jun 2026 13:03:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcnU3-0001pg-2o; Thu, 25 Jun 2026 13:03:24 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFmP56486719; Thu, 25 Jun 2026 17:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dNFqxW
 jG6b421JnfL2NRktc7MzwHb8wvc2cVmkZ+d/8=; b=CwMahiAoSl0yB2ToaBwddt
 4N5uNsyn2YrBCjGaZePmr1ELHUfqzHrSokSWooeC6ErQULWU0LjRITbyOij4+Ics
 fduePPPNxzXMO7GwDRhpnBX8n6guIxsjkczJ3b9HNQ2QCVomEhmJin4ENqkqFYqx
 fQ82+5OfLvhJ6RZ0SxBEduMqqMv5eR8J2CzQAgRJGZqWN+j2lYH+uHohO2lBJ82R
 ipn5G9wHxc1mGqrGLjG23P5C+WOCGoVaHXDLr5yB25N1/lQECoDryESD699y99hl
 1UriDDYJNxirOd7HtwuWR72I1UIvC9ycXBsBJOTR8TMU5BOs+DJDkXQgmp9J9MMA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3u1xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 17:03:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PGnd8H004706;
 Thu, 25 Jun 2026 17:03:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qqcmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 17:03:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65PH36k756230228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 17:03:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A58A02004B;
 Thu, 25 Jun 2026 17:03:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D5AF20040;
 Thu, 25 Jun 2026 17:02:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.20.53]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jun 2026 17:02:45 +0000 (GMT)
Date: Thu, 25 Jun 2026 22:32:35 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v5 1/9] qtest/phb5: Add testbench for PHB
Message-ID: <ajzojholiKw1DkFH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-2-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617095058.652789-2-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3d5f4f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=rODBop-RIHK0INa2pucA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE0NCBTYWx0ZWRfXyRjVo0yQpLsW
 zbcHF7ofbWy/5I1MyEQIQ3/dYXLQdrcY7pF4SFbZgtlCHe4PEj86ysdn6+wsoS1L8SuWcZx0vIl
 V1YwGbU9fJi0jyImwhF6QbkEANB14eY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE0NCBTYWx0ZWRfXzipMT3c/wgq8
 3vgfenABdpW/B7YzCYAReEyqz2dmg5ZL4Qp1pIjEmO3yzZ8N/R2y5YEl2IzSI90wiTdcXfGcx/5
 75jawKTmoNE2YLzN0BSIlV/r19M+eJO5Z2n0HZrgDXpxi+pMzIkN0aKfhIXKaWsdnZOeJuzvc1a
 0cHYMbH/2X9EHgxJvE/lc9BUOAKDFLM7iEm4cJXighEVpYK2sWcrjDeMA7/yDNe6ElNqDAxDdE7
 oyuxcPQfqOdjrv01DRtQN/PgbBwQBewLq9tNNSuNW0rKea6ppbQAu1lmelMF+stFNt+zlhNiS/u
 kAgwLvaw88teowZJNB4sORjV5I14K0paBxcEWvd53d+agkhpPQCQutca5TAds6NBw7x3jqK7OKr
 fIzdAQVrgfdk1JIwroM25uGCThq5o15gc5r/dkKzg8VZncuGz9jc/36yhw6v6p8NSEiq3cnIiT3
 ttCkv8tjX1ZZJ/cdEtA==
X-Proofpoint-ORIG-GUID: opJCXbyf36WcY8XwR66BdJ9LR4MK2GT8
X-Proofpoint-GUID: zqBmCKGfqiqvYQbHNeO--K5RUW4S7yZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 26/06/17 04:50AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 
> New qtest testbench added for PHB[345].
> Testbench reads PHB Version register and asserts that
> bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Reviewed-by: Jishnu Warrier <Jishnu.Warrier@ibm.com>

Thanks for the patches !

> <...snip...>
> +/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
> +static void phb_version_test(const void *data)
> +{
> +    const PnvChip *chip = (PnvChip *)data;
> +    QTestState *qts;
> +    const char *machine = "powernv8";
> +    uint64_t phb_xscom = 0x4809e000;
> +    uint64_t reg_phb_version = PHB_VERSION;
> +    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
> +    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
> +    uint32_t expected_ver = 0xA3;
> +    uint64_t ver;
> +
> +    if (chip->chip_type == PNV_CHIP_POWER9) {
> +        machine = "powernv9";
> +        phb_xscom = 0x68084800;
> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
> +        indirect_data = PHB_SCOM_HV_IND_DATA;
> +        reg_phb_version |= PPC_BIT(0);
> +        expected_ver = 0xA4;
> +    } else if (chip->chip_type == PNV_CHIP_POWER10) {
> +        machine = "powernv10";
> +        phb_xscom = PHB4_XSCOM;
> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
> +        indirect_data = PHB_SCOM_HV_IND_DATA;
> +        reg_phb_version |= PPC_BIT(0);
> +        expected_ver = 0xA5;
> +    }

We are adding PNV_CHIP_POWER11 in qtests in
https://lore.kernel.org/qemu-devel/20260624195924.1422821-1-adityag@linux.ibm.com/T/#m5ccc85c90fce585b11ec4a89317c21bc6504b10e

fwiw, depending on which series is merged first, we will have to update
this in future, just keeping a note

> +
> +    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine, chip->cpu_model);
> +
> +    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
> +                                indirect_addr, indirect_data, reg_phb_version);
> +
> +    /* PHB Version register bits [24:31] */
> +    ver = (ver & PPC_BITMASK(24, 31)) >> (63 - 31);

GETFIELD(PPC_BITMASK(24, 31), ver) ?

> +    g_assert_cmpuint(ver, ==, expected_ver);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Verify versions of all supported PHB's */
> +static void add_phbX_version_test(void)
> +{
> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> +        char *tname = g_strdup_printf("pnv-phb/%s",
> +                                      pnv_chips[i].cpu_model);
> +        qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);
> +        g_free(tname);

can use g_autofree:
    g_autofree char *tname = g_strdup_printf("pnv-phb/%s",
                                  pnv_chips[i].cpu_model);
    qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);

Thanks,
- Aditya G



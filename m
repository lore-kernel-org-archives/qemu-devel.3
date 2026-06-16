Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD1ACD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXFS-00074x-0g; Tue, 16 Jun 2026 13:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wZXFO-00074p-LY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:06:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wZXFN-000473-3V
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:06:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GFmNuI2118503; Tue, 16 Jun 2026 17:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=l6UBZs
 xCRGySzn8zWpE779BhcEbL5WHLSgtSC3XjiTo=; b=SCDUDr5ym+wifHwTcrAenx
 MAW0/yxvtu74S5SeDUMmgAXacT7IiyLcdgC76XnLo81qNyM0u5lM+U/R/W9NKNKu
 na5wGxv0Cjq4FzhkqhJ9baLOZjVFuwOyU6WfRVOo9N3WRet7knqwTQc9VM0WByad
 8mXX/AIJTTGJZZB7ULHCQqUlpGDN5TiCSDG9E6wmdKWFQiU7CnXjNUdC3igahj1K
 7wjpZCynbp42F/hF/edcHm/8qyg0Q4/mQPRnIehVzGey3NCjO2r7pDwUxcU2dSEb
 TzUNk2VJBvYmSOTHI7lgb14v6eqjf0iBIlogsC10RMACfUUv1G0mw+V/fEG5ECww
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h8739u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 17:06:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GH4aba003068;
 Tue, 16 Jun 2026 17:06:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww4k0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 17:06:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65GH6Ofs57082226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 17:06:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B757C20040;
 Tue, 16 Jun 2026 17:06:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDA9620043;
 Tue, 16 Jun 2026 17:06:23 +0000 (GMT)
Received: from [9.111.55.163] (unknown [9.111.55.163])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jun 2026 17:06:23 +0000 (GMT)
Message-ID: <9ad69343-38b5-449c-8d7b-5cbde9d3b72f@linux.ibm.com>
Date: Tue, 16 Jun 2026 19:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260529094619.1034458-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX5E+UD9gaOwMI
 j+1wNh2MUBIF400uoAI9giS17tdNHU3nZwmeQ9gytiM5NhKr0SsrqdFpjccyiXqVe3txNQnp/yX
 tml5f0HFQqYTczU08jxG3wX5as1U+h0=
X-Proofpoint-ORIG-GUID: GaPX5g8WkjeL05HbmVdZoNDZK39eKIIx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX3EQiMk1Wkinv
 UbPP2bjn6rrH3J+OdPLDoOwAzjJUy7xHIQDH9bWnC4uUwQGCSSZnHQSkDq60UAoXece1S21bgsb
 Oia8N3MF6bWgYO7nbs5faK5asy6PQQNAC/nsOJBLcyflfStGQBZw8eJAb9vJeUZITM7mK+YmZL+
 jC0qgRcyDztEhUVpPCbfEriBBaYgMHglR0QDBz6bKrC6HKkDJbm7+IgOWfszkrT24cnQqcY5QU6
 Uq+433b3Ku7qfR8H2RnAln3B++uSG1LLI0L/5PlWTZl9vD8wm9SG/vhfXduY7wRB3dTCJL7VDYw
 3TpXRzRDOz0FEx8RUZ5GYspprOQeObjGeNr6egL8rhDs8C+5Gy04eixoRRm0T4bVfmnacmnUIn/
 A/lU2DZxHjAbrc+2C94g97nR7GJ5y9zVS2xzykn4bYVMEc27GdCOEDIDDpNs8QNj13uwZ0mLV0E
 dywcLukDdznC/xwOC7Q==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a318294 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pK86CZSq-bPA3Co50ngA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: GaPX5g8WkjeL05HbmVdZoNDZK39eKIIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160173
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 29.05.26 um 11:46 schrieb Paolo Bonzini:
> -Exceptions do not remove the need for authors to comply with all other
> -requirements for contribution.  In particular, the "Signed-off-by"
> -label in a patch submission is a statement that the author takes
> -responsibility for the entire contents of the patch, including any parts
> -that were generated or assisted by AI tools or other tools.
> +.. code-block:: none
> +
> +     AI-used-for: tests, docs
> +     AI-used-for: code
> +     AI-used-for: code (refactoring)
> +     AI-used-for: code (prototype)
> +     AI-used-for: research
> +
> +``AI-used-for`` should not be included for "background" usage such as
> +autocomplete or obtaining a pre-review of the patch.

So what about using AI for security scanning? So how do we want to treat
a patch from a human that is based on an AI report.
And if ok, would we then add something like

Reported-by: Claude, chatgpt whatever?


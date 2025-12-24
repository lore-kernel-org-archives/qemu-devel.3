Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FABE78487
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 19:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYUxe-0001bI-Mz; Wed, 24 Dec 2025 14:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vYUxb-0001a4-6T; Wed, 24 Dec 2025 14:55:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1vYUxZ-0004yp-8Q; Wed, 24 Dec 2025 14:55:50 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BO57XhD002445;
 Wed, 24 Dec 2025 19:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yRpcVB
 sH03ZJ5Pmo8lqa6qCoxW8G4yq4UCXEhG9aZDM=; b=MOmEj/vZEU1FJRJtGsNQIM
 0bF1XzK1Eo/n+JBay9hQLm8thGW1HjKGVKlGnawkIdn40NrwJ2v1Twmn79+IYcEH
 x2DzUa5rU1Tg01oHTvCpc85hUefc1hnNqzb0ErpNcZNUcN21bKp7yVLHNADf8NlM
 CT/Y8rL+8Aja8E5FPr78pYk844c0rgEYLRE33UkcfgVuMXMH1nC8kzNGcjk1OGFw
 WUM1dZ2pMUWsXes65TOThJia0YtEH9ODBZJA8M0wWPk3QhXkg6czEx/5BaCT1iE+
 LB4gTm7pXfMhCiewdBzJdlbPMrJauhIBTANQjHNwZ3G+Og8QrUZ/RT+4OrvP1MXA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kfqasq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Dec 2025 19:55:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BOH3HkZ032332;
 Wed, 24 Dec 2025 19:55:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b68u199hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Dec 2025 19:55:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BOJtbPi30867740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Dec 2025 19:55:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24B702004B;
 Wed, 24 Dec 2025 19:55:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E27BC20043;
 Wed, 24 Dec 2025 19:55:35 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.16.93])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 24 Dec 2025 19:55:35 +0000 (GMT)
Date: Wed, 24 Dec 2025 20:55:34 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, David Hildenbrand
 <david@kernel.org>, Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Anton Johansson
 <anjo@rev.ng>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/8] hw/s390x: Use explicit big-endian LD/ST API
Message-ID: <20251224205534.1b623cb8.pasic@linux.ibm.com>
In-Reply-To: <20251224162036.90404-2-philmd@linaro.org>
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-2-philmd@linaro.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=carfb3DM c=1 sm=1 tr=0 ts=694c453d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=HjUa5_KY-2xxWMZ9hd4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cOJ7YuN0n_Z5R40VxCoyTCNoN-vQQcqW
X-Proofpoint-GUID: cOJ7YuN0n_Z5R40VxCoyTCNoN-vQQcqW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDE3NiBTYWx0ZWRfX5I5+yF8vgXXL
 EdmQ8Y2TWariiK2ZolYiPjOoRoKt7W7oQ8PN2CNWh8aOB+7t9gQd2vWUlpVD7amTLKZtL0voX94
 BQ2DHO0qM1GGGFB1kh16ar6sVeaCTpWnJrenXugKdn50OwdL5AagmwMN9JdFCK+BQwCYWOYWwss
 bcQZtybbKmXld1Ool4gofdyxdeMQENldbUY5ePTHjV/pHVgWmWqyOBLrb5YouNMahDh/+4DPmSn
 8Rf57tPnLZhLAA7HNeIRaXMWgMkVVCiI4bVv+41Tr8L7A3vToNN9ftw+ztGwKlTklCCW9MuNNJl
 rTy20WRudQzKqXGjftg/MU8UNg/7JD7SGkLXOB4FSraeddMwXTjseJaVjHQ3tN3MBLdQlJQqtO7
 wQYyRNqrN+N+t9H46ZRmfTckPMJqe54yj9w5734r26GjSct06FuAiWmhvh2377UTLqK2s1t1la3
 YZwTu8KD5SGxXZ3N5dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512240176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 24 Dec 2025 17:20:28 +0100
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> The S390x architecture uses big endianness. Directly use
> the big-endian LD/ST API.
> 
> Mechanical change running:
> 
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' hw/s390x/);
>     done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DD4CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 18:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5psn-0000Er-G8; Mon, 06 Oct 2025 14:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v5psl-0000BP-6Z; Mon, 06 Oct 2025 14:24:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v5psi-00029F-HG; Mon, 06 Oct 2025 14:24:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596BLE4Z010234;
 Mon, 6 Oct 2025 18:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=w11XoW
 NbJgQGkAhq5IlooxA/dZW2acqeO4AFTX+4gr4=; b=ojjGY8TW0KuzBJ4VHoDc5d
 u7JpQCtflJFRfkm7mT8YZ/9PjY2QiTvenTAa6gJUUMghwKH3mdL21YsID4GIk9xO
 bxKgKYvNOPChFHcBdtosPTm4O0g+InNFRajNcQb8Xw93rQ3dWW6DeYRI2ityFKC8
 gPglvqpml4rMVDmWZs/neXsIPmNryS8YuHEnj+oIyl1hgWx57n8KQSqJ/HoJpD5g
 Ng+IsRq6HE5aIf0iisd2KkS+fIapCuuY2BFEjtVN1J1iilUU2HjqMAMh1c89nekI
 LEucYL5lGFFH1nLPf2A1MFVMmCa98kS3Iy8aFp5i9w5iSiW7ONEdN/VjNXsvdM8A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gu2wj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 18:24:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 596IGvEv022482;
 Mon, 6 Oct 2025 18:24:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gu2we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 18:24:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596Gij7J027961;
 Mon, 6 Oct 2025 18:24:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kewmyfuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 18:24:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 596IOAAI58458580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Oct 2025 18:24:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26AAB2004B;
 Mon,  6 Oct 2025 18:24:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D29820040;
 Mon,  6 Oct 2025 18:24:07 +0000 (GMT)
Received: from [9.124.214.168] (unknown [9.124.214.168])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Oct 2025 18:24:07 +0000 (GMT)
Message-ID: <12ac41c8-7753-4191-8e64-afb91b51bde2@linux.ibm.com>
Date: Mon, 6 Oct 2025 23:54:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] ppc/pnv: Introduce Pnv11Chip
To: Mike Kowal <kowal@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250925173049.891406-1-adityag@linux.ibm.com>
 <20250925173049.891406-2-adityag@linux.ibm.com>
 <d845b30b-5296-485a-a360-e617fb50ed17@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <d845b30b-5296-485a-a360-e617fb50ed17@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX9diSXgEwGQT9
 C9DcnuTjvdTWRnMMx/2zKo2EwyMNdsXe+L7S7aDveTHDaMfIjxVO6/7FY4k6mYuWM79qMXsufhk
 yS7n7i87+HnW1Y5C6iqlyTshWg4yXBtWcMvh28mrzGKFGPw4NnlGjh0xqDmT5fmjUWEqPfqMAoF
 HTe0tFNREa/QjbJwCPYU1IJmQZ8aOYT1QrJKo2BCvrG7jd+CyOafJjdbLFM04nY8i7itV2wi6M+
 vaS0LZDFCgexg+4bdDgDQXzBXYjnjuK7IvMneeBODxXmGZNMBzeKvENdP98OEmJjPvhIw6w7BCz
 +AWGisB0Zl8h/3y0YK+Qz94dQ2isQz4l0rhOcVMfP4S28SR72lQGUIGr4Q8V4+V/u9NS6xT9VfY
 1xUuaZbSxCTvtPssvu0h2nwm8b56Aw==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e40950 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=e9fe54QSqPNgmJ2B5QkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ih7qS6VIPVYGjoYBGSGwWWAej4_V35TP
X-Proofpoint-ORIG-GUID: pNXbdSKnbFIBSy4AjNNMmPAYb4EfZd5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 06/10/25 21:15, Mike Kowal wrote:

> Reviewed-by: Michael Kowal<kowal@linux.ibm.com>


Thanks for your reviews Michael !


- Aditya G



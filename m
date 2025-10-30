Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEF1CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVtI-0000dd-IS; Thu, 30 Oct 2025 12:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vEVtG-0000dS-20
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:52:46 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vEVt5-0004Zw-2B
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:52:44 -0400
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 59UFoEiU1180310; Thu, 30 Oct 2025 16:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=jan2016.eng; bh=gJhczxobc
 1mZNz8qaVS4ULglRmVp5/t/yxjmM1TDAkc=; b=k0VoSE6O195kCxechH6VK8UsS
 ppfGG+uQBHP1CqOqJxzgkIpy5+wapI62GYq1fjushIwtexjnr3qKzElVYc1ABvsW
 2U8AcaCuwJj9qde29uhSWGpcHfRwWMKi1Dtfn9Uer1covgYZM1tJ4awg2kYY+cRI
 UHxE5yX9RNR0q4AIvkfjAcpN6O7pUXnxUaSC9hpbauCkd6CAzCOeq+AwztA7x2q/
 paRjXpvQWw35NCqPNKVETHGuizPUeBhNhZixAn7YpgAMv6lAKrwY9S3L8MT4ZnsN
 0BVrJkSgHWUB5QWXNKt7gCvvIVHcasQ5cPU0JkWa2ZijotisQUCYMJ3DmklWA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4a4b0ugmw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 16:52:24 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 59UDuA9L008142; Thu, 30 Oct 2025 12:52:23 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4a49b20nq1-1;
 Thu, 30 Oct 2025 12:52:23 -0400
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 4AED283;
 Thu, 30 Oct 2025 16:52:23 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
To: steven.sistare@oracle.com
Cc: farosas@suse.de, hamza.khan@nutanix.com, jasowang@redhat.com,
 mst@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 sgarzare@redhat.com, johunt@akamai.com, mtottenh@akamai.com,
 bchaney@akamai.com
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
Date: Thu, 30 Oct 2025 12:52:23 -0400
Message-Id: <20251030165223.508678-1-bchaney@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=482 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300138
X-Authority-Analysis: v=2.4 cv=VMvQXtPX c=1 sm=1 tr=0 ts=690397c8 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mauVNlPaqdg2CfaPDjgA:9
 a=ZXulRonScM0A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: gY8YRwAa88P741fwqaSUNGSaZgxI8eDQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEzOSBTYWx0ZWRfX0X6mV4xz8FQE
 QlS0T4WCJIz1WMNvjRAwgM45iQVWalK5X4lvNveD+PBo3n/G7L7qLQvqTVaUKmf+NE0AIoJ89Lv
 vDUfLhcTPkDAH6bEf+5yecjdTkYgkks89eRHqyoeMXD52fV9UVRqRPRKJHCG7TFmzoNbJJdZLWI
 cw0Mxf90NifVuuzcJRVIM5/A2toiAEwB3gQv0u9sjQA8dWtqVErpfh1UoWX5Tsu59tM3Gi8a4eZ
 jrfAv2c2AzmhbIPCMOHNJXNoXWl1WVAk+lty7202rfGiiPJpC2wnp6KgDa7rQkT0B1j7SELPZPU
 a7RcGZEQwp6Sw7kL1mGNPdd4Fu1X5lbyc+Lw2mKfp6Z+LUxsTtn1pcQUTsZxEMX97MI3qt10okO
 QRk548G6300WOgDDV0CprHfmO+dvGQ==
X-Proofpoint-GUID: gY8YRwAa88P741fwqaSUNGSaZgxI8eDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300139
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Tap and vhost devices can be preserved during cpr-transfer

Hi Steve,

    I tested this patch set. With the two fixes. it is working
as expected. Are there plans for a v3 of this patch set?

Thanks,
     Ben


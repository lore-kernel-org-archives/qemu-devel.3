Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3A2C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 22:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4TPg-0002cg-PK; Tue, 07 May 2024 18:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s4TPc-0002bn-Og; Tue, 07 May 2024 18:35:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s4TPa-0003Na-Fo; Tue, 07 May 2024 18:35:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 447MQdJD001980; Tue, 7 May 2024 22:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=utLfr/1cPgb4TwHoktnfaU7ePqL5FsvwV7c9kjodRaU=;
 b=imCSvdTtzDobCmL0052ieDI9iS7uzSBHa88EsU5Wgr1oSjNJrI76YBxsqM+lB0BZ/xa5
 DlDIZCgZur4aa2hqJNFdjEE7ekXPNdYxag05ofuxMMZEGa0X5VOL/g3NAhZefWNMG8Wz
 E9c+0HUmvHmHY9Vw9l6z395OmZBTJ1hhC7SvNPGGLmI4nhhgv55shcc5hKx0ut/RLFWb
 QfiU2C00O+tBaokq4Ib4K5QNWf8jpcW5beqmL1cN4NkbnkIByQjpe6xrJsoxdbrVQkNd
 YY3F6WLABcD5lubkIe+qSJ1TVF5yBQ+ELjro0FM+gDPbM1Wv2daVDJSFAAfIY08r6teO Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyusx873p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 22:35:42 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 447MZfV6015446;
 Tue, 7 May 2024 22:35:41 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyusx873k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 22:35:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 447LPkCU017582; Tue, 7 May 2024 22:35:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xyshss6r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 22:35:40 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 447MZceN21365310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 May 2024 22:35:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFB8958075;
 Tue,  7 May 2024 22:35:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81BA858067;
 Tue,  7 May 2024 22:35:37 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  7 May 2024 22:35:37 +0000 (GMT)
Message-ID: <fcee5fcf-db96-45da-bedc-599ebb71a573@linux.ibm.com>
Date: Tue, 7 May 2024 18:35:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] query-cpu-model-expansion: report deprecated
 features
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240429191059.11806-1-walling@linux.ibm.com>
 <744e57f9-5885-4fb2-844f-3f008632d257@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <744e57f9-5885-4fb2-844f-3f008632d257@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p5iqLzHBZf6L4rhTNYihLoY_UwsKeok_
X-Proofpoint-ORIG-GUID: fVLlvcbiT6pswffzVntb7-m9l8QH8Rgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_14,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=981 adultscore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405070158
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

[...]

Thanks everyone!  The RFC for the analogous libvirt patches have been
posted under the subject:

[RFC PATCH 0/1] support deprecated-props from query-cpu-model-expansion

Any and all feedback is welcome.

-- 
Regards,
  Collin



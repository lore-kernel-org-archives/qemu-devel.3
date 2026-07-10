Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9A3C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi0oV-0001D1-TX; Thu, 09 Jul 2026 22:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wi0oP-0001Bw-GX; Thu, 09 Jul 2026 22:17:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wi0oN-0001AP-Rt; Thu, 09 Jul 2026 22:17:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669Hmhcq3005363; Fri, 10 Jul 2026 02:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bwniv5
 y8pX7yn2ua3smrcZtbDsDFEWWkdLzJQo9025Q=; b=Sx2Y4MkRFkV48S5aNh8F8E
 pUbEyYkBeQrXASMSvNrNjbxvL2ICM9GuEyvDU3tMFIVg/LgcAkGmcEiRe92bnwum
 4A3PPIUZU8ao5BR8chweEsv48y815/S7jTLmgXb27Kyrtm5OA1/VOEEWwVJLBgRL
 VjY7O2RRyiKuPE1CoCJOOjfcqBpN7lC1lF7LFULqrKKNZFxX0nyAaPmQnkZiv7WS
 VvefNh5xqXjNicB9LZNllyx9AAazvut8l7n/u7AfDkQLhmaxE0fzRL+lJnmuf22i
 CHHPpp23jHHIf2zXDhzslyRHLFkpMfid5b7bF4hcAhs7PqJN6d4whwCDBnNPo4kA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknv00b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 02:17:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A24YtX027600;
 Fri, 10 Jul 2026 02:17:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqgfrsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 02:17:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66A2Hl5t24445522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 02:17:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F11A5805B;
 Fri, 10 Jul 2026 02:17:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09C7258059;
 Fri, 10 Jul 2026 02:17:46 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.127.23]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 02:17:45 +0000 (GMT)
Message-ID: <fd7145f72537dfccd62cf1d4cd532ebc4e552f18.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] s390x/sclp: prevent re-reading the sclp header
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne	 <jjherne@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Ilya Leoshkevich	 <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Hendrik Brueckner	
 <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-stable@nongnu.org
Date: Thu, 09 Jul 2026 22:17:45 -0400
In-Reply-To: <20260709142906.197474-2-borntraeger@linux.ibm.com>
References: <20260709142906.197474-1-borntraeger@linux.ibm.com>
 <20260709142906.197474-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a50564d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=xTyEUfvKXfXEQBlKU5QA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: BMO9Tfk6ymjxt1conooROkX_6HbwPAE9
X-Proofpoint-ORIG-GUID: BMO9Tfk6ymjxt1conooROkX_6HbwPAE9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDAxNSBTYWx0ZWRfX12P8LPVP/PKB
 HjZk6PPn1IySkorI8dLqBD5TlXYjlJcN+RxJQaZrjT5d5Dh/l4RQ4pHxwH/WeTpvIu+NoQd8GpN
 ToM5hq1G0Dev5z+4n4XfsYo8W7LTzCQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDAxNSBTYWx0ZWRfXzt1pOb+C9gpd
 SFxuWPWnVBvxF7iuBaDVsmKyTMonGY2Q83fJcbn498xG/tqrr7zrQbMK39OH350BXa+eyuMRYfH
 8ROkrMBnEQOKBn48cWwfbMhMo+v3Dy2Hl6rAwIKHDv7Uk0710gbZt5Eh5QNhn6fYvVdPFbEGoYM
 BBHqGjI/cIdRIi7KAORsui3fm7hUXPEfjPBUOzjSi+wnRhzhq+rPb/rckLZcqEm+jbiqkZ59AWc
 EKY4TuO7OK/9PLZdfRecBPHplB75JUEFMFa1tPoCql6Fv+53MyfQqlkp/Ev8+Iw2HgjZidiA0s/
 9wC1se+OyRq7lqRM9oZ/XE6GByNeHYxLbN28qct/MmS/QTGrsp83dWe/FgnSWONf/aR3h8OJDQj
 iiwVh+6NSrs5Vm5JLRhclFh6FUq+gg5pKFMT0wSTrENU9Zf449ZRc88OBHEVAV46ZBYhL/6Hhm7
 Zjnf8Rvufq2i4ERQsMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100015
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 2026-07-09 at 16:29 +0200, Christian Borntraeger wrote:
> We verify the sccb length and then allocate based on that length. The
> following access re-reads the sccb again. This can race against other
> vCPUs overwriting the length field.
>=20
> sclp_service_call_protected does not need a change as the ultravisor
> provides a consistent snapshot.
>=20
> Fixes: c1db53a5910f ("s390/sclp: read sccb from mem based on provided len=
gth")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/sclp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF84C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 12:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFY42-0000OC-PQ; Thu, 15 May 2025 08:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1uFY40-0000Nl-IA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 08:51:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1uFY3y-0000GC-Hu
 for qemu-devel@nongnu.org; Thu, 15 May 2025 08:51:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg0KO016372;
 Thu, 15 May 2025 12:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=p5kJ/X
 6l6SY9vigCKwp5CnTHiPwsAXj0BoSosbsea/8=; b=TI5TNF1YiZDwI0LpLBumtD
 v+E+ErvNO2i+sSatlooba+AlT8H4FSmtyy70k/WpG5tXhIGjtTdL0h8fCp/l3ma/
 rSkZs/2CtFt/IsGpmmgZmOEweu6E86Mo4U/pm52Nlqsk+qYlTNsHO/fsmTFUxgHN
 kr5zw5eCukSBBWAZB+tguS+ZMadoTJa2nm0ARVBhSK3WFTlyt+H5qR5aKjWnUZjD
 XrMv0yQE4I2tmLIC3akmHum9UbyHVp1RUS3oaj/xZAoqDmPYVVGsfftbgivFzAUL
 tO0fRKLWK7b4fAEPl1T48O4bIboKhvY/mNx8ioLBbjzyOcdV6tI8QrX8y3DnTmZw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nd4gs4k1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 12:51:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FAVUTt021822;
 Thu, 15 May 2025 12:51:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpt77s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 12:51:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FCpf4956164614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 12:51:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AB6A20160;
 Thu, 15 May 2025 12:51:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33AA42015F;
 Thu, 15 May 2025 12:51:41 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown
 [9.152.224.212])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 12:51:41 +0000 (GMT)
Date: Thu, 15 May 2025 14:51:29 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390x: Fix leak in machine_set_loadparm
Message-ID: <20250515145129.4182bcca.pasic@linux.ibm.com>
In-Reply-To: <20250509174938.25935-1-farosas@suse.de>
References: <20250509174938.25935-1-farosas@suse.de>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: koha7vWX59X567Kk9eKeMQQETAwqNYgU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEyNCBTYWx0ZWRfX0lJcfasK2yhv
 rXhdMb2sx7c6BgNOFeCJwf/0grMUYRskXaZfIR/AZxPLwW68x+8XItWL2P0Smq78PuoqhfMlnjy
 oegNDEI8nEhtqH3YrEgoUiudbStpLl7LDIfGUcgAqgohNLeJKGlJ5mvyrVQUHKQ2EQ7kfT9L7Lx
 Im68ii3BP/Z7Blw32w02p9BRkj4JJe0fRWsNBSxwU1uZWIU2gd0IIRBeyFG6qcoTqrHi1hgf3dE
 HuwCA4lTe/6GPb0ZVgwMjiQixEgmy7bdGvLqSahohM/Exo18unwK2CQiPG4zQpTZbcRVCrG6S1g
 Y6c8ijHx3slmi7J0s4Iji/XFnhcdWN9EYkLseNhE1e1+n4WO+W4XmlHnJPhs4PKlcvAPgmU57ce
 eEKbuN5RfIGg1Jp/Yth0E7QVCBqzEXLebIeWbh4vMTew/JLaAjbH2G48tZfYsEcnN81qZ1wP
X-Proofpoint-ORIG-GUID: koha7vWX59X567Kk9eKeMQQETAwqNYgU
X-Authority-Analysis: v=2.4 cv=OsNPyz/t c=1 sm=1 tr=0 ts=6825e362 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=X7Hbc9okz4KFaIvFruIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_05,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150124
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri,  9 May 2025 14:49:38 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> ASAN spotted a leaking string in machine_set_loadparm():
> 
> Direct leak of 9 byte(s) in 1 object(s) allocated from:
>     #0 0x560ffb5bb379 in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:69:3
>     #1 0x7f1aca926518 in g_malloc ../glib/gmem.c:106
>     #2 0x7f1aca94113e in g_strdup ../glib/gstrfuncs.c:364
>     #3 0x560ffc8afbf9 in qobject_input_type_str ../qapi/qobject-input-visitor.c:542:12
>     #4 0x560ffc8a80ff in visit_type_str ../qapi/qapi-visit-core.c:349:10
>     #5 0x560ffbe6053a in machine_set_loadparm ../hw/s390x/s390-virtio-ccw.c:802:10
>     #6 0x560ffc0c5e52 in object_property_set ../qom/object.c:1450:5
>     #7 0x560ffc0d4175 in object_property_set_qobject ../qom/qom-qobject.c:28:10
>     #8 0x560ffc0c6004 in object_property_set_str ../qom/object.c:1458:15
>     #9 0x560ffbe2ae60 in update_machine_ipl_properties ../hw/s390x/ipl.c:569:9
>     #10 0x560ffbe2aa65 in s390_ipl_update_diag308 ../hw/s390x/ipl.c:594:5
>     #11 0x560ffbdee132 in handle_diag_308 ../target/s390x/diag.c:147:9
>     #12 0x560ffbebb956 in helper_diag ../target/s390x/tcg/misc_helper.c:137:9
>     #13 0x7f1a3c51c730  (/memfd:tcg-jit (deleted)+0x39730)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>



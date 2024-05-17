Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28583C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 08:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7sxq-00026z-M4; Fri, 17 May 2024 04:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1s7sxl-00023E-TT; Fri, 17 May 2024 04:29:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1s7sxg-0004yV-1m; Fri, 17 May 2024 04:29:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44H8SAtV003430; Fri, 17 May 2024 08:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Fe+p7CxJOmrsH30c3QpOE5NrjA7w6qpsrt7vnNrsPMw=;
 b=Uhoz2WC+CuXEFASvZiSkfenHAIrYxYzRaq917ZYEqMHdi8DLc6VCly/1/ivwFVFA5wCp
 saipXVjLc6flwB7pB7nQAdeHIJtQBYQiyqyEk4K2ATDox4qmi1MF7IWCJCWu+N0cNzA5
 lval1Vi95YOAgXM2xJjqrLhwIzL4bRwfld3PVpZ5DDL5tpsU0n9yeaJwblA9eW44wfks
 Qaduf8g+eUo4lQzbz997xUmiO9GSVb8lkahUyGI1oGy1skTuaDfKdACLr19afuy1OyDJ
 jHNL/2xepFrCsl6SmfWFgYTByGxpVzPX0LyS8op0kdJfZ3G0bV7qlRQrcaNcPFKifCIY gA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y63r5g077-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 08:29:06 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44H8T5cw006334;
 Fri, 17 May 2024 08:29:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y63r5g072-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 08:29:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44H7ZAvb002310; Fri, 17 May 2024 08:29:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0pq3ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 08:29:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44H8SwMD17957364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 May 2024 08:29:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D53B52004F;
 Fri, 17 May 2024 08:28:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5663720043;
 Fri, 17 May 2024 08:28:58 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown
 [9.171.18.143])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 17 May 2024 08:28:58 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/intc/s390_flic: Fix crash that occurs when saving
 the machine state
In-Reply-To: <20240517061553.564529-1-thuth@redhat.com>
References: <20240517061553.564529-1-thuth@redhat.com>
Date: Fri, 17 May 2024 10:28:56 +0200
Message-ID: <87y188on93.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0Sa0BlZPntW62M7VoUVS7MUaN7rTIra4
X-Proofpoint-ORIG-GUID: oGS-GDj4J1DveK9s8cKY-M5ocEdD7K_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405170066
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, May 17, 2024 at 08:15 AM +0200, Thomas Huth <thuth@redhat.com> wrot=
e:
> adapter_info_so_needed() treats its "opaque" parameter as a S390FLICState,
> but the function belongs to a VMStateDescription that is attached to a
> TYPE_VIRTIO_CCW_BUS device. This is currently causing a crash when the
> user tries to save or migrate the VM state. Fix it by using s390_get_flic=
()
> to get the correct device here instead.
>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: 9d1b0f5bf5 ("s390_flic: add migration-enabled property")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/intc/s390_flic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 7f93080087..6771645699 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -459,7 +459,7 @@ type_init(qemu_s390_flic_register_types)
>=20=20
>  static bool adapter_info_so_needed(void *opaque)
>  {
> -    S390FLICState *fs =3D S390_FLIC_COMMON(opaque);
> +    S390FLICState *fs =3D s390_get_flic();
>=20=20
>      return fs->migration_enabled;
>  }
> --=20
> 2.45.0
>

Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>

Thanks.

--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294


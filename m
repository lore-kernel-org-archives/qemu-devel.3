Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9F8C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9NC4-00025y-KS; Mon, 28 Apr 2025 08:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1u9NBS-0001yL-3Y; Mon, 28 Apr 2025 08:02:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1u9NBP-00036j-TQ; Mon, 28 Apr 2025 08:02:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SA4LIk028116;
 Mon, 28 Apr 2025 12:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2UwRbD
 8l8ndrkmd372YpJ5wDhdx+ylZRjTHduVtT+nU=; b=DVviQGIXNv+9UMFzTASEQP
 gDo9WKpQYFUladd6q1vxZIPd5o8dHFs6LJmMaCCXPYVD2w2sBOH4b6lAP1SVup/G
 o5tRKyPZNDuvBCKljYCejWLSTp/vi/9E4roFttVuC/luahS7aD1Kcn1MSei26Xl+
 BM5k+QSikI2l7uQx3XtG6Dn9o4aQr3JLgVI26zp2XzxDIoVBZ7BX1UrkW/Mh7+08
 0Su3ITQ3GxY6CYHWU7RLJ7JwO45AKtGUm9wEJ3JMNMTKXRGIEIsybDtvxSHzf3bU
 wpCbSUO69EbXrooDJw5jZzFe//T3tJ4EZqyb2uCCF0cUk0trg3O/9mvAFSz7Qpag
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46a7kk0f42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 12:01:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53S7evFk001803;
 Mon, 28 Apr 2025 12:01:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bame6ne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 12:01:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53SC1hZW54722912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 12:01:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 550232004D;
 Mon, 28 Apr 2025 12:01:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2246B20043;
 Mon, 28 Apr 2025 12:01:43 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.80]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Apr 2025 12:01:43 +0000 (GMT)
Message-ID: <af38cbebea53bea3e06537ec69c25a2a3d36577c.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/4] hw/s390x: add Control-Program Identification to QOM
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Daniel
 Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Mon, 28 Apr 2025 14:01:44 +0200
In-Reply-To: <20250410150934.1331433-3-shalini@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OYSYDgTY c=1 sm=1 tr=0 ts=680f6e34 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=BekG5rTWfsv0CdK2JX0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aFB7g8swvj89DRAduZ4wsgZ0UIeMvMr4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA5NiBTYWx0ZWRfX7lsAaeRUBSOu
 s8+7IEWIy6ITfDtw97o5PlzwxjX8UfoMT3WIwYOQAdnf3hy57nipKxVXzwXTkupIbCJY74Bgwt+
 8OseCtdbsuiBbXyfekbeQCb7RCIxBkdGxa+w92BVxCGPkwkf0LgW7OynriWqoyaIhECKoqrmCNa
 Xx2VlWoW350Jla968YHDwa/OAgJOpeu9H92e48bl/1vCqQI/N42GYP5U786utdg/kaSSp2sLJY2
 9naH8pYgFWlD73qG7bIJyzJwAGanrGVx2LHct5/mGv4gmwNkAkjuiasmlda7BRUZeZEp0FMF+ue
 4PHdMS4cG6IDP9yJIAw/qCTKoj+1bg9vi8SwrrXuF03PB5+Mb8dCWpBNoH9STXuUMaAsLnbmMmD
 c7VOhMujHWd0GlAvCdTLR5pQn/Uh+oqBcX4TC6TZTi3VO9aQr3fat8oXRVcD/CVmabFj3+IH
X-Proofpoint-ORIG-GUID: aFB7g8swvj89DRAduZ4wsgZ0UIeMvMr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280096
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification data to the QEMU Object
> Model (QOM), along with the timestamp in which the data was received.
>=20
> Example:
> virsh # qemu-monitor-command vm --pretty '{
> "execute": "qom-get",
> "arguments": {
> "path": "/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property": "control-program-id" }}'
> {
>   "return": {
>     "timestamp": 1742390410685762000,
>     "system-level": 74872343805430528,
>     "sysplex-name": "PLEX ",
>     "system-name": "TESTVM  ",
>     "system-type": "LINUX   "
>   },
>   "id": "libvirt-15"
> }
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>  hw/s390x/sclpcpi.c                | 39 +++++++++++++++++++++
>  include/hw/s390x/event-facility.h |  9 +++++
>  qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+)

[...]

> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -199,9 +199,18 @@ typedef struct SCLPEventCPI SCLPEventCPI;
>  OBJECT_DECLARE_TYPE(SCLPEventCPI, SCLPEventCPIClass,
>                      SCLP_EVENT_CPI)
> =20
> +typedef struct ControlProgramId {
> +    uint8_t system_type[8];
> +    uint8_t system_name[8];
> +    uint64_t system_level;
> +    uint8_t sysplex_name[8];
> +    uint64_t timestamp;
> +} ControlProgramId;
> +
>  struct SCLPEventCPI {
>      DeviceState qdev;
>      SCLPEvent event;
> +    ControlProgramId cpi;

Now that this struct exists I would go ahead and inline ControlProgramId.

>  };
> =20
>  #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"

[...]
--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294


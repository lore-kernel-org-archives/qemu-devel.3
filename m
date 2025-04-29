Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13910C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9h8U-0006vy-Pa; Tue, 29 Apr 2025 05:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1u9h8P-0006l8-Np; Tue, 29 Apr 2025 05:20:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1u9h8N-0004fs-Gq; Tue, 29 Apr 2025 05:20:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4ESrh006492;
 Tue, 29 Apr 2025 09:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dpAS50
 J9K4bmIU5YjF4pL4ZxOYz4xQ9yDjBS7yKG+fU=; b=n6y/JFf/qtTrJTm/KyWptr
 vp3C/ZRDC20MQx351+UD8w/YbGK00VtgvkHVr3OWhhW7XmEIySv6l+q5MhUxtIE0
 UWzYcLxmDCACGhQEvZKL/SvOAdqJaNlvWl/REixWT0jpEVg5GwvhX7nzRRoDL2ax
 gVnd5Eq5lFdJP3Qt3moKPb7gYbFT4OnDVrT2KeJuAKhpXex44+4zKukg3ynXkaBA
 krzQHq8Q9bYCs04O6hByxE9Fb+DWO1QbJ6LvT7RyvozxlF/GB5/yVvzqpx8JNkJF
 7gaHeEskXlo/Ti8IEn0TPDruoKhzw6n6e+lz4MYHYfjCM0DrKvTXT8UHjobpmB5Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahs9a7u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 09:20:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T8pXGp016119;
 Tue, 29 Apr 2025 09:20:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a70ann9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 09:20:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53T9K3Bd32113358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 09:20:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F05C12022D;
 Tue, 29 Apr 2025 09:20:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98CF72022E;
 Tue, 29 Apr 2025 09:20:02 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.87.129.78]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 09:20:02 +0000 (GMT)
Message-ID: <fd8ffc6bf1ba66c0479f6b02bbc747d392d34f1c.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] hw/s390x: add SCLP event type CPI
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Daniel
 Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Tue, 29 Apr 2025 11:20:02 +0200
In-Reply-To: <20250410150934.1331433-2-shalini@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-2-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LuKSymdc c=1 sm=1 tr=0 ts=681099c8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=d4LToudSVkjQPbQJ9YAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GvEA3X0iq-1MWk-D4JXQVXaT9uSad081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA2NyBTYWx0ZWRfX4tf4tDwK1FYU
 07bIGj3NWSD2LQNKWxD/hXXiw+o5LpzKECZZ2TFk+ajyv01b1CevJCh4BKT+qNYUx1SaBXwM37T
 NrsUVcKMawTCHzyNAjemZRnd8cdr4mfdLGgqpFxGcqlcWvu230ZZZwW5DcMR3JQuwCX0Od0I6W8
 /Vz1fSSM3XshY/mY3avnrsnfTQ7mjQT7a2zG6o7kBUKAb6IFc4qa4sC+CdaBVE9HpnijKovbhJe
 COFn/k9tI1kA4bzE5YHjKe/rcSI7GeLPFK/urexfr+LpjCda3G/wIJe/Rm0s9NWMIQ1rbKc7vxw
 HoaNXDR66Cz7296lP1J1dL4U2j+4/iMA8r1db6MDFNv0hVHT8KH79/3b2f7v08uVrkdyEs9wdib
 KkLrEgTIv6fDUEEB2ufHBFHcyR7nxwGsf0ScSqZ8lyfdYBRiDerN02J3aptPW/Sw1ia3FmWw
X-Proofpoint-GUID: GvEA3X0iq-1MWk-D4JXQVXaT9uSad081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290067
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
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

On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
> Implement the Service-Call Logical Processor (SCLP) event
> type Control-Program Identification (CPI) in QEMU. This
> event is used to send CPI identifiers from the guest to the
> host. The CPI identifiers are: system type, system name,
> system level and sysplex name.
>=20
> System type: operating system of the guest (e.g. "LINUX").
> System name: user configurable name of the guest (e.g. "TESTVM").
> System level: distribution and kernel version, if the system type is Linu=
x
> (e.g. 0x50e00).
> Sysplex name: name of the cluster which the guest belongs to (if any)
> (e.g. "PLEX").
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/event-facility.c         |  2 +
>  hw/s390x/meson.build              |  1 +
>  hw/s390x/s390-virtio-ccw.c        | 14 +++++
>  hw/s390x/sclpcpi.c                | 92 +++++++++++++++++++++++++++++++
>  include/hw/s390x/event-facility.h | 13 +++++
>  5 files changed, 122 insertions(+)
>  create mode 100644 hw/s390x/sclpcpi.c

[...]


>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> new file mode 100644
> index 0000000000..13589459b1
> --- /dev/null
> +++ b/hw/s390x/sclpcpi.c

[...]

> +static void cpi_class_init(ObjectClass *klass, void *data)

Should be 'const void *data'.

> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    SCLPEventClass *k =3D SCLP_EVENT_CLASS(klass);
> +
> +    dc->user_creatable =3D false;
> +
> +    k->can_handle_event =3D can_handle_event;
> +    k->get_send_mask =3D send_mask;
> +    k->get_receive_mask =3D receive_mask;
> +    k->write_event_data =3D write_event_data;
> +}

[...]

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294


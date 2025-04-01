Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B96C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzc7V-0000r3-QN; Tue, 01 Apr 2025 09:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tzc5T-0007qG-Tb; Tue, 01 Apr 2025 09:55:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tzc5S-00089W-4E; Tue, 01 Apr 2025 09:55:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5318oVxE031090;
 Tue, 1 Apr 2025 13:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=w+VfJp
 lgE+gW980p6hx4ONMithxRflQKBUxtQpfnZps=; b=kBC7h2kmfOwbocd/vpyNlY
 sWUGm7C0irUIgcxJF66ak4a5k+BUPA93AEtZheaJTGHe9iX78lFO+64dOnFrvyKL
 8E3VHHKUxsyfWu5v2wx5aTaELHZGL60DdrgCTTAGoHXv7RqrvBXW1n47tvLbXHHe
 Kz38DNlrBP/aT/K1ip3mUJgonCvHYpQruhLoKk/4zmTX8rnRg3dvVQILaIUzwnQH
 UYKd1YOEOnNxbIskq2atbkn7Ml1svcA5mtKhQyF/IfpKpNXy+Fo3mrAju4IxDtGz
 jY7yOGjOwBNJxLLkGRqOpam1pzahQfIpupWO0mVXDQ/PkZmWadYlLnXwaolSRWIA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q40bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 13:55:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531CLmX7010313;
 Tue, 1 Apr 2025 13:55:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6ntr66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 13:55:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 531DtJZk42140050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Apr 2025 13:55:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4434F20043;
 Tue,  1 Apr 2025 13:55:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB8BF20040;
 Tue,  1 Apr 2025 13:55:18 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.0.254]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Apr 2025 13:55:18 +0000 (GMT)
Message-ID: <9f8c17cbdf157ceb7b339b4fbfc1cf7d06082df0.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/4] hw/s390x: add Control-Program Identification to QOM
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Daniel
 Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Tue, 01 Apr 2025 15:55:20 +0200
In-Reply-To: <20250331140041.3133621-3-shalini@linux.ibm.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
 <20250331140041.3133621-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TawFrlIIYxuu-6fmO3ed3SqM-8qk6Gv1
X-Proofpoint-GUID: TawFrlIIYxuu-6fmO3ed3SqM-8qk6Gv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010083
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Mon, 2025-03-31 at 16:00 +0200, Shalini Chellathurai Saroja wrote:
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
>  hw/s390x/sclpcpi.c                | 38 ++++++++++++++++++++
>  include/hw/s390x/event-facility.h |  9 +++++
>  qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>=20
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index 7ace5dd64e..969c15e43d 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -57,8 +57,11 @@
>    */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/timer.h"
>  #include "hw/s390x/sclp.h"
>  #include "hw/s390x/event-facility.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "qapi/qapi-visit-machine.h"
> =20
>  typedef struct Data {
>      uint8_t id_format;
> @@ -99,10 +102,37 @@ static int write_event_data(SCLPEvent *event, EventB=
ufferHeader *evt_buf_hdr)
>      ControlProgramIdMsg *cpim =3D container_of(evt_buf_hdr, ControlProgr=
amIdMsg,
>                                               ebh);
> =20
> +    ascii_put(event->cpi.system_type, (char *)cpim->data.system_type, 8)=
;
> +    ascii_put(event->cpi.system_name, (char *)cpim->data.system_name, 8)=
;
> +    ascii_put(event->cpi.sysplex_name, (char *)cpim->data.sysplex_name, =
8);
> +    event->cpi.system_level =3D ldq_be_p(&cpim->data.system_level);
> +    event->cpi.timestamp =3D qemu_clock_get_ns(QEMU_CLOCK_HOST);
> +
>      cpim->ebh.flags =3D SCLP_EVENT_BUFFER_ACCEPTED;
>      return SCLP_RC_NORMAL_COMPLETION;
>  }
> =20
> +static void get_control_program_id(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    SCLPEvent *event =3D (SCLPEvent *)(obj);

Do a checked cast with SCLP_EVENT(obj).

> +    S390ControlProgramId *cpi;
> +
> +    cpi =3D &(S390ControlProgramId){
> +        .system_type =3D g_strndup((char *) event->cpi.system_type,
> +                                 sizeof(event->cpi.system_type)),
> +        .system_name =3D g_strndup((char *) event->cpi.system_name,
> +                                 sizeof(event->cpi.system_name)),
> +        .system_level =3D event->cpi.system_level,
> +        .sysplex_name =3D g_strndup((char *) event->cpi.sysplex_name,
> +                                  sizeof(event->cpi.sysplex_name)),
> +        .timestamp =3D event->cpi.timestamp
> +    };
> +
> +    visit_type_S390ControlProgramId(v, name, &cpi, errp);
> +}
> +
>  static void cpi_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -114,6 +144,14 @@ static void cpi_class_init(ObjectClass *klass, void =
*data)
>      k->get_send_mask =3D send_mask;
>      k->get_receive_mask =3D receive_mask;
>      k->write_event_data =3D write_event_data;
> +
> +    object_class_property_add(klass, "control-program-id",
> +                              "S390ControlProgramId",
> +                              get_control_program_id,
> +                              NULL, NULL, NULL);
> +    object_class_property_set_description(klass, "control-program-id",
> +        "Control-program identifiers provide data about the guest "
> +        "operating system");
>  }
> =20
>  static const TypeInfo sclp_cpi_info =3D {
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-f=
acility.h
> index f445d2f9f5..39e589ed44 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -169,10 +169,19 @@ typedef struct ReadEventData {
>      };
>  } QEMU_PACKED ReadEventData;
> =20
> +typedef struct ControlProgramId {
> +    uint8_t system_type[8];
> +    uint8_t system_name[8];
> +    uint64_t system_level;
> +    uint8_t sysplex_name[8];
> +    uint64_t timestamp;
> +} QEMU_PACKED ControlProgramId;
> +
>  struct SCLPEvent {
>      DeviceState qdev;
>      bool event_pending;
>      char *name;
> +    ControlProgramId cpi;

I don't think this should go into SCLPEvent.
Rather SCLPEventFacility or SCLPDevice. Otherwise all events,
so also quiesce and cpu_hotplug have a cpi field.

>  };

[...]
--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294


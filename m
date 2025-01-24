Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F621C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 18:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbO8m-00029h-9O; Fri, 24 Jan 2025 13:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tbO8k-00028z-IG; Fri, 24 Jan 2025 13:10:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tbO8i-00076I-Pq; Fri, 24 Jan 2025 13:10:46 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OFdd4R013684;
 Fri, 24 Jan 2025 18:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=x/CUk1
 GoNbuO1ZvMpgkbANBUpyk/TiT3AQ8NOgUGZ14=; b=trZRBXQkYFCtnjPaRvXf05
 W0sNdE2bNfDYcJj7gARWIDOWz57lDguLmV2QTzSQOLlYrlTkt9vmqJbssBAMDwmw
 wTcoeJeG9ERl7OFvsc/UVzvN+1ZodexuMLQN88T8Qf1iPx+ng8hPOEubYM2pgzvW
 SMW6JRqVMllfYDRnrEjhqp4n8CP+tC4CiqUBfcqY+TCVCkq5FXCWI41CuGh8A1sg
 4wnxJrZPWTNs61VFG4hUTTWaMVUagP1j6YtJ0rxDsUdTo8MMD979kYnMDQA/g3Yz
 +jy+lu4ZLS5xV0XhrsoLt+H2ZsfYNxxov5LW98XTb8KObAONyCgRhXFU5sTSohSg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cdptrrdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 18:10:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OGBmem029538;
 Fri, 24 Jan 2025 18:10:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnvs2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 18:10:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50OIAd9q30933752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2025 18:10:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2019E20088;
 Fri, 24 Jan 2025 17:49:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C303020087;
 Fri, 24 Jan 2025 17:49:45 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.27.114]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jan 2025 17:49:45 +0000 (GMT)
Message-ID: <812ab32cb4f2ca3d8290936989491b8f3b970692.camel@linux.ibm.com>
Subject: Re: [PATCH v1 2/3] hw/s390x: add CPI values to QOM
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x
 mailing list <qemu-s390x@nongnu.org>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Fri, 24 Jan 2025 18:49:45 +0100
In-Reply-To: <20250115133106.3034445-2-shalini@linux.ibm.com>
References: <20250115133106.3034445-1-shalini@linux.ibm.com>
 <20250115133106.3034445-2-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QmcXeEd0ccAjetHlErWgwDxhDktokAse
X-Proofpoint-GUID: QmcXeEd0ccAjetHlErWgwDxhDktokAse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 2025-01-15 at 14:31 +0100, Shalini Chellathurai Saroja wrote:
> This commit adds the firmware control-program
> identifiers received from a KVM guest via the
> SCLP event type Control-Program Identification to QOM.
> A timestamp in which the data is received is also
> added to QOM.
>=20
> Example:
> virsh # qemu-monitor-command vm --pretty '{
> "execute":"qom-get","arguments": {
> "path": "/machine", "property": "s390-cpi"}}'
> {
>   "return": {
>     "timestamp": 1711620874948254000,
>     "system-level": "0x50e00",
>     "sysplex-name": "SYSPLEX ",
>     "system-name": "TESTVM  ",
>     "system-type": "LINUX   "
>   },
>   "id": "libvirt-15"
> }
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 26 ++++++++++++++++++++++++++
>  hw/s390x/sclpcpi.c                 | 10 ++++++++++
>  include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
>  qapi/machine.json                  | 24 ++++++++++++++++++++++++
>  4 files changed, 68 insertions(+)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 38aeba14ee..35fb523af9 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -49,6 +49,7 @@
>  #include "hw/virtio/virtio-md-pci.h"
>  #include "hw/s390x/virtio-ccw-md.h"
>  #include CONFIG_DEVICES
> +#include "qapi/qapi-visit-machine.h"
> =20
>  static Error *pv_mig_blocker;
> =20
> @@ -773,6 +774,25 @@ static void machine_set_loadparm(Object *obj, Visito=
r *v,
>      s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
>  }
> =20
> +static void machine_get_cpi(Object *obj, Visitor *v,
> +                             const char *name, void *opaque, Error **err=
p)
> +{
> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(obj);
> +    S390Cpi *cpi;
> +    cpi =3D &(S390Cpi){
> +        .system_type =3D g_strndup((char *) ms->cpi.system_type,
> +                       sizeof(ms->cpi.system_type)),
> +        .system_name =3D g_strndup((char *) ms->cpi.system_name,
> +                       sizeof(ms->cpi.system_name)),
> +        .system_level =3D g_strdup_printf("0x%lx", ms->cpi.system_level)=
,

Is there any way in which it would make sense for the qmp caller to
interpret this as a number? If so exposing it as a number would be preferab=
le.

> +        .sysplex_name =3D g_strndup((char *) ms->cpi.sysplex_name,
> +                        sizeof(ms->cpi.sysplex_name)),
> +        .timestamp =3D ms->cpi.timestamp
> +    };
> +
> +    visit_type_S390Cpi(v, name, &cpi, &error_abort);
> +}
> +
>  static void ccw_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -826,6 +846,12 @@ static void ccw_machine_class_init(ObjectClass *oc, =
void *data)
>              "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars con=
verted"
>              " to upper case) to pass to machine loader, boot manager,"
>              " and guest kernel");
> +    object_class_property_add(oc, "s390-cpi", "S390Cpi",
> +        machine_get_cpi, NULL, NULL, NULL);
> +    object_class_property_set_description(oc, "s390-cpi",
> +        "Control-progam identifiers provide data about the guest "
> +        "operating system");
> +
>  }
> =20
>  static inline void s390_machine_initfn(Object *obj)
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index 64bc730f47..75101b8f61 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -20,8 +20,11 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/timer.h"
>  #include "hw/s390x/sclp.h"
>  #include "hw/s390x/event-facility.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> =20
>  typedef struct Data {
>      uint8_t id_format;
> @@ -60,6 +63,13 @@ static sccb_mask_t receive_mask(void)
>  static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf=
_hdr)
>  {
>      CPI *cpi =3D container_of(evt_buf_hdr, CPI, ebh);
> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(qdev_get_machine());
> +
> +    ascii_put(ms->cpi.system_type, (char *)cpi->data.system_type, 8);
> +    ascii_put(ms->cpi.system_name, (char *)cpi->data.system_name, 8);
> +    ascii_put(ms->cpi.sysplex_name, (char *)cpi->data.sysplex_name, 8);
> +    ms->cpi.system_level =3D cpi->data.system_level;

cpi is overlayed with the sccb copied from the guest, correct?
So you need a endianess conversion here.

> +    ms->cpi.timestamp =3D qemu_clock_get_ns(QEMU_CLOCK_HOST);
> =20
>      cpi->ebh.flags =3D SCLP_EVENT_BUFFER_ACCEPTED;
>      return SCLP_RC_NORMAL_COMPLETION;
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-v=
irtio-ccw.h
> index 686d9497d2..c4212ff857 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -19,6 +19,13 @@
> =20
>  OBJECT_DECLARE_TYPE(S390CcwMachineState, S390CcwMachineClass, S390_CCW_M=
ACHINE)
> =20
> +typedef struct Cpi {
> +    uint8_t system_type[8];
> +    uint8_t system_name[8];
> +    uint64_t system_level;
> +    uint8_t sysplex_name[8];
> +    uint64_t timestamp;
> +} QEMU_PACKED Cpi;

I don't like there being a CPI and a Cpi struct. I'd just go ahead and inli=
ne the
definition into S390CcwMachineState and not name this type.
> =20
>  struct S390CcwMachineState {
>      /*< private >*/
> @@ -33,6 +40,7 @@ struct S390CcwMachineState {
>      uint64_t max_pagesize;
> =20
>      SCLPDevice *sclp;
> +    Cpi cpi;
>  };
> =20
>  static inline uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms=
)
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795b09..9dcd2790eb 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1898,3 +1898,27 @@
>  { 'command': 'x-query-interrupt-controllers',
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ]}
> +
> +##
> +# @S390Cpi:

Maybe spelling this out would be preferable?
S390ControlProgramId?

> +#
> +# Control-program identifiers provide data about Linux instance.
> +#
> +# @system-type: operating system of Linux instance
> +#
> +# @system-name: system name of Linux instance
> +#
> +# @system-level: distribution and kernel version of Linux instance
> +#
> +# @sysplex-name: sysplex name of Linux instance
> +#
> +# @timestamp: latest update of CPI data
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'S390Cpi', 'data': {
> +     'system-type': 'str',
> +     'system-name': 'str',
> +     'system-level': 'str',
> +     'sysplex-name': 'str',
> +     'timestamp': 'uint64' } }



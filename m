Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920B8C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 17:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZoE-0001DF-6e; Tue, 17 Jun 2025 13:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uRZo8-0001C1-8l; Tue, 17 Jun 2025 13:09:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uRZo5-0005Lx-PZ; Tue, 17 Jun 2025 13:09:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HGMbiU021087;
 Tue, 17 Jun 2025 17:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TKct++
 FKhT++aBWp1PBK0gUWWHboJFYkWa/Es3NZhWQ=; b=EVarxTVWl37/mwPtpzpCtK
 ws8AFSWweOcrr/StqVPLs4NfGFu+SSwu5kfWsHHJcyA0xdb08DSwvf6f2QJbnp1c
 kvNABI4njSIU2LKicuguhUyB6BQyvuLIO4b6idTDaMsFEUZ3RsFsiSx9MLdxvLpL
 tvFtlaHm9lhBI2rCEkRSX3NztaZnJLh87RkGMxsiwGjCOG5O/fK6rH6w3VbtX7wM
 LGCVhgca0el67fb6qIHntYaQyc3lqDD/XrLj46qqvQTY8NZjGUUHTkJ4p4ihb7k5
 8oH40ue7S848F0CEXWwnH5PbS7i8YkEQUq5loAz9NFXxEaU01Njeo/vYm5o16ydg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4hw87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 17:09:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HFtthq000720;
 Tue, 17 Jun 2025 17:09:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdp4nde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 17:09:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55HH90hw25428486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 17:09:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E8FC20040;
 Tue, 17 Jun 2025 17:09:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D92FD20043;
 Tue, 17 Jun 2025 17:08:59 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.111.37.233]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Jun 2025 17:08:59 +0000 (GMT)
Message-ID: <7f357b35ca800e45c4aff4635f06eb2ed79384fd.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/3] hw/s390x: add Control-Program Identification to QOM
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x
 mailing list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Tue, 17 Jun 2025 19:09:00 +0200
In-Reply-To: <20250616140107.990538-3-shalini@linux.ibm.com>
References: <20250616140107.990538-1-shalini@linux.ibm.com>
 <20250616140107.990538-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEzMyBTYWx0ZWRfX29WjSS/mmXad
 Hq0mjdx4lVqak1x+M8MZQIEuntXiD4YFtU1eXY7XUYClGxkevMto0qYv0NmDdnMLBdFz1m09Ltx
 LeNsjZHyA5B2p8FtOfhRchbgIkB6TDQk7vr51hO5dCojoqJV2GHFYjHKmpAO/Dv8XapdXPB/by3
 qSkMrtv2MoQp2dxQ8kCVJoHhbaD6GgdiJau3ogYZpuHbGc8Y/4Viy0QAX9CCvBK2MLC+pdrVHIW
 gXmfq5ZM6kSXogm1nvVS/IIpLdBiMQxLhczlkKL8m3Fx3aUwD6pWxY/TGhXwGXd9PmgYibHdCVV
 rdXzK+qU6l4+Obr1JeZd7EvO6klPAr4Lta3ItLSLN3RWhM9d9rjen5eBBepevCk3VJQNgKA9YkZ
 8ZbgULR6kjXKmvrSiAGAQIQYUBGPmkO06Zojo0VBVg/gCxIHXNUcjtP804e9Nfh2SEwa+V7n
X-Proofpoint-ORIG-GUID: PcW70ojdapHTUtmp0HnFDRvDIokvdxJ4
X-Authority-Analysis: v=2.4 cv=Qc9mvtbv c=1 sm=1 tr=0 ts=6851a131 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=v-TSnZwwBYDKHLXzokYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PcW70ojdapHTUtmp0HnFDRvDIokvdxJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170133
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
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

On Mon, 2025-06-16 at 16:01 +0200, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification (CPI) data to the QEMU Object
> Model (QOM), along with the timestamp in which the data was received
> as shown below.
>=20
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-list",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
> {
>   "return": [
>     [...]
>     {
>       "name": "system_level",
>       "type": "uint64"
>     },
>     {
>       "name": "system_name",
>       "type": "string"
>     },
>     {
>       "name": "system_type",
>       "type": "string"
>     },
>     {
>       "name": "timestamp",
>       "type": "uint64"
>     },
>     {
>       "name": "sysplex_name",
>       "type": "string"
>     }
>   ],
>   "id": "libvirt-14"
> }
>=20
> Example CPI data:
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"system_type"}}'
> {
>   "return": "LINUX   ",
>   "id": "libvirt-18"
> }
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"system_name"}}'
> {
>   "return": "TESTVM  ",
>   "id": "libvirt-19"
> }
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"sysplex_name"}}'
> {
>   "return": "PLEX    ",
>   "id": "libvirt-20"
> }
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"system_level"}}'
> {
>   "return": 74872343805430528,
>   "id": "libvirt-21"
> }
> virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
> "arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property":"timestamp"}}'
> {
>   "return": 1748866753433923000,
>   "id": "libvirt-22"
> }
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>  hw/s390x/sclpcpi.c                | 74 +++++++++++++++++++++++++++++++
>  include/hw/s390x/event-facility.h |  5 +++
>  2 files changed, 79 insertions(+)
>=20
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index a0b175c5d5..352ef0461d 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -50,7 +50,10 @@
>    */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/timer.h"
>  #include "hw/s390x/event-facility.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "qapi/qapi-visit-machine.h"
> =20
>  typedef struct Data {
>      uint8_t id_format;
> @@ -90,11 +93,58 @@ static int write_event_data(SCLPEvent *event, EventBu=
fferHeader *evt_buf_hdr)
>  {
>      ControlProgramIdMsg *cpim =3D container_of(evt_buf_hdr, ControlProgr=
amIdMsg,
>                                               ebh);
> +    SCLPEventCPI *e =3D SCLP_EVENT_CPI(event);
> +
> +    ascii_put(e->system_type, (char *)cpim->data.system_type,
> +              sizeof(cpim->data.system_type));
> +    ascii_put(e->system_name, (char *)cpim->data.system_name,
> +              sizeof(cpim->data.system_name));
> +    ascii_put(e->sysplex_name, (char *)cpim->data.sysplex_name,
> +              sizeof(cpim->data.sysplex_name));
> +    e->system_level =3D ldq_be_p(&cpim->data.system_level);
> +    e->timestamp =3D qemu_clock_get_ns(QEMU_CLOCK_HOST);
> =20
>      cpim->ebh.flags =3D SCLP_EVENT_BUFFER_ACCEPTED;
>      return SCLP_RC_NORMAL_COMPLETION;
>  }
> =20
> +static char *get_system_type(Object *obj, Error **errp)
> +{
> +    SCLPEventCPI *e =3D SCLP_EVENT_CPI(obj);
> +
> +    return g_strndup((char *) e->system_type, sizeof(e->system_type));
> +}
> +
> +static char *get_system_name(Object *obj, Error **errp)
> +{
> +    SCLPEventCPI *e =3D SCLP_EVENT_CPI(obj);
> +
> +    return g_strndup((char *) e->system_name, sizeof(e->system_name));
> +}
> +
> +static char *get_sysplex_name(Object *obj, Error **errp)
> +{
> +    SCLPEventCPI *e =3D SCLP_EVENT_CPI(obj);
> +
> +    return g_strndup((char *) e->sysplex_name, sizeof(e->sysplex_name));
> +}
> +
> +static void get_system_level(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    SCLPEventCPI *e =3D SCLP_EVENT_CPI(obj);
> +
> +    visit_type_uint64(v, name, &e->system_level, errp);
> +}
> +
> +static void get_timestamp(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    SCLPEventCPI *e =3D SCLP_EVENT_CPI(obj);
> +
> +    visit_type_uint64(v, name, &e->timestamp, errp);
> +}
> +
>  static void cpi_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -106,6 +156,30 @@ static void cpi_class_init(ObjectClass *klass, const=
 void *data)
>      k->get_send_mask =3D send_mask;
>      k->get_receive_mask =3D receive_mask;
>      k->write_event_data =3D write_event_data;
> +
> +    object_class_property_add_str(klass, "system_type", get_system_type,=
 NULL);
> +    object_class_property_set_description(klass, "system_type",
> +            "operating system e.g. \"LINUX   \"");
> +
> +    object_class_property_add_str(klass, "system_name", get_system_name,=
 NULL);
> +    object_class_property_set_description(klass, "system_name",
> +            "user configurable name of the VM e.g. \"TESTVM  \"");
> +
> +    object_class_property_add_str(klass, "sysplex_name", get_sysplex_nam=
e,
> +                                  NULL);
> +    object_class_property_set_description(klass, "sysplex_name",
> +            "name of the cluster which the VM belongs to, if any"
> +            " e.g. \"PLEX    \"");
> +
> +    object_class_property_add(klass, "system_level", "uint64", get_syste=
m_level,
> +                              NULL, NULL, NULL);
> +    object_class_property_set_description(klass, "system_level",
> +            "distribution and kernel version in Linux e.g. 7487234380543=
0528");
> +
> +    object_class_property_add(klass, "timestamp", "uint64", get_timestam=
p,
> +                              NULL, NULL, NULL);
> +    object_class_property_set_description(klass, "timestamp",
> +            "latest update of CPI data in nanoseconds since the UNIX EPO=
CH");
>  }
> =20
>  static const TypeInfo sclp_cpi_info =3D {
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-f=
acility.h
> index e81bc80498..eac7a51100 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -201,6 +201,11 @@ OBJECT_DECLARE_TYPE(SCLPEventCPI, SCLPEventCPIClass,
> =20
>  struct SCLPEventCPI {
>      SCLPEvent event;
> +    uint8_t system_type[8];
> +    uint8_t system_name[8];
> +    uint64_t system_level;
> +    uint8_t sysplex_name[8];
> +    uint64_t timestamp;
>  };
> =20
>  #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"

Might want to make the uint8_ts into chars since it's ascii, but not import=
ant.
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>


--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294


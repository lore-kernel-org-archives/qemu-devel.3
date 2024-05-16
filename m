Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ED8C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cJI-0006DQ-7Q; Thu, 16 May 2024 10:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1s7cJD-0006Ca-8m
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:42:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1s7cJ9-0001Yf-QT
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:42:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GDZdis005618
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 14:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=fmEzLS/sx3gNnhf09ClPy3N0yH7Zk3Z8Rq6/z2HP/pM=;
 b=E5sT0xGp0yrN3rmw4mzS+98xMvwWYTPvFWcxXvnO/wuhd9CHRVc893tCYc/IOeFCyqVV
 xmqgbOIeMaRKFb0OytRtdwagdba5MJPeR585kumBugpnpgC8dQReC+7muB6FFrqcATZl
 ebqekQCg5HEcadPOHMjIF/KXtBrHhuh9eqNJGExy0lRt0gChlbdSY/8azE+IUk/Y4nAS
 rEAnPI1tA5mR9f72bPWvhnVlxMtnCihpXeat+gPPjeiNgo18glzJFXhyX7UCKA2ihIu5
 ZL6KqHkK01cZT67SH/82mHCAf1iuwY2+fpilxc1yWdzvcxk6stb6xMovF+/a17V2FQFp JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5j5hgceh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 14:42:08 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44GEg7Yc025250
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 14:42:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5j5hgcee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:42:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GC0QiE005986; Thu, 16 May 2024 14:42:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmtcqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:42:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44GEg28051118390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2024 14:42:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 371372004B;
 Thu, 16 May 2024 14:42:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA9D220040;
 Thu, 16 May 2024 14:42:01 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown
 [9.171.26.104])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 May 2024 14:42:01 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: Re: [PATCH 02/13] s390_flic: add migration-enabled property
In-Reply-To: <20240509170044.190795-3-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-3-pbonzini@redhat.com>
Date: Thu, 16 May 2024 16:42:00 +0200
Message-ID: <877cftvmx3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FMANEP-l7-kvGmlIZle9Mre2vFeRjrg_
X-Proofpoint-GUID: 7nD5_nXXPjmfQSGY1FKl4x4HXSRp7yHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160103
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Thu, May 09, 2024 at 07:00 PM +0200, Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> Instead of mucking with css_migration_enabled(), add a property specific =
to
> the FLIC device, similar to what is done for TYPE_S390_STATTRIB.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/s390x/s390_flic.h | 1 +
>  hw/intc/s390_flic.c          | 6 +++++-
>  hw/s390x/s390-virtio-ccw.c   | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
> index 3907a13d076..bcb081def58 100644
> --- a/include/hw/s390x/s390_flic.h
> +++ b/include/hw/s390x/s390_flic.h
> @@ -47,6 +47,7 @@ struct S390FLICState {
>      /* to limit AdapterRoutes.num_routes for compat */
>      uint32_t adapter_routes_max_batch;
>      bool ais_supported;
> +    bool migration_enabled;
>  };
>=20=20
>=20=20
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index f4a848460b8..7f930800877 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -405,6 +405,8 @@ static void qemu_s390_flic_class_init(ObjectClass *oc=
, void *data)
>  static Property s390_flic_common_properties[] =3D {
>      DEFINE_PROP_UINT32("adapter_routes_max_batch", S390FLICState,
>                         adapter_routes_max_batch, ADAPTER_ROUTES_MAX_GSI),
> +    DEFINE_PROP_BOOL("migration-enabled", S390FLICState,
> +                     migration_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20=20
> @@ -457,7 +459,9 @@ type_init(qemu_s390_flic_register_types)
>=20=20
>  static bool adapter_info_so_needed(void *opaque)
>  {
> -    return css_migration_enabled();
> +    S390FLICState *fs =3D S390_FLIC_COMMON(opaque);
> +
> +    return fs->migration_enabled;
>  }
>=20=20
>  const VMStateDescription vmstate_adapter_info_so =3D {
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index feabc173eb3..1383e47eeb5 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -1174,6 +1174,7 @@ static void ccw_machine_2_9_class_options(MachineCl=
ass *mc)
>      S390CcwMachineClass *s390mc =3D S390_CCW_MACHINE_CLASS(mc);
>      static GlobalProperty compat[] =3D {
>          { TYPE_S390_STATTRIB, "migration-enabled", "off", },
> +        { TYPE_S390_FLIC_COMMON, "migration-enabled", "off", },
>      };
>=20=20
>      ccw_machine_2_10_class_options(mc);
> --=20
> 2.45.0
>
>

This patch causes QEMU to crash when trying to save the domain state
(e.g. using libvirt)

$ cat dom.xml
<domain type=3D'kvm'>
  <name>bug</name>
  <memory unit=3D'KiB'>1048576</memory>
  <vcpu placement=3D'static'>2</vcpu>
  <os>
    <type arch=3D's390x' machine=3D's390-ccw-virtio-9.1'>hvm</type>
    <kernel>/var/lib/libvirt/images/hades/vmlinux-s390x</kernel>
    <initrd>/var/lib/libvirt/images/hades/ramdisk-s390x</initrd>
  </os>
  <devices>
    <emulator>/usr/bin/qemu-system-s390x</emulator>
    <console type=3D'pty'>
      <target type=3D'sclp' port=3D'0'/>
    </console>
  </devices>
</domain>
$ virsh create dom.xml
Domain 'bug' created from dom.xml
$ virsh save bug data
error: Failed to save domain 'bug' to data
error: operation failed: domain is not running

$ coredumpctl gdb
(gdb) bt
#0  object_dynamic_cast_assert (obj=3D0x2aa364aedd0, typename=3Dtypename@en=
try=3D0x2aa3491bd56 "s390-flic", file=3Dfile@entry=3D0x2aa34920c7a "/root/g=
it/qemu/include/hw/s390x/s390_flic.h", line=3Dline@entry=3D42, func=3Dfunc@=
entry=3D0x2aa34a4b964 <__func__.14> "S390_FLIC_COMMON")
    at ../qom/object.c:923
#1  0x000002aa3459b518 in S390_FLIC_COMMON (obj=3D<optimized out>) at /root=
/git/qemu/include/hw/s390x/s390_flic.h:42
#2  adapter_info_so_needed (opaque=3D<optimized out>) at ../hw/intc/s390_fl=
ic.c:462
#3  0x000002aa348b24dc in vmstate_section_needed (vmsd=3D0x2aa34c80fe0 <vms=
tate_adapter_info_so>, opaque=3D<optimized out>) at ../migration/vmstate.c:=
330
#4  vmstate_subsection_save (f=3D0x2aa36602bd0, vmsd=3D0x2aa34c80f78 <vmsta=
te_adapter_info>, opaque=3D0x2aa364aedd0, vmdesc=3D0x0) at ../migration/vms=
tate.c:528
#5  vmstate_save_state_v (f=3Df@entry=3D0x2aa36602bd0, vmsd=3D0x2aa34c80f78=
 <vmstate_adapter_info>, opaque=3Dopaque@entry=3D0x2aa364aedd0, vmdesc=3Dvm=
desc@entry=3D0x0, version_id=3Dversion_id@entry=3D1, errp=3D0x0) at ../migr=
ation/vmstate.c:443
#6  0x000002aa348b2886 in vmstate_save_state (f=3D0x2aa36602bd0, vmsd=3D<op=
timized out>, opaque=3D0x2aa364aedd0, vmdesc_id=3D0x0) at ../migration/vmst=
ate.c:341
#7  vmstate_save_state_v (f=3Df@entry=3D0x2aa36602bd0, vmsd=3D0x2aa34c80e50=
 <vmstate_adapter_routes>, opaque=3Dopaque@entry=3D0x2aa364aedd0, vmdesc=3D=
vmdesc@entry=3D0x0, version_id=3Dversion_id@entry=3D1, errp=3D0x0) at ../mi=
gration/vmstate.c:401
#8  0x000002aa348b2886 in vmstate_save_state (f=3D0x2aa36602bd0, vmsd=3D<op=
timized out>, opaque=3D0x2aa364aedd0, vmdesc_id=3D0x0) at ../migration/vmst=
ate.c:341
#9  vmstate_save_state_v (f=3D0x2aa36602bd0, vmsd=3D0x2aa34c6cdf0 <vmstate_=
virtio_ccw_dev>, opaque=3D<optimized out>, vmdesc=3D0x0, version_id=3Dversi=
on_id@entry=3D1, errp=3D0x0) at ../migration/vmstate.c:401
#10 0x000002aa348b2d7e in vmstate_save_state (f=3D<optimized out>, vmsd=3D<=
optimized out>, opaque=3D<optimized out>, vmdesc_id=3D<optimized out>) at .=
./migration/vmstate.c:341
#11 0x000002aa345c9726 in virtio_save (vdev=3D0x2aa364afe20, f=3D0x2aa36602=
bd0) at ../hw/virtio/virtio.c:2808
#12 0x000002aa348b23de in vmstate_save_state_v (f=3Df@entry=3D0x2aa36602bd0=
, vmsd=3D0x2aa34c80cd0 <vmstate_virtio_console>, opaque=3D<optimized out>, =
vmdesc=3Dvmdesc@entry=3D0x2aa36602280, version_id=3Dversion_id@entry=3D3, e=
rrp=3D0x3ff73efb438) at ../migration/vmstate.c:408
#13 0x000002aa348b2dbe in vmstate_save_state_with_err (f=3Df@entry=3D0x2aa3=
6602bd0, vmsd=3D<optimized out>, opaque=3D<optimized out>, vmdesc_id=3Dvmde=
sc_id@entry=3D0x2aa36602280, errp=3Derrp@entry=3D0x3ff73efb438) at ../migra=
tion/vmstate.c:347
#14 0x000002aa344993ce in vmstate_save (f=3Df@entry=3D0x2aa36602bd0, se=3Ds=
e@entry=3D0x2aa365cac80, vmdesc=3Dvmdesc@entry=3D0x2aa36602280, errp=3D<opt=
imized out>, errp@entry=3D0x3ff73efb438) at ../migration/savevm.c:1037
#15 0x000002aa3449cb80 in qemu_savevm_state_complete_precopy_non_iterable (=
f=3Df@entry=3D0x2aa36602bd0, in_postcopy=3D<optimized out>, in_postcopy@ent=
ry=3Dfalse, inactivate_disks=3Dfalse, inactivate_disks@entry=3Dtrue) at ../=
migration/savevm.c:1554
#16 0x000002aa3449d15a in qemu_savevm_state_complete_precopy (f=3D0x2aa3660=
2bd0, iterable_only=3Diterable_only@entry=3Dfalse, inactivate_disks=3Dfalse=
) at ../migration/savevm.c:1630
#17 0x000002aa3448ca00 in migration_completion_precopy (s=3D0x2aa3625d1f0, =
current_active_state=3D0x3ff73efb67c) at ../migration/migration.c:2710
#18 migration_completion (s=3D0x2aa3625d1f0) at ../migration/migration.c:27=
74
#19 migration_iteration_run (s=3D0x2aa3625d1f0) at ../migration/migration.c=
:3198
#20 migration_thread (opaque=3Dopaque@entry=3D0x2aa3625d1f0) at ../migratio=
n/migration.c:3464
#21 0x000002aa3483bc12 in qemu_thread_start (args=3D<optimized out>) at ../=
util/qemu-thread-posix.c:541
#22 0x000003ff91bac3fa in start_thread () at /lib64/libc.so.6
#23 0x000003ff91c2bb18 in thread_start () at /lib64/libc.so.6

--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFCCC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 18:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHSu7-0003ZB-NY; Wed, 12 Jun 2024 14:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sHSu6-0003Z1-2G
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sHSu3-0005yi-P2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 14:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718217657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=JCVdpu79RdGGoZWMyu1Np3+tnx1dsHJYdlHd8PbSbhc=;
 b=EMJMChpaQe65PIDlf1a1d/yQx/542R5/R25J5sokczUKAIGQ7sbnZF8MweZ5ZzO7G57017
 WcD94SHKJVmHlGDz/GAxw2Ai2pM3GAIbyyZshDSG2pxkkbdIwnO1o0+DO1+LTbei5IupCi
 uyMO5RkaZ5OkNIAPOCwjl0GVOwqEwEQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-L7-5--UXPBKhs2p1srHqvg-1; Wed, 12 Jun 2024 14:40:55 -0400
X-MC-Unique: L7-5--UXPBKhs2p1srHqvg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c4b0f01581so83305a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 11:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718217653; x=1718822453;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JCVdpu79RdGGoZWMyu1Np3+tnx1dsHJYdlHd8PbSbhc=;
 b=ItfvF/BrNrdvQmgd2D57gxokxvNDz2M0j4Ye2sbL5NXLOn11jSZpyrV53Zt+SwgmQP
 HMEgBkukrHVznypZwp0wO8SZ5kQkC9aMdXCC7MpkqJ0OGMqhxXKZmW50CAR+tJ3E/1Mb
 7KzzoiANjqdtYKGu0MYtiY6dnt3Fi5yA6+S+5LGmin6ADvIy4Rk0Z8lWZ5HA19exdSpj
 igqA11S8PCqR80sYqg1XYKP/oS4WNHLx+JPvqzilFekmgElhqu9K9tyiIbuhXroIfDqg
 LqpYBR5g3GzQ+cD3gTttv8JpPFi3+yO2MhK4s4Mjc+9ZxDnDT/L0cwvWlMiY91hrCb6W
 tisg==
X-Gm-Message-State: AOJu0Yy9Rclm6gY7C30DTpGlUxeIHJKZk8qEDGHNmF6x7XzHShcJu6by
 I0XZj58z0PM358ncmlsgPoj44tY/T0E8x64aa34dSrMPqSGF8IvPc+q8lUQ4wDyXsS7/sf4Icu3
 NwiEud2FacPw8kCsZhqjdAl4sjFm+uUKP38kVjCxUsXzwY8dSr85uFMFssDmoPQwegLMAo5AMWo
 dSFLdZoIU7j7+VghySnPqRY8SY4d5y0HG9FAykPQ==
X-Received: by 2002:a17:90a:ae15:b0:2c3:38f2:d2f1 with SMTP id
 98e67ed59e1d1-2c4a761ab23mr2590468a91.2.1718217652745; 
 Wed, 12 Jun 2024 11:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVVMzuHHxQma98XxQpg8Gg/rhAxRXiDwBpWFDW7MQtUQdPnwAHSEHEUvM7adAl66AzI1rp5Ugq9f0PKD/dPNU=
X-Received: by 2002:a17:90a:ae15:b0:2c3:38f2:d2f1 with SMTP id
 98e67ed59e1d1-2c4a761ab23mr2590447a91.2.1718217652201; Wed, 12 Jun 2024
 11:40:52 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Wed, 12 Jun 2024 14:40:40 -0400
Message-ID: <CAFn=p-a4MOZGDd7nj_gEf0fT7nvwa40pLJ1GiGOTj3uNhSq1tg@mail.gmail.com>
Subject: Sample 'qapi-schema-diff' output for v9.0.0 vs origin/master
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ce8322061ab5b863"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000ce8322061ab5b863
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hiya, here's some draft output of a script I'm working on to summarize QMP
wire format differences between QEMU versions.

This script works in terms of the QMP *wire format*, not the QAPI
*specification*. As a consequence, *almost* all type names are stripped
from this output and all nested structures are fully inlined - so changes
to shared data structures, enums, etc will manifest as many independent
changes. Similarly, changes to type names and type factorings that do not
change the wire format will not appear in this report at all.

This is still a WIP: if conditionals and features may not be fully
represented in this summary report.

Here's today's diff output, see if you think this format is "intuitive" or
makes sense to some extent; or, if you're feeling bored, if you believe
it's fully accurate:

jsnow@scv ~/s/qemu (master)> qapi-schema-diff qapi-compiled-v9.0.0.json
qapi-compiled-v9.0.0-1388-g80e8f060216.json
###################################
v9.0.0 =3D=3D> v9.0.0-1388-g80e8f060216
###################################

********
commands
********

Removed
=3D=3D=3D=3D=3D=3D=3D
x-query-rdma

Modified
=3D=3D=3D=3D=3D=3D=3D=3D
blockdev-backup (arguments)
    ++ arguments.discard-source: Optional<boolean>
drive-backup (arguments)
    ++ arguments.discard-source: Optional<boolean>
migrate (arguments)
    -- arguments.blk: Optional<boolean>
    -- arguments.inc: Optional<boolean>
migrate-incoming (arguments)
    ++ arguments.exit-on-error: Optional<boolean>
migrate-set-capabilities (arguments)
    =C2=B7=C2=B7 arguments.capabilities[].capability: enum
    --     'block'
    --     'compress'
migrate-set-parameters (arguments)
    -- arguments.block-incremental: Optional<boolean>
    -- arguments.compress-level: Optional<integer>
    -- arguments.compress-threads: Optional<integer>
    -- arguments.compress-wait-thread: Optional<boolean>
    -- arguments.decompress-threads: Optional<integer>
object-add (arguments)
    =C2=B7=C2=B7 arguments.qom-type: enum
    ++     'sev-snp-guest'
    ++ arguments<qom-type=3Dsev-guest>.legacy-vm-type: Optional<boolean>
    ++ arguments<qom-type=3Dsev-snp-guest>.author-key-enabled:
Optional<boolean>
    ++ arguments<qom-type=3Dsev-snp-guest>.cbitpos: Optional<integer>
    ++ arguments<qom-type=3Dsev-snp-guest>.guest-visible-workarounds:
Optional<string>
    ++ arguments<qom-type=3Dsev-snp-guest>.host-data: Optional<string>
    ++ arguments<qom-type=3Dsev-snp-guest>.id-auth: Optional<string>
    ++ arguments<qom-type=3Dsev-snp-guest>.id-block: Optional<string>
    ++ arguments<qom-type=3Dsev-snp-guest>.kernel-hashes: Optional<boolean>
    ++ arguments<qom-type=3Dsev-snp-guest>.policy: Optional<integer>
    ++ arguments<qom-type=3Dsev-snp-guest>.reduced-phys-bits: integer
    ++ arguments<qom-type=3Dsev-snp-guest>.sev-device: Optional<string>
    ++ arguments<qom-type=3Dsev-snp-guest>.vcek-disabled: Optional<boolean>
query-cpu-model-baseline (returns, arguments)
    ++ arguments.modela.deprecated-props: Optional<array>
    ++ arguments.modela.deprecated-props[]: string
    ++ arguments.modelb.deprecated-props: Optional<array>
    ++ arguments.modelb.deprecated-props[]: string
    ++ returns.model.deprecated-props: Optional<array>
    ++ returns.model.deprecated-props[]: string
query-cpu-model-comparison (arguments)
    ++ arguments.modela.deprecated-props: Optional<array>
    ++ arguments.modela.deprecated-props[]: string
    ++ arguments.modelb.deprecated-props: Optional<array>
    ++ arguments.modelb.deprecated-props[]: string
query-cpu-model-expansion (returns, arguments)
    ++ arguments.model.deprecated-props: Optional<array>
    ++ arguments.model.deprecated-props[]: string
    ++ returns.model.deprecated-props: Optional<array>
    ++ returns.model.deprecated-props[]: string
query-cpus-fast (returns)
    ++ returns[].props.module-id: Optional<integer>
    =C2=B7=C2=B7 returns[].target: enum
    --     'nios2'
query-hotpluggable-cpus (returns)
    ++ returns[].props.module-id: Optional<integer>
query-machines (returns, arguments)
    ++ arguments.compat-props: Optional<boolean>
    ++ returns[].compat-props: Optional<array>
    ++ returns[].compat-props[]: object
    ++ returns[].compat-props[].property: string
    ++ returns[].compat-props[].qom-type: string
    ++ returns[].compat-props[].value: string
query-migrate (returns)
    -- returns.compression: Optional<object>
    -- returns.compression.busy: integer
    -- returns.compression.busy-rate: number
    -- returns.compression.compressed-size: integer
    -- returns.compression.compression-rate: number
    -- returns.compression.pages: integer
    -- returns.disk: Optional<object>
    -- returns.disk.dirty-pages-rate: integer
    -- returns.disk.dirty-sync-count: integer
    -- returns.disk.dirty-sync-missed-zero-copy: integer
    -- returns.disk.downtime-bytes: integer
    -- returns.disk.duplicate: integer
    -- returns.disk.mbps: number
    -- returns.disk.multifd-bytes: integer
    -- returns.disk.normal: integer
    -- returns.disk.normal-bytes: integer
    -- returns.disk.page-size: integer
    -- returns.disk.pages-per-second: integer
    -- returns.disk.postcopy-bytes: integer
    -- returns.disk.postcopy-requests: integer
    -- returns.disk.precopy-bytes: integer
    -- returns.disk.remaining: integer
    -- returns.disk.skipped: integer
    -- returns.disk.total: integer
    -- returns.disk.transferred: integer
    -- returns.ram.skipped: integer
query-migrate-capabilities (returns)
    =C2=B7=C2=B7 returns[].capability: enum
    --     'block'
    --     'compress'
query-migrate-parameters (returns)
    -- returns.block-incremental: Optional<boolean>
    -- returns.compress-level: Optional<integer>
    -- returns.compress-threads: Optional<integer>
    -- returns.compress-wait-thread: Optional<boolean>
    -- returns.decompress-threads: Optional<integer>
query-sev (returns)
    -- returns.handle: integer
    -- returns.policy: integer
    ++ returns.sev-type: enum
    ++ returns<sev-type=3Dsev-snp>.snp-policy: integer
    ++ returns<sev-type=3Dsev>.handle: integer
    ++ returns<sev-type=3Dsev>.policy: integer
query-target (returns)
    =C2=B7=C2=B7 returns.arch: enum
    --     'nios2'
set-numa-node (arguments)
    ++ arguments<type=3Dcpu>.module-id: Optional<integer>
trace-event-get-state (returns, arguments)
    -- arguments.vcpu: Optional<integer>
    -- returns[].vcpu: boolean
trace-event-set-state (arguments)
    -- arguments.vcpu: Optional<integer>
transaction (arguments)
    ++ arguments.actions[]<type=3Dblockdev-backup>.data.discard-source:
Optional<boolean>
    ++ arguments.actions[]<type=3Ddrive-backup>.data.discard-source:
Optional<boolean>

******
events
******

Added
=3D=3D=3D=3D=3D
VFIO_MIGRATION

Removed
=3D=3D=3D=3D=3D=3D=3D
MEM_UNPLUG_ERROR
RDMA_GID_STATUS_CHANGED

--000000000000ce8322061ab5b863
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hiya, here&#39;s some draft output of a script I&#39;=
m working on to summarize QMP wire format differences between QEMU versions=
.=C2=A0</div><div><br></div><div>This script works in terms of the QMP *wir=
e format*, not the QAPI *specification*. As a consequence, *almost* all typ=
e names are stripped from this output and all nested structures are fully i=
nlined - so changes to shared data structures, enums, etc will manifest as =
many independent changes. Similarly, changes to type names and type factori=
ngs that do not change the wire format will not appear in this report at al=
l.</div><div><br></div><div>This is still a WIP: if conditionals and featur=
es may not be fully represented in this summary report.<br></div><div><br><=
/div><div>Here&#39;s today&#39;s diff output, see if you think this format =
is &quot;intuitive&quot; or makes sense to some extent; or, if you&#39;re f=
eeling bored, if you believe it&#39;s fully accurate:<br></div><div><br></d=
iv><div>jsnow@scv ~/s/qemu (master)&gt; qapi-schema-diff qapi-compiled-v9.0=
.0.json qapi-compiled-v9.0.0-1388-g80e8f060216.json<br>####################=
###############<br>v9.0.0 =3D=3D&gt; v9.0.0-1388-g80e8f060216<br>##########=
#########################<br><br>********<br>commands<br>********<br><br>Re=
moved<br>=3D=3D=3D=3D=3D=3D=3D<br>x-query-rdma<br><br>Modified<br>=3D=3D=3D=
=3D=3D=3D=3D=3D<br>blockdev-backup (arguments)<br>=C2=A0 =C2=A0 ++ argument=
s.discard-source: Optional&lt;boolean&gt;<br>drive-backup (arguments)<br>=
=C2=A0 =C2=A0 ++ arguments.discard-source: Optional&lt;boolean&gt;<br>migra=
te (arguments)<br>=C2=A0 =C2=A0 -- arguments.blk: Optional&lt;boolean&gt;<b=
r>=C2=A0 =C2=A0 -- arguments.inc: Optional&lt;boolean&gt;<br>migrate-incomi=
ng (arguments)<br>=C2=A0 =C2=A0 ++ arguments.exit-on-error: Optional&lt;boo=
lean&gt;<br>migrate-set-capabilities (arguments)<br>=C2=A0 =C2=A0 =C2=B7=C2=
=B7 arguments.capabilities[].capability: enum<br>=C2=A0 =C2=A0 -- =C2=A0 =
=C2=A0 &#39;block&#39;<br>=C2=A0 =C2=A0 -- =C2=A0 =C2=A0 &#39;compress&#39;=
<br>migrate-set-parameters (arguments)<br>=C2=A0 =C2=A0 -- arguments.block-=
incremental: Optional&lt;boolean&gt;<br>=C2=A0 =C2=A0 -- arguments.compress=
-level: Optional&lt;integer&gt;<br>=C2=A0 =C2=A0 -- arguments.compress-thre=
ads: Optional&lt;integer&gt;<br>=C2=A0 =C2=A0 -- arguments.compress-wait-th=
read: Optional&lt;boolean&gt;<br>=C2=A0 =C2=A0 -- arguments.decompress-thre=
ads: Optional&lt;integer&gt;<br>object-add (arguments)<br>=C2=A0 =C2=A0 =C2=
=B7=C2=B7 arguments.qom-type: enum<br>=C2=A0 =C2=A0 ++ =C2=A0 =C2=A0 &#39;s=
ev-snp-guest&#39;<br>=C2=A0 =C2=A0 ++ arguments&lt;qom-type=3Dsev-guest&gt;=
.legacy-vm-type: Optional&lt;boolean&gt;<br>=C2=A0 =C2=A0 ++ arguments&lt;q=
om-type=3Dsev-snp-guest&gt;.author-key-enabled: Optional&lt;boolean&gt;<br>=
=C2=A0 =C2=A0 ++ arguments&lt;qom-type=3Dsev-snp-guest&gt;.cbitpos: Optiona=
l&lt;integer&gt;<br>=C2=A0 =C2=A0 ++ arguments&lt;qom-type=3Dsev-snp-guest&=
gt;.guest-visible-workarounds: Optional&lt;string&gt;<br>=C2=A0 =C2=A0 ++ a=
rguments&lt;qom-type=3Dsev-snp-guest&gt;.host-data: Optional&lt;string&gt;<=
br>=C2=A0 =C2=A0 ++ arguments&lt;qom-type=3Dsev-snp-guest&gt;.id-auth: Opti=
onal&lt;string&gt;<br>=C2=A0 =C2=A0 ++ arguments&lt;qom-type=3Dsev-snp-gues=
t&gt;.id-block: Optional&lt;string&gt;<br>=C2=A0 =C2=A0 ++ arguments&lt;qom=
-type=3Dsev-snp-guest&gt;.kernel-hashes: Optional&lt;boolean&gt;<br>=C2=A0 =
=C2=A0 ++ arguments&lt;qom-type=3Dsev-snp-guest&gt;.policy: Optional&lt;int=
eger&gt;<br>=C2=A0 =C2=A0 ++ arguments&lt;qom-type=3Dsev-snp-guest&gt;.redu=
ced-phys-bits: integer<br>=C2=A0 =C2=A0 ++ arguments&lt;qom-type=3Dsev-snp-=
guest&gt;.sev-device: Optional&lt;string&gt;<br>=C2=A0 =C2=A0 ++ arguments&=
lt;qom-type=3Dsev-snp-guest&gt;.vcek-disabled: Optional&lt;boolean&gt;<br>q=
uery-cpu-model-baseline (returns, arguments)<br>=C2=A0 =C2=A0 ++ arguments.=
modela.deprecated-props: Optional&lt;array&gt;<br>=C2=A0 =C2=A0 ++ argument=
s.modela.deprecated-props[]: string<br>=C2=A0 =C2=A0 ++ arguments.modelb.de=
precated-props: Optional&lt;array&gt;<br>=C2=A0 =C2=A0 ++ arguments.modelb.=
deprecated-props[]: string<br>=C2=A0 =C2=A0 ++ returns.model.deprecated-pro=
ps: Optional&lt;array&gt;<br>=C2=A0 =C2=A0 ++ returns.model.deprecated-prop=
s[]: string<br>query-cpu-model-comparison (arguments)<br>=C2=A0 =C2=A0 ++ a=
rguments.modela.deprecated-props: Optional&lt;array&gt;<br>=C2=A0 =C2=A0 ++=
 arguments.modela.deprecated-props[]: string<br>=C2=A0 =C2=A0 ++ arguments.=
modelb.deprecated-props: Optional&lt;array&gt;<br>=C2=A0 =C2=A0 ++ argument=
s.modelb.deprecated-props[]: string<br>query-cpu-model-expansion (returns, =
arguments)<br>=C2=A0 =C2=A0 ++ arguments.model.deprecated-props: Optional&l=
t;array&gt;<br>=C2=A0 =C2=A0 ++ arguments.model.deprecated-props[]: string<=
br>=C2=A0 =C2=A0 ++ returns.model.deprecated-props: Optional&lt;array&gt;<b=
r>=C2=A0 =C2=A0 ++ returns.model.deprecated-props[]: string<br>query-cpus-f=
ast (returns)<br>=C2=A0 =C2=A0 ++ returns[].props.module-id: Optional&lt;in=
teger&gt;<br>=C2=A0 =C2=A0 =C2=B7=C2=B7 returns[].target: enum<br>=C2=A0 =
=C2=A0 -- =C2=A0 =C2=A0 &#39;nios2&#39;<br>query-hotpluggable-cpus (returns=
)<br>=C2=A0 =C2=A0 ++ returns[].props.module-id: Optional&lt;integer&gt;<br=
>query-machines (returns, arguments)<br>=C2=A0 =C2=A0 ++ arguments.compat-p=
rops: Optional&lt;boolean&gt;<br>=C2=A0 =C2=A0 ++ returns[].compat-props: O=
ptional&lt;array&gt;<br>=C2=A0 =C2=A0 ++ returns[].compat-props[]: object<b=
r>=C2=A0 =C2=A0 ++ returns[].compat-props[].property: string<br>=C2=A0 =C2=
=A0 ++ returns[].compat-props[].qom-type: string<br>=C2=A0 =C2=A0 ++ return=
s[].compat-props[].value: string<br>query-migrate (returns)<br>=C2=A0 =C2=
=A0 -- returns.compression: Optional&lt;object&gt;<br>=C2=A0 =C2=A0 -- retu=
rns.compression.busy: integer<br>=C2=A0 =C2=A0 -- returns.compression.busy-=
rate: number<br>=C2=A0 =C2=A0 -- returns.compression.compressed-size: integ=
er<br>=C2=A0 =C2=A0 -- returns.compression.compression-rate: number<br>=C2=
=A0 =C2=A0 -- returns.compression.pages: integer<br>=C2=A0 =C2=A0 -- return=
s.disk: Optional&lt;object&gt;<br>=C2=A0 =C2=A0 -- returns.disk.dirty-pages=
-rate: integer<br>=C2=A0 =C2=A0 -- returns.disk.dirty-sync-count: integer<b=
r>=C2=A0 =C2=A0 -- returns.disk.dirty-sync-missed-zero-copy: integer<br>=C2=
=A0 =C2=A0 -- returns.disk.downtime-bytes: integer<br>=C2=A0 =C2=A0 -- retu=
rns.disk.duplicate: integer<br>=C2=A0 =C2=A0 -- returns.disk.mbps: number<b=
r>=C2=A0 =C2=A0 -- returns.disk.multifd-bytes: integer<br>=C2=A0 =C2=A0 -- =
returns.disk.normal: integer<br>=C2=A0 =C2=A0 -- returns.disk.normal-bytes:=
 integer<br>=C2=A0 =C2=A0 -- returns.disk.page-size: integer<br>=C2=A0 =C2=
=A0 -- returns.disk.pages-per-second: integer<br>=C2=A0 =C2=A0 -- returns.d=
isk.postcopy-bytes: integer<br>=C2=A0 =C2=A0 -- returns.disk.postcopy-reque=
sts: integer<br>=C2=A0 =C2=A0 -- returns.disk.precopy-bytes: integer<br>=C2=
=A0 =C2=A0 -- returns.disk.remaining: integer<br>=C2=A0 =C2=A0 -- returns.d=
isk.skipped: integer<br>=C2=A0 =C2=A0 -- returns.disk.total: integer<br>=C2=
=A0 =C2=A0 -- returns.disk.transferred: integer<br>=C2=A0 =C2=A0 -- returns=
.ram.skipped: integer<br>query-migrate-capabilities (returns)<br>=C2=A0 =C2=
=A0 =C2=B7=C2=B7 returns[].capability: enum<br>=C2=A0 =C2=A0 -- =C2=A0 =C2=
=A0 &#39;block&#39;<br>=C2=A0 =C2=A0 -- =C2=A0 =C2=A0 &#39;compress&#39;<br=
>query-migrate-parameters (returns)<br>=C2=A0 =C2=A0 -- returns.block-incre=
mental: Optional&lt;boolean&gt;<br>=C2=A0 =C2=A0 -- returns.compress-level:=
 Optional&lt;integer&gt;<br>=C2=A0 =C2=A0 -- returns.compress-threads: Opti=
onal&lt;integer&gt;<br>=C2=A0 =C2=A0 -- returns.compress-wait-thread: Optio=
nal&lt;boolean&gt;<br>=C2=A0 =C2=A0 -- returns.decompress-threads: Optional=
&lt;integer&gt;<br>query-sev (returns)<br>=C2=A0 =C2=A0 -- returns.handle: =
integer<br>=C2=A0 =C2=A0 -- returns.policy: integer<br>=C2=A0 =C2=A0 ++ ret=
urns.sev-type: enum<br>=C2=A0 =C2=A0 ++ returns&lt;sev-type=3Dsev-snp&gt;.s=
np-policy: integer<br>=C2=A0 =C2=A0 ++ returns&lt;sev-type=3Dsev&gt;.handle=
: integer<br>=C2=A0 =C2=A0 ++ returns&lt;sev-type=3Dsev&gt;.policy: integer=
<br>query-target (returns)<br>=C2=A0 =C2=A0 =C2=B7=C2=B7 returns.arch: enum=
<br>=C2=A0 =C2=A0 -- =C2=A0 =C2=A0 &#39;nios2&#39;<br>set-numa-node (argume=
nts)<br>=C2=A0 =C2=A0 ++ arguments&lt;type=3Dcpu&gt;.module-id: Optional&lt=
;integer&gt;<br>trace-event-get-state (returns, arguments)<br>=C2=A0 =C2=A0=
 -- arguments.vcpu: Optional&lt;integer&gt;<br>=C2=A0 =C2=A0 -- returns[].v=
cpu: boolean<br>trace-event-set-state (arguments)<br>=C2=A0 =C2=A0 -- argum=
ents.vcpu: Optional&lt;integer&gt;<br>transaction (arguments)<br>=C2=A0 =C2=
=A0 ++ arguments.actions[]&lt;type=3Dblockdev-backup&gt;.data.discard-sourc=
e: Optional&lt;boolean&gt;<br>=C2=A0 =C2=A0 ++ arguments.actions[]&lt;type=
=3Ddrive-backup&gt;.data.discard-source: Optional&lt;boolean&gt;<br><br>***=
***<br>events<br>******<br><br>Added<br>=3D=3D=3D=3D=3D<br>VFIO_MIGRATION<b=
r><br>Removed<br>=3D=3D=3D=3D=3D=3D=3D<br>MEM_UNPLUG_ERROR<br>RDMA_GID_STAT=
US_CHANGED<br><br><br></div></div>

--000000000000ce8322061ab5b863--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC61CCFA478
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLmc-00019X-1d; Fri, 21 Nov 2025 02:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMLma-00019C-Qs
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vMLmY-0005oi-HK
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763710933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3NW1ZCKUlQkbLbmb949CH/guBc8UA9jC87DIPZ5FVBI=;
 b=MBmPdgxVOW9SxkzMmeGUvvRfd7Da+s9jjYP31yv0yJKcA6tLX/DRQB3zeCc2mQY8aFjWRl
 N9y+7Wj+92aC9sqcvJ/cGkCXZ8k1D400Eb6tL6Ur3VkgUxJ2uFQb00OwQUaaj/qo14aqh3
 dguJ2iLLLn5yu5TbAkyH7op53VNVPzg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-6Nx3hajiNLuNNYgJfdWNMg-1; Fri,
 21 Nov 2025 02:42:07 -0500
X-MC-Unique: 6Nx3hajiNLuNNYgJfdWNMg-1
X-Mimecast-MFC-AGG-ID: 6Nx3hajiNLuNNYgJfdWNMg_1763710926
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF153180034A; Fri, 21 Nov 2025 07:42:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3287C1800877; Fri, 21 Nov 2025 07:42:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF17821E6A27; Fri, 21 Nov 2025 08:42:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: elena.ufimtseva@oracle.com,  jag.raman@oracle.com
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH 12/14] error: Use error_setg_errno() for simplicity and
 consistency
In-Reply-To: <87jyzkq6mx.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 21 Nov 2025 06:47:18 +0100")
References: <20251120191339.756429-1-armbru@redhat.com>
 <20251120191339.756429-13-armbru@redhat.com>
 <aR-vExiomEe9jUNN@gallifrey> <87jyzkq6mx.fsf@pond.sub.org>
Date: Fri, 21 Nov 2025 08:42:02 +0100
Message-ID: <873467q1bp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cc: trimmed

Markus Armbruster <armbru@redhat.com> writes:

> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
>
>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> Use error_setg_errno() instead of passing the value of strerror() or
>>> g_strerror() to error_setg().
>>>=20
>>> The separator between the error message proper and the value of
>>> strerror() changes from " : ", "", " - ", "- " to ": " in places.
>>>=20
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>>> @@ -792,9 +792,9 @@ static void vfu_object_init_ctx(VfuObject *o, Error=
 **errp)
>>>                             VFU_REGION_FLAG_RW | VFU_REGION_FLAG_ALWAYS=
_CB,
>>>                             NULL, 0, -1, 0);
>>>      if (ret < 0) {
>>> -        error_setg(errp,
>>> -                   "vfu: Failed to setup config space handlers for %s-=
 %s",
>>> -                   o->device, strerror(errno));
>>> +        error_setg_errno(errp,
>>> +                         "vfu: Failed to setup config space handlers f=
or %s",
>>> +                         o->device);
>>
>> missing errno.
>
> Yes.
>
>>>          goto fail;
>>>      }
>>>=20=20
>>> @@ -822,8 +822,8 @@ static void vfu_object_init_ctx(VfuObject *o, Error=
 **errp)
>>>=20=20
>>>      ret =3D vfu_realize_ctx(o->vfu_ctx);
>>>      if (ret < 0) {
>>> -        error_setg(errp, "vfu: Failed to realize device %s- %s",
>>> -                   o->device, strerror(errno));
>>> +        error_setg_errno(errp, "vfu: Failed to realize device %s",
>>> +                         o->device);
>>
>> missing errno.
>
> Yes.  Another file my build tree doesn't compile anymore.  Will fix,
> thanks!
>
> [...]

To include it in the build, I need to pass --enable-vfio-user-server to
configure, then install the libaries configure asked for.

Build then fails for me:

    FAILED: subprojects/libvfio-user/test/unit_tests.p/unit-tests.c.o=20
    cc -m64 -Isubprojects/libvfio-user/test/unit_tests.p -Isubprojects/libv=
fio-user/test -I../subprojects/libvfio-user/test -Isubprojects/libvfio-user=
/include -I../subprojects/libvfio-user/include -Isubprojects/libvfio-user/l=
ib -I../subprojects/libvfio-user/lib -I/usr/include/json-c -fdiagnostics-co=
lor=3Dauto -Wall -Winvalid-pch -Wextra -Werror -std=3Dgnu99 -O2 -g -DSTAP_S=
DT_V2 -mcx16 -msse2 -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-stric=
t-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero -fzero-call-u=
sed-regs=3Dused-gpr -fPIE -DUNIT_TEST -DWITH_TRAN_PIPE -D_GNU_SOURCE -Werro=
r -DDEBUG -Wno-missing-field-initializers -Wmissing-declarations -Wwrite-st=
rings -MD -MQ subprojects/libvfio-user/test/unit_tests.p/unit-tests.c.o -MF=
 subprojects/libvfio-user/test/unit_tests.p/unit-tests.c.o.d -o subprojects=
/libvfio-user/test/unit_tests.p/unit-tests.c.o -c ../subprojects/libvfio-us=
er/test/unit-tests.c
    ../subprojects/libvfio-user/test/unit-tests.c: In function =E2=80=98tes=
t_device_is_stopped_and_copying=E2=80=99:
    ../subprojects/libvfio-user/test/unit-tests.c:585:23: error: storing th=
e address of local variable =E2=80=98migration=E2=80=99 in =E2=80=98vfu_ctx=
.migration=E2=80=99 [-Werror=3Ddangling-pointer=3D]
      585 |     vfu_ctx.migration =3D &migration;
          |     ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
    ../subprojects/libvfio-user/test/unit-tests.c:584:22: note: =E2=80=98mi=
gration=E2=80=99 declared here
      584 |     struct migration migration;
          |                      ^~~~~~~~~
    ../subprojects/libvfio-user/test/unit-tests.c:62:18: note: =E2=80=98vfu=
_ctx=E2=80=99 declared here
       62 | static vfu_ctx_t vfu_ctx;
          |                  ^~~~~~~
    cc1: all warnings being treated as errors

and

    FAILED: subprojects/libvfio-user/lib/libvfio-user.so.0.0.1.p/libvfio-us=
er.c.o=20
    cc -m64 -Isubprojects/libvfio-user/lib/libvfio-user.so.0.0.1.p -Isubpro=
jects/libvfio-user/lib -I../subprojects/libvfio-user/lib -Isubprojects/libv=
fio-user/include -I../subprojects/libvfio-user/include -I/usr/include/json-=
c -fvisibility=3Dhidden -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Wex=
tra -Werror -std=3Dgnu99 -O2 -g -DSTAP_SDT_V2 -mcx16 -msse2 -D_FILE_OFFSET_=
BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftr=
ivial-auto-var-init=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIC -D_GNU_SO=
URCE -Werror -DDEBUG -Wno-missing-field-initializers -Wmissing-declarations=
 -Wwrite-strings -MD -MQ subprojects/libvfio-user/lib/libvfio-user.so.0.0.1=
.p/libvfio-user.c.o -MF subprojects/libvfio-user/lib/libvfio-user.so.0.0.1.=
p/libvfio-user.c.o.d -o subprojects/libvfio-user/lib/libvfio-user.so.0.0.1.=
p/libvfio-user.c.o -c ../subprojects/libvfio-user/lib/libvfio-user.c
    ../subprojects/libvfio-user/lib/libvfio-user.c: In function =E2=80=98ha=
ndle_device_get_region_io_fds=E2=80=99:
    ../subprojects/libvfio-user/lib/libvfio-user.c:617:38: error: =E2=80=98=
calloc=E2=80=99 sizes specified with =E2=80=98sizeof=E2=80=99 in the earlie=
r argument and not in the later argument [-Werror=3Dcalloc-transposed-args]
      617 |         msg->out.fds =3D calloc(sizeof(int), max_sent_sub_regio=
ns);
          |                                      ^~~
    ../subprojects/libvfio-user/lib/libvfio-user.c:617:38: note: earlier ar=
gument should specify number of elements, later size of each element
    cc1: all warnings being treated as errors



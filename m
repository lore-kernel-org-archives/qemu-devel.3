Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3B2CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 11:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v26kx-0005Wt-K4; Fri, 26 Sep 2025 07:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v26ku-0005Wf-3J
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v26kh-0006wl-OM
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 07:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758886593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9jZk+nz4EgtKkVqtxDo+JZDlbv8EBi/IQkR2TE1cTk=;
 b=GMxE9ae7DoAqGyMZHLK8ROTPyG9uqHyrWB8Wq8FPw3mn3wQ8BjB9XmIoMiKJiHtoPZzXjY
 +qGmg85IBR/H+Zj5y5ALW0VGov1ekiitmQ4KMXnqCA5Q4/VpTqN6thVm1EL5dMSgY6bxSC
 aMJAChBFrvK+NKlRnVGUM+WWsAuejGU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-8gcejOHwP-ebL9EObryFOQ-1; Fri,
 26 Sep 2025 07:36:29 -0400
X-MC-Unique: 8gcejOHwP-ebL9EObryFOQ-1
X-Mimecast-MFC-AGG-ID: 8gcejOHwP-ebL9EObryFOQ_1758886588
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 527D31800578; Fri, 26 Sep 2025 11:36:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B55521800579; Fri, 26 Sep 2025 11:36:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 273CA21E6A27; Fri, 26 Sep 2025 13:36:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: imammedo@redhat.com,  philmd@linaro.org,  berrange@redhat.com,
 jdenemar@redhat.com,  pbonzini@redhat.com,  richard.henderson@linaro.org,
 eduardo@habkost.net,  mst@redhat.com,  marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] hw/i386/isapc.c: remove support for -cpu host
 and -cpu max
In-Reply-To: <20250925160453.2025885-2-mark.caveayland@nutanix.com> (Mark
 Cave-Ayland's message of "Thu, 25 Sep 2025 17:03:19 +0100")
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-2-mark.caveayland@nutanix.com>
Date: Fri, 26 Sep 2025 13:36:25 +0200
Message-ID: <87wm5lo37q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> Following recent discussions on the mailing list, it has been decided
> that instead of mapping -cpu host and -cpu max to a suitable 32-bit x86 C=
PU,
> it is preferable to disallow them and use the existing valid_cpu_types
> validation logic so that an error is returned to the user instead.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/i386/isapc.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)
>
> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> index 44f4a44672..6c35a397df 100644
> --- a/hw/i386/isapc.c
> +++ b/hw/i386/isapc.c
> @@ -41,31 +41,6 @@ static void pc_init_isa(MachineState *machine)
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      int i;
>=20=20
> -    /*
> -     * There is a small chance that someone unintentionally passes "-cpu=
 max"
> -     * for the isapc machine, which will provide a much more modern 32-b=
it
> -     * CPU than would be expected for an ISA-era PC. If the "max" cpu ty=
pe has
> -     * been specified, choose the "best" 32-bit cpu possible which we co=
nsider
> -     * be the pentium3 (deliberately choosing an Intel CPU given that the
> -     * default 486 CPU for the isapc machine is also an Intel CPU).
> -     */
> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
> -        machine->cpu_type =3D X86_CPU_TYPE_NAME("pentium3");
> -        warn_report("-cpu max is invalid for isapc machine, using pentiu=
m3");
> -    }
> -
> -    /*
> -     * Similarly if someone unintentionally passes "-cpu host" for the i=
sapc
> -     * machine then display a warning and also switch to the "best" 32-b=
it
> -     * cpu possible which we consider to be the pentium3. This is becaus=
e any
> -     * host CPU will already be modern than this, but it also ensures any
> -     * newer CPU flags/features are filtered out for older guests.
> -     */
> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
> -        machine->cpu_type =3D X86_CPU_TYPE_NAME("pentium3");
> -        warn_report("-cpu host is invalid for isapc machine, using penti=
um3");
> -    }
> -
>      if (machine->ram_size > 3.5 * GiB) {
>          error_report("Too much memory for this machine: %" PRId64 " MiB,=
 "
>                       "maximum 3584 MiB", machine->ram_size / MiB);
> @@ -162,8 +137,6 @@ static void isapc_machine_options(MachineClass *m)
>          X86_CPU_TYPE_NAME("pentium2"),
>          X86_CPU_TYPE_NAME("pentium3"),
>          X86_CPU_TYPE_NAME("qemu32"),
> -        X86_CPU_TYPE_NAME("max"),
> -        X86_CPU_TYPE_NAME("host"),
>          NULL
>      };
>      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);

This reverts the "smart" part of recent

commit e1e2909f8e74051a34a044940f90d4650b6e784a
Author: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Date:   Thu Aug 28 12:09:44 2025 +0100

    hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
=20=20=20=20
    The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it =
is
    possible to specify any CPU via -cpu on the command line, it makes no
    sense to allow modern 64-bit CPUs to be used.
=20=20=20=20
    Restrict the isapc machine to the available 32-bit CPUs, taking care to
    handle the case where if a user inadvertently uses either -cpu max or
    -cpu host then the "best" 32-bit CPU is used (in this case the pentium3=
).
=20=20=20=20
    Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
    Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
    Link: https://lore.kernel.org/r/20250828111057.468712-2-mark.caveayland=
@nutanix.com
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

and keeps the dumb part.  Matches the commit message.

Reviewed-by: Markus Armbruster <armbru@redhat.com>



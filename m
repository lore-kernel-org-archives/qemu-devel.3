Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58553C54E55
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZyL-0006J7-8i; Thu, 29 Feb 2024 01:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfZy2-0006GP-Et
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:32:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfZxm-0002Hj-RQ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709188332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/jNDOfAqaSPp1d1AwFGj9q6q/4uUpccuEXmFzFAloFo=;
 b=Z4SY4X8Dt/Ga/5wAOdOXFuBQvbgl86tJuO921B582+u0E//txBs6uijQWAnzaiX1Ux0aHC
 P+xMvENuvKSxNooYti0mqLomPGESZCdKiiDQ64FtqWnkbJUbFYiwVC82L2ErGks1hnPhl9
 xQNqTFnvN9oJNTVxK5oQVOsCGeVXpoI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-LElognIWN3Sa7vQ3Txqq-w-1; Thu, 29 Feb 2024 01:32:09 -0500
X-MC-Unique: LElognIWN3Sa7vQ3Txqq-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D17A85A589;
 Thu, 29 Feb 2024 06:32:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 310612166B5E;
 Thu, 29 Feb 2024 06:32:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D4C8F21E6740; Thu, 29 Feb 2024 07:32:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Alex Williamson <alex.williamson@redhat.com>,  Avihai
 Horon <avihaih@nvidia.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Halil Pasic <pasic@linux.ibm.com>,  Thomas Huth
 <thuth@redhat.com>,  Eric Blake <eblake@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  John Snow
 <jsnow@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 06/21] migration: Add Error** argument to
 .save_setup() handler
In-Reply-To: <20240227180345.548960-7-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Tue, 27 Feb 2024 19:03:30 +0100")
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-7-clg@redhat.com>
Date: Thu, 29 Feb 2024 07:32:06 +0100
Message-ID: <87zfvj3hnd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> The purpose is to record a potential error in the migration stream if
> qemu_savevm_state_setup() fails. Most of the current .save_setup()
> handlers can be modified to use the Error argument instead of managing
> their own and calling locally error_report(). The following patches
> will introduce such changes for VFIO first.
>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---

[...]

> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c483b62a9b5f71772639fc180bdad15ecb6711cb..c934df424a555d83d2198f5dd=
fc0cbe0ea98e9ec 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -166,7 +166,7 @@ static int cmma_load(QEMUFile *f, void *opaque, int v=
ersion_id)
>      return ret;
>  }
>=20=20
> -static int cmma_save_setup(QEMUFile *f, void *opaque)
> +static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>  {
>      S390StAttribState *sas =3D S390_STATTRIB(opaque);
>      S390StAttribClass *sac =3D S390_STATTRIB_GET_CLASS(sas);
       int res;
       /*
        * Signal that we want to start a migration, thus needing PGSTE dirty
        * tracking.
        */
       res =3D sac->set_migrationmode(sas, 1);
       if (res) {
           return res;

I believe this is a failure return.

Anti-pattern: fail without setting an error.  There might be more
elsewhere in the series.

qapi/error.h's big comment:

 * - On success, the function should not touch *errp.  On failure, it
 *   should set a new error, e.g. with error_setg(errp, ...), or
 *   propagate an existing one, e.g. with error_propagate(errp, ...).
 *
 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   =E2=80=A2 bool-valued functions return true on success / false on fail=
ure,
 *   =E2=80=A2 pointer-valued functions return non-null / null pointer, and
 *   =E2=80=A2 integer-valued functions return non-negative / negative.

       }
       qemu_put_be64(f, STATTR_FLAG_EOS);
       return 0;
   }

When adding Error **errp to a function, you must also add code to set an
error on failure to every failure path.  Adding it in a later patch in
the same series can be okay, but I'd add a TODO comment to the function
then, and mention it in the commit message.

Questions?

[...]



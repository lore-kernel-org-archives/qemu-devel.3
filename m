Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78385C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqtw-00068a-08; Wed, 20 Mar 2024 04:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqtu-00068M-6L
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqts-0005ic-MK
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710921735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+okGbjcymjtdQ9/erBxn6ofXKVMiwKrM5wnQ0vLXFM=;
 b=VvjQjsb2KITG1F0K232iwrLBHtZRTu9qTyokhVIfAXLuyoKiRyDBh4DGSnVFSu/YI0iDsA
 Rtdy2VMkL+KJo/WH98I5yi5edr8vP716W1X+nEMk8xuPT0DpLvuxSgf7FXE0cSdnOaaezH
 4+SU/SRabMGjtx3Xg3jFWmkd64ZYT1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611--yQR0elgMtKVcciQK210AA-1; Wed, 20 Mar 2024 04:02:12 -0400
X-MC-Unique: -yQR0elgMtKVcciQK210AA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7609D101A586;
 Wed, 20 Mar 2024 08:02:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55CDB492BD1;
 Wed, 20 Mar 2024 08:02:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 50DE721E6A28; Wed, 20 Mar 2024 09:02:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex.williamson@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Avihai
 Horon <avihaih@nvidia.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,  Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH for-9.1 v5 08/14] migration: Add Error** argument to
 .load_setup() handler
In-Reply-To: <20240320064911.545001-9-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Wed, 20 Mar 2024 07:49:04 +0100")
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-9-clg@redhat.com>
Date: Wed, 20 Mar 2024 09:02:07 +0100
Message-ID: <87il1htjpc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> This will be useful to report errors at a higher level, mostly in VFIO
> today.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---

[...]

> diff --git a/migration/savevm.c b/migration/savevm.c
> index 535ad5a32d67057dd172ce25d561a66a07172e97..8f42999a15d1685957de9ed51=
7d6bc9ba49c3f11 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2747,8 +2747,9 @@ static void qemu_loadvm_state_switchover_ack_needed=
(MigrationIncomingState *mis)
>      trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending=
_num);
>  }
>=20=20
> -static int qemu_loadvm_state_setup(QEMUFile *f)
> +static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>  {
> +    ERRP_GUARD(); /* error_prepend use */

The comment is correct, but prone to go stale.  No other use of
ERRP_GUARD() is commented.  Suggest to drop it.

>      SaveStateEntry *se;
>      int ret;
>=20=20
> @@ -2763,10 +2764,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
>              }
>          }
>=20=20
> -        ret =3D se->ops->load_setup(f, se->opaque);
> +        ret =3D se->ops->load_setup(f, se->opaque, errp);
>          if (ret < 0) {
> +            error_prepend(errp, "Load state of device %s failed: ",
> +                          se->idstr);
>              qemu_file_set_error(f, ret);
> -            error_report("Load state of device %s failed", se->idstr);
>              return ret;
>          }
>      }
> @@ -2947,7 +2949,8 @@ int qemu_loadvm_state(QEMUFile *f)
>          return ret;
>      }
>=20=20
> -    if (qemu_loadvm_state_setup(f) !=3D 0) {
> +    if (qemu_loadvm_state_setup(f, &local_err) !=3D 0) {
> +        error_report_err(local_err);
>          return -EINVAL;
>      }



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65453C36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txqNu-0001QB-4n; Thu, 27 Mar 2025 12:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1txqNo-0001Pg-KH
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:47:08 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1txqNl-0007Dk-Q2
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1743094026; x=1774630026;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=uADwGL29GS6VBukfAw63YvWVUknZKKcK9Xk0o3seW4I=;
 b=MmnrwquxHRr35hkY5uqCpUpvpyNdSW5pvPQkvDjJWsI+0tTYlpdOAiUO
 h3y9ZxZSj6HzVwaLftJVjxcrUr3FQ8ni3dCCScD/rs9/0UIFcn4FD64vp
 dEQQRC7jQ+vOLe0h+bsomUzD9iLr3Jnc8g/YhRMgOq6H2Q8fkYgLzsYRG 0=;
X-CSE-ConnectionGUID: 2Pb6GUHbQWWuBS8WTkTU+w==
X-CSE-MsgGUID: 5/VBJfXsTYqgNam9Hi2h0A==
X-IronPort-AV: E=Sophos;i="6.14,281,1736809200"; 
   d="scan'208";a="569632"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 27 Mar 2025 17:47:00 +0100
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <20250327143934.7935-2-farosas@suse.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327143934.7935-1-farosas@suse.de>
 <20250327143934.7935-2-farosas@suse.de>
Date: Thu, 27 Mar 2025 17:46:59 +0100
Cc: qemu-devel@nongnu.org, "Peter Xu" <peterx@redhat.com>,
 "Prasad Pandit" <ppandit@redhat.com>, "Juraj Marcin" <jmarcin@redhat.com>,
 berrange@redhat.com
To: "Fabiano Rosas" <farosas@suse.de>
MIME-Version: 1.0
Message-ID: <1d2f0f-67e58100-9ef-73c46680@132395354>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/4] =?utf-8?q?migration/savevm=3A?= Add a 
 compatibility check for capabilities
User-Agent: SOGoMail 5.11.2
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Fabiano,

First of all thanks a lot for the quick follow up to my issue!

I just want to point out that with only mapped-ram enabled (without
multifd) savevm/loadvm do not lead to a crash but just to an error
according to my (few) experiments (on upstream).

Ciao

Marco

On Thursday, March 27, 2025 15:39 CET, Fabiano Rosas <farosas@suse.de> =
wrote:

> It has always been possible to enable arbitrary migration capabilitie=
s
> and attempt to take a snapshot of the VM with the savevm/loadvm
> commands as well as their QMP counterparts
> snapshot-save/snapshot-load.
>=20
> Most migration capabilities are not meant to be used with snapshots
> and there's a risk of crashing QEMU or producing incorrect
> behavior. Ideally, every migration capability would either be
> implemented for savevm or explicitly rejected.
>=20
> Add a compatibility check routine and reject the snapshot command if
> an incompatible capability is enabled. For now only act on the the tw=
o
> that actually cause a crash: multifd and mapped-ram.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2881
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 26 ++++++++++++++++++++++++++
>  migration/options.h |  1 +
>  migration/savevm.c  |  8 ++++++++
>  3 files changed, 35 insertions(+)
>=20
> diff --git a/migration/options.c b/migration/options.c
> index b0ac2ea408..8772b98dca 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -443,11 +443,37 @@ INITIALIZE=5FMIGRATE=5FCAPS=5FSET(check=5Fcaps=5F=
background=5Fsnapshot,
>      MIGRATION=5FCAPABILITY=5FVALIDATE=5FUUID,
>      MIGRATION=5FCAPABILITY=5FZERO=5FCOPY=5FSEND);
> =20
> +/* Snapshot compatibility check list */
> +static const
> +INITIALIZE=5FMIGRATE=5FCAPS=5FSET(check=5Fcaps=5Fsavevm,
> +                            MIGRATION=5FCAPABILITY=5FMULTIFD,
> +                            MIGRATION=5FCAPABILITY=5FMAPPED=5FRAM,
> +);
> +
>  static bool migrate=5Fincoming=5Fstarted(void)
>  {
>      return !!migration=5Fincoming=5Fget=5Fcurrent()->transport=5Fdat=
a;
>  }
> =20
> +bool migrate=5Fcan=5Fsnapshot(Error **errp)
> +{
> +    MigrationState *s =3D migrate=5Fget=5Fcurrent();
> +    int i;
> +
> +    for (i =3D 0; i < check=5Fcaps=5Fsavevm.size; i++) {
> +        int incomp=5Fcap =3D check=5Fcaps=5Fsavevm.caps[i];
> +
> +        if (s->capabilities[incomp=5Fcap]) {
> +            error=5Fsetg(errp,
> +                       "Snapshots are not compatible with %s",
> +                       MigrationCapability=5Fstr(incomp=5Fcap));
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  /**
>   * @migration=5Fcaps=5Fcheck - check capability compatibility
>   *
> diff --git a/migration/options.h b/migration/options.h
> index 762be4e641..20b71b6f2a 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -58,6 +58,7 @@ bool migrate=5Ftls(void);
>  /* capabilities helpers */
> =20
>  bool migrate=5Fcaps=5Fcheck(bool *old=5Fcaps, bool *new=5Fcaps, Erro=
r **errp);
> +bool migrate=5Fcan=5Fsnapshot(Error **errp);
> =20
>  /* parameters */
> =20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index ce158c3512..3be13bcfe8 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3229,6 +3229,10 @@ bool save=5Fsnapshot(const char *name, bool ov=
erwrite, const char *vmstate,
> =20
>      GLOBAL=5FSTATE=5FCODE();
> =20
> +    if (!migrate=5Fcan=5Fsnapshot(errp)) {
> +        return false;
> +    }
> +
>      if (migration=5Fis=5Fblocked(errp)) {
>          return false;
>      }
> @@ -3413,6 +3417,10 @@ bool load=5Fsnapshot(const char *name, const c=
har *vmstate,
>      int ret;
>      MigrationIncomingState *mis =3D migration=5Fincoming=5Fget=5Fcur=
rent();
> =20
> +    if (!migrate=5Fcan=5Fsnapshot(errp)) {
> +        return false;
> +    }
> +
>      if (!bdrv=5Fall=5Fcan=5Fsnapshot(has=5Fdevices, devices, errp)) =
{
>          return false;
>      }
> --=20
> 2.35.3
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CA4D2E03C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 08:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRRDe-000572-8q; Fri, 05 Dec 2025 03:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRRDY-00052C-P1
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:31:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRRDR-0004Oy-93
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764923460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKjopovoklbPgqNYHdBlODD/1g1OFvddnabaDvP1j1c=;
 b=SPqfqCQF2VUEgVLNhF7FfOaGNJyPvkfyp3tnlu9DxTNs6L5Yd2ahdu7TKp7FHAkYZNTWlz
 RHl+3RI02X9rCE+pEh3YS4IPiKy747SjkErQtxBQppTEm8zXHguVscZlSn3RyKREV+gGg3
 RikqXKFMD2pZAolR31AjqaablchHa/4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-s9wc7IogMKCMKZrEZsUkgA-1; Fri,
 05 Dec 2025 03:30:57 -0500
X-MC-Unique: s9wc7IogMKCMKZrEZsUkgA-1
X-Mimecast-MFC-AGG-ID: s9wc7IogMKCMKZrEZsUkgA_1764923457
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB9941801375; Fri,  5 Dec 2025 08:30:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C3121800577; Fri,  5 Dec 2025 08:30:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8856821E6A27; Fri, 05 Dec 2025 09:30:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/19] rust: do not add qemuutil to Rust crates
In-Reply-To: <20251010151006.791038-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 10 Oct 2025 17:09:48 +0200")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-4-pbonzini@redhat.com>
Date: Fri, 05 Dec 2025 09:30:53 +0100
Message-ID: <87ldjhz5xe.fsf@pond.sub.org>
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> This fails due to https://github.com/mesonbuild/meson/pull/15076.
> The config-host.h file from the qemuutil dependency ends up on the
> rustc command line for targets that do not use structured sources.
>
> It will be reverted once Meson 1.9.2 is released, or replaced with
> an update of the minimum supported version of Meson if 1.9.2 is
> released sooner.

I tend to put reminder comments next to such temporary workarounds, so I
don't forget to revert them.

> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/chardev/meson.build | 2 +-
>  rust/util/meson.build    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
> index d365d8dd0f4..36ada7c4546 100644
> --- a/rust/chardev/meson.build
> +++ b/rust/chardev/meson.build
> @@ -39,4 +39,4 @@ _chardev_rs =3D static_library(
>    dependencies: [glib_sys_rs, common_rs, qemu_macros],
>  )
>=20=20
> -chardev_rs =3D declare_dependency(link_with: [_chardev_rs], dependencies=
: [chardev, qemuutil])
> +chardev_rs =3D declare_dependency(link_with: [_chardev_rs], dependencies=
: [chardev])
> diff --git a/rust/util/meson.build b/rust/util/meson.build
> index b0b75e93ff6..8ad344dccbd 100644
> --- a/rust/util/meson.build
> +++ b/rust/util/meson.build
> @@ -43,7 +43,7 @@ _util_rs =3D static_library(
>    dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs,=
 qom, qemuutil],
>  )
>=20=20
> -util_rs =3D declare_dependency(link_with: [_util_rs], dependencies: [qem=
uutil, qom])
> +util_rs =3D declare_dependency(link_with: [_util_rs])
>=20=20
>  rust.test('rust-util-tests', _util_rs,
>            dependencies: [qemuutil, qom],



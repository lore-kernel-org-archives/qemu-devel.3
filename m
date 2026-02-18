Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1EEE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 12:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsgPu-0004iY-Ul; Wed, 18 Feb 2026 07:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsgPq-0004i8-1o
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsgPn-0004FA-Is
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771416742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrigOBYiXuhVxecp2GY0LaW6xQojf+sPiDEWmX86LEE=;
 b=Wu1VRX/J7XevCqM6/4Qr/cqK7CaBYXldsxsXJA2BDUiL7aSl+bPodH/L6z0Ga1LwFbVfLF
 RjhwSe5FLNBAIKvFHo9wU2bzhmuk5rQbM5iHrbckNtbpBWefbc9BW1bp2uUxwUA+kamczB
 5G5vHBslNsZqdjbFcNJEhfbLUO8YGNo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-_zbJmncENgyx2CBl6rBbDw-1; Wed,
 18 Feb 2026 07:12:19 -0500
X-MC-Unique: _zbJmncENgyx2CBl6rBbDw-1
X-Mimecast-MFC-AGG-ID: _zbJmncENgyx2CBl6rBbDw_1771416737
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33FDA19560B2; Wed, 18 Feb 2026 12:12:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA83E1800352; Wed, 18 Feb 2026 12:12:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A12121E692D; Wed, 18 Feb 2026 13:12:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  devel@lists.libvirt.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 15/27] ui: remove redundant use of
 error_printf_unless_qmp()
In-Reply-To: <20260211152508.732487-16-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:24:56
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-16-berrange@redhat.com>
Date: Wed, 18 Feb 2026 13:12:14 +0100
Message-ID: <87o6lmcktd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The vnc_display_print_local_addr() method is intended to print the VNC
> listening address on the console at startup, so the user can see the
> auto-chosen port address when using the 'to=3D' flag. This is only called
> by vnc_display_open() which is in the QEMU startup callpath. The check
> for not being in QMP is thus redundant and can be removed.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  ui/vnc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 833e0e2e68..fe020dcc4c 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3578,9 +3578,9 @@ static void vnc_display_print_local_addr(VncDisplay=
 *vd)
>          qapi_free_SocketAddress(addr);
>          return;
>      }
> -    error_printf_unless_qmp("VNC server running on %s:%s\n",
> -                            addr->u.inet.host,
> -                            addr->u.inet.port);
> +    error_printf("VNC server running on %s:%s\n",
> +                 addr->u.inet.host,
> +                 addr->u.inet.port);
>      qapi_free_SocketAddress(addr);
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Spotted in review: vnc_display_open() could be static.  Observation, not
a demand.



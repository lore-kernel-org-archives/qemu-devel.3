Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FC2CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZW6-0006Br-92; Fri, 19 Sep 2025 07:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzZW1-0006Ad-NR
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzZVs-0006Zc-0h
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jsecKKLR5GPzp3BSNd9cUwFnHv4PsOJqr3MvleN2F8=;
 b=XKF4uhZxr+ez/xLa+63wj7teeBczj8X/Kpl2lRlq0tyn8s5J0mR8vRxFxO1M7qqOnLvXd8
 aWatg2KEa8NuVt+3a3Jz8q4nOGJN7Z9ocRhcDYGRVb4OIsDS5WBZpZ9oUTY9uxIBSza5wz
 FYpg4EotmckqGMD7jAaRGM1PGyu2IVY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361--8JDRS-WP3S1nHzjTIugrw-1; Fri,
 19 Sep 2025 07:42:43 -0400
X-MC-Unique: -8JDRS-WP3S1nHzjTIugrw-1
X-Mimecast-MFC-AGG-ID: -8JDRS-WP3S1nHzjTIugrw_1758282161
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66BFA18004D8; Fri, 19 Sep 2025 11:42:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E189D1955F21; Fri, 19 Sep 2025 11:42:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3615C21E6A27; Fri, 19 Sep 2025 13:42:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v3 09/20] ui/vnc: remove use of error_printf_unless_qmp()
In-Reply-To: <aMQ4CHyGN5D_HyiC@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 12 Sep 2025 16:11:04 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-10-berrange@redhat.com>
 <74df1365-b9d7-448d-9edd-4a25b8dbf6a2@linaro.org>
 <aMQ4CHyGN5D_HyiC@redhat.com>
Date: Fri, 19 Sep 2025 13:42:38 +0200
Message-ID: <87348i3byp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Sep 11, 2025 at 05:54:48PM +0000, Richard Henderson wrote:
>> On 9/10/25 18:03, Daniel P. Berrang=C3=A9 wrote:
>> > The error_printf_unless_qmp() will print to the monitor if the current
>> > one is HMP, if it is QMP nothing will be printed, otherwise stderr
>> > will be used.
>> >=20
>> > This scenario is easily handled by checking !monitor_cur_is_qmp() and
>> > then calling the error_printf() function.
>> >=20
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >   ui/vnc.c | 14 +++++++++-----
>> >   1 file changed, 9 insertions(+), 5 deletions(-)
>> >=20
>> > diff --git a/ui/vnc.c b/ui/vnc.c
>> > index 68ca4a68e7..439d586358 100644
>> > --- a/ui/vnc.c
>> > +++ b/ui/vnc.c
>> > @@ -3530,8 +3530,10 @@ int vnc_display_password(const char *id, const =
char *password)
>> >           return -EINVAL;
>> >       }
>> >       if (vd->auth =3D=3D VNC_AUTH_NONE) {
>> > -        error_printf_unless_qmp("If you want use passwords please ena=
ble "
>> > -                                "password auth using '-vnc ${dpy},pas=
sword'.\n");
>> > +        if (!monitor_cur_is_qmp()) {
>> > +            error_printf("If you want use passwords please enable "

Maybe use the opportunity to put a comma after passwords?

>> > +                         "password auth using '-vnc ${dpy},password'.=
\n");
>> > +        }
>> >           return -EINVAL;
>> >       }
>> > @@ -3570,9 +3572,11 @@ static void vnc_display_print_local_addr(VncDis=
play *vd)
>> >           qapi_free_SocketAddress(addr);
>> >           return;
>> >       }
>> > -    error_printf_unless_qmp("VNC server running on %s:%s\n",
>> > -                            addr->u.inet.host,
>> > -                            addr->u.inet.port);
>> > +    if (!monitor_cur_is_qmp()) {
>> > +        error_printf("VNC server running on %s:%s\n",
>> > +                     addr->u.inet.host,
>> > +                     addr->u.inet.port);
>> > +    }
>> >       qapi_free_SocketAddress(addr);
>> >   }
>>=20
>> With monitor_cur_hmp, you can use monitor_printf directly.
>
> We still need to be able to print to stderr when there is neither HMP
> nor QMP, which error_printf gets us, but monitor_printf would not.

monitor_printf() is fine when it's obvious that we're in HMP context.
It isn't here.

Reviewed-by: Markus Armbruster <armbru@redhat.com>



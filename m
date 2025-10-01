Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E125CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 06:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3qMa-0007lK-Ed; Wed, 01 Oct 2025 02:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3qMC-0007jI-BL
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3qLz-0006W3-7S
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 02:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759300209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VufrldjP1LAPFK7LrmkzXUNw0I2YbMAL682HjshKZKw=;
 b=AZrxpIoLUNYiqYjnqrcjsgdkqFRzOuCwCnhXO6RZ8kBbG+HoDJvAN0CxHyvKHjUdunCRtr
 G/cD9LgvwTwObAYqxOU6nN37r0PtxTkEjwvjujflOH/OCPAfSZhG9FdJjipVSUMqDeDY8w
 nNRBkywOR6SDMFOED3a8HkmVtvTfacs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-d0pZ8SKMMz-1JpMi_L4frA-1; Wed,
 01 Oct 2025 02:30:07 -0400
X-MC-Unique: d0pZ8SKMMz-1JpMi_L4frA-1
X-Mimecast-MFC-AGG-ID: d0pZ8SKMMz-1JpMi_L4frA_1759300206
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B57B195609E; Wed,  1 Oct 2025 06:30:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D0D018004D8; Wed,  1 Oct 2025 06:30:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5377F21E6A27; Wed, 01 Oct 2025 08:30:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 11/13] ui/dbus: Consistent handling of texture mutex failure
In-Reply-To: <fcd1c427-7686-4b55-8696-8a589b10964f@linaro.org> (Richard
 Henderson's message of "Tue, 30 Sep 2025 09:27:36 -0700")
References: <20250930124653.321609-1-armbru@redhat.com>
 <20250930124653.321609-12-armbru@redhat.com>
 <fcd1c427-7686-4b55-8696-8a589b10964f@linaro.org>
Date: Wed, 01 Oct 2025 08:30:02 +0200
Message-ID: <87tt0j2kyd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/30/25 05:46, Markus Armbruster wrote:
>> We report d3d_texture2d_acquire0() and d3d_texture2d_release0()
>> failure as error, except in dbus_update_gl_cb(), where we report it as
>> warning.  Report it as error there as well.
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Message-ID: <20250923091000.3180122-12-armbru@redhat.com>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   ui/dbus-listener.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
>> index 09d7a319b1..b82e7c7115 100644
>> --- a/ui/dbus-listener.c
>> +++ b/ui/dbus-listener.c
>> @@ -214,26 +214,31 @@ static void dbus_update_gl_cb(GObject *source_obje=
ct,
>>                                 GAsyncResult *res,
>>                                 gpointer user_data)
>>   {
>> -    g_autoptr(GError) err =3D NULL;
>> +    g_autoptr(GError) gerr =3D NULL;
>> +#ifdef WIN32
>> +    Error **err =3D NULL;
>> +#endif
>>       DBusDisplayListener *ddl =3D user_data;
>>       bool success;
>>     #ifdef CONFIG_GBM
>>       success =3D qemu_dbus_display1_listener_call_update_dmabuf_finish(
>> -        ddl->proxy, res, &err);
>> +        ddl->proxy, res, &gerr);
>>       if (!success) {
>> -        error_report("Failed to call update: %s", err->message);
>> +        error_report("Failed to call update: %s", gerr->message);
>>       }
>>   #endif
>>     #ifdef WIN32
>>       success =3D qemu_dbus_display1_listener_win32_d3d11_call_update_te=
xture2d_finish(
>> -        ddl->d3d11_proxy, res, &err);
>> +        ddl->d3d11_proxy, res, &gerr);
>>       if (!success) {
>> -        error_report("Failed to call update: %s", err->message);
>> +        error_report("Failed to call update: %s", gerr->message);
>>       }
>>   -    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
>> +    if (!d3d_texture2d_acquire0(ddl->d3d_texture, &err)) {
>> +        error_report_err(err);
>> +    }
>>   #endif
>
> This doesn't build: https://gitlab.com/qemu-project/qemu/-/jobs/115502219=
70
>
> I think you have one too many * for the declaration of err.

Yup.  Gap in my local MinGW test setup: CONFIG_GBM is off.  Can anyone
tell me offhand which Fedora packages I should install?

Thanks!



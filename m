Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD86CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 11:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8GTI-0001Yg-Pk; Mon, 13 Oct 2025 07:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8GTH-0001YJ-C7
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8GTA-0003WF-0F
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760353916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jdv85aTfqoP0ZibPBcTkwt/hv72ZlSA/6bBbdVLFIY=;
 b=Kv3EnhJ9tMfP9iepQV8pcYXLx5HtUYgYasJfbxTm4KehOuJsBSeu+FcJAlMmKR9hhmfKMA
 Hx7M9jVRGyIRell6mzP/woYSwSpp3/jVRBj8CtbvUkPj2r7S/6jLt81mBx79X1y8XLvsnZ
 z/jznoLAi9/lqaYel4xT0msuQGrkwNQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-hmcftUM-PcCcFeIiAvXkkA-1; Mon,
 13 Oct 2025 07:11:53 -0400
X-MC-Unique: hmcftUM-PcCcFeIiAvXkkA-1
X-Mimecast-MFC-AGG-ID: hmcftUM-PcCcFeIiAvXkkA_1760353912
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EC901800597; Mon, 13 Oct 2025 11:11:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE22E18019D9; Mon, 13 Oct 2025 11:11:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C75321E6A27; Mon, 13 Oct 2025 13:11:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,  =?utf-8?Q?Marc-?=
 =?utf-8?Q?Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 09/13] ui/pixman: Consistent error handling in
 qemu_pixman_shareable_free()
In-Reply-To: <957601F2-78F5-4AD5-A6C2-CAFE49A97E84@gmail.com> (Bernhard
 Beschow's message of "Mon, 13 Oct 2025 09:55:41 +0000")
References: <20250930124653.321609-1-armbru@redhat.com>
 <20250930124653.321609-10-armbru@redhat.com>
 <957601F2-78F5-4AD5-A6C2-CAFE49A97E84@gmail.com>
Date: Mon, 13 Oct 2025 13:11:49 +0200
Message-ID: <87347n6op6.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Bernhard Beschow <shentey@gmail.com> writes:

> Am 30. September 2025 12:46:49 UTC schrieb Markus Armbruster <armbru@redh=
at.com>:
>>qemu_pixman_shareable_free() wraps around either qemu_memfd_free() or
>>qemu_win32_map_free().  The former reports trouble as error, with
>>error_report(), then succeeds.  The latter reports it as warning (we
>>pass it &error_warn), then succeeds.
>>
>>Change the latter to report as error, too.
>>
>>Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>Message-ID: <20250923091000.3180122-10-armbru@redhat.com>
>>Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>---
>> ui/qemu-pixman.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>
>>diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
>>index ef4e71da11..e46c6232cf 100644
>>--- a/ui/qemu-pixman.c
>>+++ b/ui/qemu-pixman.c
>>@@ -288,7 +288,10 @@ qemu_pixman_shareable_free(qemu_pixman_shareable han=
dle,
>>                            void *ptr, size_t size)
>> {
>> #ifdef WIN32
>>-    qemu_win32_map_free(ptr, handle, &error_warn);
>>+    Error *err =3D NULL;
>>+
>>+    qemu_win32_map_free(ptr, handle, &err);
>>+    error_report_err(err);
>
> The last line causes a crash on Windows since error_report_err() expects =
err to be non-NULL. This can be reproduced by invoking `qemu-system-x86_64.=
exe` without any parameters in msys2. Removing the line fixes the crash. I'=
m not sure how to fix this, otherwise I had went for it myself.

My bad.  I'll fix it.  Thanks!

> Best regards,
> Bernhard
>
>> #else
>>     qemu_memfd_free(ptr, size, handle);
>> #endif



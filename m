Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE60DD232EE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7hq-0000Ka-83; Fri, 09 Jan 2026 03:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ve7hm-0000Jm-Ue
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:18:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ve7hk-00080Z-Pb
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767946722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxwzm0k8MMpu87RRJePm28FlOWSBBJFckB5ykA8VnKk=;
 b=DralUNf/7DuJ7QAYTItp0Y5qK5FON/VhXdnEuD0cEIkgeh5fecIFF5uUZDwUnXx0eIt871
 qw9KabDYBYUv/AOSJBHtepX8zb397uxE4i0rdFeUyu3ji/Nng6VQoG7+j4mRCvZ5x6lVfK
 atPqUhIi2sNz+ATLu0Qb6ZP6RKs5rd8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-DdWNpZB5M4a8MjSrkDrpvQ-1; Fri,
 09 Jan 2026 03:18:39 -0500
X-MC-Unique: DdWNpZB5M4a8MjSrkDrpvQ-1
X-Mimecast-MFC-AGG-ID: DdWNpZB5M4a8MjSrkDrpvQ_1767946718
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F04941956088; Fri,  9 Jan 2026 08:18:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD6DB1800285; Fri,  9 Jan 2026 08:18:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4896221E66CC; Fri, 09 Jan 2026 09:18:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3] system: Convert qemu_arch_available() to TargetInfo API
In-Reply-To: <d8792a35-340b-4a5b-8349-42ee3d050b2a@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 9 Jan 2026 08:39:31
 +0100")
References: <20260108163601.18676-1-philmd@linaro.org>
 <f089c7c9-c00f-4c19-b4b5-175873fd8c1e@linaro.org>
 <341da906-68c9-44e9-929b-30760883178e@linaro.org>
 <0e4437cd-0e4d-4e5b-9aac-c882ef1e9214@linaro.org>
 <d8792a35-340b-4a5b-8349-42ee3d050b2a@linaro.org>
Date: Fri, 09 Jan 2026 09:18:35 +0100
Message-ID: <87ldi7mc6c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 9/1/26 07:58, Pierrick Bouvier wrote:

[...]

>> See my previous answer on v1, -Wswitch is used:
>> Reading the thread above, the only mention I find is the 3rd commit that
>> precisely change definition because -Wswitch is enabled with clang.
>> And it's not only a clang thing, gcc has it in Wall also [1].
>
> Yes I read that, I'd really like we use -Wswitch but IIUC we can not,
> so with that in mind I don't understand your request. Is that for the
> hypothetical case we can use -Wswitch in the future? Sorry I'm not
> trying to be picky here, I just fail to see the problem you raised :(

We *are* using -Wswitch.

To see that, delete the default: case in to_json()'s outer switch (patch
appended), and compile:

    ../qobject/qjson.c: In function =E2=80=98to_json=E2=80=99:
    ../qobject/qjson.c:154:5: warning: enumeration value =E2=80=98QTYPE_NON=
E=E2=80=99 not handled in switch [-Wswitch]
      154 |     switch (qobject_type(obj)) {
          |     ^~~~~~
    ../qobject/qjson.c:154:5: warning: enumeration value =E2=80=98QTYPE__MA=
X=E2=80=99 not handled in switch [-Wswitch]

We run gcc -Wall, which implies -Wswitch.

[...]


diff --git a/qobject/qjson.c b/qobject/qjson.c
index c858dafb5e..6287c93c67 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -213,8 +213,6 @@ static void to_json(JSONWriter *writer, const char *nam=
e,
         json_writer_bool(writer, name, qbool_get_bool(val));
         break;
     }
-    default:
-        abort();
     }
 }
=20



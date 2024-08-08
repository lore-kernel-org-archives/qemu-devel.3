Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F53C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 11:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1eQ-0003u4-Ai; Thu, 08 Aug 2024 07:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc1eO-0003tK-Cw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc1eL-0007ru-Sf
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723117783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=didkgguRfNqUTdyTuq2pEVbCyL4MUtkzvanbpF8HciE=;
 b=UkcO5vsDGHIgNDUhXF9ofXo8NVISJy+ehCaVGqVV8qLW7PGpoxQDkR+lMahgvlfTieLHib
 ZID4JEzWTDvMLcAosq9MK67r9B7zg6COuCW/LTu58EnxQEW5Mj0JWAFsINuy3WUpHUlB+K
 xbh836oDeXY31nrnooOQIqMvGbT3s9w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-0-zqIRGEPwSIo8th7eE4lg-1; Thu,
 08 Aug 2024 07:49:42 -0400
X-MC-Unique: 0-zqIRGEPwSIo8th7eE4lg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FD56197904D; Thu,  8 Aug 2024 11:49:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28EC3195394B; Thu,  8 Aug 2024 11:49:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE56B21E6682; Thu,  8 Aug 2024 13:48:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Michael
 Roth <michael.roth@amd.com>
Subject: Re: [PATCH 5/6] qapi: apply schema prefix to QAPI feature enum
 constants
In-Reply-To: <20240801175913.669013-6-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Aug 2024 18:59:12
 +0100")
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-6-berrange@redhat.com>
Date: Thu, 08 Aug 2024 13:48:47 +0200
Message-ID: <87ed6zxmjk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This allows us to include multiple QAPI schemas in the same file.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

This commit prepends an optional prefix to generated uses of
QAPI_FEATURE_{DEPRECATED,UNSTABLE}.

It touches neither the handwritten definition in include/qapi/util.h,
nor the handwritten uses in qapi/qapi-util.c and
qapi/qobject-output-visitor.c.

Code generated with a prefix will not compile, unless it uses no
features.  No biggie, because:

The next commit replaces the handwritten definition (no prefix) by a
generated one (with optional prefix).

Now the handwritten code compiles only because it includes an enum
definition generated without a prefix, namely the main schema's.

Note that the handwritten code continues to work even when you use it
together with some other schema, but only because all the generated
enums assign the same numeric value to the enumeration constants
_DEPRECATED and _UNSTABLE.

While that seems fairly unlikely to break accidentally, it still feels
unnecessarily dirty.

What about generating an enum like this:

    typedef enum {
        QAPI_FEATURE_DEPRECATED =3D QAPI_DEPRECATED,
        QAPI_FEATURE_UNSTABLE =3D QAPI_UNSTABLE,
        ...
    } QapiFeature;

where QAPI_DEPRECATED and QAPI_UNSTABLE are defined in qapi/util.h, like
they are before this series.

We can discuss renaming them to QAPI_SPECIAL_FEATURE_DEPRECATED and
_UNSTABLE if you like.

Code referring to special features, i.e. all references before this
series, use the definitions from qapi/util.h.

Code referring to arbitrary, possibly non-special features, i.e. the
references new in this series, use the generated definitions from
qapi/qapi-features.h.

Thoughts?



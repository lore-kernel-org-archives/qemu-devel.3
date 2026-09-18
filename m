Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED12C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ylf-0001Kp-K4; Fri, 18 Sep 2026 09:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7Yle-0001Kc-0T
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7Ylb-0002HF-HR
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789738597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IyAUaoVat+yBsNlrpihgV/nxCOmDoqg4XxP6rTI9n8w=;
 b=iPfr8uvcxxMXVZ0MCddSgHkbcEEs9sDsRKp+JMMCc+pMlW16vP5FW9B1Pzjxds9QU+vaCa
 pnPeHaLTWiMgSnMoFAhYvnVLDMpeAmq3vbfC7ut+A4i0XGUV0iBJFdB6dEzyrVyzsFYNdG
 k2/yDCktvDBK9fK61pFz4dm00TU7rns=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-9rnP2Zr7PtSW_sKFp9kmhQ-1; Fri,
 18 Sep 2026 09:36:36 -0400
X-MC-Unique: 9rnP2Zr7PtSW_sKFp9kmhQ-1
X-Mimecast-MFC-AGG-ID: 9rnP2Zr7PtSW_sKFp9kmhQ_1789738595
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C559B1956069; Fri, 18 Sep 2026 13:36:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61A5E1956044; Fri, 18 Sep 2026 13:36:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0104421E6A04; Fri, 18 Sep 2026 15:36:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/62] qapi: register all introspectable types, not
 just QMP-reachable ones
In-Reply-To: <20260911-qom-qapi-v5-4-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:34:38 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-4-7732a55b7760@redhat.com>
Date: Fri, 18 Sep 2026 15:36:31 +0200
Message-ID: <877bkin0kg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Rename QAPISchemaUsedTypes to QAPISchemaTypeAnalysis and broaden type
> collection: instead of discovering types transitively from commands and
> events, register every non-implicit type upfront in visit_needed() and
> let visit_end() resolve their dependencies.
>
> This is needed so that QOM property types that are defined in the QAPI
> schema but not referenced by any command or event still appear in
> query-qmp-schema output, making them introspectable by management tools.
>
> Commands and events still register their (often implicit) argument and
> return types, which visit_needed() intentionally skips.

Either I'm confused, or this paragraph is misleading.

Before the patch, we emit the types used directly or indirectly by
commands and events.  This ensures that you can start introspection at a
command or and event, then follow type references.  We emit exactly the
types reachable that way.

Afterwards, we emit the types used directly or indirectly by commands,
events, and user-defined types.  Now you can also start introspection at
a QOM property, then follow type references.  Since we don't know which
types are referenced from QOM properties, we emit all the types that
could be.  The only types that can't are implicit base types and the
builtin integer types we don't expose externally.

We could instead simply emit all types and call it a day.

> This makes the x86-64 query-qmp-schema grow from 244K to 265K.

Based on current master I see it grow by 9% from 246KiB to 267KiB.

If I make it emit *all* types, it instead grows by 11% to 274KiB.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

If we simply emit all types, we can drop the previous patch, and dumb
down introspect.py to visit the types without ado: drop .visit_needed(),
._use_type() and all that.

Thoughts?



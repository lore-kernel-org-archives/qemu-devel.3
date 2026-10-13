Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66979CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGd08-0000zJ-RP; Tue, 13 Oct 2026 09:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGczy-0000z0-CP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGczw-0000IL-Rt
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791899816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDDen3icjps1udFhY6halyNClEyMrZ9hCAagj2ckB50=;
 b=Vmt/L7xkolfKGfLy9PVPqB+sTeFVlJ9RR0+n6HTUdpdLOldH6n+5zqjwrWy6SEKJfX/tS7
 sE62ztYVU2V9LGip7aTcrikoR6ADHlpok+oNNlDaolSx6sOQvWt3kHHrssQv76lD7e6BMZ
 o6SED1XFuZbQvJAA/iLsSJ3qK8SgUyM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-OWER_cEdNQKixsJhbe455g-1; Tue,
 13 Oct 2026 13:56:52 +0000
X-MC-Unique: OWER_cEdNQKixsJhbe455g-1
X-Mimecast-MFC-AGG-ID: OWER_cEdNQKixsJhbe455g_1791899811
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B78918001E3; Tue, 13 Oct 2026 13:56:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F122D1800446; Tue, 13 Oct 2026 13:56:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92D6921E6A04; Tue, 13 Oct 2026 15:56:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v5 60/62] qapi: expose integer signedness and width in
 introspection
In-Reply-To: <20260911-qom-qapi-v5-60-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:35:34 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-60-7732a55b7760@redhat.com>
Date: Tue, 13 Oct 2026 15:56:48 +0200
Message-ID: <8733u9ya8v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Integer built-in types are currently canonicalized to "int" in
> query-qmp-schema. Consequently, clients cannot distinguish types such
> as int8, uint64, and size, even though they accept different ranges.

This is by design.

Width and signedness are an implementation detail.  We can change them
freely without affecting syntactic compatibility of the wire protocol.

If we expose them, we can't anymore, and docs/devel/qapi-code-gen.rst
section "Compatibility considerations" needs an update.

Why would this be useful?  Knowing width and signedness narrows down the
possible values some, but it need not be tight.

> Preserve the individual integer types during schema analysis and add an
> optional "integer" member to SchemaInfoBuiltin. It reports whether the
> type is signed and its width in bits. This also preserves the actual
> element type for arrays of integers.
>
> Teach the introspection generator to emit integer values and update the
> documentation to describe the extended schema information.
>
> For example for introspection, for all kind of int, before:
> {"name": "int", "json-type": "int", "meta-type": "builtin"}
>
> After, there are various int types such as:
> {"name": "int64", "integer": {"bits": 64, "signed": true}, "json-type":
> "int", "meta-type": "builtin"}
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37554CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 11:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7BFT-0001gS-Dl; Fri, 10 Oct 2025 07:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7BFL-0001gE-SH
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 07:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7BF7-0006HL-8s
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 07:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760095493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t1ijcKOZvJf/Qi0XF93vzsiMbbvb5OiOebs9DIIE+Vs=;
 b=bRXcPs/N9na9piGAzBRFVGFbpHKlcv2l01N/qTsXxbdYeJmd+CV9S+sEQShiozsrW28Inb
 QpmAhhFLiD44KtsLex3dI7faVff0lOtQk2am6aO99jEqEaDKha/mZOiy/JxM+tasfbqMfs
 yvescCF5NmDD2dPlvem4RdKmLjrxeX0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-n5JXiivANCSxIK0WR3XYpA-1; Fri,
 10 Oct 2025 07:24:49 -0400
X-MC-Unique: n5JXiivANCSxIK0WR3XYpA-1
X-Mimecast-MFC-AGG-ID: n5JXiivANCSxIK0WR3XYpA_1760095487
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A3931800578; Fri, 10 Oct 2025 11:24:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC9B130001B7; Fri, 10 Oct 2025 11:24:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4990F21E6A27; Fri, 10 Oct 2025 13:24:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  qemu-devel@nongnu.org,
 eblake@redhat.com,  jasowang@redhat.com,  devel@lists.libvirt.org,
 pbonzini@redhat.com,  marcandre.lureau@redhat.com,
 yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru, qemu-trivial@nongnu.org
Subject: Re: [PATCH 0/2] remove deprecated 'reconnect' options
In-Reply-To: <7503ba0e-2596-4919-b4ea-bc61e469564a@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 10 Oct 2025 12:02:14 +0300")
References: <20250924133309.334631-1-vsementsov@yandex-team.ru>
 <877bx4p3at.fsf@pond.sub.org>
 <5063033a-9d83-49da-9f15-cc492d124a68@tls.msk.ru>
 <7503ba0e-2596-4919-b4ea-bc61e469564a@yandex-team.ru>
Date: Fri, 10 Oct 2025 13:24:41 +0200
Message-ID: <87ms5zj8xy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 10.10.25 10:52, Michael Tokarev wrote:
>> On 10/9/25 17:17, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> They were deprecated in 9.2, now we can remove them.
>>>> New options to use are reconnect-ms.
>> Speaking of the option itself.. I'd not remove it, instead,
>> I'd de-deprecate it, and allow units to be specified for it,
>> like reconnect=3D10ms (defaults to s).=C2=A0 Or reconnect=3D0.1 (in
>> fractions of second).=C2=A0 But it's just me, it looks like :)
>
> QAPI is not for humans) So simple milliseconds integer is better,
> then parse the variety of suffixes. And it better fit into json
> (number is number, not a string)
>
>> Also, `has_reconnect_ms` becomes redundant after applying this
>> patch, - it should be enough to use just reconnect_ms, which
>> defaults to 0.=C2=A0 But this can be done in a subsequent cleanup.
>>=20
>
> You mean just use sock->reconnect_ms instead of explicit
>
>    int64_t reconnect_ms =3D sock->has_reconnect_ms ? sock->reconnect_ms :=
 0;
>
> ?

We routinely exploit that QAPI initializes absent members to zero.

> I believe that QMP will zero-initialize everything. But I'm not sure
> that we do zero initialize this structure on all paths.. Keeping also in =
mind
> handling other fields here like
>
>     bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
>     bool is_tn3270      =3D sock->has_tn3270  ? sock->tn3270  : false;
>     bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
>     bool is_websock     =3D sock->has_websocket ? sock->websocket : false;
>
> To drop this, we should check for all paths, that incoming structure is
> zero-initialized. And no guarantee that it does not break in future.
>
> Probably, we can implement a new QAPI feature "value with default to zero=
",
> so that we can avoid existence of .has_foo field at all for such fields.
> No field - no problem.. But not in this series)

The simple way to do "optional" is to have the machinery supply a
default value.

The less simple way is to add a distinct extra value that means
"absent".  This permits "absent" to means something else than any value.

QAPI does the latter.  Not my choice; I inherited it :)

For pointers, generated C uses null as distinct extra value.  Works,
because "present" implies non-null.

For other types, generated C uses a pair of variables (has_FOO, FOO),
where

    (true, V)           means present with value V
    (false, zero)       means absent
    (false, non-zero)   is invalid

This results in slightly more complicated code.

Most of the time, code maps "absent" to a default value.  This default
value is not visible in the schema, it's buried in the C code.  When a
type gets used in multiple places, each place can pick its own default.
Bothersome to document, and the system cannot ensure the code matches
its documentation.  Strong dislike.

Special case: when the default value is zero, we can ignore has_FOO and
just use FOO.  See "routinely exploit" above.

We could extend the QAPI schema language to let us specify the default
value.  The generator could then elide has_FOO.  Code would become
simpler.



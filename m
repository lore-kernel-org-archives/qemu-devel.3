Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DD3CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAfn-0003oM-JS; Tue, 21 Oct 2025 07:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBAff-0003na-7B
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBAfZ-0008V8-Pw
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761046599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9P2A02qk1hJkWtOHE6LNT+E/1tpKEatH+3vX8IiLIg=;
 b=Nw1AprAciV8ZyM+k3t+QleqJU2VUHfdCJASPtJC9IyBY8yrER6cbdBs3YY+Pc5z3lr/Uit
 C/7kQuGZuOhhV9yAlwdUlF6PA6Pu4zVFJI+6Qii6EDBcToaHjdW9XvbsNh/6sSbosGY8H2
 rOlhWU8xal/KqbESl2xxpjIfD8H5oGg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-ioV5v2KVOhe3LPQIDL05gQ-1; Tue,
 21 Oct 2025 07:36:37 -0400
X-MC-Unique: ioV5v2KVOhe3LPQIDL05gQ-1
X-Mimecast-MFC-AGG-ID: ioV5v2KVOhe3LPQIDL05gQ_1761046596
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1CC41956058; Tue, 21 Oct 2025 11:36:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B133C195419F; Tue, 21 Oct 2025 11:36:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4138A21E6A27; Tue, 21 Oct 2025 13:36:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com,
 stefanb@linux.vnet.ibm.com,  farosas@suse.de,  qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: vmsd errp handlers: return bool
In-Reply-To: <c11428cf-5ca1-40c4-a098-2d23d9fd8b04@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 20 Oct 2025 21:43:45 +0300")
References: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
 <87347d7s0j.fsf@pond.sub.org>
 <0ce2f913-36c2-44a2-8141-256ff847529d@yandex-team.ru>
 <aPYfqzljT3q2noDb@redhat.com> <871pmxskug.fsf@pond.sub.org>
 <7d059286-f6a2-4dae-8af1-78a3c1fc5cb4@yandex-team.ru>
 <87zf9lplvc.fsf@pond.sub.org>
 <c11428cf-5ca1-40c4-a098-2d23d9fd8b04@yandex-team.ru>
Date: Tue, 21 Oct 2025 13:36:32 +0200
Message-ID: <871pmwo5a7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 20.10.25 19:40, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>=20
>>> On 20.10.25 17:34, Markus Armbruster wrote:
>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]

>>>>> IMHO if a method is using "Error **errp", then it should be considered
>>>>> forbidden to return 'errno' values.
>>>>
>>>> Several subsystems disagree :)
>>>
>>> I'd vote, that in 99% (or more) cases, they don't reasonably disagree,
>>> but blindly follow usual pattern of returning -errno together with
>>> errp, while having no reasonable contract on concrete errno values,
>>> and with this errno finally unused (used only to check, it is it < 0,
>>> like boolean). In other words, the only contract they have is
>>> "< 0 is error, otherwise success".
>>
>> Functions that could just as well return -1 instead of errno exist.
>>
>> Functions that return negative errno with callers that use them also
>> exist.
>
> But do functions that return negative errno together with errp, with
> callers that use this errno exit? I don't ask to find, that's not simple.
> I just say, that I myself don't know any of such functions.
>
>
> upd: I found two!
>
> how:
>
> 1. git grep -A 20 'ret =3D .*errp)'
> 2. in opened pager, do `/if \(ret =3D=3D -E`
>
>
> in iommufd_cdev_autodomains_get() we do something just wrong: we clear er=
rp
> after iommufd_cdev_attach_ioas_hwpt(), but return false, which is treated
> as error (but with cleared errp!) by callers...

Returning failure without setting an error is commonly wrong, and when
it's not, it's a bad interface.  However, I can't see how this function
could do that.  Can you enlighten me?

> in qemu_read_default_config_file() we do correct thing, but keeping in mi=
nd,
> that it's very seldom practice (around one case), we'd better add a boole=
an
> parameter to qemu_read_config_file(), and parse errno exactly after call =
to
> fopen().

In my opinion, this function is just fine.  There are of course other
ways to skin this cat.

> trying with local_err gives a bit more:
>
> git grep -A 20 'ret =3D .*&\(local_\)\?err)' | grep 'ret =3D=3D -E'
> block.c-    if (ret =3D=3D -ENOTSUP) {
> block.c-    if (ret =3D=3D -EFBIG) {
> block/snapshot.c-    if (ret =3D=3D -ENOENT || ret =3D=3D -EINVAL) {
> hw/core/loader-fit.c-    if (ret =3D=3D -ENOENT) {
> hw/scsi/megasas.c-        assert(!ret || ret =3D=3D -ENOTSUP);
> hw/scsi/mptsas.c-        assert(!ret || ret =3D=3D -ENOTSUP);
> hw/usb/hcd-xhci-pci.c-        assert(!ret || ret =3D=3D -ENOTSUP);
> hw/vfio/pci.c-        if (ret =3D=3D -ENOTSUP) {
> nbd/server.c-    } while (ret =3D=3D -EAGAIN && !client->quiescing);
> nbd/server.c-    if (ret =3D=3D -EAGAIN) {
> nbd/server.c-    if (ret =3D=3D -EIO) {
> qemu-img.c-        if (ret =3D=3D -ENOTSUP) {
>
>
> I still think, that these are very seldom cases, some of them are just wr=
ong,
> some make sense, but their contract may be simplified.
>
>> I'm not going to speculate on relative frequency.
>>
>> I much prefer written function contracts.  But if a caller relies on
>> negative errno codes, there is an unwritten contract whether we like it
>> or not.
>
> Agree.
>
> I just want to say, that usual pattern
>
> int func1(..., Error *errp) {
>     ...
>     ret =3D func2(..., Error *errp);
>     if (ret < 0) {
>         return ret;
>     }
>     ...
> }
>
> is very error-prone, if func1 has some unwritten contract about _differen=
t_
> errno values. As this unwritten contract may be easily broken somewhere
> in the stack, not exactly in func1.

I readily concede:

(1) If func() lacks a written contract, passing on func2()'s value makes
the implied contract harder to see.

(2) If func() has a written contract, passing on func2()'s value makes
it harder to verify, and easier to break accidentally.

(3) When no caller needs to discriminate between different errors,
returning -1 or false results in a slightly simpler interface.

Still, has this plagued us in practice?

The only issue in this area that has plagued me enough to remember is
functions returning both -1 and negative errno.  Which works fine as
long as callers only check for negative, but is in my opinion
intolerably sloppy.  Whether the function takes an errp or not doesn't
matter.

I don't think a blanket prohibition of returning negative errno makes
sense.  Discouraging it maybe, but given how rarely it's done, I doubt
it's worth the bother.

Do feel free to send patches to simplify interfaces regardless.

>>>> Quick & dirty search without a claim to accuracy or completeness:
>>>>       $ git-ls-files \*.[ch] | xargs awk '/, Error \*\*errp/ { on=3D1 =
} on && /return -E/ { print FILENAME ":" FNR ":" $0 } /^}/ { on=3D0 }'
>>
>> [...]



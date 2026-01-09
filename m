Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7474AD232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6gl-0001iO-Io; Fri, 09 Jan 2026 02:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ve6gi-0001dO-9t
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:13:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ve6gg-0004u1-27
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767942811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pm3gmB094tq4+vW9LGOpPND15q+TFPiGP6x3QLtUfzw=;
 b=iBFp+5sB3z0yeyi2M4C0zY75nQg30LStowE+SaWyS+kOtmXfYiuwmODyo7X5bXmoQ7uPDD
 Et0kU+tdt5luUP8shInOe7yjB3LYslJ8ZySDIDBmTKXftXhILiN05lPNJf7c2+ims2IAJB
 NVqMd4k6eDIZivl7BcWFn+j7zfBZ8tg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-Fad5T53qNGy4nni3ooA6cQ-1; Fri,
 09 Jan 2026 02:13:29 -0500
X-MC-Unique: Fad5T53qNGy4nni3ooA6cQ-1
X-Mimecast-MFC-AGG-ID: Fad5T53qNGy4nni3ooA6cQ_1767942808
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5820A1956048
 for <qemu-devel@nongnu.org>; Fri,  9 Jan 2026 07:13:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 176A930002D1
 for <qemu-devel@nongnu.org>; Fri,  9 Jan 2026 07:13:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 95E6721E66C1; Fri, 09 Jan 2026 08:13:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: checkpatch.pl warning on "added, moved or deleted" messed up
In-Reply-To: <aV_CZYA3KokrT4xh@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 8 Jan 2026 14:42:45 +0000")
References: <87ms2o6z3f.fsf@pond.sub.org> <aV_CZYA3KokrT4xh@redhat.com>
Date: Fri, 09 Jan 2026 08:13:25 +0100
Message-ID: <87344fntre.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jan 08, 2026 at 01:57:56PM +0100, Markus Armbruster wrote:
>> I ran checkpatch on my
>>=20
>>     [PATCH 0/2] migration: Drop deprecated QMP stuff
>>     Message-ID: <20260108125512.2234147-1-armbru@redhat.com>
>>=20
>> and got
>>=20
>>     $ scripts/checkpatch.pl --terse *patch
>>     0001-migration-Drop-deprecated-QMP-command-query-migratio.patch:290:=
 WARNING: added, moved or deleted file(s):
>>     total: 0 errors, 1 warnings, 129 lines checked
>>=20
>> The culprit seems to be commit 1d745e6d963 (scripts/checkpatch: use new
>> hook for MAINTAINERS update check).  If I use the version immediately
>> preceding it, I get:
>>=20
>>     0001-migration-Drop-deprecated-QMP-command-query-migratio.patch:105:=
 WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>>     total: 0 errors, 1 warnings, 129 lines checked
>
> Hmm, the problem is the --terse command is rather crude and simply
> throws away everything except the first line of text. My commit made
> the verbose output multi-line to improve readability
>
> $ ./scripts/checkpatch.pl  ~/dep
> WARNING: added, moved or deleted file(s):
>
>   migration/threadinfo.h
>   migration/threadinfo.c
>
> Does MAINTAINERS need updating?
>
> total: 0 errors, 1 warnings, 193 lines checked
>
> /var/home/berrange/dep has style problems, please review.  If any of thes=
e errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
>
> but this inadvertantly made terse output worse :-(

Aha!

I posted a patch, Message-ID: <20260109071217.2326194-1-armbru@redhat.com>

Thanks!



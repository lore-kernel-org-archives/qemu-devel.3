Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79902C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 09:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzvjv-0001Ea-Oc; Thu, 25 Apr 2024 05:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzvjt-0001Dy-BX
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzvjr-00045S-SK
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714038598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFSXscm6bKTSUHEt9pYwSx38/eqZhxlT5A03U1U7Xo4=;
 b=exHO/54XTksymEDvUCSjTNNB4WdlAK9oGQvQm3Kgcvjy9kFbpuspAsl41tiiVPYoNKvmvx
 5a+BKTdu9bu2LgofjjP/UN7/R+tADQ7aveb9gkowx4Oho25AZ6LcumqO/xYDc3SGBPGAM7
 9uTuB5PbUnZjWuJq9aXDbZbCDbltChI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466--1ai1WSeNeyYo-Vrnj1x9A-1; Thu,
 25 Apr 2024 05:49:56 -0400
X-MC-Unique: -1ai1WSeNeyYo-Vrnj1x9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1E241C05138;
 Thu, 25 Apr 2024 09:49:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 836DB202450D;
 Thu, 25 Apr 2024 09:49:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 787EC21E6680; Thu, 25 Apr 2024 11:49:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 01/29] include: move include/qapi/qmp/ to include/qobject/
In-Reply-To: <87edat945l.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 25 Apr 2024 11:34:46 +0200")
References: <20240108182405.1135436-1-berrange@redhat.com>
 <20240108182405.1135436-2-berrange@redhat.com>
 <ZZxDDmv1YsqlMMCT@redhat.com> <87edat945l.fsf@pond.sub.org>
Date: Thu, 25 Apr 2024 11:49:55 +0200
Message-ID: <87h6fp7ovw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> I just realized I dropped this on the floor.  I apologize for the delay.
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Mon, Jan 08, 2024 at 06:23:37PM +0000, Daniel P. Berrang=C3=A9 wrote:
>>> The general expectation is that header files should follow the same
>>> file/path naming scheme as the corresponding source file. There are
>>> various historical exceptions to this practice in QEMU, with one of
>>> the most notable being the include/qapi/qmp/ directory. Most of the
>>> headers there correspond to source files in qobject/.
>>>=20
>>> This patch corrects that inconsistency by creating include/qobject/.
>
> Yes, there's inconsistency, but is it worth cleaning up?  Since you did
> the work already, and sunk cost doesn't count, ...

Funny:

    commit 7b1b5d191385ca52e96caae2a05c64f3a63855d9
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Mon Dec 17 18:19:43 2012 +0100

        qapi: move include files to include/qobject/

That's what you want!  However, ...

        Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

     [...]

     qapi/qmp-core.h =3D> include/qapi/qmp/dispatch.h         |  6 +++---
     json-lexer.h =3D> include/qapi/qmp/json-lexer.h          |  4 ++--
     json-parser.h =3D> include/qapi/qmp/json-parser.h        |  4 ++--
     json-streamer.h =3D> include/qapi/qmp/json-streamer.h    |  4 ++--
     qbool.h =3D> include/qapi/qmp/qbool.h                    |  2 +-
     qdict.h =3D> include/qapi/qmp/qdict.h                    |  4 ++--
     qerror.h =3D> include/qapi/qmp/qerror.h                  |  6 +++---
     qfloat.h =3D> include/qapi/qmp/qfloat.h                  |  2 +-
     qint.h =3D> include/qapi/qmp/qint.h                      |  2 +-
     qjson.h =3D> include/qapi/qmp/qjson.h                    |  4 ++--
     qlist.h =3D> include/qapi/qmp/qlist.h                    |  2 +-
     qobject.h =3D> include/qapi/qmp/qobject.h                |  0
     qstring.h =3D> include/qapi/qmp/qstring.h                |  2 +-
     qemu-objects.h =3D> include/qapi/qmp/types.h             | 16 ++++++++=
--------

     [...]

... it's not what the patch does %-}

[...]



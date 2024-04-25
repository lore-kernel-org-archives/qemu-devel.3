Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50270C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 09:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzvVF-0004l9-N4; Thu, 25 Apr 2024 05:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzvVE-0004kt-8x
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzvVC-00054j-BX
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714037689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xICHaiZHC3c6x9ec6/Gj36cZoQ2hD3Rd1o/oPxhFCzA=;
 b=Y5BN+ePwiVgqzH6tRlr8iO0Ghrenavf8AfHi+3BLIZpKou/ASUx/OJyTavYaWhAFWoDQA5
 APprwIr8yfpburSg7ztYHOST1nA90TG0Ar0fAvLd2TzoIuoF/r/6b7HwubZCFRvbES8FAs
 7Q19ueZxQ8EpV80h8PwkT3QXPoI/mRg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-EPwKpz6GP7y-MrT6obtiqg-1; Thu,
 25 Apr 2024 05:34:47 -0400
X-MC-Unique: EPwKpz6GP7y-MrT6obtiqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FE043810D35;
 Thu, 25 Apr 2024 09:34:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E40BD5C5CC2;
 Thu, 25 Apr 2024 09:34:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CF5F21E66C8; Thu, 25 Apr 2024 11:34:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 01/29] include: move include/qapi/qmp/ to include/qobject/
In-Reply-To: <ZZxDDmv1YsqlMMCT@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 8 Jan 2024 18:46:38 +0000")
References: <20240108182405.1135436-1-berrange@redhat.com>
 <20240108182405.1135436-2-berrange@redhat.com>
 <ZZxDDmv1YsqlMMCT@redhat.com>
Date: Thu, 25 Apr 2024 11:34:46 +0200
Message-ID: <87edat945l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

I just realized I dropped this on the floor.  I apologize for the delay.

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jan 08, 2024 at 06:23:37PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> The general expectation is that header files should follow the same
>> file/path naming scheme as the corresponding source file. There are
>> various historical exceptions to this practice in QEMU, with one of
>> the most notable being the include/qapi/qmp/ directory. Most of the
>> headers there correspond to source files in qobject/.
>>=20
>> This patch corrects that inconsistency by creating include/qobject/.

Yes, there's inconsistency, but is it worth cleaning up?  Since you did
the work already, and sunk cost doesn't count, ...

>> The only outlier is include/qapi/qmp/dispatch.h which gets renamed
>> to include/qapi/qmp-registry.h.

Good, as "QMP registry" is a more accurate description than "QMP
dispatch".

>> To allow the code to continue to build, symlinks are temporarily
>> added in $QEMU/qapi/qmp/ to point to the new location. They will
>> be removed in a later commit.

Only necessary to let you split the patch updating #include directives.
The update is entirely mechanical, isn't it?  I doubt splitting is worth
the trouble then.

>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>  MAINTAINERS                                     | 5 +----
>>  include/qapi/{qmp/dispatch.h =3D> qmp-registry.h} | 0
>>  include/{qapi/qmp =3D> qobject}/json-parser.h     | 0
>>  include/{qapi/qmp =3D> qobject}/json-writer.h     | 0
>>  include/{qapi/qmp =3D> qobject}/qbool.h           | 0
>>  include/{qapi/qmp =3D> qobject}/qdict.h           | 0
>>  include/{qapi/qmp =3D> qobject}/qerror.h          | 0
>
> Of course just after sending this I decided that moving qerror.h
> to qobject/ is probably not optimal. It only contains a set of
> (deprecated) error message strings. Perhaps it could just move
> from qapi/qmp/qerror.h to just qapi/qerror.h ? Other suggestions ?

qapi/qerror.h works for me.

Could use the opportunity to rename it to qapi/deprecated-qerror.h.

>>  include/{qapi/qmp =3D> qobject}/qjson.h           | 0
>>  include/{qapi/qmp =3D> qobject}/qlist.h           | 0
>>  include/{qapi/qmp =3D> qobject}/qlit.h            | 0
>>  include/{qapi/qmp =3D> qobject}/qnull.h           | 0
>>  include/{qapi/qmp =3D> qobject}/qnum.h            | 0
>>  include/{qapi/qmp =3D> qobject}/qobject.h         | 0
>>  include/{qapi/qmp =3D> qobject}/qstring.h         | 0
>
> With regards,
> Daniel



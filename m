Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2DDC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 13:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5342-0005Fd-Qy; Wed, 16 Apr 2025 09:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u533u-0005Dv-A8
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u533r-0006Ba-Kp
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744811057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdcalDUGtnqtaaV0ke2ZB8ueVUbROh4idsld6IxSnIs=;
 b=Lk96d6oFt3dK+xLpAmo3dOfn43V5Vyl+IncPSue1n9KrT9CnmK9ldZ3MQhKz9vjl4kEXM5
 KGzsc2I1mdr/QJvMi1aBJZfTMwJ8LLSYtZjdYMoWFK4V3p3gdDA1fF7N7iEqLGhWHTwN+k
 iufppFaH74kDq+0Tk7C5GUB9lMEr4Dc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-3OHU3fizMnmD4VLUhFlcZw-1; Wed,
 16 Apr 2025 09:44:14 -0400
X-MC-Unique: 3OHU3fizMnmD4VLUhFlcZw-1
X-Mimecast-MFC-AGG-ID: 3OHU3fizMnmD4VLUhFlcZw_1744811053
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 715B5180056F; Wed, 16 Apr 2025 13:44:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2256A180045C; Wed, 16 Apr 2025 13:44:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 739AC21E6766; Wed, 16 Apr 2025 15:44:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>
Subject: Re: [RFC PATCH 00/13] migration: Unify capabilities and parameters
In-Reply-To: <Z_07dfI4rFRpvZA1@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 14 Apr 2025 17:44:37 +0100")
References: <20250411191443.22565-1-farosas@suse.de>
 <Z_07dfI4rFRpvZA1@redhat.com>
Date: Wed, 16 Apr 2025 15:44:10 +0200
Message-ID: <874iyomdat.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Fri, Apr 11, 2025 at 04:14:30PM -0300, Fabiano Rosas wrote:
>> Open questions:
>> ---------------
>>=20
>> - Deprecations/compat?
>>=20
>> I think we should deprecate migrate-set/query-capabilities and everythin=
g to do
>> with capabilities (specifically the validation in the JSON at the end of=
 the
>> stream).
>>=20
>> For migrate-set/query-parameters, we could probably keep it around indef=
initely,
>> but it'd be convenient to introduce new commands so we can give them new
>> semantics.
>>=20
>> - How to restrict the options that should not be set when the migration =
is in
>> progress?
>>=20
>> i.e.:
>>   all options can be set before migration (initial config)
>>   some options can be set during migration (runtime)
>>=20
>> I thought of adding another type at the top of the hierarchy, with
>> just the options allowed to change at runtime, but that doesn't really
>> stop the others being also set at runtime. I'd need a way to have a
>> set of options that are rejected 'if migration_is_running()', without
>> adding more duplication all around.
>>=20
>> - What about savevm?
>>=20
>> None of this solves the issue of random caps/params being set before
>> calling savevm. We still need to special-case savevm and reject
>> everything. Unless we entirely deprecate setting initial options via
>> set-parameters (or set-config) and require all options to be set as
>> savevm (and migrate) arguments.
>
> I'd suggest we aim for a world where the commands take all options
> as direct args and try to remove the global state eventually.

Yes.

Even better: make it a job.

[...]



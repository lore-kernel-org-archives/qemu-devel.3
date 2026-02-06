Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106A7EB28D1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 06:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voFnw-0003Gz-Kf; Fri, 06 Feb 2026 01:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voFns-0003G3-Tb
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 01:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1voFnq-0004TJ-Oz
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 01:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770361130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTsMdXFQk+VFsm05EPjTFeASJq6gTlU22DM97NGMsVY=;
 b=LWkF8jf+bJxtK/T9gPqaLi6xjcGZNkbxTvtbq/VUOLX5aop+kA8qAcDWOiCLOhrMwjlbwz
 tUl9+2/t6ApnLXL5b/lBijfr/ZrGa1cGvJPowioLUl1zcGrshvZYPV1EUjvU103vSMEwc8
 aPCBciinxW5jvAtxunfA9c3T8mAu818=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-_pXxCrGENWGffwy_PiK_Tg-1; Fri,
 06 Feb 2026 01:58:46 -0500
X-MC-Unique: _pXxCrGENWGffwy_PiK_Tg-1
X-Mimecast-MFC-AGG-ID: _pXxCrGENWGffwy_PiK_Tg_1770361125
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BCB41800451; Fri,  6 Feb 2026 06:58:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04FA319373D8; Fri,  6 Feb 2026 06:58:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8522121E692D; Fri, 06 Feb 2026 07:58:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Renaming targets (was: [PATCH] target-info: set target_arch
 statically)
In-Reply-To: <6ddad25a-192c-4b5a-80fc-b006436810a2@linaro.org> (Richard
 Henderson's message of "Fri, 6 Feb 2026 08:36:14 +1000")
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
 <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
 <5fd0062c-b474-4971-9a46-06af9ae4e0c7@linaro.org>
 <e1495603-4ac2-44bb-8b0d-74c45e5f2e66@linaro.org>
 <877bsr34au.fsf@pond.sub.org>
 <6ddad25a-192c-4b5a-80fc-b006436810a2@linaro.org>
Date: Fri, 06 Feb 2026 07:58:42 +0100
Message-ID: <878qd6xsrh.fsf_-_@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/5/26 19:52, Markus Armbruster wrote:
>>> I assume the qapi string is the one that should take precedence; everyt=
hing else appears to be merely qemu source level strings.  Marcus, can you =
confirm?
>>=20
>> What exactly would you like me to confirm?
>>=20
>> I *guess* it's about the messy part of the patch you posted upthread.
>> There, you have to normalize TARGET_ARCH value 'openrisc' to 'or1k'.
>
> Yes.  I wanted you to confirm that changing the string in qapi is a non-s=
tarter, therefore=20
> 'or1k' is the string we should standardize on.

Yes, changing enum value @or1k is problematic.

Enum SysEmuTarget is visible in QMP: query-target return member @arch,
query-cpus-fast return member @target.  These are stable interfaces.

I can see two ways to change the enum value to @openrisc:

1. We create a new qemu-system-openrisc, identical to qemu-system-or1k
   except for the target name.  We deprecate qemu-system-or1k and
   SysEmuTarget member @or1k, and remove them after the grace period.

   I doubt it's worth the bother.

2. We cheat: we rename with the excuse that the target is bottom support
   tier, and our compatibility promise doesn't apply there.

   I don't think that's a good idea.  If we want to qualify our
   compatibility promise with tiers, we better define the tiers and what
   they mean for the promise *first*.  Related:

    From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
    Subject: [PATCH] docs/about: propose OS platform/arch support tiers
    Date: Thu, 15 Jan 2026 18:01:23 +0000
    Message-ID: <20260115180123.848640-1-berrange@redhat.com>
    https://lore.kernel.org/qemu-devel/20260115180123.848640-1-berrange@red=
hat.com/

>> I figure this is about adding 'hexagon' to SysEmuTarget even though it's
>> not actually a system emulator target now.
>>=20
>> The fact that adding it there helps indicates SysEmuTarget has leaked
>> into user emulators, and its name has become misleading.  Is this true?
>
> Yes.  The target_info structure is used for both user and system, and one=
 of these fields=20
> is the SysEmuTarget entry.

Then SysEmuTarget has become misleading.

We *can* fix that: QAPI type names are not part of the external
interface by design.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC165C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2x-0001CY-Pc; Thu, 10 Jul 2025 04:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZn2u-00012J-TN
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZn2n-0003cH-8e
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752137654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/N/iPqXZiEtPtbNs+zDYtg+6bi3YWtQN6tO9j7vkppc=;
 b=Dm43kBDY37nzoiIcgTDO9+5kHsttBGtbjckvT9HLCpRGegxfK0OQGsmxwtMjAu48KyZ3fE
 Tl7m4f3jN4VNtq7godiFuDJdXR6zDwnzXY3qLFf02wVEw5D/ilBZ6HoLwKDPzb/2V2WhTv
 z3dkwyvU1CLLiwIM9LlJQ/HoQY0qfVU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-abf2-nLhPcC2pwiGEgarJw-1; Thu,
 10 Jul 2025 04:54:10 -0400
X-MC-Unique: abf2-nLhPcC2pwiGEgarJw-1
X-Mimecast-MFC-AGG-ID: abf2-nLhPcC2pwiGEgarJw_1752137649
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38357180034E; Thu, 10 Jul 2025 08:54:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8D8618046C7; Thu, 10 Jul 2025 08:54:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1318D21E6A27; Thu, 10 Jul 2025 10:54:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Daniel
 P. Berrange" <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>
Subject: Re: [PATCH V3 3/3] tests/qtest/qom-test: unit test for qom-list-getv
In-Reply-To: <337e2790-195c-4852-8904-d421601f9011@oracle.com> (Steven
 Sistare's message of "Wed, 9 Jul 2025 11:17:30 -0400")
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-4-git-send-email-steven.sistare@oracle.com>
 <bdb92ceb-59d3-4e82-83f7-d4bde9b96583@linaro.org>
 <337e2790-195c-4852-8904-d421601f9011@oracle.com>
Date: Thu, 10 Jul 2025 10:54:06 +0200
Message-ID: <87qzyofmtt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 7/8/2025 6:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Steve,
>> On 8/7/25 19:24, Steve Sistare wrote:
>>> Add a unit test for qom-list-getv.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> =C2=A0 tests/qtest/qom-test.c | 64 ++++++++++++++++++++++++++++++++++++=
++++++++++++++
>>> =C2=A0 1 file changed, 64 insertions(+)
>>>
>>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>>> index 27d70bc..4defff1 100644
>>> --- a/tests/qtest/qom-test.c
>>> +++ b/tests/qtest/qom-test.c
>>> @@ -11,11 +11,72 @@
>>> =C2=A0 #include "qobject/qdict.h"
>>> =C2=A0 #include "qobject/qlist.h"
>>> +#include "qobject/qstring.h"
>>> =C2=A0 #include "qemu/cutils.h"
>>> =C2=A0 #include "libqtest.h"
>>> =C2=A0 static int verbosity_level;
>>> +static void test_getv(QTestState *qts, QList *paths)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 QListEntry *entry, *prop_entry, *path_entry;
>>> +=C2=A0=C2=A0=C2=A0 g_autoptr(QDict) response =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 QDict *args =3D qdict_new();
>>> +=C2=A0=C2=A0=C2=A0 QDict *prop;
>>> +=C2=A0=C2=A0=C2=A0 QList *return_list;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (verbosity_level >=3D 2) {
>>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>
>> But I note this doesn't assert anything except if you use V=3D3 and
>> look at the output.
>
> I don't follow.  It unconditionally traverses the whole tree and asserts
> that properties are present.  Plus, for V >=3D 2, it prints paths.

It starts with path "/machine".

For each property returned for that path, it checks there is a name and
type.

It collects the paths where the type starts with "child<" into a list,
and recurses.  So it walks the entire tree under "/machine".

It does not examine property values at all.  This is a gap in testing.

It does not check properties against expectations.  The test would
silently pass if qom-list-getv always returned [], or if it always
returned crap types like "".  Another gap.

Checking all this for the entire tree is entirely impractical.  But we
could check it for a suitable path of our choice.  I recommend to avoid
going into machine-dependent weeds there.  Maybe create some suitable
thing with -object, and check that.

If you can't afford implementing this, document the gaps in a TODO
comment.

> It is patterned after test_properties() in the same file.

Same gaps :)

[...]



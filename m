Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D41C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSmC-00037Z-Gs; Tue, 20 Feb 2024 11:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcSls-00035r-ND
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:15:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcSlq-0006dx-FI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708445701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7u28xwIheG3uxovuWZOpEtSYb8aZ/auv1OID/d5NrA=;
 b=epE+I2EVnjdC1JhU+soqHdtvMNC9uSmu51WG0J0MwgqFdJo14ryCcpi4trr0We3/6WsDgg
 gMCVpSIoZi4xwhBLF1aBw8LQyGpCUWYAr52CiBeO9dbjj0jHHw89oRmLC+RSXZ1QGcYLr4
 iNyr8xSfpAjo0elTPB05CYjzkov7up8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-jbZ68DtwOku-M8uuakTlmw-1; Tue,
 20 Feb 2024 11:14:58 -0500
X-MC-Unique: jbZ68DtwOku-M8uuakTlmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99F3E3814582;
 Tue, 20 Feb 2024 16:14:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C22810802;
 Tue, 20 Feb 2024 16:14:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07D0B21E6740; Tue, 20 Feb 2024 17:14:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  qemu-devel@nongnu.org,  kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>,  Sean Christopherson
 <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,  Chenyi
 Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v4 29/66] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
In-Reply-To: <cf9e91ea-825a-444c-9625-a571fdc3265a@intel.com> (Xiaoyao Li's
 message of "Tue, 20 Feb 2024 23:10:29 +0800")
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-30-xiaoyao.li@intel.com>
 <875xykfwmf.fsf@pond.sub.org>
 <cf9e91ea-825a-444c-9625-a571fdc3265a@intel.com>
Date: Tue, 20 Feb 2024 17:14:55 +0100
Message-ID: <87le7f3yf4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 2/19/2024 8:48 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>=20
>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>
>>> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
>>> can be provided for TDX attestation. Detailed meaning of them can be
>>> found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-4813f=
4e0ff92@intel.com/
>>>
>>> Allow user to specify those values via property mrconfigid, mrowner and
>>> mrownerconfig. They are all in base64 format.
>>>
>>> example
>>> -object tdx-guest, \
>>>    mrconfigid=3DASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wE=
jRWeJq83v,\
>>>    mrowner=3DASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRW=
eJq83v,\
>>>    mrownerconfig=3DASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN=
7wEjRWeJq83v
>>>
>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>
>>> ---
>>> Changes in v4:
>>>   - describe more of there fields in qom.json
>>>   - free the old value before set new value to avoid memory leak in
>>>     _setter(); (Daniel)
>>>
>>> Changes in v3:
>>>   - use base64 encoding instread of hex-string;
>>> ---
>>>   qapi/qom.json         | 14 ++++++-
>>>   target/i386/kvm/tdx.c | 87 +++++++++++++++++++++++++++++++++++++++++++
>>>   target/i386/kvm/tdx.h |  3 ++
>>>   3 files changed, 103 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 2177f3101382..15445f9e41fc 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -905,10 +905,22 @@
>>>   #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>>   #     be set, otherwise they refuse to boot.
>>>   #
>>> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
>>> +#     e.g., run-time or OS configuration.  base64 encoded SHA384 diges=
t.
>>=20
>> "base64 encoded SHA384" is not a sentence.
>>=20
>> Double-checking: the data being hashed here is the "non-owner-defined
>> configuration of the guest TD", and the resulting hash is the "ID"?
>
> yes. The "ID" here means the resulting hash.
>
> The reason to use "ID" here because in the TDX spec, it's description is
>
>    Software-defined ID for non-owner-defined configuration of the guest
>    TD - e.g., run-time or OS configuration.
>
> If ID is confusing, how about
>
>    SHA384 hash of non-owner-defined configuration of the guest TD, e.g.,
>    run-time of OS configuration.  It's base64 encoded.

I guess staying close to the TDX spec makes sense.

We still need to mention the base64 encoding.

What about something like

     ID for non-owner-defined configuration of the guest TD, e.g.,
     run-time or OS configuration (base64 encoded SHA384 digest)

or, if we decide that the fact it's SHA384 digest is irrelevant for QMP

     ID for non-owner-defined configuration of the guest TD, e.g.,
     run-time or OS configuration (base64 encoded)

>>> +#
>>> +# @mrowner: ID for the guest TD=E2=80=99s owner.  base64 encoded SHA38=
4 digest.
>>=20
>> Likewise.
>>=20
>>> +#
>>> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
>>> +#     e.g., specific to the workload rather than the run-time or OS.
>>> +#     base64 encoded SHA384 digest.
>>=20
>> Likewise.
>>=20
>>> +#
>>>   # Since: 9.0
>>>   ##
>>>   { 'struct': 'TdxGuestProperties',
>>> -  'data': { '*sept-ve-disable': 'bool' } }
>>> +  'data': { '*sept-ve-disable': 'bool',
>>> +            '*mrconfigid': 'str',
>>> +            '*mrowner': 'str',
>>> +            '*mrownerconfig': 'str' } }
>>=20
>> The new members are optional, but their description in the doc comment
>> doesn't explain behavior when present vs. behavior when absent.
>>=20
>>>=20=20=20
>>>   ##
>>>   # @ThreadContextProperties:
>>=20
>> [...]
>>=20
>>=20



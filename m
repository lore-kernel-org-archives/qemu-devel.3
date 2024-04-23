Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B07FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 12:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzFNB-0002cS-6C; Tue, 23 Apr 2024 08:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzFN5-0002bv-NS
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzFN3-00037A-IX
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713875736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4OCGcb/2OSw9wHh3Ls5sXs3Y9oqsKXa+lhRpE4ntXl8=;
 b=VxqOob62L6r5RuGRvCI+9QlJTTUJyWzDE4hJ8h8E5k4Gdj18vdsQWe2kmRAVVNhhF3veoI
 tUbc/KlsuuPLaYVpAzhoevHFTejJ8coUIra/UI3nf6Qi5vZriidOvOmm2VUm1V1kOCZHvc
 1FO8YPlkIlNt0egOxZXmsv6pcMmE9fI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-fCPgjXdeNrSVBRVXV967Mw-1; Tue, 23 Apr 2024 08:35:32 -0400
X-MC-Unique: fCPgjXdeNrSVBRVXV967Mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D4C3834FBB;
 Tue, 23 Apr 2024 12:35:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C6B2C13FA4;
 Tue, 23 Apr 2024 12:35:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DD3C21E66E5; Tue, 23 Apr 2024 14:35:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 richard.henderson@linaro.org,  philmd@linaro.org,  pbonzini@redhat.com,
 alex.bennee@linaro.org,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 14/22] target/arm/kvm-rme: Add Realm Personalization
 Value parameter
In-Reply-To: <CAFEAcA_0wi_Ujt5vjbcUFacNqxktmbF7Kma8uEw+pOUp==W0oA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 23 Apr 2024 13:20:20 +0100")
References: <20240419155709.318866-2-jean-philippe@linaro.org>
 <20240419155709.318866-16-jean-philippe@linaro.org>
 <CAFEAcA_0wi_Ujt5vjbcUFacNqxktmbF7Kma8uEw+pOUp==W0oA@mail.gmail.com>
Date: Tue, 23 Apr 2024 14:35:30 +0200
Message-ID: <871q6wb6jx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 19 Apr 2024 at 16:59, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
>>
>> The Realm Personalization Value (RPV) is provided by the user to
>> distinguish Realms that have the same initial measurement.
>>
>> The user provides up to 64 hexadecimal bytes. They are stored into the
>> RPV in the same order, zero-padded on the right.
>>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Cc: Eduardo Habkost <eduardo@habkost.net>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>> v1->v2: Move parsing early, store as-is rather than reverted
>> ---
>>  qapi/qom.json        |  15 +++++-
>>  target/arm/kvm-rme.c | 111 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 125 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 623ec8071f..91654aa267 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -931,6 +931,18 @@
>>    'data': { '*cpu-affinity': ['uint16'],
>>              '*node-affinity': ['uint16'] } }
>>
>> +##
>> +# @RmeGuestProperties:
>> +#
>> +# Properties for rme-guest objects.
>> +#
>> +# @personalization-value: Realm personalization value, as a 64-byte hex=
 string
>> +#     (default: 0)
>> +#
>> +# Since: FIXME
>> +##
>> +{ 'struct': 'RmeGuestProperties',
>> +  'data': { '*personalization-value': 'str' } }
>>
>>  ##
>>  # @ObjectType:
>> @@ -1066,7 +1078,8 @@
>>        'tls-creds-x509':             'TlsCredsX509Properties',
>>        'tls-cipher-suites':          'TlsCredsProperties',
>>        'x-remote-object':            'RemoteObjectProperties',
>> -      'x-vfio-user-server':         'VfioUserServerProperties'
>> +      'x-vfio-user-server':         'VfioUserServerProperties',
>> +      'rme-guest':                  'RmeGuestProperties'
>>    } }
>
> This list is in alphabetical order. Are we obliged to add new
> items to the end for some compatibility reason, or should this new

Since order does not matter, we should keep it sorted.  Same for enum
ObjectType.

Thanks!



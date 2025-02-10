Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D645C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPD0-0005hz-EJ; Mon, 10 Feb 2025 03:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thPCo-0005hi-VV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thPCm-0002b0-CV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739176305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=vMRsPuETqYvRODCWMBp+vjF8cqye2huWUqsXuTPjJAo=;
 b=a26VKjWcORHa92hN2Rh6JznMNHosRsjq9tZCdRn+8lrjKfWrQNoUNTV+sggEyohCkGvw2I
 7f0KbX6Bcdbxgr6oroIrem2xcnCCqvLoaBcR5dMJpfIcdrHpgSs/aJjPcpkeRBUdH+92Ze
 hwLTzS0qw7jEEtCio3rNq2fRiQoQiGg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-XkUpHtB4OS-iiZoK7a_o7A-1; Mon,
 10 Feb 2025 03:31:40 -0500
X-MC-Unique: XkUpHtB4OS-iiZoK7a_o7A-1
X-Mimecast-MFC-AGG-ID: XkUpHtB4OS-iiZoK7a_o7A
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4DE2195608E; Mon, 10 Feb 2025 08:31:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B046E1800878; Mon, 10 Feb 2025 08:31:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 527E721E6A28; Mon, 10 Feb 2025 09:31:35 +0100 (CET)
Resent-To: michael.roth@amd.com, philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 10 Feb 2025 09:31:35 +0100
Resent-Message-ID: <8734gmb3q0.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 4/4] qapi: expose all schema features to code
In-Reply-To: <CAFn=p-aSdesaSxb3pTFD54qnJJ5y0MHnS16eevcU7L+ReqZwyA@mail.gmail.com>
 (John Snow's message of "Fri, 7 Feb 2025 13:56:18 -0500")
References: <20250205123550.2754387-1-berrange@redhat.com>
 <20250205123550.2754387-5-berrange@redhat.com>
 <87wme2hsrn.fsf@pond.sub.org>
 <CAFn=p-aSdesaSxb3pTFD54qnJJ5y0MHnS16eevcU7L+ReqZwyA@mail.gmail.com>
Date: Mon, 10 Feb 2025 09:24:29 +0100
Message-ID: <87cyfqb41u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Feb 7, 2025, 6:57=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>> > This replaces use of the constants from the QapiSpecialFeatures
>> > enum, with constants from the auto-generate QapiFeatures enum
>> > in qapi-features.h
>> >
>> > The 'deprecated' and 'unstable' features still have a little bit of
>> > special handling, being force defined to be the 1st + 2nd features
>> > in the enum, regardless of whether they're used in the schema. This
>> > retains compatibility with common code that references the features
>> > via the QapiSpecialFeatures constants.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>
>> Daniel, feel free to ignore this at least for now.  I'm trying to learn
>> some typing lore from John.
>>
>> v3 made mypy unhappy.  I asked John for advice, and also posted a
>> solution involving ValuesView I hacked up myself.  Daniel took it for
>> v4.
>>
>> John suggested to use List.
>>
>> I now wonder whether could use Iterable.
>>
>> I'll show the three solutions inline.
>>
>> John, thoughts?
>>
>
> ValuesView works just fine. It accurately describes what that function
> returns. I only avoided it in my fixup because it's a more obscure type a=
nd
> generally list is easier to work with as a first-class built in primitive
> type to the language.
>
> (read as: I didn't have to consult any docs to fix it up using List and I=
'm
> lazy.)

Aside: John later shared a useful technique on IRC: "you can write
reveal_type(foo) to get mypy to spill the beans on what it thinks".

> Your solution describes precisely the type being returned (always good) a=
nd
> avoids any re-copying of data.
>
> Do be aware by caching the values view object in another object that you
> are keeping a "live reference" to the list of dict values that I think can
> change if the source dict changes.

Yes.

>                                    I doubt it matters, but you should know
> about that.

I believe it's just fine.

> The only design consideration you have now is what type you actually want
> to return and why. I think it barely matters, and I'm always going to opt
> for whatever is the least annoying for the patch author so I don't have to
> bore/torture them with python minutiae.

Since the typing in Daniel's patch is fine, I'll refrain from messing
with it.

> As long as the tests pass (my first three patches in the dan-fixup branch=
 I
> posted based on v3) I'm more than content.

Thanks!



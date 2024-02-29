Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C709C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZB7-0006r5-LQ; Thu, 29 Feb 2024 00:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfZB5-0006qo-F4
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:41:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfZB3-0002mk-Sl
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709185313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gum77zfMkvy+oPQiLKTAERDSIdzd08t1BH9kcDdJ120=;
 b=GGmNy0IKpSdusVZf2G2EZgZUHoSTFg/7Aim4Q63wRItMk4mS2F/I49yeybUR3uDEq4evw0
 JllAe7Nwv4suIWXzCfiOQaNd/MXXkTtEQT0cDIoZKPmuaf7Bojk8yySR3vxc6nPmXVgwET
 v/a68bvtzih7oFJ91o6I0JvBdP2SGeY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-dXEiRyVzOyODOJDws-xRmw-1; Thu, 29 Feb 2024 00:41:49 -0500
X-MC-Unique: dXEiRyVzOyODOJDws-xRmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3405388FBA8;
 Thu, 29 Feb 2024 05:41:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BE4B200A382;
 Thu, 29 Feb 2024 05:41:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CAE9221E66D0; Thu, 29 Feb 2024 06:41:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 thuth@redhat.com,  lvivier@redhat.com,  jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v3 2/7] migration/multifd: Implement zero
 page transmission on the multifd thread.
In-Reply-To: <CAAYibXgdaH_=JxswvKaz9qaXRFuRncmkrrSpkqSMbFu=3ypfLQ@mail.gmail.com>
 (Hao Xiang's message of "Wed, 28 Feb 2024 10:45:29 -0800")
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-3-hao.xiang@bytedance.com>
 <871q8w29zx.fsf@pond.sub.org>
 <CAAYibXgdaH_=JxswvKaz9qaXRFuRncmkrrSpkqSMbFu=3ypfLQ@mail.gmail.com>
Date: Thu, 29 Feb 2024 06:41:47 +0100
Message-ID: <87a5nju8ro.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> On Wed, Feb 28, 2024 at 1:50=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Hao Xiang <hao.xiang@bytedance.com> writes:
>>
>> > 1. Add zero_pages field in MultiFDPacket_t.
>> > 2. Implements the zero page detection and handling on the multifd
>> > threads for non-compression, zlib and zstd compression backends.
>> > 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
>> > 4. Handle migration QEMU9.0 -> QEMU8.2 compatibility.
>> > 5. Adds zero page counters and updates multifd send/receive tracing
>> > format to track the newly added counters.
>> >
>> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>>
>> [...]
>>
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index 1e66272f8f..5a1bb8ad62 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -660,10 +660,13 @@
>> >  #
>> >  # @legacy: Perform zero page checking from main migration thread.
>> >  #
>> > +# @multifd: Perform zero page checking from multifd sender thread.
>> > +#
>> >  # Since: 9.0
>> > +#
>> >  ##
>> >  { 'enum': 'ZeroPageDetection',
>> > -  'data': [ 'none', 'legacy' ] }
>> > +  'data': [ 'none', 'legacy', 'multifd' ] }
>> >
>> >  ##
>> >  # @BitmapMigrationBitmapAliasTransform:
>>
>> What happens when you set "zero-page-detection": "multifd" *without*
>> enabling multifd migration?
>
> Very good question! Right now the behavior is that if "multifd
> migration" is not enabled, it goes through the legacy code path and
> the "multifd zero page" option is ignored. The legacy path has its own
> zero page checking and will run the same way as before. This is for
> backward compatibility.

We need one of two improvements then:

1. Make "zero-page-detection" reject value "multifd" when multifd
   migration is not enabled.  Document this: "Requires migration
   capability @multifd" or similar.

2. Document that "multifd" means multifd only when multifd is enabled,
   else same as "legacy".

I prefer 1., because it's easier to document.  But migration maintainers
may have their own preference.  Peter, Fabiano?



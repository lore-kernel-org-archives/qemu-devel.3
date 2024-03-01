Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF51C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 05:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfvq4-0003yd-PR; Fri, 01 Mar 2024 00:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfvq3-0003yL-9x
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfvq1-0007qk-GY
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709272420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyRkmVMN5nuPIt2PJKAIL4i+J+M7XXVZtG2toE45VXE=;
 b=Y8o8YQ0Z9D+NsZVfdE3e0zkXOqUlG077kx30GuLI6mp1cOlrOO6fOgO+OmCs4gp9G3JIWy
 /aB+U6YrXVxH9ngVX/87MzwJ9KQ2R+b6K5W14sVdhtymQ4CL+qkntwh5+WuMSKwswamC2k
 k5GEPzkotZEiO5B25/lyvZPkMcK7GNI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-qpSv13ZCOHSqKbdM4cZ0Xw-1; Fri, 01 Mar 2024 00:53:35 -0500
X-MC-Unique: qpSv13ZCOHSqKbdM4cZ0Xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC601841861;
 Fri,  1 Mar 2024 05:53:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A21D2166B33;
 Fri,  1 Mar 2024 05:53:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B3E221E6743; Fri,  1 Mar 2024 06:53:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 thuth@redhat.com,  lvivier@redhat.com,  jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v3 6/7] migration/multifd: Add zero pages
 and zero bytes counter to migration status interface.
In-Reply-To: <CAAYibXh_Rd0q1SnFmbH4+DUUY_Vdr5dcvawtrayRRp6ZCbOfPg@mail.gmail.com>
 (Hao Xiang's message of "Thu, 29 Feb 2024 17:18:33 -0800")
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-7-hao.xiang@bytedance.com>
 <87wmqozzjn.fsf@pond.sub.org>
 <CAAYibXicsMkZ+QaFtjgSbjk_eL3waOp1fiJQ7M9b5SRXCRa+ig@mail.gmail.com>
 <875xy7u7vb.fsf@pond.sub.org>
 <CAAYibXh_Rd0q1SnFmbH4+DUUY_Vdr5dcvawtrayRRp6ZCbOfPg@mail.gmail.com>
Date: Fri, 01 Mar 2024 06:53:33 +0100
Message-ID: <87il26sdk2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

> On Wed, Feb 28, 2024 at 10:01=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> Hao Xiang <hao.xiang@bytedance.com> writes:
>>
>> > On Wed, Feb 28, 2024 at 1:52=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >>
>> >> Hao Xiang <hao.xiang@bytedance.com> writes:
>> >>
>> >> > This change extends the MigrationStatus interface to track zero pag=
es
>> >> > and zero bytes counter.
>> >> >
>> >> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>> >>
>> >> [...]
>> >>
>> >> > diff --git a/qapi/migration.json b/qapi/migration.json
>> >> > index a0a85a0312..171734c07e 100644
>> >> > --- a/qapi/migration.json
>> >> > +++ b/qapi/migration.json
>> >> > @@ -63,6 +63,10 @@
>> >> >  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
>> >> >  #     7.1)
>> >> >  #
>> >> > +# @zero-pages: number of zero pages (since 9.0)
>> >> > +#
>> >> > +# @zero-bytes: number of zero bytes sent (since 9.0)
>> >> > +#
>> >>
>> >> Awfully terse.  How are these two related?
>> >
>> > Sorry I forgot to address the same feedback from the last version.
>>
>> Happens :)
>>
>> > zero-pages are the number of pages being detected as all "zero" and
>> > hence the payload isn't sent over the network. zero-bytes is basically
>> > zero-pages * page_size. It's the number of bytes migrated (but not
>> > actually sent through the network) because they are all "zero". These
>> > two are related to the existing interface below. normal and
>> > normal-bytes are the same representation of pages who are not all
>> > "zero" and are actually sent through the network.
>> >
>> > # @normal: number of normal pages (since 1.2)
>> > #
>> > # @normal-bytes: number of normal bytes sent (since 1.2)
>>
>> We also have
>>
>>   # @duplicate: number of duplicate (zero) pages (since 1.2)
>>   #
>>   # @skipped: number of skipped zero pages. Always zero, only provided f=
or
>>   #     compatibility (since 1.5)
>>
>> Page skipping was introduced in 1.5, and withdrawn in 1.5.3 and 1.6.
>> @skipped was formally deprecated in 8.1.  It'll soon be gone, no need to
>> worry about it now.
>>
>> That leaves three values related to pages sent: @normal (and
>> @normal-bytes), @duplicate (but no @duplicate-bytes), and @zero-pages
>> (and @zero-bytes).
>>
>> I unwittingly created a naming inconsistency between @normal,
>> @duplicate, and @zero-pages when I asked you to rename @zero to
>> @zero-pages.
>>
>> The meaning of the three values is not obvious, and the doc comments
>> don't explain them.  Can you, or anybody familiar with migration,
>> explain them to me?
>>
>> MigrationStats return some values as bytes, some as pages, and some as
>> both.  I hate that.  Can we standardize on bytes?
>
> I added zero/zero-bytes because I thought they were not there. But it
> turns out "duplicate" is for that purpose. "zero/zero-bytes" is really
> additional information to "normal/normal-bytes". Peter suggested that
> if we add "zero/zero-bytes" we can slowly retire "duplicate" at a
> later point.

"zero" is a better name than "duplicate".  Identical non-zero pages are
possible, and they are duplicates, too.

If you add @zero with the intent to replace @duplicate, you should
immediately deprecate @duplicate.  If you need assistance with that,
just ask.

> I don't know the historical reason why pages/bytes are used the way it
> is today. The way I understand migration, the granularity of ram
> migration is "page". There are only two types of pages 1) normal 2)
> zero. Zero pages' playload are not sent through the network because we
> already know what it looks like. Only the page offset is sent. Normal
> pages are pages that are not zero. The entire page is sent through the
> network to the target host.

This is not at all clear from the documentation of MigrationStats.  I
think the documentation needs improvement there.

>                             if a user knows the zero/normal count,
> they can already calculate the zero-bytes/normal-bytes (zero/normal *
> page size)

Yes, because member @page-size tells them the multiplier.

>            but it's just convenient to see both. During development, I
> check on these counters a lot and they are useful.

QMP is for machines.  Machines don't need or want the same quantity in
two units.  Providing them both bytes and pages is a design mistake.
Whether it's worth correcting now is of course debatable.

Regardless, the fact @normal-bytes =3D @normal * @page-size needs to be
documented.  We have

    # @page-size: The number of bytes per page for the various page-based
    #     statistics (since 2.10)

The fact that I inquired how zero-pages and zero-bytes are related might
indicate that this isn't quite clear enough.

[...]



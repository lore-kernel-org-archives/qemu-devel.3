Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E748BC36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 06:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzUnB-0006Rd-FK; Tue, 01 Apr 2025 02:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tzUn3-0006Qj-BU
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tzUn0-0007jv-64
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743487673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/KLLi23gZ4QOQsGPjDcjGznbKTl55e5dJc1Lg7XaGE=;
 b=Q8GowF2lvZvHIYipK7fGg0lHSzrA1YHUhckZ5krMOaS5jJYHyxr4PFn3BZXaaUoUnzOfjf
 ZyL+GriY+wK9S1DgVr/wA+4tvooJEoMmovjRzKu+wVs/6ubKlapQ5bbUD/U1gR8nJvQMFj
 SKx1AmsLHVZPs9i6WN7VQ8T9YdnEl3A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-eanJGHPMNZODn8wKWLFA7g-1; Tue,
 01 Apr 2025 02:07:47 -0400
X-MC-Unique: eanJGHPMNZODn8wKWLFA7g-1
X-Mimecast-MFC-AGG-ID: eanJGHPMNZODn8wKWLFA7g_1743487665
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9336180025E; Tue,  1 Apr 2025 06:07:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3396180174E; Tue,  1 Apr 2025 06:07:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DFB821E66C5; Tue, 01 Apr 2025 08:07:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Fabiano Rosas <farosas@suse.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Hanna Reitz
 <hreitz@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  qemu-trivial@nongnu.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 qemu-block@nongnu.org,  Lukas Straub <lukasstraub2@web.de>,  Jiri Pirko
 <jiri@resnulli.us>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael
 Tokarev <mjt@tls.msk.ru>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Laurent
 Vivier <laurent@vivier.eu>,  Zhenwei Pi <pizhenwei@bytedance.com>,  Eric
 Blake <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Kevin Wolf
 <kwolf@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v2 2/4] docs, qapi: generate undocumented return sections
In-Reply-To: <CAFn=p-bwhzosvS8v7q1sKhYaa39LkPKAoYkog14jEg_S_s0jHg@mail.gmail.com>
 (John Snow's message of "Mon, 31 Mar 2025 14:30:36 -0400")
References: <20250326195756.330817-1-jsnow@redhat.com>
 <20250326195756.330817-3-jsnow@redhat.com>
 <87zfh6yh1o.fsf@pond.sub.org>
 <CAFn=p-bwhzosvS8v7q1sKhYaa39LkPKAoYkog14jEg_S_s0jHg@mail.gmail.com>
Date: Tue, 01 Apr 2025 08:07:37 +0200
Message-ID: <877c445s9i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On Thu, Mar 27, 2025 at 5:11=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch changes the qapidoc transmogrifier to generate Return value
>> > documentation for any command that has a return value but hasn't
>> > explicitly documented that return value.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> Might want to briefly explain placement of the auto-generated return
>> value documentation.  But before we discuss that any further, let's
>> review the actual changes the the generated docs.
>>
>> This patch adds auto-generated return value documentation where we have
>> none.
>>
>> The next patch replaces handwritten by auto-generated return value
>> documentation where these are at least as good.  Moves the return value
>> docs in some cases.
>>
>> First the additions:
>>
>> * x-debug-query-block-graph
>>
>>   Title, intro, features, return
>>
>> * query-tpm
>>
>>   Title, intro, return, example
>>
>> * query-dirty-rate
>>
>>   Title, intro, arguments, return, examples
>>
>> * query-vcpu-dirty-limit
>>
>>   Title, intro, return, example
>>
>> * query-vm-generation-id
>>
>>   Title, return
>>
>> * query-memory-size-summary
>>
>>   Title, intro, example, return
>>
>> * query-memory-devices
>>
>>   Title, intro, return, example
>>
>> * query-acpi-ospm-status
>>
>>   Title, intro, return, example
>>
>> * query-stats-schemas
>>
>>   Title, intro, arguments, note, return
>>
>> Undesirable:
>>
>> * query-memory-size-summary has returns after the example instead of
>>   before.  I figure it needs the TODO hack to separate intro and example
>>   (see announce-self).
>>
>
> Yes
>
>
>>
>> * query-stats-schemas has a note between arguments and return.  I think
>>   this demonstrates that the placement algorithm is too simplistic.
>>
>
> Yeah ... It's just that *glances at length of email* it's been a sensitive
> topic without a lot of certainty in desire, so I've tried to keep things =
on
> the stupid/simple side ...

When the best solution is unclear, starting discussion with a simplistic
solution is smart.  Beats starting with a complicated solution that gets
shot down.

>> Debatable:
>>
>> * x-debug-query-block-graph has returns after features.  I'd prefer
>>   returns before features.  No need to debate this now.
>>
>
> Willing to do this for you if you'd like to enforce it globally. I'd be
> happy with any mandated order of sections, really.

Could a more rigid order help the inliner, too?

>> Next the movements:
>>
>> * x-debug-block-dirty-bitmap-sha256
>>
>>   From right before errors to right after
>>
>> * blockdev-snapshot-delete-internal-sync
>>
>>   From right before errors to right after
>>
>> * query-xen-replication-status
>>
>>   From between intro and example to the end
>>
>> * query-colo-status
>>
>>   From between intro and example to the end
>>
>> * query-balloon
>>
>>   From right before errors to right after
>>
>> * query-hv-balloon-status-report
>>
>>   From right before errors to right after
>>
>> * query-yank
>>
>>   From between intro and example to the end
>>
>> * add-fd
>>
>>   From between arguments and errors to between last note and example
>>
>> I don't like any of these :)
>>
>
> So it goes ...
>
>
>>
>> Undesirable:
>>
>> * query-xen-replication-status, query-yank, and query-colo-status now
>>   have return after the example instead of before.  I figure they now
>>   need the TODO hack to separate intro and example.
>>
>
> Yes
>
>
>>
>> * add-fd now has a note between arguments and return.  Same placement
>>   weakness as for query-stats above.
>>
>> Debatable:
>>
>> * x-debug-block-dirty-bitmap-sha256,
>>   blockdev-snapshot-delete-internal-sync, query-colo-status, and
>>   query-hv-balloon-status-report now have return after errors instead of
>>   before.  I'd prefer before.
>>
>> What's the stupidest acceptable placement algorithm?  Maybe this one:
>>
>> 1. If we have arguments, return goes right after them.
>>
>> 2. Else if we have errors, return goes right before them.
>>
>> 3. Else if we have features, return goes right before them.
>>
>> 4. Else return goes right after the intro (to make this work, we need
>>    a few more TODO hacks).
>>
>> Would you be willing to give this a try?
>>
>
> Probably ...
>
> So this algorithm seems to imply a preference for this ordering:
>
> 1. Intro
> 2. Arguments
> 3. Return
> 4. Errors
> 5. Features
> 6. Details
>
> Do I have that correct?

Yes, with

  7. Since

although a case could also be made for

  1. Intro
  2. Arguments
  3. Return
  4. Errors
  5. Features
  6. Since
  7. Details



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98A1D35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7tvV-0004lE-Q2; Wed, 01 Apr 2026 07:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7tvS-0004ku-7z
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 07:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7tvO-0007Ff-Uj
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 07:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775043593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqezalPl4i3JBcgLVBe3bFLBNdF5OgFM/6xHTa3bquo=;
 b=RWAhoLKZGbhzsSnZKAULu2ihCHm1wy9eKnhWQVbv8dMpYTnHQ55I70D2Tny/xa8Ud1iScC
 2vOWJLztKQzsuEywZQXLa9MtDbRbAgeZ9f2A/OToYZ3ald4GfE0kFTWc1AVubpw9WnJXtT
 H9zbJgr/ung9Y9cS/5nBhN0KD6kNvS0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-qe4Ff5YzMWiw4qyQPLAQqg-1; Wed,
 01 Apr 2026 07:39:47 -0400
X-MC-Unique: qe4Ff5YzMWiw4qyQPLAQqg-1
X-Mimecast-MFC-AGG-ID: qe4Ff5YzMWiw4qyQPLAQqg_1775043586
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B930195607D; Wed,  1 Apr 2026 11:39:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17205180058B; Wed,  1 Apr 2026 11:39:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BAB5321E6A28; Wed, 01 Apr 2026 13:39:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
 <berrange@redhat.com>,  <eblake@redhat.com>,
 <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
 <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
 <me@linux.beauty>,  <ira.weiny@intel.com>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
In-Reply-To: <20260331155044.0000603d.alireza.sanaee@huawei.com> (Alireza
 Sanaee's message of "Tue, 31 Mar 2026 15:50:44 +0100")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-10-alireza.sanaee@huawei.com>
 <87mrzuei5f.fsf@pond.sub.org>
 <20260327151811.00005564.alireza.sanaee@huawei.com>
 <87zf3s1ohc.fsf@pond.sub.org>
 <20260331155044.0000603d.alireza.sanaee@huawei.com>
Date: Wed, 01 Apr 2026 13:39:42 +0200
Message-ID: <87tstu29kx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Alireza Sanaee <alireza.sanaee@huawei.com> writes:

> On Sat, 28 Mar 2026 07:01:51 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
> +CC Ira
>
> Hi Markus,
>
> Please look inline. I believe Ira might be able to help and we can see what he thinks.
>
>> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
>> 
>> > On Thu, 26 Mar 2026 16:15:40 +0100
>> > Markus Armbruster <armbru@redhat.com> wrote:
>> >
>> > Hi Markus,
>> >
>> > This commit adds a test command to check whether an extent (a piece of memory region) has been released or not by the guest.
>> > The process of removal is highly asynchronous, that's why I needed to add a new command to check it.
>> >
>> > I would be happy to drop this patch, as this is extra.  
>> 
>> So your motivation for adding the command is "just" testing.  Correct?
>
> I wrote tests to make sure extents were released, and I used this QMP command to check.

As long as this is the only known use case, we want

    # @unstable: This command is meant for debugging.

in the QAPI schema.

> Now there is background about extents where DCD was developed in Linux by @Ira, CCed [1].
>
> In the DCD extent tracking section of the CXL spec, I see some commands 
> related to getting the extent list, maybe Ira can comment here. To be fair, knowing if an extent
> was released or not is a useful information in general from orchestrator perspective.
>
> [1] https://patchew.org/linux/20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com/

If we believe there are other uses, but we're unsure the command
actually serves them:

    # @unstable: This command is experimental.

>> Can you think of other uses?
>> 
>> In particular, would a management application need this query to monitor
>> removal?
>
> I think management will get a signal on the removal given the schema in Ira's Linux kernel 
> patchset. I do not think this is implemented in QEMU at least (I might be missing something).

I'm getting a feeling of "this is underbaked" :)  But that's for the CXL
maintainers to judge.

>> The description of feature @unstable may need to be adjusted for the
>> answers we work out here.
>
> Absolutely.
>
>> 
>> >
>> > Thanks,
>> > Ali  
>> 
>> 



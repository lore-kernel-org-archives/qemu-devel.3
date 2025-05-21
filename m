Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D582DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 14:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHkR9-000246-N0; Wed, 21 May 2025 10:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHkR4-00022M-6Y
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHkR1-0003Q6-Qj
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747837720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6xEJzFN9pM8phaAMhP1/Sx30r+OXrk88FvBes68Cf9Q=;
 b=Rlm1gxheLyXI6RJqcfu633uyX/q2lJVPO2IvJMLNiQKLXcqcYy75LCUCvpn/9YKB5wKRou
 9kTpf9BoYwPd6t171ex3Dakqv11toelL5Kgz23LmKA7/ZdQuCoVGpU6rkZCYjwqQTevZeZ
 MzEAGlboIIe7pQli2o5QVYZCwhg3hA0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-45Cp4JNAMJuPXcFVrS4KBA-1; Wed,
 21 May 2025 10:28:39 -0400
X-MC-Unique: 45Cp4JNAMJuPXcFVrS4KBA-1
X-Mimecast-MFC-AGG-ID: 45Cp4JNAMJuPXcFVrS4KBA_1747837717
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E0D0195608E; Wed, 21 May 2025 14:28:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB7EA30001AA; Wed, 21 May 2025 14:28:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F253F21E66C3; Wed, 21 May 2025 16:28:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 devel@lists.libvirt.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/4] qapi/migration: Deprecate migrate argument @detach
In-Reply-To: <aC3VlBLa0nmaXNLW@x1.local> (Peter Xu's message of "Wed, 21 May
 2025 09:31:00 -0400")
References: <20250521063711.29840-1-armbru@redhat.com>
 <20250521063711.29840-3-armbru@redhat.com> <aC3VlBLa0nmaXNLW@x1.local>
Date: Wed, 21 May 2025 16:28:33 +0200
Message-ID: <87msb6yr5a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, May 21, 2025 at 08:37:09AM +0200, Markus Armbruster wrote:
>> Argument @detach has always been ignored.  Start the clock to get rid
>> of it.
>> 
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/about/deprecated.rst |  5 +++++
>>  qapi/migration.json       | 18 +++++++++---------
>>  2 files changed, 14 insertions(+), 9 deletions(-)
>> 
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 9665bc6fcf..ef4ea84e69 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -179,6 +179,11 @@ Use ``job-dismiss`` instead.
>>  
>>  Use ``job-finalize`` instead.
>>  
>> +``migrate`` argument ``detach`` (since 10.1)
>> +''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +This argument has always been ignored.
>> +
>>  ``query-migrationthreads`` (since 9.2)
>>  ''''''''''''''''''''''''''''''''''''''
>>  
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 8b9c53595c..ecd266f98e 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1660,6 +1660,10 @@
>>  #
>>  # @resume: resume one paused migration, default "off".  (since 3.0)
>>  #
>> +# Features:
>> +#
>> +# @deprecated: Argument @detach is deprecated.
>> +#
>>  # Since: 0.14
>>  #
>>  # .. admonition:: Notes
>> @@ -1668,19 +1672,14 @@
>>  #        migration's progress and final result (this information is
>>  #        provided by the 'status' member).
>>  #
>> -#     2. All boolean arguments default to false.
>
> There's one more boolean ("resume") exists, but probably not a huge
> deal.. All booleans if not mentioned should have a default-false semantics
> at least to me.

Its default remains documented.  It's visible above :)

> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!



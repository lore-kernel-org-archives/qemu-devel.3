Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797BEC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 05:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2kvO-0007uX-7b; Thu, 10 Apr 2025 01:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2kvL-0007n6-Nh
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 01:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u2kvI-0000e7-HG
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 01:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744264678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GAMbCe7k8yZNvZDO6Ko/L68MPhTknoXorTdtxyGPhjc=;
 b=g9sNJJWzzUeUvNsjYI9fzSBby/PTFRN9i5QVKwVNgY2h2jGprum7BTuywBoeSH1XqPYJn+
 bErwGdD7pIng6/mZrfsiWd6KbvKzhLsBOJ0YoGt+3vw0GQgccwpPAIMvy8PXk1N5qZirbv
 pbDY3X3VP62oVMnXYhxA10yHExxbf0k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-7pJBevUPM6uUhpr4U-cFjw-1; Thu,
 10 Apr 2025 01:57:54 -0400
X-MC-Unique: 7pJBevUPM6uUhpr4U-cFjw-1
X-Mimecast-MFC-AGG-ID: 7pJBevUPM6uUhpr4U-cFjw_1744264673
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EE35180AB16; Thu, 10 Apr 2025 05:57:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 057BD3001D0E; Thu, 10 Apr 2025 05:57:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A6D0821E66C5; Thu, 10 Apr 2025 07:57:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  devel@lists.libvirt.org
Subject: Re: [PATCH V1 0/6] fast qom tree get
In-Reply-To: <2a1419b3-5cee-4c57-9f3b-a02d630df3b6@oracle.com> (Steven
 Sistare's message of "Wed, 9 Apr 2025 11:14:45 -0400")
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org>
 <86bb6d0f-63a1-4643-b58a-1186a73e3b17@oracle.com>
 <87mscp8nlu.fsf@pond.sub.org>
 <507cd943-5922-44b2-a0cb-1b85f0cfd074@oracle.com>
 <87iknd75so.fsf@pond.sub.org>
 <2a1419b3-5cee-4c57-9f3b-a02d630df3b6@oracle.com>
Date: Thu, 10 Apr 2025 07:57:49 +0200
Message-ID: <87cydk4kyq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 4/9/2025 10:44 AM, Markus Armbruster wrote:
>> Steven Sistare <steven.sistare@oracle.com> writes:
>> 
>>> On 4/9/2025 9:34 AM, Markus Armbruster wrote:
>>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>>> On 4/9/2025 3:39 AM, Markus Armbruster wrote:

[...]

>>>> Anyway, asking you to fix design mistakes all over the place wouldn't be
>>>> fair.  So I'm asking you something else instead: do you actually need
>>>> the error information?
>>>
>>> I don't need the specific error message.
>>>
>>> I could return a boolean meaning "property not available" instead of returning
>>> the exact error message, as long as folks are OK with the output of the qom-tree
>>> script changing for these properties.
>> 
>> Let's put aside the qom-tree script for a moment.

[...]

>> Back to qom-tree.  I believe this script is a development aid that
>> exists because qom-get is painful to use for humans.  Your qom-tree
>> command would completely obsolete it.  I wouldn't worry about it.
>> If you think I'm wrong there, please speak up!
>
> Regarding dropping the error messages, I agree, I was just pointing it out
> in case anyone objected.

Appreciated.

> Yes, the new command plus a formatter like jq obsoletes the qom-tree script.
> Just to be clear, I do not propose to delete the script, since folks are
> accustomed to it being available, and are accustomed to its output.  It also
> serves as a nice example for how to use the new command.

I have little use for scripts/qmp/ myself.  Since nothing there adds to
my maintenance load appreciably, I don't mind keeping the scripts.
qom-fuse is rather cute.

> Do you want to review any code and specification now, or wait for me to send
> V2 that deletes the error member?  The changes will be minor.

v1 should do for review.  Thanks!



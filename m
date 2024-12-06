Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F1E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 09:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJUgp-0002A4-1H; Fri, 06 Dec 2024 04:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJUgn-00029m-AB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 04:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJUgl-0006Qv-Ia
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 04:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733477513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8jc9cfEj5U/gW2+rQs6yqVqfr3ukquc8pdZwTmWNvLE=;
 b=UgQtgqxY590kcAFZhaH+EAjXAbNeIPLOi3XezWwYnOCu8o/30qsSX4DgK0LUWXuLBICoGX
 b7LpgGcAe09TTJYwmaSfzQKSTh8QbkXQ6cJuoAI59HCH0Q0I19YzZHJd8bv3cdfWwEfs4W
 R3Fb6hO1NBXavMVJTzdsGladmdZ069Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-mVYN-kzPN26_PHQs74iUIw-1; Fri,
 06 Dec 2024 04:31:50 -0500
X-MC-Unique: mVYN-kzPN26_PHQs74iUIw-1
X-Mimecast-MFC-AGG-ID: mVYN-kzPN26_PHQs74iUIw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E85FD19560A1; Fri,  6 Dec 2024 09:31:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5995919560A2; Fri,  6 Dec 2024 09:31:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0F50921E66E2; Fri,  6 Dec 2024 10:31:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V4 10/19] migration: cpr channel
In-Reply-To: <2ac9265b-0092-4636-8238-91331834ea77@oracle.com> (Steven
 Sistare's message of "Thu, 5 Dec 2024 15:46:53 -0500")
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-11-git-send-email-steven.sistare@oracle.com>
 <87cyi6cf9k.fsf@pond.sub.org>
 <2ac9265b-0092-4636-8238-91331834ea77@oracle.com>
Date: Fri, 06 Dec 2024 10:31:46 +0100
Message-ID: <877c8d6ttp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

> On 12/5/2024 10:37 AM, Markus Armbruster wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Add the 'cpr' channel type, and stash the incoming cpr channel for use
>>> in a subsequent patch.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> [...]
>> 
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index a605dc2..a26960b 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -1578,11 +1578,12 @@
>>>  # The migration channel-type request options.
>>>  #
>>>  # @main: Main outbound migration channel.
>>> +# @cpr: cpr state channel.
>>>
>> What does "cpr" stand for?
>
> docs/devel/migration/CPR.rst:  CheckPoint and Restart (CPR)

Suggest something like

     # The migration channel-type request options.
     #
     # @main: Main outbound migration channel.
     #
     # @cpr: Checkpoint and restart state channel

A quick glance at docs/devel/migration/CPR.rst makes me wonder: is that
really *developer* documentation?

Should we have something meant for *users*, too?  QAPI docs could then
link to it.



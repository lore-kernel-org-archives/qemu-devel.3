Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4641C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 16:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaGxE-0000KJ-53; Fri, 11 Jul 2025 12:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaGwy-00009j-Ms
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uaGwv-0004rf-Uj
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752252611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2eLuC3l1c3rDDHsFyz6gz7pcYXgvINDuGDm5mDgJtas=;
 b=Lib58CkOnUh8oMHlliv5FVTxQl5zKUQLvMcxGWIDeXazMiV4gzdLMkgSocnF8/eGLoGDQy
 xWV8lzr5HLk7Gk7yYg9UHGKuvCk9mfXtEQrn4pv7IscTxExkRaZ8/4PHDzvbG9Ofzmrfa0
 lKeQ3nU2ctCUM/1D6L8YYpI7x2S6b3g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-e3XSXwVDOfW-ZCjFZI9omg-1; Fri,
 11 Jul 2025 12:50:08 -0400
X-MC-Unique: e3XSXwVDOfW-ZCjFZI9omg-1
X-Mimecast-MFC-AGG-ID: e3XSXwVDOfW-ZCjFZI9omg_1752252607
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AA3E1809C83; Fri, 11 Jul 2025 16:50:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B33381803AF2; Fri, 11 Jul 2025 16:50:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0875E21E6A27; Fri, 11 Jul 2025 18:50:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Philippe Mathieu-Daude
 <philmd@linaro.org>
Subject: Re: [PATCH V4 2/3] python: use qom-list-get
In-Reply-To: <a84a1482-4ba4-4520-b875-9b3a9a879868@oracle.com> (Steven
 Sistare's message of "Fri, 11 Jul 2025 11:23:03 -0400")
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-3-git-send-email-steven.sistare@oracle.com>
 <871pqmwzqr.fsf@pond.sub.org>
 <a84a1482-4ba4-4520-b875-9b3a9a879868@oracle.com>
Date: Fri, 11 Jul 2025 18:50:04 +0200
Message-ID: <87ms9au0xv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> On 7/11/2025 10:47 AM, Markus Armbruster wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Use qom-list-get to speed up the qom-tree command.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> 
>> Quick test...  Differences in output before and after match expectations
>> (see appended diff).
>> 
>> New version:
>> 
>>      real    0m0.446s
>>      user    0m0.062s
>>      sys     0m0.017s
>> 
>> Old version barfs a stack backtrace (appended), and is ~18x slower:
>> 
>>      real    0m8.176s
>>      user    0m0.395s
>>      sys     0m0.126s
>> 
>> Did you see the stack backtrace, too?
>> 
>> Regardless
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks.  Do you want a tested-by credit, or is that too little testing
> for you to stand behind that endorsement?

Tested-by: Markus Armbruster <armbru@redhat.com>

> I observe the same expected differences.
>
> My test did not backtrace.  Must be a different VM.

Let's not worry about it.

[...]



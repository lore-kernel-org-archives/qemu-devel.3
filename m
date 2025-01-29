Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF24C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3IN-0004lC-KK; Wed, 29 Jan 2025 03:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1td3IA-0004c8-Mn
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1td3I9-0003uB-BX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738138760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=esgCsG9QOo0u29WGMucAkgit/kdlVKJgu14ihyTt+O8=;
 b=IMbRuyxPDmmuwHfU88+0bfjDmcQeN+FT2tqqg0ZDpuzRmgAQD6BdBmgyuNOgFVrMurVCPV
 1mLCK9lJiXI7jMOFf1kRQJRlvwyUcVWDMal5m+7KcuqG6pCOlHNFlpYjPDHrWAhueuio1/
 R3WDbedmPSpiCIpmES5S1UZFpcqdxHY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-9f3y1ildOHWnEjZ8bfgt_g-1; Wed,
 29 Jan 2025 03:19:14 -0500
X-MC-Unique: 9f3y1ildOHWnEjZ8bfgt_g-1
X-Mimecast-MFC-AGG-ID: 9f3y1ildOHWnEjZ8bfgt_g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09D521800268; Wed, 29 Jan 2025 08:19:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.71])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACEE719560A3; Wed, 29 Jan 2025 08:19:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B2F921E6A28; Wed, 29 Jan 2025 09:19:09 +0100 (CET)
Resent-To: marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 philmd@linaro.org, qemu-devel@nongnu.org, steven.sistare@oracle.com,
 farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Wed, 29 Jan 2025 09:19:09 +0100
Resent-Message-ID: <87plk66nia.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V7 00/24] Live update: cpr-transfer
In-Reply-To: <a7af45f7-cd65-497a-9b20-eae6a0dab361@oracle.com> (Steven
 Sistare's message of "Tue, 28 Jan 2025 16:20:39 -0500")
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <87y0ywqna1.fsf@suse.de>
 <a7af45f7-cd65-497a-9b20-eae6a0dab361@oracle.com>
Date: Wed, 29 Jan 2025 07:24:09 +0100
Message-ID: <87cyg687ee.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On 1/27/2025 10:39 AM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:

[...]

>> I'd like to merge this series by the end of the week if possible. Please
>> take a look at some comments from Markus that were left behind in v5.
>
> We discussed, and Markus agrees none are show stoppers.

I just sent my Acked-by to the QAPI part.  Thank you both for your
patience!



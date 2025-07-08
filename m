Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436BBC83F10
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFCr-0000kr-7E; Tue, 08 Jul 2025 16:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZDmf-0003m3-7a
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZDmU-0006uj-Iv
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752002088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLStfRJpmfQIOh7bxIrsJAAe+Duhq1gVCiVm8+G88H0=;
 b=dajCX01+m2Stwx0f9M/Mxpu21vTA6+Y1/k8SWBgul48dcFtO9DWnMD0sg6DtS5GJwVYdBd
 cHBcUrQ99+Y5fe1JUJngbsanlTxhhS3nUNIW0sfoYmkU7WXd5KMNperwoAnpMAMq4dpwOI
 aUYAn05AHgarrpvcOSvtU3UbWL3kgow=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-0xo2J7d1OFa-lqVWW6Fupg-1; Tue,
 08 Jul 2025 02:54:00 -0400
X-MC-Unique: 0xo2J7d1OFa-lqVWW6Fupg-1
X-Mimecast-MFC-AGG-ID: 0xo2J7d1OFa-lqVWW6Fupg_1751957639
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7F0D18001D1; Tue,  8 Jul 2025 06:53:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F4097195608F; Tue,  8 Jul 2025 06:53:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 362CB21E6A27; Tue, 08 Jul 2025 08:53:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Peter Krempa <pkrempa@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH V2 1/5] qom: qom-tree-get
In-Reply-To: <87zfdfz2y6.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 08 Jul 2025 07:06:25 +0200")
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-2-git-send-email-steven.sistare@oracle.com>
 <877c0ono29.fsf@pond.sub.org>
 <76271add-d9b3-4b45-a272-3cbe336c2103@oracle.com>
 <87zfdfz2y6.fsf@pond.sub.org>
Date: Tue, 08 Jul 2025 08:53:55 +0200
Message-ID: <87cyabyxz0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Markus Armbruster <armbru@redhat.com> writes:

> Steven Sistare <steven.sistare@oracle.com> writes:
>
>> On 7/4/2025 8:22 AM, Markus Armbruster wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>> 
>>>> Define the qom-tree-get QAPI command, which fetches an entire tree of
>>>> properties and values with a single QAPI call.  This is much faster
>>>> than using qom-list plus qom-get for every node and property of the
>>>> tree.  See qom.json for details.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>   qapi/qom.json      | 56 ++++++++++++++++++++++++++++++++++++++++++
>>>>   qom/qom-qmp-cmds.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   2 files changed, 128 insertions(+)
>>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index 28ce24c..94662ad 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json

[...]

>>>> ##
>>>> +# @qom-tree-get:
>>>> +#
>>>> +# This command returns a tree of objects and their properties,
>>>> +# rooted at the specified path.
>>>> +#
>>>> +# @path: The absolute or partial path within the object model, as
>>>> +#     described in @qom-get
>>>> +#
>>>> +# Errors:
>>>> +#     - If path is not valid or is ambiguous, returns an error.
>>> 
>>> By convention, we use "If <condition>, <error>, where <error> is a
>>> member of QapiErrorClass.
>>
>> OK.  I was following the minimal Errors examples from this same file.
>
> Yup.  I'll clean them up.

I changed my mind.

Omitting ", <error>" is fairly common, actually.  I don't feel like
chasing down the actual error classes.  Moreover, documenting error
classes we don't want people to use seems counterproductive.

Feel free to just delete ", returns an error." and call it a day.

[...]



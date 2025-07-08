Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783C9C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGHV-00038c-3p; Tue, 08 Jul 2025 17:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZFTe-0007i8-Bj
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZFTa-0005Tn-Fw
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752008620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGNEdukx/ufZOsXYGrbvDF37eR6Pq/To/jzZNjCDQ6k=;
 b=HyeEGu/v+RC0MVxZ98kr2R05x9vp2PiKFy/2SiexeL3FH/QAzc2++8MhgRVcHN/z99zJh3
 mApOJd8iOJLgLDu0aaZoLUkdTsaXw3PzUo0r90WMMl2j01LkZSSUcZtj3RORHq2Go+6H+H
 Vzn1/5h6/5bERZOrVyoyE4iX2QyfqUQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-tT2NIpFlMw20657iMmeLbA-1; Tue,
 08 Jul 2025 00:41:36 -0400
X-MC-Unique: tT2NIpFlMw20657iMmeLbA-1
X-Mimecast-MFC-AGG-ID: tT2NIpFlMw20657iMmeLbA_1751949695
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73E741944AA9; Tue,  8 Jul 2025 04:41:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D73E51803AF2; Tue,  8 Jul 2025 04:41:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2CC7821E6A27; Tue, 08 Jul 2025 06:41:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Peter Krempa <pkrempa@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH V2 4/5] qom: qom-list-getv
In-Reply-To: <282efc8a-c37e-4afe-8e1e-f28436e74efe@oracle.com> (Steven
 Sistare's message of "Mon, 7 Jul 2025 10:40:23 -0400")
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-5-git-send-email-steven.sistare@oracle.com>
 <874ivsno15.fsf@pond.sub.org>
 <282efc8a-c37e-4afe-8e1e-f28436e74efe@oracle.com>
Date: Tue, 08 Jul 2025 06:41:32 +0200
Message-ID: <87frf71egz.fsf@pond.sub.org>
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

> On 7/4/2025 8:22 AM, Markus Armbruster wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Define the qom-list-getv command, which fetches all the properties and
>>> values for a list of paths.  This is faster than qom-tree-get when
>>> fetching a subset of the QOM tree.  See qom.json for details.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   qapi/qom.json      | 34 ++++++++++++++++++++++++++++++++++
>>>   qom/qom-qmp-cmds.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 74 insertions(+)
>>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 94662ad..dc710d6 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -62,6 +62,16 @@
>>>               '*value': 'any' } }
>>>   
>>>  ##
>>> +# @ObjectPropertiesValues:
>>> +#
>>> +# @properties: a list of properties.
>>> +#
>>> +# Since 10.1
>>> +##
>>> +{ 'struct': 'ObjectPropertiesValues',
>>> +  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
>>> +
>>> +##
>>>  # @ObjectNode:
>>>  #
>>>  # @name: the name of the node
>>> @@ -158,6 +168,30 @@
>>>     'allow-preconfig': true }
>>>   
>>>  ##
>>> +# @qom-list-getv:
>>> +#
>>> +# This command returns a list of properties and their values for
>>> +# each object path in the input list.
>> 
>> Imperative mood, please: "Return a list of ..."
>
> OK.  (I followed the style of qom-get and qom-list).

Yup.  We have a few more elsewhere.  I'll clean them up.

[...]



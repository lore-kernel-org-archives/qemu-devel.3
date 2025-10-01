Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E02CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 04:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3opy-0004zs-Ew; Wed, 01 Oct 2025 00:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3opv-0004zY-U5
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 00:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3oph-0006zs-Ky
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 00:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759294363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/wIzqBPlmC9+Gh20BlzJ87rI/2ufbG8UI3yR1nk8O8o=;
 b=cFBWKLqYGi0dimlp7jyRnfGY4gJR4bOdU/iuhyZ9c6B3VmUYr/Uab6ZMzkTGq8cKtRDgQ4
 1l2omD6xdKA2bBS6F5vafrymLJSR0mHwG9IateBjHMYAPD6oj9wdbtyJycup0yejDuX/Wc
 1XD3sp+P0/ReWV3Zw1MuZ2hi8BJZBHQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-Q9YFJy74PYCElTEiFUuz8w-1; Wed,
 01 Oct 2025 00:52:42 -0400
X-MC-Unique: Q9YFJy74PYCElTEiFUuz8w-1
X-Mimecast-MFC-AGG-ID: Q9YFJy74PYCElTEiFUuz8w_1759294361
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77B961800290; Wed,  1 Oct 2025 04:52:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E055119560B4; Wed,  1 Oct 2025 04:52:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A50621E6A27; Wed, 01 Oct 2025 06:52:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,  mjrosato@linux.ibm.com,  thuth@redhat.com,
 alex.williamson@redhat.com
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
In-Reply-To: <5ebeb8ec-395b-46ca-b6d4-b2c78ae0465f@linux.ibm.com> (Farhan
 Ali's message of "Tue, 30 Sep 2025 10:15:28 -0700")
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com>
 <87qzvtstd7.fsf@pond.sub.org>
 <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com>
 <87ms6gmo4j.fsf@pond.sub.org>
 <4207529b-a0a5-4360-8449-f4c20661e9e8@redhat.com>
 <0c221734-5faf-4829-bc17-21ec96a91fa5@linux.ibm.com>
 <87qzvo9tzk.fsf@pond.sub.org>
 <5ebeb8ec-395b-46ca-b6d4-b2c78ae0465f@linux.ibm.com>
Date: Wed, 01 Oct 2025 06:52:38 +0200
Message-ID: <87y0pv2pgp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Farhan Ali <alifm@linux.ibm.com> writes:

> On 9/30/2025 2:20 AM, Markus Armbruster wrote:
>> Farhan Ali <alifm@linux.ibm.com> writes:
>>
>>> On 9/27/2025 12:05 AM, C=C3=A9dric Le Goater wrote:
>>>> On 9/27/25 07:59, Markus Armbruster wrote:

[...]

>>>>> * Is the comment still accurate?
>>>
>>> This comment would still apply for vfio-pci devices on other architectu=
res except for s390x. We are trying to change this behavior for s390x.
>>
>> The comment is about things that should be done to handle the error.
>> Would these things be done here, or in a suitable ->err_handler()?
>
> Ideally in the err_handler(). And for s390x we try do what the comment me=
ntions, which is inject the error into the guest through s390x architecture=
 specific mechanism. I can remove the comment block.

Well, if there's stuff left to do, a comment outlining it is desirable.
If I understand you correctly, then the one we have is no longer
accurate.  Could you update it, so it is?

[...]



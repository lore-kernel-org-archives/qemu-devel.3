Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59F3CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 08:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5gB7-0002hn-OG; Mon, 06 Oct 2025 04:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v5gB6-0002hX-It
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 04:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v5gB4-0006mh-Lx
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 04:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759737756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=YUGZCDjFEctRT6cVSUMTWaPKAksh+FjTiipPbWAtEPE=;
 b=K5Os+6xKCuAOWZHSKphC8WGZEHjAhC5eT9CMbT1jr9c+gPOEx1/VoWOBu+GSWMQ9tZxNoM
 ZQH2AbPx+a9aaXnWmWo1uZpyEAKpTJZxXegenf0It9QhkYzk/sJM5hbLD5gvdn1B1IZkdZ
 Q5kLCxpVVDGAFM1BBC8hvNo/F+oH/Ro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-dJhxRP7xOgmSufAvO5PKBA-1; Mon,
 06 Oct 2025 04:02:33 -0400
X-MC-Unique: dJhxRP7xOgmSufAvO5PKBA-1
X-Mimecast-MFC-AGG-ID: dJhxRP7xOgmSufAvO5PKBA_1759737752
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6387C1800343; Mon,  6 Oct 2025 08:02:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B16B91956056; Mon,  6 Oct 2025 08:02:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0792021E6A27; Mon, 06 Oct 2025 10:02:29 +0200 (CEST)
Resent-To: alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 06 Oct 2025 10:02:29 +0200
Resent-Message-ID: <87frbwpiei.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,  mjrosato@linux.ibm.com,  thuth@redhat.com,
 alex.williamson@redhat.com
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
In-Reply-To: <d2dd6aaa-69b5-49ca-bcd1-36d43334b5fe@linux.ibm.com> (Farhan
 Ali's message of "Wed, 1 Oct 2025 11:21:11 -0700")
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com>
 <87qzvtstd7.fsf@pond.sub.org>
 <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com>
 <87ms6gmo4j.fsf@pond.sub.org>
 <4207529b-a0a5-4360-8449-f4c20661e9e8@redhat.com>
 <0c221734-5faf-4829-bc17-21ec96a91fa5@linux.ibm.com>
 <87qzvo9tzk.fsf@pond.sub.org>
 <5ebeb8ec-395b-46ca-b6d4-b2c78ae0465f@linux.ibm.com>
 <87y0pv2pgp.fsf@pond.sub.org>
 <d2dd6aaa-69b5-49ca-bcd1-36d43334b5fe@linux.ibm.com>
Date: Mon, 06 Oct 2025 08:06:35 +0200
Message-ID: <87cy70r2c4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 9/30/2025 9:52 PM, Markus Armbruster wrote:
>> Farhan Ali <alifm@linux.ibm.com> writes:
>>
>>> On 9/30/2025 2:20 AM, Markus Armbruster wrote:
>>>> Farhan Ali <alifm@linux.ibm.com> writes:
>>>>
>>>>> On 9/27/2025 12:05 AM, C=C3=A9dric Le Goater wrote:
>>>>>> On 9/27/25 07:59, Markus Armbruster wrote:
>>
>> [...]
>>
>>>>>>> * Is the comment still accurate?
>>>>>
>>>>> This comment would still apply for vfio-pci devices on other architec=
tures except for s390x. We are trying to change this behavior for s390x.
>>>
>>>> The comment is about things that should be done to handle the error.
>>>> Would these things be done here, or in a suitable ->err_handler()?
>>>
>>> Ideally in the err_handler(). And for s390x we try do what the comment =
mentions, which is inject the error into the guest through s390x architectu=
re specific mechanism. I can remove the comment block.
>>
>> Well, if there's stuff left to do, a comment outlining it is desirable.
>> If I understand you correctly, then the one we have is no longer
>> accurate.  Could you update it, so it is?
>>
>> [...]
>>
> How about something like this?
>
> We can retrieve the error details and decide what action needs to be take=
n in err_handler(). One of the actions could be to pass the error to the gu=
est and have the guest driver recover from the error. This requires that PC=
Ie capabilities be exposed to the guest. If err_handler() is not implemente=
d/fails, we just terminate the guest to contain the error.

Looks good to me.  I lack the expertise to really judge.



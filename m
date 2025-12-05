Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614D7D2E009
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRPam-0002ZG-Ff; Fri, 05 Dec 2025 01:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRPaj-0002Ys-KI
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRPah-0004VL-KN
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764917213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9TIULzHZ+/aPStUjHpAud9RvJt46Xfv6HIwan4IJmU=;
 b=UmYxmtAF8UcTHc/eKECdwaqlfBSb0kMk7jHDmCXdiu4C7rFM3z/HWrLvXwaWUrR105i24c
 YJhztqo9l6MSNnaKV+36ZZT/LjtcWZCFKqaYBkP+182OpbkQYRmUR0JBLvRUfkeS2aB+Ob
 mxAFAAs4EZVDelKJpHPK2hhAEo3QjTU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-FIgp6_MpMMeVsInsRsWxdw-1; Fri,
 05 Dec 2025 01:46:50 -0500
X-MC-Unique: FIgp6_MpMMeVsInsRsWxdw-1
X-Mimecast-MFC-AGG-ID: FIgp6_MpMMeVsInsRsWxdw_1764917208
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08AE518002ED; Fri,  5 Dec 2025 06:46:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDB741800577; Fri,  5 Dec 2025 06:46:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 44AAE21E6A27; Fri, 05 Dec 2025 07:46:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Ben Chaney <bchaney@akamai.com>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex@shazbot.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Stefan Weil <sw@weilnetz.de>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Hamza Khan <hamza.khan@nutanix.com>,  Mark Kanda <mark.kanda@oracle.com>,
 Joshua Hunt <johunt@akamai.com>,  Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v3 6/8] tap: cpr support
In-Reply-To: <CACGkMEs0cNNYewaEnMVVWr8ng4kRJGotqwk5O1z1fs4BTnzPhQ@mail.gmail.com>
 (Jason Wang's message of "Fri, 5 Dec 2025 08:51:43 +0800")
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
 <20251203-cpr-tap-v3-6-3c12e0a61f8e@akamai.com>
 <874iq6mzx5.fsf@pond.sub.org>
 <CACGkMEs0cNNYewaEnMVVWr8ng4kRJGotqwk5O1z1fs4BTnzPhQ@mail.gmail.com>
Date: Fri, 05 Dec 2025 07:46:44 +0100
Message-ID: <877bv11l4b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Jason Wang <jasowang@redhat.com> writes:

> Hi Markus,
>
> On Thu, Dec 4, 2025 at 4:09=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Ben Chaney <bchaney@akamai.com> writes:
>>
>> > From: Steve Sistare <steven.sistare@oracle.com>
>> >
>> > Provide the cpr=3Don option to preserve TAP and vhost descriptors duri=
ng
>> > cpr-transfer, so the management layer does not need to create a new
>> > device for the target.
>> >
>> > Save all tap fd's in canonical order, leveraging the index argument of
>> > cpr_save_fd.  For the i'th queue, the tap device fd is saved at index =
2*i,
>> > and the vhostfd (if any) at index 2*i+1.
>> >
>> > tap and vhost fd's are passed by name to the monitor when a NIC is hot
>> > plugged, but the name is not known to qemu after cpr.  Allow the manag=
er
>> > to pass -1 for the fd "name" in the new qemu args to indicate that QEMU
>> > should search for a saved value.  Example:
>> >
>> >   -netdev tap,id=3Dhostnet2,fds=3D-1:-1,vhostfds=3D-1:-1,cpr=3Don
>>
>> Hmm.  See below.
>>
>> >
>> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> > Signed-off-by: Ben Chaney <bchaney@akamai.com>
>>
>> [...]
>>
>> > diff --git a/qapi/net.json b/qapi/net.json
>> > index 118bd34965..264213b5d9 100644
>> > --- a/qapi/net.json
>> > +++ b/qapi/net.json
>> > @@ -355,6 +355,8 @@
>>    ##
>>    # @NetdevTapOptions:
>>    #
>>    # Used to configure a host TAP network interface backend.
>>    #
>>    # @ifname: interface name
>>    #
>>    # @fd: file descriptor of an already opened tap
>>    #
>>    # @fds: multiple file descriptors of already opened multiqueue capable
>>    #     tap
>>
>> Not this patch's fault: the interface is misguided, and its
>> documentation inadequate.
>>
>> @fds is a string of file descriptor names or numbers separated by ':'.
>> Not documented.  I found out by reading the code.
>>
>> This violates QAPI design principle "no string parsing".  It should be
>> an array of strings.
>>
>
> I agree with your concern. Just a note that this "fds" was introduced
> before QAPI if I am not wrong.

It's from 2013 (commit 264986e2c8f).  QAPI was still young then
(netdev_add had been QAPIfied less than a year ago), we had much to
learn, and interface review barely happened.  All understandable, and no
reason to throw shade on anyone involved :)



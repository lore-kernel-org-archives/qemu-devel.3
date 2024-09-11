Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91159EE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPQA-0007cO-7M; Wed, 11 Sep 2024 11:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1soPQ9-0007WN-6x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:38:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1soPQ7-0004GC-Ev
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726069093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d77J+34o2hbXYcWKv4p7sXHEjN5agx8MwMPMnZzMtiI=;
 b=AGMYbe0ohJXhTZNUSBdq9rQb9A8Ez0po5FzvL+QfuT/Z5DkTIh+5khddilfPA8qDVOPIyr
 4LBkm6mOzZcuRbzIpysaWmXf0qXjNJkunFoH2FPeFjXCBcgJ/gON0ho9JKljq+j2KGII0k
 xmFjoQymptAeXTga1/VfgKVeVZJ8gg4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-Wg9s8VapNA6FwyP0tBDJCw-1; Wed,
 11 Sep 2024 11:38:09 -0400
X-MC-Unique: Wg9s8VapNA6FwyP0tBDJCw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3D2C1944B2B; Wed, 11 Sep 2024 15:38:06 +0000 (UTC)
Received: from localhost (unknown [10.39.195.16])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 299311956086; Wed, 11 Sep 2024 15:38:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v1 00/14] s390x: virtio-mem support
In-Reply-To: <20240911100415-mutt-send-email-mst@kernel.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240910175809.2135596-1-david@redhat.com>
 <4429b29a-a022-4507-a358-1a16b5032395@linux.ibm.com>
 <9dc58bde-7979-4ffb-9ba7-a501d9fcc416@redhat.com>
 <20240911100415-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 11 Sep 2024 17:38:02 +0200
Message-ID: <871q1qurol.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11 2024, "Michael S. Tsirkin" <mst@redhat.com> wrote:

>> > 
>> > I'd rather have it in a shared and bigger repo than in your personal
>> > gitlab one. Maybe there's a space somewhere in QEMU or the Virtio team's
>> > repos that would be a good fit if the kernel's docu isn't the right place?
>> 
>> At this point, outside of kernel/QEMU feels like the right thing to do.
>> Conny is already a co-maintainer of my "personal" (;)) gitlab.
>> 
>> 
>> And now I realize that I CCed Heiko on the Linux series but not the QEMU
>> series. My bad.
>> 
>> [1] https://lore.kernel.org/all/20200727114819.3f816010.cohuck@redhat.com/
>
>
> No prob. Or if you want it in virtio spec, that's also fine.

The virtio spec makes sense for documenting things needed to implement
it, but what I liked about the gitlab project is that it tries to go
into more s390-specific aspects (that feel a bit out of scope for the
virtio spec), and that it provides a place to document non-virtio
related interfaces.

Anyway, if we want to proceed with the gitlab project, would it make
sense to create an org for it, so that it doesn't look like David's
personal project? In any case, while I'm happy to stay on, I'm not that
involved with s390 anymore, and it might make sense to add more people
to it.



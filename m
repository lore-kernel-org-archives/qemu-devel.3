Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AEAC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzhJ-0001QD-Da; Tue, 07 Jul 2026 02:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wgzhI-0001PP-Pv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wgzhH-0004u0-Eb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783407262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JgepxbO0PrlH/mJkonyzrlmU03jNWgDYZP6euDZ8EhY=;
 b=IjOpAB8Ofh4D1NM+Yl/uWA0NW+mTxez0UxlOfCHGQBV7JjiHJMYchxFnyBRw1IKOe1HdG4
 Vp5DtKFO6VZISzUzB19fYj7dRPpl6ZFN+8gthLY/nLi1EmOW0aGW0Vk+kLw6btvTaicbKP
 HWWahDlaPvXm2Qp32IjwF7Eyjn9xYmc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-5neTasHcNbCeaL3_xpMACA-1; Tue,
 07 Jul 2026 02:54:17 -0400
X-MC-Unique: 5neTasHcNbCeaL3_xpMACA-1
X-Mimecast-MFC-AGG-ID: 5neTasHcNbCeaL3_xpMACA_1783407255
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4363180130E; Tue,  7 Jul 2026 06:54:15 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19FE43000C06; Tue,  7 Jul 2026 06:54:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH 0/5] s390x: interface hardening fixes
In-Reply-To: <4a383828-7488-4160-b46b-36f3a3f37b77@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <87pl10jgmk.fsf@redhat.com>
 <4a383828-7488-4160-b46b-36f3a3f37b77@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 07 Jul 2026 08:54:12 +0200
Message-ID: <87mrw3jnmz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 06 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 06.07.26 um 17:13 schrieb Cornelia Huck:
>> On Mon, Jul 06 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
>> 
>>> Several fixes that improve the guest->host error handling.
>>>
>>> Christian Borntraeger (1):
>>>    s390x/sclp: reject invalid write event data headers
>>>
>>> Eric Farman (1):
>>>    s390x/css: limit number of CHPIDs in description
>>>
>>> Matthew Rosato (3):
>>>    s390x/pci: Tighten region detection for BAR read/write
>>>    s390x/pci: Shrink RPCIT ranges to registered window
>>>    s390x/ioinst: Require strict length and format for SEI CHSC handler
>>>
>>>   hw/s390x/css.c            | 17 +++++++++++++++++
>>>   hw/s390x/event-facility.c |  6 ++++++
>>>   hw/s390x/s390-pci-inst.c  | 32 ++++++++++++++++++++++++++++++--
>>>   target/s390x/ioinst.c     | 20 ++++++++++++++++++++
>>>   4 files changed, 73 insertions(+), 2 deletions(-)
>> 
>> I think the patches from other people are missing your s-o-b?
>> 
>
> Right. I guess I must re-send them, we cannot "heal" the patches by
> Adding
> Christian Borntraeger <borntraeger@linux.ibm.com>

A quick resend would be easier for me.



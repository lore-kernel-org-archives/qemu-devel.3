Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066CECEDDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLN5v-0006T5-RL; Tue, 18 Nov 2025 09:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLN5r-0006R8-RU
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:54:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLN5p-0002TM-Ub
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763477644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nxJjYK5sf1aycLpPfldsgzDRteDgbc4TdlfACYYT/j8=;
 b=WBV3B0Wbav2SncF2XxKXPh3C9EQwdf88kVvNTYVHf9dJ4/+gBSur+nCiQZSHVF2PeK9N4s
 FwcsFWvIGbYCUVXlILYb4qvq3Te+Z1IqvoZsoQ5dxHw6q+UmXHUxTuMIucJyLv73rmOK76
 a54izI7tsGTPhoQBgsGV+VzSyvirqaE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-Xu2FjxofNqCixfYGJaE5TA-1; Tue,
 18 Nov 2025 09:54:00 -0500
X-MC-Unique: Xu2FjxofNqCixfYGJaE5TA-1
X-Mimecast-MFC-AGG-ID: Xu2FjxofNqCixfYGJaE5TA_1763477638
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D1D218002D6; Tue, 18 Nov 2025 14:53:58 +0000 (UTC)
Received: from localhost (dhcp-192-224.str.redhat.com [10.33.192.224])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FC3519560B0; Tue, 18 Nov 2025 14:53:57 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand
 <david@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Halil
 Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
In-Reply-To: <20251118152411.37a06f7a.pasic@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251118093945.35062-1-thuth@redhat.com>
 <20251118130218.30d3da33.pasic@linux.ibm.com>
 <50f79156-dd93-40c4-831e-66e558531be8@redhat.com>
 <20251118152411.37a06f7a.pasic@linux.ibm.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 18 Nov 2025 15:53:55 +0100
Message-ID: <87ecpvqtmk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
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

On Tue, Nov 18 2025, Halil Pasic <pasic@linux.ibm.com> wrote:

> Hm, the -EINVAL is put into GPR2 which is 'Host Cookie' according to the
> virtio specification:
> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-2260002
>
> Unfortunately, I did not find any words in the spec according to which
> GPR2 can be used to indicate errors. There does seem to be handling in
> the linux driver for that. It basically says negative is bad, but I can't
> see that in the spec. It just says "For each notification, the driver
> SHOULD use GPR4 to pass the host cookie received in GPR2 from the previous
> notification."
>
> Maybe we want to update the spec to reflect what is in the filed.

Saying that the driver SHOULD check GPR2 for negative error values is
probably fine, since it matches what is already out
there. (Unfortunately, we can't mandate it without either a new feature
bit or a new revision, and that would be overkill IMHO.)

For the device, we say "The device MAY return a 64-bit host cookie in
GPR2 to speed up the notification execution." -- the spec should
probably also say that the device MAY return a negative error code.



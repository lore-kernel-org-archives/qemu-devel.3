Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABB6CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxli-0003oi-09; Fri, 29 May 2026 10:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxld-0003nA-64
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wSxlb-0006tZ-43
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780063250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwdXh824kP+j9SBL7IEbD6J46bZ3P0kQRlPXbipqwBk=;
 b=YDttStkGVowJmTN1Ouuhb0+vmKjeQoinEfohkTGeXnWWhJcWwVOrr0ORrZjAXROxcRiX5m
 BJ0sVwHE3Yw7arhjkzuCroaEmHL3vykjIh1WBfsgmHglL62QhQvy0JvDC5LRwLfcdX4GN9
 HEyKK/9NTESy0GuqUa1ETgTHHNIyXGM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-qmk_69ZBOkav-QSwo9qotw-1; Fri,
 29 May 2026 10:00:43 -0400
X-MC-Unique: qmk_69ZBOkav-QSwo9qotw-1
X-Mimecast-MFC-AGG-ID: qmk_69ZBOkav-QSwo9qotw_1780063237
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 526A91956053; Fri, 29 May 2026 14:00:37 +0000 (UTC)
Received: from localhost (unknown [10.67.32.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB48319560A3; Fri, 29 May 2026 14:00:35 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Alexandra Winter <wintera@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
 Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@kernel.org>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 qemu-s390x@nongnu.org, Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH] target/s390x: Make container ids in SysIB_15x 1-based
In-Reply-To: <20260511134909.43802-1-wintera@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260511134909.43802-1-wintera@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 29 May 2026 16:00:30 +0200
Message-ID: <878q92mi2p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, May 11 2026, Alexandra Winter <wintera@linux.ibm.com> wrote:

> The Container Id in a container-type TLE of SysIB_15x is defined as 8-bit
> unsigned nonzero integer. Make stsi fc 15 emulation architecture compliant,
> by starting the container ids at 1 for the lowest numbered container.
>
> The qemu misbehaviour without this patch becomes obvious due to a recently
> proposed kernel fix. Older linux kernels pass the container ids from stsi
> fc15 unchanged to sysfs, i.e. starting at 1 on s390 hardware. This resulted
> in off-by-one values when compared to the values from HMC. A Linux kernel
> fix is being proposed to correct the sysfs topology ids by -1, so they
> start at 0, e.g. when displayed by 'lscpu -ye'. In case a KVM guest with a
> fixed kernel runs on a host with a qemu without this fix, this can result
> in container ids erroneously being shown as 255.
> Example (Fixed guest on unfixed qemu):
> $ lscpu -ye
> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>   0    0    255  255    255    0 0:0:0         yes yes        vert-medium  0
>   1    0    255  255      0    1 1:1:1         yes yes        vert-medium  1
> After this fix:
> $ lscpu -ye
> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>   0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
>   1    0      0    0      1    1 1:1:1         yes yes        vert-medium  1
>
> Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  target/s390x/kvm/stsi-topology.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks, queued to s390-next.



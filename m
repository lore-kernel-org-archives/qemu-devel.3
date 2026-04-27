Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B029FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHGNp-0007zD-Js; Mon, 27 Apr 2026 03:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wHGNl-0007yI-Ph
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wHGNk-0002an-BM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 03:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777274870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YI7VnGYQ1t7aqANYAoPcMrk+7GXjMQP8Gv/S/7Q6WN8=;
 b=YU8Ii8V8gXPXgA+bvwLr3FnjUy8NlvwsY2GRuirKIzYDGtF5oRagLLNAXEgfB5Va1GgNHw
 9JfuOYKYoy+QfiyiiSDw6Tqv3bhfgeVJHBaxvwwp9mlm1zcSbBW7WYUYr62KeW7ElaH/n5
 xyw79YrvODrG3OR3+rtVi6UgRlQePYA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-hgwqu1wkMN6vkkBHlMPrpA-1; Mon,
 27 Apr 2026 03:27:47 -0400
X-MC-Unique: hgwqu1wkMN6vkkBHlMPrpA-1
X-Mimecast-MFC-AGG-ID: hgwqu1wkMN6vkkBHlMPrpA_1777274864
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DABC1956054; Mon, 27 Apr 2026 07:27:44 +0000 (UTC)
Received: from localhost (unknown [10.44.33.83])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4994F3000709; Mon, 27 Apr 2026 07:27:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao
 Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH for-11.1] hw: add compat machines for 11.1
In-Reply-To: <85948999-6dcb-4f36-8450-ab74ebb35e3d@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260331140347.653404-1-cohuck@redhat.com>
 <85948999-6dcb-4f36-8450-ab74ebb35e3d@linaro.org>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Mon, 27 Apr 2026 09:27:39 +0200
Message-ID: <87h5owsw0k.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 24 2026, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi Connie,
>
> On 31/3/26 16:03, Cornelia Huck wrote:
>> Add 11.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.
>>=20
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   hw/arm/virt.c              |  9 ++++++++-
>>   hw/core/machine.c          |  3 +++
>>   hw/i386/pc.c               |  3 +++
>>   hw/i386/pc_piix.c          | 13 +++++++++++--
>>   hw/i386/pc_q35.c           | 13 +++++++++++--
>>   hw/m68k/virt.c             |  9 ++++++++-
>>   hw/ppc/spapr.c             | 15 +++++++++++++--
>>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>>   include/hw/core/boards.h   |  3 +++
>>   include/hw/i386/pc.h       |  3 +++
>>   10 files changed, 76 insertions(+), 9 deletions(-)
>
> I'll take this patch in my next PR to avoid another conflict
> with your tree.

Yes, whichever one goes first.



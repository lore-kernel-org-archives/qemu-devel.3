Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599EAF436B5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkuR-0001GU-9C; Fri, 17 Apr 2026 11:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wDkuK-0001CH-Bs
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wDkuI-00007e-1h
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776438895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6b1r//k0ik/pzvE7CIcClrrkckDHJaNGITsN2SHNBs=;
 b=Mv/nK3rhtFO1gkFFM8cQo77iKFN1UG+PSnQUS3ZUQlfLngeyPTJuYQBj0N6sgb2IzEDJ3/
 qKPPFhGxTdqZM6//yfR1UMaVZ5A83xkZ0Ka522+jiUz95RLHX6GNE/SXzNkoUINDS2qygn
 JfeblIy6WFA7LTL+na/GZN4FRqzMILc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-N2zEhCHkN9y7Cvo_wyyCSA-1; Fri,
 17 Apr 2026 11:14:50 -0400
X-MC-Unique: N2zEhCHkN9y7Cvo_wyyCSA-1
X-Mimecast-MFC-AGG-ID: N2zEhCHkN9y7Cvo_wyyCSA_1776438889
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAA6819560A2; Fri, 17 Apr 2026 15:14:48 +0000 (UTC)
Received: from localhost (unknown [10.44.48.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39CF91800351; Fri, 17 Apr 2026 15:14:46 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>, Eric Farman
 <farman@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, David Hildenbrand <david@kernel.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/5] target/s390x: Forbid to use legacy ldst_phys() API
In-Reply-To: <20260319185203.11799-1-philmd@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260319185203.11799-1-philmd@linaro.org>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 17 Apr 2026 17:14:44 +0200
Message-ID: <87wly5ty8r.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Mar 19 2026, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Replace legacy ld/st_phys() by address_space_ld/st()
> then lock the target again further legacy API uses.
>
> Philippe Mathieu-Daud=C3=A9 (5):
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
>   configs/targets: Restrict the legacy ldst_phys() API on s390x target
>
>  configs/targets/s390x-softmmu.mak |  1 +
>  target/s390x/cpu-system.c         |  2 +-
>  target/s390x/kvm/kvm.c            | 12 ++++++++----
>  target/s390x/mmu_helper.c         |  5 +++--
>  target/s390x/tcg/excp_helper.c    | 21 +++++++++++++--------
>  target/s390x/tcg/mem_helper.c     | 12 +++++++-----
>  6 files changed, 33 insertions(+), 20 deletions(-)

Thanks, queued to s390-next.



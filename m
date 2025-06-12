Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C275C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjyi-0004hb-Ii; Thu, 12 Jun 2025 11:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uPjyg-0004bJ-4S
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uPjye-0000we-HG
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749742587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aN7OZ8GnoaJUynVwVsXnb6hzJQk2C53xbbNuavIdXdE=;
 b=SwKbuzroecdd7dBNRX3Klq/m0MmzMYjVNpA4NEHBRscvYpeikff07FmWlYNB2G28Y1mRO2
 Dc1uE168JFDiZOxMRKVUOFGnKHh5QLIgKb+v/BUGyzhm6KOhFz0UApYgZl4TpkGt9CwjM/
 FPqaPtxXgKk+bhaAdbFFae24r6ieF7E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-YKlXxlMZPkW2jWRmhKvNrA-1; Thu,
 12 Jun 2025 11:36:23 -0400
X-MC-Unique: YKlXxlMZPkW2jWRmhKvNrA-1
X-Mimecast-MFC-AGG-ID: YKlXxlMZPkW2jWRmhKvNrA_1749742581
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1DFD18011CD; Thu, 12 Jun 2025 15:36:20 +0000 (UTC)
Received: from localhost (unknown [10.45.224.54])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D06E230044CC; Thu, 12 Jun 2025 15:36:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com, agraf@csgraf.de, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v7 08/14] arm/cpu: Store id_isar0-7 into the idregs array
In-Reply-To: <CAFEAcA-c=EaE-Y4DMVz_meVd2cbxuCyFGFOXET-COOgMWHXWWA@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250515153907.151174-1-cohuck@redhat.com>
 <20250515153907.151174-9-cohuck@redhat.com>
 <CAFEAcA-c=EaE-Y4DMVz_meVd2cbxuCyFGFOXET-COOgMWHXWWA@mail.gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Thu, 12 Jun 2025 17:36:16 +0200
Message-ID: <87a56d9dlb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 12 2025, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 15 May 2025 at 16:40, Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  hw/intc/armv7m_nvic.c     |  12 ++--
>>  target/arm/cpu-features.h |  36 +++++-----
>>  target/arm/cpu.c          |  24 +++----
>>  target/arm/cpu.h          |   7 --
>>  target/arm/cpu64.c        |  28 ++++----
>>  target/arm/helper.c       |  14 ++--
>>  target/arm/kvm.c          |  21 ++----
>>  target/arm/tcg/cpu-v7m.c  |  90 +++++++++++++-----------
>>  target/arm/tcg/cpu32.c    | 144 +++++++++++++++++++++-----------------
>>  target/arm/tcg/cpu64.c    | 108 ++++++++++++++--------------
>>  10 files changed, 243 insertions(+), 241 deletions(-)
>
> This doesn't compile:
>
> ../../target/arm/tcg/cpu-v7m.c:70:5: error: incompatible pointer types
> initializing 'ARMISARe
> gisters *' (aka 'struct ARMISARegisters *') with an expression of type
> 'uint64_t *' (aka 'unsigned long *')
> [-Werror,-Wincompatible-pointer-types]
>    70 |     SET_IDREG(idregs, ID_ISAR0, 0x01141110);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../../target/arm/cpu.h:875:26: note: expanded from macro 'SET_IDREG'
>   875 |         ARMISARegisters *i_ = (ISAR);
>          \
>       |                          ^    ~~~~~~
> ../../target/arm/tcg/cpu-v7m.c:71:5: error: incompatible pointer types
> initializing 'ARMISARegisters *' (aka 'struct ARMISARegisters *') with
> an expression of type 'uint64_t *' (aka 'unsigned long *')
> [-Werror,-Wincompatible-pointer-types]
>    71 |     SET_IDREG(idregs, ID_ISAR1, 0x02111000);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../../target/arm/cpu.h:875:26: note: expanded from macro 'SET_IDREG'
>   875 |         ARMISARegisters *i_ = (ISAR);
>          \
>       |                          ^    ~~~~~~
>
> (and more similar errors until the compiler gives up).

What configs/compiler are you using? I obviously would have fixed that
if I had hit it...



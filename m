Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144D1E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 10:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tImRo-00076G-KZ; Wed, 04 Dec 2024 05:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tImRl-00075e-8u
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 05:17:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tImRi-0007ru-J9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 05:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733307444;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y91Af20oAgA7njdpzt56A/kMd4t46ji/mAYP+YHjdUM=;
 b=LPDpKtRZ+dbE02GyYvP+BGfHemVdiNKgnlpxDcSuEs2IYplozGbTeB3MKeSyjDl1A9Pjlp
 MEG0Q9wNQ1KwGT0hPSpNmwxapuagocCKKhZWzofwsouG9DVDC/mtMwW/IlvELZSYnHn3BE
 +sMq+zDsuMqAw9AkAUeFy9K/5g3GvNM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-tdWqcVniOLuAGYm7sgqDLg-1; Wed,
 04 Dec 2024 05:17:21 -0500
X-MC-Unique: tdWqcVniOLuAGYm7sgqDLg-1
X-Mimecast-MFC-AGG-ID: tdWqcVniOLuAGYm7sgqDLg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48C441955BFE; Wed,  4 Dec 2024 10:17:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4E7E19560A2; Wed,  4 Dec 2024 10:17:15 +0000 (UTC)
Date: Wed, 4 Dec 2024 10:17:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv <qemu-riscv@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 David Abdurachmanov <davidlt@rivosinc.com>, Mark Corbin <mark@dibsco.co.uk>
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,64} part of the same
 family
Message-ID: <Z1AsKNcbY2I46Tx1@redhat.com>
References: <20241203094702.124748-1-abologna@redhat.com>
 <cb079b65-e5fc-4667-aa63-9ff347666b6e@linaro.org>
 <Z07a_kYh4duwWKWw@redhat.com>
 <CAFEAcA8BAW4=Yk5q0CgQNL4UZpUJXiwRV6VD-52_Rw0SN=E1Cg@mail.gmail.com>
 <dc1b450a-f250-4b84-80bd-6f14888ce327@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc1b450a-f250-4b84-80bd-6f14888ce327@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Dec 03, 2024 at 07:57:14AM -0600, Richard Henderson wrote:
> On 12/3/24 04:35, Peter Maydell wrote:
> > On Tue, 3 Dec 2024 at 10:19, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > Separatley this from patch, we should also consider whether
> > > it is time to do the same for aarch64/arm7.
> > > 
> > > If I look at this page:
> > > 
> > >    https://gpages.juszkiewicz.com.pl/arm-socs-table/arm-socs.html
> > > 
> > > and sort by 'announced' to see msot recent CPUs first, then
> > > almost all of them have "NO" in the "aarch32 support" column.
> > > 
> > > IOW, on modern aarch64 CPUs, qemu-arm is the only viable way
> > > to run 32-bit usermode binaries AFAICT, and suggests we ought
> > > to be creating a binfmt rule for that on aarch64 hosts.
> > 
> > What happens if you have a host CPU that *does* support 32-bit
> > natively and you also register the binfmt rule? Does the
> > host kernel prefer to execute natively or does it invoke
> > QEMU? I don't think we want to roll out something that
> > silently downgrades native execution to emulation...
> 
> The registered rule applies and the kernel invokes qemu.

This is all quiet difficult from a distro POV, but not QEMU's fault.

We want to install the binfmt rules in a way that we "do the right thing"
regardless of hardware out of the box.

The systemd logic for loading binfmt rules is unconditional, loading
everything from /usr/lib/binfmt.d, but we need a way to make things
conditional on the lack of support for aarch32 on the currently running
platform.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF5AC982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rSE-0007SL-0W; Wed, 16 Sep 2026 11:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6rSA-0007RX-Ah
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6rS6-000822-Py
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789572095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSJGIG27EYd31hKDdOatx1+8waatuy+ER+YVNlaIKFg=;
 b=a0pWkFfBb+mch/pAGApP+9mOG6e4clW0KzKiamSzXBYB7oQU0M8FtZ4EMAvI7ZCS6duCO3
 okUIqq015g/wfjumAQJYE74mfO3WN9TYNuQsW3cfSHFEQiqEFLXjvs8rcGmmvlLA/fcx3W
 4pPFtXY15Ob/uhsNE70UrpAlTvx6zPQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-vvyYz6CMOpKa8HRMeVL4-Q-1; Wed, 16 Sep 2026 11:21:33 -0400
X-MC-Unique: vvyYz6CMOpKa8HRMeVL4-Q-1
X-Mimecast-MFC-AGG-ID: vvyYz6CMOpKa8HRMeVL4-Q_1789572092
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c295b027ee0so486186066b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789572092; x=1790176892; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RSJGIG27EYd31hKDdOatx1+8waatuy+ER+YVNlaIKFg=;
 b=KLq5e1NLxYpzLtFO0cS5b3QKVuCuwDmETORrMM9BpvjLLv8bM6TtM1JBgLcERlc8gP
 pMGcnVowf0QnxI3UPxQucfpeO7ubkmDuoNtYKfXId8KJFXFTnbimcJYXViyW84qznyr7
 Ng78fTLah1rOibCfcBclVBLgNJ8O5FYKsS6nauVmJnkoUef3S10v+aJh06P0KHXrSTJK
 licAMH8evDb+1K/LGglks68nNRxaOBIwxnt0Ec+XvwwTV4qTVijpYWtiJw1I0NgMW4fd
 IPxGTBBhDVIHABAOIM/Tmhk8R8C3fy/mwerFvxR8h7P8nk03cr1pXiehW/llQGNZyRnH
 c2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572092; x=1790176892;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RSJGIG27EYd31hKDdOatx1+8waatuy+ER+YVNlaIKFg=;
 b=vamoYZKfwRvVGTTb78+d5guOMSQCfUYOJ7OiUv6v6PvEkYA2rtoZ0Ff3iYZoYVv0ig
 e8PMboNjd/YpO5Y9ksMGk6/lbMb1geZvSd+y0Hhg5GwyNUZrSD5FaUG4dqKL1z4oX73g
 zPAvQQwkof72ZB/Pj2c5qxk1IQenOjyjNmyCPiq4DxvHzTDm4A5G/4XW/zeKr0idy5JC
 R6JGqdrghVcRqbbmYjmH3pXflNV1nznzpEkSqUFCrvAaH58h7kQxnsyVoGAPrZ8sMfk0
 P8nVaiNkvCjbqldvjr+w3wGb3qCSARBTq2uR3CM0EZaDB87JOrb250gYek2h8w4H6ANF
 sXJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+NzStxi7xCceNu87lzQNXjHHoaB3A3I/yTihuAhKavSWhxhSV80lE6RK47hPBYXltfMPg2iZlnW8L@nongnu.org
X-Gm-Message-State: AFuF++kVVXZv3envYj/PrkhQ/dOmGkt5WbXD7VygSXFZv8A529z98WAA
 TOQxhcIkORXEB6XT7QqDVAcCb8oz9f8HTMj5gExawrPCzJPVJRpgGIerw/GBVikqJYKyC/ttWW1
 VQN5WhaDJSPWzeS/zE6Q57VVQM07xAnN1zurK2rreEmi2Br+RWSXyOK7r
X-Gm-Gg: AYBFou0jOpCJvGncq2K4Mwa1mpbzOICDHKoYnj4Y8/2uzw5JPqoez532x/A/DFH1ld3
 cSfbWrfPPRrHyikiN6+3cPxkt498S1HeGPzX9dRgJOA191Xy1YM8YNlluld7c4nzhqM08uA8pEQ
 X9VQYM8NgL2EqdcGuPksjjRUbNFuTYzT0kXjvh1eFnjqTTcz3V/yc/YZTcxEvZ0K/TqIi0YfjML
 CTuZgj/8ClV7jxr6BWlP0IiWO6LBA2gteMoEut2CPz/wZ+DUauJSJEdzjkQOUo2fIczB7uWbt1I
 XNu8fVjfzGaHcxjLSjLmijp9JUIT9LUxWpM3OMD53psXvQM88Q4+zkT1CPXDORfpcPY7zuna2LI
 fjPvJXJyZX975cg9ORs504YQ=
X-Received: by 2002:a17:907:9804:b0:c29:3a1b:ec91 with SMTP id
 a640c23a62f3a-c29e5336eaemr421130466b.20.1789572092266; 
 Wed, 16 Sep 2026 08:21:32 -0700 (PDT)
X-Received: by 2002:a17:907:9804:b0:c29:3a1b:ec91 with SMTP id
 a640c23a62f3a-c29e5336eaemr421126166b.20.1789572091706; 
 Wed, 16 Sep 2026 08:21:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de487581sm154259066b.27.2026.09.16.08.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:21:30 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:21:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com
Subject: Re: [PATCH] util/error, hw/net/virtio-net: fix NULL pointer
 dereference in error_vprepend
Message-ID: <20260916111206-mutt-send-email-mst@kernel.org>
References: <500d4850-f7d7-45fb-91e5-74d32d35fde2@swemel.ru>
 <87h5jp8iqc.fsf@pond.sub.org>
 <410859ee-80a6-41f1-8b40-7e5014a6bd10@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <410859ee-80a6-41f1-8b40-7e5014a6bd10@swemel.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 16, 2026 at 04:48:19PM +0300, Николай Зорин wrote:
> Hello!
> 
> This is not AI-generated content. We have a dedicated team of engineers who
> monitor and analyze security events (ranging from ASan/TSan sanitizers to
> PVS-Studio) and perform statistical analysis (from cppcheck to SVACE and
> white bear). This is a strict requirement from our Quality Assurance
> department, which is mandatory for compliance with our government and
> commercial contracts. Unfortunately, I cannot share our internal security
> tools (especially since they are tailored to our environment and won't work
> for you). However, I can share what our engineers flag as potentially
> dangerous cases during their research. Since the patches we submit address
> long-standing vulnerabilities, we have to maintain them on our side for
> years, as they rarely get fixed in your upstream. If you think these
> findings are outdated or redundant, fine.

I don't know. The patches aren't documented to the level where I can
pass judgement. what there is, does not match code.

"We have an internal tool that flags this code as a bug, I'm not telling
you what it is and I have no idea if the patch is right, it makes my
tool shut up and my government happy, figure the rest out yourself" is
not how any of this works.

If you think your changes are important, work with your dedicated team
to figure out how to be prepared to defend them in public.

Good format to follow:

At the moment .... as a result ... but ... so ... and we can not ...
Fix this by ... as a result ...



> I'll try to convince our
> researchers to drop it—letting them know that the upstream developers
> consider this work completely unnecessary.

I merely consider it incomplete and poorly documented.

> P.S. We are backporting these from Debian 10 (even though the current
> release is Debian 13).

Shrug. This is not the tree against which qemu-devel patches are
supposed to be against.

> P.P.S. I used AI for correcting translate (I not good knowled english)
> 
> nice day
> 
> 16.09.2026 15:48, Markus Armbruster пишет:
> > First, please read docs/devel/code-provenance.rst section "Use of
> > AI-generated content".
> > 
> > I'm not looking at the patches, only the commit message.
> > 
> > Николай Зорин <zorin@swemel.ru> writes:
> > 
> > > SWSA#b0709cee-9722-4603-a30c-dc857dc87961
> > > 
> > > The `error_vprepend()` function modifies the error message inside an
> > > existing Error object. However, it only validated if the `errp` pointer
> > > itself was non-NULL, missing a check for whether the underlying Error
> > > object `*errp` is `NULL`.
> > This is nonsense.  error_vprepend() and error_prepend() modify an error.
> > They must not be called when there is none.  The check isn't missing.
> > Adding it makes the functions "work" papers over bugs.
> > 
> > > Calling `error_reportf_err(local_error, ...)` when `local_error` is `NULL`
> > > invokes `error_vprepend(&local_error, ...)`, which subsequently crashes
> > > via a `NULL` pointer dereference during `(*errp)->msg` access.
> > > 
> > > Fix `util/error.c` by adding a defensive `!*errp` check inside
> > > `error_vprepend()`.
> > > 
> > > Additionally, fix the invalid error reporting patterns in
> > > `hw/net/virtio-net.c`:
> > > - In `vhost_user_net_save_state()` and `vhost_user_net_load_state()`, when
> > >     `vhdev == NULL`, calling `error_reportf_err()` with an unallocated/NULL
> > >     `local_error` is incorrect and unsafe. Replace it with a straightforward
> > >     `error_report()` call.
> > Both uses of error_reportf_err() are indeed wrong.
> > 
> > > - Fix a cosmetic double-space typo in "Error loading  back-end state".
> > Worth cleaning up.
> > 
> > > Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5140C4829C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYNO8-0004A0-Ux; Fri, 09 Feb 2024 04:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYNO7-00049l-3S
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYNO5-0008Jk-9t
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707471696;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmELvTX2kcxxQwjmVY59ESHt1qZebZ5TsAxoUzqNcnI=;
 b=Es7GxAAagWLKfQwhrEbQCVaWFNB/L0R5C7H4EQKCyrJnoYOBOVeDx5QUi5sW8LBQpJsMCr
 ZiIQdU2cFN6Qz5RGzCBwBgdZcf9C9NQmlcOhOaONRkJZqSMCpSVqPv968qrQf0pZRmeW+E
 wrpwblnFsxQ/++Zp+IFYRUUCBku+F7k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-T6Ifrmr-MuG44yRc6e5suQ-1; Fri,
 09 Feb 2024 04:41:32 -0500
X-MC-Unique: T6Ifrmr-MuG44yRc6e5suQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94C5938135F5;
 Fri,  9 Feb 2024 09:41:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00247AC1F;
 Fri,  9 Feb 2024 09:41:31 +0000 (UTC)
Date: Fri, 9 Feb 2024 09:41:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Schmitt <richard.schmitt@starlab.io>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Unit Test Aborts when building with -ftrapv compiler option
Message-ID: <ZcXzSjbO0AMuzqGZ@redhat.com>
References: <DM6PR09MB528878EFFA4532FF15D778DF9C442@DM6PR09MB5288.namprd09.prod.outlook.com>
 <12a41472-5d91-4e8c-9cc1-e255313791c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12a41472-5d91-4e8c-9cc1-e255313791c9@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 09, 2024 at 08:02:49AM +0100, Thomas Huth wrote:
> On 08/02/2024 20.23, Richard Schmitt wrote:
> > In an attempt to build qemu with hardened gcc compiler options, we
> > specified the -ftrapv switch rather than the -fwrapv switch.  The
> > switches define the behavior of integer overflows.  -ftrapv causes an
> > abort on integer overflow, -fwrapv causes overflows to simply wrap
> > without any error indication.  Wrapping overflows can result in
> > unexpected behavior and therefore, hardenened builds typically recommend
> > trapping overflows.
> > 
> > The abort occurs when running the “test-string-input-verifier” test and
> > begins at line 129 of the source:
> > 
> > v = visitor_input_test_init(data,
> > 
> >                              “-9223372036854775808, 9223372036854775807”);
> > 
> > check_ilist(v, expect3, ARRAY_SIZE(expect3);
> > 
> > Where expect3 is declared as:
> > 
> > int64_t expect3[] = { INT64_MIN, INT64_MAX };
> > 
> > The actual abort occurs in “string-input-visitor.c” line 209:
> > 
> > *obj = siv->rangeNext.i64++;
> > 
> > The test, as coded, will generate an overflow.  Using the -fwrapv
> > compiler option hides the overflow.
> > 
> > My question, is it the intent of the qemu community to rely on the
> > overflow wrap behavior or should this be considered an issue and added
> > as such in gitlab’s issue list?
> 
> As far as I understood, QEMU deliberately depends on this behavior - at
> least we require -fWrapv in meson.build:
> 
> # We use -fwrapv to tell the compiler that we require a C dialect where
> # left shift of signed integers is well defined and has the expected
> # 2s-complement style results. (Both clang and gcc agree that it
> # provides these semantics.)


Introduced by this:

commit 2d31515bc0880a1cea86ce638d2a109f4f4e6f7d
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Mon Sep 12 14:10:08 2016 +0100

    configure: Always compile with -fwrapv
    
    QEMU's code relies on left shifts of signed integers always
    being defined behaviour with the obvious 2s-complement
    semantics. The only way to tell the compiler (and any
    associated undefined-behaviour sanitizer) that we require a
    C dialect with these semantics is to use the -fwrapv option.
    This is a bit of a heavy hammer for the job as it also gives
    us guaranteed semantics on integer arithmetic overflow which
    in theory we don't require.
    
    In an ideal world this would allow us to drop the warning
    flag -Wno-shift-negative-value, but we must retain this to
    avoid spurious warnings on clang versions predating the
    fix to https://llvm.org/bugs/show_bug.cgi?id=25552.
    
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
    Reviewed-by: Markus Armbruster <armbru@redhat.com>
    Acked-by: Paolo Bonzini <pbonzini@redhat.com>
    Message-id: 1473685808-9629-1-git-send-email-peter.maydell@linaro.org


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



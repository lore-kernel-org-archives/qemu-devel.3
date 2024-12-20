Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D37DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfWD-0003hs-F0; Fri, 20 Dec 2024 11:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOfWA-0003hV-9C
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOfW8-00034Z-My
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734710780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuOHL+BI+KPUkCrVcsU96mx+0GMeZIAYSCNLXtxwp1U=;
 b=h41BZ063vdT7inPzccdYBTehltFn2K7mHhjR565w7n/eRXYEiAKP4tnntiWaL4OD4SueDQ
 Y7c7dMvaLHOoN7cBwPQWkeuKdGO4XWbgFXsVAXoZXrOIbvh/9qbMy9srLbYTyUFfuUTksH
 07wWBzkAM0pg6b7PnLSEmDUuh9RXEqs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-gceceiiROFqIxHdIGHFM0Q-1; Fri, 20 Dec 2024 11:06:18 -0500
X-MC-Unique: gceceiiROFqIxHdIGHFM0Q-1
X-Mimecast-MFC-AGG-ID: gceceiiROFqIxHdIGHFM0Q
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6eeef7cb8so300448685a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734710778; x=1735315578;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cuOHL+BI+KPUkCrVcsU96mx+0GMeZIAYSCNLXtxwp1U=;
 b=q7GcQPhqK3Xejrxi1/tqo4aCjEdy7WPJo9vtQR57XiWbXdZ5T2cLRsmqMcChESDF7T
 NPcxkV9NLVIg33JYZ/P09RfnRFaP4oax9iiy+PCmiNFns+x2eBwmKojRQyR1pLbsAqMs
 MrIB4Oq8/M/yWNnUQyg8KflKarEVGyu+TW3oKFvbhOymEVvXNN78Jc/lMtsdH77rruLa
 /GrGx12cM43qlDomhaCDbuQVFQUGx/JApaSc0yb/npwwr8tjngjS7t3aUBE9pHmx/AiW
 ZTOlBAAoeGrENbP0a7N3HVWVZkPnqgFlacIt6OYJ1VRmI5a/QWBVd+rt8eL5AGufpecD
 hczA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtZnu5BdPvQyuCapEHSFZlOEdxs4ZR8wRzdVbLjcV8Z1Oqvz3yChQQ+RSjygUW0qeisT5GtR3XsJFY@nongnu.org
X-Gm-Message-State: AOJu0Yymk5sgxhiOGtnykUjK4GLuIOikCyM/OtwyLSJiMtmdkkEqP6vJ
 cMGXivZrFQiNI+YOI+7dINCBl7RWmrJfvVhgf9KIH16MvlPuMGBLI6q8dgQzrVtpkaRQRrFrR0/
 h51QzLZdwdld/57F26zrbJYtmzvNJ88mfyiQOSjmOoWWdAeTR7gqT
X-Gm-Gg: ASbGnctPHreL7G32/O747qklJ+I7bPnIKU7BkzrhpcAG9ds9r5bY52XjLAjpKZAGvZi
 On9Vj6DvAPN07Zt4w9giDZUMk4TNmqrhR84gzc/HubIq36cANh7oxzF/Rnikg0Fw86ffJd6d3HB
 U7xHUbkGzq6jp2pDL95Pah/uSDVXjg6sfdvRPVKIp78T237k7kvccLQr0BdGJ6BnK9D6q3h3GXA
 bpvXOXve87pKbFhOaRzTEve4KiHguQbN6biU0egz5ZGrhpONLFC9B2+rGSdI6pWA4dW5Dtid2uK
 itfvrZ2QGSdt8insyg==
X-Received: by 2002:a05:620a:4096:b0:7b6:c4c7:ece5 with SMTP id
 af79cd13be357-7b9ba7ead53mr573031185a.43.1734710778077; 
 Fri, 20 Dec 2024 08:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYrUClMTrKEr1iHI2oHNiXNXmrubSEyDyLJ72x40vReR2MEaFeqBXzpsC3ucnw93GukTdvbg==
X-Received: by 2002:a05:620a:4096:b0:7b6:c4c7:ece5 with SMTP id
 af79cd13be357-7b9ba7ead53mr573024785a.43.1734710777596; 
 Fri, 20 Dec 2024 08:06:17 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2df864sm148387485a.44.2024.12.20.08.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 08:06:16 -0800 (PST)
Date: Fri, 20 Dec 2024 11:06:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
Message-ID: <Z2WV9TfVwvbQz0bv@x1n>
References: <Z2MKesakYn3fn2ue@x1n> <87h670vozv.fsf@suse.de>
 <Z2MvCRYKLmYCj55i@x1n> <875xngvgwe.fsf@suse.de>
 <Z2NHBQc9ixuvJ3k_@x1n> <8734ijvg2q.fsf@suse.de>
 <Z2Ra7c7svRVbYw1k@x1n> <87wmfvtqpz.fsf@suse.de>
 <Z2WKzdDIyiSCHI9f@x1n> <Z2WOiKDOOIwEkg15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2WOiKDOOIwEkg15@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

On Fri, Dec 20, 2024 at 03:34:32PM +0000, Daniel P. Berrangé wrote:
> On Fri, Dec 20, 2024 at 10:18:37AM -0500, Peter Xu wrote:
> > On Thu, Dec 19, 2024 at 04:31:04PM -0300, Fabiano Rosas wrote:
> > > We shouldn't change stuff that's also used by the rest of the
> > > community. People know about QEMU_TEST_FLAKY_TESTS and -m slow. These
> > > must continue to work the same.
> > 
> > I see what I overlook; it's used much more than I thought in qtest and we
> > also have a CI for it.. So ok, let's keep at least QEMU_TEST_FLAKY_TESTS.
> > 
> > But again, I don't think it matters much even if we rename it, it means the
> > flaky CI test won't run these two migration tests, but that's not the end
> > of the world either, if you see what I meant.  CI relies on the normal
> > tests rather than flaky tests to present.
> > 
> > We should be able to move in / take out FLAKY tests at will, as that's not
> > what CI is really relying on.  Here renaming the macro in migration test
> > almost means we take both ou.t
> 
> Side-note - QEMU_TEST_FLAKY_TESTS is something we should apply
> consistently across all types of tests - unit, qtest, functional,
> and across all environments - CI and local developer execution.
> 
> In recent changes to functional testing, I've set the expectation[1]
> that any use of QEMU_TEST_FLAKY_TESTS *must* be accompanied by a
> link to the gitlab.com/qemu/qemu-project  issue that describes
> the flaky behaviour seen. We've got too many places with flaky
> tests where we don't quiet remember what was flaky, so don't
> know if we can remove it or not

Thanks for the heads up.  Yes it makes sense to document it explicitly in
the code.  For now we can still dig into git log, but not as easy as
inline.

Aside that, IIUC the major challenge will still be there though on the
justification itself.  It could depend on how easily reproduceable the
issue is on the developers' hosts.. If there can be some link that not only
report where does it came from, but also to verify a fix that'll be even
nicer.

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483BBD41170
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLGc-0007oC-Mb; Thu, 15 Jan 2026 06:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgLGZ-0007ne-O8
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgLGY-00034u-Az
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768475508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQhlb0630OfHU6Y78Jg9uKNtTrLe7h7Mt/S3sd0uM9E=;
 b=N39QMv1Q0C40NLyozYHUwSQv6BWdY2iRTFBnECN3iW3mBQjdfOi2jSxPkcN6PR3oHcMIF0
 DxH7gApyqtyz3s1DiLVFQamp/EvcEuII+my+bLZvJUxhcKdLQeiT3IEg4De7xZxoHEaqaB
 r6tE4XGC1T6nGleF7icnB4V+AK0L4PQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-mLw7WrZsMpWeswSS1OXwzg-1; Thu, 15 Jan 2026 06:11:47 -0500
X-MC-Unique: mLw7WrZsMpWeswSS1OXwzg-1
X-Mimecast-MFC-AGG-ID: mLw7WrZsMpWeswSS1OXwzg_1768475506
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee71f0244so8445655e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768475506; x=1769080306; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kQhlb0630OfHU6Y78Jg9uKNtTrLe7h7Mt/S3sd0uM9E=;
 b=DOu1Qa173pmGtM5zxJEwvVtv/xLvSRZ7iWIrjxvqf8OzZYxOk0w0ojaUNZu7sRXvXO
 vlcGbfIGmayhKMFWbVAB+V5BC4/bMzAtwf2HxYI3NpN29M2gs2EVxv7jceQWSkI8Cf7+
 gaT/44ZrGQtNRIiXfmwzyX6+xDHO9wM4amk3vxyKEMN1jL/6xndpgLJNUx0LS4KpjJpC
 A4AjhyKO+FjUMZ57uIUTFXJqDBRmNz3SNVkgo7Bs0+StMVX/kJqiquHhOcTRCrkEpQ/n
 WCu8Wl/fJ6eUmuVg3SU+ySGLgi5Xo+E5eGQoOXDkHdDgmLiY6/dXWGeYSiQyAcYKwDph
 hfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768475506; x=1769080306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQhlb0630OfHU6Y78Jg9uKNtTrLe7h7Mt/S3sd0uM9E=;
 b=ZFRHX5sPLFGeNTtKOW0Nj+stNNOh7SaYEJMV5D2ok4rNQ/U7GTM2/eBLo0mdxSW167
 JWQ5XZxBV9KuWtHe89xL1LRsYdvbFPiGGHEftDUukK8sBxJa/FpDvAZSi0YrS0zjA5UF
 1QO4SLZjLyGkE2yhROWus5fzTI3pm5FwLoKf1IClPtvGVANXC3arguvSnrW+mTQj3cxb
 6jNlHo/bFxmGh2Nbe7edF1bMdcWgYw0AX1IBgmVmJpEfA7jk/lkIKtUCBn3QXQkRiMO+
 HQD7mFvORr7PtpB9CVtX0kiXVM+2wDgJ59GSDk56Ly1yujn/m+WjGLOQ8jv3rvxLaqNT
 E7iw==
X-Gm-Message-State: AOJu0YwH3ar4cMJNBsjHijApkmTwXIlWUyUT1YOrb/fKkVf00lUk1mir
 9sE5PxYlCdViIq9SkMYUDy0HQPPmg/hl6aX+3EPCwm/zAWyEcwREHQPf0FlmyTq91aaBqKyICMV
 glgpWWOS7dqmCJGmfGCbBzMJV+msXBmP5D7t6Rf5szFY3L5XpwM1Lutrqcq3wVMy4ZfKiAAE56k
 4Q25ej9jBFLcfbCHXlOaqfb15ayy5sXSs=
X-Gm-Gg: AY/fxX7LPyANVXsD70Ey2hDmIo4nTx1G0D2jJwINo3FIs+Z5+8q4x0gwTTRxAJ90nWV
 MKw0pFzLDLCpRMxM6OSobLEIN/H7Ykri2OhZaMTd1tXrg9ULaeJrFMchL3xlZCFLAjona7FoLAF
 cFOjv5ARFS66mZLBQx+UHFhDkUjfOSBsq4so7C/zm/fDWrQj7kAoHFhVOnWng642nfTi0lSfSBh
 swFgsXY0WIf17Hqic9+JJywwwkobGbi2WUdIAMLokq/9Adb21lXmQ2N
X-Received: by 2002:a05:600d:17:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-47ee8de7443mr39661015e9.22.1768475505599; 
 Thu, 15 Jan 2026 03:11:45 -0800 (PST)
X-Received: by 2002:a05:600d:17:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-47ee8de7443mr39660735e9.22.1768475505272; Thu, 15 Jan 2026
 03:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-2-peterx@redhat.com>
 <CAE8KmOwA-SVy1tQOzAKpa6B4uoVw=veMcn3qzkF0KJ8Cq0C_8w@mail.gmail.com>
 <aV6T-JDXv3wa7tdc@x1.local>
 <CAE8KmOzCYg_55J9J6Dh6Pr2D5wp_YLOXZqa4cm=Vt35ZDkiUXQ@mail.gmail.com>
 <aWe3lXEsr_dsKzVU@x1.local>
In-Reply-To: <aWe3lXEsr_dsKzVU@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 15 Jan 2026 16:41:28 +0530
X-Gm-Features: AZwV_QgW5UcJcdAGviT2muKCfSc2vr3SEwSNV-33z7hdDbhI4lbhpjCofTl23vM
Message-ID: <CAE8KmOyW9Pvma6MyLOVerHzsGYBhK44M_7Gak6zH5VQa5daWeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests/migration-test: Remove postcopy_data from
 MigrateCommon
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 14 Jan 2026 at 21:04, Peter Xu <peterx@redhat.com> wrote:
> Sorry I don't follow.  We need the hook_data for cleaning up tls objects
> later in end_hook, for either postcopy or other tls tests.

* Yes, but only start_hook() in tls-tests.c seem to return *hook_data
object and end_hook() there free it. postcopy-tests.c and other tests
don't seem to use *hook_data object; Other start_hooks() functions
return NULL, so there's nothing to free in the end_hook() function.

Thank you.
---
  - Prasad



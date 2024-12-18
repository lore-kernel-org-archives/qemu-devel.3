Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C643E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwjH-0003MQ-LZ; Wed, 18 Dec 2024 11:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNwir-0003J8-FU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNwip-0003F9-7i
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734538585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdpAgcnLTtvnlPjY1iLiDRL0CiQY7xovIC0/pqPpahc=;
 b=IPYs7SDiK67sIO3stvS7GjnR7XwXYYGF4axY9ns6rkjHqIiGydAAcISef8vzTjXg9kpSjr
 6U8icqY6r/d2A4VBJuqOZRCNmYL50wGDPQUdgyCOW/5fmilbIC50DvgyRxWJPV4qWQaVDR
 0yMfObkOwGHuVsvflz0s0hJuryDvEyk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-SjveGxJ-NaGQw1T_8w0lXg-1; Wed, 18 Dec 2024 11:16:24 -0500
X-MC-Unique: SjveGxJ-NaGQw1T_8w0lXg-1
X-Mimecast-MFC-AGG-ID: SjveGxJ-NaGQw1T_8w0lXg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6ee0af16dso1091392185a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538583; x=1735143383;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RdpAgcnLTtvnlPjY1iLiDRL0CiQY7xovIC0/pqPpahc=;
 b=PcCZpurTFAXGSNv87amECAa31YmWdjcdq+fNiaEmv+IQRrGja/ZfWfhmLlwwphgVd1
 ME5AfV+WqCPJjstbVr05uHMvjmI/FcSAHlfY3/IYjLf6dF3Gkjj2bxtuRziUlZeIYNhi
 CWKLSCFIBIj5SxFLdGyGOCEWr3CPS1CNLii06aONwB06ahgi2/KG/eexTLbsjo/NfUBR
 8GeP3q5yQXOZQER7uRsikluZSCakPT7vZyOx+L8kmb+4vueFaBCyaFb1mRBv92CGy+O4
 vO9zDlXeSpRIORWLM0c1Bi9dO1cApHbmzLa/XYvnYKt0XCrTZEASLj6rk1g1FusVqRIm
 8Dfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhMENLSzSs6bAAqDB2cKAeZEZTfU3SjmFhWcmqpEuSv8NNi37lZHAGPTO2V61y73fZSFSTBeaiGrJs@nongnu.org
X-Gm-Message-State: AOJu0Yy1uX3LlXVL+fF/0vZstyJHuShp4mCzltvHLz5tfX4TtXGjt87V
 7o4Y7HeFCqpLE+4S5QLRy/nn7P2yVUhGOyUTzHhKxvQjlPaYHfDWKO56RFVrdClfe4MWfftfzQL
 hNEO/erNqd27wOk94BUI5k7aiOT/U8sZ3R2rkhluEInUy9QSsxExZwu2LU9J8
X-Gm-Gg: ASbGncu1AhjiroS5R0eD9ZKtlK7Hm2ZOgH+aJkcZUEyRCoq2aCD5cfkVKdhH6lnD+6z
 spjGynOQxD4Er86+e1iJSPaeky6RnqkobMDNhH5df68EVXsdVnQzN8/tiUROUJSEmwGiV5HtIg4
 cNtrj3sxt1zDXDHCpFGwZmrZYs1uDj6h22llKsz7wn+2SRuYnDOrlMxoRj0UBbfF493nOtTN25Q
 I9eUWGoUAg4u7rgRJoMmYvuuiFUWf/7LOJA8MbnH8tgh9+dYDd6d7xxqCF2pdzcpVcVFl6pY5go
 IaTfVfK7HkuupMwssg==
X-Received: by 2002:a05:620a:1a2a:b0:7b6:d88e:f187 with SMTP id
 af79cd13be357-7b86375aa33mr560661385a.35.1734538583691; 
 Wed, 18 Dec 2024 08:16:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3YVCFZ4rYt2oUz58rKWi+ENusPUG00+AXKtqiQwD2cueAfZtk/VIG/xtfeJazDhNeGysYlA==
X-Received: by 2002:a05:620a:1a2a:b0:7b6:d88e:f187 with SMTP id
 af79cd13be357-7b86375aa33mr560657385a.35.1734538583320; 
 Wed, 18 Dec 2024 08:16:23 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048c9f62sm440312285a.111.2024.12.18.08.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:16:22 -0800 (PST)
Date: Wed, 18 Dec 2024 11:16:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration: Restore include for postcopy
Message-ID: <Z2L1VNu-wKy_6pOv@x1n>
References: <20241217212201.23376-1-farosas@suse.de> <Z2Hxe0PyVACaKIlZ@x1n>
 <Z2KGUnQIcxZNohzi@redhat.com> <87ldwduit0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldwduit0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Dec 18, 2024 at 12:12:11PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Dec 17, 2024 at 04:47:39PM -0500, Peter Xu wrote:
> >> On Tue, Dec 17, 2024 at 06:22:01PM -0300, Fabiano Rosas wrote:
> >> > Commit 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to
> >> > utils") moved the ufd_version_check() function to another file but
> >> > failed to bring along the <sys/syscall> include, which is necessary to
> >> > pull in <asm/unistd.h> for __NR_userfaultd.
> >> > 
> >> > Restore the missing include.
> >> 
> >> Ohhhhhhh.. so postcopy tests will always be skipped as of now?  Maybe worth
> >> explicit mention that in the commit message if so, only when you merge.
> >> 
> >> > 
> >> > While here, remove the ifdef __linux__ that's redundant and fix a
> >> > couple of typos.
> >> > 
> >> > Fixes: 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to utils")
> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> 
> >> Reviewed-by: Peter Xu <peterx@redhat.com>
> >> 
> >> Maybe we don't need to be as careful on old kernels anymore especially in
> >> tests, because userfaultfd syscall existed for ~10 years. So if we want we
> >> can start requiring __NR_userfaultfd present for __linux__, then no way to
> >> miss such spot next time.
> >
> > Yes, I think that check is obsolete, based on our supported platforms
> > list. It would suffice to just check __linux__.
> 
> This breaks the cross builds. It seems the __NR_userfaultfd was actually
> stopping several archs from reaching ufd_version_check(). Since
> <sys/ioctl.h> is under HOST_X86_64, these new instances now fail to find
> the 'ioctl' symbol:
> 
> https://gitlab.com/farosas/qemu/-/pipelines/1594332399
> 
> Of course I could just include <sys/ioctl.h> unconditionally, but the
> fact that new code is not being built means the assumption that we can
> imply __NR_userfaultfd from __linux__ alone is not correct.

What is the new code referenced here?  I still don't yet understand how it
would fail if we move sys/ioctl.h out.

PS: we don't necessarily need to do it right now to remove that ifdef, but
I'm just curious.

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD320F54ADB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55GJ-0001st-D9; Tue, 24 Mar 2026 13:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w55GF-0001sO-Ov
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:09:47 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w55GE-0002MZ-9z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:09:47 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7982c3b7da9so15653097b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 10:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774372185; cv=none;
 d=google.com; s=arc-20240605;
 b=kwhGDTX8n8KvCMg6z+Kph8jm3XXRFl6EuZGb5QtDDy2H1AFlhUITQDjVleO6vJFcp+
 BTf0WiTvOxpc1q+R4EX8l72fJFJWqnWIvCekw29GRvpBQrgwuiMAGuQKRQii+H8pIKDU
 JQDwU6mx2/+37s0X1CVfPlnmayOm4w97kHaZstu3ZKoAnssB8JM0T+QQJiC2EMf5khM6
 bVn67rsl8ero2wq5vLbymqdOeEN/vgUJuxaWwWqJ1QlQo2zWF6K71YJfPnegZf2R4XVd
 UpMuJoeYF1Usjmth8GvpDHGZdXKL5YF7FImTE8WRBq3Vc8plQO7gSUyPgg1qSGBkx7UG
 vWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=robp5mC1djdBdxWJDsuuuuCcZL1S0BKnvrEBhDr1Nyo=;
 fh=q7ScI39W7Apdjiuprknk/v1SJ/4kRZAP+qOi3NRhZXY=;
 b=iC4Yfw98UZBUBfnTeQ0C7Wc/MkTLY4Em2l9sjyEaJEbpnuMNkaeHzY+OZ1Cg+8Oadc
 6Ylsq3aNSv68bzOqcXcXavDWwquSFOhJmRoEUvbC9LUOiH0QCD+RFAhKBiv+i/DpEhjW
 E0vEBbfNlSFXCn3kdMreLYZU+uQ1zrkSR1qlrdvqsuXooh8oaeSsvvz5Y4NMUaIdh3bk
 UJhaThgl5cHw/nS/PuRIPXDwjrco1NYTj5Vy6uLRwOAoF5ZlcWr36JuOE+0UJhTyeh4G
 7NekMKh9c2gUNFUcX4ChOmWHGIM28f10EtAJUDCMYrG2uJ+YVquPVY7VpTVyev2RREPL
 MvOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774372185; x=1774976985; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=robp5mC1djdBdxWJDsuuuuCcZL1S0BKnvrEBhDr1Nyo=;
 b=GwfGEcnXOuAtvwZnq2LqPEV5ErhOEXyHgbLw02B7wLs6dVD+pRqbWqmCmIbfAR/KC5
 36z3RY8xjROvOSau/LnqeePhYTKKwnKYcyKZzNnA9MMd5sB6dz5PKOv8G8u2xp/8uyCZ
 ykPeQgoykirVucq15xfZGuqMroOrJFcSb7nAfaic98IwZukKzOVuNAuDbQIUV4s0SJVD
 HfU9x4OUjTvROzaI9jy+v0FfpwR7jj2+uax1Q01UKBn5VfHWjoog4+AIt9K1Pde+J7MW
 XS1BawJsB1GYYAK1sGc0knJZ2330rpc8b35s3Yn3bbksLjlUkei0gYP9hy8QnwNjqFmD
 huTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774372185; x=1774976985;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=robp5mC1djdBdxWJDsuuuuCcZL1S0BKnvrEBhDr1Nyo=;
 b=kL4tw8TVe1VFyNaJ7uj/9cG6H0iXzW0LFrGZGVTVTcpoK+VS5FMZI2k8bAsVjukbik
 Uoqe2KrZ6RNPjGhtLnYVWgp/YZYEjGtnLGhJLLqOVdsMdawCX1/VjICv0xaPlM99VQHf
 Wt1CLBvIMB9PshPMQ4dwgV0+q98UDysN2TMY+jTyc/cDDu8RgWD3St4hxFEOZpsQ99kc
 oIkEMLOCYPm/a6HU6ebL5VUPxNrORUrXD0n2Wg7dJLN+x/odVgBN56ihRs2b5GNkuvv6
 ep/TF7SGJnXiT7tnsPUSpAHCPPfXcA0YqsJZgvEPv4gv9T1keI3Vqt92jLoY1FlKaqx9
 rqoA==
X-Gm-Message-State: AOJu0YwJoQHHAefBgGT71ogifOACSghPM7UkX0D/b6qf+DeoT6i4V3uL
 dutLjdy2cBmOYRm35V9sUWLFZi1UEs0r8Tz72yIGgU6qDH5sNgrRMri4ioHwmn0X3lL35YGjoIg
 3buh5Cjf/ZLGptIqtHDwlNrKLClRzbJZBBar+rXqqzhh+lJVKCkbxojI4Hg==
X-Gm-Gg: ATEYQzxlTRtRhq+ZNUtsnFaQzKkwu815akWnTneaVIG7qUjZ8N43Xwka5BPMvOMM1DB
 EWdm9qIyFlKW/nXnl6x3wsOIUPJRHT7p8D/5cZ6oww/vMNgPenR9xOEzbbbwKp7DFg0OkJs3VKd
 UIiGeMlxMCY1nvpEDfpdtjXLIXC67kSn7kSmkfDWY38memKvIJK+HASsu0m1bbeVTax1Cjf6wa3
 +HGXFZHY1Tw4Njt/KTeWY0A5VFiCnba6ILN9gc22zeQDz0GKC0MiW/ztZvBLEiqHDqhxsedhW/k
 85mIzYCka05vuMZeBQ1uh69mC8N7nlt2Dp8RbeSetEHKB2HVGbvTWpU0lGd7dJ7LY6g=
X-Received: by 2002:a05:690c:941c:b0:797:d386:44e4 with SMTP id
 00721157ae682-79acf3a2649mr4371017b3.16.1774372184782; Tue, 24 Mar 2026
 10:09:44 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 17:09:33 +0000
X-Gm-Features: AaiRm51HqI8-37gZGrf1rjEehVbIf1o9TMZqSgthTOkBQSPkvBJtrrJIfEWLv1I
Message-ID: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
Subject: Cleaning up contrib/ and tools/
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We have a couple of directories in our source tree which have
accumulated things in them that don't really belong there; this is a
proposal to clean up by moving things to more appropriate locations
(as 11.1 work, obviously).

Firstly, contrib/ has a tendency to be a dumping ground for stuff that
we didn't think hard enough about finding a good home for, and for
things in a weird "not really maintained" state. We should either
(a) care enough about something to give it a correct home and to
maintain it, or (b) not care about it, and kick it out of our tree.

Secondly, tools/ exists but is very under-used. I think it should be
for the set of standalone tools that we build if you configure
--enable-tools and which we document in docs/tools.  Currently it
contains two things, one of which doesn't match that idea...

So, starting with tools/:

 * tools/ebpf/ is the source for the pre-generated
   ebpf/rss.bpf.skeleton.h ; it should move to ebpf/
 * tools/i386/qemu-vmsr-helper.c is the source for the
   qemu-vmsr-helper tool; it can stay (should it lose its
   i386/ subdir ?)
 * the tools which currently are in the top level directory
   should move into tools/:
    - qemu-bridge-helper.c
    - qemu-edid.c
    - qemu-img.c
    - qemu-io.c
    - qemu-keymap.c
    - qemu-nbd.c

And for contrib/, easy ones first:
 * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
 * contrib/elf2dmp moves to tools/
 * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
 * contrib/plugins moves to plugins/plugins (or a different subdir
   name of your choice)

For contrib/, ones I'm less sure about:

 * contrib/vmapple/uuid.sh is a one-liner; we should either commit to
   having this, by giving it a better name and documentation and
   installing it in 'make install', or else junk it and have
   docs/system/arm/vmapple.rst give you the plutil command and tell
   you to run it directly.
 * contrib/gitdm moves to scripts/ ? It's just config data for
   generating statistics about patches, so with other
   developer-related stuff makes sense.
 * contrib/systemd -- we don't do anything with these (e.g.
   'make install' ignores them), so I am sceptical about their
   usefulness. We could drop them, or move them to scripts/, or put
   them in tools/ and qga/ with the tools that they are systemd
   scripts for.

Then we can delete contrib/ entirely.

(scripts/ is also in danger of being "miscellaneous dumping
ground", of course. I have tried not to suggest it as the
destination when I could think of an alternative.)

-- PMM


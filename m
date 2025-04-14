Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FA1C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 01:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u48fF-0000Pa-9h; Sun, 13 Apr 2025 21:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1u48fD-0000PB-P7; Sun, 13 Apr 2025 21:31:07 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1u48fC-0003xt-Ak; Sun, 13 Apr 2025 21:31:07 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86b9d1f7249so3333728241.2; 
 Sun, 13 Apr 2025 18:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744594264; x=1745199064; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=adUbBB77t6OYafof48KUJ86gD5TkTpXXFj9ZCu1Ytxc=;
 b=eCdzZulqs6dBAPqPYHXMzTqqGuvap0H+8LNg6M3WXyw+3lydGmG8E6uX+jDAZRiQKM
 zSOSIJwgVD8XD/Q7T9uTFYNJnFmOIY+e+1rneDA4PWLq/ObTFbT9wyQiLJy7QGrDNPar
 Rr6yxgpzNw/om5hcuiYVGc9V/WR45FlXh/B56V4DYyjZopGMBL3ItUHZi4eCJG6vyKao
 MNP2taD3vd8DoSpk+n6qdXX4DxkOzLKSAZMOvYwMVqUg6U/xF2qsmk2udUVZxNqMSlgA
 YcG+68ny07nPZVPg1j70yNpuwJIB73ehI3fWxcUzh2gTCc1WOvfP+u++5mkVtlAiLgRG
 zORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744594264; x=1745199064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=adUbBB77t6OYafof48KUJ86gD5TkTpXXFj9ZCu1Ytxc=;
 b=pATuNzULDAQGC6zIOpwK1jMrG1ThHPQCfSH7oVnTPIbD1t5s7HnrHIfM/D8JXojtlH
 lY3xRcIXQxip8R0V+hjnLFcebP/LgLeAgIARYVd/F4xdw8hcPl+yRk98Pf1Lw8iht3Jr
 ZkaXZixWH1YNBBed7RB4nx4umHV3bgSV52cE5hZ814Nq4xkD5RfvQoMNwWHADQoUgaXf
 DzIAtxh1ebmsBm77QYEZqIMeHWDjw3R2tzr36qP5fQY1PwUiad7BHs++0kOMjUfNrUw/
 Plx6+2pIxWlT8MztnHl6NoBWkhGsyQwZEl1W7hrwgu08goGT1tY2CrN1B3a6mCKmb3sj
 ev0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjc9G+ZlCqSAICbNGXiD7Ji/ROBWZmGXBnh/trUD6Wu8qQwjOjkRzqXKSyIDam688IFB9S4ru6gIdR@nongnu.org
X-Gm-Message-State: AOJu0Yxy/3Ay0sArebFbPTkcJBn5cKE0z9e45OAEuZZURE6OgOqf7pln
 4wq5xQOm/vBE28tzX7O0tQTzvY6FUp+4kJaPi2xxix+LI76sN3QNi7Kv4K7/fCBMCxlXWedLJOi
 rBa1XRHKnVGyAdH32aPQ4EidD360=
X-Gm-Gg: ASbGnct0eJSGPvE/9PiEQs8YhFijrT7XX1J/X6siQxAVTDUY8ma6pjoyWGJ/C2ctO9K
 zR2GV2QaW96YyKbKzmBm1Tz0AeBQse4unIkE7UbJziKCy+opgILpHXD1McctAJj+YrUHi5X8K+m
 1jtRQGb/eKgFcJo6vD8Bew4TIPekSeYbnyo2hSkjoDSUYF8GNHxFdfLT8=
X-Google-Smtp-Source: AGHT+IHJf1rP9DJUyzD7uFQ76mxQxUghlNYT8EJPSkflAES3WDy7XrcR5yrtI1tAXAB2B71sZlT/N0PnIdFWztKwiOg=
X-Received: by 2002:a05:6102:1501:b0:4ba:99b5:60f5 with SMTP id
 ada2fe7eead31-4c9e504c870mr7173921137.23.1744594264062; Sun, 13 Apr 2025
 18:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250304091703.462342-1-Raman.Dzehtsiar@gmail.com>
 <3806d9f0-c689-47fa-a0cb-37b9c33685b2@yandex-team.ru>
In-Reply-To: <3806d9f0-c689-47fa-a0cb-37b9c33685b2@yandex-team.ru>
From: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
Date: Mon, 14 Apr 2025 03:30:53 +0200
X-Gm-Features: ATxdqUHP9SAJ9f0iV8_6AqG7uVoUZOUfLEqWY9kbia6foTfDRjak-BihRr9QxGg
Message-ID: <CA+uc5a0wB54KixsKqF10njhfcZd9xkwWiPQoofZFjQ8+LsDBLA@mail.gmail.com>
Subject: Re: [PATCH v2] blockdev-backup: Add error handling option for
 copy-before-write jobs
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>, 
 Wen Congyang <wencongyang2@huawei.com>, Markus Armbruster <armbru@redhat.com>, 
 Xie Changlong <xiechanglong.d@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=raman.dzehtsiar@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Vladimir,
Thank you for your review.

> The patch looks good to me. Still, could you also provide a test for a new option?
> Probably the simplest would be add a test-case to `tests/qemu-iotests/tests/copy-before-write`, where existing on-cbw-error option is tested. Or you can make a separate test.

I've added test cases to the `copy-before-write` test to cover the new
option. The changes are included in v3 of the patch.
Would appreciate it if you could take another look. Still hoping it
can make it into v10.

Thanks again and best regards,
Raman Dzehtsiar


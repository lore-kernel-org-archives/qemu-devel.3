Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C7BF43689
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg0w-0008Hp-2L; Fri, 17 Apr 2026 06:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDg0u-0008Gz-8P
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:01:28 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wDg0s-0004nF-FT
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:01:28 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f0884bcfaso404165b3a.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776420084; x=1777024884; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=elNsITX+U9Qr9VO5/BiGHtg018i5dbosztOX94VBVWw=;
 b=pq2oPSFnk7x5MXWQjlXHjuv98dTgmH58ctljxRfk+cjqD/jPMCjsUmu7jnE1P+BoDk
 MLgiyKNDoe+RkUmtrjJ+rPqMDkL5C/cjkFXdQxVAgCJ1unSot38ACO5EE2RECnq7SpSF
 t4crYivcugaS4oigqfLIw/ZkUYI4+1vM4sBacPI7pKciJOt4zLjLxvLfDMYsvye7uHoV
 ggncZltJa+twG5IeJ+MAczC9jkOJ1ZS6mcP9X5UZHBJhAGkg7cKcLv+yPEx2O5csoJC2
 tfONAMt2jwK5HOwBYFr+PdrL8hahvxpus8g09PVAW0N2V+IwNZaWUqlrcPUyEW204EMK
 7UBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776420084; x=1777024884;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=elNsITX+U9Qr9VO5/BiGHtg018i5dbosztOX94VBVWw=;
 b=K+S9qAjVuQm0U7y2G4WR9gyNSsDUCrm80iQxtmktiAy5b/82BDSii2/P+0oDqeezLm
 mEVa7i2f8h+i2OHqL6A/1XQ/x6m98q/cWw8f2/cFpjBjHFVsYlUbbYJSL2pLZhmqvN1j
 +yhNELANQ075HIu59Q2ZUepA4kfHBOKYuDVsz9V+ecce+CNZQzinaXVJm9yQ1ZjDZEay
 IAq8bN37J6kzf77ZMHN0GlHpSHmJuyc3lk+/tiTRuX9IR+kVm9ZWOzm/uq2P5TrCzVk3
 E2pCUJXlbVNBOoB7vePTS7ZaxTw1GQ5GBNUfl07KCHcjID8ekNT6hG8FIyOJ2veHO9ba
 LHFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DAMck9jeHGybeLaE4tK1VNczDaE4AvR4FqkiFpHBNUIOu+4pab3/cd7d6Fji6Hk2Pscwt7YgRa9/5@nongnu.org
X-Gm-Message-State: AOJu0Yz2G3/6HeSffE5zmIAV1ksxSBixNvxReQGq7Nmu6vT+P95yBZgw
 xNGlsxRXdHnwIW6dE9wJIXmkBlCSc9TvlML890nDAwkOldGqWWgcEJ7w
X-Gm-Gg: AeBDietf12GBUPT7Y6zCh6Qt7RSwGi7CuFHRYzmd2CGjVIKw0mhwqHs0A6JWzEGoVQ6
 DFbPLjGLrQ5u2lN092mEqGXa5R765hVBAzMU6ZRn5+TBDWZlIqj4YXADV5nK9v2VVt7RusjonhR
 PQ7oDwbdXKwPfyqblz6qW7QRT88SeuhQ3/+KUYsMS995Kkc4rZyd7KS5ILf8oqDV9AfU6grg97y
 Su9OqH5gUAuUw9FZsu6vZs/hFZUCZ2xebpG9Ei8X4cHF7Tm+UrclyuG/8d/lYcLAX0QJUhQ2TaP
 mg/6fN3dcgMi7mWZV6src7UcGgp6kenvCbMT+ktyVMmYA9Ih+VFMAuIp2WA1Kk/I91/sTjQr+Eo
 xk2wQLRrLvnYJvj9rBKUKJHkPKpzeot+Xck8ZgHP6wVGgxPKV1R8x6RwKcMmj4w8DquRhgmRvX9
 c++DeuyYtfg8xWXTVSpWNrS9mfoLvpWqcR70tPfmx1VCk8GtK/cdT4D5hJSIvRPqjNzK492EK18
 cqxQLzi8fKxNl9hKld3V72R6RRGUHbMBA==
X-Received: by 2002:a05:6a00:2d19:b0:82f:425b:4c27 with SMTP id
 d2e1a72fcca58-82f8c8250a2mr2528860b3a.14.1776420084449; 
 Fri, 17 Apr 2026 03:01:24 -0700 (PDT)
Received: from
 trieu2-huynh-trieuhpn-ubuntu24.beeworker.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f94204ac8sm132766b3a.0.2026.04.17.03.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 03:01:23 -0700 (PDT)
Date: Fri, 17 Apr 2026 19:01:20 +0900
From: Trieu Huynh <vikingtc4@gmail.com>
To: Peter Xu <peterx@redhat.com>
Cc: Claudio Fontana <cfontana@suse.de>, Fabiano Rosas <farosas@suse.de>, 
 qemu-devel@nongnu.org, Jim Fehlig <jfehlig@suse.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
Message-ID: <az5m2gurqpmjildkikpgkvewebq2vcqaigkdqddwyyoihxii27@fujofmealpbv>
References: <20260405152612.93027-1-viking4@gmail.com> <878qb05gq7.fsf@suse.de>
 <ada038hgmY9hNqPK@x1.local>
 <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
 <ad1a9GaGQFHS4UHx@x1.local>
 <spjcuqt626vglmkxxal6ntrttaiwlapcbltrix5eslmyr7yirx@cegi5c5lvay2>
 <aeEvdT0gzpOfDksG@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeEvdT0gzpOfDksG@x1.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 16, 2026 at 02:50:29PM -0400, Peter Xu wrote:
> On Thu, Apr 16, 2026 at 11:53:55PM +0700, Trieu Huynh wrote:
> > Hello Peter,
> 
> Hi, Trieu,
> 
> > One specific use case where the source is completely unavailable is loading 
> > from a migration snapshot (non-live).
> > In this scenario, there is no active source QEMU to query_for_stats. The 
> > dst (IMHO) is the only entity that can report how long the loading took 
> > and how much data was actually processed from the snapshot file.
> > This use case is a little bit niche but still a valid one though, isn't it?
> 
> Yes it's in general valid, but it also depends.  There's a reason that QEMU
> supported load snapshot over the years and nobody was asking for it.  I
> believe it's because people simply don't need it.
> 
> Load snapshot, unlike generic form of live migration, doesn't have much
> uncertainty on its own.  It should either succeed after a while, or fail
> with an error.  People should not expect to need to query anything.
> 
> It will likely, and should, hold true even if with async load snapshot in
> the future.
> 
> It is only valid in that it might be useful for developers who works on
> snapshot, especially tuning the performance.  But then it also means we
> shouldn't expose it to an user API (QMP is in this case).  For dev only
> reportings, we should rely on trace points unless we have good reason to
> make it visible to users.
> 
> In general, we don't need to add unnecessary API maint burden to ourselves
> when not needed.
Thanks for your detailed feedback, I appreciate it.
Taking your comments from the other thread into account, I might drop this
series for now. As I don't have a deep understanding of libvirt or similar
management tools, the specific use case remains a bit ambiguous to me. I’ll
leave this series/patches here for now in case Claudio and other experts
want to chime in or if further concerns arise. Thanks again!
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
Brs,
Trieu Huynh


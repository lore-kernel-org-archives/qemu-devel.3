Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E47C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x18z3-0004cZ-UR; Mon, 31 Aug 2026 16:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18z2-0004bz-0Z
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18z0-0006Lk-72
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788209516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=AkYsQKm4H+Wv2oMEmaOJZPn3MyHI4XETACimHQiQ88E=;
 b=hWPPWtRWueLTuW4F6DG4tH7KYSwvLm1R3RHgsU5/nTez3XKqzUs94lA9pWJkI63C1P0E9x
 iahPxWq4ItIs1Q+Q4hrNd0xn2UWB7nrlnEE4Y4Jvix/5DZBEY8/O+1NVgkpBPU4xZwavea
 ihgs1n0nm/Hq8CNEGNJs6NRoHYXWPJU=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-43-wY7OLOh2gAZwXW3FbxQ-1; Mon, 31 Aug 2026 16:51:55 -0400
X-MC-Unique: 43-wY7OLOh2gAZwXW3FbxQ-1
X-Mimecast-MFC-AGG-ID: 43-wY7OLOh2gAZwXW3FbxQ_1788209514
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66e5862a158so299898d50.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 13:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788209514; cv=none;
 d=google.com; s=arc-20260327;
 b=b2IKqqLQSwlkYopbuqUuqYg4beMJQmZWYCELbJ6gSICkS8/pHp8PVVwfqXlD+s6ljP
 RfjtlhL13i+ML8TX8rANLjTUuE5RLcsZJybfG/n7V/435anV2YqAFuyzd/vajrlquDrg
 fuRtqmJyms3cnmUBOV2Ug6HsbCGtNPtolAW1iyvpc7Q+SmKaQeCuGKt/99hHHLSPqhfg
 P4maeE3wbE7GZf/8aCyYAEreguMakLpCXvQk5fQlKtkmsw5xGUPnXVT054QbY5tHBz0q
 8DeRvRqYqJHG8QvSALAxjYgp2RUteGE7B/j0LGLTOmfG9EYDkSkRBSwcjTKsHuUGTH7x
 DKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=AkYsQKm4H+Wv2oMEmaOJZPn3MyHI4XETACimHQiQ88E=;
 fh=bkVI2tKSBaK1aZ/o/QCF7IE6HsHarvFGL+KUN7OuELQ=;
 b=neqbSOhiRRoyxFSBtNw0oMv2RIZEiWEvea+HdFGB72R/yzBTOtnbL2m9hZ6kQeyPOe
 lDeCxnoC4Eq4AB0TX2mjktCs+WaGTfiI3EMdBbYTtjWnxb215kkOz8jY6QOsQves0A5K
 a8afN6sjNjr4sGMYIoBlvJYP08uScpdtdAkURUBwXdkjEuiVRiwMNk8TeBhyfjKrxCsf
 rvybkG32h+a6tMofC1Oh9glx+QUNHM0OKoY/DD6Ogcm/HjFOqCZbduk0lHV2+6q4c9Yg
 JKsVxNrkuhcLHvxAhXuda5KX6i15ikg/r5tZic86xkxibcMFbTxXmvKMWn8jmP93MJvh
 Hm3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788209514; x=1788814314; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AkYsQKm4H+Wv2oMEmaOJZPn3MyHI4XETACimHQiQ88E=;
 b=gaPQ+DOKAeY2xFKEU/Y+f2hstti0+x6X115hDw2oBtbrgKk8hNPapH1eN2c+I8a0Pj
 Hgy1QtMEUlgrkVpydvropCalhbXOt+7I/+yfuXaTPeuPxgGael3HCoHR8wx8Td0c330e
 7GTGueIKKEzKbfQiJtUaNrDMd9flFvtUwUXbfqsNbq5yy0Wzo8vLhxQlfA4FfR24UHz9
 hUoNq83h5wA6PiFZA025OxHqDgqUbJwHkVAhpbzRTseG8C6btONvKSXajMQnXiYoY8Fn
 eS4PInRjnr50NCFj0LqCqZy/yHJ5rAGjqhl0XEWGrCGYXmzd+Q9H0uW8onr8s2eLp0Uu
 tOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788209514; x=1788814314;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AkYsQKm4H+Wv2oMEmaOJZPn3MyHI4XETACimHQiQ88E=;
 b=YJHgEdOP+Yq8LXRfwHOi286f544Hf/cYMJXdmzDdqvis8fI+poIRfcNXMzNd3RS8NT
 advRUF1IAH43t+OsqhDMx0KqoitDgZ7O0Jr/veII7EtfsGMsr6CCmVRJdikuBXhIn/2+
 uH7k+6Tcj8UO0yS1hUkIGGckc0qB5UWgYBq2/AZ4w8HW5mf+3Xi8qkL3IiZFdN4ZcbK3
 5xhgw7hywJD6xJYk6aSLN8pFeqzPNkLDlEWiOZMVEj0osNjsfKQ+Wo0VeLdaAf5nUYAB
 LRsGEtBdQ5BaklZLjhwiheMLGxUp07sc3WM4h64ZRQH8zu+nkVWZJ6FENQ5ihIT9X9zR
 vz5g==
X-Gm-Message-State: AFuF++l5DwZIwnCJ4GdtB4pJbfLCGN+I4UUx5cv1Kg2+8YfAqLAcTnXA
 s/EdZBRU31kLvPMjNHOsay/au2rmv++9Nr8y4E1OIWGaqMmt67N3s1v02LrvxD414FAo8fWAfUr
 TvnwM5QkQbl2t0b4avGd8/MbLAzJ3ciZiUMvNCbU6vprx/S5hGGEfGxhkSeQIon1IBGFhaFypGD
 wMQHE9bYNVewE7KmSHURW3p1NB1MkD2+Q5EUWs79A=
X-Gm-Gg: AYBFou15PzB/KMTffQiRKeC1ILDQerzGMlxoNdyR1i5k9EXf/3mHN5vnSY0/CkSlXxR
 w/xQlQdkaFijrKk5AY4paL7vSLL1PdyVm2z/MVyiR1hihj6D19qeOMMOOULJro/X0wJVnxXVQHu
 +nS9ZFXPR+EHEmYkswkB3Ncnjp5r/MiZCvElwXyMxAqakGFiBuk9LiZ4Ac4DIH+ubkf17692u1q
 nRgxxKTkTtKQKkk
X-Received: by 2002:a05:690e:1609:b0:66c:9a74:d34e with SMTP id
 956f58d0204a3-66e4c5f03a5mr6861870d50.8.1788209512587; 
 Mon, 31 Aug 2026 13:51:52 -0700 (PDT)
X-Received: by 2002:a05:690e:1609:b0:66c:9a74:d34e with SMTP id
 956f58d0204a3-66e4c5f03a5mr6861736d50.8.1788209507220; Mon, 31 Aug 2026
 13:51:47 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Mon, 31 Aug 2026 16:51:36 -0400
X-Gm-Features: AcwNN1XfihkNYlE0wA4khTCFTeeMQbGnhSkAwxv1RZAK_pmOr8ZhDojFieqLI3U
Message-ID: <CAFn=p-aVpKptC=G6yTWWuQoeG+peChgw60uJdOXr7B8r=m=iBQ@mail.gmail.com>
Subject: Async machine appliance for testing (python)
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

WIth the upgrade to 3.12 imminent, now might be a good time for me to
revisit the work I started when I converted QMP from sync to an async
library. I have a draft of the library I wrote some time ago, but it's
probably in somewhat dodgy shape after a year or two of being ignored.

Before I dig in, I wanted to ask if this would be a helpful project.
The main selling points would be:

(1) Ability to split it out from the main QEMU tree, like QMP was, for
use in external testing
(2) Better stream management so console information is consumed and
logged reliably without deadlocks due to pipes hitting their buffer
limit
(3) Removing multiprocess and multithread processing of console and
stdout/stderr logging from test suites in favor of using async
user-threads for (hopefully) simpler, more straightforward processing
and customization.
(4) Ability to add listeners/event handlers to watch for specific
patterns and trigger asynchronously when they occur; i.e. ability to
handle and watch for specific patterns in an arbitrary order without
deadlocking your test
(5) Centralized timeout setting and handling.

I recall in the past that I heard some interest from various folks,
can you just confirm this is still interesting for you at this time?

Thanks,
--js



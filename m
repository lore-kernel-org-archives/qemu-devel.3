Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC0FCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL28Q-00079y-Ce; Mon, 17 Nov 2025 11:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL28L-00076r-6u
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL28I-0007gX-NJ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763397073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9EV0G8fOv9urSTQ/Zi9BrN+v8CBpmDQcEA3FMJ5hCDI=;
 b=Z4SDfB/MnV65YACGRc8qfWyzHGCYfwkRBbOZEbj4Pbi++tO2uVRlUq0bjnhF0NfY8DHVsB
 rRNCCLA54IBQABBVKldzU8b3oqxY7Du+w4yw+xym0+J94+EFAYteUn4dSRvi5HO3hrJIDc
 VN0kcJmgxT5zRtoBjv8wNeMK8dnAya8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-OV4QJj6UOZy6ZW6Z--o6jA-1; Mon, 17 Nov 2025 11:31:11 -0500
X-MC-Unique: OV4QJj6UOZy6ZW6Z--o6jA-1
X-Mimecast-MFC-AGG-ID: OV4QJj6UOZy6ZW6Z--o6jA_1763397070
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so26086935e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763397069; x=1764001869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9EV0G8fOv9urSTQ/Zi9BrN+v8CBpmDQcEA3FMJ5hCDI=;
 b=YwA6fsdpvUW+HuQy4HGgqBWT3Vn6hb0Td4WJSlhdpJRgMO1Q1X91/slKU92by15+9j
 bo0qsZF7S12oUD1lcYpT6dPC4UFksE9dWHZdwSPtuWJoU6wWgYPym/ZH9VoffCcpyK6t
 A4sfb+a8GgouqQb4BzRtaF2pwaETec8P1tzxsy49Ng6gOOEArozOfC2xM74gZAkAk2bC
 +9N7rgAjmKJ4QQopZukoNV/A7tQ7EtuYlYAd+7yl1gsYaocb61RwvDcJGGvxxRJE1AUI
 TPioAlESQ0HmasNMhw8j9VITxwSLwiGkyiWsHgE9O1hG70xk3csFAr1e6Zi3dsSu+vvu
 Qj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763397069; x=1764001869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EV0G8fOv9urSTQ/Zi9BrN+v8CBpmDQcEA3FMJ5hCDI=;
 b=xSmQ22jngHvR6kY0NB8lqnWvLrLlp5YXeeCXFipCuLqjvQWMtZmTAeq6WtXDRbYTzD
 ioxBvwV8z/TU0wohpFZmSfnYn+TodPJh4DxhJ0SGS7mropeL/425BVOeFJFjKV22qMp0
 SATMFUxKpqy8GKDqJ9quc5SwMAABcd6lRK43RGcnIGK0takgjhPQRMvNyMxagBXKptld
 kEq8oVn2FROJddeaEzum9FqyOh+39gNZBFTX8hhGjeLfdKm47d7VjME8fhN/LwGAF46h
 sde+F1eKchgm5B9QZgK1Znh7IbfKaGJlqlgqbfhj/gVHgCpIXzQElWHHIlpcDHOCRrGh
 3hcg==
X-Gm-Message-State: AOJu0YzDmk5Oeeu/saD+eZmSUo8JzFiFSGOsCE02FzaqB2922cohwFX5
 3Plz791PfjA9J3UFjgJixZa+hKQb7q+Tn9oq2AlwpJwqDiU8DF8lw5A1SqvZUJ5lRBTIDc+8hRM
 LRH5ZtmI+/N0K6/ytXs9QWyfDNwa2+q07hPaDFbWGl9PF7XPdIQ7rMHNmiSoUjvG9G9noOR8uCn
 tqGB1Ou2kB/jSHLnB1gaaNGPuWmkgd2GKeCqiKUuD4
X-Gm-Gg: ASbGncvxoRt0g4c6s/1+CYzM00e7q2+317R7Gzb9CN7e+xy3ovklZ77lNsw7vKoTNG0
 g/YQgn0Rbq0hMiWApX+6wgi7wEga7Yvjk+FT0NsjtVl2RMwkPTJDEmjHia+xHAYrCFGd41bAkc1
 x7ldOkuCvm0CxghUbuDSekTlkSXNWoHGJJYgMlodnKvOSLa/98ugT5uvO63nzHhrjiZuatjm/OH
 8pdFkTyibglEQp6OZRh2AbG8UmbAzt0VWdEP8Qc9zZIMXK8Cb5Y4bYKSi178TIzLzA7PBGkAUm7
 Zzt0ibSlTeq22yRscDfMt4owRjkqgb77uoD8ErNApvORVNKIlHsZ+rJvJF15+DnPrDlU1PWCYPG
 ozfoefholkZu9EdLfMyLeaOACFksU4MdHnfZc/f94Qgtj63qjJ4k3y7lvhTloZN7ZxS/6S7TPy7
 mr3p5F
X-Received: by 2002:a05:600c:3587:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-4778feb23b3mr129423525e9.34.1763397069065; 
 Mon, 17 Nov 2025 08:31:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3lrjs4Ap1sFQcoO4p66XX8pM0YvYevbQYPjMR4436z8tfMJINA/9vZN5f1jzYpVKDeFHDHA==
X-Received: by 2002:a05:600c:3587:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-4778feb23b3mr129423135e9.34.1763397068564; 
 Mon, 17 Nov 2025 08:31:08 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779fc42f25sm99329855e9.6.2025.11.17.08.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:31:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 0/3] mtest2make: clean up and make dependencies more precise
Date: Mon, 17 Nov 2025 17:31:04 +0100
Message-ID: <20251117163107.372393-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

You probably have never thought much about scripts/mtest2make.py, and in
fact it has seen only a hendful of commits in the last few years.
The idea is pretty simple: gather the list of testsuites and their
dependencies, and turn a "make check-*" invocation into calling "ninja"
first and "meson test" second.  On top of that, it magically turns
SPEED=thorough into invoking up to three suites named XYZ, XYZ-slow
and XYZ-thorough.

But even this incospicuous script can harbor a bug, or rather an "I
didn't really think too much about it" situation.  Dependencies are added
to suite XYZ independent of the speed that is used in the meson.build
file: add a dependency to a func-thorough test and "make check-func"
will build it at any requested speed.

Fixing this is a one line change, but it is easiest with a small cleanup
on the front, which is patch 1.  This (at least to me) makes the generated
Makefile.mtest file a little bit easier to read, which is also nice
to have.

Paolo


Paolo Bonzini (3):
  mtest2make: cleanup mtest-suites variables
  mtest2make: add dependencies to the "speed-qualified" suite
  mtest2make: do not repeat the same speed over and over

 Makefile              |  4 +++-
 scripts/mtest2make.py | 43 ++++++++++++++++++-------------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

-- 
2.51.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EE1E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 09:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMka3-0004S8-3w; Sun, 15 Dec 2024 04:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMka0-0004RL-AZ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tMkZy-0006wF-62
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 04:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734253579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JWQExX/Bkd5EWlI8DMzxeNmtXkiXVxZ5BzUuDMLVkIw=;
 b=ZOTzDCa0VAfZUBH26RoJovcRXeoJZp8NLffyqE/grDAcJwBtgSsNM2FMtMOYQoNiZurcFU
 XOOX/d9mW7++oBX5AWawzn954Ydtf4bnXpFKCC3VOshb7Wlq/ec032C5dwxvVMJIfRQ5ux
 SDTXnCbs7SPHhevTt+F0O8XM+mcj5PM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-qxoDSUhxMQKOR-ENT8ipWg-1; Sun, 15 Dec 2024 04:06:18 -0500
X-MC-Unique: qxoDSUhxMQKOR-ENT8ipWg-1
X-Mimecast-MFC-AGG-ID: qxoDSUhxMQKOR-ENT8ipWg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43626224274so10728575e9.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 01:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734253575; x=1734858375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWQExX/Bkd5EWlI8DMzxeNmtXkiXVxZ5BzUuDMLVkIw=;
 b=Ca6+rkQBOAtWGuOn0aeoRMq8QxFnj0UgE7hV7JI9ba8JBQC5wDt7FuJZvCs1NxkC5w
 nhGt36ABsRGAxYFZWfv/1M9hx6GdqbbqjhhoCVaBmukgTIEyp6f8dHeTil3vCYfnPCEa
 l1v8iYl6uixvxSPhPKoJNuwju0cLl6Scx9j1ymc0K+ou1eum7ZcTinXqO0+xHBxkX/Qf
 wn8ZIG2YLAj26ZZcNViP0/TYfkAys6ujAne5Fq3lFRYx4DECxNpkj9JJ+DdZzrzAudnI
 JZ2RJm6kcVoHHHSFtG+0e/YmScjJZKpeXSgkFU5vOCOAybTGJKifqusukU0aplwYY+eU
 EHvQ==
X-Gm-Message-State: AOJu0Yw58bSSzoaJThAfDeZD/LeIEZAm2GVT9G8W8wMSwB/QQhcEEXXD
 uWv/pJ/l4XNHDC/2hp5vHOyBqmbeczg6LsDyc834ynUbWpqgZnAZ3varuSos4+/cjtxlGgryL7+
 jR+rNw8+a63rpN4AxBrxBDavX6mvAmjYBWCedOU1Kq1xIlvfys97ZqOcpuGbUvQCGJ9K1kHA8xl
 XrIc+ZSbKCGEsYGpyxvSUkFl4C0GJHnU7k7ps3
X-Gm-Gg: ASbGncuxgBrmksDiuIJN23OgnlDQWxtXgsxM7efXt8kbTdYXR90Oz7G1dyv2H0virzV
 rusUn/HtgdmxRE0WbaOFAPuVznyHH/O6xBvsh7Q052O5QpzHPTbyTVJRnw1nT9tj8DdWLoyQJWq
 Bnemp2fuT/80YEcwFBl761mdBOyEaN/RIJe4ZxtYgC/amMFFDBGwq/sjuMz8IRvjNphSjTiEuH2
 6GJmD9VJ1oxEsYPNEwsQN9w5WDE3mTqVblOy9GECaEwg/O8/3m+uceS1Pw=
X-Received: by 2002:a05:600c:1c07:b0:434:a852:ba6d with SMTP id
 5b1f17b1804b1-4362aa3df0amr79983365e9.9.1734253575350; 
 Sun, 15 Dec 2024 01:06:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjOvcvMdh5sAmHdvKlFsebcc016IFhqSoUPSrynaACAzzO7oYYL+saMdpquzlY0exA3i+PyA==
X-Received: by 2002:a05:600c:1c07:b0:434:a852:ba6d with SMTP id
 5b1f17b1804b1-4362aa3df0amr79983055e9.9.1734253575002; 
 Sun, 15 Dec 2024 01:06:15 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8047055sm4776764f8f.70.2024.12.15.01.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 01:06:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 00/13] target/i386: optimize string operations
Date: Sun, 15 Dec 2024 10:05:59 +0100
Message-ID: <20241215090613.89588-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This started as an "easy" fix for RF handling in string instructions.
I then realized how broken repz_opt is (patch 5) in that it was optimizing
for the wrong case; and that redoing the optimization would make the RF
handling basically free.

On a microbenchmark running x86-on-x86 user-mode emulation, stos and
movs execute about 40% less instruction and about 60% less branches.
Performance is very variable, because it is limited by memory bandwidth
and because the out-of-order processor does a great job of scheduling
all the useless instructions executed by the older code; but the
microbenchmark results seem to improve by 10-15%.

Paolo

Paolo Bonzini (13):
  target/i386: inline gen_jcc into sole caller
  target/i386: remove trailing 1 from gen_{j,cmov,set}cc1
  target/i386: unify REP and REPZ/REPNZ generation
  target/i386: unify choice between single and repeated string
    instructions
  target/i386: reorganize ops emitted by do_gen_rep, drop repz_opt
  target/i386: tcg: move gen_set/reset_* earlier in the file
  target/i386: fix RF handling for string instructions
  target/i386: make cc_op handling more explicit for repeated string
    instructions.
  target/i386: do not use gen_op_jz_ecx for repeated string operations
  target/i386: optimize CX handling in repeated string operations
  target/i386: execute multiple REP/REPZ iterations without leaving TB
  target/i386: pull computation of string update value out of loop
  target/i386: avoid using s->tmp0 for add to implicit registers

 target/i386/tcg/translate.c | 342 +++++++++++++++++++++---------------
 target/i386/tcg/emit.c.inc  |  56 ++----
 2 files changed, 219 insertions(+), 179 deletions(-)

-- 
2.47.1



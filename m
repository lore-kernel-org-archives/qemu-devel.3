Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEDBC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6Cx-0005Uv-3e; Wed, 12 Aug 2026 06:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu6Cv-0005UE-5P
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:29:13 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu6Ct-0002im-7D
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:29:12 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso161166066b.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786530549; x=1787135349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oxQRXS7v42FKVGJTTMz20DEkewRPJnwRUlem3xt6bbc=;
 b=joqUZjCINKih0igqKgWNwSI+Y2VXETSHiOElGk3q/QtxRUElU7L316Smvoq8faRRjP
 39dmoBLjGuRFGYLw5bI32PvfHl4Vi5U4y07tGZjkFyi31tLHmDR/1i0cfI2FGfQDROyG
 Vxezu2wQPXwk98uiSSkwRCSV3b+e5JlBACxM1v9WSsuL1Q99S7nfdpb8pOiJ3D4/xuM/
 VQkPkhF9iw3q+eAL4jhd0ngZjM/ZA3ZpX2jAKpilNgdTTmLQTy3ywFeHuF72obajZrnp
 Zy28j3q+pRk5nDHSAWT1T+3eSmHrp+bY/rychakbPH3QJS/p5P4P97nhIbQrgkjyLGOF
 1PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530549; x=1787135349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oxQRXS7v42FKVGJTTMz20DEkewRPJnwRUlem3xt6bbc=;
 b=gBfBFbWNEdWnrFfjCodrZutnJu77oFIVWs50x0SCqLTbhv1HgNmgOPg3EO7YQz5QXl
 1dSH1Dz3XGwbuDegeK2lRgYjO3lolXTgnXWxY02zeBjLeFeFvf8ShiLKDkr2DuNcli9x
 fQp01fxIRwEUmYVtdp7gCHr8ZFdmNR9D9LxC3f1G3YWnyqguzDGEgiEbQnF0hCpqqj5S
 XIv2YxGluY47Djsk6vD06cSHEM5LBDP5oKpXhqlY9H/Nc3IZfDllHNu2TaLLtrqHdieY
 zgl9U0Kzm1uHnTjs01EK5ivgLxBcDx6KCUuAx5hNf81KcQ2qVU5fzJ3FqkA5mH1/kP/N
 uu9Q==
X-Gm-Message-State: AOJu0YzObe/YzqDGXBVbIQuS9518Iu3Pr9IYGRzZWfwOrs5szA3W8IIc
 456zPWZYjE7zQIjo0fzJg/x8UqbEK5YlYYeOrjWp0Xyb/NyG/mS9GEZ0hbhIb+q4gXAEKp/1b13
 9N4o4
X-Gm-Gg: AR+sD127fSuDCQOMSaKF93ql7ClIOy1MvHbIjjLJVbPHhMy2Oc3ZmlNLGc6ELycFYW2
 UDiMkcCqBfWUht2EjpdtBsOOJFdhA9+VCey5BYfwic4RDuJv8LFsbrJPrzhL76JzIZU1GQlzr7d
 sYfH5Dew7GGX4KSgMJKdqs3YaViBOPNevLLiMQ2motdnD6O83DGijyPz1yAei9N8P/Fu7yNZa3M
 2CKCb6CuIemac+08VDsGoQUHcW3KE/DfKKLnrCKFhUiWtuzQ3BrRH79UpisSOts/XAWRzKUiMZ2
 5eyRyF4b1ZRKCdx3F+5I1HqlZ0dwmDFis9NtkP+w8xs3HAJS4NysyFB5rBiUpDVOEcunCsMKzJM
 24skENeCYg7oadZ4ftUWaEqc+sHAMZsLxe3DQ8Jz4fxDXwUDKjpAFBRbVL1CzHRiBBGduMu3hzd
 EwmuMiH8QczPlUQHzMFBHOZuNlAI+kL5NDGexySTBFtUQQjABe7LOgOgydlA==
X-Received: by 2002:a17:907:1c9f:b0:c1c:6d29:8a11 with SMTP id
 a640c23a62f3a-c20f51732a5mr148378566b.13.1786530549360; 
 Wed, 12 Aug 2026 03:29:09 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20f0ad270bsm70748466b.46.2026.08.12.03.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:29:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 0/3] block/nbd: fix a race in reply processing
Date: Wed, 12 Aug 2026 12:29:03 +0200
Message-ID: <20260812102906.894063-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=den@openvz.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

s->reply is documented as protected by s->receive_mutex, but the cookie
which owns it is cleared without that mutex. A request waiting for its
own reply reads the very same field under the mutex, and reads it twice
in a row, so the owner can clear it in between. The second read returns
0, COOKIE_TO_INDEX() turns that into an index of -1, and s->requests[]
is accessed in front of the array:

  Assertion `!s->requests[ind2].receiving' failed.

  (gdb) p cookie
  $1 = 8
  (gdb) p s->reply.cookie
  $2 = 0
  (gdb) p &((NBDClientRequest *)s->requests)[-1].receiving
  $3 = (_Bool *) 0x5555558416c0
  (gdb) p &s->in_flight
  $4 = (unsigned int *) 0x5555558416c0

requests[-1].receiving lands on in_flight, which is non-zero while
requests are outstanding, so the read comes back true and the assertion
fires. Without the assertion it is a plain out of bounds read.

This was hit in the field, on a virtio-blk disk whose backing chain ends
in an NBD node, with the virtqueues of that disk spread over three
iothreads. Two coroutines of one NBD node then run in different threads,
which is what the race needs: there is no yield point between the two
reads for the owner to squeeze into, so a single AioContext cannot
produce it.

Patch 3 is the fix, patches 1 and 2 are what I ran into on the way to
it. The order is dictated by patch 2: it routes every cookie to index
conversion through a helper which asserts the range, and for the cookie
of the reply in flight that assertion only holds once patch 1 stops the
error paths from leaving a value chosen by the server behind.

Reproduced with a scratch harness which drives one NBD client node from
two AioContexts against a real qemu-nbd. At -O2 gcc merges all three
reads of s->reply.cookie in nbd_receive_replies() into a single load, so
the race is not observable at all in such a build; the gdb output above
comes from an -O1 build of this branch with the two scratch commits on
top. The report itself came from a build with coverage instrumentation,
which is the kind of build that keeps the reads apart.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Denis V. Lunev (3):
  block/nbd: clear reply.cookie when the reply is rejected
  block/nbd: never index requests[] with an unchecked cookie
  block/nbd: clear reply.cookie under receive_mutex

 block/nbd.c | 53 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 18 deletions(-)


base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
-- 
2.53.0



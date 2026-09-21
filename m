Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35D0C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Ypj-00081l-KV; Mon, 21 Sep 2026 03:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x8Yph-00081W-S6
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x8Ypf-0006sE-VH
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789977177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8xcxYIcKz8qp+fwci8Yjop1cyoel8MCFV5Yft5a8wC0=;
 b=gv4UKPS3SuuczCgR6w04c7Q/6phGzUDeQEtIhbfIzXJD4/ftaVNS06n3nI+6zvPbKhQNQs
 VCLoE5We0Iib90reHdX0VAPE4doGvSrp4gQ8vLaNJf8nTZW8lWYgdzMHF8eGuL8XVQoO+d
 UFm1ZyhvRAsnjs7YLzXzXLLBukfajNE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-t36yzVmLMbuvBLnA9JsvFA-1; Mon, 21 Sep 2026 03:52:55 -0400
X-MC-Unique: t36yzVmLMbuvBLnA9JsvFA-1
X-Mimecast-MFC-AGG-ID: t36yzVmLMbuvBLnA9JsvFA_1789977174
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e635a6002so30851415e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789977174; x=1790581974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8xcxYIcKz8qp+fwci8Yjop1cyoel8MCFV5Yft5a8wC0=;
 b=G32hjV/ZCsCHaTJ/0OrGSBUO02H5N0RKbqSYVLZ+Uqqy1o3mQ4Wm8GJtP0ngNs3fkN
 o3pmN3UlmDjmxEYMKl17dg9j6IGenrv0xrWpKOELBk3ZkiB90VC1yYInT95FAHAVX9FB
 Y8I0jLkfUmO7UGXc/MSRGZiSL74f0XN0JTCp1Eh8lfa9NY52sRI35LCs5txEzs+9Ow01
 6oem0EBCGmWtUVzP51lOv2rj2vXYjTwXnhocsxHQctn7Q2BhVICfFaH4QY2nOOP0zJdw
 Q6ZAGsafykSK+hG39ysbtznKJyCF6IY+B1LJC77F1x1gXzv9oSnzD7sQg4YA8ozc130K
 Prow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789977174; x=1790581974;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8xcxYIcKz8qp+fwci8Yjop1cyoel8MCFV5Yft5a8wC0=;
 b=R6b8RP0DmcND0FwXbdpAXMwu5TjqcBC2eLDjhExjJcL7vNktL1H6CWFvLX5eVaevV7
 ClucykP7wHJh212Y9HvOGEegeeW6BEtuPidk1twWpoUeuKZ1AQBGt5NqZaf/d0dWAVFE
 a/CxP8UW/HinB2CsHs2weObY3yPIbWk+62MTONdfWOJKXhhxN4XILY1GoXKSGxyYwOMp
 WT9NsUT0xL+7IDdURfnmD8QEvktsYtzrJUWkTvorWUITyJubW/pfV5BJ5AGp9wL9pSEx
 QjTSRIfGGSzg7A8aGmnruPf5xpdtkoA3g1OZ2Ioyj96gW2NkttI8MIiJ+AQW6C1fdoGq
 shKg==
X-Gm-Message-State: AFuF++kl0Zqw5tRGUTSdOyTO8LOKq5RC7HswqoUU1IVRIvMdxuf8gNxW
 RVdWSsmoryDpE828Ujer0QeineNe795v5T/ZUaZxYxv/NGaeMlZpzY2vd+SK2XCZ7GDGlzLF3w3
 zU2Mk41OQMwzkx/Z8E5c9vuMvaRiLep/j2SSTMUb/6aFxa+IMTJN3r7NUsljwfvRUhBSwvtGiOX
 bXZRzD3k3NEzWVC0fkWGRgr4ha9bbvkcVPNfBBi4+T
X-Gm-Gg: AYBFou1KrhSsviSghRypjgDH/vPPQQVjGqRs7X6lq+DhKZpw7nrOC0xxZIJKpM5flMG
 szXrLR88D1Rd0zgWhXZ4l/tWI8jT2cDag4+/pLj0KypAaozHcn5EQwswFpx4/KqO9uSLxCZdfAf
 gji+lr6gBd1wY8mw1H0raDlIjh/mXef8/C8t3zJj6g0Lj9KPVo77DzkLY2AaM6HCR7q9AMbLVl8
 hYlcHxlzcQ2JJXlye6ORFYvhd2Sotmw9TNl8+irChWkyPuddnt0MxP16ydXFp3xt0s5hARGWVLS
 xWRHQfDO4u21RRc4KtwpiD8gm1qZEJRkv/ZlVRwstHLvTB2WvkXKIApvhj8hvXaTdZIx+gCqNaK
 LOURecsxaEDyhEa5VUoAHgdcVhzJLL7WCBrnDhO4k6Xx2edsOXbbq6AgXCIbA/hzCYELkSHnX6I
 uYcHt2
X-Received: by 2002:a05:600c:c490:b0:49e:6e43:ef13 with SMTP id
 5b1f17b1804b1-49fc574122amr119896635e9.24.1789977174295; 
 Mon, 21 Sep 2026 00:52:54 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:49e:6e43:ef13 with SMTP id
 5b1f17b1804b1-49fc574122amr119896275e9.24.1789977173829; 
 Mon, 21 Sep 2026 00:52:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd07411fsm219658985e9.7.2026.09.21.00.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 00:52:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v3 0/4] docs/devel,
 AGENTS.md: a completely new policy on AI-generated contributions
Date: Mon, 21 Sep 2026 09:52:47 +0200
Message-ID: <20260921075251.12831-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

WARNING: this is *intentionally* a full U-turn from the previous policy
and discussions.  This is not a refusal of the arguments presented in
those discussions.  Also, it is still a request for comments.

I've explained in v2 my reason to "try something else".  On one hand
attempting to introduce small carve-outs did not work due the impossibility
of reaching a widespread consensus on this topic.  On the other hand,
some contributors have been posting AI-generated patches or even larger
series, most likely in good faith as they predated the introduction
of an AGENTS.md file.  This shows that AI can be used for useful work
on QEMU, ranging from small incremental improvements to new device models.

This is not a free-for-all, which is not a good idea either.  Maintainers
will want to apply their own considerations (see [1] for a good list),
and contributors should take into account the maintainers' preferences.

This is an attempt at building a process for contributions that use AI,
heeding Conservancy's advice to not shun contributors or maintainers
belonging to either camp, and keeping in mind that maintainer burnout
is the one thing we have to avoid.  Some of these processes already
existed, but the possibility of AI contribution makes it all more
important to write them down for everyone.

There was not much discussion in the previous version.  I tried to rein
in some of the language that allowed too wide interpretations, to apply
the changes that were suggested, and to clarify those choices that drew
more remarks.

As usual, the text including the commit messages is informed by discussion
with plenty of people, mentioned in the Cc trailers of patch 1.

Paolo

v2->v3:
- remove parser example, replace with "adaptations of existing code"
- when LLMs are used for boilerplate, "highly recommend" disclosure
  for "non-trivial, functional code".  The idea here is to avoid
  having to disclose using AI to apply e.g. changes related to
  automatic code review, and leaving people some leeway.
- clarify split between DCO (legal right to submit code in general)
  and AI-used-for acknowledging that the submitter cannot audit LLM
  output against e.g. the training data.
- clarify the defense-in-depth/swiss-cheese approach to limit the
  risk of copyright violations from LLM output
- mention that pre-arrangement is not an entirely new concept
- mention that maintainers can demand larger changes than for human-written code
- do not mention inclusion of the prompt
- add checkpatch.pl hunk, changing the phrasing of "no AI" lint
- rebase AGENTS.md on top of existing file, split
- drop CLAUDE.md/GEMINI.md symlinks, already done via .claude/.gemini

[1] https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com/

Paolo Bonzini (4):
  docs/devel: relax policy on AI-generated contributions
  AGENTS.md: add final instructions
  AGENTS.md: let agents know what the participation rules are
  AGENTS.md: make the human part of the design process

 docs/devel/code-provenance.rst |  71 +-----------
 docs/devel/index-process.rst   |   1 +
 docs/devel/llm-usage.rst       | 202 +++++++++++++++++++++++++++++++++
 AGENTS.md                      | 137 +++++++++++++++++++---
 scripts/checkpatch.pl          |   5 +-
 5 files changed, 336 insertions(+), 80 deletions(-)
 create mode 100644 docs/devel/llm-usage.rst

-- 
2.55.0



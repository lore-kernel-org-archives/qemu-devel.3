Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87D7C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1R86-0002bB-VI; Tue, 01 Sep 2026 12:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1R85-0002aZ-0W
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1R83-0004EQ-6V
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788279269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=19G4sFaAyvOiqZLggzmyDfE+f2TgUAGJu34IcNqZtc0=;
 b=Z7yK1YUAwykLepO4KjtcAbt5Yf/hiXzF5B5FX+J0tK3OtI0W1SlceOxPy4mJj08voAJ3Jc
 n7qbblvEQ5AMkMwkwjDTA6pHF375xaNO6057gEiv4FnEPMeLMPaj9hW/LIesN+QelZlJSL
 EsPV5g/VYPc0lvH/krI22aFd2yIydEQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-mwHVzj_ZMFKS6J-f5IygyQ-1; Tue, 01 Sept 2026 12:14:28 -0400
X-MC-Unique: mwHVzj_ZMFKS6J-f5IygyQ-1
X-Mimecast-MFC-AGG-ID: mwHVzj_ZMFKS6J-f5IygyQ_1788279267
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso10135715e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788279267; x=1788884067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=19G4sFaAyvOiqZLggzmyDfE+f2TgUAGJu34IcNqZtc0=;
 b=sx5qOAcSW4aaDncu/tOOT0a0r/VsNSJwDuH5lunG6OoJyjaWKQe4Xk0PtCvTb6jA3r
 TVTiPbcmeq8qsPSb8ougcbIvyx8DvYM3U6w8lh5MU/NLTI+fKZERPH5Y1LEfZLYtoUH+
 ZdEMmWnegyHkhSLl6YgMpL0MpJ4Xk57gt/U4UC6llly7T3f345P2RllzapM7d+re3kbH
 aA2pvC4A8z86JgFkT0rqSgN3fPp60Vh6/VkIlmk4Y9FYh6LD7M0n2YCPtoGI3LDxDOCL
 cER7uDHl4gRr0bp25w5XJkGBiIqIsQA3wC3z9k8DET82M/1osegC4KqrJMXayk0uUNj3
 YrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788279267; x=1788884067;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=19G4sFaAyvOiqZLggzmyDfE+f2TgUAGJu34IcNqZtc0=;
 b=cabMUqp1HRuamTDWr0G/a1MJ37P3UdAjWR0Hw3UKGYI62P5RJ1i1NRNKzFHT3H1q2Q
 oEyBGaPEh9KXwfOgRJcKDMCukXXDTmllGi5R57LM4GpJNrYs0eXC7XiAraC2TI131Li4
 NS5i4eVUsRwllZlMl1s1b3Gq3030fzYyuNCQbfbtLGt72Jok9vks1zjKDxvjTOR2hB3l
 FbLPW8xLRBjMR0d0dpaXbjJraXh6r4Ol6vPSOmLhiPqd8aIT4YDSzXVfVb3muh02CtnU
 rAjKb9P/YbAKdCNGH/DWKvQ29/TTtUK1ghIr2jh0HVy0T/jx/xKHOOrtuzfOm5ZYLkle
 ulJw==
X-Gm-Message-State: AFuF++m7dwW50jQA/8mVzskVC1PbtGcs4S+29XMUi1PO/f3sK3r9b3en
 0G3pFEh0UtpcxMVvUk7NBYrQe3PZEB/IhwFxi9ShgPX5S05Vwg+Uxz9QZjp6UDxpi6sLLZsS/5h
 M7kqvEPFXaE5ptCqhyfXLQ3fX3YIoaYw6lmnGRPe6SN2Xj88cAsh3Ofc+iuL+fsepxPdlGRNBMk
 rHhcwsmBEwC34tLNl/c6bUuADJjLZ4q0thEVzFnGRu
X-Gm-Gg: AR+sD12eCsIWjuxTZa3ER4I4LnLYpa822AH3DEiaoBwAsRgjLeThxGJcci6TyfQXXYc
 eX+Dq7dP7J0/0ylchMAPkkC4oiE4vLfkyhqAqXn4Ny2LKJd2yq+dZkKhuPWBK+e3c2yiVtaaEvO
 uL6nalXq/x8VPcCO4xhfGSn30RGxjIaGO5vsbxpOjijbsFoaliNWYb6QuGMmt/4JXyRZjp+D1NS
 WN8S5FrQ6QxZQku6+M3YBlqlPxoty+p7ZuKF1tnZJG1sWnPvOgHB+LfZFHwZ3VbhOmXl93apACc
 m/4l9YtfIzPNApvYjVZOpWGZx337FsCC6rbYA8lt02QFBYpnS0a6KEmhOIeMqU4htxSuHKItHZq
 wFjxCp2+XrBCPWywEdjiXnIxrJW1bC5lYgPDdFvMrkunE0vBorWmxn8WiAJPtb5hBX+FRNRCU20
 AH7GA=
X-Received: by 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id
 5b1f17b1804b1-49b91bd99b7mr609993675e9.0.1788279267012; 
 Tue, 01 Sep 2026 09:14:27 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id
 5b1f17b1804b1-49b91bd99b7mr609991135e9.0.1788279265991; 
 Tue, 01 Sep 2026 09:14:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccd1e19desm341365315e9.1.2026.09.01.09.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:14:25 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/4] docs/devel,
 AGENTS.md: a completely new policy on AI-generated contributions
Date: Tue,  1 Sep 2026 18:14:18 +0200
Message-ID: <20260901161422.314581-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

WARNING: this is *intentionally* a full U-turn from the previous policy
and discussions.  This is not a refusal of the arguments presented in
those discussions.  It is also a request for comments, and not something
that is ready to go.

The reason to "try something else" is that previous discussion have come
to be a unanimity trap.  Attempting to introduce small carve-outs for
tests, for doc comments, for bugfixes did not work; each case will
have someone (rightfully) expressing disagreement and the only possible
equilibrium remains the current "no AI for code generation" policy.
The Rust project also acknowledged the impossibility of reaching a
widespread consensus on this topic.

Furthermore, we have clear signs that the current policy is not blocking
some contributors from posting AI-generated patches or even larger series,
most likely in good faith.  While the policy does not require maintainers
to police AI usage, "don't ask, don't tell" approaches are best treated as
a red flag.

At the same time, a free-for-all is not a good idea either.  Maintainers
will want to apply their own considerations (see [1] for a good list),
and I think we want to heed Conservancy's advice to not shun contributors
or maintainers belonging to either camp.

So let's make a new hypothesis: that the no-AI policy is an equilibrium
only because it's stable, not because it's good.  Attack the problem
from the point of view of maintainer burnout rather than copyright/DCO.
Apply a large perturbation, and see where *that* discussion takes us.

As usual, the text including the commit messages is informed by discussion
with plenty of people, mentioned in the Cc trailers of patch 1.

Paolo

[1] https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com/

Paolo Bonzini (4):
  docs/devel: introduce a new policy on AI-generated contributions
  AGENTS.md: Let agents know what the participation rules are
  AGENTS.md: make the human part of the design process
  agents: add CLAUDE.md and GEMINI.md

 docs/devel/code-provenance.rst |  71 ++-----------
 docs/devel/index-process.rst   |   1 +
 docs/devel/llm-usage.rst       | 179 +++++++++++++++++++++++++++++++++
 AGENTS.md                      | 116 +++++++++++++++++++++
 CLAUDE.md                      |   1 +
 GEMINI.md                      |   1 +
 6 files changed, 304 insertions(+), 65 deletions(-)
 create mode 100644 docs/devel/llm-usage.rst
 create mode 100644 AGENTS.md
 create mode 100644 CLAUDE.md
 create mode 100644 GEMINI.md

-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6A6CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBq5M-0001o7-Bx; Wed, 30 Sep 2026 04:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5K-0001nx-TY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5I-0002lO-Ir
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790758479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2Hcb64L706f+uiyGLXfN23w5rfYDEh0B3dDS/vpmVjo=;
 b=MagMF1Qli1dpfBK4Imr+NfUJqmchamBwrqHIWOXnMyniaKgCKjkcmplCfEKSoryD2aFJ6Q
 Vgj8Iz/CqW/wsSctgJccF3+Iy9OcRu5ms1+cGsG7VmBQmwXYWMy8pPixbdQxLrUx/aGR0v
 aSb6KFxWVqE/6pk3R3FhvgcoWWl56Nc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-D_xCyRD9NhmOWx8GOV2-Nw-1; Wed, 30 Sep 2026 04:54:37 -0400
X-MC-Unique: D_xCyRD9NhmOWx8GOV2-Nw-1
X-Mimecast-MFC-AGG-ID: D_xCyRD9NhmOWx8GOV2-Nw_1790758476
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4870af30a85so1449220f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790758476; x=1791363276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2Hcb64L706f+uiyGLXfN23w5rfYDEh0B3dDS/vpmVjo=;
 b=uCtqUyVp2FVDLEDa0poWc2w3dtxm+AfwPRLXXLJOz8KjSae/Gc2rJJviYlmQd6wyrQ
 SQPcVv8NjS+cgh2X9Z0/uKXRlHNi7X8tFippAV409spL24g58y8E+d6gY8o2pE7+f4XR
 ecLipfwrTu/R4lR1HZuX+vrFDIje4WABovge6f1SMQLd01EjSBZ+R3l5XOFAhRiKENZE
 JfajdbRi62Kw6OBG7Bzr75kJ0yl0VH9NYgsKaXosZTio56wBbdVrcTlf2+1/pZAhNu8q
 VYA3NiDxKzvl2mQ7ebx2TWRT+eubUKySZZVsnqxyl6LRF6uFW/VbJS1IztsAyKPWUFva
 iPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758476; x=1791363276;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2Hcb64L706f+uiyGLXfN23w5rfYDEh0B3dDS/vpmVjo=;
 b=juWiN4y1ThQjuXqcuarV1WwDwUOHwFKUo9kLAtuaxHCaqRchQiGhywhHpnehhYt+C4
 FiUV0HTtt6+yMcwoySuYcVU/WHJOhPSBwqT/riAoWEg7gXHeoxuI1WRi9tyuArFdqbZ0
 NS2SvykG5yEj9E+mhtnaGa4zCFTIgdL+vJxXM9+Lm+htBZgG2DrQYIGKLbqcZYRH50wb
 1ZNcWpPNnOwKIXhh5a1Te/GSzhrzsHW4iRhaxdkSnPac1cVZV49BcNy1kj1pPn/NbDXI
 W6CzIfemoNsbobnMhRODhVw/3lOcF44LhL0O+cAioslYedPILCYo+fTUF0+UB0JLj/03
 3vFg==
X-Gm-Message-State: AFq9FYIzhfBEOjWxtBdi7rfMN/BcTloTdlkc/V2nerlqxnVUSPe8v5yW
 38PY0KNk4+s1FXAvUXtanIcwD24oRCJHmgfPJ8+auP0x0AZYdXESQP/XTaLQsb7LydMLWa+dqsv
 Ix+wp+OWTNP0FXdxi6tqMHc8IAX+DKh+RinmcRRMlw5Qa807Dw7ZjR4xGOJa+Cv5nkB+gxjUqd7
 r4S3lQ7OfanzlVr78/uwXLx8tlbb/NluO4y6W7e0BO
X-Gm-Gg: AYBFou21WUNsTge8IIhe51lvxWf63tHZ7LXfPKhdlhG4BEdtgD9hboOsN33qbwh2TsM
 rnvHielqnRMafKQVz/aPpy8h5HE4T1IyNW+TiCKj6jVnLee8DA8FCQhsU4872ewsT6SjZ8UDHPP
 Iwg/Js47jvxGnM6l9lxcyhBLXSP7aQ4yDpIshx7KEfpMyoXzVsvlGgAvNd8JOFmbyHD7QxozpiE
 EdvtOEk04sbfCqhaeNhKgmB7VNqLFqOwB/rxu7WrPyqquMStiabMW0/6yNyPw3qmadq6hNU9ku+
 0vKPl8wPtvmBk6S3K3Y7xkaxUxV9ghrEtVjroKgkkYQE2wqbQgzRUjqC/Dbm5mnLwsdyTn2zAak
 fE88fnqWmk61ydc57Pu9EYWXlsLngsldgS04s3WKx6WdConh/JlDdv0ucJdtzXTHqgXIpVqJNmP
 M3M/dV
X-Received: by 2002:a5d:6f19:0:b0:486:f3ae:7d93 with SMTP id
 ffacd0b85a97d-48b02737091mr1508698f8f.12.1790758476332; 
 Wed, 30 Sep 2026 01:54:36 -0700 (PDT)
X-Received: by 2002:a5d:6f19:0:b0:486:f3ae:7d93 with SMTP id
 ffacd0b85a97d-48b02737091mr1508638f8f.12.1790758475891; 
 Wed, 30 Sep 2026 01:54:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029bf85dsm2061093f8f.13.2026.09.30.01.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:54:35 -0700 (PDT)
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
Subject: [PATCH v4 0/4] docs/devel,
 AGENTS.md: a completely new policy on AI-generated contributions
Date: Wed, 30 Sep 2026 10:54:29 +0200
Message-ID: <20260930085433.830743-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Based on the previous discussions, I am finally attempting a non-RFC
version of the new AI policy.  Discussion on v3 introduced interesting
points on attestation and I think a consensus is forming.

Why review the policy?  The blanket ban no longer reflects reality, since
contributors have been posting AI-generated patches or even larger series.
This was done most likely in good faith, as these submissions predated
the introduction of an AGENTS.md file, and it shows that AI can be used
for useful and creative work on QEMU.

Rather than expecting maintainers to police these contributors, the new
policy seeks to ensure that AI usage helps us produce better code rather
than simply move faster and flood us with dubious work.  In the words
of Warner Losh, we want to avoid "free as in puppy" contributions[1]
that increase the load of present and future maintainers by adding
technical debt.

This is not a free-for-all.  To avoid maintainer burnout, AI
contributions must be grounded in respect for maintainers and in the
existing contribution process.  Large, heavily AI-assisted contributions
require pre-arrangement with the relevant subsystem maintainers, and
will be held to a higher standard.

One of the reasons for the old policy was the issue of code provenance
and the impossibility to certify the originality of code created by
AI/LLM tools.  The new policy tries to adopt a "Swiss cheese"
approach to mitigating the risks implicit in accepting AI-generated code
in three ways:

1) by requiring pre-arrangement for larger contributions, and making
maintainers free to apply their own considerations (see [2] for a good
list).  Maintainers' preferences bring experience and creative thought
into the process, and contributors must take them into account.

2) by introducing agent instructions that help the contributor drive
the design and understand the code produced by the LLM;

3) by introducing an "AI-used-for" trailer that scopes areas where
Signed-off-by cannot guarantee full control of provenance.

This series reflects feedback from earlier requests for comments, and
even earlier discussions with members of the QEMU community.  Thanks to
everyone who provided feedback on earlier drafts.

Paolo

v3->v4:
- rework opening text [Daniel]
- exempt "official project agents" from not being able to post to
  GitLab [Alex]
- explicitly forbid clean room reimplementation [Kevin/Daniel]
- remove "The DCO still certifies that the contributor has the legal
  right to submit code in general" paragraph, replace with a note
  that "AI-used-for" attests respecting the policies and is considered
  enough for DCO [Daniel, Kevin]
- make the requirement to "understand and explain your changes"
  more prominent
- small edits for grammar and clarity

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

[1] https://lore.kernel.org/qemu-devel/CANCZdfrTwfrK0wnuL2cPVF_9W2-8PXtJeHkgkTP+Uv2sT8s0Ng@mail.gmail.com/
[2] https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com/

Paolo Bonzini (4):
  docs/devel: relax policy on AI-generated contributions
  AGENTS.md: add final instructions
  AGENTS.md: let agents know what the participation rules are
  AGENTS.md: make the human part of the design process

 docs/devel/code-provenance.rst |  71 +----------
 docs/devel/index-process.rst   |   1 +
 docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
 AGENTS.md                      | 137 +++++++++++++++++++--
 scripts/checkpatch.pl          |   5 +-
 5 files changed, 347 insertions(+), 80 deletions(-)
 create mode 100644 docs/devel/llm-usage.rst

-- 
2.55.0



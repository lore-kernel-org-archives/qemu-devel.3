Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A96C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4bM-0005Q2-Rm; Wed, 12 Aug 2026 04:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu4bI-0005PQ-3D
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:46:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu4b9-0007DJ-2i
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:46:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so6996395e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786524364; x=1787129164; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=vxpANR/5yMOAXn0D5VMPZGj8tNa5ITas9wtz5/oLDToCggbHdatedlZrr4bR/Mb9CO
 UHkNEkifwnnzXQgwE4lHSL6Yk+A2X8rYAIVkMtMpSl6aR0VHpMb/StIxihjVzVOU9sac
 j0mp4aLlk+xX4JmAET5Qh0v5B0zj1EVIvPFUOxOYdyqAK7Wa6mY5MVVuCfb0q3xp1z3H
 PxmLm33B+RSTnX+qVb3oH9l9OycDmVjZQ+dG+cQYlgxHH+EDlqjHJMG7be5g1cTXmY03
 euhqqTtA1zzvPhh+0BsjwAQFS5WReNW+G8oH2Nvr7b/N1JBlF96e3717a2FbS47x7WiL
 F/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786524364; x=1787129164;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=MY9ylD/xjUBMukjuWF2A1LtbV+rxLpLW3OnEdEDScdc9vVIYcUTawHqsAcVhO/xa1L
 YaTc8d0esctSVys6kZrsHIB+m3yjU7+xHqTEPQl9a4twyj+FSUwgNDxd6KzwjOMyGvTf
 SjcfDjY56v/BLYZ0o8ouIyLrpkfIRfeMDx5Rzijj6tjbiEupBHipGAtvUu0vfjNsb4Fz
 d/XHnifezD3pjdnqLmB6LKxrCvevZ4f1lG4YdXV9pDOwzIBmAv40nFx13FS3APiNgblY
 wLndurc7oQa2nvz5LlIPVFdEneB+w3tFHXxk/T9evLFFvFrWjVwf6bjLH2GmIgR1PIsa
 a5ow==
X-Gm-Message-State: AOJu0Ywcb9L4dHpQ0qdnPpVjP8a6nP0vmT7esaxz2eumYqvQ9y+MuQLs
 Ax8ktCas3OrY8zx6ySC6VO/LLJrvqPXl75VAM8IKVuM/d1RSVoTGUSRdxkuxumf+NJ4=
X-Gm-Gg: AR+sD11ZivU0E8zQmirq8MEACxQxYEbTHMbzXL99mNVYRzC7OW3QZU4peZxG9dqImtn
 R/+pfhwLgzItlWp0RQ39P2hyJlXbjTtxQ7fFGnOuTXb7O5Zwy64XpYcK+6YfRHbwRZ7DSyzKgnc
 Xjsb2X/0ctbsmChv/5c4hVDaK3efCGwlp+hwfZ+hz67SI2A/h/w0zkWDKHSu3qw6fxlvrgJqVTC
 urG4q3FxyBkfbxtlmivCmwnIcz6ngd4HJkCzLeNjUpW4EvFEP8IF7FFNh5MhvA3hK3B2L156X50
 OUylb75ra4ph5PvKtlCKWzJg1xZ4NEIiFeURJmmoZCzw5+nMDNxk9wYAaDNBTJTF6NV8iuxwpDv
 hX7uNAsskPh7cRfK+6+COufnWdyS1UTkPl0J9fHFVGNgDYgeuHFsap2FU/VW4LGOI910rxQv/Lu
 x1fgGqEzb7cfdw9MuXUcb8PzPQXxt+CFmz2wX262O50vD3GsLD2V6L1VK3cHrE/Dd+RwkVkvY=
X-Received: by 2002:a05:600c:4688:b0:499:728c:a1c7 with SMTP id
 5b1f17b1804b1-4997c3f159dmr29861595e9.5.1786524364118; 
 Wed, 12 Aug 2026 01:46:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c9417bcsm41480455e9.4.2026.08.12.01.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 01:46:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 31D5A5F886;
 Wed, 12 Aug 2026 09:46:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/7] tcg/optimize: Handle min/max opcodes
In-Reply-To: <20260812003143.225228-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 11 Aug 2026 17:31:38 -0700")
References: <20260812003143.225228-1-richard.henderson@linaro.org>
 <20260812003143.225228-3-richard.henderson@linaro.org>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 09:46:02 +0100
Message-ID: <87o6f720c5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


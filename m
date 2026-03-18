Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3197C10706E1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nt3-0006F8-9F; Wed, 18 Mar 2026 06:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2nsx-00066D-Bw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:12:20 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2nsv-0006rA-AY
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:12:18 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ca9ec3ee7so8140664d50.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773828736; cv=none;
 d=google.com; s=arc-20240605;
 b=eGXXeuqku4GvrL7aVWBGiN0GfeQi3vzubz1E4riNwtF4KYAsy6gjcrphDG6XTJ0xlS
 zVKB0vqqZbGs9DXmIfkZt1VivL32o6kmmjHZJsXcwe/8GCr/aqh7stgPv1Lezk6D7Wx4
 vYyNajOuP0PYLvHTWoAT/lpgnMBuyB44O9+nYEcqpkYBrk6zdqASPZ9nh9nzXSBqwYxi
 ADWt4ipP0hMV8Y8PHSLWV5BdcngP5P5oto35Cfh0w56SPW1AUhjPrPPVQaytlwxpsGBb
 gSnWQzGIO3oX2YRS+CYK9BLZZb0gjAwOipMUKZPctSc4H6tvgYyMO3sq3DYUNbPbQSs/
 aCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CKYGWIbsKDxC6NL71HCTLt6L34oq29gbsuD8lOS+Ttk=;
 fh=rUlx1AzE4gGDPpJM5XpZ5NUxPVkV0ukmf3IGHh/CzUM=;
 b=H77FInQHufjvpbd7uAnGanfNgpAsfZnmxzWYxzg3eT237TxG00ktN6TcxGyb24Zcvy
 /oy3i0eaDv0CT9Hq9m4ZGbC5akhMliaz+9htxci5BLgteSub7U+1MCI20B0Qg2cl2CGy
 JsDgZyutvY7XTMvlw57uHOmHlhyyLDPcn87VJxkN7K3TpiiIw5/h6MkgW8cHvKhTtEbT
 q+aihe8nGv+6IgWJjB5GuUO5zFKKIc85CRDub4hnFC0Jp9TIn9+igT27TOlyWHLjg1Ez
 U6D0C6v+HlqLt+YkfqIyrULZP3Fvkx9iLoK2l3PthwUJ6pz01X90tJTz7zc8iW0UcgkR
 raEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773828736; x=1774433536; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CKYGWIbsKDxC6NL71HCTLt6L34oq29gbsuD8lOS+Ttk=;
 b=l8TQwm6DzOebHccg3Fu/ZEUgpgvdN0uSF24nhopwe2nu5IW65DQHBykJ0VxiSVP0Or
 I2rr7ucWWkq8KCKe9CDppyzI3bFhoQ94wcoHZ9yIuz14ljK72c6EbEbKn5yz/RqTV8DO
 ZcAa9SkDTS26eWxBKdHK21PQgbpp7IS/cut55YbcvE7353XgKXui4MUHQTtDI3B7yOzA
 m3YHTNFX8iNxZeBnAAjDiCMc4bjz/4DUVPskLLhuNHYNSpxbXOViJQgD/Id9SNJ5XWTv
 JMVEyLjr3V99GTPhj5eaj7IZJcCvOKK2zTYK5RpAlFNcY6O+rkBNq34itbcjJ+aHMX9G
 DQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773828736; x=1774433536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKYGWIbsKDxC6NL71HCTLt6L34oq29gbsuD8lOS+Ttk=;
 b=cMYWMFqo5cR/iJKsBPCWdmxv7IR/18laMDsedTdwOu5sTd5YIqaOi+FVG8bM8voPDw
 0o4uNqoisWkYPVsPpjcKhDqr6x4eprfM4XvuPWLhD/In3MWqWVIWFKVccLykFlR+SOOQ
 nRBNcerdrmj7G3AeC904jtNUzF4Vqyf4WWfb88VgzomD0vvL4f20H6alCP80+VjfnC96
 cQ64YfLgx8VBcR8yY0wRcFlRZxP1KLMJMawIeavsXff+Au3Tc1qpznv6P5iQ9RPNxPoA
 Zh7RMGNLUxilR/8Wu6V6f/u5HpL0h94mbN1suxUfw0KxsJmqEv7r5P83VXfhTAA9D+Qa
 gNgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVoxVr53zUF6ck6KfCK//6BamW0sU21wD6PXLYYzT9N93+t7BCrA/ozw8bpMjA8qV+RnSYb3HoUW/k@nongnu.org
X-Gm-Message-State: AOJu0Yx9QLuUW76sNRUZ2xf0YE9suGervcndLCu4/vjnLGtcCFVqWVhL
 RLb4tnhpE8Z+G+Ro0/7lYgiP+u8uDW/823Ck5WUJ6iNzYBP1vT6Im5JHLXkv1FwU5VgMb3PBt6X
 QmZ81V+QX/txKPFAnq/S5bL8D/eAHEFKvj6uvdkwpjQ==
X-Gm-Gg: ATEYQzxvA/ddUyo0ReJ20XNueDdtux/SK2ADHHSmBSdSsc8kRjsKYbZncXvPEjsFCme
 dwM49XM0Oh2Pry3qauG4ejMorL5HzYOfCqyFy3+yvL3FsIp4TIZINrqy+63tI8A01mRPAWG7+Si
 iuQ/A5T+D0W8aYX47r2YxaLrJutmpcz5AdA5H4Mie/v0a2WO8BFW+dt7lFSVuZ4CtpGDvrckVDC
 hb3Dwjc/F7EU9MNM0PCGummMvJmYadc7SofkJKwxC8Y3i/rB/iGh7ZBNkFNXyPAPusdgwvzTDhi
 sijp2krzkUPmCvUK4hEf/G+0MpaojErDHy/rXQLqQF7GEddu8LSK50rQeqLemcB1nyGM5lHOg+C
 jhg==
X-Received: by 2002:a05:690c:a4cd:10b0:795:1d73:4d7d with SMTP id
 00721157ae682-79a7182db3emr22210087b3.12.1773828735721; Wed, 18 Mar 2026
 03:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260317134521.112121-1-hreitz@redhat.com>
In-Reply-To: <20260317134521.112121-1-hreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2026 10:12:03 +0000
X-Gm-Features: AaiRm52kkXuS5R03OFWJJ1anUu0dL7wmB8srnYRY4hDwy5TaCtgYp1WWfpEjorM
Message-ID: <CAFEAcA-8Z5yBD816LLzjcvWo3aD8-n8ik5Og4=fXXSCQ-0S7mw@mail.gmail.com>
Subject: Re: [PULL 0/2] Block layer patches
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Tue, 17 Mar 2026 at 13:45, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> The following changes since commit 559919ce54927d59b215a4665eda7ab6118a48aa:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-16 13:07:33 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/hreitz/qemu.git tags/pull-block-2026-03-17
>
> for you to fetch changes up to 9ac85f4cc7995217db8f736733b990d6addcb036:
>
>   block/mirror: fix assertion failure upon duplicate complete for job using 'replaces' (2026-03-17 12:31:54 +0100)
>
> ----------------------------------------------------------------
> Block layer patches for rc0
>
> - Fix race condition in throttle-group code triggering an assertion
>   failure
> - Fix assertion failure in mirror job when issuing job-complete twice
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM


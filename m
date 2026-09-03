Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2741C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24iA-0000nb-LN; Thu, 03 Sep 2026 06:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x24i3-0000n9-OJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x24i2-0003mu-Ax
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788431417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvIpx0iLmbZJL7f8WJ+Uyqg0WseYHSTdLLk5y1EY4cM=;
 b=OQCNhR9R5VT1+55pea79lH+TBdn0mOUqLXxx80z/bx2Ph2adksFJvLEAIiVti62Df5XFIs
 iVgQeIKR/2GV5Otj8/go3snmtFmsyM7/N8I8uYFahjn4aN+LY4cG2LxnUta/UoxtZAPjkW
 /RQMFPe5bGwq3LsYK0c0BgempxkpTPU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-GdaDlbvsNiOfCOLajr3wHQ-1; Thu, 03 Sep 2026 06:30:15 -0400
X-MC-Unique: GdaDlbvsNiOfCOLajr3wHQ-1
X-Mimecast-MFC-AGG-ID: GdaDlbvsNiOfCOLajr3wHQ_1788431414
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-496bbcf7d1eso16550785e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788431414; cv=none;
 d=google.com; s=arc-20260327;
 b=Z35tKZLWevxb7KR9aNY7jyzCj8PnJY85aUzq5bdbmEmzXVkMJOm1Nd3ybyUOXP3MX9
 WVsxQU0OWwODq+NXqCGqtNP5LrJ5jVMTjnQMYjcE8VCDJC3cn/wIM5s0S/dIJTgzdhml
 +QU35INOJ/AfZfI4ApbQCM72w1uOIfFpncnS4XFAHkMO9x1wfPD7lZvHuK7OQlwf7NvD
 knyoUqXdc1LSCjYstydGtprtV8Pl1nfGzja395RmsHgYAbmMCjhIQp+Eg2aAwIccQl00
 4/zVSoi9xukt5DX0zusVviVWazaL9MLUkOoWX/KM4u1aP9QBz2lMHiT4j/IKJjUWBlxf
 O2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vvIpx0iLmbZJL7f8WJ+Uyqg0WseYHSTdLLk5y1EY4cM=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=INa+Ui24nrzlzFhntjmcbnWIyASA3fOebeVKV2B1KZzFA8qsrvtoZq8I1nAYwF1h+2
 f2Ktnd+A3hFK2iTlRaA/DCkuBzh13OHNZ/Vex9q6RP5PdEErMEL7f/XxczNe4w5ceKuy
 tr+hkHreHJYDx6eZNUkqhRCQJZOp4cHNww3nzS+ZvLrGa6um7Yl9vdqyLRIL1RasUmCG
 u5cHw6aTIm+LLaPptdI0DiU+KZY1ZpSyU3J+SzF9HOnGLynFT+wThKRB+sPoYzF5d7Hf
 ft0TYpphT+Lqb7i+Sopcj0ITQCVjCBjgLqI/R9VQaXsrsUJjtAc16YXs/O0WuAi4j0sJ
 tQfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788431414; x=1789036214; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vvIpx0iLmbZJL7f8WJ+Uyqg0WseYHSTdLLk5y1EY4cM=;
 b=LDP0ldhpqc94bu3QuBmnUutyICBpCBAs/2Caj7p78a1CW8ucPc58lHd/bK0ocB59BQ
 yAw5ij0wEbQhMHrzqMPLkZxh7dYSR+huXfRs+vdNQrunDwFMp97JEeuBD9Xk4oKT3GRs
 zCFY04XSxq0+hNdKTsr9P+ZIg1SK0sTQaYE6i5oUGbb1kJgI4fxxPANdIMLT/y6m7tjY
 r5BplVhxHWPo2EWC/s+zkMDHsY4KH/sjpTtpyJ9WxAow7lo3mbBSrCwVtN/AR8KVcUH6
 jKdq15jnf0m5eHlpzNKZd2BQBNUkff0OgteNwBztJZOpdDy3Muk9nqGCKtIcRu24JP10
 ygHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788431414; x=1789036214;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vvIpx0iLmbZJL7f8WJ+Uyqg0WseYHSTdLLk5y1EY4cM=;
 b=cwuZEyDcvy1IWdKAXb6hVKfxIit0cdHvKyppHOTSmMLzzbbeVA6UNZvbrKGQzjMn40
 seQgwsGzMgwBvZdy+8LOwE0uif9zP5hJRYv/qSaveBQTYDynPEPYTa44kKqpLFyMGVto
 zrrQI+kZSNNfjCzbxpN72HiGnGBeyjVbG4yoxFp6XFXcV2293JO5QoP84PSoEe+sGKgw
 dWU1e1B5kVjMUyHlLzk1Zz5vVr2rUZ6b7ltHybt29ZxO921L5OSaRD0OxMU/Dk97v0td
 eBMkb1qADxk7EWoXM2tXSzWHOYAZcVVcRCDEBccvbpNFeOLFooTV3qx9Tz9Vi5Cd3f80
 0zdQ==
X-Gm-Message-State: AFuF++lIqjB/xoOg+PWfA5L0zMIM4RsKigX/+jsTKkAqfwxHCfzNeiia
 fH89F9ruP0L93wRq7ynHIdHfQal592w5aqKR6BGimULQiSdItOlX7tXyZ0FO5KB+6DbjLVh7PgY
 q70pjota3TF/bT2Bx0KZjtMtkDcf2PtyR56jWQ4RNdaZRYTMfg3U1QbrYhJOO9HdZdBkdRLRS/9
 7/cj5IHrgtEw4s8BOhRayKKnsASE80Jhs=
X-Gm-Gg: AYBFou2AAAsEucpxHPAKN1tOBcMSQn3GpBc1umPXJ0Yx5jTDLBO5qb+QY4RePWIgA4A
 zJP7NjrwVOaI3LJyUBL3+jvwBRegY28xX3P91NqEB0gNE+rkpOdSwWUGd77K/RvYHhHCqfOVQzX
 BXw5+nHcaUhio+h4ptjebDPASnUutkAqtKPuxRLoudAG7thIybfLT5jNyWilGbcX9ZctHZPckAQ
 Bq2W5QZkh2YYBGA6rNbHzlHq3WmS8RxWkcWZm2HYwnBNzApHo3vj/+6OBmf
X-Received: by 2002:a05:600c:5307:b0:49c:cfbe:5a76 with SMTP id
 5b1f17b1804b1-49ce55ecd3amr225654685e9.2.1788431414490; 
 Thu, 03 Sep 2026 03:30:14 -0700 (PDT)
X-Received: by 2002:a05:600c:5307:b0:49c:cfbe:5a76 with SMTP id
 5b1f17b1804b1-49ce55ecd3amr225653355e9.2.1788431413950; Thu, 03 Sep 2026
 03:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260903100441.781277-1-pbonzini@redhat.com>
 <aplIdioRiKdK5gqg@redhat.com>
 <40f3f1da-ef32-4223-ada7-642f6798eb19@redhat.com>
 <aplLMqiQrOP3yvfY@redhat.com>
In-Reply-To: <aplLMqiQrOP3yvfY@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2026 12:29:57 +0200
X-Gm-Features: AcwNN1VlaiIo_52Mz7U4DlvBqXMYfeJrM-s_wMO3HeaHu7aoiFuVDpZMETEC_gs
Message-ID: <CABgObfbWPE+uLuzuTbANbrf00ohaJFj2R_u9oW4c68iiafHhLA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: reject trailers that credit an AI agent
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Sep 3, 2026 at 12:26=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > For Claude yes, for Gemini I guess it's not really needed.  BTW I have =
no
> > idea which coding harnesses use Co-authored-by specifically so this is
> > really just a guess.
>
> I expect Co-authored-by is often added by the contributor themselves

$ strings ~/bin/codex |grep -i Co-authored-by
- Commit messages must end with `Co-authored-by: Codex <noreply@openai.com>=
`.

Straight from the system prompt. *puke*

Claude Code also has "Co-Authored-By: ${d3o(at())} <noreply@anthropic.com>"

Adding "noreply" to the list is probably a good idea too.

Paolo



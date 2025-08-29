Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7D4CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmB-0006GQ-4U; Sat, 30 Aug 2025 11:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1us8Iw-0000tO-C0
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 19:14:46 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1us8Iu-0004tP-Br
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 19:14:46 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-541c760fda1so468480e0c.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 16:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756509282; x=1757114082; darn=nongnu.org;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SXA0e6NQn/DMrZIRbXW9RSTecrnWBuqvCvxMokaMr9k=;
 b=u3SlBtpq+ALBI4EWo+IJBcwiZwM7SZUQTC0pgVbN67zMXRli+7oMYwVYEY98vr1sK+
 fK1YTrWnhHOja6zeh49CIspNizTYkiHiDn+gyxJq511hpqARcvyNKuR1cyKFhSQMsfUJ
 yQ88C6tFCFmXh4FI/2r9mKaP65c7diTPjdNlE2UlnxPJ0Yk2zaOpQfEwfe0fb2BsNvlu
 1WC5oj/r7AhT4BO0ZVNbVc7FqQX1Y5dSYqbvcGbpf3YYcAeff7Qb5288faWIthbKXxWo
 gJY6aUqgGfYU07CzKSQngIQSKsxE8/ws9pTZ5D9JSCqKM12LfHYLbk96vOq/0YCkMnXX
 +u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756509282; x=1757114082;
 h=mime-version:message-id:date:user-agent:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXA0e6NQn/DMrZIRbXW9RSTecrnWBuqvCvxMokaMr9k=;
 b=hVMjyE5W8MbE9CHL0xSd15UcAfHkXk4xy/wyx2j5mNGXq/7GI9dQN/F+pcDzx/oWUB
 7ZwNhtyDrhkB5Cdf632AXhRArrve+ohJq732NgXaBYnscZ1B01B672Pt82n1qi3qLi22
 xes1RYUsV+8dYfLJ48tHA/jV4oZ2eB6iUpjRLwVM/QU8wEuedNT9hpLHSbwl4z65Jc0+
 3zhrxO2lUeGyxt46//R/V/LlRIzYAeIWxeqByg0EMLwHIQerMmZo9G3TTpWvGri064Qd
 V/Z8RJ8w6Cri96coMixb1VU0cX/ASu5VCJWDpb+eS2ZxhMYNCqjDu2Pn+0ADG0eEs8nZ
 h/TQ==
X-Gm-Message-State: AOJu0YywAWKh8SfPnT6Xh55viqN46Qydf+/WLvTdtD8PZrDAVcDf2JrM
 6UIy2rKL/2Lz+sKp/SqYxMIhxvR2+vZpEU+TUbBAc/l1oUdvbJS1psnatqLsuGpZ7PE=
X-Gm-Gg: ASbGncvD4vpl9LCA4Iqm0Vx6DN/hhPJl1V9BBnnZjFRagz5tCGxXXQKiBrwhmRy7Ww9
 tEkYBy7DndiFNgo2r1soR5lqOXtzDr4zetqGwAwomyefBIH3qZKWK+pUPkV9FXdPR0/OounnyIU
 0+xLKJJefQxVXKDWSHn6g9Slmhg2FFbCP1f2cJCL30G8+5dBkkAtLN+iWTKyCJBlUB93kr4Vgsk
 IY59Un/qeEfdPB54Qi8hMx8qz4YS0RpN+i/XpidN9fZEOQbBOWV1knV5Eu8iiv09O6PAYhT/cOH
 tZ4xlUaje6EuuZZZtFBN1DD5iUP/ROrtAqzxFefV3Ng+qDLQDSfaVLIUgL6Ea3X5tDu1bEH5IH4
 xmFxtcHv1MWEiwoN/JILNpYABXKjkVNg=
X-Google-Smtp-Source: AGHT+IEvwwMQoEqh0dgnANx6uBLDqYvufu+iEOWsCAJ8SQiTTI0w108A2L1cn+52ntkn1Z3BCvqXEw==
X-Received: by 2002:a05:6122:659b:b0:541:2e11:6738 with SMTP id
 71dfb90a1353d-544a02a9309mr80095e0c.9.1756509282546; 
 Fri, 29 Aug 2025 16:14:42 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:88d6:4d63:9b22:f928:fdc])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5449131c808sm1623391e0c.13.2025.08.29.16.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 16:14:41 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v3 00/85] target/arm: Implement FEAT_GCS
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Thu, 14 Aug 2025 22:56:27 +1000")
References: <20250814125752.164107-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 29 Aug 2025 20:14:36 -0300
Message-ID: <877bylk9er.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=thiago.bauermann@linaro.org; helo=mail-vk1-xa35.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Based-on: 20250727074202.83141-1-richard.henderson@linaro.org
> ("[PATCH for-10.2 v9 0/6] target/arm: Add FEAT_MEC to max cpu")
>
> Tree: https://gitlab.com/rth7680/qemu/-/tree/tgt-arm-gcs

I tested the branch above with my GCS patches for GDB and everything
passes. Thanks!

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago


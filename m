Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A644EC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjzG-0005rD-HF; Thu, 12 Jun 2025 11:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjzD-0005mN-SF
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:37:03 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPjzC-00012a-4Z
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:37:03 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e81826d5b72so1101965276.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749742621; x=1750347421; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wUzfaRCNXWxAipjWVnsPLleFiVr/W7oIJEdJrgXZxBQ=;
 b=DBVmA+d2LRcR/u2lSj6dLjxUuvfCZUr3n0g13PqVLKoztunEckEl/6hZEmX3jXDp49
 uLwIa5CbnIFh9F/drl3h7wWO8ieEVw0fa0IR+2SBgp8pwzyKFk/4jEu2EYz5yR/v7kcv
 Px2aSzQnYpzyOv3l7Zv6UE1cAialB3zpDIrhO+bznTV1si46mXkAFB9YAgAhiEl3cwdW
 5S9hcsKvp6oC5tMVKGV33vnOp6A6+5f+IRYA2ZDPYcx+0l6wbE9BKRRpygm79cSNdJ9o
 FRuhvkRY6INc2fjQe5pQbHMMWCEQ+ye6q7cAhMuvOfRMb3Vq8RO5OJejg1B/JMoZpF6u
 nFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749742621; x=1750347421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wUzfaRCNXWxAipjWVnsPLleFiVr/W7oIJEdJrgXZxBQ=;
 b=iQWNp/0bdgZixHw2bpIT0bXj6uIbIhX8eNGRqUhJ4GmwjxBmrXR4HKBpd7ioYUMnO+
 n4TS6kyzWpEeBZgQEjmSY7wj1bbG6CQRHkUsGsJYojZCdK80UA3MiGm3fi4TZzmcPaA9
 3di/dU+zRJoBSlpvjPLjq6h0pCS5lVAgBwCJwE3O86BEOvMLmhCEL5/1+XSAWbJcJdk/
 XpX3+bSgZ91nPK8L0nSlQpC7IcYvb759moSH4039ZFnh+5CDDMGxwjxFofIOOzxSSZBt
 AEkDT/M6QPckiOTtEVGZ9Rng+6P8yY9gWRW4ojbCWFs95NWekkXPr8AGEZDGdr8l3Xrw
 DuSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7DuLhZxZK1oVN/M7sneOrNus30XzAEUgjX06QcxXhVqE1YbGDHHjAeJpZaa8cr32HydL9xCzTGrs0@nongnu.org
X-Gm-Message-State: AOJu0YxRXIL1p9h3Dx8TA4ApWy7EePZw3pUi9FuRAcq16CjOJiTE1lgg
 oC9f1FHt0dUy+cw1fTkfy1QNxE9N4RCKe7siSY7Y4/AlQNGCop6JqeiyS/52UP9cFF2/3tujB88
 mGXZ58sM9MUEUbQLedL1C2GmthS7juQa5p9b8YoEI+w==
X-Gm-Gg: ASbGncvKDdXI9hs/nl2bQTAKxGKhxDjAD2+Xt0YdXGRIxqjZKo+Ikgx+78IbmSbYNQW
 sJJTr2+WpUqmG8AULGuv7y6ZxsYWNx4Py7PZ4BKhm08D7TXJu3DCYsRibDPbr2CuJ9eh/XcdIEc
 8eEaYniMv/emoT71nvnb+GKQWuFqclizzyEwK9SSEpa7cE
X-Google-Smtp-Source: AGHT+IFAtm8qzr6DZ3uaSYxOLv9IeVEoJWiRE3BZrwJ8yLOpfYVXBv3GPKSCSeTz/MFg2VqncxBQeUgBAgmpJHSNC0I=
X-Received: by 2002:a05:690c:6f04:b0:70f:751c:2d8a with SMTP id
 00721157ae682-7114ec48108mr60341587b3.3.1749742620984; Thu, 12 Jun 2025
 08:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250515153907.151174-1-cohuck@redhat.com>
 <87ikl99oxg.fsf@redhat.com>
In-Reply-To: <87ikl99oxg.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 16:36:49 +0100
X-Gm-Features: AX0GCFvQWjJwiT3qdzhS5zCC8eN_284PdbWsiIoJoiu0vOTKgt6QJf-RLSBsf38
Message-ID: <CAFEAcA-t09k_mcZhHRcHZQqdTfzn8-E3vjGoL4ViFfoZmCBk5Q@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] arm: rework id register storage
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Fri, 6 Jun 2025 at 10:53, Cornelia Huck <cohuck@redhat.com> wrote:
>
> Friendly ping... anything else that needs to happen here?

Sorry I've neglected this for so long. I'm OK with the general
idea, but I've commented in a couple of places about compile
failures and other things. You'll also find it needs a rebase,
there's a trivial conflict in an early patch.

thanks
-- PMM


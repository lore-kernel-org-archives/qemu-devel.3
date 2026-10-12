Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C916CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDFy-0007Ky-Al; Mon, 12 Oct 2026 06:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGDFl-0007JW-Vy
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:27:36 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGDFj-00057P-6z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:27:32 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b094046a7aso1698077b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791800846; cv=none;
 d=google.com; s=arc-20260327;
 b=eAV+vSgOquEwzbWfTplp8NFtopXRRxlcDA+uxphxjlSWjz7bTiRNq/R6PQ8QejC9fq
 PF6MYYh9S/nRupR9JOiNdQsOnu/GtJFUwqMMGuqG/ZIKjwhpUWjTATydq+C0cY1a7Dni
 AOyrbUa9aW5dOLJVxR5UsXqfSb2DgbA9S0xQvHP32Ymb1TSGs400fg6kdJ8NrHYDFt/Y
 ed0GYDhRM8MPGGBZawe+nlhxpJqpXUmwbt0JRjvjBYB4kBaiiZoF3R+COsLZLMCRjX6s
 Rbt/Lo6pEcmXNvM1isypKtC2X4FhY5BcqEbs8IlULN7Nsky7E3NgWGDpj4eg1FMepmO+
 88yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aW1fhbUGu6OqgjQI+qSffpqhlyHcxg/42Q5aUE4TzTA=;
 fh=z46AiCw+RUjdSv5Wn7hePQs1Ez3oK8s9me4u1FuvHzM=;
 b=kQ71NuBi/ri/7UP5D61YpRMQTk3dViAF2C3CF8fw3HWWgk9vuM2lr2V8jE3JZGFRyi
 XjwBTDZBX8uOXx0Rs7mlTT6VSp1OpjnBULYToxW7eX6d3+R2ltSRQM0Z0OGU837juDPB
 haslGxDyJCTPzJ52TPs0ou1im9pOmkycWZd5jBX5pec8TcsXjA117vQQlNXK4ZddA3sZ
 sXSuu9AZdcAgc/CrImws3sHRbl01SI+TD94LK5Wu/BUMkPOKefqhz0cDqnXsiizx7Yli
 JLp2kA0avkGdOP8fbIaOnyaErp3fj7xl2MHblWj9BXyWY4YYHIEWDNCuD+Ytnrn/U5Hf
 WPMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791800846; x=1792405646; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aW1fhbUGu6OqgjQI+qSffpqhlyHcxg/42Q5aUE4TzTA=;
 b=N19mDcPKvhYgbKTJMBWmfZzvOnh+rwioUop7zZkT8mCKlDxFkF/9d9IktUSriT6pLC
 KQmEcn8sZtX3wsF8nqcScenexxGUVYBKnyLIYkAsRn0vHrcOeoqdjr3knohAzA+yu4n3
 LOxXj8Nz1ffooj9BOVmUo27eLVwWIYlUm/mwTb+sPQhymvZSJvQWhGZERZqjsQbdh1ga
 nLXpjxN3o8tDj0+xPRAPhuvcdHd1Bjqc5bJj0yvoBiS1IsjCUImjWzUaSibidsg5aJFN
 aBIYzjPqxNIwF+99cQsNYWEgpHZm/kjwH8eIDkNRNyTscnBec/CMZ/yilovDGvUs2S2b
 5mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791800846; x=1792405646;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aW1fhbUGu6OqgjQI+qSffpqhlyHcxg/42Q5aUE4TzTA=;
 b=FWgSwAh+BmZ9/kzpj3J2uw6kqidgW2Ch+Mv/NyZNkVQQ9xdqApXB42soXQI1uw3mvc
 0sAAy6I72Ks0xhcbNc8xx+zojTEutbbWKTF5l7HG2aWS1B/FaO5oC+0xIuqW4mHXuH2V
 OnOwpX5U44oAGokq9rEY08HbvyoNsPJ2msIdPZbXSYcQPaaRGzr6QIIt1Z6TnFDQhMAC
 2kRwLQjecEbJZrhIFAQq3rSbOsQ2Eo9HVakYDBCvSCQV7Vvojfe5/n91oUb1wfqU/EiN
 6lE9nR8VkJfS7fmwfvpZnlY6hRCzjH8f2MXh86iBs6IjJmlI1CdD8RAoHxLem/5ycvbb
 ui6w==
X-Gm-Message-State: AFq9FYJhiy1wD9oh7ILM4R38iRYM9dtIaTVZpyr6qxhR3tehjKkv2qYQ
 jJCn024YIQZsh0DBMx+Vct74g4LrnCEDpaB2BhcVjj0fSwPr7Ly3JNYTea2sh24wD9kyvYtrsPU
 GpzK3sCy6YZYfhZa8oK7Hbc3pgVwg93Cmm/I7Yuzc7Q==
X-Gm-Gg: AYBFou1BQ79o3MgYZLzchBkjT80m0BOUL6HnsSWXOF53kGYLo7FCu8jnA9sLt6RYnds
 JuxHyIuEMSS18cgd0ZrArHiHoIFI31lYS1Sy5bf9NX5aoITztvwK5/lVCGxzeNvF19HMR7euJHF
 3VYx0/rHaK0sh5JCUJVVeB6PjlXOUWsppamUQwDyouKxgiD2wK8jc1R6gEyQIUv3biaCqZ/qszB
 mWZiU8XpurDjY5NGTslTc0otJhRfAjpvhZaFFjRzXX3g3iCgPiWR8gFHc/K+GGcnBpvfkE635Ee
 sBhpaDVhI29RekuV1WkPZFoH9Jdrpklie3pIPDiuldq/sAbGjCeg//bGrWs1WNDGinp0aalTdYZ
 2GlpVowJlOBaTYta+tJ+n2tz8wCxZzupF5UidgX8WXmRPdmj+KA==
X-Received: by 2002:a05:690c:6182:b0:8a9:a921:13c7 with SMTP id
 00721157ae682-8b07ee5880cmr30824607b3.44.1791800846408; Mon, 12 Oct 2026
 03:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <C38CE953-7A98-42C7-AE35-443BED94674D@archimede-energia.com>
In-Reply-To: <C38CE953-7A98-42C7-AE35-443BED94674D@archimede-energia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2026 11:27:14 +0100
X-Gm-Features: AclHuK8qEJqKaQPW0mxOYfZgMRkvdQZ65BCP00AZQHP82bo0Kh9kMzPMwOuJeu4
Message-ID: <CAFEAcA8d-jepdKubizqZKXPafY1jbLdbB8YjxcZ9MR38f_zp7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] STM32F405 timer and RCC fixes
To: Manuele Conti <manuele.conti@archimede-energia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "farosas@suse.de" <farosas@suse.de>, 
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 7 Oct 2026 at 20:38, Manuele Conti
<manuele.conti@archimede-energia.com> wrote:
>
> Hi Peter,
>
> Here is the complete v2 series, resent as fresh emails with both patches
> inline.
>

Thanks. I've applied this to target-arm.next.

Something seems to have gone wrong with the threading on this series:
the individual patches should be followups to the cover letter.
This was OK in the first version of this series, but not for this v2.
I picked the patches up manually, but the threading being wrong
breaks the automated tooling, so you might want to look into that
for next time. git format-patch produces a cover letter and patch
emails that have the right headers to thread together.

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C009FC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siy7m-0004TG-46; Tue, 27 Aug 2024 11:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siy7j-0004PL-Nr
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:28:47 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siy7i-0002X2-1V
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:28:47 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so7213472a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724772524; x=1725377324; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4yAlMlBA4ouTt0DGe3f9cAnewU9Z5AuKZeGQC3oO/yM=;
 b=VjdeJLkZq3A38hsqfxQ8z9jMh2iHOcjFU2vDLOUBeuLczCKkjbEVU3izm7Fbn2pVgQ
 mURYjF0JpUOIE/6z/lDzxoseq2C0Y+yU9e0lA6kkJWS8UEo61F6MBRnPDBHkkqF9PJ8s
 jSURM5tYlCuSdWT/Mn2Ox/CriiOnU2MHIi9iCR+w5AhiGx5BlLoxzxbhVxAdUiXMXlTf
 ZjEQepF7VA5/v4FEaGnjuPmzRc7WizdNuUfEnDzNhSezpUbYnI+a2y9L+wawHqQ7wZ7/
 at+tP1Ell4KRxZYU4l5/uI6EpBqVf/Y9XDMSKXQVCqormXqkqm4bmKNl+h1s7oQSxhj5
 K+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724772524; x=1725377324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4yAlMlBA4ouTt0DGe3f9cAnewU9Z5AuKZeGQC3oO/yM=;
 b=VxyAW/T+RcXNKJW7grfnxFUJl6QB3kSlGvBwgCIKEnGbMoowrZ2qMSxH3vaFKq3AjT
 mbnry5bQsLCPN/xBy5Hw9afOReuIJ9hfOQ0yfdun8jNE8zuAIrdLLMLK76vDJoY87Xh7
 7CMtL3hQAZC3AWIk95Q0WdEZq3u6TkqQHD8c4xo/znu7b77RCnZpaij+Q2WBJP2VNnPb
 s62V3q1tohEteBV5BpEAtP8o6zyctu+754P8YJi1CHkpEK1l544tLnsolFe/xpTwXNJq
 EM9ff4HCp7RjMI+0MT82l8bLWy5/fVlVYv4OYYTZZn8L90XU99N4Ix0iN0bH+0w0OZ8x
 Xu8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWcd6Xx4u2yOGm4T6VNe2yTKX3+sEzHvuiYIVZ57De+2ujtNJqjWjBinEAPJhH0KtnT/ARtoN205u7@nongnu.org
X-Gm-Message-State: AOJu0YwEy0eX6LUrKIK/skufkOAfdiQdgu0/Wrkl7gg4lfu4faVqeeqx
 xZjOxBrApcIyyrdw0GTGSKJAUR2sNndq6hPzig+zwmBmaF2cK6751cXs55mht5Dz6OCmF6W/kAT
 o2vu1hClg65NLLrhL7WAoik+B2WfFj5l4xirFig==
X-Google-Smtp-Source: AGHT+IHNXYKP+BrjeVYDN3n2Nvk0pm4G3DyCjzZQTu06RSPdP2LyJjWIHGARVO3uX/jlq7P9dttqNx7mclhmD5yRb5U=
X-Received: by 2002:a05:6402:1f4e:b0:5c0:c4d3:9017 with SMTP id
 4fb4d7f45d1cf-5c0c4d39303mr1334841a12.38.1724772524119; Tue, 27 Aug 2024
 08:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240827151022.37992-1-anisinha@redhat.com>
 <20240827151022.37992-3-anisinha@redhat.com>
In-Reply-To: <20240827151022.37992-3-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2024 16:28:33 +0100
Message-ID: <CAFEAcA9Xq7S6_-hYkNYdv6-z7tM7xSgDGyC92L19kTm02qScAw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kvm: refactor core virtual machine creation into
 its own function
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhao1.liu@intel.com, cfontana@suse.de,
 armbru@redhat.com, qemu-trivial@nongnu.org, kvm@vger.kernel.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 27 Aug 2024 at 16:11, Ani Sinha <anisinha@redhat.com> wrote:
>
> Refactoring the core logic around KVM_CREATE_VM into its own separate function
> so that it can be called from other functions in subsequent patches. There is
> no functional change in this patch.

What subsequent patches? This is patch 2 of 2...

thanks
-- PMM


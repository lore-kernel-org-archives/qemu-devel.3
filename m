Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA35CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1OJ-0002pL-Nz; Wed, 29 Oct 2025 04:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1O9-0002mv-MG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:18:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE1O3-0005Xf-Tv
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:18:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475c9881821so4374315e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761725907; x=1762330707; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q9tdhi6SMCKrV/uMVORoNV2nyNe/atRzmSSLlvNiQ1I=;
 b=dIwnn606EWVx4cNBVXnhzjIiIXB7JGNhDsn86YNFui5KHSKRiBML6Y/9jGj0hs1aUF
 55jm7QySpR3WRH19xl/k9TPlubqM/eCPEInqoWMZq5H92ftRi9jXS8OYp6lm9m40Se3l
 +nBWAt8uMZBMUlCeXG+9CA3NIoCx27/uwXNoOOH0sfGyFRQ1k+ohKzyuIX4ix6fpCcSB
 OPbVszohMOhxpfDDueRUwCYo8IVmOHmjxKCf9rF0GNrn7KJL+MKkHHImkUFio2GkGsYx
 FEQRPI8triBaGyWwGXkjhf7swuk4eve53GM6Jd8kZSkCF4+uw2JsboC9hK4UK2dKTPbK
 Q58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761725907; x=1762330707;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9tdhi6SMCKrV/uMVORoNV2nyNe/atRzmSSLlvNiQ1I=;
 b=GdjlOhXrNyOkt0X1iaJdxkjcRI4nTTfRbXP9Y50/iP+Sw449IpjT/2pGOtBPB8CrQ4
 qofl2JarZV1Cxa4mx78EBJaqYTtRhmDzWplHOMpHr7GLLfg9TQAAwWMBDenlfDFLXfBs
 jkmNmQtvfxAou/gqKqVt7X3CSgKSBr/0wDFYOYeOeB5M+k33BaeZv0wRrbWvHdbDF1yW
 juTiy1pVWedWf2wnpEd/+yHzW6wNupfs+rMZ3pq9iskRBlOOaAJeqJbU0YhtQiYAVcAX
 tulEL7aYFnFNZgQZB+GFD1RvEi13bc36pvf8PISNJoIqxdQcXmvGGZt5dLteQ6ION18M
 iLWw==
X-Gm-Message-State: AOJu0Ywb/1tN3K5Fs7vh7QXAQ17tDJ8SSl6VHs1Oaqtl0UjYf5Ugrze8
 0D+juWYePzvZEStsfzxwAPw22nvdPAsYLon8G22g/UqBX8JSbPhbtt4Dk9Nudrm4vhgBqw9aqYC
 yn6W3
X-Gm-Gg: ASbGncs2Xa5PN3jKbYPd60LQUv+U+KbDMd9gF+buOEoLCcuWVt0BeKHPTZlWBxuxofp
 TPZHNsSAN3G05z/o51b75pdy+O8syBlCCaYghPk6oAGML4qkBiRGpXlkOBibskmk/K9v2C2voH3
 ogSQZxr3c8P2OKOt6aGVRz0ZbVhhG2N+TxY0Ou+zJp8x5CgYr7sHnBfklCCVMZu0sWouKXI+I3Z
 K2yjOiFeKHaHocqZxsBs7avEL5SPAl7FLKnf/z9HwU6ummCDAftUHzfT5jc9omRRhrf8IP4XGyk
 GQqmV/ulqj6syCZBUvyZVHZFTYsVxj/+q+S9+cAZzQe7ffPviseaOqu3GkY9nZRMxpKKGjLr35s
 uIKAGvbY4FK6YPsi7q3fMRh5RPl4RZgvXrjzv4UmppuTH80zGWKaVN8xFvwgBMzd/13mfFyZuP/
 75T8lifmnEPzEGWNV+Ul98/5emenL6upzFXl6j30d9jcKa6kuG
X-Google-Smtp-Source: AGHT+IEsCo/W9/+yo8JioFVxnZTLzWLV8k7mkG3ielvycXUyNkeBRZZ16dKPk8K32YpyrR9zHmKjHA==
X-Received: by 2002:a05:600d:1:b0:477:1b2f:1190 with SMTP id
 5b1f17b1804b1-4771b2f153amr27628895e9.18.1761725906788; 
 Wed, 29 Oct 2025 01:18:26 -0700 (PDT)
Received: from meli-email.org (athedsl-4440624.home.otenet.gr. [79.129.178.32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e387baesm34215625e9.2.2025.10.29.01.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 01:18:26 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:18:09 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9_?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>, 
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: Re: [PATCH 04/35] scripts/ci: allow both Ubuntu or Debian to run
 upgrade
User-Agent: meli/0.8.12
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
 <20251027110344.2289945-5-alex.bennee@linaro.org>
In-Reply-To: <20251027110344.2289945-5-alex.bennee@linaro.org>
Message-ID: <t4vwep.178r78l9ikkwn@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=0.737,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 27 Oct 2025 13:03, Alex Bennée <alex.bennee@linaro.org> wrote:
>There is no practical difference between the systems when it comes to
>updating the installed system.
>
>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> scripts/ci/setup/build-environment.yml | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
>index 66bde188755..253d0b759bc 100644
>--- a/scripts/ci/setup/build-environment.yml
>+++ b/scripts/ci/setup/build-environment.yml
>@@ -24,7 +24,7 @@
>         update_cache: yes
>         upgrade: yes
>       when:
>-        - ansible_facts['distribution'] == 'Ubuntu'
>+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
> 
>     # the package lists are updated by "make lcitool-refresh"
>     - name: Define package list file path
>-- 
>2.47.3
>
>


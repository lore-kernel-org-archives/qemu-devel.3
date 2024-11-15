Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D680BD68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC05L-0004pA-2r; Fri, 15 Nov 2024 12:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC055-0004Rl-IG
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:26:05 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC054-0001Yy-5b
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:26:03 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so1400329a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731691560; x=1732296360; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cy0bpqhYABl5xQS0sS5/3rdfS2dftArPARrYrzeGb04=;
 b=J8+pYP0tSZb8i5L11YZaWyC8cHEB6fzcN2PpjrFoYHHO+HED5WJO+G76Ic1IwwX4O7
 ZmbQ0AXq82/rWwtjsdL45mfzgt6Ia5KsjpkzM5Q2QevYGRMGhC+1IoQ+Vvh9TknZK5Dv
 rZfCC9ZwAJH1/lW+L/c/WlTqnpnpOoNJX4jw+NGYkvtyfZKU5k7r8sZO/jTKRy2BY/I/
 QdeanMEohABNi2mV9Y1zGwlTIzM+i3VfqO3+pgXadgN8g+sBwNIhHxqW8qtHOLQVskje
 0Geh+y8pYhOEvVjdIJaXYCDvW8dNEQS4smsEyPHpdJ8/MnlZeLkxEvSs2XqG6J5j7RSn
 eM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731691560; x=1732296360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cy0bpqhYABl5xQS0sS5/3rdfS2dftArPARrYrzeGb04=;
 b=oG6v4ymKlrhOL4b0Q+nDJbmomiyinoFjPX2EeFBSnOhJw0jsi8Aeioy9FabSIVuLMD
 CqUa8woqjQURzLddowbLmzbMmQYAoPU8i+Uoz99g96zY1CTrVhWB2IqgHgLxa2MrHNmp
 vO7NEcvSI6BQ4ea/i66I5yLQDkxGoLQBFe813L9EgF4HKA36quF1WieqAKckLjfmpvGu
 58Zjd8wjGSUn+1W9Hw0VqaC1bPlFs5UKEmXcHyUHhfeymQsCjczTQGVxinURjFmYKe3z
 7zEwjw9FDRTGSJPbg+uxMY+GxBQr/cTLhD1Y4+XrO5fqYHs6E5Gok5a2mdDYNYO0zhC0
 1dIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHJ93/kTgbpT0iyP7nKu84WCGX0acO2d6P2R0ei+e9ZoI5waZJl8k8i+/5LNAJzqar7HaoQE7S33WP@nongnu.org
X-Gm-Message-State: AOJu0YwT32mhS1Y0tocR0IfNIh9puUqNb5okSSoSxKrE8XQ9fKViu4oG
 Fzp0Z2X/4PO0MwHMG/qnbapKz0jIzQZ+zftmkmAuxG0XxCSbODIAlcWcjUCdUqLntDQ1+u/are5
 alsMR3DSxDQgYmoMK9ytX8pyC6UM/NvZLz3GHcw==
X-Google-Smtp-Source: AGHT+IGCovN6x3B1ZP7h2lJTYiJm6pw/acTun/aa8G/JREOFEbSRH8Aj9O40Q7tA149aEarn5coRGqEa2KyFF7kiKT4=
X-Received: by 2002:a05:6402:b65:b0:5c9:5c40:6d9a with SMTP id
 4fb4d7f45d1cf-5cf8fd1b721mr1808724a12.34.1731691560442; Fri, 15 Nov 2024
 09:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20241115160328.1650269-1-roqueh@google.com>
 <CAKbPEtafvSf1ACPRQj2-eEGS_Son53rmyqZ_8vH8gx-uK4o78g@mail.gmail.com>
In-Reply-To: <CAKbPEtafvSf1ACPRQj2-eEGS_Son53rmyqZ_8vH8gx-uK4o78g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 17:25:49 +0000
Message-ID: <CAFEAcA8zJQ+3vwWm_cEbqqRuptdLm1Ts6r+fK8nR=a5C2jZtTw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Make WDOGCONTROL.INTEN the counter enable of the
 CMSDK APB Watchdog
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: farosas@suse.de, lvivier@redhat.com, slongfield@google.com, 
 komlodi@google.com, pbonzini@redhat.com, venture@google.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Fri, 15 Nov 2024 at 17:21, Roque Arcudia Hernandez <roqueh@google.com> wrote:
>
> Hello,
>
> I forgot to add the -v 2 to this patch series. This is the second
> version after Peter's feedback. Shall I resend it again or is it fine
> like this?

It's fine like this, no need to resend just to add the v2 tag.

-- PMM


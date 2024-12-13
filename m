Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2639E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 05:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLy0p-0008Jc-3r; Fri, 13 Dec 2024 00:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tLy0n-0008JN-Ad
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 00:14:49 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tLy0l-0002HO-BT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 00:14:49 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7feffe7cdb7so953721a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 21:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1734066884; x=1734671684;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F+JxJ+W7qflQ+2La8EzXyDPNgnobCVhuQmxAQnbJQnA=;
 b=DIkez/tcGfzGMC1VibjUl/24z11yNOvUdM1P/JjIxREIqzLmczIhDgaYc1q8aXQBiY
 tkd5d3qqzVIV3zC9XF+chky41GIAY67yCuY1LyWczwBu9CcA+9hAALkAMzSCRnbY07dz
 +OUuhrJWDfXI7kx3vC//WZQ762jfPbAZgavkFcByr5qR1OnUvLpbrGQrQDBw9VWoAxqT
 +Wn+JWP84g/M1MikGX6sXb8GZUB/aYHrgf2PffyuWN+jpkgj3SfXmcYwNRM4w1SV7U12
 Qm4AVZ2b1aIVI4gvaOCstDsptcai74DKVKecDVKlePkPfsT45LieE/GYgNnNTGQaFCaT
 NYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734066884; x=1734671684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+JxJ+W7qflQ+2La8EzXyDPNgnobCVhuQmxAQnbJQnA=;
 b=v64IUYpDqWrdEmKO7h6MNZLJR7sowzrIssDrxbh+BAq0Dpi5BO0wK/sW7ko1s+Y5LY
 dUKRrHc3TGyGBHkyaT7HVUiqMU8cRKkkmnZ+Gx9eirYssa9eVqhEiIOYNQpBQek/SDno
 GQLOlkKomdViv10UVM7fPEvuYcsQtV/3UGh7FvZxa0uR+n7Uem5dOHYAHU4s2NIkK9ae
 63X26XbvEuWaDMqmCA9+9yn8xq+rc6gCpdgCMdh+N7vdXJtFwAgCNrvHzsypZS3aa0ly
 I9feCusfoQNaSbghhDMb7QHBKE9bCzVhXoxfK6IBA/4wANSDIf0Q1OSR0sG54yOT5ssy
 cEvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXajA5LRVgWILmQG057o24Uf0Ulz/a2ecrqVGKPfazbo1A5r0VrzzoqRvZiaJapKXnF+O+S16P+yBH2@nongnu.org
X-Gm-Message-State: AOJu0YzlQ6usacq7AKfSQW/wexbmI9J1IV7dZ2TAQPkyNtturC/F38t2
 f+9VwZE5zNgMbwd7O5PM1Xx76fzO222BOCbYgavLX5vagl3nbFGIR7ENYYPPgK4=
X-Gm-Gg: ASbGncssLm5SBDkwobyqJLxIUyBnhVhPHV3+AjD0xc69PjLBze4GPVAEGoLoI8UQB6Q
 PiAjgiNvETJogMbZXTEjx1gVywQiIyTX5II+T2kQAsZX3EnXM501s/ECQGqQ1VNBQgfcTf5MmUB
 0Xjc6zdDljbbVM6yE7RiqkdD5rguADw3SknbGB/H2dvREXLcG0LRvUzl9IXn2B5dYNwQO7cihRz
 PcXcQxkgaBk5VvFgTkjxhpzqcC7Vogs9IoB6296fBGdFd4ULjg7EYzHwheO75l4cZc=
X-Google-Smtp-Source: AGHT+IFKn9qmDW+4iAXv4BnqzbTlblWSVq+u1KIFb+1J7l9S7p5N/bheFWiE7YChq7JGt2hHeDwPwA==
X-Received: by 2002:a17:90b:3502:b0:2ef:1134:e350 with SMTP id
 98e67ed59e1d1-2f2901b8178mr2308022a91.35.1734066884026; 
 Thu, 12 Dec 2024 21:14:44 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21779e0f7besm38651835ad.115.2024.12.12.21.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 21:14:43 -0800 (PST)
Message-ID: <5dd989ee-e9d3-4c49-9031-a4bc320bbaa9@daynix.com>
Date: Fri, 13 Dec 2024 14:14:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] pci/msix: Implement PBA writes
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
References: <20241212083502.1439033-1-npiggin@gmail.com>
 <20241212083502.1439033-4-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241212083502.1439033-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/12/12 17:34, Nicholas Piggin wrote:
> Implement MMIO PBA writes, 1 to trigger and 0 to clear.
> 
> This functionality is used by some qtests, which keep the msix irq
> masked and test irq pending via the PBA bits, for simplicity. Some
> tests expect to be able to clear the irq with a store, so a side-effect
> of this is that qpci_msix_pending() would actually clear the pending
> bit where it previously did not. This actually causes some [possibly
> buggy] tests to fail. So to avoid breakage until tests are re-examined,
> prior behavior of qpci_msix_pending() is kept by changing it to avoid
> clearing PBA.
> 
> A new function qpci_msix_test_clear_pending() is added for tests that
> do want the PBA clearing, and it will be used by XHCI and e1000e/igb
> tests in subsequent changes.

The specification says software should never write Pending Bits and its 
result is undefined. Tests should have an alternative method to clear 
Pending Bits.

A possible solution is to unmask the interrupt, wait until the Pending 
Bits get cleared, and mask it again.


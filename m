Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9866C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMRr-0006Kt-CA; Fri, 24 Jan 2025 11:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMRj-0006Hc-WF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:22:16 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMRi-0004iK-7k
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:22:15 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so1393355f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737735732; x=1738340532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rkbXvayzTlgOaEErHYllykNxh5YTXXUlWKE2TQcW5NA=;
 b=tdBssMj1YFU0CSTSRqus/GmovTc1eQXyKuglxKY4IyTJHKoIuy7z9c/GNnliWo5hDy
 t6nSS4k3wgOXY0bs2r2bjU0yYzCHk5UL8AOX19YSPMYs6MCGbXeSz2nkglkflizY3bdY
 CpCW/2sTNXF4uHaHFk/GAiyhEyhaOyUONRHmPcEeJf04Wrv8L5gWmy0uR4M92r465lac
 mZwrdFS3xryQanNamS+65dT/SHb/9jFKbT/Hh15VvxKzz+Z+gAJ66BKh39Q8MTkwKQl2
 vHcJUQcxTdGVxcrWWCNr9lSy0tWsRZLcYHAYkS/o9PoUx1AuEzH8v25HLq6nK34DHno/
 7CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737735732; x=1738340532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rkbXvayzTlgOaEErHYllykNxh5YTXXUlWKE2TQcW5NA=;
 b=NHtt7qqNgqe4OWk8XPlC0uSkdQ9MUhNH7j1PuOEqHhuKc2zklLOhhIPAZvGkCZmkZW
 D4b0DO+DUs6ebzSsk0i94v5Iv/nxM+FMwDjU47LYkWag1XNs8E9uKDJ6sDJud+sZzhI2
 Hot7KTblU8dwWZWlFRuUYbedkL5wNYcE8ZPNiDPH+VttKdRwEEovFHSh25cz/gbpRBRP
 3qqyRipDq5QA50+EWdjMRaamtSJPUp7H77PZfCiYn/BRVSnMWYYRD4cGuVzOParj22Ib
 zG0i+QP3eo4jlWhNAP5pXoSNjCKK52m2dds4uG+D8muT+JyCUaKe1Z2ExL3m/gWTtWBC
 B/PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi++/FK4c+OLJGlUUV2sR44+N8scStnu34eIg5cq7Eu+Cv9OarTvRwXNfNXT5/6MhyLnLEuthU+ZKv@nongnu.org
X-Gm-Message-State: AOJu0Yw/HISmC5C6KEWJyurEfMood1nXLkIYIpOk2qCgS2cPp8mpYW0E
 V2MQRlsH95cJiNRJObbzxA/omInieFC3fF61Wx07BwdN5D/FCNEP0ZQeXfa+FKI=
X-Gm-Gg: ASbGncu6EUpQYADst80b6eicpr7RIDZikCgBnnUZIYhSjr+5JWVZOx9N10g9Vv0QB0E
 tFlt8wV/YK4WcW3grRZxD9Zqo4xTgtfYfIIstxchpVYZFggH1VHpmZZukVc3Qa0WAbF3uEDug4p
 Lx98kCu1BeRbMZuSMBOggLv4l6wqM4WCiF0/SH9m69qxc2ah6HC4TTpcRI+eHFVhtDywagV0ibJ
 RXLOl+rhE5Ye9moL38V9VJIqXdevjwHSuSyAF4oRAEW8mSuVmCCB06outa6o0eJLBIOZZ8mfTwc
 WVClvcrr+FS0h+kWkFzvPc/UJC3lJ5LG0edUmgIn7SMXHzGm
X-Google-Smtp-Source: AGHT+IGG1WnyLsf+fHUS9MFHVUOS/sy79Two8h8h2hQWubp+Df5WYSJavrRFYAkcmpO/0BZfzbcQ6g==
X-Received: by 2002:adf:e84a:0:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-38bf5686090mr23148686f8f.33.1737735732379; 
 Fri, 24 Jan 2025 08:22:12 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4212sm3014955f8f.87.2025.01.24.08.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:22:11 -0800 (PST)
Message-ID: <35e2dcf5-d1d6-4326-90cb-22dc82023bed@linaro.org>
Date: Fri, 24 Jan 2025 17:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add me as the maintainer for ivshmem-pci
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com
Cc: alex.bennee@linaro.org
References: <20250123012212.716499-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250123012212.716499-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23/1/25 02:22, Gustavo Romero wrote:
> Add me as the maintainer for the ivshmem-pci.c device, the ivshmem
> server, and the ivshmem client tool. Also, adjust remaining parts left
> behind after ivshmem PCI device was renamed from ivshmem.c to
> ivshmem-pci.c, like header files, Kconfig, docs, and build scripts.
> 
> 
> Cheers,
> Gustavo
> 
> Gustavo Romero (2):
>    hw/misc/ivshmem-pci: Rename remaining parts for consistency
>    MAINTAINERS: Add me as the maintainer for ivshmem-pci

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks for volunteering!


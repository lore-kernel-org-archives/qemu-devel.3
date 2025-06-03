Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A115C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQCK-0006TW-Cc; Tue, 03 Jun 2025 07:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQCI-0006SF-Iw
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:52:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQCF-00009c-Hf
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:52:50 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so5169666f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748951564; x=1749556364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KfnykfZKOUVWk1tORUraI0Oj2VrklkCrkfB1rmGQ7B4=;
 b=uEGEe3ndpgwXUyNutljBVkMEV364QO3UkJOR3tNvnuoNBc76rt1V7lbbpspjqCTm1V
 cWo7A9Ojisfw+/X6e2UssepOC+UPKZYcP1upX4Fvqs4zy2/gOvoOBLSVxMRrnLaUyjOe
 SrDy3Rj51+PKkdxIqTs88BVsJEQ7VhVHZJ+0NTRa+/7BaYLKyCv2x20J5cQqOxEdE2eU
 63uohmc5MGWjw0mS5CpLJEsTz0NOo1WHwQQ7UAGeHgVMbeWnaP7I/Eg40sw5l22MGBBb
 V9dJdpNCABsn9bIz3AgV8pnqQB1SH+M38scz+0Y5YZG2j9p5IBV1GhafqJJY6U/Bfqwc
 /+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748951564; x=1749556364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KfnykfZKOUVWk1tORUraI0Oj2VrklkCrkfB1rmGQ7B4=;
 b=CEvTcU8m0nOFnWtFIcYf/YYT62niDPjD1jOFI9+ET/hV8/AmIkeFtU23asKmYqAZfz
 HTIe/s1EUPCJnqahIQwg9lp4PepoLnvjUqQmZQJc19hHOx2lUqeriEDPjSfcupnRHyGj
 qwosOM7A7k1na85UD9eLBwd0UHmouadCE+IEAJh3tD1WnCr7PMPBxC6d5ghFe3QurUva
 pdeFfeudHgWIhb7N1gaDORNkRvBr82pIShUrfUG+ZGc8aYzMCZQzJTs43r1TaR4GfBLc
 eCInOojuKdU7X2mUIBL+MkOakIXdlNqpa1r572mw4MR3xZNbFjK2i1QpYor+EgoUa8zn
 n94Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp0enYmdIT6qvhUryJ7XoTi96ciPyj9rBMjfsv5ZPLT9SP+/+UXQTBloeSiybwUIhEqJZFQLUuRpdH@nongnu.org
X-Gm-Message-State: AOJu0YxH5Z2wJN9qUR95ELFIUbq5xsKY/NOF3mw4/7ScKVnp57BXQ8mw
 Xhshjejv8V0TUlJCE7NGugQ/5VhZ8JyuxHfQE2bVS/V9LDYUsLTRTXjeaIwZiKk8ib4=
X-Gm-Gg: ASbGnctkPnMwiLoetKbJ3HERszUxL8JRNDE9o5WgLwQX89pCVcp4rFqhsCK0Yn6MolX
 83nNFdzMjiZaPt1JM8cAp7wjuhU16h23kYaIQHUxKhINqJGmWvque+TGW2bJsiozlcrFGuZbbJ/
 lkBODLHa0M4e2hsmW/94rzMQ3ltBBDikVhjAwU9VRNRfKH+Qc+1fUL1wA1nH91XtBl+lIybLkgd
 3wdtdTgkyVFW/GsAbviHUa0zb9HFZfzVwvavocIDvGh+24/dMNyaf59xbWv1k9TvFz5+Ol4vobS
 XJ3efYuoMW3pExuwh4KKKzP1UeISI2K8xOP/hTd0X0VV6+rK5KAjPmFoRsjaPdU3D8kp1yTHd4f
 GtCvv0nuxNRbirez3nxrbMXK8
X-Google-Smtp-Source: AGHT+IFPIwJPz+m0TnyThAKUDnOs0AcZJYmiJzxE3pNjqMXmbQ4qMXuymcFiSzSQKPmO7YcYDmymyg==
X-Received: by 2002:a05:6000:18ad:b0:3a4:f7e3:c63c with SMTP id
 ffacd0b85a97d-3a4fdefd71amr9566604f8f.0.1748951563938; 
 Tue, 03 Jun 2025 04:52:43 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8edf9sm157839055e9.3.2025.06.03.04.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:52:43 -0700 (PDT)
Message-ID: <798f138e-56bd-4ca6-ba72-6be24e8e8739@linaro.org>
Date: Tue, 3 Jun 2025 13:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] hw/pci-host/raven: Fix PCI config direct access
 region
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <24056115eec7fc376d1520283122f9191bdb0553.1746374076.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <24056115eec7fc376d1520283122f9191bdb0553.1746374076.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/5/25 18:01, BALATON Zoltan wrote:
> The PCI configuration direct access region occupies 8 MiB at offset
> 0x800000 in PCI IO space so model that accordingly.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



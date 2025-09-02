Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014F6CA1009
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utRM2-0000px-31; Tue, 02 Sep 2025 09:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utRLy-0000nI-Pp
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:47:18 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utRLs-0001Zd-DG
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:47:18 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b040df389easo484735666b.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756820828; x=1757425628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JOrIcxvbGtIjxIEEKO8oqR3YjayeX30bSPd7VVgscIE=;
 b=lNED0g5TaIynb1SU1GoDGxBF+DzBbgGtkxu6PHWUXoFACoyAv+uvxVMwkSq/yQgM3V
 gCDL+GXQ6wabR+DvT1w9jBondkLGZJCPPZr4K/QS5aY3b7AqBnH3zrEmtCd8R4XDfRkB
 c5HG2ySCwivFC+6RGXlR8X9h6P9XxtKH317TlI1WJYmzRUFes9BVbQtWuOsfuvghvmG2
 CvEKJK3VbLVDAYS88Agxa95muGCypZOz2NHwukpEXsYpU4tP9r/VIE+/LEAQEuPIwXXX
 kMTsxrIuwV/GT8ZHZGH//AqoyKOyrSGyFbvBWoGAQqXotES1kFYJU/zHokOSt94NVueN
 JU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756820828; x=1757425628;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JOrIcxvbGtIjxIEEKO8oqR3YjayeX30bSPd7VVgscIE=;
 b=v07J8LHch+hHd5i9c3cOBP6Xwup9JZjkN1O+DTb5cr8jrV7//tr15aRs46g8Bqt3Vo
 5IXHs62vQeFvIkFS+muNnLRQS+Q/IU3iPbVV6nABdSwj/qcCKR0iRDuSOLHi7vHmEWJF
 83Gg9b00iXZyBSWDs7oSbX8YGMltQhYuDQeoBIV0Iuf5EgdwXNCqhgdeO7nbySWYZyY8
 Ti/RguciScUtTn8lrSgtemf1pZ/4+s2DhO0JZqzgEaBAudb+IlHIbqphZrki5IxGNeN3
 g9HJ2t3/yk8LX4xVP2nGDAYBir9pMegEODr3CYaq2cP6qznQyQZ2+EItfxeCmReM8WTM
 gW4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9k0xALF5sAq6Ge36GrS+zSmyex1EwNclexYPSml706fUUJERZwDRJUTO372e2PlKFarSizbcDYdSa@nongnu.org
X-Gm-Message-State: AOJu0YwLZbkoShJ5ulQ0dOE4lA8CHGUyBIY0pcJTE82eXAF9ryAfp16+
 twoS9gL0CANyCjbELRwx3HwKKGQDlGLnyj6+9q4X1Dc1PTdAbSxVYoc5lyVHqpQiP2p0wBcAfGg
 dmfaYANg=
X-Gm-Gg: ASbGncuBTW6ZdujaVbsqel/STDQFZuXRBltooIfYVIIYXa2ofDG7fVZ5cDADZ89MlVZ
 YtOm3UO0vTYw1tWhJ1vLBva1WKM+Gt8h9HJvg7dnExh4udPrFkIiBwVxg60ZBJuxl88cEZQMdFH
 k4fR1KXM9NbiAi1Zj6K+n8OdLyL16Ue0D1A5mfU2P70CxKLIoG0Hi+njTtNZfleGoTY9zD+KvQo
 3Yw7Ezam+YRcnGn6XUK53upM/0FqiZkf3A+p+wuoUjuHzWvd5zRAJ+d7YNSgyywtoLQUlh5dZTV
 AdDh7et7zjWHAQ4r5GRF9RbI44Ok2jdNWTYEpBtDURbasH4oxy2g1MRYuTUg2IbBmKfxDIAC6tx
 etA/o0Q8RUSCjjRwX518WpO7uJxzes+pgJTjBgSoRAbUNkLHCNkWG47BVhlxDdrTuRIlK5J3G2A
 LQei9Otg==
X-Google-Smtp-Source: AGHT+IGNkrdkjrtzEgNN+f50HTIir3x6VZqw/Qpa12YF7q+IkU4J1JjGdePULqwIeqF22PSVNKcBkw==
X-Received: by 2002:a17:907:7fa3:b0:b04:38ca:9394 with SMTP id
 a640c23a62f3a-b0438ca9476mr612241466b.46.1756820828492; 
 Tue, 02 Sep 2025 06:47:08 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff032125e2sm1084670666b.77.2025.09.02.06.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:47:07 -0700 (PDT)
Message-ID: <bc8b6ac6-0bd7-415b-a1dd-cdae1e95920e@linaro.org>
Date: Tue, 2 Sep 2025 15:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] Error reporting patches for 2025-09-01
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20250901111906.2403307-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250901111906.2403307-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

On 9/1/25 21:19, Markus Armbruster wrote:
> The following changes since commit 91589bcd9fee0e66b241d04e5f37cd4f218187a2:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-08-31 09:08:09 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-09-01
> 
> for you to fetch changes up to ec14a3de622ae30a8afa78b6f564bc743b753ee1:
> 
>    vfio scsi ui: Error-check qio_channel_socket_connect_sync() the same way (2025-09-01 13:11:13 +0200)
> 
> ----------------------------------------------------------------
> Error reporting patches for 2025-09-01


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


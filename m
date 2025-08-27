Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4181CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 20:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urMjs-0007uu-Ms; Wed, 27 Aug 2025 16:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urMjo-0007tU-Mp
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 16:27:21 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urMjf-0000wh-6i
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 16:27:19 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b47475cf8ecso222985a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756326424; x=1756931224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SXl2jGBiSAP374GQpjlhxwfvspORjjNoa0q7cwTMl60=;
 b=JO75dEhI4dGK/iC4ejBCyq3URXFChp1+9RErvubNttiaessPArRu//U8VugdG7jXxl
 0Jb3J0oS3GiZ8X7ztJBBUDwt8Mblc9ihMA0DX2lilY29doit5jIf7vPPlUBx02i7Sym4
 snhh80QLggVSLb/FS0H9h1+aSwIV8diRPH9XSjAWqSAeLoONUFfSrTX+F0/thGLiO6Vv
 DL2ob32IFHruu+xn6zZSTMO+BYWn/U32Gno+9sRmm8V3WaTvwCnDHU5l0lDy9Fa3Rkw0
 lypkTJBnwWBuzqgd7Q0tDgsgkKyM/0rp6xtZ/EjBcSOpqYTjKtwFoYMmHx4yWvEoBM19
 9+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756326424; x=1756931224;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SXl2jGBiSAP374GQpjlhxwfvspORjjNoa0q7cwTMl60=;
 b=GA8whQtB8hEhuUWpo6nKenx/gBe+ue21ZbG59ua+Si+ZZOWifm3jFpAfSL/7ePYiV6
 qnZDkTgjan+TGHT3oYrrnruIeTCaaK7BAn1WtgzaXqru92JGCPDgFLiyHrl/quqYFPDr
 ygc/zB8t3nSzvpScn6zU9fAxjXhkw1JtftbxomX1smf6Del1pmgpRLVIE8X7erhrUPLh
 M6YX8X/cJw2pTZJR6G+ixqx0K99l+nrTxiD2aGJJJi0Y0NGpXtrTwZI7/IDcy97JVQ6d
 3IUTyUYgtqJRV4gZbudy3ypj2WYBGrn7O8Z5bTR2x1fBH/D5JXr6bdDxbLQ3ME0ksV69
 DQWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9OQW4N+y+oaC0zPRD9k9+FweEPNwlwjv4ei2yuf2JWL4rGw2eQ1xrXKS0uvPepCCqd65ppSXj6DqC@nongnu.org
X-Gm-Message-State: AOJu0YwkUhlUli5bRq/eH8kZnEu2VEcH0caMSyrOq/OAbtD+hWqb/OB7
 GoF8fuxMI1BMH3QfTxTMAk7KeqQkMyg0q6L6mF21TxJr4bsJV0A9M6fveQ8sVAmzNZ5Bd+sIsh/
 e954lH7A=
X-Gm-Gg: ASbGncvSNYTIyPZxkUXa97rhD7CHEMGdsorbqCDhuvjWHUKeB9h56XI61F/4arZnNgC
 0Xwc6fXShAKvtCAsNfOW5hv9LgvucshOZn2z9uXlz56eajRepbDslSKT9JbSevE9bq3NxdHSi5+
 svKW8Z9GjLF06IRWdu9SieciCNaXO9W8rryMK49ZUM/EJB7vGtzoF3TYrmqZ6Hp4Kz2Ffjut7kV
 RVA9Gl9hTLWNhwAoezg88AeX/JaboSl3pQ7uP985nsnLX25+a7bycefVId3S/GBM9feEBE8GZZv
 0HRNqBCvzXIbIm+s5gu14DkV4gMpsDN5M6vuOfAfUbjDEai44jE/gXhSUyZGsuB0//mSUwqK5lo
 g+ggKEI1ur6exvK+/VOVmYz82Hr8E6Vg663kXKPtuuS8pgxU=
X-Google-Smtp-Source: AGHT+IEIYF3vdaXA5K07MAu2Zut5NZumhH+Dj0tmZdj2NzuWvykOXU9NzSFWeryhjj0ziUvasJGtfw==
X-Received: by 2002:a17:90b:1344:b0:327:78ec:7bb3 with SMTP id
 98e67ed59e1d1-32778ec7c71mr3878260a91.27.1756326424390; 
 Wed, 27 Aug 2025 13:27:04 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3276fde4cecsm2769483a91.29.2025.08.27.13.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 13:27:04 -0700 (PDT)
Message-ID: <665fd924-6b2b-412a-82d9-e2a9697bffda@linaro.org>
Date: Thu, 28 Aug 2025 06:26:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/31] First pull request with functional tests patches for
 QEMU 10.2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250827075443.559712-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 8/27/25 17:54, Thomas Huth wrote:
>   Hi!
> 
> The following changes since commit 88f72048d2f5835a1b9eaba690c7861393aef283:
> 
>    Update version for the v10.1.0-rc4 release (2025-08-19 14:05:56 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-08-27
> 
> for you to fetch changes up to 0ac3c314130eff8e3ea9860fe3202908a7746225:
> 
>    tests/functional: Mark main in QemuBaseTest class as a static method (2025-08-27 09:46:55 +0200)
> 
> ----------------------------------------------------------------
> * Add v10.2 compat machines
> * Move functional tests to target specific subfolders
> * Fix some issues in functional tests


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD58CA6012
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF6xy-0002PR-0q; Fri, 09 Oct 2026 05:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF6xw-0002Or-2i
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:32:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF6xu-0003Ro-71
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:32:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so32871335e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791538352; x=1792143152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nXMnABsLVhQcouyZTVCpK7268L+zO7BcHPMDvI6NMyA=;
 b=fjeevgsMxzRhcsbxOKyT+SXunwiWEKSboo42And1Iz3gF0oapdWOA+VOf0cpCRWAqy
 mLwLBjOaKIPGJAyCXVnU/9wEY4sPDCRjbrZzCYwAArTXk5xJ73BvlxGoOoTs5He5Ecdv
 xKHkawul7M5WVuTDFe+IgES3W6evPMuV4pTqj8lRLoHK7HS+2a4P/SGavjQadS5lA6IH
 CRra6c4dsu5LGIaUJdag8WuSdZ0N+fjNSM+UE+RRoAaK63iVYoq/vWHhQ6ntDqwKfDm1
 BmP2uE8O1H5RiDy0bc5rXq2sOmm3HjikMMlcickjmea9kY6+31ulKv/eC2TskhDx7kS4
 ZWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791538352; x=1792143152;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nXMnABsLVhQcouyZTVCpK7268L+zO7BcHPMDvI6NMyA=;
 b=dXV5CIvXEOfiWS7zyJMZsJ3JkZubSVZ8Ro4X/mCDe9Xn1aLSYYEvbfqOAPGLFS1R4S
 oJWW0LgT91vifdNSdZAdmDj0RaGHpIplmpbKXpqCi3yeYVQgoe8m80exy8cX6fP6pl5e
 pu8CaHP3j/8x5J4efn/KD2Y+hWHhXIfD8U1SAVWbGRhUMpLkbeq8i4k5yZG7tw/8Pj+N
 B3qYt/qu5z0tcRAOCtucgw8wllC2XBg0ZzID+zp7//sBMr0KAmCpwJJJFld9CxftFV6I
 s/vJDs+zJpea8DlgzasirNcs4z7ObppdcwaqWoN6bN/jkYO1enbqkAF00Gz2V/X9LC0l
 qVtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHaBYMtEjic/zwhLR3FWtlXtfIsupQq2wHjRDOAjGtZvIcwC0gFLm0g4NZBpK89WAl/KOpVWZhpepE@nongnu.org
X-Gm-Message-State: AFuF++lTS755wfXBlKBjU1ghzAGy3b82FQX72v9UVy1miLMgz7f/SFAV
 faJQqVyeSVpiVVnuDuwpqV6awDS0+K9GNBKniSrJnZzuqbEwNXErGfci5CTYM6hRDBU=
X-Gm-Gg: AYBFou3amKzClbdly+S2G9oAq/WqAeWackkPKBN9xi4zrG5zodkNgX4KkShKZIuX+B8
 8dBUeIb13vnfDqp+8xjncTrWfw928D6HkScjOOPtZdZCKAaKYWHOq4tTIaplTcf7EVim7w7EFoY
 TilO6nQ2QMyYBxUjaRGsme22mnRjQjjOClQaIXKpKPKWMwm/EdMDiplVtL98eoN83PpLNyFSlm0
 WduEAcCq8lWvXwUf4ypOkORmbBQQjH+zhP66oJGRzUxy3WEZZuLctX94T43u3S+9GBykau/srAE
 4gz8og0DX0guG4NXVFUxvjhzBFPe4eMt8YJJs5LUDYXXg5go9q7DVkVSIB2M2JJihYlFvxPZFRL
 K5LlyKAgwl3AwqsI0+ofz+IGHGtHQx3vEVM71tEtPy/UBWw6zY+evOSxltKHNdnf5vAEqLx9GGN
 7Z87yxNIBv+wTKCwGvxF7jwXEJLa5dDLyaZQ3QlNjqCVBSrFeZlA/8kiSawa364nh8t2TboQORI
 j60KfHI2nf1vJnGCHkKixvQG+TxRdtIw9KCyuLb5bKMJnmaiC9pM1ljeSeULJlU3g8kBJB3avMr
 hg==
X-Received: by 2002:a05:600c:46cf:b0:4a1:7e1f:21bc with SMTP id
 5b1f17b1804b1-4a18e4d6636mr23347745e9.29.1791538352045; 
 Fri, 09 Oct 2026 02:32:32 -0700 (PDT)
Received: from [10.86.151.227]
 (ipservice-092-208-245-012.092.208.pools.vodafone-ip.de. [92.208.245.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ad56a6sm2702184f8f.52.2026.10.09.02.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 02:32:31 -0700 (PDT)
Message-ID: <9764ac74-ad13-4694-9a7e-de22dc067b37@linaro.org>
Date: Fri, 9 Oct 2026 11:32:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] MSHV changes for 2026-10-06
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/6/26 18:48, Magnus Kulke wrote:
> Various minor fixes and a feature (gdb debugger support) for the Microsoft
> Hypervisor (mshv) accelerator. The changes have been rebased and re-tested
> individually.
> 
> My public certificate is available at:
> https://mkulke.github.io/magnuskulke.asc
> 
> Primary key fingerprint:
> 5255 B617 7982 9168 7022 31CA 68D9 BB56 DD17 8417
> 
> The following changes since commit 3377670ee96b5a68361016680a95b9013709d4b7:
> 
>    Merge tag 'linux-user-next-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-10-05 07:14:51 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/mkulke/qemu.git tags/mkulke-pull-20261006
> 
> for you to fetch changes up to 7d42b0a4f52d57cd2d9e0a9ceb8ad5102219a801:
> 
>    target/i386/mshv: support single-stepping (2026-10-06 18:14:35 +0200)
> 
> ----------------------------------------------------------------
> mshv changes for 2026-10-06

Applied, thanks.

r~


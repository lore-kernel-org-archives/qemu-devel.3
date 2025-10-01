Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC8CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3wu8-0000r9-AH; Wed, 01 Oct 2025 09:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3wu2-0000qk-OP
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 09:29:55 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3wtw-0007wP-En
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 09:29:54 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-799572d92b0so64256776d6.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759325375; x=1759930175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lKWlnmMTpy8J1ZutJOGESUBXl/YEDhZZSiYIPJKzcVI=;
 b=nKl970OdzDeGOn71uCaEFMRqRsFmUJJQz9QMTKz+E7ts76pd20ic0YCD3AcEKf75jN
 v5sOIDznug7eRRrQXFm3v/7EHHM240dP6AZMaaG7/ZfZx8fkR6CYdUok4YpBwz4rlwYx
 tA1TN2haLe3t+Hmw98NEdboABS9Vlu5kzDuTty+HaHSMNSGVz34ItTe5kojCXGK81byB
 QhHLEvqNz0ipIRcqY7d8TAxzhEJaZrkTR1zRBIfe5M8O6jt+TdenRpdcVi/DIIuas38A
 pbtRzeYWQal9QEoakGyu/nHAk23OY1oXzuSFBwhdDtRri/l70+t56HG1nTxZhQb6eQJ8
 w4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759325375; x=1759930175;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lKWlnmMTpy8J1ZutJOGESUBXl/YEDhZZSiYIPJKzcVI=;
 b=jd5SaG8Vj6hYOv1YxaRAa9Pg5sl03Epg/aIDSMdtxtv7X2lQ7PH3R4QrNrnLDcQiad
 dbeXVIValOepz2cnMnW5muAyIkt62befZnklmviJy4D/0S3QCjUMrtW6e5Gs1YASkClZ
 XytUXjL05CbQF5vcZR47a9xgRDh831dwx9VJ/pa+SvNqxEIOm3a+zaoI+EdthXaq1wOa
 Mx5Tv5DEqSt5cjrrp+3In8I7qnc3xX6wVGrzMXSgSuTrnM06Nbw6O77wAk4yLWdmkNeT
 dRjHAMYabTCw8ZOpJg6EBYul0IM2bbvCbhzLWv5A7bSznrq3I7VtZ5kJrivoi9QcB3fh
 OS3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0OE0ZPbrhdrqi5g6cCxKejlQJJOeleiOj8XSz1h1aaWYWSo1eoVRFnbyRlRtBoJ0IpPqAdgNBKm5U@nongnu.org
X-Gm-Message-State: AOJu0Yy+3MWpvaw2Rl2ELxAqc2tQkn/sDkVz7TtlzQ5JnLt2VPdPcdCj
 3KyAKSpubG7mm1fja+DP11LAPlbf+ByNd67NH1srRFVXuEw8xMUKI+P8mMQYhTGjHYH0/NdIEJR
 a5R+V
X-Gm-Gg: ASbGncsfaeLadDDK8ROFWaaw0Cls1Oc5D5w/wWz2OYZYV3b9NXUIKJmYTlNoyAKO/O8
 8sduLNXdih1Wkkkqwf6DFrgf95zV5EfJb4G/P9xGRq6fi3Z+xD5+JsIj4wliHuvbBpIoNWVwbEp
 uzahaGmxCNBOQDjiWTZainlqA8mBzomQwSay5YTIOjqB1/PJyxBfNe7d3kB1cCT/jH1Pd0aIXF3
 J1xuy6n3iI+dMud7w5cj/Z2P09dllKQuzbHiB2VV/ry7KFcnQxluUMyo+EUFldpMV0JHkFLimyD
 sfqDXyW8HdrifkZ4dtIe1cQeX55NEirBx/k+98Slxm1ntOQ19KX8y4oOUCcMsBOXrudqKKGGG15
 vFWMvRDvgPA8UU8XUeKLc/MZiK22p1Fpi7OLWGmeyONmZenPQeEBdMwjTKYhGqWf3SmXkGk4LBA
 isqIrPmnNu6XRfC7OkDlq3uGgmEEyR2yw=
X-Google-Smtp-Source: AGHT+IFP2bCdy4A/1gYa6+qBQvWPLecYJu8HVoLM/KGfOQipxFtyfNmxz1by7tN4bpBvkLIAL2TLww==
X-Received: by 2002:a05:6214:242d:b0:77d:bc4e:e0e5 with SMTP id
 6a1803df08f44-8739c0fad1dmr48747186d6.14.1759325375570; 
 Wed, 01 Oct 2025 06:29:35 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8013cdf14e8sm113255976d6.20.2025.10.01.06.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 06:29:35 -0700 (PDT)
Message-ID: <5f37d626-f564-4b75-80f1-ab8021c8fc82@linaro.org>
Date: Wed, 1 Oct 2025 06:29:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Ui patches
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20250930075559.133650-1-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930075559.133650-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/30/25 00:55, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> The following changes since commit 9b16edec6e9a483469c789475b2065d26b52db35:
> 
>    Merge tag 'pull-ppc-for-20250928-20250929' ofhttps://gitlab.com/harshpb/qemu into staging (2025-09-29 07:25:28 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
> 
> for you to fetch changes up to 9163424c50981dbc4ded9990228ac01a3b193656:
> 
>    ui/icons/qemu.svg: Add metadata information (author, license) to the logo (2025-09-30 11:21:55 +0400)
> 
> ----------------------------------------------------------------
> UI-related
> 
> Fixes for gtk, sdl2, spice UI backends.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


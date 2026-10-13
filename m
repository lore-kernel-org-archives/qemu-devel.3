Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022B4CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGidb-0005P9-NQ; Tue, 13 Oct 2026 15:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGida-0005Os-6b
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:58:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGidY-0002b4-JW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:58:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1903400f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791921491; x=1792526291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WQF1upnov7gcJxgusZlbVaBABSNc8PvZ7p1DSey8bpI=;
 b=czfOin8OzqtSEus7QPYILZ4BJtT32OLRmNv9xnufqF7Kb6lFLLC9LHx1pf3maTptXz
 G3c9W1FcKBbvdo/9cFCoMU62TzAd4awgWY2tgfqQbJNk3unbIaTdyD3PD8pyLVQeNV8W
 i3h6pgW4nSkOlBycFOwV0cd63wWdcOAWfaCPX1iOu6fJof0rs03NuiJlXu7+srHs/s/k
 MVB0ZQplywVvt2FpA2kEXOjv3w0Uw0x4XVuaJMCgoQs4dX+LcQYYKNbriuvmvmpHop5p
 npJHtyci5pT547i3Zn++ehG4pcsJzViSN/XvO9UB9qGokGqM/FhHn4dTY6NdDZPnhbaA
 U1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791921491; x=1792526291;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WQF1upnov7gcJxgusZlbVaBABSNc8PvZ7p1DSey8bpI=;
 b=GSY3hKxTXTwicLDi2ujn1d0xN/Oe9SPcvvBZ/3QwfDXRENXsRHDaU44QyeDai92+tc
 rzkkFHp7n+3yXWvb6i1gHIiaI94hk1AtrL6yxtCTTnTptDsNJzkYY0St7AKd4NWirT+k
 j5Fgc54FXyJl8cF0UGii9FWyO884402PkuZxL/Y5xK9TE03sTZOSQE1vbieGM72MahZu
 A9OrIWk+bJX2Vj3bqMfD3hwuybGdjHvjvlgYq0tbWCOAmx/4S+qIO7gChAj3suOH/eib
 96OB8MODVOp1+EcCakrlpoz5L+ozIVEstcqmIwcLbuCKUojI+EvrVEjZqdx0e5R/Yhwo
 s8cA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDC4mLai4WVkIL5sLCEZ/mQQJPLO0gJaaPyB8omfIGI5z76tDBD4gPLY0xzFGBeaEUnFUj2/kvvG3Z@nongnu.org
X-Gm-Message-State: AFq9FYJ1ZpyQ6Fhkno+3VlaSoVca09s4D2xAKO8OyXGEsTckKjqH7MbO
 JApkFSKiE1sEVm6KDEtgsonch0LrPAgs07zrlUseLQvxLgYbHciuLxqClucfi1Qm50U=
X-Gm-Gg: AYBFou39e7F1FFdmf7bPyjlqDJD+hIhPiJQvCiSs8v69mcVaM6YcdLdCEfzkPT8OA0H
 WyOT/5XmMLHVCRD+xWzLpA1abprQ2T6Cg9aEiQccwxOWKsSfSqyTKAmPhCatwbWjtDEShmv1IJw
 hWUJBHY3QmrKgHBl2b+j6VoSUFU75RIQTUMiDBpxH2wRpeRRwXnoCxSKXUnJrhaciuX5pZ3Z5OB
 +b3BVKAlyp0FQPklIzmuzJVsP76F3vvPzwdb9wnh4fEwSBPBfePBY4Kln7XLrW57YFuMVT5YFyi
 YjV/NssfkhSgyVGzTx4kmJjyVaS5iPtoczHYEfsMxYMEdX4c3WRbDFSYrFRGhrjZTxGAzhpx4UQ
 R5OIcalhTeicP/7IzPF+21ohIIU2kRJuZYU8htwUW2wWve5HFcDAWkWccEzhv5CG9U4Fohpk2gJ
 Y6OQbViDX8V5t5RAWArdiVpOFEXYy9XNB9818CWMs0C33QR3ZWWI4f7lI+/Sh8Y43R0rPXukuzu
 O3IOnOhXCCGdBBwiCdGmACpZ0MSYYfnLLdaCYO+iKCFmn1sc+njoVuyCREiLAO+khCl
X-Received: by 2002:a05:6000:46ca:b0:487:40d:af33 with SMTP id
 ffacd0b85a97d-48dbaaddd7emr16626950f8f.13.1791921490617; 
 Tue, 13 Oct 2026 12:58:10 -0700 (PDT)
Received: from [10.86.151.227] (ip-109-091-152-129.um37.pools.vodafone-ip.de.
 [109.91.152.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab4e8csm6552215f8f.23.2026.10.13.12.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 12:58:10 -0700 (PDT)
Message-ID: <bb99a307-848a-404d-8fe4-761da4001e1d@linaro.org>
Date: Tue, 13 Oct 2026 21:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] s390x queue
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

On 10/9/26 20:28, Eric Farman wrote:
> The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:
> 
>    Merge tag 'pbouvier/pr/plugins-20261005' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/efarman/qemu.git tags/s390x-20261009
> 
> for you to fetch changes up to 598482e3cbf449d76870730f796176da73863e13:
> 
>    s390x/pci: Reset a device in error state (2026-10-07 13:19:35 -0400)
> 
> ----------------------------------------------------------------
> New s390x features for 11.2
>   - Enable migration of emulated zpci devices
>   - Error recovery of passthrough zpci devices

Applied, thanks.

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541E7C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 17:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpWqf-0006xb-7q; Wed, 27 Mar 2024 13:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpWqe-0006xL-Cp
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:14:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpWqc-0005Na-SF
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:14:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-341d381d056so1789160f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 10:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711559637; x=1712164437; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vu7suNCUX1YMKGA4SET/IwU/8+fAPUob1HodKRWXOiw=;
 b=M00dKYMB7gZMUuv6wXNsUllWSygYUgATjQBuOHHScfCIbtSaa/WjUQglvLpm89L8yG
 bqzXzRBpyZIJUOFh3BaN7a0wHE2LRtFm6tTmXwbmDyoQ41ZruiTUZx9Sx+U1e/IXnGzk
 68rP7sixEuZ44V9trTDdEujZO/YaEqRuQSXrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711559637; x=1712164437;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vu7suNCUX1YMKGA4SET/IwU/8+fAPUob1HodKRWXOiw=;
 b=qKHQMSErbYMatUx7W9qq8lfmBTauck+q2NcH1baS74OCb822k38oaYZUOZLevywzYu
 zIlh3LWGuVPSWoJ34o/jgqWJ5Vj1uQqYe8c5Rk8gKs/JNu3lDP9sdvrDIBXw5+m/5Rwd
 cBjPsi/MP0xLFXtTuM5NW+s2gTRPyAfM7/P8Rywemur0m1WGDPCQ+nkoSY84yUfG1dra
 zLcM2vbi+d1C9Y2Ct34sG2XlJNjFFg9amBhaRdl1jEQT6YBZehWWiRswNVbRJFNo2RSX
 toSBjdWQac927tN3E7f8EC6fCiHay5DgMDy06YiGgD2SRtNGNvtEfATvuABsm1BJ6itV
 lcoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfQYYJUrYNwcelXl3X7Irurvl0uTs9RaRyYy6KkRAvr4/8+Pa/C41NR7JjKKAPEz+n64khDm3ao0O3WLi5qoIWP2hz0Bg=
X-Gm-Message-State: AOJu0YxfOX8ybx16emEgJXxNO4d1FjvzzUTRBQSKQC8u+ZqSnn9uJvVQ
 DKRgOS+nfnUJ7QJ5xM7g2OFKsjh/wlqnD0H9vb6wsPBRfVHuI1CF9ZUeNSz+PlE=
X-Google-Smtp-Source: AGHT+IHuzwyfCe0U7WV3L9+qNX5m7LH+o76ieKYIT56YXzVsC6yBJ1zoRlezauX/mZrHEMHFIXhO1A==
X-Received: by 2002:a05:6000:ac3:b0:33e:64f3:65a5 with SMTP id
 di3-20020a0560000ac300b0033e64f365a5mr433896wrb.52.1711559636869; 
 Wed, 27 Mar 2024 10:13:56 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 w17-20020adfcd11000000b0033e786abf84sm15317168wrm.54.2024.03.27.10.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 10:13:56 -0700 (PDT)
Date: Wed, 27 Mar 2024 17:13:55 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.0 v2 15/19] hw/xen: Reduce inclusion of 'cpu.h' to
 target-specific sources
Message-ID: <5cac8283-2e26-44dd-b113-d8499a0ef618@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-16-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114143816.71079-16-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=anthony.perard@cloud.com; helo=mail-wr1-x42c.google.com
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

On Tue, Nov 14, 2023 at 03:38:11PM +0100, Philippe Mathieu-Daudé wrote:
> We rarely need to include "cpu.h" in headers. Including it
> 'taint' headers to be target-specific. Here only the i386/arm
> implementations requires "cpu.h", so include it there and
> remove from the "hw/xen/xen-hvm-common.h" *common* header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD


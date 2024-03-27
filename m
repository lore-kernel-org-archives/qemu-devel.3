Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97A3C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 11:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpRrT-0004cl-S6; Wed, 27 Mar 2024 07:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpRrS-0004bS-B3
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:54:30 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpRrQ-0005it-NY
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:54:29 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so811468566b.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 04:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711540467; x=1712145267; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xo2nfZBTCiRDB2jtZRoNWpjUBE4WiCL6rnHvacWUBJM=;
 b=jQFtWQcIDzKKavi3YJpRVG9dshxMnBptfnWzeM/+27/Kmz8niBHxzmMS8G5NQ4SPVz
 RX8PmdvLyjJfD+0qqiukNAKdPzcKFBGp3fdu76MoF9IfPWoFh6x/SmLZNM3k7pXgrYIr
 Wj1/RMCXqyLLO3DOAAWa0EQw0++3woZfGy1AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711540467; x=1712145267;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xo2nfZBTCiRDB2jtZRoNWpjUBE4WiCL6rnHvacWUBJM=;
 b=F6N4KgAJXvjvfdZpCPJPqXt5lyWyEroyejG2ezUN/tfnygLY5bLXzbzb0MfcYwgvT2
 uPfX/gHjqXGB8X/5v0aEWW04zzxS+hStfUR5+R+4S3gk2wP3JTbY/I+K/S2VwaUXmII7
 qZreEmgJiPeGFyspv9EPxheubZSim1gZ1VctC/5a7BSkae+mJnis4pK29pgQPyfDID8j
 dVPrv4qABIrrd9Q3Lm8ocekPfSz0yIj9eKuoBYCXwPOWA5Sn05y5oberEWU8EaepW0FM
 RDiH2d/xHxH/NIiaJ2lW6r/gHADCR+6Ue7OOSqsvN7R4FUgHmC+6gFJ47GBpuAfYU1wn
 qI/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH+Gw+MIvsagx6J/0nqfEfZtZ1gM/aVhOHjYqg10T2X7zJiVYYAmjJRQH4kzqtC9EzZ7PV5Pky7p9mMtoxkp8vPh6qKRc=
X-Gm-Message-State: AOJu0YwHuF83M9SScNCKzZbPHFftfpZETS+cUrqpuGBmNSWCOIZ5Bixd
 1vSumd9bDQcs9UEL+EV0OX8WLJyHrtsgHLcMaR/s4QMVHYJ95GvYu7wRzxnKQD0=
X-Google-Smtp-Source: AGHT+IG9GlCL2qsgWyuFSglCpOBIwZX7MMRogX3VsIf8avJI3j19EV0AuKmIO9P0kiOttKpgN9U6dQ==
X-Received: by 2002:a17:906:1911:b0:a4d:f2a3:9c37 with SMTP id
 a17-20020a170906191100b00a4df2a39c37mr3310934eje.4.1711540467139; 
 Wed, 27 Mar 2024 04:54:27 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 x20-20020a170906b09400b00a469e55767dsm5334791ejy.214.2024.03.27.04.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 04:54:26 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:54:26 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH-for-9.0 v2 08/19] hw/xen: Remove unused Xen stubs
Message-ID: <7af32170-a282-4f28-9db6-913087960acf@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114143816.71079-9-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=anthony.perard@cloud.com; helo=mail-ej1-x62c.google.com
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

On Tue, Nov 14, 2023 at 03:38:04PM +0100, Philippe Mathieu-Daudé wrote:
> All these stubs are protected by a 'if (xen_enabled())' check.

Are you sure? There's still nothing that prevent a compiler from wanting
those, I don't think.

Sure, often compilers will remove dead code in `if(0){...}`, but there's
no guaranty, is there?

Cheers,

-- 
Anthony PERARD


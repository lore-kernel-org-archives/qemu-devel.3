Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDC4D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAWQ-0001jC-WB; Mon, 01 Dec 2025 15:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAWP-0001gY-JN
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:29:21 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAWO-00035k-8F
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:29:21 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78aa642f306so43628697b3.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764620959; x=1765225759; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l6Ws/qzj87TQh8kOkry2xrOTXNOSSBHYzNxnJ31MRWw=;
 b=sOM/4R24/k4I6tn6krHLcXSI9KL7WwlhsEWHLf9W5E4WY6QJEJMukx+H8ezP5DgYvx
 pcByqWbB2I1shDk1kCBrmtlgQBtb09CNH6czMojdca5cNTzO32X3xdrehJln4bfLEZGL
 2m6cGLZLkQQlG1fKzXwy17eDuamYLe79t7jY26lmztHNFFyenZ/ZYXsKZWujyKkwx3rq
 9ubKO3543dj8VlvG/3IPEBITCf9DOhA914RpCj47UktC8GEXslMqFn+/7W898trYhOLJ
 xhEYX3LG87QFnx+6hiJSiIMxLhTHT5zEIOSdgoj3njBTc8ptfgokRlNorsktQtHTp+d1
 5ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764620959; x=1765225759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6Ws/qzj87TQh8kOkry2xrOTXNOSSBHYzNxnJ31MRWw=;
 b=CYyz9Ur4QNdLI3EuXyiozxoO1EqDWNCWRL1sLPJyGovWzplZwEU7ahyobbXR46AwdU
 kfcrnbhO2T5iLuoSK3bKtZ755UU5xtr2EQLjOv7hviwQlBDeIo5mhfgeYqTgD3aUdPUn
 g52FAMg1OsuvJUVhJzkilZbioM17zRqifxJ5B9CRZMJBxapjzOxOmM8B13pWmUx9oHQp
 QZ1Q9DmTScFeqRKj7rxCAaXCbHFMiDhHDR5WOyteNlIJ74WD+uwd/SfxkC0iDYs2UGmI
 T/StHcapj+pysspvU/ziD/c8wocGTyUI0QRM8WG0ecs/A9HT+nMggRGmfoygkgCAtSEy
 GnPw==
X-Gm-Message-State: AOJu0YzjB/SPLCRa9QrULIJzaiNg2/xO+s3esuBv0u2SWH+hCJxFOGgB
 dJBJjqHPfDZF2d5i60GQG3P217jRpkDOHTQMIRBpN2xsxU6NYbW/8uVnOIdomPvR/hGB5yK9oTn
 dc+Jns2JzUd156tG2dVH4CXFW13c1ZrwV3pq3eutaS/N3FW7aVBhbk7A=
X-Gm-Gg: ASbGncsCc1tZDyBgHtinPwbxBOQTAlpJc72w5H2LV0nTj3t2OpqaJcWQ4MPqV43mztP
 EWhZZd4IapPG/PncsXb6XXocs2O8KemP5MjdafeBjKxNAktY3uhBK+BUHGSMIoh7Su9LBxFEkPF
 bfi5+P3/SBLeXqT/OJ0+B49kEyupPBgl/wghUIw8/5YfJF9vRKpnZ2w9QIZDA5eE3mW2gGA6TRh
 iug8aARzZnI/o2+n2J0XAE8NRjXuSm3H4jtYTfVXAC9Oj7E9vIWGV7YESmGck0i4Rdjhs9c
X-Google-Smtp-Source: AGHT+IEuVA805ay4FnZAbHHavQX1h7/ySKrFsp34lX+x7uTm+oo9mUVs57zKaUBWYPmajYZb82Sg5JLo2zr0e//ANok=
X-Received: by 2002:a05:690c:a94:b0:784:952f:922b with SMTP id
 00721157ae682-78ab6fa8e22mr211876217b3.63.1764620959011; Mon, 01 Dec 2025
 12:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-8-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-8-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:29:07 +0000
X-Gm-Features: AWmQ_blkPDVWnf4rLQggFuuIx-JpOiSmOmmdJfNMmVsIkrF7BRS1hcyIrPiTD6c
Message-ID: <CAFEAcA_wGB9mgLgzAvmz03waPFPaMNWXChAQb5NC+bUctLTK3g@mail.gmail.com>
Subject: Re: [PATCHv3 07/13] hw/arm/fsl-imx8mm: Adding support for I2C
 emulation
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> This can be used to test and debug I2C device drivers.
> Added I2C interrupts
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


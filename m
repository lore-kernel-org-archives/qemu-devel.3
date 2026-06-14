Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9F2CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYnCf-0004eM-3x; Sun, 14 Jun 2026 11:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wYnCd-0004eA-R6
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 11:56:51 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wYnCa-0007kr-RC
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 11:56:51 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-8ccf130dedcso5454786d6.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 08:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781452606; cv=none;
 d=google.com; s=arc-20240605;
 b=DGHBNELqDe0cXCxqPr7zZdF1SZRXeYJNbM6Lw8vwgmAUQkkbUFzIQrggT3R0fr6CBT
 mm6NW4WCs5/u0CFNN4u7T/HGibW62tDRcex15rzzsgNdrL56Kt5sdooSKZwzTazisb5C
 EiEcjQF2eNFyzV8KKbdW2Xk/zJg/WDfxYDa2rv+D3QvdoSxlrUHu1aXMOYRHbHhB7NNs
 Oq9OoevwbxZcRmsqTdFDqE9JJouS6KBjtYD/iHvk8O0rgjdHNlz2FvxOvzTkEHauwBIX
 7xv6UtIgj5k1HCXbd+NABeFTodcWvKxf3eFWQnE2+1em/g7p7BUD5w8Pgug8x7qiNMZ8
 fkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4714zu1NyKf7AxHrPS2grIVlMFq1zuydTJr406pWA4U=;
 fh=lrmPJ0Yto0CZ98BsYiLmCZW7N+RxTbMi63WegqQblAU=;
 b=DlGd2R7bdelIR1jNDOggRyAmfqcPjNi/isgy4fZ6StyPHw+f53MZtHOIgq+MuR+xU5
 GnjPzzcUW2LuyK5HHYGtSKaI4qu4roQhxSMDa660xaeQkC4cKAIs9kiQYaQsVLbtO1uF
 w1fTEVHTLmiqWslPun157Y6aKlVDC8gwPzGO4fZRsqY88c0+EOOql4zK1rRCWE9RNbRc
 7/XnzpByriuxXobvVvNqfHXzP76Hl3E4I3J2pB931lQfKa7zbkodKESO3eOuvRv+dp/5
 6+wPoIqdLs4XrWoc7AuZmKYNZnZ/6N2Ey9T71n30u9/DaSNeAeO2M7rfdAWazIZ/D6pz
 diyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781452606; x=1782057406; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4714zu1NyKf7AxHrPS2grIVlMFq1zuydTJr406pWA4U=;
 b=i4wV7f0zWfmKENh6UkUs1M5dWZd4MDZJ42FgS321hmpGeJoVgiueqyv0keUyL3PGaa
 q2Y6mQYpxcZcXeTHZJMPxIyf49FGwdmjX+MO7QNQ40S8N56U9Qo2XcV/p/4vQ2QWmdSv
 pJNQA/bLPMPCcmgtPra3X1W2p7i64DF4+FOlDmxZmSo+F3H0KO8HaYoqbpiGsnip29WV
 qWv4xKTzQo0eK59LV/gRkwS6iveF0leLvMdqaEdAuPeUi+fAYrzfcyUcsZREp834btPS
 BiByVBJINJEgL07RptfyDtwPF2YNfSi1DjFzRbfk1bCZj7qVUl2818YfO6lwjWbQkrDT
 spAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781452606; x=1782057406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4714zu1NyKf7AxHrPS2grIVlMFq1zuydTJr406pWA4U=;
 b=KNW2dC9Z8LvUXQJp9g2y74LSU0k9kLKLpZ7xCxPHBu4f8CbF6Cn/OaYe3N/ghM4ed9
 5yb274A6ElLHvuds7LZ2SPqvrL/uBXiP9G0m7qd/0BfAExf7FmNs5lYKgTvDWiSjwMV5
 QafnxzxkGgZM1pP3xOXw9+Kdv3XB9IYv06YDLGrAudW2VdDf9ZoKZgSF7He8QvFfr0aO
 oZxt0wfMfpj1ga1f458Pe3Syeq8qDNOScZxnKWQKgIiRdoMRKZczRWUoczeXoJp3siQy
 XuMpqM4UHdgU0voeU1NhCs8OpbVnKuxR4vriWl4iSSVI8LyFo1AzK2OyvQ2jVjiOWHJJ
 xwpQ==
X-Gm-Message-State: AOJu0YzEw0t6C5vcILVEFHp4QB5P/jbbbENnXoB0agnHkRXEvMAcPI8W
 gDlKzLBS6V2x7NUhLPR/ItArXzvHnUUVPGgVkD+jgTULd2HDVScj8/9+D3/QQwUUyhZoumuy/4a
 N3Laqrkzx1tzrVQAMfK5/W/R2lNgYTfA=
X-Gm-Gg: Acq92OGMEgVDHwFrLScCC20T770gyycJeM8KlbxWLdiXBtt+2Hs8OSx3Fs8a8ELwkdJ
 jidETXPtcGbOtjrJgIUps8pxj5r0efdoaK1Zs/l+ec5aNQgkW90Vv7dRCLQTTbeX+OnWp/Zb/6C
 u3BoaxsEOQyOuzj/0Pj+kuHRcxWsb9FmZdCiA++ytLIrBAPnN+wdHk8WUkcdzDrScv3XJPe0Tiv
 pVmTVEux1zCZhK22c2aT2A4pi6eu0qQ2kIgGrL8UuF91Rdk6WYq+GiLybVfmFjpAerVWimnhjwh
 Jkjt6g==
X-Received: by 2002:a05:6214:3981:b0:8ae:65b7:1b0a with SMTP id
 6a1803df08f44-8d32bb3edd6mr104778166d6.2.1781452606616; Sun, 14 Jun 2026
 08:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260225180555.154428-1-danielpaziyski@gmail.com>
 <20260420173816.63673-1-danielpaziyski@gmail.com>
 <CANukVxuz3feJuiOV8s3oCYb0PrE3p173mLSyzRGdkA_7haGeGw@mail.gmail.com>
 <CANukVxvbQ3_9QcLNNQHG7Tn2OTmn59FbKxe_YosHmY=8diaA3A@mail.gmail.com>
In-Reply-To: <CANukVxvbQ3_9QcLNNQHG7Tn2OTmn59FbKxe_YosHmY=8diaA3A@mail.gmail.com>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Sun, 14 Jun 2026 17:56:35 +0200
X-Gm-Features: AVVi8Cf-FkGuKyut6s4W6z2FKuiakFTgfRmrNtXArrPlpBHsqvMBb_XuEoJI_wI
Message-ID: <CANukVxusX7cKXnTy_V_Dm=ikcm=cvWXWTdWLtZ9Xi6VhECZxsg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/intc/apic: mask LVTs when software disabling the
 APIC
To: mst@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Ping. https://patchew.org/QEMU/20260420173816.63673-1-danielpaziyski@gmail.com/


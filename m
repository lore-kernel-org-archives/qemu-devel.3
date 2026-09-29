Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBE6CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBafX-0001VR-6p; Tue, 29 Sep 2026 12:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBafV-0001VC-Io
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:27:01 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBafT-000553-V1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:27:01 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 d2e1a72fcca58-882c2bcef77so1764132b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790699218; x=1791304018; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X9kWX6v3y+YXYZdUtYWCrvUlVDuqoAqJpKOAsp5S0x0=;
 b=FbRsYgH5QbmPk6zoQHmlQfNctyIgpMd82tZDeS3paoa45VYr7UI4Hhus6p3YaUqSt4
 nqFzKPt+BLgOgBBuwj1Rs+suhwNzQY00zv7S4I8VicMEAeBx/5gemmerQinjyh10J8qE
 6n7TDeNRdgrZyW30h7jIUp0ML0dm561i7mUe2HdGVtVc6cqEpIg0ziWXcyAFM9Rc13iU
 IsFUNaiZ39aoY8+zoBHVgWZCaCqA2A7bNkNcyGUaWsUFClVwgxZLZmTKdZPt2qnZMd3L
 7k9htZrGnoA+V8+gmbQ9crfZy9EgD7rkLcniXEtT/O1EWbQA7p5dDgSo8YIAVBGePQY1
 Brug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699218; x=1791304018;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X9kWX6v3y+YXYZdUtYWCrvUlVDuqoAqJpKOAsp5S0x0=;
 b=YqhJKDKGMUfZCJ/glR9XJb/MsC+e2MWtLNC/gNtEEohCGIsVSq9iNGdVOrOLz07UTA
 BLv9WNI1QJ0IGaU6YbI+98zqUncipP1qwg1dJnJrQ7EhCaLJ1vc5BOkT0ZDv910EzrpB
 sGyDAHxnZh+XQpLgjzj9WKI7h1tzKJg83BL5u4gJ0UZ73OJ+3KX6qtZTuzkbPqipb5nY
 LVqKZjHDxsEFC4N2psYR67SVB2xoRKu5bnsVzPKWgM6aOnRM79JbBfS/tKwevcgm6EbQ
 eF1HTl2QRwXvDIR68C4zhC+/YHKZVVN375b9ZiE7KkEQ9XJvgsFny+1fE9QiON5BrVeV
 uvmA==
X-Gm-Message-State: AFuF++lNxWU5BJnDISPjg9Rl9w1xAm7jBmQKQQRJTe4M8Kc+Smq4qtTI
 YOqZSVoDVX/TqQvgflLx57PCelV1muVCw1m0y4/0a2BLM8RxHIOMKwQA2Vtl3nBA0eQ=
X-Gm-Gg: AYBFou0R69K7pof4uVyLHe/c2qj4SOxfG4q+70lg0KQuXfxG/L8CJ4e3/MfNAhM7LZA
 vOf5VdHxcNJtCFr953BrZPCRh/aiDqi0DEoD+sKKpvnBbeBAl/T9gK3SlqgX5LmNBBqrN1McPyf
 pwcJyvvA6Mz43wasDErqFlmQewDcRh87f70SkucikrlNMmVMmjQvdRHOcPmGhjp+GtPzsQ0pSlK
 Nl0eINif/my/4jFik04J0dHYUWbogprKQhACWmeZhRiv4eTPyxe6ji8kGoSiWf9gN7lF2RBhvXD
 +KcZKwdJl6aDS3mC8X0HKWOQ2IlHaGxIaXOviXZgbNviSM2LsIg2WiYaGZ5jHcCDTLu937IxSfH
 RSHJVi+FnOy+FTQn9NoQvy+RE6drvMD0xOBeLFb1z25LDWATuYxemjR7CHiEKHuH4925pFdopUE
 twNrqiP58j/1WuZCOjs8B4rszVPsKRJi0Z2HyhqSeanW+XC8rAt8hWXFHw1jBfYMtmk1uqnHcGv
 JUlQDPpxBMFyO0Cka8S22s=
X-Received: by 2002:a05:6300:2204:b0:3dd:a196:69ed with SMTP id
 adf61e73a8af0-3de26fad73emr11609707637.72.1790699218256; 
 Tue, 29 Sep 2026 09:26:58 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc7d2b3b3e4sm103301a12.17.2026.09.29.09.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:26:57 -0700 (PDT)
Date: Wed, 30 Sep 2026 00:26:53 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 09/11] tcg/riscv64: Fix off-by-one in branch range tests
Message-ID: <arvmrqCgbcQ0FgMv@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-10-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x2a.google.com
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

On 2026-09-13 14:08, Richard Henderson wrote:
> We tested the size of the field encoding, not the
> actual range of values.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F7BC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Vcl-000594-9I; Wed, 23 Sep 2026 18:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Vci-00058w-As
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:39:32 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Vcg-0008Mx-LK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:39:32 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso818007a91.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790203169; x=1790807969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/4wl8e6dbRmpTu6wxYx6y9pRYqYmZCSaS/+Eh+NaSIA=;
 b=lg851miNrweEP4bBIiQwuPQBwSJyAdsiA6BaoCP6TBlTU6zlCo8ZB7l/C7BOEtNkPl
 +GkbkPxIw9aX4IrIPrI1XhFqkHmub69aS3r3kpjjKjhFsevPfuyaBhIae7AZJvv5SBF8
 NFU69+8asUWvoXPU8F3NHQy7QKvAQskYcOU9sxXd5NidQsv2fN+Af4o9OZO5pPrtg+Hl
 inZvOQdvk5oLgtZuywmfJ6ejp6kho28lyZ58VozoJdamZsqrnD9gjdB0kWPqhr3g1eDr
 m3+rgSRaVg1/ZzLH8she52eY+EuXkvI5xoL8Nwd8O8J+HusVdiKhFWGv8p/QT53QD/+x
 coXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790203169; x=1790807969;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/4wl8e6dbRmpTu6wxYx6y9pRYqYmZCSaS/+Eh+NaSIA=;
 b=K3TkmWeIQDq5PyK6XzcoA84WbmSFr19JjwAPkJLH8oCaDvtgsDFKZnmwpUBgWcT/Xa
 pNHKBuBQgoP2bg7OXKpIsnuSe6Zkrkr5O+DAxIr6ZHp6iUdkFgbTYRTAbK49PH6UhTgh
 7EZol/pBlGCx+dpdRqqM8gUJjZR6D23HFbecSHeydzrIuNYCyzY9mHRsusYLyFV55Xny
 Ee6MGWU7j4w1+yGuh5ZFdNTglENgdrdLadJyncLE5f62CfI4ty7NEarpqExvvby2ta+d
 LKf52GuuudiJT/CeLlhI1zeJFnrbYqzMazAmP8QGqiZFVupJNwkz1vflbWsGiSS2jOp4
 TGCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzALLNXlGL0NL/XJJm5ekXjOiNOOO+uWsZAD6vq8UXqAGEcNCEvuoudCtXq5LqO8hys8ls/hJRLlC8n@nongnu.org
X-Gm-Message-State: AFuF++mc+wMmxem2PEOhqL/VcBGJjIiY1QGegdZ4TSzHCSs1rGkGJS7n
 z7iMwi3ul27hyJFAb00i69HQ/VQBYvvwQsuqjOIPgpaJlp4X/sgYq7z1tVTXgp1Y8g8=
X-Gm-Gg: AYBFou1kn6S3JgnOKTYyV+a9jW/cFUztNWdp/B8d887COhY9J2D/+ctHz73iMIbHimt
 RzNVpyhyOG7w/dYxEe95fnhnJ/9vPLNDl9HfCHREVswXvINHFVZQ/00ZMs/xtgbTvqCcKRiWpxj
 JsZb8GnWXb21TWOtqeuOI8goR5Z3EJG6XW1Pe43RkBTaYleXLIlIWRcI4Zy4aw3UybWEMU1P3m/
 y+yHceuPiRadISwpVHYzVVdGdtASG2pKBGNRLJiWsGwbMVT7ztRrh3uGXi9zNZKpaUTKtoLOZoA
 M/WCsQ72Eni2MiT6W5j9vxHrn5nnJ4P5dujwc0Q4NlhQkT9tzB2KrdUQYzHsxT/SPjJeEoVRWJ3
 VHtYX1Q74sHriTlDu4eT3g3O+O+GCx29uyotLvYc7suyARpNIi809Yxt/cWnyySML7WaLkm1x+Y
 W8iuyjO0b22q5Fj8C1QVfSHa63YhY384SNvAUC1DagHLllhMkigCAIExPfrAF1De03oPCDpsmam
 /EBuIkscv0NMBM6Khl7/V5RJjXPJJdKZ7+KZvuG
X-Received: by 2002:a17:90b:3c05:b0:39e:1ff0:331b with SMTP id
 98e67ed59e1d1-3a098ad9d1bmr437157a91.2.1790203168946; 
 Wed, 23 Sep 2026 15:39:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972b11d4sm1176501a91.4.2026.09.23.15.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 15:39:28 -0700 (PDT)
Message-ID: <b87d2dfc-518d-40e5-a2d4-8ce5666e0604@linaro.org>
Date: Wed, 23 Sep 2026 15:39:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] target/i386/tcg: extend VEX.vvvv parsing for APX
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-12-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> BMI uses operand type B when VEX.vvvv provides one of the register indices
> of three-operand instructions.  However, APX needs to use it even for
> two-operand instructions, similar to how SSE and AVX share destination
> but use the modrm operand when there is no VEX prefix.
> 
> To do this , operand type B can mostly reuse the code for operand type H
> but there are two extra possibilities:
> 
> - instructions with VEX/EVEX prefix but no new data destination.  To handle
>    this, use a new field s->vex_ndd to retrieve whether the B (or H) operand
>    comes from VEX.vvvv or from modrm.  For now, this uses the same existing
>    logic from validate_vex(), but later it will be extended to read EVEX.NDD.
> 
> - instructions with operands "m,r" that NDD extends to "r,m,r".
>    In this case, in the non-NDD format "m,r" the B operand corresponds to
>    a memory location; when this happens, it is incorrect to parse again
>    op1 as a memory location, because that would read the displacement again
>    from the instruction stream.  Instead, transform op1 into X86_TYPE_2op
>    if VEX.vvvv is the destination operand.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      |  1 +
>   target/i386/tcg/decode-new.c.inc | 38 +++++++++++++++++++++-----------
>   2 files changed, 26 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


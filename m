Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B10C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5vb8-0001t7-NB; Sun, 13 Sep 2026 21:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5vb4-0001sa-9R
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:35:02 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5vay-0002Ci-WD
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:35:02 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc4b29fa803so1180630a12.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 18:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789349694; x=1789954494; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UtS5u+1eD4Z2AhmTXPYGTHkO9mfv9RCbB0EPbSoca6A=;
 b=DMy12gMd5fcBCeJEZg7sd8kysDZu/EPLC+eQEFCLkNTiXSoxicat7iMMXqm4xDnLCK
 kKqbpiC2vavObudMTJ2H36ZHE4GHECXwjxU2L1xnl2txGaEoFKOFDhkCEfAlY+vNkAbH
 EDob0R+INsJaV4V/+COAiPTXx870w5o7XEext447FkXSYJFb87zoeDb55NPke/MmI9+Q
 rK3z1H9qxY2QC8Klk9VF39hB6wDTwH/+Q9JMzq/iP0Y8O2oGNZDcw+IyVW+49uaK5pqL
 tPNGAuV2mGBnf/K1g+WqlUoU2i5KGsIcln0OW82785cRkZ4AX0beeRVn3AKeFGRc/End
 Tl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789349694; x=1789954494;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UtS5u+1eD4Z2AhmTXPYGTHkO9mfv9RCbB0EPbSoca6A=;
 b=dVL/D+l8Nbas7aE2AVhsSnFr5dRDhn6ihdlo4GwodP50MTsLdF1LWN10Dx6GdgMz+q
 hD3X7Ndo8jFDQOf35/e3qae2LNzlk6RWQz/BNv6VS9xnF+tX2iRs/cdCLArIEZbcfX3f
 7iqSIsjKxVzGk2LYodgFCgCk6tl4xShpAGuBYe+fZ+6ILRw8dbWfU7hHxfL6M/QK/no8
 DuSerFoabdeQRmS1xl6M3fEkyBdK7BNd8zwvex1DL4Cc7m3zl1hTpcSxBcBhqpp8Knpy
 5kMvHiDxnzTvS5JMuMMNkvkvTi71ej4xcK4xdfl5kbzzRbFCgSf5y5LN348kQSVQzJQ4
 ob6Q==
X-Gm-Message-State: AFuF++n7yTpUPrNl3JfUUMsoUYGeUoHkoBXz9qZwe073RDHbQcJg6aBz
 1p91URszX+kNVdXItVi9T12s9waeZ4t0oYcgSrOZIW0UAG/6jm+GO7jTbg5avpxeyGNksBeS4tU
 LdDtBwaE=
X-Gm-Gg: AYBFou0okQMEMVQkyP/dOXI2FdabL0UfhFk+Vpwmj+hP7v6ldDzT/tU6wW06DGGQM/s
 GLrfbX82qGWI+yfkO7QP8pRsd2c/CeOZyyChJCReiBJh+8n/20N2UR+X90rGR9qdptxZdFdspHe
 ZpYtkef9jM9VR6NnCuTVvVGQsqyeOYqQ67Ll5hWUcYwNZYo9n/oT1VN2Kj8M4IfnuFYBIDc2/TB
 xQc+QwrKtAFk01nHBBYh1IdwuB8KwTdk9fz6QKucUbK0MV0pksAqNycuRB1eDvdq464+Zb6UVBT
 CB/WEC0fyS26mES6kcF04S+D9wMXNErwdmq5jbUjFc+di7EGK+VcjxMD4j5cu17NPpN9Ldx6EHe
 eAIMn3yY1tfI0xvrx6a1mXD9ROSnHPrSS9U0A4i66czAaH+CP7X1xLMuMP1swvzFB3gDWwAMuFB
 Nw1utGy5XzYI4ERXRjFnsdp4Wb4J/6+QOs0ELRDAfYfILgzuOC0jE7X840l1dySs+TpQ4hgm3AL
 9/kGlO2OOCHA5uGl7p91TNkV1xzdPqt4DE/qKrxNA+nBP0dFk1pDdpNrku4Jw==
X-Received: by 2002:a05:6a20:914c:b0:3cd:67e9:8565 with SMTP id
 adf61e73a8af0-3db404225d9mr527354637.9.1789349693716; 
 Sun, 13 Sep 2026 18:34:53 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870?
 ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f739b5sm22778317eec.25.2026.09.13.18.34.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 18:34:53 -0700 (PDT)
Message-ID: <00fe78e7-8941-4da6-829f-1da1afa21fe0@linaro.org>
Date: Sun, 13 Sep 2026 15:34:51 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: add helper_tlb_flush_page(), use for
 sfence.vma with vaddr operand
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <20260904-riscv_tlb_page_flush-v2-2-defec3f29312@baylibre.com>
 <b11c9b27-8ec0-49d9-8cad-9f04b1ad3641@linaro.org>
Content-Language: en-US
In-Reply-To: <b11c9b27-8ec0-49d9-8cad-9f04b1ad3641@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
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

On 9/13/26 15:17, Richard Henderson wrote:
> You're missing the similar changes to sinval.vma and hinval.*
In addition, th.sfence.vmas.  Moreover, for that one, if rs2 != 0, we 
don't need a synced global flush.


r~


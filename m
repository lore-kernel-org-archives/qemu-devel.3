Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424F9EB596B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3lQ-00018i-Lv; Wed, 11 Feb 2026 01:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vq3lM-00017r-AO
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:31:49 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vq3lK-00048g-E3
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:31:48 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-81f5381d168so1717926b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770791505; x=1771396305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5VI3P8I4QXrt/D58wc4S2XlvSfUm8+jvHYdThYnzY4E=;
 b=UcwYGoVkLwfC+iHbpzk0l0QcLrfYa72eFf10kpdtrG46u/kAsgrYq79zoVKsmYL2Ff
 ptsLzqFncZOcVwsqehCdKm8KTQNg/PKtCzRS9742m2yFjpeNhJorSWi7opCKfGKffRSP
 0Bgq8qAvHnfHzrjZUZHDVGbKx1vNHVfOjnnZ5US6LiQ684aFzCKQm2W0mAQkVBsFFdto
 jFy1OChe2dueSJL7vXR5+CRAqS95AWl0l04urjBSQGYfdSHF7nh9P2gTWqBa/CXMElJJ
 APmurbux4xVVGgBDPvYv2sVbda7+rnDPH0kH5ditDlvMn6es1kjuqx0n8TDtxqprluS1
 sqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770791505; x=1771396305;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5VI3P8I4QXrt/D58wc4S2XlvSfUm8+jvHYdThYnzY4E=;
 b=niz/ifSFdcuhk5xJLpFzwUAolBTHENCADgRsCIXfMBiTDtYZHgzupwl/kDGw3DDtcH
 6EZvkNNwwUR9fz3HrES2p4fYn5TYZWNhGE1XS3fyvM+IstiT8zT/tCzhlioJa1iikEri
 QbC8cmKuNbI/dHTtevxzw3yY15q8hw9Cs8GMpSBkomEO6uhstSbMzy2QMHp6aHNoJxfJ
 zorg/+ca9w782ZVHZz433omlDUfxQUyRxUEohTbFBRrM4YDtU5zAi1bw4hCyXW/fNPaV
 tUCOceDRDO6CgbIwT4/DT77c/+M3egdpHP0auKxttH+4oXiXLNmx/tqgKhVqnLD2f0U2
 rnTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLgItXOvYkSSSwvi6pBxgu8igPZ948Ie9ci+2/8E1FA89OkdwzBT4FRHzbWGFvoEC9buH7bnJ1wpK0@nongnu.org
X-Gm-Message-State: AOJu0Yz2FrVvi/mPyA8hxfhqY0EsQMMv/SgZyGN/9gTToRS9NG72UgQl
 ibHk59BV/Kb4jdJ87oE4faeEhfsqiBSHz3wWAeLqpaPVWWS8ww10roOQm1i8A12iZIc=
X-Gm-Gg: AZuq6aJOf1hkeBIO2HGvLwMUtjDNVVd/UhVuX2q0SozHEuTIqn1TNCWkH9xEk15vHpb
 sEv/jhNsjKhrIkzQP4sP11mXZ5McNsqrhgjLONSo8njXqJhKzpgL0eUWcq0CUC4rkBTAw4Vv2zI
 tb62+IBkiL5I0QEsbkheIsqyPfVE+N2+r0iz7dL3vXrC61oVe1YLozV5IwxnNLLhgfOxIA6IwMs
 uaJJrfjuX2asDEhiq/RFI4iihiNEgsLy6+DS34lMm2DQ/6YY8iLZzcg0cYFPD0n+I53S7z5VJd3
 +qzvPB/Ug/fWkUbiVvhRAUND+r6shpTpGq/thwg9eqZcpb+mjmbUBaUGqlNcP6yO9u7eRxSBxDw
 DusbAClHk+m6F77BUugMNEojSqXQ8H6fxsbckev4NZHG41mVcZZeWqkgTlJI4duxuLxSuHZmlsk
 EMuKsKas29m7ZIrbZmzzsP4uGBjx3d1FtxUohvRbVowcBYAfSoDVmUcv2IbAU3W6voCop+89S7p
 2xUX+nqnjZc/JoSONfPSsD4
X-Received: by 2002:a05:6a00:22cc:b0:81f:43fe:988c with SMTP id
 d2e1a72fcca58-824416107b2mr15625182b3a.6.1770791504764; 
 Tue, 10 Feb 2026 22:31:44 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:f8f8:2c3b:9605:55a0?
 ([2001:8003:e109:dd00:f8f8:2c3b:9605:55a0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e366a76sm984264b3a.10.2026.02.10.22.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 22:31:44 -0800 (PST)
Message-ID: <8addf5df-614c-4309-8ae4-c3bb59f7e0ef@linaro.org>
Date: Wed, 11 Feb 2026 16:31:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] include/tcg/tcg-op.h: eradicate
 TARGET_INSN_START_EXTRA_WORDS
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
 <20260210201540.1405424-13-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260210201540.1405424-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 2/11/26 06:15, Pierrick Bouvier wrote:
> This commit removes TARGET_INSN_START_EXTRA_WORDS and force all arch to
> call the same version of tcg_gen_insn_start, with additional 0 arguments
> if needed. Since all arch have a single call site (in translate.c), this
> is as good documentation as having a single define.
> 
> The notable exception is target/arm, which has two different translate
> files for 32/64 bits. Since it's the only one, we accept to have two
> call sites for this.
> 
> As well, we update parameter type to use uint64_t instead of
> target_ulong, so it can be called from common code.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538E6E74AD8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 21:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIaEd-0007aF-Ve; Tue, 03 Dec 2024 16:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIaEc-0007Zz-2Q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 16:15:06 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIaEa-0003Mj-4C
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 16:15:05 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5f26265602eso119645eaf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 13:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733260501; x=1733865301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H3lLIWl0gvscLNFSs37nYrnRUHcjfyoNpgFn0rHdlX0=;
 b=gBuun+icNrJ1PP2YJoXwXG51fJyiUEhbrfYdmz9kt56PdR+yjy9L29OJyatCRPYbJy
 cDPQSwwEmqKNis7Kt31rl9M+SF+DPeZ5MjD3Zb3VxTRJCoj0PMtQ32/BT7mPu9cLyp9s
 E75Fm2GNaRGB5b8trCUsgwrx5QNlmAE1dRK+idC589KaztRPWszJ3JTD5XP0SFa7esmd
 b36pd//CAdwquidpzj5ywNj+9qmqvCN3RkwN6yhbdMp1MAYpdw9Ngy9qbULFvdSR64fK
 pHB08zlc5xQmAVuovNFXE9gkuN989A6q8ATGZ7UNgfWpkqvMfr/RAjaM+X97Vxx7P9P4
 bkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733260501; x=1733865301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H3lLIWl0gvscLNFSs37nYrnRUHcjfyoNpgFn0rHdlX0=;
 b=CVRLq97TRL4wMPyucRi8Ej9IvQoG1ae5PeUX26I7SwM4MGYZkrUjWIcL7FDNMZqu+u
 AKWhew6azQX00k+vwwUBvcMVw+hLiXr3dP1xf5TOAwNmLwtWZKFyYq8eAAQRdOs2Yatb
 gs/UjLADXyDzRdt6P2lvdyYPaHQqkWtKuX8CDCA5fyLXobl4ZkUGxyd7FO42EwmDrC46
 cuZFIxegD8qnnEMvwu2SKUzlOAaEADB8uwswxjOTHgW73xw0p8ii0aBtRplzUCYMm9+Y
 FDtXMffWSDHSSdSOClxZeM9WsMQQHLeGYpFjZjYz5gEsSgjOx/0/Pp3bEDaZgC1H6PB8
 waWg==
X-Gm-Message-State: AOJu0YwbRBPMxtlf0cBW6niN6iszJN2cxqzkBC3/HbJndkGFxkdlMB+T
 eNNuSCu1EksNPprgJRG9by77vPTeyu+ftYtst3o4dlIqpj+mFL5PohXpm8Ltczo=
X-Gm-Gg: ASbGncsEeUT5wWl87ESszN3GdRz9eIEuvVXYtlirnRzxj6yjGqZBne852VrvxDoBRDO
 Pcw8S2rf8dlzMRwMTboeXr5hZtfcnF2oz6IuJ2S6SPoPD7euXtEfggobXTRds3C2wFw2CG/GTwg
 9l6t1Y1+EBdai9jmNHW3FntCC8FHHBsOz1SlJIAdM4omAt0xVzwqpEADIYvEwoPNqxMf5wbcta+
 GNh5VxQ3EnnGHGuBCmTbzjUXf0fgoSWFi6JcPv1Yx9dk/gTTfSG/3CGmZ1dO3ixgMUJL1dE6o7O
 vVXO4VB/aUZAKrHren0SWFnGclPd
X-Google-Smtp-Source: AGHT+IHhg3CDhimQNYpeAVfsEtbthcMOOLZHB/9lf9DZDTGg+fhnQtdUwG7IfqWun8gMWVdzPtekFw==
X-Received: by 2002:a05:6808:2207:b0:3e2:9468:49db with SMTP id
 5614622812f47-3eae4a4884dmr2463704b6e.21.1733260501293; 
 Tue, 03 Dec 2024 13:15:01 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86346a2csm3057970b6e.46.2024.12.03.13.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 13:15:00 -0800 (PST)
Message-ID: <277dc7d2-4279-41b5-93a2-a8b9d8545000@linaro.org>
Date: Tue, 3 Dec 2024 15:14:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 03/43] accel/tcg: Add gvec size changing operations
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com,
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-4-anjo@rev.ng>
 <b2986b74-2c74-491b-90a1-9ec79367c2e8@linaro.org>
 <v5pkpmxto7vtshg7a5mifaozrzn6n5d7raknvydad3oxk67jeu@i4jydb4wylpb>
 <e4910c71-8220-404b-bb43-0b885914e183@linaro.org>
 <kxrtubx3f4yyzhlzzpgvuqvvutcbu3fclo3pgigjgpaauhxkfm@uvvdaentlh43>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <kxrtubx3f4yyzhlzzpgvuqvvutcbu3fclo3pgigjgpaauhxkfm@uvvdaentlh43>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

On 12/3/24 14:15, Anton Johansson wrote:
> The point is that we have a lot of Hexagon instructions where size
> changes are probably unavoidable, another example is V6_vshuffh which
> takes in a <16 x i16> vector and shuffles the upper <8xi16> into the upper
> 16-bits of a <8 x i32> vector
> 
>      void emit_V6_vshuffh(intptr_t vec3, intptr_t vec7) {
>          VectorMem mem = {0};
>          intptr_t vec2 = temp_new_gvec(&mem, 128);
>          tcg_gen_gvec_zext(MO_32, MO_16, vec2, vec7, 128, 64, 128);
> 
>          intptr_t vec0 = temp_new_gvec(&mem, 128);
>          tcg_gen_gvec_zext(MO_32, MO_16, vec0, (vec7 + 64ull), 128, 64, 128);
> 
>          intptr_t vec1 = temp_new_gvec(&mem, 128);
>          tcg_gen_gvec_shli(MO_32, vec1, vec0, 16, 128, 128);
>          tcg_gen_gvec_or(MO_32, vec3, vec1, vec2, 128, 128);
>      }
> 
> Not to bloat the email too much with examples, you can see 3 more here
> 
>    https://pad.rev.ng/11IvAKhiRy2cPwC7MX9nXA
> 
> Maybe we rely on the target defining size-changing operations if they
> are needed?

Perhaps.

I'll note that emit_V6_vpackwh_sat in particular should probably not use vectors at all. 
I'm sure it would be shorter to simply expand directly to integer code.

I'll also note that tcg's vector support isn't really designed for the way you're using 
it.  It leads to the creation of many on-stack temporaries that would not otherwise be 
required.

When targets are emitting their own complex patterns, the expected method is to use the 
GVecGen* structures and the callbacks therein.  This allows the JIT to select different 
expansions depending on the host cpu vector support (or lack thereof).

For a simple example, see gen_gvec_xar() in target/arm/tcg/gengvec64.c, which simply 
combines a rotate and an xor.  For a more complex example, see gen_gvec_usqadd_qc() later 
in that same file, where in the worst case we call an out-of-line helper.


r~


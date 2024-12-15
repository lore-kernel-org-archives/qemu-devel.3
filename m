Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3FAE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 15:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMqQU-0003mU-K8; Sun, 15 Dec 2024 10:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqQT-0003mE-B5
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:20:57 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqQR-0005yy-MO
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:20:57 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ebbec36900so259379b6e.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 07:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734276054; x=1734880854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZTXkqeDO03oQQio7LV6Ebhxt0KLSXOR13nLUHhpZlRA=;
 b=r4e4MDFCakps2y6MKFEM+DjF8zgp7sZWOiPF4ltJgAG3AILdJXhq5Zv1uM1D8x6YYy
 hAhbEpsz3MQBLgjo9O0JIgBCFw8EhAKJp3nlYR5c2VyFFGrQEeliP6sa/hvdUgyThHrX
 viJHFUBwZwy2IlrzOD2HtM+z8+/eIDoiutgQnVQHkwBZ7YDuB4BQUi44XJgXeFmjOrgu
 1GOA4xg8W2f2VYFH4UNC63AdlqrDCMAmAw0Aojxm8zkBQlB7w2W9py4oppesfQnjbDQm
 l7FGo9ILN9Fg5B2xsie6mbx3J1vshpqUa4XDCHOaGk4qfTk+4TYTPLP/Kek5LvkJirPm
 OUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734276054; x=1734880854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTXkqeDO03oQQio7LV6Ebhxt0KLSXOR13nLUHhpZlRA=;
 b=LV/EZQjsl6HLbH+yazlg5ClJW4LkeCr2MBxiMY4pbFSh4ZTuhj4NscLkY9UytuvLb5
 QSw/o+VatX50ZRI49xkzLynHpx0ZlGp3LWPl+Rw4SXqAvlyOuxugWzXGuIfAPsEbHfkH
 U4vi+xI7gK+zAy+Op4wWqdpDlaSQSGdkSUPOrhCrC951clmwzoHVTeSP6WK/4+vkDObN
 1ksf44xrTxP/+n2Ambit53LRKzZ3+o1x62tmZS6+iQfe9a+181LXpmmIhq39Gr2qwWiy
 D6HVke9IgizWk9HTtbkMQsQHXnWBttv5IPX6slkud9+Lm/iOaOzKH5wSI/hEAshvG1b6
 Z60A==
X-Gm-Message-State: AOJu0YyeQZZcrgQQuYHwIzlC05cKxTYpZvJcyNKCpb8+KIYokn5qisRd
 UKbvKVnB08nYni8hSTYwXD278IOu6bCQcwxl7lEY0k5wnJmP1neIwt5HJBQfAuY=
X-Gm-Gg: ASbGncvFNgT5AIFEJKboCtFp0TcomOCuFvjGffZDVzYvTG2AR7DPwx2WYfpqQF25WLg
 9lV/kviaGk0Cd6jiTMb+rXGTs8IAkKry6CoNaY/tcYDbPDnaYot5d+26ktxvvkvqoEmCiBQiOfh
 X38hWBl6d1OoXvUIe9TpyMcDJSoVbICrrd+Lbh5pQlgg/B7ECYOPXgchde+zIvKvUhpMlS66Dh2
 uh1UYDZ+ZX/X3U+moCrZvYKVRECpZwOXje24v4TXfj84yW/OVFuRnO50wL3pDLOsNgluKsnQ78v
 vUsa+YjspEzooadvs1QFh8St4aPJGnUTx1o=
X-Google-Smtp-Source: AGHT+IFTYittD9kfS33bJCeRnY4WpuLRN2LRlh3CUnU4/kuq0DpDzXZLMo0BcHzei8BNt8lpgb4CzQ==
X-Received: by 2002:a05:6808:2191:b0:3eb:5c03:2508 with SMTP id
 5614622812f47-3eba6871df0mr5318815b6e.18.1734276054297; 
 Sun, 15 Dec 2024 07:20:54 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a362sm1051237b6e.4.2024.12.15.07.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 07:20:53 -0800 (PST)
Message-ID: <bb8030dc-bf47-42cc-a4a1-49e4f9fc825c@linaro.org>
Date: Sun, 15 Dec 2024 09:20:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] target/i386: make cc_op handling more explicit for
 repeated string instructions.
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-9-pbonzini@redhat.com>
 <98175648-fd1e-470d-a8e4-a6053cc3c35f@linaro.org>
 <CABgObfbV4A71dRi+hrjkTUKoq_=g2TLWBs5f0JwT=2pd0+dOWA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfbV4A71dRi+hrjkTUKoq_=g2TLWBs5f0JwT=2pd0+dOWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 12/15/24 09:13, Paolo Bonzini wrote:
> 
> 
> Il dom 15 dic 2024, 15:45 Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> ha scritto:
> 
>     On 12/15/24 03:06, Paolo Bonzini wrote:
>      >       fn(s, ot);
>      >       gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
>      > +    gen_update_cc_op(s);
>      > +
>      > +    /* Leave if REP condition fails.  */
>      >       if (is_repz_nz) {
>      >           int nz = (s->prefix & PREFIX_REPNZ) ? 1 : 0;
>      > -        gen_jcc(s, (JCC_Z << 1) | (nz ^ 1), done);
>      > +        gen_jcc_noeob(s, (JCC_Z << 1) | (nz ^ 1), done);
> 
>     The comment in gen_jcc would still seem to apply:
> 
>           CCPrepare cc = gen_prepare_cc(s, b, NULL);
> 
>           /*
>            * Note that this must be _after_ gen_prepare_cc, because it
>            * can change the cc_op from CC_OP_DYNAMIC to CC_OP_EFLAGS!
>            */
>           gen_update_cc_op(s);
> 
>     via any path through gen_prepare_cc that reaches gen_compute_eflags.
> 
>     However!  Because this is JCC_Z, we will never call gen_compute_eflags, we will always go
>     through the gen_prepare_eflags_z, which doesn't have the same problem.
> 
> 
> Or more simply, fn(s, ot) must have left CC_OP_SUBx in cc_op.

No, even CC_OP_SUBx can (and in this case, will) goto slow_jcc.
My correctness analysis is strictly based on JCC_Z.

>     This subtlety deserves a comment and maybe an assert.  Perhaps
> 
>           gen_jcc_noeob(...);
>           assert(!s->cc_op_dirty);
> 
> 
> Either that or an assert(s->cc_op != CC_OP_DYNAMIC) before the call to gen_jcc_noeob().

No, not before gen_jcc_noeob, since that's where any buggy change would occur.

r~


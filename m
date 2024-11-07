Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1962ED4335A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91ux-0002HM-Iu; Thu, 07 Nov 2024 07:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t91uw-0002HB-Jd
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:47:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t91uu-0004L2-Sh
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:47:18 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d518f9abcso557629f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 04:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730983634; x=1731588434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=36ocz2UGSGLp/P4/X2OErcbO6/Tu/TZX+h/RDgbuMis=;
 b=od0F2DjDDWEWPjjZo4Qp8dbgpSnTkHViyEBM0byDBIwjK95Pu0OR6aBhwW/hUlTQu5
 BAUo9LVzcIM78GdCVXyYcY8D/R6rQGZ4BMhxFKIW2kD4LlQMcZ3IpdaUd8DNCRmRrq6W
 lBs2GZSiBA363oMQ8H23BHQb2T1O6uaSiBW9P5NSXMpXLa9x7tHISw5/nZb5jVxgsMDJ
 0qlgXrZ+j9ejXsTNVpcU/okGoRvf20969Jub24jNdggb4o2y9T24KHedrJQWog6I4C4l
 XXlD8RHMiFl9OWZ+8q0XWiKJuVIn63CIfoKhAnXzArgfKeOIHWv7wj/wcixJiApiHvji
 O4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730983634; x=1731588434;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=36ocz2UGSGLp/P4/X2OErcbO6/Tu/TZX+h/RDgbuMis=;
 b=UmdWCcd5cCRhbYhsCAdgphU4JrCIz7uk81DLxZHRxexvtX7bOHT+l5XNsyE582WDgp
 oyH2DfIlBvExwUqHKAv+ZnrBTXKGqtXh45+Nn+32DAfC2AtPtHLxYNVzRprl4AwKLUxF
 5Tgu+06/LWt/FvyqvH0UJP51+4+/FRa9WZTeGjln4TH6jwzWOkCjFqUEfE3qZ8Mw93XO
 oXx34HLquhM1I3+Kvvqteq6BNrLCT7CfS/0RNDqoA8BuJTPTWLAU5Jz2rxBnbiGoaCZg
 RonM1RETP0ujbGRtg7gJg+3tDIH1l0KjCosRkXjdB+vj0YhRAg+ihXyICRUE+TxMfM92
 WB8w==
X-Gm-Message-State: AOJu0YztP95AuS+eBg3pTneai9H7i9qVnvlK3eu2KYdZAg1HyA2KvUzS
 BQT9i+JgKD5xxdQrbtQUH/iXPABSLdOWv3ZlhM5fsC1H8zcF4w4bHjiCbQ2Y1rE=
X-Google-Smtp-Source: AGHT+IFE1gV7SfYPpb006wJKmTzuP+KCP/foOY1s9KBP/kBuUnGiUtxYEflVmBY5phSBOL0ofhByqw==
X-Received: by 2002:a5d:42cb:0:b0:37d:4d3f:51e6 with SMTP id
 ffacd0b85a97d-38061128d8dmr30612039f8f.14.1730983634143; 
 Thu, 07 Nov 2024 04:47:14 -0800 (PST)
Received: from meli-email.org ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9707d3sm1630744f8f.19.2024.11.07.04.47.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2024 04:47:13 -0800 (PST)
Date: Thu, 07 Nov 2024 12:44:04 +0000
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PULL 32/40] rust: introduce alternative implementation of
 offset_of!
User-Agent: meli 0.8.7
References: <20241104172721.180255-1-pbonzini@redhat.com>
 <20241104172721.180255-33-pbonzini@redhat.com> <mkvxc.kptyckk1ksc@linaro.org>
 <CABgObfbdGz7gqbej1J0iN2GDgbHf9WhmvnfwfSik60AUJcyXRg@mail.gmail.com>
In-Reply-To: <CABgObfbdGz7gqbej1J0iN2GDgbHf9WhmvnfwfSik60AUJcyXRg@mail.gmail.com>
Message-ID: <mkzin.ykt05oslddrq@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

On Thu, 07 Nov 2024 11:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Compilation fails for me, on macos / rustc 1.80.1
>>
>>   error[E0369]: binary operation `==` cannot be applied to type
>>     `&Attribute`
>>     --> ../rust/qemu-api-macros/src/lib.rs:25:43
>>      |
>>   25 |     if input.attrs.iter().any(|attr| attr == &expected) {
>>      |                                      ---- ^^ --------- &_
>>      |                                      |
>>      |                                      &Attribute
>>
>>   error: aborting due to 1 previous error
>
>You need "meson subprojects update --reset" as mentioned in
>the cover letter.
>
>Paolo
>

I did already, also purged the build dir. I had to delete the cached syn 
subproject (`rm -rf subprojects/syn-2.0.66`) to make it work FYI


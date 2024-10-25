Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C52D149C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4N59-0005eA-Rt; Fri, 25 Oct 2024 12:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4N58-0005dv-T3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:22:34 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4N57-0007TW-7q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:22:34 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb5fa911aaso31597331fa.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729873351; x=1730478151; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9+wLAiY57wa/0yeBtyIf9H5B8Kh5xcFEI0nkbJQqgDY=;
 b=UT1vctLAtNpLd1+u/U+TZlZVN5b8gVeuVwAtDZixC1hBBQKHDhc6MLkV2uVfvMuX4q
 Mum7rC32SQ8zPZnpViDmb+KbQv7bd6Dbp2eLVuSc6ysLj5NH/rL+JT42IELhJvETfK7c
 CpfIl6vVTtk8hNiu9y9lIifWehnl8AZnKJJIqD6KxVv/VgXvEWYDLBMFxFBEQCFyJDzf
 O9RUpABzh/Bqozww0VtJp+EBllihAYdkALxkg8oDNOUjztGrFQDQSg6R8/UeaR+aqt9j
 bugw8y0z0owjHeqCw2GrMlNart+wb2Hbd/rlNn3pyW04IfDcFIhKdYcNSZWBOYNoyukE
 RmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729873351; x=1730478151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9+wLAiY57wa/0yeBtyIf9H5B8Kh5xcFEI0nkbJQqgDY=;
 b=Ch60y6mGGyDFLDQX0znYxXFryhLozlLUBMFUTpIUXvjyV4+AV1W2GBAvjfBORGA5HD
 XonqgH/yM49aERiklRmADqPT8SksaUU/Y+Q+R+7BnHKJTQ53nrHc6KLQvPkTBGFWhx2t
 bc/Y/gKZJtHzOXMiZ54uLvdwIMrWVUJHCT9RApkqZR4/StczoER8dn0SCBApppMdBCNc
 lLeZgG+plrPp7kak45zl3QDjOQAXvv4Pp/8n9PAWx2ZWXNP9UUCmBk0EnrY4TDBKwMrF
 +mjafvi/SPFwSGiPFaKl/rWQTA9RwR/KeC8Ca9dYcQgRHVjo1PLY3/vmjYsyOlkiIE7G
 f8yw==
X-Gm-Message-State: AOJu0Yyh1sXQ4Ruak8lPypHR2A//COqmt6E/haUBzj5avQtwoW+J8YQg
 79gKbTXeDJRCtfPnJnAavBA7IxFlVkt2vnlEo9kEykezs1DHbAzQthB/HRsXJGduIOi4XXX5j28
 qaL4D2PlBTT386oMaygWURRpyFCtRARz2pSwlPw==
X-Google-Smtp-Source: AGHT+IFhVz0w5qjaYA7f3hZguc8vtH68GOyf2zbf5Mnz35xXMkAUXHdTx8Slqmv7NCB2MB0/G31fJB25fMegM95ci80=
X-Received: by 2002:a2e:5149:0:b0:2fa:c0b5:ac8c with SMTP id
 38308e7fff4ca-2fc9d33adeamr67753871fa.21.1729873350631; Fri, 25 Oct 2024
 09:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
 <34f5191b-67d9-4815-a58b-a794fff0294d@redhat.com>
 <CAAjaMXZmNN5WS7ETQnGgUvWK+aY9w0oW+G3oBko_C2utK2BjHA@mail.gmail.com>
 <CABgObfZj1ViRJ_6mgvuzYuHGqLvQ43G+va-6ahZbk8ripr5pcQ@mail.gmail.com>
In-Reply-To: <CABgObfZj1ViRJ_6mgvuzYuHGqLvQ43G+va-6ahZbk8ripr5pcQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 25 Oct 2024 19:22:14 +0300
Message-ID: <CAAjaMXbxqqAqB2SEqLPFdw1RpeH6bcL7f241dEXTKmXfX9eraA@mail.gmail.com>
Subject: Re: [PATCH 03/11] rust/qemu-api-macros: introduce Device proc macro
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22c.google.com
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

I disagree with your points, Paolo. A patch review should not be "Fear
Uncertainty and Doubt" but point out actual problems with the code.
Please do not proceed with this conversation since it's not
productive.

If this series misses softfreeze because of code problems or by people
delaying the review/merge, we can figure out what to do when we get to
it.


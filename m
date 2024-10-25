Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBD4D149C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4N6e-0006v3-8E; Fri, 25 Oct 2024 12:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4N6c-0006ug-UJ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:24:06 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4N6b-0007ZT-GH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:24:06 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a1b71d7ffso331030666b.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729873444; x=1730478244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k5YytcxA9pktv9H6nEPntH3CH/fGugWRxyN+AfXHAyQ=;
 b=CJ/G9yU6OWRvBNCM3Iv/h7OthWFUVkNL1O5LQYaRqSIsm4Hdj7WgqsNZfQYClMPM4Q
 blpaxtEcvsNAKje3pPR4zcjJ8tCrWgfsqd6nQOIo91+IB9uVfn3stB6bt14/J8qGqNcV
 pzGXrYpPWEO8yCHH+4RZoUtrCEVOxckA0bBo3oq62yoLDr53d3U1KFlkUZCYXO18EZHr
 M7xMM4lFmgZNLpg3RMVWcfTqJLsC+sMFlfov70aBiDyCNK+xJpWB2TWjjV1NYY1V5HPM
 rqhrUOBvcO0iS54u5CLFztDfOPP0ikqR6LPDO0hKbjWWZn3CItZEftMIDJQl0+rDNUMK
 npoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729873444; x=1730478244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k5YytcxA9pktv9H6nEPntH3CH/fGugWRxyN+AfXHAyQ=;
 b=PxAA2X0WL3KhYx9iXTVq77YCOaRD1Vp+DI0BSboQrqQlQD/G6Q0HCrmjROC69tpb0E
 4STPjUTReLs+e5hh5881Q2fJ26BmD/pIgJmHC1V3Ztp8Kw52pnJQhL/JHcNcOtreUY4Y
 s5qlwfPzJ+Ir8fpHrJSgN5kMZ+Rornd7R2QPrt/bE+UrNz93GQ17QbnEsecPp1fDJ14v
 q7PF20Dr41jfl8UzauZNOCh0Ad+EiDMHB+1KAQJsMuY9ge5HMq66g1Hx2dKGc6Ryw0WC
 hFCyLmBAi4l9Aa1XywnBpyUmR2v3dKlholRU116HKUNby8lqBq3ioks4AesyIBO6KmnI
 boYA==
X-Gm-Message-State: AOJu0Yypk5nMRSjzstluue32xuzqwUVTDeIuAp7x9KHZvKdC48uahUPD
 g6YAAzkR3lNgF2VMn4dqogtvgCelIhllJEa/NeekAGerK1L/cBNeqjnNx/EmJqIPdB90ehAxFef
 RTv2EW3p3ugeaphB0DNlFmQYZNaPu5YhOcr8oIw==
X-Google-Smtp-Source: AGHT+IEFOJ/3RRKy4ow63aLvU5lkZM3t5ln2cyLjzgXRQXq/Z4jg8Vn/7gLw/wzytLXcybB8EmKB+bBxyvzhAbyQB28=
X-Received: by 2002:a17:907:9486:b0:a9a:6314:40e7 with SMTP id
 a640c23a62f3a-a9abf8756e6mr1021370766b.17.1729873443715; Fri, 25 Oct 2024
 09:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 25 Oct 2024 19:23:48 +0300
Message-ID: <CAAjaMXa+fyKHyufwmEQG5dqvFWW+uHtu9PDMkznD=3iViV6L1g@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc and
 bindgen
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, zhao1.liu@intel.com, junjie.mao@hotmail.com, 
 berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

Paolo, you picked up my patches without us first talking about it.
This is not how things should work.


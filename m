Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9A1C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 15:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNDT3-0006DT-43; Fri, 28 Jun 2024 11:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDT1-0006D4-Rg
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:24:51 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNDSz-0000lL-9J
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 11:24:51 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5854ac817afso975601a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719588287; x=1720193087; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D5HUSUDLHOTtK/umfe4PWzRCmNKwIHPNF0bzagzfamo=;
 b=lW3vfy7SmWjdH+bpQ/2sAzbQS364dcEMsxb3O/IW/37JW0SPUwzleBSvlCHbqApUoc
 NvUYxpWCCkvqVWyYuTF7u/MJo/pkQTmdBwsd+0/bMpEK7cU2TxUaqIu5DQEHqlFSTDv3
 kKM+9igXDzkufcffVMyO3KUT3PaJh9aFtHD4lEqkAY3WEMkMgBcylVpYAiimu9WTNmFO
 Job0IOUcmF8ubzLrM7L08NaB3uDb42SRnpHfFdx7kHyzPa1BxauGCJxl7riwLZAvzoLI
 /tGcs+qDDL+HECZBPg/A/wH/1tQJ4ExnVytf+Giubl/6C6psJJVCs10ukHBe519aMsAT
 yRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719588287; x=1720193087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D5HUSUDLHOTtK/umfe4PWzRCmNKwIHPNF0bzagzfamo=;
 b=YRc26NJgUfXmcy4rht8Ve6pWLEtGp2AenSjbYAVHFzXYQFqqvuatSQZ0W8RKD9PNSB
 DrFUptvnPYoZ4lrK2QMi5oqZKqwpLpWSs+uC4Gu9nyJuM4ygyB8L1k/9Z3h9MU9S/x+j
 Dvli4u83w7zO5b2wk3G2q9rTO1HqHJsJCxZXfdwRvsFHAJuR3YRhqmYGMBiGd9kaVOhe
 /do5sBDBMZGF8Qzl7gNZYGSi7gfUJJr3ABt7PcRjiIKrrkSc/fD8iIntFwK3eWeY5ICu
 DXsJ8NTMIoHkWsFyUrJ6HB+obvURz2/ih6otFwkSdB4F5Y8cHXis887/NvQDpTRia9tj
 3rew==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5WlYGAJc6JAFRLPXppFCyAHIbd98TEcnbzFVpMCZpCDDwPRe+M8NPdQe8VtMZMnl021H0jbd2Z68dwyY5M1Ef5ZzGPuI=
X-Gm-Message-State: AOJu0Yw6hDQH21JoVc8A9EU6qDt6TI6l6Lcc5SayE00auVJey3F56DAH
 gQyrYiu9aQkE1UQWj4ufd61mPEexWhw9YrQbu73961zN3BWc+n5oewrUD6H9rCoac1E4Te4oeRI
 sFI2ulrfDCWwwvrwSXD/TbsgOpKMkTzfMdh5bvw==
X-Google-Smtp-Source: AGHT+IEKGBfQUnvRNaipRGfVEHOj0R3ZWfoXKzwvAt+itiNURd6pDpOePdl/pzEEsHFkaaTBNJAP3QCIpBScVNvPdRk=
X-Received: by 2002:a50:9354:0:b0:57a:858d:20ca with SMTP id
 4fb4d7f45d1cf-57d4a2cd733mr13202499a12.28.1719588287418; Fri, 28 Jun 2024
 08:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240627-san-v2-15-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-15-750bb0946dbd@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 16:24:36 +0100
Message-ID: <CAFEAcA8OcwR5RakjDutwE47o4=jixhM9pt=EEL3rdmCvZjkHNQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] tests/qtest: Free GThread
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Jun 2024 at 14:41, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> These GThreads are never referenced.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


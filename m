Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BA7CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 20:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyyqo-0002mW-KM; Wed, 17 Sep 2025 16:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyyqm-0002lt-Li
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:34:00 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyyqk-00058n-N0
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:34:00 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2445806e03cso3404415ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 13:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758141236; x=1758746036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o06i7bnTP5n2IrQ7VwvEnn1KIKTMocqtqFRmFcxhrms=;
 b=WCk+s/4Losk7VBp7IDM/duLsbatjhVhrYT4BKckXJbIbV/YfBkgsMTJM38GbizNBS9
 uw9iseWueAbNNoSPhQcmCTN5KOnBcmtn9gkzrEGj9GWg1D0eM8+AKF5/RU+A7dAxOOqR
 s1PtO0f6/2Vt0uB3rs1kfocf/kKRNHKZ6AV8d2fNdYNgwsCPrUQcHH/vQjMjdyQoxsdB
 CYmK6bm6ZWyNwRwnLYH2/is2TZvPQhny9qi8USQXaMI31STfqjB9oURjP4CswbsCbmqU
 Z4//QtjkLiSqPO/BiEWEKi/w7ovE3fFz1WTfl/T9hTqLbXnNfP7WnZQHP98Y4TC39hXU
 pBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758141236; x=1758746036;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o06i7bnTP5n2IrQ7VwvEnn1KIKTMocqtqFRmFcxhrms=;
 b=kfctcZNEGm2bLkU+Oof6Y0D5AsSLHAqmJy5E1BOHkk9ly0wiHplSqA3n8y3nPqvPOJ
 UG63n4hCbZVRrF/Wqqr8qoptUhWXKFJWP8fAp8U5fuGUvrXP+Zhup+IiIke34bk/JEKT
 5BdS8jsqL7g7cdHBXbyUlMFnVmy0/357aa31jeddBy+zDbUa2CIwCaD0UDBNo8BjyDSd
 KAZDWiiYdxIu9tOEE0Twpl1hWlEj4EZylp9athcfd0yhkzLLcbOwLPVUlo3M2ZxPb0TQ
 sKJjU2Kma100E34UKvmCbKyHWoZJ4VzcsJGR3fr+6MMX118/mUqauDXgPE2UWZY1elB+
 S1Lw==
X-Gm-Message-State: AOJu0YyPoExmruAaJ8tZN44YopsDKKS/4wM5StF2vahEGlKm0ANfqk7R
 SAn62S29mAaWckKdFXPgQHHUHw+wi2uUAVyCMqPYB6B+qlgOCvPswoSF1svEfbLv7ALW8fNnn6C
 CHy2G
X-Gm-Gg: ASbGnctbppFhfpSFJCWLmBkLHB5kIFWfeA8E20mLuK7UMsm7uPBtJgOOs8xYNHnx6/K
 9vz19/ezgRY0ZUrKNyhkiTJt2lkatgMYJ0R+PLS2NsxcQR48baN4hmtqvnqimiu0IW1pByVXhmU
 skHl5qWbxT1kDIb7QFGdknLcZGANGeMJXVw/pVYw656GSEJwUuZvvo3uj461b1QBd0k6UBwTqzT
 iNXRf6ffjKb2wkiO7znDCqvuTy1FQwl87TFSfM4mSqhQVpKxw7AKs5j3Y8Bi5eQNzg5jvrmSVIR
 QBCkeCE+6fayZpzJzKCD0uddt8bpRh/OrQLNhpppcEVVGNdKzN9+cluFh1gs/exvkaAGq5mtyOG
 sNUMXhx3FRhCkHu3cqPfZm6sNweyrLsq7j1HbVLAR8l3CRLhJDnZQ1gM=
X-Google-Smtp-Source: AGHT+IHwookrxXPNjEa2VOHC1ju4yQTReZ3W2H5jp4VILkawxe7XDYWH0eWnRmmkZFt1P0bQJLDibg==
X-Received: by 2002:a17:903:8d0:b0:263:a2f7:60a0 with SMTP id
 d9443c01a7336-26813aef9cdmr37615775ad.48.1758141235870; 
 Wed, 17 Sep 2025 13:33:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698033c922sm4038675ad.131.2025.09.17.13.33.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 13:33:55 -0700 (PDT)
Message-ID: <7743993b-7ad8-4fe2-a80b-6a40a4fa8360@linaro.org>
Date: Wed, 17 Sep 2025 13:33:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] util/oslib-win32: Do not treat null @errp as
 &error_warn
To: qemu-devel@nongnu.org
References: <20250917115207.1730186-1-armbru@redhat.com>
 <20250917115207.1730186-9-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250917115207.1730186-9-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 9/17/25 04:52, Markus Armbruster wrote:
> qemu_socket_select() and its wrapper qemu_socket_unselect() treat a
> null @errp as &error_warn.  This is wildly inappropriate.  A caller
> passing null @errp specifies that errors are to be ignored.  If
> warnings are wanted, the caller must pass &error_warn.
> 
> Change callers to do that, and drop the inappropriate treatment of
> null @errp.
> 
> This assumes that warnings are wanted.  I'm not familiar with the
> calling code, so I can't say whether it will work when the socket is
> invalid, or WSAEventSelect() fails.  If it doesn't, then this should
> be an error instead of a warning.  Invalid socket might even be a
> programming error.
> 
> These warnings were introduced in commit f5fd677ae7cf (win32/socket:
> introduce qemu_socket_select() helper).  I considered reverting to
> silence, but Daniel Berrangé asked for the warnings to be preserved.
> 
> Cc: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> ---
>   io/channel-socket.c | 4 ++--
>   io/channel-watch.c  | 2 +-
>   util/aio-win32.c    | 2 +-
>   util/oslib-win32.c  | 7 ++-----
>   4 files changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


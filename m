Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650A8C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 04:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmnss-00043u-14; Wed, 20 Mar 2024 00:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmnsl-00042p-Bj
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 00:48:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmnsj-0007Hu-TB
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 00:48:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e00d1e13a2so22091975ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 21:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710910132; x=1711514932; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWrHrWlJHAd37Xlmt8FIThSCV/pVvYFW4UmE4oBFjcY=;
 b=XkutSpnLVPus9UYgblChyxpMX3Cw0nvMN4YCzITjWNjTRsNHhDz40CamLhPgZe/Ug6
 nrNVZcpYiEPyKZa2UZ699jO4IGadXt86HQYhgEOob2MGMUoUJOAjQ4BqDm5Uh/BG+MDP
 cGygYo1Sw6hXyolcCZmldRHdOq4JmFwe5fO31KiTdQZoGAz/dKC56wutMMUXmWCusF4J
 46KrJAT4VoJpdlJDhg7fF6Lsa+o9SFudNACH9/Q7+WIElRo8O67o5WfKo92wRs29TIyt
 1xmhMZch84DjD4jSKZ9Fij1GmH/o9RLvrjHUb3F1mANct5KeUrKpv5DTiDWNCadTVylR
 1QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710910132; x=1711514932;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nWrHrWlJHAd37Xlmt8FIThSCV/pVvYFW4UmE4oBFjcY=;
 b=MubTqh7tRndlLzJalAVTN1ZSGg2RIC6RuKhyKPtnfUa6vFWSztjf0LYMTaSCo1T+iu
 sorECYRfmPLJtWmlqTJUDr0N/OJptQENutsmpCidgtTE1iiHxhpCJ2nbRUygzxEHwnoX
 rts9KtkyaegeIaNA+v1EgTnP7BpeUkek8tk7YHWp+Q9RXOwTQ6lW1E/TlH+5p0sHEIJQ
 LwzNLcAce3D6LzD7oDKIpicDVDOA9bKkgPbC2ejOCmbBQo0BVWNdP/ve0qWqvrotZXI4
 ZAUrb5AcZV9hahbBAbt/zdwuHpNwglwf6sML08O+iWKftRZBBAa5P0lxxYTnOhcfWGYz
 8d4g==
X-Gm-Message-State: AOJu0YzKqE8j6finPzYPI/Kscv13QGlKmf75llVFTzUXepkzt1SgtfM6
 8ZqzhlHhP/KLESc0HRs+pG+e2XgHyRsqH9hVYQDFnsCQn2s6HoKn
X-Google-Smtp-Source: AGHT+IE7/nFra+c/YGXwCSXSMqRrSeC1mVckh4fHAsPS5nSyqC8I7isJ776JNakP39WQgInuhMtkMw==
X-Received: by 2002:a17:902:ee8c:b0:1dd:6ce3:7442 with SMTP id
 a12-20020a170902ee8c00b001dd6ce37442mr13037331pld.39.1710910132638; 
 Tue, 19 Mar 2024 21:48:52 -0700 (PDT)
Received: from localhost (193-116-208-39.tpgi.com.au. [193.116.208.39])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a170902d2c500b001e038619e34sm3694256plc.221.2024.03.19.21.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 21:48:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 14:48:45 +1000
Message-Id: <CZYB0T96S7CT.NONBFAOI30CD@wheely>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>, "Cleber Rosa"
 <crosa@redhat.com>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, "Michael Tokarev" <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 08/24] replay: Fix migration use of clock
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-9-npiggin@gmail.com>
 <87ttl22bvv.fsf@draig.linaro.org>
In-Reply-To: <87ttl22bvv.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed Mar 20, 2024 at 6:40 AM AEST, Alex Benn=C3=A9e wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > Migration reads host clocks when not holding the replay_mutex, which
> > asserts when recording a trace. It seems that these migration times
> > should be host times like other statistics in MigrationState.
>
> s/host/CLOCK_HOST/ and s/host/CLOCK_REALTIME/ but its a confusing
> sentence.

Yes you're right.

> If the MigrationState is guest visible it should be
> QEMU_CLOCK_VIRTUAL surely?

I didn't think it was visible. It was added with ed4fbd10823 and
just exported to QMP.

It was the first and only user of host clock in migration stats,
the rest use rt clock. OTOH it does seem to have deliberately
chosen host... can you see any reason for it?

Thanks,
Nick


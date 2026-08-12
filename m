Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF57AC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBRI-0002O8-EB; Wed, 12 Aug 2026 12:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuBQw-0001eF-3T
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:04:11 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuBQu-0000hb-AJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:04:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495590dde14so14536935e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786550638; x=1787155438; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u6D9UhjDK8cihmktW0F2d0ZO4IEhU767NFw/NHuhS3M=;
 b=tAt5M/QbpleBMoSg8NIBS2lusP61/OYe42Ls7K+ipGO4DRm+ki3MTie8HdygE2q38Q
 S2a6a7wdFw7NMFHTq3R1T3SBiDUbCKUqaOBx1WPDSdsR+GKOtlyFcCFfL2RFgRpUHMlW
 +d1knbINYbBKhwcnHpl9l59ScbwD+zBsqGAqtPOTSnHNIZrLNWG5z0Isqztb27F1oNkb
 UFSMrT/NVbwpoeKUq/P1hGNyuwFxivq1lQ12fAQLsf4PB5wjADVELOICxEGvCswCNFQa
 WPEV/k+f1ZCSrcUSAbXvq2P6mpu9hHNJbUXghGrfjJOlPTl7ULZ4vGYtarYLYW6x7m9t
 S/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550638; x=1787155438;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u6D9UhjDK8cihmktW0F2d0ZO4IEhU767NFw/NHuhS3M=;
 b=MoPBJwexFATDpHDTQ0kSFWXtoyf3E54AkP4zkV5oOH4aspTXqHGGsMujdmIr8p1MFV
 q1SooZayjKfzYwJ8Izzp3D/d1ubjzFHD7QmVzSGL9aEi9aXwFV+fPCDulzqtRz2Ao0FL
 YwIvRYYnqOZwYDcyNs6K0yju4TvlvprEaV5XEK97UKIjU9Yt9UiNwGDl9TKE0NijNFZl
 MAhWkPUDgMWZlJ727/hKeuxYAUFSfAacjraYpUCXaAzqu6XsEfXfQLaPtvAfNTJWwJcF
 paNTptmV/NXU1InreXArwErszoDnQ0N5YNan64YGINzGvIGCFSlzFlW0QHoEorUI2L+z
 xNqg==
X-Gm-Message-State: AOJu0Yz88etY2colcTWLscLdiBde2KCXlX1CAPYRBAniofsF+7UnSPyu
 omEu8iRexua5rzgs/q+Bbb3LV8Ty69WjRIfxsxzfKMauTKxbGB8XqtExm7pgkfukHX4=
X-Gm-Gg: AR+sD128HxLNDhFxXNWqVJ0eym7XjzO5h8AyGSlF6KCO+58x/BWrffNjGNNzYhc+OL5
 BEd749li1edAY/w6fBrwb6aqt5Fq7G++PoweYTnGQ5OnXOBKug5b7j8rij6pt4C8fyFDhcIQd16
 jTURxC6oX0WEuOu5BXcsjKgWCiCeRk6Smy7OJlBfVIYHlVvuruYChJD1f2L396oDSdE1BuIQ1A3
 N62lcqfTfdgum53P3rOJRAgOI/DF5OOP7JHVgQ1Qfyrn8M9eSI7DSCP4xcOHoHkyIsE3p6gSmoN
 R3RMMTxpmWmimQGY8lNefmy9ZQ6IwIbq1vsb89SwPS55+Lx6h7ZAFYE4EeaC/tQjh1iX0vH21L4
 J61zFypq7OLVbjDHSEjC3jQLRXRjRPt8xWHriSIl11Ec5XLTD2fLK67MxS+aPCK/3Z1KFbxE7Xe
 bHggViEi9wXgORku+/YDclBLZuUIGhp38NpUIPaVgNh7b22irtHHuH6v9q8TNp
X-Received: by 2002:a05:6000:982:b0:47e:9f16:c0bf with SMTP id
 ffacd0b85a97d-48152c892c8mr9211078f8f.30.1786550638472; 
 Wed, 12 Aug 2026 09:03:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5cba0sm8437940f8f.25.2026.08.12.09.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 09:03:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 988D15F886;
 Wed, 12 Aug 2026 17:03:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 101/103] configure: remove cross_cc and gdb detection
 logic
In-Reply-To: <20260728044248.137626-102-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:42:45 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-102-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 17:03:56 +0100
Message-ID: <87wltvxr4j.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> We have now implemented the same in meson directly, so no need to keep
> it on configure side. Also, we have no more Makefile consumers, so we
> don't need to export all those variables anymore.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1009DEA812A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppLH-0002jN-7y; Tue, 10 Feb 2026 10:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vppLE-0002j6-QD
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:07:52 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vppLC-0006Jz-PF
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:07:52 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d18d02af68so3954328a34.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 07:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770736068; x=1771340868;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kN61xMbPHcz4sJcGA9j5tiUEkgPkS5ZtoT1G4GzjFl8=;
 b=uhSjhyGlkvY3Bhn+wUCi7+QTBn7hV5hWgUz/OcAOrSVzBdnb+EH7livTsWKi0w57UH
 GS49Phl67inyipn2CvN5CpRxar8fUbLfm8A1Q+X6JTsbuX6rla7FAHbjryzPkc3ve4Xb
 jzfKSP3UocB2y5J9q55ilQaUp0RYAlriyqzCO4jv1KACDFDsEK3vnXumQO+HZahA/vWh
 vJ86RpvbN3iRJxGXwQX6OsvTeIxnk78a8Gyq4o79x5/8U5droviZU5ECxInVbs3e3c99
 IXw9Yjisl642uJOZBsBqIaljHWh/ISS6Ymi+9aqT8k7wcDRaOJ2ohfu4MXopxvN4fua5
 aVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736068; x=1771340868;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kN61xMbPHcz4sJcGA9j5tiUEkgPkS5ZtoT1G4GzjFl8=;
 b=hIgjytErZASR3VqZjPx8BwHEVktNQBpys2jWV7HeCA8lLbv3XxL6ze7Zm4Y+RcE3Wt
 JSfZ6bq6ektAa+E/5oIHs7btvpVNyXdUjvs6GCeekyO8s0oeDao0iG10647Xc6tpHFLJ
 1eI2YvISsDTXV3BV/K72UonoHML99SoWFVYqmPbao9gMfci0Lls2HBwiC+IH9vpu+XAJ
 zxFoiw5GCe/ZE9f6cN+G/geZKeAA5BNBTlN6vWp0cNcyHTMG4E94SPSEEHsWetDcTqm0
 xmrnZsxCbCmSHkbvNIDI75zn9yL2/6elWI4YolAmE5YwaRgmw6rMbnxolzLpx2LZju+E
 tDZQ==
X-Gm-Message-State: AOJu0Yy6HUOZBZuziCVmeTaBEzpdTRNY2qGl5hp4BmqXZC3CTLH8oCgT
 dAn6e4cILvg+mlVVz6+IoNUU1ZD6ZDBMLJhYaQ42YrgOaSNde23CK9r0d0NAEpEeBtE=
X-Gm-Gg: AZuq6aKiFtY8X23l/foH+Z4/HmTMO88zRmlqcCjyZACEOqghYhf6iRIAJWHgeO/II/I
 zrrZFT9LzfUqzwf9UW47QgNaGW6fnUwMZ7Nho0rh9/HVweXQuSlDrqC6CR89XTcZN41ikGGEo0t
 u+T19sQiw45GAxLd0s+sYZdik58O8XmPBJ7GuG/0bHFAqqXbYcA6dMYvE3GJlubOkkRAWFjPCxh
 HBI07iGKar2ZpncyvtDjYtqdeZkeq9jbzKsTSzIS2LZWlbZe+2Gq/eNE69wbpW4SttYI1xfg+2g
 JqKHIVi8OHIoyVZiX91UKwmWqz1OvSbIwZpJQmm8xubZLckTtSYfQztlc1assXBtjxg4Lqi3u+i
 BBXfbQv7zj8Hz0BLP0nhH4t+kAajKlOyyZJgI+klRdtMSZigZY3hsV6wZPHitaWesqSm7I3uFVc
 OFQqIe3zg9Ow==
X-Received: by 2002:a05:6830:6a98:b0:7c6:ca92:3621 with SMTP id
 46e09a7af769-7d4998a3889mr1299550a34.22.1770736068592; 
 Tue, 10 Feb 2026 07:07:48 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4646fb56dsm9986510a34.3.2026.02.10.07.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:07:47 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH 0/3] bsd-user: Remove netbsd and open support
Date: Tue, 10 Feb 2026 08:06:48 -0700
Message-Id: <20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIhJi2kC/x3MQQqAIBCF4avIrBswjaCuEi0sx5pFFloRSHdPW
 z2+xfsTRApMEXqRINDNkXefUVcC5tX4hZBtNiipWqlki1O0eOUThg33g3yxp7OMs42TzmitOoI
 cOAI5fv74ML7vBxLXFnlsAAAA
X-Change-ID: 20260206-bsd-user-rm-openbsd-netbsd-fd4f0fa3329e
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3095; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=WediQ/CHqH4cefApIWfi994FL0Nx3jrvq5iNODT1M10=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpi0m8FfMXmkuU3hGz7iH5ljkmzYo/OmPpAMMm5
 QFUFb/II9KJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYtJvAAKCRBsHNEofbAR
 AB4DEACovRe+eb2bq2q/JQ/Ht+w4PfqHyCOxC/kgVZiMjJDeF2eUMUKFMJs8DAEoP861pxonPG3
 Nb1xJYOeIoupREGhsg00tvS5CWtwVvtAgpq+DJ+KBpVq8RkpDx7oyqlO2dzQPTXpIRWGZZME7Sl
 ahnWMfc1ppIG2VXAeuIaOzTxWFaqUfoQFS81kircZIDGdFwegrgQxpbrOGytPwdV7ZMzP7lGmCa
 q0KXjtMQAFaPZuoPdSpsnBmOWP2lOjGNGjIIW+bbJLAFkPWsJXJ5097kpW0dVHmSHixq1EHfCc3
 rv4oL0CXMh8jtD8pBVjNTNLTII3tp+MOILBx6Q6vc0GMI71rDwLgz0FjblNm7Jj+24YnTZqDNY2
 Un8O3K5Q66oOZD0wAdSmjhBQDCy77mKgctWJ55LrflMqFmgXG/f178/d6ztAVxw768Xu3BPHMjs
 IVDENecnfGOnCXxELD7f8bap4PtcjUKn3xEyenYzzn9eHopvmAEs9Z78MGkKM6JLUKDw9JBKqd6
 IRPTfxMru69L0IX80P6m7xQoALMsiqkrTF3jVNbZF0yWEcfeBVh4m/oXk5+obxjkqOH5E2JXEa2
 OpzWi7fyCZI5kt7FxODCsTNHgh4AxdVs1rvSbm38Ut5739IaRIBfAmoNo14Mzu5GTPoIN7XlV7T
 06KO9pPf5ATXEMA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

bsd-user switched to supporting a single BSD compiled in 2022. We've
only built on FreeBSD since 2021. The NetBSD and OpenBSD support in
bsd-user, even when a hacked meson was used, hasn't compiled in years
due to bitrot (the last time I tried it was early 2023, and it failed
then due to easily correctable reasons).

In 2018 I tried to connect with the NetBSD efforts to get bsd-user
working there, but they didn't get beyond a few emails. I contacated the
OpenBSD people and they said at that time they'd not used user-mode in
years. I'd kept the code in the tree on the off chance it would allow
this work to continue, but there's been nothing contributed to either
bsd-user/netbsd or bsd-user/openbsd since the initial import in 2008,
apart from the work I did with FreeBSD to separate the BSD-specific
requirements out in 2021. What's there now is so badly bitrotted it
would take a very large effort to make it work.

It's time to give up, at least with the current code. This series
deletes the netbsd and openbsd code in bsd-user. I do plan on still
trying to keep the bsd split, with some common code for the 4.4BSD
interfaces that are still around (not many: most system calls have
evolved independently since the late 90s). And I do remain open to
working with people to make netbsd and/or openbsd support in
bsd-user. As it stands now, there's code I'd like to merge from
the qemu-bsd-user fork that this code is in the way of.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Warner Losh (3):
      freebsd: FreeBSD 15 has native inotify
      bsd-user: Remove the openbsd-specific code
      bsd-user: Remove NetBSD supprot

 bsd-user/netbsd/host-os.h            |  25 ---
 bsd-user/netbsd/os-strace.h          |   1 -
 bsd-user/netbsd/strace.list          | 145 --------------
 bsd-user/netbsd/syscall_nr.h         | 373 -----------------------------------
 bsd-user/netbsd/target_os_elf.h      | 148 --------------
 bsd-user/netbsd/target_os_siginfo.h  |  82 --------
 bsd-user/netbsd/target_os_signal.h   |  69 -------
 bsd-user/netbsd/target_os_stack.h    |  56 ------
 bsd-user/netbsd/target_os_thread.h   |  25 ---
 bsd-user/openbsd/host-os.h           |  25 ---
 bsd-user/openbsd/os-strace.h         |   1 -
 bsd-user/openbsd/strace.list         | 187 ------------------
 bsd-user/openbsd/syscall_nr.h        | 225 ---------------------
 bsd-user/openbsd/target_os_elf.h     | 148 --------------
 bsd-user/openbsd/target_os_siginfo.h |  82 --------
 bsd-user/openbsd/target_os_signal.h  |  69 -------
 bsd-user/openbsd/target_os_stack.h   |  56 ------
 bsd-user/openbsd/target_os_thread.h  |  25 ---
 bsd-user/qemu.h                      |  16 --
 bsd-user/strace.c                    |  34 ----
 bsd-user/syscall_defs.h              |  23 ---
 meson.build                          |  16 +-
 22 files changed, 9 insertions(+), 1822 deletions(-)
---
base-commit: 0b91040d23dc8820724a60c811223b777f3bc6b7
change-id: 20260206-bsd-user-rm-openbsd-netbsd-fd4f0fa3329e

Best regards,
-- 
Warner Losh <imp@bsdimp.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF00FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6Bi-0004RD-Hh; Wed, 29 Apr 2026 10:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bg-0004R4-VW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:52 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Be-0004XH-MI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:46:52 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbd23bc684so7103333a34.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474009; x=1778078809;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CC/5fWdBzD5vebSyF1z+Tawq9ewU1BUuAdGgeXpooyw=;
 b=JG04/91SbLtVGSCBImUBP2/vjdzQD3RTKwT/xg5ZaYjadsmKUtaReT2MUdZ/aB70x8
 DfddJ9b71uacqLlgVjyZlTUg6FX5v2GZqtGBG5tXm682qyeMrnVRj4Ix3c1H+zFlhDr4
 7hrc02zZGyFaW5EtBo8Cry22DDSIDWZNQIRwi0DwRX5Aihw96Cu4SsmOa5Fe3htMAtts
 NhokEZ5/BHGMHQL4jKnPn+ZAAvzu0ZYh4kpSTTYdF8rpVeo/IrRL81U5TJ2X0m5IZ9aF
 ePpRJNQBREAX9vcwmC1dBk5heWqx4FPM9eoOp0C5+TFIhmVCnwPFeeviCmrH/2NQTODx
 rcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474009; x=1778078809;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CC/5fWdBzD5vebSyF1z+Tawq9ewU1BUuAdGgeXpooyw=;
 b=bty03EJWEg4r6LwFhn8cyu669NjW+ToHN2oPkYIjvuQQdGnsgz4yDdQPORuFLx+YTz
 dPl3b85SjDmLMTgjkhwL6+1E9NyLVoLlSoKa2jgGjHh48enoXGbJT/l9nu43yeFFW/RA
 26AxUtnjS+Dsqw4Tlgmpy+PS980gE6Z2bsq0cD++2jhiqOblwGZueCWUZVnZqG32LWBi
 oG+TfLfOqX5rJEPXazZQpr2N/J/wHp2xKqfGVO9EC1tH841yURERBzZefnc5kkLDTv1E
 5OjD78+EBf3Nx0iw44nNk0EGB+ehkM96t5t10E3AEjRbW2qT+lKAqKxtHEpEDXgPB4fp
 qdkg==
X-Gm-Message-State: AOJu0YxU65JKVQwWmOQl/ugLOsooC+bxuzTD1M21C1tdRgz8j/6bqkeZ
 73cGFgLjs0SapCKwBm/R13EVjjJiLye3CxTXYmZhzGNMo4ouNsfhS8m7Ds0ulcrKQn0=
X-Gm-Gg: AeBDieua6S9GMq16bSwKeVWWEViNvpfZbcU/wqmSMO3afq67uM2BT/Cb6cZkeyKqYQ2
 tdxTULT8vewiFQNuS0DU6cJZjRtWXana5wTGe4D/9qsE+bShJ4I2Bw2tUbLuh6moPOPdQXiicbB
 Lepjy59HPixWDGqd67TYl1XN+MZnIpQvtk06ycB03cdDxUGzYrvuEZhNu6so5QEpaafm8iREn7K
 rj2PZC8Fw2BYewU2yMWoX87KgrF8G7Ypn5ZK3Hrr/Tocg8FqZLCgzMkFLwL+h+6cvg8CCJiM4g/
 V1nrZctsKO+KB37xAsInLUoCtiRO0nzLx/WkMMTH1bfr55AlSwBSBAlA3eeivHSzqHg7ofN9Gz2
 UofKDCXnZT+nwTDYgDn6C1iArodNUJb+t6DmhvzvLbzOaSED6BT7RMvrDNPkuz79d2UvXsgT8Zq
 sWlz6syVEEqSvDxfevAR/V
X-Received: by 2002:a05:6820:1a81:b0:696:64ab:cd83 with SMTP id
 006d021491bc7-69664abd594mr2408375eaf.55.1777474009062; 
 Wed, 29 Apr 2026 07:46:49 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:48 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 00/17] bsd-user: upstream ioctl
Date: Wed, 29 Apr 2026 08:45:06 -0600
Message-Id: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHMZ8mkC/0WPy27DIBBFf8ViXSIYMA+v+h9VFjwmMUptp0CsV
 pH/vcSJlOUZjc7VuZOCOWEhQ3cnGddU0jI3gI+OhNHNZ6QpNibAQDHJOU1LqN9UmWCY09pFAaT
 9XjOe0u/u+To+OePPrenq8/i2NfnDJTjQMrqMtI63+UKd573ppdbW2mHdpd4VpGGZplSHzmOIA
 KcYwDHNtRHRIpMSeA9KCaE1eOGtCeQxP6ZSl/y3V618338FwCtg5ZRRHq01TirWK/bpS0zT9dD
 2yHHbtn/7xgd2GgEAAA==
X-Change-ID: 20260411-ioctl-68c80a77ad32
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>, 
 Alexander Kabaev <kan@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=h7lWbo76mSsNTVc+7DDA11jabhBzVz44+sh22FNm/Mg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl8BaqQj5Qy/lYh6N2JYr0rWwZP248+WGs6L
 zAVfYaZOtyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfAAKCRBsHNEofbAR
 APJJD/98hsWOEd5fjJE5+Ir6a94VaqIOrcSRp1mA9ZP8qi3GlBZPx+/FHoNMmvIZXcZLOorLzKG
 w9G+2EDcy8i07STKNGMQNa0nX1LTSWvi1lmFcMzuUKgmTT3hoZWb6Yjj1QmolcOImOqj8PwjnLA
 U1brmH4H47uNNL72hgIx9damhJ9wfh7jJJvl3Pu0+fh5ZTtlcQ3NnJsADebf/n1whhCnfGzINDG
 MztGgnyZ6U464AviiLyi7w67HEaFITODXbG3D7ev0aPBCSdsfh9b1db1ht+MWwiKMCCkac+t1Z0
 70taVAhSGkYP0qnzvNpMbx0S5VI2b7k+vTjqqEVtNVDLCzIuYsrmZA63Cwawq09DEkijiOhsS4Q
 Hj97ao49V8WOYPghlTqKU4RD+Spm0KQA25izRUW1w+MON/ypEyPKHnRGEZGP2xbyQiQyR3UO1EW
 EHq1Erqtz1UY3dkG4siPJnwMOgg51G/FjYx8bvRp0uJ7HBTyM3mfvHqmf/6sdlCMpYu+VApLXSF
 KFDf8v8y8tgJVRuynBnw44+FfJWZCJ+ernwyNhAGeOlZYBbpENkFZzctj1FnJNl5QmEcTVZW3Ml
 DOb9bQTyJjmOoCOfhmIywc0ljExGr6THCSc6OPKsrGD6JQHNEXR9lfMMdqjnf7RI6TP5gUVM0C3
 I3nyHfr+UlpwvNA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
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

Again with the help of claude, harvest the ioctl changes from
bsd-user blitz branch. These are a bit messy, since ioctls tend
to be a bit messy. Ideally, all this would be generated, but
that code isn't ready yet, so we go with what we have.

Please note: All style complaints are false positives. The > 80
character ones are fine: these files are semi-generated from upstream
and fixing them makes syncing harder. Harder syncing in code that's
basically boilerplate is worse than lines that are too long for
definitions people are never going to read.

The two errors:
● b64902a56387: bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
  ● checkpatch.pl: 197: ERROR: Macros with complex values should be enclosed in parenthesis
  ● checkpatch.pl: 198: ERROR: Macros with complex values should be enclosed in parenthesis
are impossible to fix: they are what they need to be for the macro
tricks that are being used. One cannot add parenthesis and have correct
code.

This is largerly unchanged from v1, which didn't get any reviews.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Changes in v2:
- rebase forward, minor tweaks for blitz branch evolution
- Link to v1: https://lore.kernel.org/qemu-devel/20260412-ioctl-v1-0-1d998a460560@bsdimp.com

---
Stacey D. Son (10):
      bsd-user: Add FreeBSD tty ioctl definitions
      bsd-user: Add FreeBSD file I/O ioctl definitions
      bsd-user: Add FreeBSD socket ioctl definitions
      bsd-user: Add FreeBSD cryptodev ioctl definitions
      bsd-user: Add FreeBSD disk ioctl definitions
      bsd-user: Add FreeBSD IPv6 ioctl definitions
      bsd-user: Add FreeBSD ioctl type definitions
      bsd-user: Add FreeBSD ioctl command table
      bsd-user: Add bsd-ioctl.h header
      bsd-user: Add target_sockaddr and safe_ioctl to syscall_defs.h

Warner Losh (7):
      bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
      bsd-user: Add log_unsupported_ioctl function
      bsd-user: Add do_ioctl_unsupported function
      bsd-user: Add target_to_host_sockaddr_in6 function
      bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
      bsd-user: Add do_bsd_ioctl main function
      bsd-user: Add init_bsd_ioctl function

 bsd-user/bsd-ioctl.c                  | 438 ++++++++++++++++++++++++++++++++++
 bsd-user/bsd-ioctl.h                  |  14 ++
 bsd-user/freebsd/os-ioctl-cmds.h      | 151 ++++++++++++
 bsd-user/freebsd/os-ioctl-cryptodev.h |  74 ++++++
 bsd-user/freebsd/os-ioctl-disk.h      |  41 ++++
 bsd-user/freebsd/os-ioctl-filio.h     |  34 +++
 bsd-user/freebsd/os-ioctl-in6_var.h   | 217 +++++++++++++++++
 bsd-user/freebsd/os-ioctl-sockio.h    | 240 +++++++++++++++++++
 bsd-user/freebsd/os-ioctl-ttycom.h    | 237 ++++++++++++++++++
 bsd-user/freebsd/os-ioctl-types.h     | 104 ++++++++
 bsd-user/syscall_defs.h               |  10 +
 11 files changed, 1560 insertions(+)
---
base-commit: becd22fdc2a071783d9e04421526633772b3b98c
change-id: 20260411-ioctl-68c80a77ad32
prerequisite-change-id: 20260312-share-thunk-ab1585477999:v2
prerequisite-patch-id: a048e442d9dda7ee4ed1070ef5eb524e078b9a3b

Best regards,
-- 
Warner Losh <imp@bsdimp.com>



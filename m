Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF82CCD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 17:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJDsB-0007nj-UT; Sat, 02 May 2026 13:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDs9-0007mx-Hr
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:21 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wJDs6-0006zr-62
 for qemu-devel@nongnu.org; Sat, 02 May 2026 13:11:20 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4be94eeacso3210156a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777741876; x=1778346676;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BHEeUiuTS20hAbJtrDrc8enylxgJOyJ6P4KcTKr5Suo=;
 b=0IrgJyPNFMbgr0IrVDLEO3sP5EB17jsX420jRo65Pr1PofG3sS1SIv4D7jDBXDuMAe
 TxQ0+uzF7Mqbbz4pwz6WBmnU2l4fcUIKhT7lSzZrqB7JNSHOTVOOnu2E6H+SOXE2MmJr
 LZl1qkSBhkesPRyGDg5m/Jj5JpNx4L1royyQSrvJngajieYPX/PRop94ROCaiUI8RcFP
 KOp/yOBlDb7YeHUjbum7fC/pHDaymObZKYDCUSmC4mTvNZMKmUJaTOFrVAuuQXztzk4n
 6wSa1YatfQjqHrjz/FU7crpGZLwKjlpODNNRTuDyx8135nyg2TFl0WLaOydLwkv12Djd
 yBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777741876; x=1778346676;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHEeUiuTS20hAbJtrDrc8enylxgJOyJ6P4KcTKr5Suo=;
 b=kN50WHDbktGjjPCekrmkOJJu0NqMArPqTwhiPWiAv8Qqm9gW2wOKOgfg5cjq7nKOeC
 iqZyfhRB84sLUezrvnOrEc5yC3Apo7TPKaZcu0w2bZ/dUHJbl1C5/NryQ03b3oKfsr/t
 reIjli3Rd3LwVgwsoCw9K2y3z49B/+zkiDHNMUgERs3tJzCO5U8nj9HLLmuAoa9L4Igo
 I2Ggu0FYjPo544oiPVeunR9JatPYSrB8GesG1exR93ihBF3JVfZ935f+FxlxEgTqCEAj
 zfgHpfGyVnRTO0/kgcenQO8TjEVDJpwszWpjS5y/6lZ1qKCkFV8ZTX8ZmnJnn+sevNpT
 wprA==
X-Gm-Message-State: AOJu0YxdviEPEsyESY7HQPtpnjAycVYrZxENBZlaCBfLrknhSBFBT2I9
 1PyYpuMwOvsrAJj9YePmPXXm89IaiNHZa2O+Al0G+oN8itwnh3tpdu2RTar2LdK3d2BsAUhpH/E
 5e6ftxHY=
X-Gm-Gg: AeBDieuu1nkofNgTJaBfGRi6ntbUBTv8YJmdRcRuyCqOwW9BXb7yxAr7RfQYLrST7+f
 HreaWXzXLXizOu8nigVuSmhTbxXClGtsf2Zlj9wokF6UkItIFpdBCsmIX1tfmFi2ZJjlCLsYJCy
 vT123TBQ1m6qQN5tpw7egzfJbVmENZI0HUEwI/G/1QfcB1irZF9bGrf5uW1Z/Uji/CPASkJ0Jhx
 PCzLYUQMf+uDnh9wveOgVBUq1mHt10Wa5wh/PpttINwAeWb+5b2+E3Ng6YjToC+xTTajWVfIgoI
 nCFp8+bomasxdpOOhOxsjdtvlVJBZXp5XHV698NwwLCgAQ/V+nymLUBu0pJhkYZ+iGokianNaFP
 8TWVdlxvu8QmAkw3nhuvlquGNDNV1a+WtuRdQlOH4nwCmmmwTC5P/dSnjBY8BW6028bZk3Ns/l0
 q9XW33gOwTBKJnF1ToDXO2
X-Received: by 2002:a05:6830:6d27:b0:7d9:7ea8:7a4f with SMTP id
 46e09a7af769-7dee13c171emr2193897a34.16.1777741875924; 
 Sat, 02 May 2026 10:11:15 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca824746sm4334355a34.11.2026.05.02.10.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 10:11:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 00/19] bsd-user: upstream ioctl
Date: Sat, 02 May 2026 11:09:21 -0600
Message-Id: <20260502-ioctl-v3-0-a05d4cb1bdff@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMIv9mkC/1WPy27DIBBFf8ViXSoYMA+v+h9VFjwmNWptJ+BYq
 SL/eylJFXV5R5xzuTdSMCcsZOhuJOOWSlrmGsRLR8Lo5g+kKdZMgIFiknOalrB+UWWCYU5rFwW
 Q+vaU8ZiuzfN+uOeM50vVrffj0zZ0zSU40DK6jHQdL/MndZ73ppdaW2uHrUm9K0jDMk1pHTqPI
 QIcYwDHNNdGRItMSuA9KCWE1uCFtyaQ3/oxlXXJ323Vxlv/YwA8BmycMsqjtcZJxXrF3nyJaTq
 91r6mqF94YmD/MKgYGKOE9QEk6H/Yvu8/S79LZVEBAAA=
X-Change-ID: 20260411-ioctl-68c80a77ad32
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 "Stacey D. Son" <sson@freebsd.org>, Alexander Kabaev <kan@FreeBSD.org>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4600; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=BihK/iYJ3f8DVUsc8c6CuVTli0R2ZFo/+UfIoYndxN4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9i/Iv05dpjFwyVsCjLGEo+K/w74NuODSfX6zp
 XljS0p2K9SJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafYvyAAKCRBsHNEofbAR
 AOIOEACZ62nO/ItiQ6aKVof48P63NHEvbLdK6G89uKSpFYYhXHO8tkTy1MWZq4FPTWBHsJDP1D0
 4WkfUbMpUCGoNUc+BtRH80BVNZtBvDdmBQuSNjlHj/pvYdLgCCFZEZQaX04+yENr8VxL5gKsMmB
 pjeDRv4Z84BogAGea+iGrb6N6doYndPsU47bm5tz05dtBG94XhNBNnivwrBl8zKR5tOFiGqdF/V
 IajLK+2qFYqACxc5Q5Tto4HLVfxWIm6QO5QFGexgjx6Ox0TWD9yM2rkOY7Q2BemSbgtRVNtur5/
 mQ20kNc5nRJVlmg3rEaguuwFew0z2Uv+eyRa5uipW+Aw0Xq6SkPblVk7oxXwvttrfS/VTD1mhkU
 2uh5BolWilKp5N0G99cCpuwdYHG9b9+d47Ikahp3SlKFQPXtEyhGljHcU5UtMIepc+k+c/7NXhV
 IuWoIxSxqldqCgxc7i/j+0WE7x7gfSOXydHK6kjNXf1o4Nohg+Ctk7+dpaNDoh9+ZTbYHR0DbSO
 +s/f2c+w1xTdETuaNGsM227SdrZ7j3+WnuvKpjFh0dLq2lylPVfvnq8hoqPhhzm4/RnAapsDIB+
 2POPhu8evGALjH0kgjoNMTM7P1ETFxga/GCh8fjWbMjzE3ZOon0DPG/wzU0tZ1kzVi4N+gvPfwb
 E744eMRd7qv1Xsw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32c.google.com
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
Changes in v3:
- Fix numerous small errors in types found by claude code review:
- remove duplicate net/ethernet.h include
- remove duplicate TARGET_SIOCGVH definition
- fix lock_user issue in do_ioctl_in6_ifreq_sockaddr_int to copy it
- fix unlock_user issue in do_ioctl_in6_ifreq_sockaddr_int to use correct size
- remove duplicate TARGET_IFNAMSIZ definition
- Provide struct target_crypto_op
- Use abi types not native in several places (same size though)
- Fix logical error in ioctl encoding using TARGET_ forms if IF* constants
- Fix ieee80211req definition for ioctls to use SHROT instead of INT for int16 types
- fix lagg_reqport_lacp_opreq and lagg_reqall_lacp_opreq thunks to match structure def
- sync to latest freebsd and delete obsolete crypto
- Use abi_ types more consistently
- sync to latest disk ioctls
- Somehow foled all that into the same number of patches (since it just reflect
  blitz fixes and we don't need that history in qemu-project master).
- Link to v2: https://lore.kernel.org/qemu-devel/20260429-ioctl-v2-0-288639bc2427@bsdimp.com

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

Stacey Son (1):
      bsd-user: ioctl: add common definitions

Warner Losh (8):
      bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
      bsd-user: Add log_unsupported_ioctl function
      bsd-user: Add do_ioctl_unsupported function
      bsd-user: Add target_to_host_sockaddr_in6 function
      bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
      bsd-user: Add do_bsd_ioctl main function
      bsd-user: Add init_bsd_ioctl function
      bsd-user: Add call to do_bsd_ioctl and add bsd-ioctl.c to the build

 bsd-user/bsd-ioctl.c                  | 436 ++++++++++++++++++++++++++++++++++
 bsd-user/bsd-ioctl.h                  |  14 ++
 bsd-user/freebsd/os-ioctl-cmds.h      | 149 ++++++++++++
 bsd-user/freebsd/os-ioctl-cryptodev.h |  84 +++++++
 bsd-user/freebsd/os-ioctl-disk.h      |  52 ++++
 bsd-user/freebsd/os-ioctl-filio.h     |  34 +++
 bsd-user/freebsd/os-ioctl-in6_var.h   | 226 ++++++++++++++++++
 bsd-user/freebsd/os-ioctl-ioccom.h    |  43 ++++
 bsd-user/freebsd/os-ioctl-sockio.h    | 246 +++++++++++++++++++
 bsd-user/freebsd/os-ioctl-ttycom.h    | 239 +++++++++++++++++++
 bsd-user/freebsd/os-ioctl-types.h     | 109 +++++++++
 bsd-user/freebsd/os-syscall.c         |   9 +
 bsd-user/meson.build                  |   1 +
 bsd-user/syscall_defs.h               |  14 ++
 14 files changed, 1656 insertions(+)
---
base-commit: becd22fdc2a071783d9e04421526633772b3b98c
change-id: 20260411-ioctl-68c80a77ad32
prerequisite-change-id: 20260312-share-thunk-ab1585477999:v2
prerequisite-patch-id: a048e442d9dda7ee4ed1070ef5eb524e078b9a3b

Best regards,
-- 
Warner Losh <imp@bsdimp.com>



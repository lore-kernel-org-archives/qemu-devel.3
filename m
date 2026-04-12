Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857BAE937EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxHv-0006Pv-7n; Sun, 12 Apr 2026 12:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHh-0006P7-SE
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:43 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wBxHZ-0004T8-VZ
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:03:35 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40efc77933fso2350595fac.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776009811; x=1776614611;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sDPHxCUUZMuudC3r/Is5VFOWdpeuXtwqE61HpPsUYjI=;
 b=AMzTCNY7QwWWsEWBtcI/UckAa/f13leDcbsr2s7p2aghDbxgDEx/9L6V4F2n24qJi7
 va8WqQua6nOgALikG/0cBiPsdRSRpCg+NuhxGk1jjWJs15A3MJ+R4KiqX/bAWgY+5aRj
 vewAYSjJANAUv9FYIwckJXMtgcelJ1177CmtgEc5gVc/6rFcihMoroZPWfP6cqOcBluo
 gat4mPAKXfLKpP3MdKTFZMEu4Pg+UsgzaytfbE4p+F+G/8L1G/6Q2K0TPelEdYoUVq4m
 YomFKVCrejWif/yq+Nj/8aLyqfJ41gyz4lUStdDghRXwi/wXDzXu74Uho7JL7kMOK60D
 wrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776009811; x=1776614611;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDPHxCUUZMuudC3r/Is5VFOWdpeuXtwqE61HpPsUYjI=;
 b=i700WlNEEkQOD202sPBrFVDZIExySFyqD6Mu5npwBF5qxMNJ8L5+r0CSok8EfIIUbX
 xTHF19O+TqSm9BiaYDsGcXv2SLwRTofRsrbuNwEC3U28MixroAYMk1eVnxrhgMgCDjas
 MxOJKUF4izGtAyiJumgCbr2fLQac12HW/FfITi/8wO603gAj1D2j/jd3PzF/h8Hm86MB
 dJsSyKZv0M+gTjxU7yWIBl0jbVRWb77OYyNwht8++BaVNn4M4MD9bLYB1F6WsZGuZwlK
 uDIRkjd1rcv8Z5bFvsOwyAaMciMMi1QYKxCxdQp1aaLXQxIUnRw0xhyZC5rMOeFuyJNc
 D0Cw==
X-Gm-Message-State: AOJu0Ywo+EVwPXDKL/qFq/Kxe5uUhNYaaiRGbebyOj5ds9MnoZCv+ttZ
 RxoaXXYQYDA6X6YohTvjc9u3S07qCDmD2lui8c1Tl3T7jLAmdtrtireUQIxRMHdvOUugn1NSvr0
 2c0bqkyQ=
X-Gm-Gg: AeBDiesU6x4Uep/zNWCYaAISpg23bHQ7VR+l0T+Pl3Qyb3A67IQ15e7Cn9Cx+x5qOyZ
 gPu7VB957gKdO3liP+8ivsj3gxgQ2Q173hOar2x6vdE6ardoizoVlkp8/flL3XUfyiz1R3D6OBB
 X5554b9UEgSrTpqn+hzkKaVpDolEU6Kgit9Y4GZWJJF8djAMqljGcgwrjUeknjOY+YX+qMqPKaw
 L3G/rqjNsLp07jtD03N6AFwb1JyqACN9uZV9gnqjmCaAaSs8LWZPxeV8T+pISIGsKBkPK6OYg3f
 pedq0TruqWu+lPz0jQoB1yndv8x1+glgL4OVyAkzKOsr5shUQkaxSpXPYr+pLEwoa+ajaEDszH8
 iKEHzF7C2FnRAomApgZp5+TVpcBLydgavHQe9jSUN0Jl2tlFDz86C4q7YPLKyjd0GQKStr9SUBv
 42PX1fWw59yg==
X-Received: by 2002:a05:6870:b28b:b0:417:2156:ffea with SMTP id
 586e51a60fabf-423e0eb1375mr5781463fac.13.1776009810892; 
 Sun, 12 Apr 2026 09:03:30 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423ddbee0fesm6457006fac.17.2026.04.12.09.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:03:30 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH 00/17] bsd-user: upstream ioctl
Date: Sun, 12 Apr 2026 10:02:23 -0600
Message-Id: <20260412-ioctl-v1-0-1d998a460560@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABDC22kC/0XMSwqDMBSF4a1Ixg0kNzEPt1Ic5HGtoVXbRKUg7
 r2igw7/w+HbSMGcsJCm2kjGNZU0jUfwW0VC78YH0hSPJsBAMck5TVOYX1SZYJjT2kUB5Pi+M3b
 pezr39uqMn+Xg5mv8a011WoIDLb3LSOd+GZ/UeV6bWmptrW3WE/WuIA3TMKS5qTyGCNDFAI5pr
 o2IFpmUwGtQSgitwQtvTSDtvv8AFzJPwNYAAAA=
X-Change-ID: 20260411-ioctl-68c80a77ad32
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 "Stacey D. Son" <sson@freebsd.org>, Alexander Kabaev <kan@FreeBSD.org>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2977; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=dqWlpRoLXMYeX6+AokJWrSRtLXbR4AbGf+9KfgwWhAg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp28IYD5eJ5lN4IfRC9plhM5Z1CUog/EfTLdMOl
 RPhLlyB0FyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCadvCGAAKCRBsHNEofbAR
 AG9BEACE6ShC/ZOyyCmXw3Py7ZvvTRU07GnhyWPSs9EoHX0FydqkLZf00KNYhavmO/8wsncEaxv
 jqgnYld7ZEWKGMd07ZGqX0cyFiw6RkUpmpigjTWzkyT0N7kvhDMSdNz74IzOFqy5J4zmdLu3H7/
 mt0zwK1Q2a36iZt0OGWIXFzUJMqkV8a67YOAMFHFZU2SQWoMk7bYcZpRNWDraNbsaVhvGtnbzDu
 7JD4xa2h/sULNFeqDRPjNjsW7vsywSFWQP1MKREvyZ00EftkYfgQKTUTpmN4KZ66YulNNIhV0yF
 9cig00zVaIi5hmC/sC9IXWC2dUzNT/6/JxkG9BLWSauyb1xI/jbCA6Wbwure4cGOHSGz33nuCp+
 0O+Ll3igM2vpsp/Ug38zWa0lXqkRspkhpxCtBFBSEVhXMUnADXjqJGGDYSzXW0qKYA1MJQm5dPm
 BMdmA64Un6HxjIzlf0AsYIP2tmBW11JwM+OTxved5mk6k+h0lcDaeL07QxwOIrA3A+V44OBx4qQ
 fvF22stps5wHlnST1EetHOvxH3hw16BaFJzIClAK3m8Mrr2ZYd5OcZVvbphbQGoz5N+79kmVd2k
 gJAnAUJQgFuGJ+VTz3agZWtcarxaVU1TARE1RKrJp3YSnYbe/IeGdYtMrUrQVQBgi4QKo21xV67
 oSe+RSOTVM5hqxA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::32;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x32.google.com
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
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



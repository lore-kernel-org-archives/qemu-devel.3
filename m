Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D33610AB824
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 20:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5rPr-0004sg-Es; Thu, 26 Mar 2026 16:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <landonclipp@gmail.com>)
 id 1w5rPl-0004rr-UR
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 16:34:52 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <landonclipp@gmail.com>)
 id 1w5rPj-0005eX-VD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 16:34:49 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso1637388eec.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774557286; x=1775162086; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGl/teyNC0SWm2wgC2pX8w4WxS1cFKv/cl5QxBs/xWI=;
 b=rHyW5j0bNs7aqZ/AyNYqH2gM/ht+95lRRpTSxxsAf7mX+NnJmDTSB0zd5Xk/sqyLKz
 JVqRCC0rXYAbkcSRbAVfjWGT0u/c/Tl8Jj/k2D23Chmk8egGJuZRBlPH8vZfEdtZta1l
 ANTIVSwHan24JLStX1rRkOXuYVOrio3Cjx/SKm+35bidj2rDVfON/35blGfo2z3uWT1Q
 WAHAAPTI3oIaCTRLOHekie/BSOLIEfoZgppkpSUO2yT9uKRmQwBg0xMbQZCq7IxXI2q9
 ouflBJACgv2qR5nklLpYt4jMtVWuutOevngZ/56Rv4xvgE0V8+J9jqupqStvllL2K6jH
 eW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774557286; x=1775162086;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dGl/teyNC0SWm2wgC2pX8w4WxS1cFKv/cl5QxBs/xWI=;
 b=kIV00qYtu/kEsYSxorzgK31N0WJ9uWuL65vANP6+HXCvRpJqtBgr7Q+wra9tPOeRQF
 uvJ4OiQLLvCBr2u1NT0VGYJMTyH+xJhnvEEJEyumKFMDTl6XrVTbpWrb8l2yysggiCnk
 S0oUW7QGaNAmFVLpBpXRol7gwm7MZ4LdonrCH3BY4LmD7YL+CzT98CMCextsCUbZhniP
 oC+VLFORUHmKrDatp3OgM6/cZks/pTVw2K791v8A0SQAhf5cUREKNQ7uEH5UJovUxhKs
 tM/uJwwEh/96Sm+BqcehZmPS3+B2wF7ccYffnz20vX2FAd150AryU5SI4wW8fJn3zLxQ
 oESQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRRKNXtHaYCYCM+z97nq1ITdpnIhtmGFsSwEAYqA06zGU86EzeREaOt4uRkLXL9LLNGJ5Ab2iLg4h3@nongnu.org
X-Gm-Message-State: AOJu0YzHa8BtRLQcP3coz6u/v5orsxFnwbkRNdRft1Pn9imjSUjs0pJA
 yencnJa5z1E0SDoXS4fSdh7/PbtCw2y0GneQXAQY//ZaP06x61XMgidO
X-Gm-Gg: ATEYQzyyFcUfUv8w+/+j1MNnz5nvjqY7go1F9A/0y9bq9clJQrPX7t7bwCmj0BppgDL
 WWj0LZEjsuOUIS2cJQ0hNpxfC9YKzmrCOLx9CnQHQKhQuhnqw14YPb6X7GScuuWlpFiHYr8fezP
 sesrp1i6jGcqnTprQeCD6p1MP0bUpwAkpYtAowZ/nmE/UiSOLBHk4CyiBpMiDc9ivvSWBVKCTj5
 LORcDyJrD8ipv5j0vQDIOeHJ3s73tiSQFHhPtTIqAFGcsb4x6B0fJnGULXxiCpT+oKew/7g7Jw0
 rk1WYcsCKt//QgaSAnNWydfeWoEt+2qriHxfUMg6vAxOdgD1krlCOCdP2E4zJKfuVPkvEAEZBMV
 jLA0a6ExOzngFaekDpCJLTxIaSS77mhhwX1eGTIQaAbITNLRM351yR5GKFC1TwcgrTEX5sq/I1R
 Ewt599OqPhGFipM1a9Q36GyGOP4zsUPXD7Sg0nU+1s/wtU0w==
X-Received: by 2002:a05:7300:e683:b0:2be:22b0:8bf3 with SMTP id
 5a478bee46e88-2c15d450548mr4976524eec.30.1774557285574; 
 Thu, 26 Mar 2026 13:34:45 -0700 (PDT)
Received: from localhost ([2600:1010:a022:bf:450d:95db:3067:ea7a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ed9f739sm3420120eec.16.2026.03.26.13.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 13:34:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 13:34:42 -0700
Message-Id: <DHD021CSIBZK.3PZ1A7CQUUBQU@gmail.com>
Cc: "Alex Williamson" <alex.williamson@redhat.com>, "Cedric Le Goater"
 <clg@redhat.com>, "Yi Liu" <yi.l.liu@intel.com>, "Eric Auger"
 <eric.auger@redhat.com>, "Zhenzhong Duan" <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, "Peter Xu" <peterx@redhat.com>, "Fabiano
 Rosas" <farosas@suse.de>,
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH V6 06/21] backends/iommufd: change process ioctl
From: "Landon Clipp" <landonclipp@gmail.com>
To: "Steve Sistare" <steven.sistare@oracle.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-7-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1751493538-202042-7-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=landonclipp@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello,

I'm running Linux 6.8.12 and when running QEMU 10.1 or above, it segfaults =
when
submitting the IOMMU_IOAS_CHANGE_PROCESS ioctl which is not supported on my
kernel. Here is an example strace:

3388260 22:48:30.540879 openat(AT_FDCWD, "/dev/iommu", O_RDWR|O_CLOEXEC) =
=3D 25=20
3388260 22:48:30.540942 ioctl(25, IOMMU_IOAS_CHANGE_PROCESS, 0x7ffe91d96490=
) =3D -1 ENOTTY (Inappropriate ioctl for device)
3388260 22:48:30.541003 close(25)       =3D 0
3388260 22:48:30.541059 close(26)       =3D 0
3388260 22:48:30.541120 --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSEGV_MAP=
ERR, si_addr=3DNULL} ---

I heard through the grapevine that this is a known issue and was fixed. My
question is what QEMU version should I expect this fix to land and roughly =
what
the timeframe for it is (assuming it hasn't been landed already)?

Landon Clipp


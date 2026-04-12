Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5617F3ED67
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 01:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBjes-0006Te-PQ; Sat, 11 Apr 2026 21:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBjeq-0006TW-MJ
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 21:30:40 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBjep-00086S-5H
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 21:30:40 -0400
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8d560ede296so382323285a.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775957438; x=1776562238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=706mik4a5EaJRznrXjUeSZaB/OA8609WSGWhVzBGMGc=;
 b=OBprmUpjHcIcaNl94r9xr2krs1p2Y6QVpo8u+Kd7rL5obVnCzXS4Tof/8cgVdsUy4T
 fzodPK19Xr7a1MY0AHoLWy+IWglW74V05p7NYUcjT2nJIwj9wunFz5mqOHf2ThRpWqxi
 0Ij8tD3dyoZCOA5pFRHNh6PTRZKl5apWvUZa/2R6tigDT+p/lvuJbBlB3tvDFBvxxeJ+
 MpGTo4Th5K0Gl+ALbuioZOJ6409OkS3ioGaA+oEN31uesG6PRmbys/e+gZSShh5nsCbV
 0BKdSrOHFNAVR80IiXR9gCghxVVwa5ndwTZ30M7adRIggjV3X1IqCYmOqz+wRFVl0wMH
 oHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957438; x=1776562238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=706mik4a5EaJRznrXjUeSZaB/OA8609WSGWhVzBGMGc=;
 b=m9+X7fEq9iXEVvCJLFz9rxE00qq7Oo/+FKWsHfSzZTkfNG2PJWGG0cBot/LpKCOuYo
 Nz2NWdAviq4Pl1zUdkZAY9yYM18jOcQYLX02OXAdBhSz5jtFU9SGqwllECq/pIz+g8/h
 nMNuMVshdgr/5eqz4aPgDIzTnqw5mGThUBZGpZYHfGuPjMyGLYjRcgEOCJQI2F0Dpmuu
 RXWkv+O9yVAr+A+FueysQpBIMGVbRXTW4Khz190FoKsep1/Ysyl+hwaRUmY3yCTCjO7y
 R7NZ/RFhyPojbzvMwN+1hIvbGxyfOKPpMK8T/lzqzgaldDRmKHZB4IGD4+qlh+5k01my
 JooQ==
X-Gm-Message-State: AOJu0YzrbgrVk39Q98I9y8lc7B5MPaxbQvwuuN/dTqaU0OovlGqmyD/a
 PARnNAqXXFRwWCNNCsCjmLmHufVzwd9PirlkH96Wl2UEf7iQycFmCdWX
X-Gm-Gg: AeBDietW0hxH+PyPM00ZkK9R/tmoI30FGcZTcT8o+TL1ADP8W78x6lp9RSofyIx2aN5
 5XpSOkiv5bXmz3bHCBiA1zBtAIBNi+3ECliJBZZey2dLuw1YcBK5YiFGhPJlFF9V2dbYywjlIHb
 /3Z8OOOFWpKnEN7GzZq7YwKvSZLEzILJOawC67/ytE0ehJmFW01FM+mkjpF1E/PskVYTFzrkkiE
 HjSFJ0O73Jk2B2z5nj2qbRgPHaHLbWOdwMp2ht4FuqXJYU+VYQRTNvwRMdYb6Srs1zOnqnfQ5Ao
 OzDye6nxOjf1LN1sNY45XG32uYeN/T4Z3aAiE+NOEPJK7HsmmOoQ8KFfhHDN9mW2xXZuhHqsCg9
 YGs344D60F9t2CsIrSeJssPQnAtZiaDoh/ztesAVYEkEe1eEVMEOwGddX11L8q6y04BbX0V99MZ
 W3HaCSJ3xNFGfPEy8DI4gRNP7KpcMrYnbiYtzON8Y6RL1ViDUFGiFVI8RGCJrwe1tiDxkS
X-Received: by 2002:a05:622a:1c1a:b0:50b:49c0:b6f0 with SMTP id
 d75a77b69052e-50dd5c4d3e1mr129144861cf.61.1775957438093; 
 Sat, 11 Apr 2026 18:30:38 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd541a559sm55119351cf.13.2026.04.11.18.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 18:30:36 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org,
	tangtao1634@phytium.com.cn
Subject: [PATCH v1] tests/data/acpi: Update SPCR golden reference for
 LoongArch virt
Date: Sun, 12 Apr 2026 09:29:55 +0800
Message-ID: <20260412012955.1810499-1-chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x741.google.com
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

From: Tao Tang <tangtao1634@phytium.com.cn>

Update the expected SPCR binary to match the corrected field
sequence after the Terminal Type and Language fields were swapped
back to their proper order.

This fixes the qtest-loongarch64/bios-tables-test CI failure in:
 https://gitlab.com/TaoTang/qemu/-/jobs/13879552224

Fixes: 977c6fefcd04 ("hw/acpi: correct field sequence in SPCR table")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a738709a45260cbb2 100644
GIT binary patch
delta 23
VcmWFtm|!Qw%<%vJ|Njg~003Gc1%Lnm

delta 23
VcmWFtm|!Qw!2JLJ|Njg~003GZ1%Lnm

-- 
2.53.0



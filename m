Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E2FC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf0cd-0000XK-EI; Tue, 27 Feb 2024 11:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rf0cY-0000WE-Ed; Tue, 27 Feb 2024 11:47:59 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rf0cW-00034c-Ko; Tue, 27 Feb 2024 11:47:58 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BB1004E6013;
 Tue, 27 Feb 2024 17:47:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4aFTFiWexcFc; Tue, 27 Feb 2024 17:47:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 746824E6005; Tue, 27 Feb 2024 17:47:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 70D007456FE;
 Tue, 27 Feb 2024 17:47:49 +0100 (CET)
Date: Tue, 27 Feb 2024 17:47:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: TCG change broke MorphOS boot on sam460ex
Message-ID: <fe59ceb1-e8cd-f488-d6f0-6372923a8a33@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

Commit 18a536f1f8 (accel/tcg: Always require can_do_io) broke booting 
MorphOS on sam460ex (this was before 8.2.0 and I thought I've verified it 
before that release but apparently missed it back then). It can be 
reproduced with https://www.morphos-team.net/morphos-3.18.iso and 
following command:

qemu-system-ppc -M sam460ex -serial stdio -d unimp,guest_errors \
   -drive if=none,id=cd,format=raw,file=morphos-3.18.iso \
   -device ide-cd,drive=cd,bus=ide.1

before:
Invalid read at addr 0xC08001216, size 1, region '(null)', reason: rejected
Invalid read at addr 0x216, size 1, region '(null)', reason: rejected
Invalid read at addr 0x4FDF6BFB0, size 4, region '(null)', reason: rejected
Invalid write at addr 0xE10000014, size 4, region '(null)', reason: rejected
Invalid write at addr 0xE10000214, size 4, region '(null)', reason: rejected
Invalid write at addr 0xE30000014, size 4, region '(null)', reason: rejected
Invalid write at addr 0xE30000214, size 4, region '(null)', reason: rejected
8.440| sam460_i2c_write: Error while writing, sts 34
8.463|
8.463|
8.463| ABox 1.30 (2.7.2018)...

after:
Invalid read at addr 0xC08001216, size 1, region '(null)', reason: rejected
Invalid read at addr 0x216, size 1, region '(null)', reason: rejected
Invalid read at addr 0x4F0C01374, size 4, region '(null)', reason: rejected
invalid/unsupported opcode: 00 - 00 - 00 - 00 (00000000) 00c01374
Invalid read at addr 0x4F0000700, size 4, region '(null)', reason: rejected
invalid/unsupported opcode: 00 - 00 - 00 - 00 (00000000) 00000700

Not sure what it's trying to do here, maybe decompressing some code and 
then trying to execute it? Any idea what could be the problem or what to 
check further?

Regards,
BALATON Zoltan


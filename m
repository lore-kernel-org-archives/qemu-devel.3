Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000A2C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCg1B-0000uq-2o; Thu, 30 May 2024 09:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCg15-0000qi-3l
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:40:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCg0t-0004Kg-1V
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:40:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35dbfe31905so980111f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717076412; x=1717681212; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxlETE6o4k+C6WO0qDsyk8tUIsM4tkylf/cHCXTauLU=;
 b=FUJpCoezBfdAE+hpYZiUwfwwzBrNIA4oP9eCg5DzElrh42fPJhpAOAeOACoc0Zd16Q
 Q8iVwOpPvreNH42ShHmu69AyxEfTgR5aSrdk1UGppkXw8FQgt0HylP6+Wr5PR1ZuewjC
 i8/RQXKJISOwGEzBjoSwhFzNNEQwZ4Ry2Vx4tv7p1TGtRyx6xxOCXVxKH9PWm69K0h6c
 k7G79GrY3V8X9tkNlLE7nLO+oyudSKyT+1kV2f7c4oz2OQclH+/PxlmU3Isi7oDh+Uv7
 81HVCYrDTfa9pqb43Ng6uM2wvp7feC8UuzSClOR7Z1U1SJiGtLLu1er2d+Cy8I0b7NMU
 t3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717076412; x=1717681212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxlETE6o4k+C6WO0qDsyk8tUIsM4tkylf/cHCXTauLU=;
 b=cQL/WvKPhgS6zwh1rJKeUezQ9Cwl/XrmjvRd5spXmJTcDMHt+Pz7hkzCZlGYWxywie
 +hZm0a2iO+8jD7UmL3T08RUHaw5GgAvlz+U03a9uRL9XPlU/7RaWP99VQyL1OhML+iBc
 A3C8EipfhNyg0wZUhGr90DaBG+XPlY0Oqbs/65SWSY0o8732az0mK1xkmAQykI5Zwkuh
 E9yHKvIDtyzPet4YhDwBpIuXhHvhqhMgM1OJzhcB7TkL709vikvwJDYcIE3WCphNZpV7
 ZytNJ42fIQteKwtjkJWMtNclKTRDHHGqOXtA1JpGX+0D/Jkm8Dl6PNJhYAwGx6cspvh8
 ccpQ==
X-Gm-Message-State: AOJu0YynduhiPMnukOxhrm+r0//6/+kTo5T1H2qGTzLvDZTlDDn8DAYx
 9kGjATMQC9Q954YYBvoPevd3bR2DfshwzyUAoxsokBqjwscmq+I1E01Eo0gIk+0vCIwaIKtitxB
 B1LGUYMjACX54Tw9KB9x7spoQuIyr6A311/GcHQ==
X-Google-Smtp-Source: AGHT+IHiBYBnTb+9xm+rsz46RyZqHZbOqgrJlxv60uKDxtoLqV7PesOrAYN549CwPpBwPe7V98kTFlk4qAUI3xVV48w=
X-Received: by 2002:adf:fd47:0:b0:355:2d3:c894 with SMTP id
 ffacd0b85a97d-35dc00c6c61mr1584159f8f.66.1717076411888; Thu, 30 May 2024
 06:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-3-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:40:00 +0100
Message-ID: <CAFEAcA-+H6U6N8JxZrvF2W30e0zL+YSOUJz1w9bqudDWVQHRqg@mail.gmail.com>
Subject: Re: [PATCH RISU v2 02/13] Build elf test cases instead of raw binaries
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For test_arch64.s and test_arm.s, use '.inst' so that the risu
> control insns are marked as instructions for disassembly.
>
> For test_i386.S, split the data to be loaded into the data section;
> fix an error aligning the data: 16 not 2**16.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This breaks the 'build-all-archs' script on my system;
looks like something is incorrectly using the host 'ld'
rather than a cross ld...


risu$ ./build-all-archs
Skipping i386-linux-gnu: no compiler found
Skipping i686-linux-gnu: no compiler found
Building x86_64-linux-gnu on host...
linking Makefile...
generating config.h...
...done
generating Makefile.in...
...done
type 'make' to start the build
make: Entering directory '/mnt/nvmedisk/linaro/risu/build/x86_64-linux-gnu'
x86_64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Di386 -Ui386 -I
/home/petmay01/linaro/risu/build/x86_64-linux-gnu -g -Werror -o risu.o
-c /home/petmay01/linaro/risu/risu.c
x86_64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Di386 -Ui386 -I
/home/petmay01/linaro/risu/build/x86_64-linux-gnu -g -Werror -o
comms.o -c /home/petmay01/linaro/risu/comms.c
x86_64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Di386 -Ui386 -I
/home/petmay01/linaro/risu/build/x86_64-linux-gnu -g -Werror -o
risu_i386.o -c /home/petmay01/linaro/risu/risu_i386.c
x86_64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Di386 -Ui386 -I
/home/petmay01/linaro/risu/build/x86_64-linux-gnu -g -Werror -o
risu_reginfo_i386.o -c /home/petmay01/linaro/risu/risu_reginfo_i386.c
x86_64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Di386 -Ui386 -I
/home/petmay01/linaro/risu/build/x86_64-linux-gnu -g -Werror -o risu
risu.o comms.o risu_i386.o risu_reginfo_i386.o -lz
x86_64-linux-gnu-gcc  -o test_i386.o -c /home/petmay01/linaro/risu/test_i38=
6.S
ld -o test_i386.elf -T /home/petmay01/linaro/risu/test.ld test_i386.o
rm test_i386.o
make: Leaving directory '/mnt/nvmedisk/linaro/risu/build/x86_64-linux-gnu'
Building aarch64-linux-gnu on host...
linking Makefile...
generating config.h...
...done
generating Makefile.in...
...done
type 'make' to start the build
make: Entering directory '/mnt/nvmedisk/linaro/risu/build/aarch64-linux-gnu=
'
aarch64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Daarch64 -Uaarch64 -I
/home/petmay01/linaro/risu/build/aarch64-linux-gnu -g -Werror -o
risu.o -c /home/petmay01/linaro/risu/risu.c
aarch64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Daarch64 -Uaarch64 -I
/home/petmay01/linaro/risu/build/aarch64-linux-gnu -g -Werror -o
comms.o -c /home/petmay01/linaro/risu/comms.c
aarch64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Daarch64 -Uaarch64 -I
/home/petmay01/linaro/risu/build/aarch64-linux-gnu -g -Werror -o
risu_aarch64.o -c /home/petmay01/linaro/risu/risu_aarch64.c
aarch64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Daarch64 -Uaarch64 -I
/home/petmay01/linaro/risu/build/aarch64-linux-gnu -g -Werror -o
risu_reginfo_aarch64.o -c
/home/petmay01/linaro/risu/risu_reginfo_aarch64.c
aarch64-linux-gnu-gcc  -Wall -D_GNU_SOURCE -DARCH=3Daarch64 -Uaarch64 -I
/home/petmay01/linaro/risu/build/aarch64-linux-gnu -g -Werror -o risu
risu.o comms.o risu_aarch64.o risu_reginfo_aarch64.o -lz
aarch64-linux-gnu-gcc -o test_aarch64.o -c
/home/petmay01/linaro/risu/test_aarch64.s
ld -o test_aarch64.elf -T /home/petmay01/linaro/risu/test.ld test_aarch64.o
ld: unknown architecture of input file `test_aarch64.o' is
incompatible with i386:x86-64 output
make: *** [Makefile:54: test_aarch64.elf] Error 1
rm test_aarch64.o
make: Leaving directory '/mnt/nvmedisk/linaro/risu/build/aarch64-linux-gnu'

thanks
-- PMM


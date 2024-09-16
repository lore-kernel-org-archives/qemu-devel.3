Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27AEC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 13:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqBXF-0001fm-T5; Mon, 16 Sep 2024 09:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sqBWv-0001a9-Fq
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 09:12:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sqBWq-0006X8-PE
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 09:12:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42e5e758093so10239615e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726492348; x=1727097148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuKYW32iuCVO7VkUFGzQQhY9BZxeslT0FvFlLvclZ1c=;
 b=r4fUdevpZxJVBQRDa15yNJIkwOwCdpi5k3LVGyqf63m5N8MGiT1HcHRvJbFZe0KoYQ
 DHfDKF9N8WP9KSdy8R0Jel/FQYajQUquMVSPMZXwmjV8Tj6dds/2o+WSlKMtyY7YYqlw
 MLu2grBggzKnh0SLqjWZa5vuxYlx0yht7Bv2CnQbWbYNs3PmeFzYcWohST50JBrcP1+1
 1ne03MD7K7TDtO9wLk/kL2VybUy9wOZrdXKxWOphUCTiPbvgGbBb+VyiI+ZkuVHI6+ZM
 /nNcwSz0p64wQFK8M+fjoQ1Gdy/f7xa+0tQuNA0X6K+vzG7M3kg+QhOOAvfbw4OfKrCe
 S/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726492348; x=1727097148;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CuKYW32iuCVO7VkUFGzQQhY9BZxeslT0FvFlLvclZ1c=;
 b=UkdGLi5QZ9h6lIQW8H+uHp6lCxn37+h2+3Y+hoWm9nTxGrp/wFVg/rcQJ4Rab1wKQ/
 tll5Qs/LBqlUT1/65FkLYlM/kvJhMVo5uCWRaTitRWQ/vdYRR4lO6nPV5bJMuxD9CSMu
 6/0gTcLXZxAlyNGVm1TZlQzC9ahP4ryOplm6Q93KqruXZ+imRpAMJGNsIJtkkb70jSX7
 7UlqCBwygA/00ebxv4Nl/nyiMAz4E06QS+zgoPxJlcpL4A7BVDULpftuGrjq7mfpx5Rs
 vY9J9pPaIt2mpRQ4BNesUvKnB/OSoVFSwIyAyVJh2Ih5a9Jox8XXZo/TgwoMaAQ00DxA
 lwgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAHUWJczp4Eb81djJWe782D+LIJtqls7i9+pqH84kKRFqsNX9Q0BpIDMbxaI612I0IWxtYnX2l7hUu@nongnu.org
X-Gm-Message-State: AOJu0YzD9qHlIqA/eP9qlK5xF8EKxhPyUyjM0jix+e19oa7hqAfXjRbt
 1UUMqptGiG4C5oumBnByQor0/mnvcSuas+V7weZNNnoMGKEqD7ogR1g/OdjBW4Vx81TVf1ElnoO
 I5EY=
X-Google-Smtp-Source: AGHT+IFp29qAJ/cy4sTtDRKo/qHQ0KqnyGC7vMPx+izD63MIohHoUF09Y0KqgYxwhFQNCbbQN6ju0Q==
X-Received: by 2002:a5d:4533:0:b0:368:31c7:19dd with SMTP id
 ffacd0b85a97d-378d61d5309mr6952021f8f.5.1726492347895; 
 Mon, 16 Sep 2024 06:12:27 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f62bfsm7199110f8f.51.2024.09.16.06.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 06:12:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 931DA5F87D;
 Mon, 16 Sep 2024 14:12:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <quic_bcain@quicinc.com>
Cc: Brian Cain <bcain@quicinc.com>,  <qemu-devel@nongnu.org>
Subject: Re: [PATCH] tests/tcg/multiarch: Define _LARGEFILE64_SOURCE
In-Reply-To: <0298a6cc-2c75-4cb9-8f9c-146c0173fc31@quicinc.com> (Brian Cain's
 message of "Mon, 16 Sep 2024 07:45:38 -0500")
References: <20240907023924.1394728-1-bcain@quicinc.com>
 <0298a6cc-2c75-4cb9-8f9c-146c0173fc31@quicinc.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 16 Sep 2024 14:12:26 +0100
Message-ID: <87wmjbg2th.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Brian Cain <quic_bcain@quicinc.com> writes:

> On 9/6/2024 9:39 PM, Brian Cain wrote:
>> With newer clang builds (19.x), there's a warning for implicit function
>> declarations and it rejects linux-test.c.
>>
>> glibc/musl's readdir64() declaration in dirent is guarded by
>> _LARGEFILE64_SOURCE, so we'll define it to fix the warning.
>>
>>        BUILD   hexagon-linux-user guest-tests
>>      /local/mnt/workspace/upstream/toolchain_for_hexagon/qemu/tests/tcg/=
multiarch/linux/linux-test.c:189:14: error: call to undeclared function 're=
addir64'; ISO C99 and later do not support implicit function declarations [=
-Wimplicit-function-declaration]
>>        189 |         de =3D readdir64(dir);
>>            |              ^
>>
>> Signed-off-by: Brian Cain <bcain@quicinc.com>
>> ---
>>   tests/tcg/multiarch/linux/linux-test.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarc=
h/linux/linux-test.c
>> index 64f57cb287..4e0e862ad9 100644
>> --- a/tests/tcg/multiarch/linux/linux-test.c
>> +++ b/tests/tcg/multiarch/linux/linux-test.c
>> @@ -17,6 +17,7 @@
>>    *  along with this program; if not, see <http://www.gnu.org/licenses/=
>.
>>    */
>>   #define _GNU_SOURCE
>> +#define _LARGEFILE64_SOURCE
>>   #include <stdarg.h>
>>   #include <stdlib.h>
>>   #include <stdio.h>
>
>
> Alex -- what do you think about this one?

Actually scratch that, this is a 32 compat hack:

  1f442da51e (tests/tcg/multiarch: fix 32bit linux-test on 64bit host)

Is the __USE_LARGEFILE64 symbol in the hexagon headers?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


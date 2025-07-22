Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D83C83F25
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 10:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueAEV-00007Y-4S; Tue, 22 Jul 2025 06:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ueAEH-0008Kn-JQ
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:28:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ueAEF-0004Id-AI
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:28:13 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso2975326f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753180078; x=1753784878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCZb4Ql9pkQ30XAHo/sCf3esdUUQcCPYr1NZMe2QvQQ=;
 b=pwJ0aHEFaPXGMkgY51Wv1oi2o5OAnW3Yb934tbRgUuXhpBcUxyAwmWyh5LBDi0Ocdd
 PBOoDvBQ9EablnTP4FD+lFMru39ZuOrwhvy15/224OEl/fcB3vAU3+MJMDUeSq6Lk3XY
 O8mfmXQw71uY4KLXTfeAL5NPzheaDFCZVCpjFLED2yVWwAUdE2TBZUlFeDHKerDPsyGW
 jGKoA19Imb1HVgUuYsIRijb9M/15i+cwl5J0pwY3OPipTz17bM0fc50axQfAHXnnDx5i
 JasFBqZlPVX1eItnylOwemvp7Q0XM5uR5piLJ336xFd82hdinEW4tu5QUmkiV+vyLq+a
 qlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753180078; x=1753784878;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DCZb4Ql9pkQ30XAHo/sCf3esdUUQcCPYr1NZMe2QvQQ=;
 b=Cg7+z1u3u09//Z52VOjnQ1Mta5Wf1IG2T59WBrIQvIgjryjos0yj/rsD3FlFZQku1N
 ms0pYxvSgyjD89DnJa96qImAmv+QpQs6jECyL+FL+9qvI+VXoDlEzS24TAhTXnAlSHbW
 9ydZyH7nEiT+RmSQQJRCj6vr3k4MvqR22IwjFKK1nCHmA4Ifqfu6udijf1XIL8hKcw1a
 3YHm8PGsQm898o/eh0dHQlYZ2btyBjRi8/7vypltcqjftWsxHV2UDn6Mm/PRLASoCyZu
 GGjMH7V5d2G93j5svm33nBuqyQgENPfVjPHRjMqLalc/LyXkPC9Wb3uiwIyNqkgWcEx9
 17fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkn0i/GlJzHnFruB3P6S3lthdaL0XUn6bllPUrojG0Qaw1sRB6t0IBGizCp7462luLW6SlJ/CwPPmv@nongnu.org
X-Gm-Message-State: AOJu0YzqKHgS1usacaE9YrpehHj4U6MxDk448ddZqeHkIJtwo1qum8kR
 EedLstcvFlqPMsO5LvDuaTrpj2pO3eA64LZp2TJvk9zoT/UpLZ0FGFZFhhW/EPl6H68=
X-Gm-Gg: ASbGncvAuGHS7TdtSl3xA+aSIBoAQ/BypZuPNziE51tEI3LF7hRCaQPN3Kpudsps8mr
 TbMZiopiWksGvB1koG1lj0spAi9rgXWXGomExKQ+hJQmkVycL8iwfF2TtvI/FbjHCjNT4fzNiWk
 qtsK3zeXJprIzjL5nXQSFyaLSTofpr9eoYvjHfEmElZvHMsn6UVZDBQXIlDxxX40fthKFlLq2LI
 yOT/dZYDeR5TpeoKvNv/J2icHHD9h4KA0sni9ssGYuMWn+WivvQoGH7wxHOTPvpHfG5RpfpHMHz
 /i8hbABUgEsklg0Fmdh70/CgQa0ytzYHef8hzGoa/4XE8n/nfdiAS4Xayxg34Xn0r5Vo9B88aIf
 IgDRs2cMl7nPY9KqNuYh4XR4=
X-Google-Smtp-Source: AGHT+IGDp5t9jB0F0F9/WUUy7gAZlAfuiVCYmBHASAng8cuIqOrRd9ls9+v0eyc3pytXznQmT/hPjA==
X-Received: by 2002:a05:6000:248a:b0:3a5:25e0:1851 with SMTP id
 ffacd0b85a97d-3b613e60138mr14354417f8f.7.1753180078227; 
 Tue, 22 Jul 2025 03:27:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458639ffca5sm13116615e9.1.2025.07.22.03.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 03:27:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 48A2D5F839;
 Tue, 22 Jul 2025 11:27:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Kane Chen <kane_chen@aspeedtech.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>,  Troy
 Lee <leetroy@gmail.com>,  Jamin Lin <jamin_lin@aspeedtech.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,  "open list:All patches CC
 here" <qemu-devel@nongnu.org>,  troy_lee@aspeedtech.com
Subject: Re: [SPAM] [PATCH v4 4/5] hw/misc/aspeed_otp: Add 'drive' property
 to support block backend
In-Reply-To: <3da6275e-84d4-4911-8df1-6ed35bf63c07@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Tue, 22 Jul 2025 11:30:49 +0200")
References: <20250708055810.2868680-1-kane_chen@aspeedtech.com>
 <20250708055810.2868680-5-kane_chen@aspeedtech.com>
 <3da6275e-84d4-4911-8df1-6ed35bf63c07@kaod.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 22 Jul 2025 11:27:56 +0100
Message-ID: <874iv4wmdv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 7/8/25 07:57, Kane Chen wrote:
>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>> This patch introduces a 'drive' property to the Aspeed OTP device,
>> allowing it to be backed by a block device. Users can now preload
>> OTP data via QEMU CLI using a block backend.
>> Example usage:
>>    ./qemu-system-arm \
>>      -blockdev driver=3Dfile,filename=3Dotpmem.img,node-name=3Dotp \
>>      -global aspeed-otp.drive=3Dotp \
>>      ...
>> If the drive is provided, its content will be loaded as the initial
>> OTP state.
>> Otherwise, an internal memory buffer will be used.
>> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Erm where is this email getting tagged as SPAM? The headers seem to
indicate its clear:

  X-Spam_score_int: -39
  X-Spam_score: -4.0
  X-Spam_bar: ----
  X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=3D-1.9,
   HEADER_FROM_DIFFERENT_DOMAINS=3D0.157, RCVD_IN_DNSWL_MED=3D-2.3,
   SPF_HELO_PASS=3D-0.001, SPF_PASS=3D-0.001 autolearn=3Dham autolearn_forc=
e=3Dno
  X-Spam_action: no action
  X-BeenThere: qemu-arm@nongnu.org
  X-Mailman-Version: 2.1.29


>
> Thanks,
>
> C.
>
>
>> ---
>>   hw/nvram/aspeed_otp.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>> diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
>> index e41481d9bb..f018c58713 100644
>> --- a/hw/nvram/aspeed_otp.c
>> +++ b/hw/nvram/aspeed_otp.c
>> @@ -9,6 +9,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/log.h"
>>   #include "qapi/error.h"
>> +#include "system/block-backend-global-state.h"
>>   #include "system/block-backend-io.h"
>>   #include "hw/qdev-properties.h"
>>   #include "hw/nvram/aspeed_otp.h"
>> @@ -35,13 +36,25 @@ static bool aspeed_otp_init_storage(AspeedOTPState *=
s, Error **errp)
>>   {
>>       uint32_t *p;
>>       int i, num;
>> +    uint64_t perm;
>>   +    if (s->blk) {
>> +        perm =3D BLK_PERM_CONSISTENT_READ |
>> +               (blk_supports_write_perm(s->blk) ? BLK_PERM_WRITE : 0);
>> +        if (blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp) < 0) {
>> +            return false;
>> +        }
>> +        if (blk_pread(s->blk, 0, s->size, s->storage, 0) < 0) {
>> +            error_setg(errp, "Failed to read the initial flash content"=
);
>> +            return false;
>> +        }
>> +    } else {
>>           num =3D s->size / sizeof(uint32_t);
>>           p =3D (uint32_t *)s->storage;
>>           for (i =3D 0; i < num; i++) {
>>               p[i] =3D (i % 2 =3D=3D 0) ? 0x00000000 : 0xFFFFFFFF;
>>           }
>> -
>> +    }
>>       return true;
>>   }
>>   @@ -75,6 +88,7 @@ static void aspeed_otp_realize(DeviceState *dev,
>> Error **errp)
>>     static const Property aspeed_otp_properties[] =3D {
>>       DEFINE_PROP_UINT64("size", AspeedOTPState, size, 0),
>> +    DEFINE_PROP_DRIVE("drive", AspeedOTPState, blk),
>>   };
>>     static void aspeed_otp_class_init(ObjectClass *klass, const void
>> *data)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


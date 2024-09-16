Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C23DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7Ec-0004xe-W6; Mon, 16 Sep 2024 04:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Eb-0004vr-6I
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:37:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7EZ-0002oa-Ix
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:37:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so39676205e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726475841; x=1727080641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkMDRJ6OsaJkjDJfBt6t6kM6jKTO9PSiyocI6kNUcAo=;
 b=h65ifc8vfP1PP9IOBPTtJMQHDpiefFRGSm6KOPWrpAY+/EI0gUd6fGSHlvIzJTPwHE
 zLAWfOvX0M3GdzeuwDkrO4ZSEf41dknciEVCJohfIvq2+l/a+6mBIlLSMJtckno/i2dU
 PSCchJXeXeGhnpMxv6EUDuIJ1S0zr2mR/NvxyGUmIsZ+nujO3fj22kRKc4izk92yBeRd
 uy0lQ1bxfVSFfX6JWlq7ONQv9RCZQ6QpD8HfXW1k2ot1oF3is8C0n8jaMuJcs1QCxIJG
 5TPLwmu4qSNmuAP8Nq0fFo60MudczDyUyTErjzF+X5P2B1x98yMrK3vj/H2HNoxN4f0I
 P9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726475841; x=1727080641;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AkMDRJ6OsaJkjDJfBt6t6kM6jKTO9PSiyocI6kNUcAo=;
 b=oDj7soR+a4OcLMvp1ROnWVvJjjc1Ws33kQls/gOp4h7UD9LjPJdCp2s54v2ZLgvPaC
 NwuYM+d05KsmdTo73dWdi3lSARTt31fFVhS8/yypshlEoH8uaW54udgqrunJgeFjQyAh
 UvV+DORxbAipaUsNM7aHyhGIpeHt0wxkSJx23Kx1PcE1HgH7DFqdk4EvCQPAv4waO1ls
 h7lq4+dWD8BctV4EEbeEZkdbap6RtwUURyf2jFPmhMPcmotS7ECu2L3QyXSYKl5SeOa7
 FqDzdgtZeqyUH278dc/uCHZ7Zz6/iA2cWIrFTMcuvqc1BLFMeVDMLSbLY8MBVY0V2CCx
 jmvA==
X-Gm-Message-State: AOJu0YwxZ/2UfJp5MxBlrC1LHXMI0jNc9q3VNFnx9z8CJh6F1t7FxXOd
 JPddXnvU1lL3il3ViiIoq1V3rZQgYWA7Vl1FCXdSRg7Xkj400lbr4fb7n54z7to=
X-Google-Smtp-Source: AGHT+IH5h2YPyhIX9ETwAEAK9SlS76q6XlZ+c8QWxGx4CwVAFn7FVsAyRu1Bfd4Illrr09nVLuTxEA==
X-Received: by 2002:a5d:4589:0:b0:374:c9f0:7533 with SMTP id
 ffacd0b85a97d-378d6236beamr8950052f8f.41.1726475840380; 
 Mon, 16 Sep 2024 01:37:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800138sm6541772f8f.68.2024.09.16.01.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:37:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C09A45F87D;
 Mon, 16 Sep 2024 09:37:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  David Hildenbrand <david@redhat.com>,
 qemu-ppc@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,  qemu-s390x@nongnu.org,  Alexandre
 Iooss <erdnaxe@crans.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 12/17] tests/tcg: ensure s390x-softmmu output redirected
In-Reply-To: <32e9207b-0aac-4d43-9dbf-bf5e36d634de@redhat.com> (Thomas Huth's
 message of "Mon, 16 Sep 2024 07:27:56 +0200")
References: <20240913172655.173873-1-alex.bennee@linaro.org>
 <20240913172655.173873-13-alex.bennee@linaro.org>
 <32e9207b-0aac-4d43-9dbf-bf5e36d634de@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 16 Sep 2024 09:37:18 +0100
Message-ID: <87a5g8gfk1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 13/09/2024 19.26, Alex Benn=C3=A9e wrote:
>> The multiarch system tests output serial data which should be
>> redirected to the "output" chardev rather than echoed to the console.
>> Remove the unused EXTFLAGS variable while we are at it.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/tcg/s390x/Makefile.softmmu-target | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/tests/tcg/s390x/Makefile.softmmu-target
>> b/tests/tcg/s390x/Makefile.softmmu-target
>> index f60f94b090..ad681bbe40 100644
>> --- a/tests/tcg/s390x/Makefile.softmmu-target
>> +++ b/tests/tcg/s390x/Makefile.softmmu-target
>> @@ -1,6 +1,6 @@
>>   S390X_SRC=3D$(SRC_PATH)/tests/tcg/s390x
>>   VPATH+=3D$(S390X_SRC)
>> -QEMU_OPTS+=3D-action panic=3Dexit-failure -nographic $(EXTFLAGS) -kernel
>> +QEMU_OPTS+=3D-action panic=3Dexit-failure -nographic -serial chardev:ou=
tput -kernel
>>   LINK_SCRIPT=3D$(S390X_SRC)/softmmu.ld
>>   CFLAGS+=3D-ggdb -O0
>>   LDFLAGS=3D-nostdlib -static
>
> EXTFLAGS has been added on purpose here, see commit
> 26a09ead7351f117ae780.

ahh missed that as I couldn't see it being used elsewhere. A comment
at the use site would have helped as git blame only gets you so far if
the line has changed multiple times.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


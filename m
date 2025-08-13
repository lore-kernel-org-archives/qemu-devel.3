Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CDEC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 08:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um7HP-0005im-R6; Wed, 13 Aug 2025 04:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1um7HN-0005gF-Hp
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 04:56:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1um7HL-0005C5-Bs
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 04:56:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b9163ac059so512548f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755075372; x=1755680172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05BepfjRkfU6TWdCxcrbXFkyDEWZqQ67vXEHNC4Sfd4=;
 b=wHZTS66ywfpoM0PXP8VR+himsaa2Ik/iturckPpVMoHDUVW6Ov0D+1FswBevOX2QiP
 dDSgPrUXh57n9WWfRHrU3iMg3hUTPV3vJhb4oZwQk9kjthjkhkxm3gOuHQudGFxvgtFu
 OizsPTe3+8wKk6t5bLOFolMSEumaU2kUvwgEaX9sffjrz/qGrcItC/tiD/oMW4E9/gyu
 MCi6p+lZ7myRu63Jvc74hwnq2M6JWAIjn6V0FfD2ceb8hVnf/r6DK3s7pXsy4QSMJfrg
 jnjrxh3CNDMN27NHbUttiUTNhiGK1C7g3zPtE5IUScmMr+XKIjH2ENtNsst0jztohnYH
 EkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755075372; x=1755680172;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=05BepfjRkfU6TWdCxcrbXFkyDEWZqQ67vXEHNC4Sfd4=;
 b=BB1QvB1RhLoRl/wQOpv0f6y8Jyt5kwWwMZRDIIzCKuu9vIPqDdf4nXuv98IfVTSjh6
 /vB+6DFzx/9j4TPCW5g/fwJh68BWO7agxTudfZ0mGNPjlXLqHxAcPRZ77VAjBh6aoe7l
 2ebvUMZ7b3h1EXfof5aUdqF2OTRhIZiIw4UOENp6B2gMSVHjAYdi8+wCBBjXm8fi3Y5P
 CjfUgznqttZpTyhE4nGi5Fgur1ANP23eGPviH0bhdX5KaUXVJHaw1ke2fcHtDRjSgAFp
 G04SNlzxGwzc85bwlI227oKsU+OvM4Ul6fyjxftMgGZ2Z9kR8cNIg0s/v3AUC+kIx6hy
 YLSg==
X-Gm-Message-State: AOJu0Yyj6KA9HT9a1luAf6kf7dQHn6wQVnwRuuJB9olPePKgVHcKWSX+
 hqnCmwbsxPVK1Srn9gZZQVBSIT/Ek3D2Bm3/89Sloy7/GnwJjo8bu5UVxL3AdbASUCc=
X-Gm-Gg: ASbGncssG52pw3VG1GF2VodWdSaH26ekx9xMSnHOULVgxOPtgaIBacptkOZRHj6pSSa
 KfURF8eTeWUuNCmmg2JI9l8vBL2E+8UsY0hf/Lhd1j19voB/lRrGwwnYrwRY63ULkQ1S6VAdlkV
 h+8MyvnR3pIil9QUR88WZYm7pBZw8n+Sjm1XVJiQMDRPBDURZRX9qYh4qFmdSCX0TxXIoHUZgCq
 fukWrJXP96quBG3xBRVUEMSyyit11DSLDTSKsIqMZbEFu/AVlSr5+NvUBXAtgt3lzv32zYj10Ah
 bb7La27utvqoVN+HL/baPgIwYEJK5tyV+PIsAvl2oir27/v77VkAeje74NtPT6uwQrmi5D6x8xC
 cEQoRspCiBG7cQVwRCi2maUc=
X-Google-Smtp-Source: AGHT+IEvTFbfvZDLjjJmJX1Zgz2TPoRvrDm4j5ECWrQ2V2yVmZsRgSjq6xnFKxUju2KlwwEvhnJxuw==
X-Received: by 2002:a05:6000:240d:b0:3b7:8f49:94f7 with SMTP id
 ffacd0b85a97d-3b917ea0520mr1584286f8f.31.1755075371931; 
 Wed, 13 Aug 2025 01:56:11 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf970sm46746108f8f.25.2025.08.13.01.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 01:56:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 397FE5F7AC;
 Wed, 13 Aug 2025 09:56:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PULL 06/14] tests/functional: add hypervisor test for aarch64
In-Reply-To: <dd353f4a-74cd-4c37-b9ea-5486168c52ce@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 13 Aug 2025 09:27:43
 +0200")
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
 <20250727083254.3826585-7-alex.bennee@linaro.org>
 <dd353f4a-74cd-4c37-b9ea-5486168c52ce@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 13 Aug 2025 09:56:10 +0100
Message-ID: <871ppfa9cl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Alex,
>
> On 27/7/25 10:32, Alex Benn=C3=A9e wrote:
>> This is a simple test case that runs an image with kvmtool and
>> kvm-unit-tests which can validate virtualisation works. This is useful
>> for exercising TCG but can also be applied to any nested virt setup
>> which is why it doesn't specify an accelerator.
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-ID: <20250725154517.3523095-7-alex.bennee@linaro.org>
>
> You merged v1, not v2, was that deliberate?
> https://lore.kernel.org/qemu-devel/20250724094214.93330-1-philmd@linaro.o=
rg/

I merged my v2 from 20250725154517.3523095-7-alex.bennee@linaro.org
which addressed the same review comments.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


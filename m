Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D647CCD190
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 14:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8JJi-0007Bo-Gq; Mon, 13 Oct 2025 10:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8JJh-0007BU-8Y
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:14:25 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8JJc-0003CK-Oq
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:14:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e52279279so30119455e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760364855; x=1760969655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qv7yKUSp1keAvGeIJTgsLzzM2Dd2vNSw3IfagjYR6Ak=;
 b=uXuAxnefmNz6JGOAoVwNRLPc9RonfOPoYevDGThYU6lJS2ib3imJoiURFfna4Gh/gc
 n2qIWXiq5fSahNS/RpUUh2Bj+tYee9WQfTA+RV4sgJlEM48VSmMCoU1yh5M6/6vqhteO
 3k1bbQjpU0IX8N5by1u76FJTG8tOJUNBttEcBPisySWblb203X6uXg9Xzh97IQWWqQG7
 aYy88r7arLIWdIOw1ntJt0eQBxy/2da8Lg5Fsb72Vdw18zqU9mK0uXU5CPuni9nZ8+Pz
 R4DhHjmH3XNJKBXwcaGxf62j1GLhokQdlprZwVI4bzVBcZQGOJzMtUR4hOacDBiQ4vtW
 Ui4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760364855; x=1760969655;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qv7yKUSp1keAvGeIJTgsLzzM2Dd2vNSw3IfagjYR6Ak=;
 b=KqfzqOSYuGNkcKTL942lMlsQOHvHOBNz7J5oHh1gDkALD2Jd6XXvBaheF4YhxsjSY4
 rrcyyVssiMNIBTan/L9+mBfP/k9xf47X7JdgZHYkbnj2B4YXuLOQt/v/jAdoXckeQNoA
 v25M6CiixVVzbaLks0geUkCmNb92Bmj030OM+/HsPM80lO5H9yv8ijF27YRokCmU4ZoP
 uCTxfL612cvtRJBO2aTu7/prIRtIa9jaXqlC8p/HhRY0jXOwklekrMNcKIaaV3PmMmKM
 XrkDzrZFl6LKK4l/dwO2Gg1dGzQQilclGJSsYoNK7K0aunJdk7xe/Rgj9CvC/s/Ve/UW
 IhIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP5FF4p+cZ2DK8fpSzCat9VSaBR9DH1PXt09iqLP6vTFWGnEhaLlyl5MWuqbpdzSMo3Z1isvy+lN1U@nongnu.org
X-Gm-Message-State: AOJu0YyroNW8rWBcgOVLtvua01p6V/PhwrbyeiVAUIPpBLsT7XEULyjD
 aXB8lSnEYsgdwnxXHLmbW9ZTh6OGYFB8hhk/gsJ0Om5a52OK59KJk7e6sXaVfTuxUvY=
X-Gm-Gg: ASbGnctUWrXj83Ng1Ga8f5W//1wilkP72s4gSfgtWzrvrLSs3LZTwDlaLtET+i8gcZV
 cJ+cAMHss0ARCp1yNzFILZlrzCCRh+4aUiAR8I7xxw/QXAMdOMIXjk/PGiMyTKtMJ6F1Is7gtOc
 JR1mPtHgi3NMQfkJuh2BSfj8PPS5RC/knkXk6a8Kv8bgCWxbjULjbeKCsOAi+kNJKUk+MCnPmtT
 gPysHvb9/p7qXKJoO6Z1tTZ3BXSsT3tB5UG+5O59gi3Eddg40eVPESZKWkZyCQQr+XouDLF05jI
 eunMe4iTah99I1kcwT3yE1W4QFV+NamPxO4hH8n7RCBhBnYA22Uyy34/KSsjkrCrpS4T9VCqo1a
 aOrN0k5ZxYr9Ah+nk9LxmjvlgP/OadZPTAHhkxTtN+CiU0zkPxLloxKfDK+9il1XKKrkblU3fMH
 aj00S4MOrHpvZp
X-Google-Smtp-Source: AGHT+IFpD7B4YpSeDObYU3xiNzf797WnP8ClM3/cdXiW5NpKO9VzUYIyFMpffvprfsk6KbSgYLlZIQ==
X-Received: by 2002:a05:600c:1f93:b0:46e:376c:b1f0 with SMTP id
 5b1f17b1804b1-46fa9a8ca9fmr151711385e9.7.1760364855227; 
 Mon, 13 Oct 2025 07:14:15 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fc155143fsm125262305e9.11.2025.10.13.07.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 07:14:14 -0700 (PDT)
Message-ID: <ba4ca63b-6d46-4df9-8d30-fc0537736adf@linaro.org>
Date: Mon, 13 Oct 2025 16:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/xenfb: Replace unreachable code by abort()
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org,
 qemu-trivial@nongnu.org
References: <20250729111226.3627499-1-armbru@redhat.com>
 <877bwz6oqy.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <877bwz6oqy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 13/10/25 13:10, Markus Armbruster wrote:
> Ping?
> 
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> xenfb_mouse_event() has a switch statement whose controlling
>> expression move->axis is an enum InputAxis.  The enum values are
>> INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1.  The switch has a
>> case for both axes.  In addition, it has an unreachable default label.
>> This convinces Coverity that move->axis can be greater than 1.  It
>> duly reports a buffer overrun when it is used to subscript an array
>> with two elements.
>>
>> Replace the unreachable code by abort().
>>
>> Resolves: Coverity CID 1613906
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/display/xenfb.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued with g_assert_not_reached(), thanks!


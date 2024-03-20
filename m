Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1506CC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 03:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmmUx-0005fP-9J; Tue, 19 Mar 2024 23:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmmUu-0005f5-Ch
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:20:12 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmmUs-0007BS-5R
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:20:12 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so379549a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710904807; x=1711509607;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+7gSRZQKqTYhIIVhro9hV6j8lyLELp80FOk4YvnWdV0=;
 b=TlEVsX6nZtcKXCXf8sfT5Bozz46A6s65Z4gqzfcaXF1ul/Aqp9tWwtZmfA9yw3f/Oj
 DVNX5Kt6U9lYcM0W3wk+E3Qjx22fRBRNwOZdxFs427Di6QhhUerwbSgdWl29avnezgVj
 KNNaMQi2p49QfeUaCl9J69fFUZ0YkU1YtI6raKno7oiQ06WPBUisGHd45RHSf/8YwTPb
 +jh41lFkrm0tSAuLng3oPUJmFDZIKSY9n1Z+RPHJeGR0NADd5x2pBZ4cHIGouLs6NRyu
 hbw1TxFDvmcN2S0Vp/GO/uvV6conlG1OvOsR+a00Y4mAZupYvZISY7ue/Ud2ZLeqvTro
 GcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710904807; x=1711509607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+7gSRZQKqTYhIIVhro9hV6j8lyLELp80FOk4YvnWdV0=;
 b=MBBPgVXGBKOIZxPRyPGuHo6On5+rsnZktpbzPkjlzRb56N8+y7+c6dZiR8OQaZVPlZ
 fH0LnGWo3mKhAuNmd/boHNuLHrRvinlOiG5LtnxdMfAROGzEVjhiD8D4x8O299y+ti8j
 NteNXkENzDGJp3CXejzykvr7+XqWa70lTzgSz9i6UCGuuJ3dC/fcecaZRKs3JTxcD8CU
 v6rChR67IZUR9Ai02xgATk20TiMNk3ExZ5RaB3tRVtyEcDiq/eGElI2tNGLG8R7KflBx
 5N/hRaDtQBp1YFbnuBQP/5lCwa/EGj/uOw8U2MM6K3wA1si2ARHSf0DGJ8zB2BjwpcIn
 MmZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKftPXtsCaexEZHP23JTKV/zUTsIhQjJLCWyXS2WBK0ymeTttCR+zdIalpEM3HimXIiwelcwIEPlYNUTOvoKaMeLNO5kE=
X-Gm-Message-State: AOJu0Yxt88Nn5dRf48rCfoUcpiwp4gCy9g+cZXAT32qrcb/pR3EwHPHk
 fuOcCiVTtmsQvII8JGVeZH9Y+EvlYr6Eji96sHmIPCegOp1+0cS7LMFqmJoXSfc=
X-Google-Smtp-Source: AGHT+IG6f/Pyv3J/PQjc4stxjlz2BF4p3j9jqTvHA6JHIUNH/IQmcnJirYn3DzUGvR7MQdVjpnvlCw==
X-Received: by 2002:a17:90a:2f42:b0:2a0:298:536 with SMTP id
 s60-20020a17090a2f4200b002a002980536mr331853pjd.19.1710904807446; 
 Tue, 19 Mar 2024 20:20:07 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a17090ade0900b0029bc9c34a39sm357750pjv.50.2024.03.19.20.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 20:20:07 -0700 (PDT)
Message-ID: <5b8160c8-6774-47b3-a495-f7dc64ebd28d@daynix.com>
Date: Wed, 20 Mar 2024 12:20:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ui/console: Remove console_select()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240319-console-v2-0-3fd6feef321a@daynix.com>
 <CAJ+F1CKOuZR5nZxcxRzZyoE56p_nNW11cySEmnFvRgiPv5OAdw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1CKOuZR5nZxcxRzZyoE56p_nNW11cySEmnFvRgiPv5OAdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/03/19 17:29, Marc-André Lureau wrote:
> Hi Akihiko
> 
> On Tue, Mar 19, 2024 at 7:09 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> ui/console has a concept of "active" console; the active console is used
>> when NULL is set for DisplayListener::con, and console_select() updates
>> the active console state. However, the global nature of the state cause
>> odd behaviors, and replacing NULL with the active console also resulted
>> in extra code. Remove it to solve these problems.
>>
>> The active console state is shared, so if there are two displays
>> referring to the active console, switching the console for one will also
>> affect the other. All displays that use the active console state,
>> namely cocoa, curses, and vnc, need to reset some of its state before
>> switching the console, and such a reset operation cannot be performed if
>> the console is switched by another display. This can result in stuck
>> keys, for example.
>>
>> While the active console state is shared, displays other than cocoa,
>> curses, and vnc don't update the state. A chardev-vc inherits the
>> size of the active console, but it does not make sense for such a
>> display.
>>
>> This series removes the shared "active" console state from ui/console.
>> curses, cocoa, and vnc will hold the reference to the console currently
>> shown with DisplayListener::con. This also eliminates the need to
>> replace NULL with the active console and save code.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> lgtm
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> I am willing to take that for 9.0. Is there any bug already opened
> about the issues it solves?

No, I'm not aware of one.


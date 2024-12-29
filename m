Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EDBE7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 05:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRmHS-0000eA-1W; Sun, 29 Dec 2024 00:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tRmHP-0000dw-QB
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 00:55:59 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tRmHL-0000Ig-1n
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 00:55:57 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so8977750a91.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 21:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735451753; x=1736056553;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qFk1xO9HgmOE68zctv7LR0Nvms0xgteIPePI8Ey83ZY=;
 b=qrvTQsPXNJnXYEzSlvU0/ihp+NK9dd44qj77QqPau6xLRM5n8/fCPYR5eDfl4Vxq59
 YCDcOaeNIR1bJf2heh+oxFaKC6EWFf1pULpcLLOJygH34MsOG7OQzpsa3t861sutOMwG
 Cj67R34ReA1u9FckiIkI9Z7NRyOzPF4BlLQ5UeusWeN4wQlwwLvFsar/nmKzudEshoPl
 ni8Whf9St5xyKKeERYKkyvQR35mo7rzhY4v0r0O1KTm6iLgTWduMjekTmoVV9ZT/P2sp
 VLZkmCnjUc/DdBuas0deLjWNXNeszdfui0Zrw+XwSpV9XbaKQCVeu3+GfxfmcG92EfRP
 E1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735451753; x=1736056553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFk1xO9HgmOE68zctv7LR0Nvms0xgteIPePI8Ey83ZY=;
 b=TZIhtRdw2/zMMjlU1luVWa9QXSrE94B0LWMvDiEBbQEJP5JU0PRg7aaqvldLfph1LK
 NCIPPjvR39mg01rziBEVI2ejE5t+32AG9uNgu4RU+Hl/YERA/k9d1kP2IinPflregUUj
 ENgzRC3CscT592wFXOtLy6DCVyhB2Oolf8bz4zvH49X4Gukpg+TDWO3Bw6Oup38l+/zn
 IKJW5C6oQGn5DZvT8UB0GuUTrR0SP0K9pl6MPfXo8mmwOnvXUttfRvPtToVkOe9LcxEd
 /QR+VHthcabqbTr/keGSrPHTSYt3BYwf3RwBL9hY0bmD6hdBXed/XhGi5rOpDCfLuSSJ
 oTfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPcdwo9eIUqhVKi1W3Kpf5sRwD1cVfUXLt03jZCw2jhSPFQrQTfGDY2HfxLcwC4AKY4UGMiGnSl3KV@nongnu.org
X-Gm-Message-State: AOJu0YyyuMDE9N1K4F/3gOSz5sbzK9W2VBhSQL9SOwfdKTqgEfxwca9x
 IOQdIUtgGBeqOziW6n1GMrzk8uLrcDb97IwiEyAk1KmgkLANexureRIJMvOInaw=
X-Gm-Gg: ASbGncv3hc+9VArdg4pUfevdvNuCBrYMTkEEvoDNtR0SVxCZcp3KoXAyK9WZHwLZBiL
 88t+IoP1SSQTyglMQqV5BEI4Qjomt6UNI+h4DEzlLySaHJwX0USXQDD689y+7fmYJPG+OiFk9EH
 lPOtUgMNjbyEGt5s0CgsmKu62qcMWfdhiIxRUeJLDB87ra/lhNjf0grK58Xliq01DUrjW5XD7JA
 yvYGo7/glE8Tfa5S5QpjkPm5KiGVZ7lS4tntcoGnxNTe5PmqGcxr7qlMZVM6i6gEDlGsg==
X-Google-Smtp-Source: AGHT+IFBmMRTqatpz4bELDIArxMkuIzXkZY3uWPpTqdfuiRQJ8CN/Vr7W5Ux1cVaooLm546TRklVCw==
X-Received: by 2002:a17:90a:d64f:b0:2ee:9661:eafb with SMTP id
 98e67ed59e1d1-2f4536d18a7mr46550320a91.12.1735451752799; 
 Sat, 28 Dec 2024 21:55:52 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed82d27esm20179076a91.31.2024.12.28.21.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2024 21:55:51 -0800 (PST)
Message-ID: <867fcb50-e1bb-415d-9bf2-0b58134f95e4@daynix.com>
Date: Sun, 29 Dec 2024 14:55:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] futex: Check value after qemu_futex_wait()
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 devel@daynix.com
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
 <20241225-event-v1-1-a58c8d63eb70@daynix.com>
 <CAAibmn0u1oveoxVXbTzZn4RahxDbtxDvGHZ2y=JF5NsEfdoE_g@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn0u1oveoxVXbTzZn4RahxDbtxDvGHZ2y=JF5NsEfdoE_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/12/28 20:11, Phil Dennis-Jordan wrote:
> This is somewhat orthogonal to the issue being addressed here, but:
> While reading the man page to make sense of this patch, I noticed the 
> following:
> 
>  > If the futex value does not match val, then the call fails
>  >              immediately with the error EAGAIN.
> 
> And qemu_futex_wait does not seem to handle that case. In fact it seems 
> like it would take the default: abort(); code path?

It's handled as EWOULDBLOCK. The man page says:
 > Note: on Linux, the symbolic names EAGAIN and EWOULDBLOCK (both of
 > which appear in different parts of the kernel futex code) have the
 > same value.

> 
> If I've got this right, I'm surprised there aren't spurious abort()s 
> happening, but I suppose QemuEvent and qemu_futex_* are used fairly 
> sparingly and in low-contention areas.

QemuLockCnt, which relies on qemu_futex_*, is used in more contended 
areas so it will cause trouble if qemu_futex_* is broken.


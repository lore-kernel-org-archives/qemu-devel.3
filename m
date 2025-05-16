Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468BAC3ABDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 07:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFpRT-0004XJ-Dd; Fri, 16 May 2025 03:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFpRL-0004Ts-Ox
 for qemu-devel@nongnu.org; Fri, 16 May 2025 03:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFpRK-0006UA-5k
 for qemu-devel@nongnu.org; Fri, 16 May 2025 03:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747380305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eSAnGQhYKpKgFL66orC7+rsOCkKK/O7bRDjGT4hqM8I=;
 b=c+e6to0QQe7BTkGa+xIyHRhAcytC78163P+KJysgXAq8gu6Kqmsk29NK/a7+L0emzfKYgZ
 h7HFrdDLVyDYwLwEsDJudZn5MuXmPtQLtGk+ebEPllS3DxNNt7XowTZSCQpHNIuLphbNlw
 2d9nvewGIDt/+tk8TQaYDL5dyARbgSU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-qk5XFT1nPVac1yPxR9v0wg-1; Fri, 16 May 2025 03:25:02 -0400
X-MC-Unique: qk5XFT1nPVac1yPxR9v0wg-1
X-Mimecast-MFC-AGG-ID: qk5XFT1nPVac1yPxR9v0wg_1747380301
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a34f19c977so854290f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 00:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747380301; x=1747985101;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eSAnGQhYKpKgFL66orC7+rsOCkKK/O7bRDjGT4hqM8I=;
 b=Pbdg1AduBdAQ9D2jJsDbuOjCBnuLRwEWaeSxJNftVTuNt7DNS37d2AiYYNxH7DPQwq
 d8PCV8T6SjND5ckduBMEwsAUFqxF5KdzCeksWMIgLm2Sb009XfhKYS4/69ZvDklMB9sv
 P31QafGl5AS0T4eXtoRqWo4OVtjFrSB/mOQL1c8m0G23XxP3dpT/2igAifGRrUWVdLlV
 pP+gHa/tzC3xMbeqD/Ra7gQlyC41S4lXAsoAYQUbvjt6XoVMLYwkeQmVmdLRaVivOKOD
 Ly+FBezVdNFxanDaN7kOYne37Z0GHBjePQDul5tQI+EuG4s3+22dxN8J+FXP4Qyd+160
 RgGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc0mVED1x2XhOwTE3kIyJSRXcm14N+CadJCCUWuM917ugXx+bIi6DJACIYR7IQjLX60E63SZADj0Qh@nongnu.org
X-Gm-Message-State: AOJu0YxqbqjPX/9TmqF9PMShcAt+bYavwH3ERBjKWju/v/0BEfN7ZDs8
 3CNcWtl0owWAVgqQIuFYiO43nYlaGuHHV4gf4t9evVIt4Iu2ZeMMskV2ZTCxl8wmVFX2aNLxM83
 GzfUIEnr0wMhTiEJqaUgzgbSelSFI6cGfcaUpGFg5L9Q2+i8ebxHs1X7e
X-Gm-Gg: ASbGncuZuMXMqjRAou5B2/yF0uNGc00PQdZYjkm3LB5883b0OLIbsB5kBU4b/0EEVzJ
 7rLtpWQqGdG4e8FS+jT32b3iNyLR9mm2w2dDh53D0NHaZRofTyGscKEEqlekiptcM8KLqaPBxN9
 PoNTzkVKeHhqNnFsXj5MWVTs9/p+iHXh+JYBaXP/a5MWklkt2g9Ho/BgTFqa5owuCFcCGvEdcBY
 52/BK9G68P2OXVyQSfC4FWE8/z461hoKUwR1URbpBKZd5TqMxduWsz0DTWZ7SDpRfnCn38neIYR
 9JksWhWHbcMt498FdIm5qACfqn6KqJWQ9ZVHKAUg6YU=
X-Received: by 2002:a05:6000:1acc:b0:3a0:8524:b480 with SMTP id
 ffacd0b85a97d-3a35119b98fmr5694046f8f.2.1747380301285; 
 Fri, 16 May 2025 00:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJTcHvywGXDKmB92HMsF2oA+4YtKBmrPVQtYWQK106mroBAtc4pzvZEBxDQtf/IfCwkZ3EvQ==
X-Received: by 2002:a05:6000:1acc:b0:3a0:8524:b480 with SMTP id
 ffacd0b85a97d-3a35119b98fmr5694034f8f.2.1747380300955; 
 Fri, 16 May 2025 00:25:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-129.web.vodafone.de.
 [109.42.48.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd4fdc73sm24064585e9.2.2025.05.16.00.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 00:25:00 -0700 (PDT)
Message-ID: <09e3b668-3956-4e77-b189-e86fcbb2da7f@redhat.com>
Date: Fri, 16 May 2025 09:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] single-binary: build target common libraries with
 dependencies
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/05/2025 07.27, Pierrick Bouvier wrote:
> Recently, common libraries per target base architecture were introduced in order
> to compile those files only once. However, it was missing common dependencies
> (which include external libraries), so it failed to build on some hosts.
> 
> This series fixes this, inspired by Thomas fix [1],

Actually, credits should go to Paolo who came up with the meson magic :-)

> and applied to other
> libraries introduced very recently with [2].
> 
> As well, we do further cleanup by removing lib{system, user} source sets that
> were recently introduced, by merging them in system/user libraries, thus
> simplifying the work on single-binary.
> 
> This series was built on {linux, macos, windows} x {x86_64, aarch64} and
> freebsd on x86_64. Fully tested on linux x {x86_64, aarch64}.
> In addition to that, it was checked that compilation units compiled per binary
> stayed the same, and that their size was identical.

Thanks, works for me, on both, Linux and OpenBSD:

Tested-by: Thomas Huth <thuth@redhat.com>



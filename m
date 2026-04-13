Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A22EBFD0F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCCMy-0000zs-OR; Mon, 13 Apr 2026 04:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCMx-0000zP-6Z
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:10:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCCMv-0007y7-FS
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 04:10:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so18889585ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776067803; x=1776672603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f8n3zErYGVyHXRFsuw1UMVYYHEQvpBSsrrQH2Im/cQc=;
 b=G/0jWar3HojvsHaqlRlL4BHsSX25oMFH38GFNe019ZPaky+mRs7AfDskXM19tvlzLy
 aprmZVzmd2tuNEDxduo/P/Pbsxha+fQQxJQdbc/iBmwM+Z0ypnuPM/olccisg9nbfs4l
 r0wEf9lAHJMydy1/DSTdWMB+5bv1GNkgKupgNIJ5V5pWH0S1NQnJSR/VPjOCN084Umip
 mQSfGYiVZg/IIcgWLQOaqmSJtqPyv3Is1zaOF268oW1wvNDJqu3Ygj5beiShH7pjvF33
 S8ud2YZLD+/mDSs+ojClDvFmIqjrwi2kDHKsgQyXww+RZb82h/Lgc4NAYuWMjv0wTq28
 muGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776067803; x=1776672603;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f8n3zErYGVyHXRFsuw1UMVYYHEQvpBSsrrQH2Im/cQc=;
 b=Rj2xdP54A9vpoCsxwUy+PGSikyb2GzzTaeI+DWtRQZHtHsd3hAzZKiCyUgbOihmEh8
 FgVe59aucdsV+RwliRi5cyqSD2HXimVZh82Frf2cVZlb+PkWz1L6m8A4ZU/XIitHPmAH
 SMadlF1DeMemDTD6eDFlNtgE8jowvwapV5EIuU8XUFK5k0j8O3Su1OCOC0tvuTTN3rdN
 18+M8ZBc0cqiNC8+simk6ArjvL4SRYto2bw6f2wOyOn0PENS6ETbx6aKOHLT67OGYakL
 AkEzvDgYYlnAinWWUsb2Ud9Y0ChOLNiWH9U20Ge0/dPyVvdP5tTKQFnP3So3plikFr3O
 49aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2rIAW7N+o9RMH1KFkYgEfWJCRUWbDm5Ndil18wQkS0EIZTCpjYzCWMMaIYZU1FzBegtNsnljOCxzo@nongnu.org
X-Gm-Message-State: AOJu0YxwZIGJw6ZmAyKxtl0EauLKGSUCt3uSl96lcVh5pTN+wiRHcBES
 TNgWfZvGmq144GqY0ApS70w7NWzb8Us4VyvcnqsMRuI3yhU/v9MqLAN21fvFkySEn2Q=
X-Gm-Gg: AeBDieugxHDm9pDMifYyWHMqlaGugzsf6n4IAuwtgflsMPLFX70l4fwWeWYOFSsPEbq
 rRWkwbdHqc9FaBhFo6ZRjCeuVsdqwVjsqNotcNtlPWtqSZRDIbEDYcBmnAYhU6IhbY7jxe3BJhI
 B0N61ZmPIH7DWE///3bY/tnMq5sYiKRqdWWaJcXIzIYhpNib8qAwZO6xxnqnmarIkupLhXNRZMU
 86bf6cJKGzFLx+l1k69f2lXw8/MNuhqPLo0YHBg81mihc4cmsDB+hvcI9i/xwd69K8ZyqguDtB2
 gwF6JnYuTSc0OG2UpVwKZlmeV30SmhCABVAiHcWbVuxoU8snmGA/T97J6hmnbmWQzAY7Jj1P29S
 FH6nmrruO2HIeU9nGmUMZE5c/MF4aBEm4i6kUB60ZfpcQn3mKj/Y0sOL4HQ0upCLud8T8qyrkNE
 wHUaaRGHaBErCipcbt+LteUbZA3U45yce7ZgdnZOx2/wnyP/l6XfMplNzBeWb+B7Kj2Nl9JQiAr
 dAiTT+009WpR0Dept7EdQbqncc69VpB7pfWHQWnvA2szSLjl7N2Z24=
X-Received: by 2002:a17:902:9a4b:b0:2b0:70c8:ccea with SMTP id
 d9443c01a7336-2b2d5967d7dmr82546575ad.13.1776067803123; 
 Mon, 13 Apr 2026 01:10:03 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f08b9esm109858935ad.41.2026.04.13.01.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 01:10:01 -0700 (PDT)
Message-ID: <ff2feba8-fcb7-4c84-83b2-135c396fbe96@linaro.org>
Date: Mon, 13 Apr 2026 18:09:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/27] monitor: Do not check TARGET_I386 to build 'info
 sgx' command
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-24-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> This command is filtered at build-time for i386/x86_64 binaries.
> By using the recently introducedHMPCommand::arch_bitmask flag
> we can filter it at runtime, making it possible to compile
> hmp-commands-info.hx once.
> 
> Since the method depends on the CONFIG_SGX definition, define it
> in its own stub file.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS            |  1 +
>   hw/i386/sgx-hmp-stub.c | 16 ++++++++++++++++
>   hw/i386/sgx-stub.c     |  5 -----
>   hmp-commands-info.hx   |  3 +--
>   hw/i386/meson.build    |  1 +
>   5 files changed, 19 insertions(+), 7 deletions(-)
>   create mode 100644 hw/i386/sgx-hmp-stub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


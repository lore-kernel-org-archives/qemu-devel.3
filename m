Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73A6C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 19:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTma2-0004w9-Td; Mon, 23 Jun 2025 15:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTma0-0004vj-Dh
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 15:11:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTmZy-0005MX-H2
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 15:11:44 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so2719533b3a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750705901; x=1751310701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DHiwJfnthY4SOgskpiApv91qyy0EhaXUMalYCaS82/4=;
 b=tiJAVCElGpv2sjCbY4Xx0s9ZqfPYHVMsNyp3VfC+ylAfaKJ6LmF/NHm5unYJMn1tgO
 jrs+0m25WZLHxPkNE9uptu/SBgR1LlnpRCL75BcUJ/MCgQm4nkzJRe5Qef1i8/P84yJi
 US4EZxBllmZaLm3BgvtcdSTvocQ/orp7NN/6/abI9RTwshQOeXK6DHiHzH8A9Iq4qH/4
 zVuj2gw2p6ggP1cNg7RdFcaIuBw9uBNo9WVTuWTEHpJwvMj+9KQcCYNx21Bb2HBapw6l
 3gWG18VlR02RTzkX9s2gLs9BRbmo0Rm3C6Qw0CXcm05Z8BrfuIbr9y4fnbvr/1reFtus
 2kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750705901; x=1751310701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DHiwJfnthY4SOgskpiApv91qyy0EhaXUMalYCaS82/4=;
 b=LfvRqIK7VdPjorrk03fmXEMkdsCjfZ20S891AgnPgkU3FSyjFDPAz/9Nz4+qY5TCD7
 EljTnqH6aVtfz9MVJKYtTGal++ptOQ4XbBlVGrat80E8srO2U9ALgwUPTn1OaVfTRYtz
 vfK1oapu+XS68zEU274X8I1eUNhfUNVfvEjgBbjitQ8ooscPTj88VOKsCs2D9+SKOE8a
 7CnwrXml5NpLS4DpLyPfeUP6gNtX5ShBMaufrjpcMp7pmSozrvsnU87A05zrNEKgK8s4
 4iq+F+sQ3sVn3ns3hN8WWfX57DoDFfR36M5M6WtN4WdBjkMFk9o2h0TvHkoHlZS0T4k+
 xsqA==
X-Gm-Message-State: AOJu0YziWnLx5xAxxioeEIgL/oIpTqJ9kf/ZEjs9JDE5X02KXlQD2MIl
 Tv6z2LSYA73Xv+Rhd9Yicd6g9PtqD2PwZd+gs4NXXeBgWHs78RAaXGsLeLokZ9GHrsHwwsKzO7z
 2tA27Rjs=
X-Gm-Gg: ASbGncsuyVkQYrnRJHGhpll8iJJlW2KogxxtlB1rgFBPrMCSwyk9aCiecupCrd7Iw9w
 aXCV4paN4PO5pxBK89mW3lI9z9olEldQBHzgr+m8lPpEvSxba80mBKd5W6Yz3NXdy+8MS0X/ABT
 3e8P3y46Zu4OuDk5PZX8hFq8KDHEcb4hqVGqkPG8058Zy931RlWfjsxZakK2o/Inc8H94zHdEVY
 aH2K+0OAUWwzBLk/umM3FKd5KEiKwqyi/hznUyNZFKPcHorCarrrBFTsyulvY1MNzaoH3DSn3gC
 HXSe2zdjL7bYer5LsvIDU+X748F53yJtgaCA4FOMy3EuqywQvi2+GtdpVMbZj2ToOTzjdd6/RiL
 FI/cJnZzLPTRjF0atSE7pMppP60RV
X-Google-Smtp-Source: AGHT+IF0MlaV2DBnZff03sH+K15H2V4EmdbOOuPztTMKv2jtb/5TOkxINz1KccSlFvneyzeElMBV3w==
X-Received: by 2002:a05:6a20:9191:b0:218:bb70:bd23 with SMTP id
 adf61e73a8af0-22026f11d79mr20523162637.42.1750705900791; 
 Mon, 23 Jun 2025 12:11:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a498b5bsm9262482b3a.54.2025.06.23.12.11.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 12:11:40 -0700 (PDT)
Message-ID: <f8b6c667-d105-4852-a4ba-3d86e603823b@linaro.org>
Date: Mon, 23 Jun 2025 12:11:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: fix resource leaks in gen-vdso
To: qemu-devel@nongnu.org
References: <20250513150346.1328217-1-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250513150346.1328217-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/13/25 08:03, Daniel P. Berrangé wrote:
> There are a number of resource leaks in gen-vdso. In theory they are
> harmless because this is a short lived process, but when building QEMU
> with --extra-cflags="-fsanitize=address" problems ensure. The gen-vdso
> program is run as part of the build, and that aborts due to the
> sanitizer identifying memory leaks, leaving QEMU unbuildable.
> 
> FAILED: libqemu-x86_64-linux-user.a.p/vdso.c.inc
> /var/home/berrange/src/virt/qemu/build/linux-user/gen-vdso -o libqemu-x86_64-linux-user.a.p/vdso.c.inc ../linux-user/x86_64/vdso.so
> 
> =================================================================
> ==1696332==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 2968 byte(s) in 1 object(s) allocated from:
>      #0 0x56495873f1f3  (/var/home/berrange/src/virt/qemu/build/linux-user/gen-vdso+0xa11f3) (BuildId: b69e241ad44719b6f3934f3c71dfc6727e8bdb12)
>      #1 0x564958780b90  (/var/home/berrange/src/virt/qemu/build/linux-user/gen-vdso+0xe2b90) (BuildId: b69e241ad44719b6f3934f3c71dfc6727e8bdb12)
> 
> This complaint is about the 'buf' variable, however, the FILE objects
> are also leaked in some error scenarios, so this fix refactors the
> cleanup paths to fix all leaks. For completeness it also reports an
> error if fclose() fails on 'inf'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

Queued, thanks.


r~


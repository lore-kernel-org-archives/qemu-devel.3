Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626BCCCD182
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 11:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4eNS-0000uT-UC; Fri, 03 Oct 2025 07:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4eNP-0000r2-OL
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:55:08 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4eN6-0001nx-TN
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 07:55:05 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so2123849b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759492476; x=1760097276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GM1v8WKUlQvcJItATHvg4vyybmkegTOyo+dMKSH18HU=;
 b=Or9A6jOhfYsPu5Iys37BSHGiMTdBYUjDnbrG1+7f8P4I+eDN6Ndm2pgbiuw40otuCy
 91LGr7wVkZ/Fr3C0Wg29crDKGmPltQJuFkfw63YaFHMG70//V5Fuf1omrC7wlK0CUHUg
 FUGZsXX59IojLlbhwoRn6OL7fkq/VaV0qzOOF8MCXJqgaR0t22AXIDqngqRrmh+2VCi1
 f57GD0Oylt9/t4pQJ2Na3pxVAVz8+RjNDyuiDSTUmJdC97/Fq2xkCz2IzJOgt9Sf++jU
 ak+QduA5a8C0DOoEoXpdLY5Bp50z4fEvZaKO3mIfb4eJ6GtSo1mHoLPenzHOeaIgAr5B
 AVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759492476; x=1760097276;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GM1v8WKUlQvcJItATHvg4vyybmkegTOyo+dMKSH18HU=;
 b=sERtB6ySelT83al5poV7jA8U1BJ9JyqiEUUF9QERbis76GujubPxWxzLhr07k9mucO
 2hbYRv4kFbHaaXtHWMjaTGC/vE1Tc6g5vIyW4SqeWqTX1jojVj+h7iFV0W6SUAmPhUlL
 30c43L3+QHcxXmJm+HfD+ZttFmJbaDSc1O0Mt4IHlqUDQIBEndACJJsqzRCq1AwO7ao3
 8wHDj6p1IYKDUfDulKM0cYXl8PiIs3CFdyDaJFFcRXbo4206hXo2i2625UeBjzdhdk8h
 GgNEBc6pmPNPXSyiuy+WGCVJ6uYI03XpAASbDRPMP8g/LqVgrP1GpKolJ9ukGTwFQq7k
 gc4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH5wbbRqik7R3396wlbgJozDpWCBmFlqtCK0Izo/B4ZrCOi6tvzofCrakFLAsrN2PCdGQvlUcq4AiI@nongnu.org
X-Gm-Message-State: AOJu0YxWg1gBoWQo1rHtalwhVNqY/UFgmi77yR0m8iYmAultTY1mM4vu
 ZWF7Xpa6DOv+mk04oDkhQIzTn6r3R4A/bg0/mJZRCdzHpYYwD03AY7gM21cNOho5jvU=
X-Gm-Gg: ASbGncvE/5r8m7aMYAlwuqkd2JCNBxChcfqG5O8F9MOpEWZtiSJKx355c1TleM67DtG
 yYrt3FflBQlvQUuAV5TWDy5AeetgM4uT8+KrQxG6+LQm+LpurNVAVJKFE8oVcmGLvcWhPSc0X2H
 qk58Jt22fzXUVi1f+IR8ZyKRh9nMmgYa0oKdVbF5od/f3Ln+m9dZufOi0Y5sxq2AAkypY8x5Wfl
 3xQGKs+FGlExqo+5AheNIZRIS+/GrbaeSecVl7AbRQgKV5GVhTAkSDeqJCsBaDd7yblWar6vK9S
 FwyKCi/0S4lfjhMiGbvWzs2iT881kiv/SA/DaGwKd3Q3GrifGyj+0rw0sjISCesSZA/W/Bc5LKu
 BpXWMWeDrVhQZ3eWR3YeKHjNFD0XjaC1NduUF4IgNeYPZ3gxQzkc3lSLC7ZfpjyStfvBlbIqkjp
 Q=
X-Google-Smtp-Source: AGHT+IEiYxP4bFrykUsS9cJCvdGwTtMlo/w4SFF86PvPdi4nRpJuP9R4QVlbDB1IWMU0zTlCXsjVfg==
X-Received: by 2002:a05:6a00:94a7:b0:78c:99a8:b748 with SMTP id
 d2e1a72fcca58-78c99a8b97bmr3367778b3a.0.1759492476437; 
 Fri, 03 Oct 2025 04:54:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01ea8cb8sm4811598b3a.0.2025.10.03.04.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 04:54:36 -0700 (PDT)
Message-ID: <c0fddf6d-74dc-4992-ab70-0d3da2da5584@linaro.org>
Date: Fri, 3 Oct 2025 04:54:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/13] Error reporting patches for 2025-09-30
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20251001065122.575596-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001065122.575596-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/30/25 23:51, Markus Armbruster wrote:
> The following changes since commit 9b16edec6e9a483469c789475b2065d26b52db35:
> 
>    Merge tag 'pull-ppc-for-20250928-20250929' ofhttps://gitlab.com/harshpb/qemu into staging (2025-09-29 07:25:28 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-09-30-v2
> 
> for you to fetch changes up to bcb536cabe108e71e2900cdd605f5b4e59ac3e1f:
> 
>    error: Kill @error_warn (2025-10-01 08:33:24 +0200)
> 
> ----------------------------------------------------------------
> Error reporting patches for 2025-09-30
> 
> ----------------------------------------------------------------
> Markus Armbruster (13):
>        monitor: Clean up HMP gdbserver error reporting
>        tcg: Fix error reporting on mprotect() failure in tcg_region_init()
>        hw/cxl: Convert cxl_fmws_link() to Error
>        migration/cpr: Clean up error reporting in cpr_resave_fd()
>        hw/remote/vfio-user: Clean up error reporting
>        net/slirp: Clean up error reporting
>        ui/spice-core: Clean up error reporting
>        util/oslib-win32: Do not treat null @errp as &error_warn
>        ui/pixman: Consistent error handling in qemu_pixman_shareable_free()
>        ui/dbus: Clean up dbus_update_gl_cb() error checking
>        ui/dbus: Consistent handling of texture mutex failure
>        ivshmem-flat: Mark an instance of missing error handling FIXME
>        error: Kill @error_warn


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


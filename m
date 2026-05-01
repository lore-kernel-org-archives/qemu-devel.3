Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68B0FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkVn-000353-3e; Fri, 01 May 2026 05:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkVg-00030J-HF
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:50:13 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkVe-0007bE-QO
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:50:12 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79ab5fd969aso20905927b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777629009; cv=none;
 d=google.com; s=arc-20240605;
 b=aKLLlrx2hda6XoxvSAkS/84YF1n3zsHGQN2UkDaaZXVXZjuI89bwKFFlvsukgHwClU
 Ivi7UoVfZl/f2Oi/QFegSE5wapfB48GX6r4+C5Ut+HL+ulCc2jHXfqr3wlICUohUXv5W
 NfjzbUF/2N3m1RRsNakn0WE5j9ROZe67WecCIt5sgXkJu4H2h4d+etdVVJu1ZE09JLZu
 u8VaWvSr9hpusmdyyUjT+k6PRb5wzzpK/dQcjuzXKOryYfoT14EzPmOOKw4wOlc9tSeG
 pAqX0yhZ6NwAXiNzVpAsxZ/bI387hGf1JAL7gUVdWUY+VSobNkgkd3FJC0/F92cylh7+
 SEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hIWpiTawUseQQPCN+9bltXY0EQ2B4/qK0zGFjkzJBcE=;
 fh=67FIEAxCuvQIamkfYfieYWW8UW8BrMCsPo5FDyEN3kQ=;
 b=BS4LFI3192/5w5oNBZi/v75bAZHR43ISPduTJXmoL18q9SsLxvFqN0xTCkaUYsosFE
 O4JTUycSukfNjvkOSEKsOFyWJvNlvr7Lljb3jYWnsEJleGCRhHl6+AbpkOiw4T7ADvux
 EazhxnL1xnM4zt9DiVu5vz7LryYMJ8DmPRf+YwlG+04tgWXVDWZfqJfks71dXZxU9Uzd
 +1SRa9hJNFqv4ER2u2dtVMcmTMNxQsELiikwVLFJFW4S4mvefTw4WPa36uUjeZaSYV75
 bmZFtPrEAYhAygjHlUSFvZ3ABoGrsO7eQU46EusIwVu2S3QwwM3DIooxI7N49SxieRbv
 /75g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629009; x=1778233809; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hIWpiTawUseQQPCN+9bltXY0EQ2B4/qK0zGFjkzJBcE=;
 b=LFZWR8Ky4xs5ylmoMMr2cskrZz7YWD5xE/Mb54SRfKvhKBTNKk2EU4hDgcmWhs17qY
 +diFi4tJyHzMjJGHta5BX4M1r4TTMuELjVzvdNAJzZIf0/HbQF/rseSB1B/wouA885SF
 1Q9Y1k+SFG5tOCrsp4ntYTZxD78jNc/pIhLkkeVzHuENCODUj+FuL0ykGjnIqfBdoQNV
 yIdL/AZGZfdboFKpWW+OxZrpsRm0b3CZeojnbFRTh5N4V6kmB+MQS9Q8FnHBhZ7eSO3f
 z9hvAj558eSHKdcv6Es3ff8kPWA8mmoeP9YnbfA8RVYzEbanGODaqWCE1pWOHrbaNsIy
 9mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629009; x=1778233809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIWpiTawUseQQPCN+9bltXY0EQ2B4/qK0zGFjkzJBcE=;
 b=Cxj2Fg3/T8nY/8oVpPxSgZsQdk1oyQYbzaFS4i/xcwhuRTQhbOGF6Hkj+8/N1R+uDi
 3iZ5gCRtWSFIxb/6uBZ+E1hpMIYmZYcd+d4JilYz0MPe7Ot2pWplLbhwfLXANqs31XrI
 34IBj6G7/ibFHQkzt1haWDY2oDnSSAm4JwEPIVyVFU98Gadat9xgwjY6Bl9u9p+cMeyp
 /R52lYfz5mj0VH88bohYS6iBy5uHmM8MbUyQ1ZA/PX95IhkJitrPSoJCMsIiiMjn9gHN
 1hOcVj9kjMbqQ5UlajYfpzSo1wJuMGRT0tV1YNpalBnDnl53YUcQYr9yFRHpZQaIXBM2
 WAsA==
X-Gm-Message-State: AOJu0YwQZrNx78eSfOty7aXALvxo++bjGFjvDopn01QpHQw+UeanabvS
 czhCg6aVjJkTtL43k/qUtc3up1G+U7AzRPl8Z6RHbW+niS+O/KujKsHujIJoOYd8lYXrb9dVsMd
 ncCIQlcD2JeAFdbes89ckNg0DCFcb481rUxiLg9B9rg==
X-Gm-Gg: AeBDiesjBb6m8g+WNLQ3LExcaBQ1/WvniF/UN5PXI4mD7iixOql+R074BXaSSgROUWQ
 rc4I6Hi2vMBdZU9h7S6yt1RbDrcd5LhMo/CIcoaeFKhoQhJS0St9ktJ2LyQZYNQFZdO7Q9uCrIp
 c5nZvJ80No/0VVe+waU11zT2blqQK51e9NjSiN8/QrH81Sn3oWHA394ED/ZTpXoLnoFU5zGtBph
 sJMdVAdeKxvofdX1p/wmRiGUPNG7EofHWANCVwlkd7SE79GM8K7FY9lTDe0/Q2O+LmEUx/1g8QC
 BpqnE+QMyP2oy/Zja9bKwLEzAOoFfgMI59Ci4XKxmkGHXP8GrCllSbfKHimeUgY19XOQqnnlhuS
 K7g==
X-Received: by 2002:a53:db07:0:b0:654:6a61:fb5a with SMTP id
 956f58d0204a3-65c18aedae4mr4030050d50.2.1777629009103; Fri, 01 May 2026
 02:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2026 10:49:56 +0100
X-Gm-Features: AVHnY4I4HtaW2t8cz9v0J4YSOM_Gp0HgSC_gzLnG8im95OhzidTduIqee8IOS_Q
Message-ID: <CAFEAcA_Rq+ggHLJEAmviCpTUfK8opcJ9B0wpD-WacbS2GP3abg@mail.gmail.com>
Subject: Re: [PATCH v21 00/15] HVF: Add support for platform vGIC and nested
 virtualisation
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 29 Apr 2026 at 20:05, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
> (tag for this submission: hvf-irqchip-and-nested-v21)
>
> This series adds support for nested virtualisation when using HVF on arm64 Macs.
>
> The first two patches are from the SME enablement series and are present for the
> series to be buildable on its own.
>
> It has two parts:
> - Apple vGICv3 support and necessary infrastructure changes for it
> - Nested virtualisation support. Note that the nested virtualisation implementation
> shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as shipped).

I've reviewed the last two patches and applied this to target-arm.next;
hopefully it won't get tripped up by the CI this time.

I had to fix a few checkpatch nits -- it would be helpful if you could
run it on your end before submitting patches. It has a bit of a high
false positive rate (especially the "long lines" one it's often better
to keep the long line than make a particularly ugly linebreak), but
things like "open brace for function definition is on its own line"
and "multiline comments have the /* on their own" it will catch.

thanks
-- PMM


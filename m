Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABF0C04FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 17:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwmDp-0003Xk-5o; Tue, 16 Apr 2024 13:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwmDn-0003XV-Q8
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 13:03:51 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwmDk-00025M-5g
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 13:03:51 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a51a80b190bso303769866b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713287026; x=1713891826; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RU+dh6HWh2B9Bq5iKXDPGo5Q7sfLGmeRAxp+Hf92rRY=;
 b=CR1mNyn3ThUEacG5H006YrDL8dlkLPZp40w64rxdKo0x8Z5ctvqAacqKblI9ocfFbK
 SxA7dS/sD8B4bRMQUh6b/0WtlwJWEWPtjWJEKjtkmc9QCZUu4OWRbxo/s7hj26AFgqqu
 LlH8yaIBnBvbBRwmS4d3AEgeNbABg18tA9vAmK+U8A8KuVvxNbugkjKWl/xmzKuTGczm
 ZhC62VBNtZfNsi+xCliFOpJDfh56TwGwcM1NdvJD6ziE4YCTrBkagb4qzUobEiRnTE7s
 RzHRWCzl2nSAmP0S+FO3xb5mdghi9zYl5o69OAcsGKOIshcPKZ+SVUpkAAXt0EBkB+tn
 oW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713287026; x=1713891826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RU+dh6HWh2B9Bq5iKXDPGo5Q7sfLGmeRAxp+Hf92rRY=;
 b=K/wVg02J6+WAQBAwwJHiuuLL2hV3fBufapWv6lKRfQt7NrWomx6PEHlScBMzLpUZ3g
 SJ+lmJncsHnIXTiC6wM5yQxaYxtIgnSfA6rVZIfO+cRbeEC/WewBRRjbylmtJCOith7s
 AL+e4a8B1QWBrcdNMbGbaUGAnZII379hlPM+YTJlkUoS2YmQ2mnw18snPNEAyRE3h6nx
 xHQ8XQiAegUdkYOrapNFaQDnD59TiCpJkrERCSpKur1LM3cm5gaWcW3nc5W9P1fEl4K2
 Df9BYetgOROaXbmvH8S0vhq6AeHNgeb660yeqzD+M0odBBOazyJEgJAr33emSInba+9k
 WfUw==
X-Gm-Message-State: AOJu0YwBaefmS7Ijusfs0+yIuOrRYW+vkEmHfVdOLojVRMsnFGR2N1E5
 G/2M1GIqbVcpeMadSEhVpw723lPiMMM8blQ36KKQ1uGgTjgJurOeD/sPys8Fc01LblqIdz+ig+8
 EXgIJAfQsup4W8RNDOt3DMIjyOjyYzvOsQXDsvA==
X-Google-Smtp-Source: AGHT+IFyN6eUTSXd2uHMQpbN8xmXp8Ye3t+qPXsqDdH7wK5c4+gdyOE/b9tI3ec46N0ZpEtQTyPQVkrDzUnIB0bCAcg=
X-Received: by 2002:a50:d5d9:0:b0:568:abe3:52b2 with SMTP id
 g25-20020a50d5d9000000b00568abe352b2mr10013789edj.23.1713287025663; Tue, 16
 Apr 2024 10:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240415160818.2316599-1-porter@cs.unc.edu>
 <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
 <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
In-Reply-To: <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 18:03:34 +0100
Message-ID: <CAFEAcA9Fe8TerNSrg_AfmpFZNL_4B9WV0OccFdLakJhtCN+m4A@mail.gmail.com>
Subject: Re: Add 'info pg' command to monitor
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, dave@treblig.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Tue, 16 Apr 2024 at 17:53, Don Porter <porter@cs.unc.edu> wrote:
> There is still a lot I am learning about the code base, but it seems
> that qemu_get_guest_memory_mapping() does most of what one would need.
> It currently only returns the "leaves" of the page table tree in a list.
>
> What if I extend this function with an optional argument to either
> 1) return the interior nodes of the page table in additional lists (and
> then parse+print in the monitor code), or
> 2) inline the monitor printing in the arch-specific hook, and pass a
> flag to get_guest_memory_mapping() that turns on/off the statements that
> pretty print the page tables?
>
> It looks like most CPUs implement this function as part of checkpointing.

As far as I can see only x86 implements the get_memory_mapping
function, so once again somebody has added some bit of
functionality that does a walk of the page tables that is
x86 only and that shares no code with any of the other
page table walking code :-(

thanks
-- PMM


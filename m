Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5D2CF34A2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 12:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swKXF-00016j-30; Thu, 03 Oct 2024 08:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swKX6-00013d-6u
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 08:02:13 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swKWt-0003jT-EG
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 08:02:11 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-537a399e06dso984845e87.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727956917; x=1728561717; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=miVKMR4+8TB0V0xL2jTpdCXf/qy0jYYmyQBozO4nE6E=;
 b=yqI710PjO4W0VN8zecuX+65OjRHMCswCmC9TfqdDsZ3pNMOJWqEf1viGQjXTXlHzM1
 lrHt8RSVTaoJ5FDkN7cI1UH6Dncb0dwF3ewEX52M4Z0tKU0YhfvqJ4+xkhIDQOqUNQHx
 vhTMTWql+t+RJoD1vtYp3f9aj+J6U3e4FfhW8WGzizhqagSwsXZVgwt/N5a/gKPGg1+2
 5RnePaHe9cF6durDtZrejURGE/yMsx19SsSBJDr7D5qrwAuGXw/Glo+xq8LbfDP/dI+J
 EexPVIy3HRU77zz4PUNFqQTQoyI+UYHZb3ihe519J1LKyX87yS/uCzwrmT6gHdhlLBBj
 6D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727956917; x=1728561717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=miVKMR4+8TB0V0xL2jTpdCXf/qy0jYYmyQBozO4nE6E=;
 b=QVTAySnZqPvz3dGjAiXYO5Q8te9IBTjx3VyEeYUGxStz5yCxwJVgNvCQbG3EmRjD37
 oa+eOpf+vekkl0BfeLmzXl939wJC93tMLZBx3RZIiyGGd0SjHffZlm2feBt048DLUeti
 jTJBg4wpW0uk295TKIlDNUI30Rhx8H/4XArNk5EnxWQHQH8wUOkOjrGwTdKfzsffPpxx
 kIDAyISlBHEScQhOpiiEJChb/glK0A+VqfGxOMyyuKaDK1dXxuZYkk2iW6K3FnwRSvZS
 yiI84UEDzdY+LzX2A5ShMPkl9lzXCSgkXdQ2vhpcq+GnocUQwBDT0h2nkXAMr3a7ZaLu
 7OuQ==
X-Gm-Message-State: AOJu0Yw5Rd4tAzZNDzkzAb1gCcQDLLzBkROJSqArHW9X/rcwU/eDYj3s
 tPTydgHxD3dzkqnu+ObmoUl6QZIOVaPi083wmX4QMHRz4Mch1omroBNUT90/7PQOp7YG3t/PBti
 Mse6GPO/t/Bq7mnhDOVm/9roZCzHttGenGEmjxw==
X-Google-Smtp-Source: AGHT+IEHw1waWpAg1uh/JxTUwqahQsF4DuhddXwJ4yqyg/yUa00qkCgYpZpvK8fq4wVincFAL4O/tWS9x1m5+siRUmg=
X-Received: by 2002:a05:6512:e9a:b0:539:958f:1b8b with SMTP id
 2adb3069b0e04-539a07a8926mr3803345e87.50.1727956917110; Thu, 03 Oct 2024
 05:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241002074404.1983368-1-armbru@redhat.com>
In-Reply-To: <20241002074404.1983368-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2024 13:01:45 +0100
Message-ID: <CAFEAcA92__1AJuTiW2z5rA5pKU4_sx2pW3r208=L5+x1NtGq0A@mail.gmail.com>
Subject: Re: [PULL 00/10] QAPI patches patches for 2024-10-02
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Wed, 2 Oct 2024 at 08:44, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:
>
>   Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-10-02
>
> for you to fetch changes up to b3bd7617dbae8e5f84c27a1ab8df89cba371a276:
>
>   qapi/block-core: Drop drive-backup's "Any other error" documentation (2024-10-02 09:10:01 +0200)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2024-10-02
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM


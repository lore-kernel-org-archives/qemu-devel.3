Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE44BFF60FB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7WAp-0002Hr-P1; Tue, 31 Mar 2026 06:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7WAn-0002HF-D1
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:18:13 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7WAj-0002pD-IL
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:18:10 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-650158138d9so4370884d50.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 03:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774952288; cv=none;
 d=google.com; s=arc-20240605;
 b=QcOIowpBhUAdqernA3oDPGPBYTydW4VGjvcWuzqEwBgMfEAJTEuVja2hBy6ib3pVU+
 zdGze7023K94WGxSv217YT6CTI6qOhnfUJC4+QQarVJpTwYo82P8UFOMlC1iRzpI1Ujr
 Kfyfv/KMMU6PgySSlSYH8eiSR0nu04dKbNDbxzWxWBi3DttfI+3uWumP/h2zgVmVGbG1
 4v3OeaMq7DLmgsQWFYznrVsfInglMpOpQ7dKZ08U8Cax0KlnqcVEod1JHpkhKwWo5IuV
 ii2Z/EGEAC09n0D+Gd48kc5m5dDUZfiZmRhM9K5s9bDO+8Ebpeh43ZXWnasCGwBjdX70
 dT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/V3PhvmSWLWyM96kXEZpy8XeO2W85Xd00AGp1Hc9D1k=;
 fh=6kJ3CohSxQ+7EgnARanNFMAgatAnP0uu5SOkx3O7QGs=;
 b=Qea2iPe8IVt8yBQjJfvqy5PA7Na5nWgL4EzDpeicte4PHk/2BrdTPCduUYE2sOyr7k
 D2K7/ad6EQA9/O782rnY7UxoaD/+ciyewDmY9V6jO98HocNH33QhlS4BsCXJrfPrA/LS
 +7gofQKBUBavc7T0CXhBJJ4zkQk0WHb5G9Hk9qg9Hrsty+bRNH9Ms4KJOsypzmGnLzK3
 1PpOu1dnp+RBF3PCMyprE/8A6MWuUHo7p6NT282K4Z9QHMhcUsr5b9Bqp8uA0THnC4EQ
 60YE8LXrM7EwEvSkPvc4/QAu996yVQibMlax1AUMqVnL9ybwJ/bf+zyrgT1ZQT09Bv2w
 zSNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774952288; x=1775557088; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/V3PhvmSWLWyM96kXEZpy8XeO2W85Xd00AGp1Hc9D1k=;
 b=dpepgS9aMMisrbb/hmwUGK561/aMB7udNyvmj8QEWFVs+Taw1cIuOGJe5AGcWOkq+7
 oZ27kd1DD7Z9n3JVuUn0SvHxGox8S6pc1/P04QHPuc1+y5U9HGHYFMc/8SQuLYKK1OqK
 +gt4J8DO6LHI8lBubtMrK07oPvNAxHYxC7z2cUOIh7fOnDfkPe+wCoUXqhxHkHgxJ8ls
 oulbgyTAMdJuM39NVXEtrAK3FkOtsXNQ1e3FEAXbSl8n0Y9/kKKDre2fl+v67GgjyhgF
 eSyphy+3iDbNLAiYDrrxNKGbDY4BBFGEcKTXsiIpBRBrc0l4HKqJ/C9hnEraboDDiGYE
 oSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774952288; x=1775557088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/V3PhvmSWLWyM96kXEZpy8XeO2W85Xd00AGp1Hc9D1k=;
 b=J79vhdKqkppNZ1pKPt/ykihpDLGqowK8rtqP/TEQBnXSQxPz5K3fm+DGlcDo4maIt0
 FPe/ANsUcNzbpB1zhczP/PVgEOBDwS8IdU59qmjpBXWK3ZRzNXeeSR4Bi2Vq+n5MePBO
 gA0cvCMVX1pkaNI5V843zpMMoHuxNjj2gO/MyQnPL4dhXSvdYJV7rqSWCU2o0xQLXPB2
 +GsGdPv1Fjj2RRpj+NU733ZuP9fA+mvOeNyhanVlg9OVYZjrN2CLEmihVxA/F//MersW
 6Q9qSzWOa7wb9l+RT1NoM6xdvVSj31Hpg3YzpuPx8j77paQ5G141j+u63k+6Q9+Srzrp
 YL6A==
X-Gm-Message-State: AOJu0YyHyIag6c/BsUllnIy4mylyRydFX1LaLFE2EotJFzKhB8HVOwFX
 uYdFOU/MqPV8xLuKg5dD0Av9eYH2CR0c4WAQUWa7ME51Zaw/z/TzUJM8ZnICZRKw72IIvgy76PN
 5NWzIixztLgtjkiyQQAJZl2tcFn5XIqvsPwTQeWnXiA==
X-Gm-Gg: ATEYQzw0cyR/lrlDNeC82HZEkX73cuRHjEg4+pOzcoRI0GStOxbRMlNk3okMqDfYkue
 ZR01w0Jkqz0YkPHGfjlpHWiBYDmDuyNxKT/Qov6qKTOwD4fXL74fP+VrwH0gD3NuzblXufMqbvS
 lBowXxp/lAH6OEAqOhFeVIp4170CYxRzx1Vz8QuwftqNxUqRq+RSmbpMnLcDXvALIWFibDH9IQM
 nQ0tfpCiTGly5M1gFjZT9aN4IQf3LXJQGO6A4h/ZeUCAsOkiFPUOz7YkwB7RW5IiLw4iLgEuhaQ
 WEeYRe7NvqVMw0JovwbyB45eT/ABPuCNCd9daCzf8qlt17nH6qkDk+3AFkImNthe5/E=
X-Received: by 2002:a05:690e:14cf:b0:64c:b75d:4ad5 with SMTP id
 956f58d0204a3-64ff742f898mr14825885d50.69.1774952288196; Tue, 31 Mar 2026
 03:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260330190508.8634-1-farosas@suse.de>
In-Reply-To: <20260330190508.8634-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 11:17:56 +0100
X-Gm-Features: AQROBzClH3JNYZ7YLsh6GtuZuPDlXchdmxj-tpXiNU7DE9__w5v4bySbqz9_7nM
Message-ID: <CAFEAcA90+_PMed6NS=owFsShxPitPkOmEVY7kOdgpeM0YABqmA@mail.gmail.com>
Subject: Re: [PULL 0/3] Migration patches for 2026-03-30
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 30 Mar 2026 at 20:06, Fabiano Rosas <farosas@suse.de> wrote:
>
> The following changes since commit e389503e73f1726c997531447288ce154394d07a:
>
>   Merge tag 'pull-request-2026-03-30' of https://gitlab.com/thuth/qemu into staging (2026-03-30 11:50:24 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/farosas/qemu.git tags/migration-20260330-pull-request
>
> for you to fetch changes up to 6f33b6eebb7d406871150b0285c36454a1b4d0d3:
>
>   tests/qtest/migration: Fix slow test dirty_limit (2026-03-30 10:48:12 -0300)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - Fix dirty limit (-m thorough) test
> - Fix a few error message strings
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM


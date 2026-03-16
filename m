Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D10F506D5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28rY-0003uS-RR; Mon, 16 Mar 2026 10:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w28rX-0003ts-2F
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:24:07 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w28rU-0000jQ-Io
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:24:06 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79a51edef1fso11741637b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 07:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773671043; cv=none;
 d=google.com; s=arc-20240605;
 b=JeGGlTwJ8PWg2oTNfB0aQ823J6o9ehvLFcxDbeTTF5J7wr/eDkdKpdJWZMP8CnYszB
 lJ0xtSCL07aaguoE63EFwegBk0kE37A0/mBqxdEsOhIakwSp9qge7LloInVSA4jJnyPA
 +9nrAqjDe6O7kgLGk6W61AggvvxQWkYlDaaKOBg3ZmlB4hGq+1ccCxsbe1dlfYOEgUAd
 3MhWFULpR2VLduE37OZLo27eZxfrccfWal837S/B82Xd1gYaAO/Y3QeHgWdCJlfhmnE8
 BERRzum4Yo1e1ab6sDTY/1n0yuCkVQbQW4zqhOBwkRD42nzelM5JVlIjLoSmCbnJ1JR4
 8MRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=/HN/wjCxiK4/24f8DZiXfMoiv8URbM3hPtbpytOkDaI=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=Odt3tRVdwoWnO3Mp9nIp/ykxP7oQnt7Pk7Cmd+H89tDjnm/jRwfnzUPrHpCW1IXU0z
 fi5JCHh+qEp0c0dxUqBSDRESCKb6zb7U9Q+DgymNYO91hxQKlvAvjiF07VO3KqJqVtiN
 HztNUwWxDx/oJ0PSBV/3pVHLDLs+3WQvx/UdYeo3OeZ6derhZJkZb7eD2pYcpEXd7a7Z
 aZA+h+IHlYDUff5qfDoYLeFQLyHygIgxncS+/EgBO161Wm+jI7BlBxf2hlx0EWMNMxiH
 uHZpIIYEXcdKdPCRJ8cSXKghAOOsuluzVz1xHwATJnR9JiB28PuO8EcS8VNR2AlBmVqW
 1UdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773671043; x=1774275843; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/HN/wjCxiK4/24f8DZiXfMoiv8URbM3hPtbpytOkDaI=;
 b=H13o4fYBw2jC8pggubJrvrGpKyE+1A4NuW6cZ2khwVENHgfVy1HIbx7ClFAL6QMO3f
 dlkc9ePgyK6y63XIjnXrrtPvU4hEdejUB6J0X4GRdSnXI3wSdNp6i33h9e9JGFO/+Asq
 64xi62r6H3SX++9S4r7ANwlPOnAcRs5S2YHlyQFGGrybtRIJ/7wHFcUXWTZcnYD9wQZz
 NTA5iT3Sq+j1MU2bDKyEbcj3oIJ4XJ+sCXNQ0YHWOMVI2tyN8RlsbdzEm0ktqnaEJauO
 g9OJMWu3NfkZmO+Hf8rIRENtJeEkOiqmriH6RC+etJ5c3vdWPDGD6mopJ6bf57v7RXtH
 kjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773671043; x=1774275843;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/HN/wjCxiK4/24f8DZiXfMoiv8URbM3hPtbpytOkDaI=;
 b=eyOxWTIQSdlT089sm4sXvq0JdOt2LKNeYILtMxYped0hYgwNoQ1GqIwA25PdkUR18j
 jbjmnmHkprXY4/Kv2mHojff6kxyk7SzXwwnlAIpazAUqNXYyo0FwpIyab442qcJvEJwD
 ceEY3diZ5VLN2nmZciCbjQd8yW4ui207NzZBVkIN3TLEsBPEnjA0FgdMFzuaaONPH01T
 iss1cFjM6zUaxK2/iGKIYwR0LXiBw7y1p67LfLzSGQ+KkX07+CbfbYvsLZ2Ui3OjrjdE
 bdme+U0/9WcBQlbkYl1B8rGGQQOPLbjq79Cn07l9BIp541OzCIItajCdkicyvtiZFYmI
 tbyg==
X-Gm-Message-State: AOJu0YyqkM827W8aAL+XRu5JakQA55eleP+J9bWY307zi7VIJA5bqtko
 +8DlS4oMgSpm3O6sTEFI53GD9LvjMeJlwXRnDtY36s0RILsoItuzP68RvHpmnz4sjzwTpgZuKzy
 OEbFkwAzH4FCjIIEyj1SoPknKc+DVZf9RoEv0li/JQMkclPt4yix9
X-Gm-Gg: ATEYQzwQwJFdLvFaS4Gfa6PDWOYa1v1xGQUwIIVux7oZ1LId05MR6h7IeyHVDESh+5U
 s86zT5zPm4me1lkcMQsBbOD5kg+3TZjtVjGkq1d2jl9IRGTxs3k1Vf7n8Tzfe5fh4c1bky5hPa7
 DHP6A7AoVxFmJs6SHdSBPBdp+tX7/st6u2P7imKF12V5Q0ND4rMYfVlWfM/GHCimky5WiNssnxC
 jCP810orE2s3yOQgBfajq6ynduYpTmQW+AfCA0IUTV/q88KSs3ZM64N2e+kxnjH+zGEgw76fK/x
 xSfwIuWYavUu+fA/Jo9fjlhhFtK7vy6ooxaWst6ylu013jQjNgvBfamge9rFBe193vga/Eh19pn
 4qQ==
X-Received: by 2002:a53:ac8c:0:b0:649:4f58:5cd2 with SMTP id
 956f58d0204a3-64dbcb5e3eemr13940344d50.0.1773671042547; Mon, 16 Mar 2026
 07:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260316104230.836962-1-peter.maydell@linaro.org>
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 14:23:50 +0000
X-Gm-Features: AaiRm52Q2IX45wL0_2qyLJnDIKZzyUhkGch-Zu-qHZi-CWts-6UXZDecBBkcgTg
Message-ID: <CAFEAcA-ut5Md3cEjxogHEuPx_yxR0tN7G7EVoJMx5WJn5GX=qg@mail.gmail.com>
Subject: Re: [PULL 00/17] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 16 Mar 2026 at 10:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Some arm changes for rc0, all fairly minor bugfixes.
>
> -- PMM
>
> The following changes since commit fff352b9b6080e580aa1fadd29b4eccf4cb2922a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-12 15:21:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260316
>
> for you to fetch changes up to ed44618b8e6cb394c6b9d3642d9d130b46b8457a:
>
>   tests/qtest/aspeed_gpio-test: Use g_strdup_printf() instead of char arrays (2026-03-13 13:27:57 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/net/rtl8319: Work around GCC sanitizer / -Wstringop-overflow bug
>  * semihosting: Correctly byteswap data when CPU is in big-endian mode
>  * hw/dma/pl080: Fix various minor bugs
>  * MAINTAINERS: Remove some no-longer active maintainers
>  * tests/qtest: Use g_strdup_printf() in various arm tests
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM


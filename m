Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFE0EC047B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxLzL-0002Jp-Ka; Tue, 03 Mar 2026 04:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxLzI-0002JZ-BB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:24:21 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxLzG-00047U-CJ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772529845; x=1773134645; i=deller@gmx.de;
 bh=hLtFD1dUqUl6cJa0Xytf8Rne6E6r5wr2yp+lhLxPJBM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ADs1gspGioNBKIQTUFk5n+dqtQtUzwFIPBaOPsJJfEWrCUcuTB3lfxsA+ij/hOMO
 V4wSyf6ZecIwkQVa2vVSkhN/wWMOtNgfXXDXSkKW0DlsCdyiR0ioa6KaaSHbyYeYa
 oo2Y/DzFZ/BWpVTzIUaJNWGiz+N0eYEVH6OJCl3WwOi1ZIJCKnw8dqGks6jlLw2wT
 onyFluOkaYNP8HTbbTgEuYKr7KNMXr6uOQy6En6zOa/h9JSvnPgntL55VuJIXxijY
 VffMQu8rENKv+xr/30S0QL6IiHMRmtupoMLFDtpbg+eaItjW3LoO1UNHUUgdnb57t
 ay7dMiKZMuTBjhGhJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1vXOpv1z4A-00wmsV; Tue, 03
 Mar 2026 10:24:05 +0100
Message-ID: <c02eaa1b-93bb-4ab4-8bab-68ca3681844c@gmx.de>
Date: Tue, 3 Mar 2026 10:24:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] hppa: Restructure CPU Class heirarchy
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
 <20260302-hppa-c3600-v4-1-447a800da8cc@rev.ng>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260302-hppa-c3600-v4-1-447a800da8cc@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/LxngwvPjM877WS03XUVpbdOKgxvAv36cnksaSZnxYdW+yv4tra
 IOsxVieNsKT4KEDIFAnvEdoDFMWS6u0dUnU/uHFRPNkDIQT0aCAb4WflRW9+YJ1W7UHbtr0
 4egkioNfllOwpCTvwMfEixNwYympBDaqbA7Fwn32lWYU0q5ye4HZj+tHZ65b2/9Rd+HHVre
 YDboQfu+DaIchbd0zDx3Q==
UI-OutboundReport: notjunk:1;M01:P0:buYIu2y37uE=;q9pcFm4+i02ZyTvUrirk1RnggL4
 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
 fp0CJveyGEPl3GhTU=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/2/26 12:56, Anton Johansson wrote:
> Clarifies current CPU model names, assuming 32-bit HPPA runs a PA-7300LC
> whereas 64-bit runs a PA-8700.  The PA-8500 model is added, which will
> later be used by the A400 machine.  All CPU models are made into childre=
n
> of the now abstract TYPE_HPPA_CPU base class.
>=20
> References to "hppa/hppa64" models in test cases are also updated.
>=20
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/cpu-qom.h           |  8 +++++++-
>   hw/hppa/machine.c               | 21 +++++++++++++--------
>   linux-user/hppa/elfload.c       |  2 +-
>   target/hppa/cpu.c               | 25 ++++++++++++++++++++-----
>   tests/qtest/machine-none-test.c |  2 +-
>   5 files changed, 42 insertions(+), 16 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>


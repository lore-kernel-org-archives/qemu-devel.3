Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD8DC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rda4U-00026A-64; Fri, 23 Feb 2024 13:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <0102018dd71dee2f-7fd6007a-3ff1-4b5c-b02d-08ed4bd110ce-000000@eu-west-1.amazonses.com>)
 id 1rdZoD-0004Zo-Hj
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:58:07 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from
 <0102018dd71dee2f-7fd6007a-3ff1-4b5c-b02d-08ed4bd110ce-000000@eu-west-1.amazonses.com>)
 id 1rdZoB-0006sd-0Q
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=we7ia3fxgawvchs62qr3tqnz7sf6mlor; d=ipxe.org; t=1708711079;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=XYMqB2hEdroNckJjrA3r9AzIfnX8UFrVTfXXIFTPad8=;
 b=ERyVU1GGOwxK5w/1ZLQGm4FdaMQPVCQOFl/AZ1L3KLhOOTnJvvdNrCk8Z/+IC3q3
 rltSJDFI11YOWbDSzEt9msTWMFfJf1n92UbWI6eUNiOubRky80AJHitF56O1UebVqHf
 Yx4EsQtfnIcmK7XEMGOwQ3dUqpULHxgrD6395XH/VuCPIszRUrVOnmLUNCNn16tqGRw
 XQm48w/WOzFmSODz2qhGOI5Q03Rb9nh5Z1GcC1HqnFuGC2fICHnksAuSEKBfr9GneCy
 QQVJlVeIqM7m3t54Tokdk/dLxHtB3SW1vS+E9uIgWT4ukCQOt44NSI6zTXN8C9idc4O
 KtCK/CqGdw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1708711079;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=XYMqB2hEdroNckJjrA3r9AzIfnX8UFrVTfXXIFTPad8=;
 b=IApSWT1wlMf2yYC7EhwmVePLDX4mYiK3nwIwQLTL8+viThjEZSjv52r0ZHDXJfYN
 jV6YCpccym7in+Fy5eUirGMr4n/n6QiEAB577SdbbeNW9LtcQy5ClXLD1H40gWY2T+E
 TEQhpTAEjJWhgZfzDz+3no+UF7fcU0ROQPSArdU0=
Message-ID: <0102018dd71dee2f-7fd6007a-3ff1-4b5c-b02d-08ed4bd110ce-000000@eu-west-1.amazonses.com>
Date: Fri, 23 Feb 2024 17:57:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] target/i386: Fix physical address masking bugs
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20240223130948.237186-1-pbonzini@redhat.com>
From: Michael Brown <mcb30@ipxe.org>
Autocrypt: addr=mcb30@ipxe.org; keydata=
 xsFNBGPmfF4BEAC3vcU4aLC/9Uy/rTpmYujbqxQNZje9E34jGvLxO3uYwj4BeHj1Nn5T2TDM
 Gkc4ngk+mGPsJsIn69YU5cfVN+ch9O7FVfsn6egZsCNeLy6Qz0o//gBaWJodFBeawuBjXXyV
 HnQZa1p7bA/Lws8minW7NrZ7XZgEBaiVm1v1dNbLEoWR8UL2AMtph5loCQ5jPYQNqp/wH9El
 /R30GjXvAd1riWyJR2TWSN23J9rnuH2Ue+N4yEnWxAsBQ6M/NFQ5z42w4mYdsnzy1w3PulrL
 icpSixXHkm3lQcKGtKKX41HvJukSpxCgbHfuHGEJZ7bdhgRic1DHKav0JR8kQhx3gnPh06z8
 1Teu2NKkSsTR3Iv6E2x6Yy6H34lKWzBzd8TLNSevesDD/L6NU/HxT9AxrTBuypk9PZGe2VH1
 W03XnR/0Mnr0QqQBXcIAERdgNzRJY4VKF75vedf8IooZFUQ4RUlqH+x3aZB9nJ9ET77mPaNi
 SQVQBxE68uzb7eh2Kf6z7ftOYpWPw1v5HyB3oMmafEDG36SIvNF2wnmNaLQDRnAbTcy4ERgy
 tpJ3wtQDJeXOePLv8hJ3q7DSuePl7cwz4xy0ZHglW/EXRXLnyRRACfDGowyENoStg06qF+qm
 edGu1wNtmDZ/lypWm/CkzzpUDFeGP5BLZlqwVX4hn88llfvVzwARAQABzR5NaWNoYWVsIEJy
 b3duIDxtY2IzMEBpcHhlLm9yZz7CwZEEEwEIADsWIQTgD69MBpjBm2slMvwCNbEKAOtEUAUC
 Y+Z8nwIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCRACNbEKAOtEUFlhD/9ElIUg
 JxBXpIbF8s7u79OdXLld2Z1DfVmhP5Q+GilPvEeAWHhp689S9B88aNvpwW5zJfxlxcJZO0ay
 jc7E/vtdNrkXGWNEEXBgdve6m+uL+pW/i5E2htqxbLyfgTJKmsvJ8graHbwrrBS/PA8KuwVJ
 eAGbBNi3f1gyQQWrLqfTkUpLtuj7A76iVVk0G0a78L69Al84qhK2imqpFJoZt1F8h0Z5ddGv
 mvf2M/DZp87UXvXjy7X6r7msbMZa6S/Jv0dtWHeZGl3Xu3qzbtjlqFyz2Q7TibHiirsgg/CV
 BsbH/LLbi/aNCCQ/85C6jAMB0lNzcVZ7ZiKKo+vBNMTycDFk70LA9yjlNf7exHejoXmPkLmH
 ddapYZ4dzwdOiJlaTu8NZgzXUCt3RDDA1qmZrAOBF/F+tPILAEhenl9kj3blD3mPV2SrWLWY
 dbahY9BsylUhj/qE1ik5CJXrPotmJhok9Vpg07xKDpVnZXuWLGNIE8018UumO7phLrWQwLb1
 wJdN7PG165w4UWf4aQphfwaMKOVU3WDghz3aVSP9rgtm3RsUcYHPKx8IaPcDh2yf0bgG386i
 Axx3U3UQeyz2Pb9Vigo6DmPwXjLkFr/dukvVLVJLVkUab9ZhhERzWTEEMifUVEK2rGNvA87L
 VKJ2zOyxWx1e0CPj6fcGbkJ0D10XLs7BTQRj5nxeARAAz18zv2ksRiM6eEKG0qzpiKHVYlVy
 wtjla+m9wuAIwm314tffY5hjQN46uwTstdhQirjywF1EmcS6KNGiIjmoLim+dqyFP5d/UF5A
 VjLt0TYq7HjadIxbm2/CvcRnNJ01FkD99xLxV0hFTUAWAUX1mNqQ3MmWIjV89wiT06uuAUog
 m+jG3RRDyWbUnVELR60mhzccKsaEsjO/HqIERvBwL7tlOJewlPrVyz9Zed9Nhhv0KDAYmdEm
 kIEEbOfsjRu5I6nIY3NrX+QP9+nmgxADlsjvLXTSU0fT/g7IPEl3gpsQZAbgmrlGcPtvXod8
 P4iOmL8GJDU1RdBE9TBOLEbu9UlDRD4zr6tdzRpB9wvXdtSUcNCdHVqJTfq2qjIlBk7x+zQD
 ayhxzDvTMxD/93K6txKXmVVtfMBsmt9KuD2JBUEAExjsLHqzg48nQg8wF9JYWCWGBb36qpd0
 yC6VPzhSLe2Ov3/GyV5ZshO046+OiGxEeaHCwMnDTZF9xrQ5paCwWedlWKvGM2zB64AHuk+M
 v2ABK/gbDO7eS6p+xz11oD1NHr1HQLRtknfClIqj9AmjgX9maD+4GUrmHaxmkNilIukahotd
 Un9Up2gX05Wy/S3H/v8RB0kxwWg2Wh065dnyCF4Doe18bcYZvM+iMJmUBag6aDfQlryM04K7
 z4ITYDkAEQEAAcLBdgQYAQgAIBYhBOAPr0wGmMGbayUy/AI1sQoA60RQBQJj5nxeAhsMAAoJ
 EAI1sQoA60RQZj4QAIkiRDVNWynZ4kEdpqmf6hpD++Zycz+LMne4iGRsiyyTf/rPNgskNLrU
 JD555yDvFiEAhOI27R8YNCJj5byXRDa/Bm6ueClFia+POibt28UEdyOFU9PVcgFaU+VxaBIP
 rHacHL6A7UKFjmBN7o8VkVF2xXlmFge795mP4/Y3t6qfWUTodrpw1w1t5/bZxZdWqX4pUCpY
 fEx87jm60+Mj0Tb4VPWXz0UD1q1BDcdYxNa2ISLaJhGJmjjks9eqdFOhPo1fTINMNWF2Alxi
 jA6WNT8nn9lm1kav75EMYMc8WIR9tb03i+IuKNp2IWwTGBqIUyQj00BhHkZQFl4HxZhV0gXE
 AWu34Q/Z7hOUXGXq2tvYCxDeaQb2wks93e62lrrUm1JGhPWkVoCI8Md8N2mkonqIfMK8lQ0W
 WbkYHdKBkgDqhDypNNhkjWNX3JL1kL0c3rqGL381iBAZaGQPygyCx2xH9PDNp59W6u8sXb13
 +UX+kXdWU+KYbMTVoO/t4MxUJg6nXPJHz9NCkyluI820l+2OtXZZy0u196evIlUdD6RoTrNK
 z5OgFxNctVi9BPsQea9du+JlYJ460vZNPz180oczj7iqffd+p9DmAkeK25njWhg3qPeXiNZN
 45J9eMChSOaJ0GMGUQndIIxz7PO8IzjbkSHLG5CKrR3MaphMB/0L
In-Reply-To: <20240223130948.237186-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-west-1.fspj4M/5bzJ9NLRzJP0PaxRwxrpZqiDQJ1IF94CF2TA=:AmazonSES
X-SES-Outgoing: 2024.02.23-54.240.7.17
Received-SPF: pass client-ip=54.240.7.17;
 envelope-from=0102018dd71dee2f-7fd6007a-3ff1-4b5c-b02d-08ed4bd110ce-000000@eu-west-1.amazonses.com;
 helo=a7-17.smtp-out.eu-west-1.amazonses.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 23/02/2024 13:09, Paolo Bonzini wrote:
> The address translation logic in get_physical_address() will currently
> truncate physical addresses to 32 bits unless long mode is enabled.
> This is incorrect when using physical address extensions (PAE) outside
> of long mode, with the result that a 32-bit operating system using PAE
> to access memory above 4G will experience undefined behaviour.
> Instead, truncation must be applied to the linear address.  Because
> this truncation is diffent between 32- and 64-bit modes, the series
> opts to split 32- and 64-bit modes to separate MMU indices, which is
> the simplest way to ensure that, for example, a kernel that runs both
> 32-bit and 64-bit programs looks up the correct address in the
> (64-bit) page tables.
> 
> Furthermore, when inspecting the code I noticed that the A20 mask is
> applied incorrectly when NPT is active.  The mask should not be applied
> to the addresses that are looked up in the NPT, only to the physical
> addresses.  Obviously no hypervisor is going to leave A20 masking on,
> but the code actually becomes simpler so let's do it.
> 
> Patches 1 and 2 fix cases in which the addresses must be masked,
> or overflow is otherwise invalid, for MMU_PHYS_IDX accesses.
> 
> Patches 3 and 4 introduce separate MMU indexes for 32- and 64-bit
> accesses.
> 
> Patch 5 fixes the bug, by limiting the masking to the 32-bit MMU indexes.
> 
> Patches 6 and 7 further clean up the MMU functions to centralize
> application of the A20 mask and fix bugs in the process.
> 
> Tested with kvm-unit-tests SVM tests and with an old 32-bit Debian image.
> 
> Paolo Bonzini (7):
>    target/i386: mask high bits of CR3 in 32-bit mode
>    target/i386: check validity of VMCB addresses
>    target/i386: introduce function to query MMU indices
>    target/i386: use separate MMU indexes for 32-bit accesses
>    target/i386: Fix physical address truncation
>    target/i386: remove unnecessary/wrong application of the A20 mask
>    target/i386: leave the A20 bit set in the final NPT walk
> 
>   target/i386/cpu.h                    | 46 +++++++++++++++++++-----
>   target/i386/cpu.c                    |  9 +++--
>   target/i386/tcg/sysemu/excp_helper.c | 52 +++++++++++++---------------
>   target/i386/tcg/sysemu/misc_helper.c |  3 ++
>   target/i386/tcg/sysemu/svm_helper.c  | 27 +++++++++++----
>   5 files changed, 92 insertions(+), 45 deletions(-)

Thank you for putting in the work to fix this all up!

I confirm that this patch series resolves the issue that I originally 
observed in https://gitlab.com/qemu-project/qemu/-/issues/2040 and that 
Windows 10 32-bit is able to boot with PAE enabled and memory over 4G.

Tested-by: Michael Brown <mcb30@ipxe.org>

Thanks,

Michael




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ECCCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArym-0005zX-IF; Mon, 20 Oct 2025 11:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1vAryk-0005yF-2N
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:39:22 -0400
Received: from out-186.mta0.migadu.com ([91.218.175.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.anderson@linux.dev>)
 id 1vAryg-00042q-Gb
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:39:21 -0400
Message-ID: <33d414c8-426e-4334-b757-77d008abd6c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1760974752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9xvKOfLPrvh3t7SE44m3xhwobFawrYpaKKXtdB3QrU=;
 b=Bzcvf+0UOgIrG9x1i5Yr6S3OwLqi0vE13HjopgZ3Qsq7jux7WOcc9Y86MaABF5IvPaYcMg
 3ufRFB2GV6t82OLT72hzmrhGJk7qNpDgdnEXimx994AnhQyTd7aF7gsshy6dmra31RG0VY
 4FjQRN7HBzXHUl04w4lymmHdMC20l1k=
Date: Mon, 20 Oct 2025 11:39:09 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] semihosting: Check for overflow in FLEN on 32-bit
 systems
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Luc Michel <lmichel@kalray.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "qemu-devel@nongnu.org Developers"
 <qemu-devel@nongnu.org>
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <20251017213529.998267-4-sean.anderson@linux.dev>
 <4d1a679a-f1c2-487b-bddb-eaf7dd56fd0e@canonical.com>
 <56d70072-67ee-471a-9b9a-c3257886d668@linux.dev>
 <CAM=mAOn0vTDhaW3fYKK+E2t6R18+KA0ZgwantE5+9PwGCMPFKg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CAM=mAOn0vTDhaW3fYKK+E2t6R18+KA0ZgwantE5+9PwGCMPFKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.186;
 envelope-from=sean.anderson@linux.dev; helo=out-186.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 10/20/25 11:33, Heinrich Schuchardt wrote:
> 
> 
> Sean Anderson <sean.anderson@linux.dev <mailto:sean.anderson@linux.dev>> schrieb am Mo., 20. Okt. 2025, 16:21:
> 
>     On 10/18/25 03:21, Heinrich Schuchardt wrote:
>     > On 10/17/25 23:35, Sean Anderson wrote:
>     >> When semihosting 32-bit systems, the return value of FLEN will be stored
>     >> in a 32-bit integer. To prevent wraparound, return -1 and set EOVERFLOW.
> 
>     >> This matches the behavior of stat(2). Static files don't need to be
>     >> checked, since are always small.
>     >>
>     >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev <mailto:sean.anderson@linux.dev>>
>     >> ---
>     >>
>     >>   semihosting/arm-compat-semi.c | 17 ++++++++++++++---
>     >>   1 file changed, 14 insertions(+), 3 deletions(-)
>     >>
>     >> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
>     >> index c5a07cb947..57453ca6be 100644
>     >> --- a/semihosting/arm-compat-semi.c
>     >> +++ b/semihosting/arm-compat-semi.c
>     >> @@ -305,8 +305,19 @@ static uint64_t common_semi_flen_buf(CPUState *cs)
>     >>       return sp - 64;
>     >>   }
>     >>   +static void common_semi_flen_cb(CPUState *cs, uint64_t ret, int err)
>     >> +{
>     >> +    CPUArchState *env = cpu_env(cs);
>     >> +
>     >> +    if (!err && !is_64bit_semihosting(env) && ret > INT32_MAX) {
>     >
>     >
>     > The issue with the current implementation is that files with file sizes over 4 GiB will be reported as file size < 4 -GiB on 32bit systems. Thanks for addressing this.
>     >
>     > But unfortunately with your change you are additionally dropping support for file sizes 2 GiB to 4 GiB on 32bit devices. This should be avoided.
>     >
>     > The semihosting specification specifies that the value returned in r0 should be -1 if an error occurs. So on 32 bit systems 0xffffffff should be returned.
>     >
>     > As file sizes cannot be negative there is not reason to assume that the value in r0 has to be interpreted by semihosting clients as signed.
>     >
>     > Please, change your commit to check against 0xffffffff.
>     >
>     > It might make sense to contact ARM to make their specification clearer.
> 
>     stat(2) will return -1/EOVERFLOW on 32-bit hosts for files over 2 GiB. I believe we should be consistent.
> 
> 
> That may have been true historically.
> 
> Current 32-bit Linux supports 64-bit file systems and reports the length of files beyond 2 GiB without error.

Yes, but 32-bit semihosting targets only support 32-bit file lengths. So
I believe we should behave the same way as if the host had a 32-bit
off_t.

And as I've mentioned elsewhere, I think that virtio is a much better
way to transfer large files.

--Sean


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3163AE7716F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJPBT-0002tg-Te; Thu, 05 Dec 2024 22:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tJPBR-0002tF-SU; Thu, 05 Dec 2024 22:39:13 -0500
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tJPBN-0002Gz-HS; Thu, 05 Dec 2024 22:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1733456342; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=vTDyYR07cfyUVZr+yA60dd4WEYQEhFx/ILQXTT4E4J4=;
 b=V9tceRvn/q00MKz7YfIyjg1Lx+cAssorcUBfUl3PSCrp/YqRUm+G8Kped6GTAuvT0mUIaUSRZCuyFdL/j8QyCLG8fzmK5y+bBDMpmaD/64QieC8YoHaSWym6ZNOQ7BjmEqgJZyEyv1DgcvNFUtGGdG/FsWHDn45IHcZizvw4q3g=
Received: from 30.166.64.70(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WKv2jMP_1733456340 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 06 Dec 2024 11:39:01 +0800
Message-ID: <750f1e4e-0efa-43d2-9100-be8d59a23f02@linux.alibaba.com>
Date: Fri, 6 Dec 2024 11:39:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Host riscv disas is broken
To: Alistair Francis <alistair23@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, liweiwei
 <liweiwei@iscas.ac.cn>, Christoph Muellner <christoph.muellner@vrull.eu>
References: <95383723-cc27-4986-8dc3-827962120f8f@linaro.org>
 <da7690ea-a02c-4402-b798-fc29bd07451b@linux.alibaba.com>
 <8b1e3b44-1cd6-45a2-933c-a7a599598758@linaro.org>
 <d90a4d13-b356-4669-8e7d-e1409bb6fca0@linux.alibaba.com>
 <CAKmqyKN+gGMFxvbRwgq5oWs9=zuAmwpMY9nFtRbmuWVB3Fjrzg@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAKmqyKN+gGMFxvbRwgq5oWs9=zuAmwpMY9nFtRbmuWVB3Fjrzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hey Alistair,

On 2024/12/4 10:45, Alistair Francis wrote:
> On Thu, Oct 17, 2024 at 2:39 PM LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>>
>> On 2024/10/17 11:52, Richard Henderson wrote:
>>> On 10/16/24 19:57, LIU Zhiwei wrote:
>>>> Hi Richard,
>>>>
>>>> On 2024/10/17 02:38, Richard Henderson wrote:
>>>>> 2595: if (dec->cfg->ext_zcmop) {
>>>>> 2690:                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
>>>>> 2716:                        if (!dec->cfg->ext_zcmt) {
>>>>> 2726:                        if (!dec->cfg->ext_zcmp) {
>>>>> 4028:                if (dec->cfg->ext_zimop) {
>>>>> 5044:            if (dec->cfg->ext_zfinx) {
>>>>> 5051:            if (dec->cfg->ext_zfinx) {
>>>>> 5058:            if (dec->cfg->ext_zfinx) {
>>>>> 5065:            if (dec->cfg->ext_zfinx) {
>>>>> 5371:        if (guard_func(cfg)) {
>>>>>
>>>>> This structure comes from RISCVCPU, a target structure.
>>>> Oops. We missed this.
>>>>> There is no such structure for the host, causing null pointer
>>>>> dereferences.
>>>>>
>>>>> The zfinx references can be changed to
>>>>>
>>>>>      dec->cfg && dec->cfg->ext_zfinx
>>>>>
>>>>> but some of them can simply be removed, e.g. zcmop and zimop, which
>>>>> are otherwise reserved encodings.
>> Yes. Maybe it is better to disassemble them as usual even when there are
>> disabled or not supported.
>>>> Should we probe the host feature like what we do in tcg backend
>>>> support and then do the right disassemble according to the probe result?
>>> I don't think there's anything that is currently checked in
>>> disas/riscv.c that needs to know about the host.  And, as I say above,
>>> some of those checks can be eliminated.
>>>
>>> Host disassembly needs are limited to what tcg/riscv/ emits.
>> Agree.
> Hey Zhiwei,
>
> Did you follow up on this?

Yes, I have recently sent a patch to fix this.

https://lists.gnu.org/archive/html/qemu-riscv/2024-12/msg00150.html

Zhiwei

>
> Alistair


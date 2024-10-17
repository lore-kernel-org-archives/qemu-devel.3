Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C5D2F7E1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 02:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Ghc-00015f-HN; Wed, 16 Oct 2024 22:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t1GhY-00015R-ED; Wed, 16 Oct 2024 22:57:24 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t1GhU-0002nV-NP; Wed, 16 Oct 2024 22:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1729133833; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=Cp8ioRcZX8FMF0jvehyUiM9phW01rKkMhhLEdAKNWr0=;
 b=eOk5+4vMvyl2pznjx+Ytsfvvlcv9wrIFBWCRRdoxF44lisXwCH8CgF4BccRIHaAD44yQo8H+yceg2AibkQejanxiT6MO3DST/sdjpTe8rb2T3Q39jyGzOyLLZqJEi/OoWfKiZaoXkyHhSddULAn/usD3dOxlWaPmkzBMrByeN44=
Received: from 30.166.64.122(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WHJGiyf_1729133831 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 17 Oct 2024 10:57:12 +0800
Message-ID: <da7690ea-a02c-4402-b798-fc29bd07451b@linux.alibaba.com>
Date: Thu, 17 Oct 2024 10:57:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Host riscv disas is broken
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, liweiwei
 <liweiwei@iscas.ac.cn>, Christoph Muellner <christoph.muellner@vrull.eu>
References: <95383723-cc27-4986-8dc3-827962120f8f@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <95383723-cc27-4986-8dc3-827962120f8f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
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

Hi Richard,

On 2024/10/17 02:38, Richard Henderson wrote:
> 2595: if (dec->cfg->ext_zcmop) {
> 2690:                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
> 2716:                        if (!dec->cfg->ext_zcmt) {
> 2726:                        if (!dec->cfg->ext_zcmp) {
> 4028:                if (dec->cfg->ext_zimop) {
> 5044:            if (dec->cfg->ext_zfinx) {
> 5051:            if (dec->cfg->ext_zfinx) {
> 5058:            if (dec->cfg->ext_zfinx) {
> 5065:            if (dec->cfg->ext_zfinx) {
> 5371:        if (guard_func(cfg)) {
>
> This structure comes from RISCVCPU, a target structure.
Oops. We missed this.
> There is no such structure for the host, causing null pointer 
> dereferences.
>
> The zfinx references can be changed to
>
>     dec->cfg && dec->cfg->ext_zfinx
>
> but some of them can simply be removed, e.g. zcmop and zimop, which 
> are otherwise reserved encodings.

Should we probe the host feature like what we do in tcg backend support  
and then do the right disassemble according to the probe result?

Thanks,
Zhiwei

>
>
> r~


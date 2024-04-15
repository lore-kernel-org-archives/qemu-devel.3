Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 10:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwK2f-0007gg-2V; Mon, 15 Apr 2024 06:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lrh2000@pku.edu.cn>)
 id 1rwK2S-0007di-Gb
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:58:17 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lrh2000@pku.edu.cn>) id 1rwK2K-0004Jb-Us
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To; bh=Am61oWCLIJ5IIMd92Y+dxQDj7V02
 EWzSeppA5VY3Toc=; b=gMHfrVcd9xPlhY/TCoe+B9WjA/7wcG0H4DQSrfas3Ytm
 hqwAXPQuBrRVIPi+hOq3k1dZZr+asjVJngpRcz3z2pxzQFNsxxH0MfWlXTYs8o5O
 3+0gP/i9enQQOb0xtmmUAUQym3hIzJgeqViueWzMA4hq+bvZrgcBCxvSwHufcCc=
Received: from localhost (unknown [116.84.110.137])
 by front02 (Coremail) with SMTP id 54FpogCHDkszCB1m02JmAw--.17356S2;
 Mon, 15 Apr 2024 18:58:01 +0800 (CST)
Date: Mon, 15 Apr 2024 19:57:53 +0900
From: Ruihan Li <lrh2000@pku.edu.cn>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH v2] target/i386: Give IRQs a chance when resetting
 HF_INHIBIT_IRQ_MASK
Message-ID: <3vdrympspwm25t23nromdtaqv6ham2lvbico6u2artvk7nidtp@p7ppubsmw4tk>
References: <20240415064518.4951-4-lrh2000@pku.edu.cn>
 <CABgObfZmQoSBMQx=t0UYCa6t5d9RRZKy23zeW3orrBYnVQtKYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZmQoSBMQx=t0UYCa6t5d9RRZKy23zeW3orrBYnVQtKYQ@mail.gmail.com>
X-CM-TRANSID: 54FpogCHDkszCB1m02JmAw--.17356S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XryUtF1fXr47tw4rGF4Uurg_yoWDArbEga
 yDJanFk3W5WryrCw17Ka409r17CrZ7Wws7JFWqvFy8uFZ3XF1qy39rAr4vqry5JF4ayFZx
 Ar12vrnIyw1jvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbfAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
 wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
 vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
 87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
 xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
 JF0_Jw1lc2xSY4AK6cCY6r4DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kw
 1UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
 0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUU89N7UUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEHBWYavlcgnwAIsj
Received-SPF: pass client-ip=162.243.161.220; envelope-from=lrh2000@pku.edu.cn;
 helo=zg8tmtyylji0my4xnjeumjiw.icoremail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_L5=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Paolo,

On Mon, Apr 15, 2024 at 11:32:51AM +0200, Paolo Bonzini wrote:
> What do you think about writing this:
> 
> >      /* If several instructions disable interrupts, only the first does it.  */
> >      if (inhibit && !(s->flags & HF_INHIBIT_IRQ_MASK)) {
> >          gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
> > -    } else {
> > +        inhibit_reset = false;
> > +    } else if (!inhibit && (s->flags & HF_INHIBIT_IRQ_MASK)) {
> >          gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
> > +        inhibit_reset = true;
> > +    } else {
> > +        inhibit_reset = false;
> >      }
> 
> in a slightly simpler manner:
> 
>     inhibit_reset = false;
>     if (s->flags & HF_INHIBIT_IRQ_MASK) {
>         gen_reset_hflag(s, HF_INHIBIT_IRQ_MASK);
>         inhibit_reset = true;
>     } else if (inhibit) {
>         gen_set_hflag(s, HF_INHIBIT_IRQ_MASK);
>     }

Yes, I agree with you that your changes look a bit clearer. I have
tested your changes and verified that they fix the reported bug.

> No need to submit v3, I can do the change myself when applying.

Thank you for your review. Feel free to do that.

Thanks,
Ruihan Li



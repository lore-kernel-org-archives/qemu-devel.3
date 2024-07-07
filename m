Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5A2C3DA44
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 20:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQYF4-00022w-3A; Sun, 07 Jul 2024 16:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lrh2000@pku.edu.cn>)
 id 1sQYEz-00022c-7x
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 16:12:09 -0400
Received: from azure-sdnproxy.icoremail.net ([20.231.56.155])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lrh2000@pku.edu.cn>) id 1sQYEw-0001P5-CL
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 16:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; bh=ZS
 UnDvGwptpz1MMtrvo5PTPCsIrlKrs3/Jd2bPgfs7g=; b=e/3sZCxU3QP1LFsYxP
 WEUbLLKXY0YZYUXIQ16z4VoK3INJrD0gIo0HDuxcOeHhr8KtOHlrGucFDzM5pelG
 01dPY5mUN0f9gyE4BFeVU34JjrvqxxT+W6btxzVUNHE3/U/xAO8g994v7/ZXoOAJ
 9xyuJRZAnPk+C3ocSngPRjfuA=
Received: from localhost (unknown [10.7.41.133])
 by front02 (Coremail) with SMTP id 54FpogCXWhmJ9opm08Z0AA--.3189S2;
 Mon, 08 Jul 2024 04:11:57 +0800 (CST)
Date: Mon, 8 Jul 2024 04:11:51 +0800
From: Ruihan Li <lrh2000@pku.edu.cn>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH] char-mux: Don't overwrite the receive buffer
Message-ID: <uvyay4oml2krvru2jflwcv7z6ex375glbmpmy2k2a7fophaiew@3cz5i7zqrd3j>
References: <20240707111940.232549-3-lrh2000@pku.edu.cn>
 <CAJ+F1CKHve-3SOzFOLBCKo-5yQDuo7QpSqxw9N5NtPbg7bdQdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKHve-3SOzFOLBCKo-5yQDuo7QpSqxw9N5NtPbg7bdQdA@mail.gmail.com>
X-CM-TRANSID: 54FpogCXWhmJ9opm08Z0AA--.3189S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43XrWfCF4xKrW8Cw47XFb_yoWrXF47pa
 yYkFyjkr4DJFnFy398uF1Yg34FyayrX347WF4DJrya9w15uFn5XrWUKa1F9ay7u3yxGF1j
 vF45Zay5C3WjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2
 jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw2
 0F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
 j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
 kEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svP
 MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7
 v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
 1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
 AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
 42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
 VjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEFBWaBhWQODAAdsa
Received-SPF: pass client-ip=20.231.56.155; envelope-from=lrh2000@pku.edu.cn;
 helo=azure-sdnproxy.icoremail.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

Thanks for your quick review!

On Sun, Jul 07, 2024 at 08:28:50PM GMT, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Jul 7, 2024 at 3:26 PM Ruihan Li <lrh2000@pku.edu.cn> wrote:
> 
> > This commit fixes a bug that causes incorrect results when pasting more
> > than 32 bytes, the size of the receive buffer b->buffer, into the virtio
> > console.
> >
> > Example (note that the last 32 bytes are always correct, but something
> > goes wrong just before the last 32 bytes):
> >
> >         Pasting
> > abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
> >         Received
> > abcdefg)EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
> >
> > The root cause of this bug is as follows:
> >
> > The mux_chr_read function passes the data to the backend via
> > be->chr_read one byte at a time, either directly or via another
> > mux_chr_accept_input method. However, if the receive buffer is full,
> > there is a chance that the mux_chr_can_read method will return more than
> > one byte, because in this case the method directly returns whatever
> > be->chr_can_read returns.
> >
> > This is problematic because if mux_chr_read passes a byte to the backend
> > by calling be->chr_read, it will consume the entire backend buffer, at
> > least in the case of virtio. Once all backend buffers are used,
> > mux_chr_read writes all remaining bytes to the receive buffer d->buffer,
> >
> 
> My understanding of the code execution is:
> - mux_chr_can_read() returns be->chr_can_read(), say N, because d->buffer
> is already MUX_BUFFER_SIZE.
> - mux_chr_read() is called with N bytes
> - mux_chr_accept_input() flushes d->buffer, writing MUX_BUFFER_SIZE
> - be should still accept N-MUX_BUFFER_SIZE
> - mux_proc_byte() loops for N bytes
> - chr_read() should accept the N-MUX_BUFFER_SIZE
> - d->buffer is then filled with the remaining MUX_BUFFER_SIZE

Note this:
	[..] if mux_chr_read passes a byte to the backend by calling
	be->chr_read, it will consume the entire backend buffer, at
	least in the case of virtio [..]

At least in the case of virtio, if the guest provides a buffer of length
4096, be->chr_can_read will report 4096. But if you then call
be->chr_read with one byte, the whole 4096 buffer will be used. After
that, be->chr_can_read will return zero instead of 4095.

This should make sense since the device cannot change the number of
bytes in the buffer after it has made the buffer available to the CPU.

> 
> 
> > but the number of remaining bytes can be larger than the buffer size.
> >
> 
> By the above description, I don't see how it happens.
> 
> This does not lead to security problems since it is a ring buffer, but
> > it does mess up the receive data.
> >
> > This can be fixed by having mux_chr_can_read return either zero or one.
> > This fix is not very efficient, but it is quite reasonable since
> > mux_chr_read also passes the data to the backend one byte at a time.
> >
> 
> Could you share your testing setup? Even better if you could write a test!

This happens in https://github.com/asterinas/asterinas. Sorry, but I
don't have a minimal reproducible example, and I don't think I can make
one anytime soon.

As for the tests, I'd like to know how to write such tests in QEMU. I
checked the documentation but didn't find anything, maybe I'm missing
something?

> 
> 
> thanks
> 
> 
> > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> > ---
> >  chardev/char-mux.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> > index ee2d47b..5c6eea2 100644
> > --- a/chardev/char-mux.c
> > +++ b/chardev/char-mux.c
> > @@ -210,8 +210,8 @@ static int mux_chr_can_read(void *opaque)
> >          return 1;
> >      }
> >
> > -    if (be && be->chr_can_read) {
> > -        return be->chr_can_read(be->opaque);
> > +    if (be && be->chr_can_read && be->chr_can_read(be->opaque)) {
> > +        return 1;
> >      }
> >
> >      return 0;
> > --
> > 2.45.2
> >
> >
> >
> 
> -- 
> Marc-André Lureau

Thanks,
Ruihan Li



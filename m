Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87BDC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRDCg-0001Tl-V9; Tue, 09 Jul 2024 11:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lrh2000@pku.edu.cn>)
 id 1sRDCe-0001N1-0P
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:56:28 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lrh2000@pku.edu.cn>) id 1sRDCb-00040L-57
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; bh=/7
 aB/wdUeme/pLtcNpF+NSF1zy2X0PTR+J8ZPtEyhXQ=; b=d5c2mO+OlhK5WJwMyI
 v+wWiI28SPdY8GDIBDIBYbg6JuZMhlQTVqF5A5oJoFVrEbcsmcwC32Vio9YtZnCh
 7b2wmeD0hRj1Jcmt/sjqI98U864R6kh2X5RcyaQxOqbz1lB08nhf6tDwhVmYwuTl
 qlKNIQmh/XVFsx4VWNWIHl9mw=
Received: from localhost (unknown [10.7.41.133])
 by front01 (Coremail) with SMTP id 5oFpogD3z8aeXY1mvgAnAQ--.22406S2;
 Tue, 09 Jul 2024 23:56:17 +0800 (CST)
Date: Tue, 9 Jul 2024 23:56:13 +0800
From: Ruihan Li <lrh2000@pku.edu.cn>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH] char-mux: Don't overwrite the receive buffer
Message-ID: <zs77anawocu236ados4po6tfvfvjfkvkdnk3okrtu325tikzfm@qjabaix55gay>
References: <20240707111940.232549-3-lrh2000@pku.edu.cn>
 <CAJ+F1CKHve-3SOzFOLBCKo-5yQDuo7QpSqxw9N5NtPbg7bdQdA@mail.gmail.com>
 <uvyay4oml2krvru2jflwcv7z6ex375glbmpmy2k2a7fophaiew@3cz5i7zqrd3j>
 <CAJ+F1CJc8dS3tSChnN+MwUCZfYPkoXGS+kd2Trw2RTtG1HRq1w@mail.gmail.com>
 <fx2rkepa2jhuy7novlpyqfgwh2fven3rjjzfng72hzkh3vnylg@wokdocju7bx4>
 <CAJ+F1CL6A3oZqqCmgmHSDPmaDBODhsLaWhpVxvH3u0qgFZCPWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CL6A3oZqqCmgmHSDPmaDBODhsLaWhpVxvH3u0qgFZCPWg@mail.gmail.com>
X-CM-TRANSID: 5oFpogD3z8aeXY1mvgAnAQ--.22406S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1UJF1kWF4DWw17Kry7GFg_yoW3ZFyrpF
 WYkFWUtr4DJFnFyr1qv3W5Xr1Fya4rJryUWr1Dtr17uw1q9F1fXrW7KF4j9ry7ur4xGF1j
 qr4UZFy7G3WqvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
 z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
 AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
 McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
 v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
 04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r
 1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
 b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
 vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
 73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEFBWaBhWQODAAssr
Received-SPF: pass client-ip=209.97.181.73; envelope-from=lrh2000@pku.edu.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL=1.31,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 09, 2024 at 06:58:41PM GMT, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jul 9, 2024 at 6:41 PM Ruihan Li <lrh2000@pku.edu.cn> wrote:
> 
> > Hi,
> >
> > On Mon, Jul 08, 2024 at 03:21:58PM GMT, Marc-André Lureau wrote:
> > > Hi
> > >
> > > On Mon, Jul 8, 2024 at 12:12 AM Ruihan Li <lrh2000@pku.edu.cn> wrote:
> > >
> > > > Hi,
> > > >
> > > > Thanks for your quick review!
> > > >
> > > > On Sun, Jul 07, 2024 at 08:28:50PM GMT, Marc-André Lureau wrote:
> > > > > Hi
> > > > >
> > > > > On Sun, Jul 7, 2024 at 3:26 PM Ruihan Li <lrh2000@pku.edu.cn> wrote:
> > > > >
> > > > > > This commit fixes a bug that causes incorrect results when pasting
> > more
> > > > > > than 32 bytes, the size of the receive buffer b->buffer, into the
> > > > virtio
> > > > > > console.
> > > > > >
> > > > > > Example (note that the last 32 bytes are always correct, but
> > something
> > > > > > goes wrong just before the last 32 bytes):
> > > > > >
> > > > > >         Pasting
> > > > > >
> > > >
> > abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
> > > > > >         Received
> > > > > >
> > > >
> > abcdefg)EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()EFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()
> > > > > >
> > > > > > The root cause of this bug is as follows:
> > > > > >
> > > > > > The mux_chr_read function passes the data to the backend via
> > > > > > be->chr_read one byte at a time, either directly or via another
> > > > > > mux_chr_accept_input method. However, if the receive buffer is
> > full,
> > > > > > there is a chance that the mux_chr_can_read method will return more
> > > > than
> > > > > > one byte, because in this case the method directly returns whatever
> > > > > > be->chr_can_read returns.
> > > > > >
> > > > > > This is problematic because if mux_chr_read passes a byte to the
> > > > backend
> > > > > > by calling be->chr_read, it will consume the entire backend
> > buffer, at
> > > > > > least in the case of virtio. Once all backend buffers are used,
> > > > > > mux_chr_read writes all remaining bytes to the receive buffer
> > > > d->buffer,
> > > > > >
> > > > >
> > > > > My understanding of the code execution is:
> > > > > - mux_chr_can_read() returns be->chr_can_read(), say N, because
> > d->buffer
> > > > > is already MUX_BUFFER_SIZE.
> > > > > - mux_chr_read() is called with N bytes
> > > > > - mux_chr_accept_input() flushes d->buffer, writing MUX_BUFFER_SIZE
> > > > > - be should still accept N-MUX_BUFFER_SIZE
> > > > > - mux_proc_byte() loops for N bytes
> > > > > - chr_read() should accept the N-MUX_BUFFER_SIZE
> > > > > - d->buffer is then filled with the remaining MUX_BUFFER_SIZE
> > > >
> > > > Note this:
> > > >         [..] if mux_chr_read passes a byte to the backend by calling
> > > >         be->chr_read, it will consume the entire backend buffer, at
> > > >         least in the case of virtio [..]
> > > >
> > > > At least in the case of virtio, if the guest provides a buffer of
> > length
> > > > 4096, be->chr_can_read will report 4096. But if you then call
> > > > be->chr_read with one byte, the whole 4096 buffer will be used. After
> > > > that, be->chr_can_read will return zero instead of 4095.
> > > >
> > > > This should make sense since the device cannot change the number of
> > > > bytes in the buffer after it has made the buffer available to the CPU.
> > > >
> > >
> > > Thanks, that helps explaining the incorrect behaviour.
> > >
> > > I think the concept of extra buffer as introduced in commit
> > > bd9bdce694ccb76facc882363e4c337e8a88c918 ("Add input buffer to mux chr
> > > (patch by Tristan Gingold)") is flawed, as Jan Kiszka explained in commit
> > > a80bf99fa3dd829ecea88b9bfb4f7cf146208f07 ("char-mux: Use separate input
> > > buffers (Jan Kiszka)"):
> > >     Note: In contrast to the original author's claim, the buffering
> > concept
> > >     still breaks down when the fifo of the currently active sub-device is
> > >     full. As we cannot accept futher data from this point on without
> > risking
> > >     to loose it, we will also miss escape sequences, just like without
> > all
> > >     that buffering. In short: There is no reliable escape sequence
> > handling
> > >     without infinite buffers or the risk of loosing some data.
> > >
> > > Maybe the best course is to remove the cycle buffer and either:
> > > - drop the data that be can't accept, but have always responsive mux (by
> > > default)
> > > - blocking, including mux, until the be can accept more data (not
> > friendly)
> > > - or allow unlimited buffering?
> > >
> > > Given that mux is meant for developers and qemu CLI users, I guess any of
> > > this would be acceptable.
> >
> > Thanks for your comments.
> >
> > However, I'm not really sure what you're talking about. If we make
> > mux_chr_can_read return either zero or one (as I've done in the patch),
> > do you mean that we are still at risk of losing some escape sequences?
> >
> 
> > In mux_proc_byte, we set d->term_got_escape to 1 when we see the escape
> > character. As far as I can see, the escape sequence is always handled
> > correctly. So I don't understand how losing escape sequences can happen.
> >
> > Would you mind explaining this in more detail?
> >
> 
> 
> I agree with you that returning 0 or 1 in mux_chr_can_read() should solve
> the issue (assuming future call to be can_read still return >= 1). But it's
> not elegant to read/write by 1 bytes, especially as you explained, it takes
> 4k buffers for virtio-serial by write. My comment is more general also: the
> 32 bytes buffer isn't really helping, at some point it may be full and mux
> will stop handling input...
> 
> (I think the quoted comment talks about escape sequences for the guest, not
> the mux term_got_escape - unfortunately the original commit bd9bdce69
> introducing the mux buffer doesn't have details)

Thanks for the explanation. Yes, the cycle buffer isn't helpful.

I think it is possible to remove the cycle buffer. Then, in
mux_chr_read, to remove the escape characters from the input string, we
can either mutate the input string in place (can we?) or allocate a new
buffer to store the escaped string. Then call be->chr_read *once* and
pass it the escaped string.

This should be fine as long as the escaped string cannot be longer than
the original string.

(This cannot handle another corner case where the input string contains
escaped sequences that switch the focus in the middle. But neither does
the current implementation).

> 
> 
> > >
> > >
> > > >
> > > > >
> > > > >
> > > > > > but the number of remaining bytes can be larger than the buffer
> > size.
> > > > > >
> > > > >
> > > > > By the above description, I don't see how it happens.
> > > > >
> > > > > This does not lead to security problems since it is a ring buffer,
> > but
> > > > > > it does mess up the receive data.
> > > > > >
> > > > > > This can be fixed by having mux_chr_can_read return either zero or
> > one.
> > > > > > This fix is not very efficient, but it is quite reasonable since
> > > > > > mux_chr_read also passes the data to the backend one byte at a
> > time.
> > > > > >
> > > > >
> > > > > Could you share your testing setup? Even better if you could write a
> > > > test!
> > > >
> > > > This happens in https://github.com/asterinas/asterinas. Sorry, but I
> > > > don't have a minimal reproducible example, and I don't think I can make
> > > > one anytime soon.
> > > >
> > > > As for the tests, I'd like to know how to write such tests in QEMU. I
> > > > checked the documentation but didn't find anything, maybe I'm missing
> > > > something?
> > > >
> > > > >
> > > > >
> > > > > thanks
> > > > >
> > > > >
> > > > > > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> > > > > > ---
> > > > > >  chardev/char-mux.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> > > > > > index ee2d47b..5c6eea2 100644
> > > > > > --- a/chardev/char-mux.c
> > > > > > +++ b/chardev/char-mux.c
> > > > > > @@ -210,8 +210,8 @@ static int mux_chr_can_read(void *opaque)
> > > > > >          return 1;
> > > > > >      }
> > > > > >
> > > > > > -    if (be && be->chr_can_read) {
> > > > > > -        return be->chr_can_read(be->opaque);
> > > > > > +    if (be && be->chr_can_read && be->chr_can_read(be->opaque)) {
> > > > > > +        return 1;
> > > > > >      }
> > > > > >
> > > > > >      return 0;
> > > > > > --
> > > > > > 2.45.2
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > > --
> > > > > Marc-André Lureau
> > > >
> > > > Thanks,
> > > > Ruihan Li
> > > >
> > > >
> > >
> > > --
> > > Marc-André Lureau
> >
> > Thanks,
> > Ruihan Li
> >
> >
> 
> -- 
> Marc-André Lureau

Thanks,
Ruihan Li



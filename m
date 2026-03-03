Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C5BEC047D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM7t-0006J7-Vv; Tue, 03 Mar 2026 04:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxM7s-0006Iz-Px
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:33:12 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxM7r-0005ow-2h
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:33:12 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64aedd812baso4765686d50.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 01:33:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772530389; cv=none;
 d=google.com; s=arc-20240605;
 b=WWFxLCy+ShUvNqe5vUvIQVdWKOkpyj5lG2O0CjPxCzpPDjLqGI13RaL5/s8/jAJc02
 EXkrtO0t4wbQg6eRIjChj3Y3eK+oEKKv5kkSbqRhe0bbA9mMVO5Eg/kaZPWpYsbNAWfF
 gpUtiSKtyv98IMlGO3XFmon2IxvCtQf8CwHGBwNu7rZZrQnePmUWFAWeFvS9H+ci6iMX
 e4hp0TllQy8TzFDfv5dLBK2hEziCi4NB/T9jEhQ8ddix5ToMaXMfQPxm6wBjrtyjkplw
 8cgikIZpGouj3RBXGJ+JRa2fO3WAkUPaTKxBOzb/X5o15umRzD8CklCzOuDUNcJhx/iv
 Gv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1CoBz/OqT5GECboya7D8HG8j0hqSTgZQuM6CSXWkmuI=;
 fh=9L3087NhbYdluKZGzIxMGa5EiRKr3LrOuboog0e4oYY=;
 b=Wdq+/zjMdtb8WnhTCnxQyMpOXJ8tDBx5tBqopVFefQXzoCjlHjL9gR/1qK7q6JMAAZ
 LfAC/figJpOVOmSm/uZ7LiT+TMW/s987GCzQCG4zorMYTDbtRvvSSyEqULlQf6mqw/WW
 boKVXTlsn4VLlmJZV7ERQaApLIm1nPz1z4EndrzMoFgHhEW2cSrgMKlolTuTyQyg3cHW
 mE8BBsOKq+Pz9G+QNdb9aID2/XgYRCg6iQ6wS/lzbCOb8p2ttVrFkULU6vWKeEpRbQd8
 VCXGFagqebEoQaHecCs2t/aga7i82E8ynftyxiB+bfma1dNkbw93jUI1k14eJBKwGZ7F
 fjdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772530389; x=1773135189; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CoBz/OqT5GECboya7D8HG8j0hqSTgZQuM6CSXWkmuI=;
 b=XTsNqMXdogOQfIzFmvKGnjNmAZiN21FbZngc5Cqn1ffDadkTWejNvC7IeG+8FuG5Km
 lE81FtkWlmTdKbjClwVPBzu8t6zQgrarnoRnHpCTE4C2e6K3e/m5oAxuXSErmo68QMt8
 VDAT1wiGJvGuHy1RcznyRGmCaA1AesQzzbN+oBSXfLksiLT9WBIxqHj3iscUWnrTjf+l
 +0vbDYa2uuGhpZCaEWK1lgXWrOj3nqQwBkIkVJ8ZpI2EW8lWQS2IWL/xcAq2p86dcBBC
 3wI40SGIuHB1RLf0EvPj2iPpFOHUSz3bJSnxRpnJ/u1HOqPzcEGFViSH76ELQUmKeLMW
 xxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772530389; x=1773135189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1CoBz/OqT5GECboya7D8HG8j0hqSTgZQuM6CSXWkmuI=;
 b=HMFptts43yR0VIMwJDqYqLIoDsZGOOcDb+o+qrV/UHTckKBn0MZcNQ03E411wghHSU
 1JAfUozkG7f1vy5DLJ/h1pDUCQpyccjItpPK9ne4nYHJ1AMeJz0bpqhRIJnN0kGFL/bm
 GGE0ZbfQ/iSWFIO6WLCJEv6dLcmXOf011tPdUyGtZ3LkhyRAaOfj/fBJ2v5ibzl7EGiA
 s7uTrvl+RQDJXp6qjpXCBYcGyjunkdWRelwg05XiTl2CGAyxRFLjO/gh/1TKXTa1PVrT
 PVC73lOYoJOWSkgQ5oT6AaXOhyFG1rkrPPweHDpC1gEkkRvbD6pk/UM/f8KE+I+S10ao
 zMMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGbYrIDRuNNtDb+mufLlHBza0TYZF7iPvMNfMVYPJhoz5389UI7iyHdyf3gwVv2HXe2K6Kd1gAJRVK@nongnu.org
X-Gm-Message-State: AOJu0YyH8A6xNX1haL0Dl6hWiY/I6kU2GphDPcQbktZjTBbbFcYMS8jP
 sXgkV5w6JM0pXbIoKuWbziae6BuOm/5i8SCvYIf/R6eEU6thS2I+RUjad2iQU1LVaQQHOYmyVC8
 67aOF8sTWUVmvKLgaROBAkeIXWb+30prtHK5IbHM5lg==
X-Gm-Gg: ATEYQzxMmxRFzaOcFXX0bOtI6NBUYfTuvuwYQKp2ZwWUpOgiRuHzM3peDS4dM4trQGX
 D0YBdGIVLL2AD2+0PrwldS+yZuC/pGqUyKN04ZGmn8KmGb0Bo5HOEOWdIAYKn5+on/BaQH4OQXf
 UwF3Y9yOZyZcw2DmsYqEH+1PB1m4UHajr4+XKvNhxPh4xb9w+hb3nMlJIjAgUBG7Y5LzVX79qSN
 CHnwRt6AaCPwIs0FnxCuYB6xK1Ac+/GcKjh80BaLmNzxxhLnR/KN75smKbgyF5hZh1TszQtxiIB
 OhnO75wYL+6CDFwtqu+VZWYamoouRH1Ddw56qD46yG/IS01otU6NrEXd9CXadpaJZv4=
X-Received: by 2002:a53:b6ca:0:b0:646:5127:9d14 with SMTP id
 956f58d0204a3-64cc2369027mr10256605d50.79.1772530389407; Tue, 03 Mar 2026
 01:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20260301121347.797dc9f4@penguin>
 <127d0e97-ca25-4847-a06f-954443bbc886@yodel.dev>
 <CAFEAcA_igpniZ=zZAUPTyx9xpyS+TjU5KO+LYc-noJsJ+L-GSw@mail.gmail.com>
 <aaanU-ZiDQr72j4g@redhat.com>
In-Reply-To: <aaanU-ZiDQr72j4g@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 09:32:58 +0000
X-Gm-Features: AaiRm51k0jTUPTPF4s2W1z1XTtXyfCqoWFG3vlB2un6mCMrH5RAx-NvE21VtEck
Message-ID: <CAFEAcA-b0MXpUg2=x6c6=sY30sf0KpPDKmDn=yS3Bfp=fRjsRw@mail.gmail.com>
Subject: Re: qemu master compile error in hw/net/rtl8139.c with --enable-asan
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>, Lukas Straub <lukasstraub2@web.de>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 3 Mar 2026 at 09:18, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Mar 02, 2026 at 10:32:38AM +0000, Peter Maydell wrote:
> > On Sun, 1 Mar 2026 at 15:15, Yodel Eldar <yodel.eldar@yodel.dev> wrote:
> > >
> > > Hi, Lukas
> > >
> > > On 01/03/2026 05:13, Lukas Straub wrote:
> >
> > > > ../hw/net/rtl8139.c: In function =E2=80=98rtl8139_io_writeb=E2=80=
=99:
> > > > ../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region o=
f size 0 [-Werror=3Dstringop-overflow=3D]
> > > >   2264 |                 memcpy(data_to_checksum, saved_ip_header +=
 12, 8);
> > > >        |                 ^
> > > > In file included from ../hw/net/rtl8139.c:62:
> > > > /home/lukas/qemu/include/net/eth.h:50:14: note: at offset [8, 48] i=
nto destination object =E2=80=98ip_ver_len=E2=80=99 of size 1
> > > >     50 |     uint8_t  ip_ver_len;     /* version and header length =
*/
> > > >        |              ^~~~~~~~~~
> >
> > On the face of it, this looks like a compiler bug (warning false
> > positive), because we set:
> >
> >     uint8_t *data_to_checksum     =3D eth_payload_data + hlen - 12;
> >
> > and earlier
> >
> >             eth_payload_data =3D saved_buffer + ETH_HLEN;
> >
> > where
> >         uint8_t *saved_buffer  =3D s->cplus_txbuffer;
> >
> > and s->cplus_txbuffer is a uint8_t* which we set up via g_malloc().
> > None of that is an ip_ver_len byte, or even an ip_header struct.
> > So it looks like GCC has incorrectly decided that this uint8_t
> > buffer has a type which it does not.
>
> Yes, the problem is earlier code that also consumed eth_payload_data,
> by assigning it to a 'struct ip_header' pointer:
>
>             struct ip_header *ip =3D NULL;
>             ...
>             ip =3D (struct ip_header*)eth_payload_data;
>
> As a result GCC now believes that "eth_payload_data" has the
> 'struct ip_header *' type for the remainder of its life.

Andrew Pinski kindly found this bug in their system where it had
been previously reported:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D114494
It's been marked as a dup of a different bug that's still open:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99673
(the sanitizer pass can rewrite the IL so that an address
expression is changed to one that has the same value but is
pointing into what the compiler thinks is a smaller object; the
warning-generation pass runs after that and assumes it can rely
on the sizes of things being pointed to in the IL).

So this is definitely a gcc bug, and it comes down to how much
we care about working around it.

> Eliminating the intermediate 'eth_payload_data' squashes the bogus
> type inference
>
>             ip =3D (struct ip_header*)saved_buffer + ETH_HLEN;

Mmm. This is a bit ugly though because it's expressing the
intent less well. Conceptually we have the packet payload
data in the buffer; then the eth level payload data is at
offset ETH_HLEN from that; then the IP header is at the
start of the eth level payload data.

-- PMM


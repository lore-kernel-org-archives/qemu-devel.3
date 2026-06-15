Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA47CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ8zh-0007nb-4C; Mon, 15 Jun 2026 11:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ8zg-0007nA-4o
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:12:56 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ8zd-0003pu-6K
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 11:12:55 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66077f6c438so3332281d50.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 08:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781536372; cv=none;
 d=google.com; s=arc-20240605;
 b=OuU671Pal8ZJ9R+cBW4XDXmcwVz0tWircv8qxDYfMctsOSyV6d5Hw8eFu1AEEtRjWH
 wnXodn0/xe0vaynGGNCpeypwg1FfXu4Nu0zNBhBBgoojZtDQahNY/0Cikprw/3v2NL4B
 YkESgMSJMoIrYj8mgIthUN6yggyGp1gKpc8VolOuyZdGsnvPbDAgPGp8B8E0rDWwndRv
 3yOlejkh2wKrb3ODGBVdMXmsaAzpTpbe6fuReZOfJ0rbnhefv0dYi8UjL60/JnuOfT7r
 +fiJAaj9/ahuWxzRVYhMvcmPHX5i8LOyflojtxIsgQnu6639hikr4blaJinCGXeAsAoj
 eBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UMXWJ2+3cc1wAiWWyN1hPgsu3EPzkzH6hh+ksPb3bwQ=;
 fh=CwehfKbbXE58IsLQxqLUsWz12n/kz5Jzz4Q4kbebhIA=;
 b=UapFskHoWuXN+C4eGRPAna/rJMKla82yept51o1iTnz/ODEtTKjkGLeM+bN7YvP16J
 nh8I5GSUEB/6tW5JLr9GvLjVusHmvDFBOq9zzWHvmTUSpHJOnG3iUrKiqe+cvXx0mRgY
 LS321zRSGy+Balm/AJwOMKpxJfPUjhk5Ja2+dJwOGbsPPJlHrdHa4ArX7FSk4VoAaywO
 QTjqEL1hg0YRRcotBPkmLoGalsubo61lhG/ytPpXBcZshys9DI9pMiFOaQ7E0pVmIGDy
 /GVXtU1BBkUIIjKSpIE1PL8R5lGy8ePLsvT70tgvUBLqloHgihfzACuAScKalXw0oMPY
 QQeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781536372; x=1782141172; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UMXWJ2+3cc1wAiWWyN1hPgsu3EPzkzH6hh+ksPb3bwQ=;
 b=LxLqj4uNEzcNfUEUhicoIKTmERcNQR8JS2vtVdg9DZoP1S+EYdeypXW609jfZrbSGP
 4VYKPnjnLjuVtDga+yAy13M8cov9+juEnlSSabUDxeiMdNfCWxJ6Rnstq8sKiyECrxEg
 PBixvt4AtJLYrfWMwhARyzj52FLKUNLUlXwYqCLk1BVaf1Zjqv7AxiTFzU9AfrPPQ6Z2
 yin1hQhixWB+wenII/JW0KNpC9xxGyLbZZBKCQ9nf/9jaQQcy36PvTOHHPkjB09W80ul
 B6dx8oqaJsly9WilS14snRCU+H1FdSSiCzOgsLbupzLR65Xfj3MmT3NC7JDdQvrK5Ywx
 KF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781536372; x=1782141172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMXWJ2+3cc1wAiWWyN1hPgsu3EPzkzH6hh+ksPb3bwQ=;
 b=aXC/JzBGByWVhSSMciqiGWyWutR8+mShIMhtEy9/xTRj1G2jWNmiqytT4VG3A4aFjf
 WX4hJpbcLDa1jmoGj9jo5kqeAzIXbxarXg2/ckNOY2IC2I9dTRZ4Brpam6v3UTmqQbf+
 MmEC0eYTuFZzMn6JJ5k4y5ws8N5go88xG1bLvtstKalHN1n6VwZxwwMUTU72zFVghg5N
 3BMsJYyG/fSmfoeVfI4qKj8gEBA/OFveTn1qWwQqHF6gGJ0sQplyLL5+38Pv2nCJL9oO
 36APMRcvuG5tbW8sLBvJnBWd5BzpV/kAtcY0zfrnAVC98YOiNHKH29b4T6/YOQPZud9K
 YZfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1Obu/o0LOZvB2ibUE9pUy9fGVh/RMkHomqImQkt0WzsoWUmJaT+mNgcOs/Ch7IMEbZJKfcU5oF/8a@nongnu.org
X-Gm-Message-State: AOJu0Yzo88WQ8HfvAqTBIQgdH7Xu+0+13VG8xy7pzAiq0FJ77rf7GrD1
 Ce0JuT83ySw8jcpnsKEebkIJFMvn/NOilCD38CB1k5iAJAabx0z/62D9t+Qi4ahTvZ9HJ7hjSOu
 CGcWVrZ1CAA0oh04ijJhrbNiWxM5z3zYhppF/2yC6zA==
X-Gm-Gg: Acq92OGMnbw7QndAXdoQtAuNeyNuRZpLBsbXEvRT0cSrbcjqvlLxazBGNVStreGxNCm
 ZZ6V4mzFYrl0sdg+Vonx48maGslQd/9sKu6OUbE3lyn+nxJytax+8Q5VGQKoGLbfUXIXX0M2qM3
 9prh12lG72rT78NNLCB75Pwdw/EdTAfskHhyL1CLmS1jyaOLF8XSQSxPtrVBv1UPX+zVthEJKMR
 h5kiui07h472k+RKWb6x6rNIzb5BhLKdwPIjaIXT9qB72qNoZXsEd6iwZ56ds7PSZ6cv5r1SiaG
 wMUOxG/U9r8vlcCTMTE5zcJh+8oNXpTBFs3bEWTffslYJire6jlbGe/uYUdxOHj2n0U=
X-Received: by 2002:a05:690e:168a:b0:660:31bd:3c5d with SMTP id
 956f58d0204a3-66278127b80mr12762789d50.29.1781536371644; Mon, 15 Jun 2026
 08:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260615105556-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2026 16:12:40 +0100
X-Gm-Features: AVVi8CeG4_zk7zZB_1rlayRwtBBOUzxEDrTg-LgMb3yOrLiHP91Gzr_RzPZ2iGs
Message-ID: <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, alex@shazbot.org, richard.henderson@linaro.org, 
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com, 
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, 
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 15 Jun 2026 at 15:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 15, 2026 at 11:57:09AM +0100, Peter Maydell wrote:
> > On Mon, 15 Jun 2026 at 11:03, Gavin Shan <gshan@redhat.com> wrote:
> > >
> > > All ram device regions were turned to be indirectly accessible by commit
> > > 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> > > to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
> > > guest is started by the following command lines, with GH100 GPU card passed
> > > from the host.
> >
> > > diff --git a/include/system/memory.h b/include/system/memory.h
> > > index 1417132f6d..5878727d09 100644
> > > --- a/include/system/memory.h
> > > +++ b/include/system/memory.h
> > > @@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
> > >  void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
> > >
> > >  /* Internal functions, part of the implementation of address_space_read.  */
> > > +void qemu_ram_copy(void *dest, const void *src, size_t n);
> > > +void qemu_ram_move(void *dest, const void *src, size_t n);
> >
> > New function prototypes in include headers need documentation comments.
> >
> > In particular for these, it's really important that we clearly say
> > what semantics we are attempting to provide with them, so that
> > (a) when we're reviewing or later updating the implementation we
> > know what we are trying to provide
> > (b) when we're looking at the callsites we know what the function
> > is guaranteeing to us and what it is not, and thus whether it's
> > OK to use it or we need something els.
> >
> > > +#if defined(__i386__) || defined(__x86_64__)
> > > +#define HOST_UNALIGNED_MMIO_OK 1
> > > +#else
> > > +#define HOST_UNALIGNED_MMIO_OK 0
> > > +#endif
> >
> > We need to do something better than this. We can't
> > just say "oh, we trust that on x86 this works": it is
> > neither actually true that the compiler guarantees it
>
> sorry guarantee what?

Well, that's part of my point about "we need a doc comment":
what exactly are we trying to guarantee ? But whatever it is,
"hardcoded ifdef that privileges x86" is definitely the wrong
answer.

-- PMM


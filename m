Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64F0C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzeE1-0001Hc-VN; Thu, 27 Aug 2026 13:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzeE0-0001FQ-5T
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzeDx-0003yq-4m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787852952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awWB6uB0BedZ29MREFEh7+eImC5cdPwPdJfM9BMb5dE=;
 b=IF2eZsls/RTm8CMitNhytLIcXLaOuHTB0PYZjqSLisYjJAXCCJu6L2pH2keEgqobpckPLQ
 9DP0wA/fePyKo2lLmjhg2LeaQwnBhYYXHsL53fQzi7pXqgEq1OqpgYt3x++V7PY2f7Zs4U
 XAr733whiOFiTI0m88OYC2ZFAxH03/w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-mB2uK_DaPou0xGJFT1rEww-1; Thu, 27 Aug 2026 13:49:10 -0400
X-MC-Unique: mB2uK_DaPou0xGJFT1rEww-1
X-Mimecast-MFC-AGG-ID: mB2uK_DaPou0xGJFT1rEww_1787852949
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-482e2541c30so32005f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852949; cv=none;
 d=google.com; s=arc-20260327;
 b=sOfj5RF080vgeP/wBm+qT10cV4iB8qRY4ahnyuxsrfOqRYiJno/hm3wTvooSMFip60
 GRsuGcz6Nee4l3WBbRtmzMEYQNJRKqfYtntxb04+Icao7jAmBVHfi7TbVESvugMcwk2R
 0KMrUta1iUt6u+EbzWKhZ3Tl53kGDnE/cJy1V7txz1C9WgRq57dM2AjKdbtaiePQ590l
 oNixwLRooRtQuFaVSCtvYEy9uFTqtDryADI/GHMjKGF9wHJT8Efv0jExU3f3eViVsxcB
 Yz5ShnvQ3AkufBEes4+OtJ4iFj2JclDJro+9vUP/ZHOOin15mophp3LadtYYmoWQuPZc
 xTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=awWB6uB0BedZ29MREFEh7+eImC5cdPwPdJfM9BMb5dE=;
 fh=aOL6avpqHOgt2q8BSQxgYwM58UM8QadR33sxHcFuJmw=;
 b=OcxmZbBjbyGF/xzfPu6PT9K56S7xVb2X9rOgAZhfXdPSGZzncVFUFgMuVd04OC6Oja
 fDVCLSUqIYDD+lrvQjI5kmbTsOgmSYMsl7C0Xx7UQ5yalXIbpcAcCiHyZgo6I9pY/q1/
 Vt4ofaRQ7PfZpQRliUxWnHd4CEG9Vs6Hbk9lmLTUwpbvCLfNSjjzIH3H4G7NTILT8tfV
 trGPtu3gppT+RUjlFy9XullSi1tqzDHwNAO8HZRPyS0hleNE24s0WythgZHu419qBAy1
 +fTfkor5A6gmwhCuPkaz/3Ipb+wKUx1rvwREHvGd5JxNBGJDuss2925II6JzK1hBYriM
 u8bg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787852949; x=1788457749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=awWB6uB0BedZ29MREFEh7+eImC5cdPwPdJfM9BMb5dE=;
 b=p2ouHxPGKZqZWeDQ98L4IUX+9em7cisOZB4C37JxsKJ+cYI6/QRqH6/Zy37/kvPe/t
 IhvuQoYOXT56XdAGjrRaLFy9QfSxSgT0mHbAXJ6nFlfaoJ6P0AMAOszxaSCn5HJghEou
 SnBIH7vxSgNIQ0/jzFowXINEW5a4P2Om32LZqinKEtsXbmqH4bqV4ra42v6j8MfjBptw
 XPCFRNgaALEfYCMJY4KwO8JhpGk1N5+bMv0vimU0QKtMq8fMMvQGFIANrBBij0mwMIKF
 eIDSNtor1scs45OVrJbulVCHX09pkMvjeFNTqz9uT1ttfighYlK+wipwIv6MZ+AahXsl
 ZnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787852949; x=1788457749;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=awWB6uB0BedZ29MREFEh7+eImC5cdPwPdJfM9BMb5dE=;
 b=N4jSCQmKf7ghIs9nLpV4L7bsujXknZTeQjrdh4L9eT7oxxBxawt9w8wyefhr9f854C
 3cHNkD2czH85sL6Rf03hASzErn4midZ7W5ZUNeOqFW6M7GCEF4I295czfPFNPoftYGzl
 +bVSXzX1qy2Kw2bX+zvhX4GhtH2CGvYk06OKmb4YPpLnBvtXgFLrg7kVM8hfFzaP3k+I
 tL2bPYyp3LMtsBrbFx7YEMl6BDwrXu63XhoQu8lXEJbNKo5eez9yozXQUhb4FOaTXt8s
 PQA7zdNqbmdQDY1qdF0XwcTKEVD+fXij5zqWbXW1uLJOFjmzwie8vx5MBrpUlMRygWOh
 237Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrsx6+lM7lNGle/SbLW5/lkHCgbJV7KNhhxoYhcxSYFOR4VEUIYSS12nqmAfeKRAGj0nPDwWz8duvgL@nongnu.org
X-Gm-Message-State: AFuF++m9M7zdCfuI+gVwjF1Y+ohFRn5/nPmElE493YZrktx8fhKiFdsh
 5AhzBDpkd04HLkTARlbOG1C5hqRzwu/BZ8qTpeR+W8oskSIFxqDnG++Dw77wFQwGos4OKkMFmF6
 hgTNqt+DmVhzcdTrxzt39Z4uPTyCg51PEkzqyI8nbsHtd9oQSAXoa0NbEm8ife//lvXHjCx2qzO
 azqj4fu5xwYwzuCHdfRV6TqaS9zmWMJYk=
X-Gm-Gg: AR+sD10ZtKy8v00Pm4eGVQOPxVcWoqdt2r3zPumXhDMpmfCThkBXXNS0jM/QLu+itvw
 LMTD3CSY97thpEUmBcBqVgkCrnFvc2SaPtWT+l/q4gD0ONd7/gX8IPnmzIqcKhDShorC+dlXSx8
 gJF3wyxFR6kNypkZuD7VxeY2z9q5ptFl4vGP/Gp2zLRB4io5SUzAP7cz0XaIWxVEMHpn59ESYzI
 SGZK6QOhb3dB2lZ74fL/v7wcUBhKohiD8tsH8jxWRr12qD0wqtJkjJLnWBR
X-Received: by 2002:a05:6000:719:b0:474:bbbb:bf17 with SMTP id
 ffacd0b85a97d-482f71ecf61mr1510692f8f.0.1787852949216; 
 Thu, 27 Aug 2026 10:49:09 -0700 (PDT)
X-Received: by 2002:a05:6000:719:b0:474:bbbb:bf17 with SMTP id
 ffacd0b85a97d-482f71ecf61mr1510638f8f.0.1787852948770; Thu, 27 Aug 2026
 10:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <b2b1d77e-c3e3-4aad-87d2-f5d4834abd1a@oss.qualcomm.com>
 <apAG8JQTnQxRkfip@redhat.com>
 <9e36f8a0-5363-4ce2-accf-62ccf3602344@oss.qualcomm.com>
In-Reply-To: <9e36f8a0-5363-4ce2-accf-62ccf3602344@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2026 19:48:55 +0200
X-Gm-Features: AcwNN1X1-eaT6TIQtq1c9AZkdJJPAFSqmjPm7XfVmNJJCniwRLGMzUtpOIIGOgA
Message-ID: <CABgObfYw8U6q1xdUXcP5XBNTpB-n9MR=DkzFXpb6nkn7g00etQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org, 
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Aurelien Jarno <aurelien@aurel32.net>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Aug 27, 2026 at 6:32=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 8/27/2026 2:44 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Aug 26, 2026 at 11:35:11AM -0700, Pierrick Bouvier wrote:
> >> Seems like the Genius.Artist. in the bottle just need to escape, and y=
ou
> >> can send us a nice series doing all this. Meanwhile, I'll try to find =
a
> >> carpet, a monkey, a princess and a suit to be the next Aladdin.
> >
> > This kind of comment is not productive and disrepectful to the time
> > reviewers in invest in looking at the proposed patches. Please stop
> > this.
> >
>
> The only person wasting everyone's time here is YOU.
> There is not a single person who came on any thread to say "I agree with
> you Daniel", while several posted or commented they were ok with the
> approach here.
>
> Project is QEMU, not Daniel's EMU.

Whoa whoa.

Sometimes people don't reply not because they disagree, but because
they trust the people involved to resolve the problem.

Let me remind you of the discussion we had about -fms-bitfields and
how it was resolved amicably and profitably.

I will read the thread and try to understand what's going on but from
the first impression, "wanting to keep the single-system
qemu-system-riscv64 instead of a symlink" is a valid objection. In
fact, with the proviso that I haven't read the code, I don't see why
you'd want *anything else*.

And especially, "How surprising (:eye-roll:) it is that adding more
code and more classes would result in a higher memory usage, or bigger
binary size for qemu-system" is not a good way to conduct a
discussion.

This project was extremely complex and some disagreements are normal,
but overall I would say it has received support from the community for
years. It is close to the finish line, let's not forget all the
collaboration so far.

Paolo



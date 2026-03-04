Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72E6EDEBF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgZF-0007FK-KK; Wed, 04 Mar 2026 02:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgZC-0007Ey-Kc
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgZB-0003BJ-5S
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772608964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPCfb2FDxLMxN12huZjUgdujpqtuCf8kw0/k32NLDjM=;
 b=iUq8EXn7q1rewOppBaj4EpOssNTBXLatQ8ihCY7I69eF8Y6QS1V2kcu2H3CFs2kN+Gyw0U
 xa11ErDcNUluJvNyz7Ls9yxCs2k1hTXEG1xs7SujDlB3mWJSEZm7rABdX1z1i5a9V9ge7Z
 9EKkWvvLq1d8iwx8aoj+I8tvZ/WNhsU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-M-55dQEkNjCl4SrhREuqcA-1; Wed, 04 Mar 2026 02:22:42 -0500
X-MC-Unique: M-55dQEkNjCl4SrhREuqcA-1
X-Mimecast-MFC-AGG-ID: M-55dQEkNjCl4SrhREuqcA_1772608962
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ae405e95f5so39842235ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772608961; cv=none;
 d=google.com; s=arc-20240605;
 b=akaJVYtuht3apPnCDrulAiZiJYW3P3tvFKp57R9iBaNAt839m61KTM505c1yi05spO
 z1rDyc2TH/nf8aCPxGtMsC7iBsYjW8dDQDFjDWEI5DuArmqPsL4pACw9UspGSRMwI2rs
 HbHh/5B42jz2/qqS83trYuUWo8m+k82Z6lRjKhw/hMD323P/n0cisDNER29WEl02FMDX
 91TGifWWfu9622gKXkqtyaQ14/j6YFshP79RgnAU4T6MfSge+bFAb9SMTXT1XwNUyCVT
 gh0o2qYbUP9zkvUfEN1cBgRj7Qyw49SnPy67CIJDc3akfb5/c6Z2Yse4PwjzPV2dhZ8S
 s9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zPCfb2FDxLMxN12huZjUgdujpqtuCf8kw0/k32NLDjM=;
 fh=0Jvbt9B0s8bGT+BOpSkFXAj7zmYT/Alfm5/SqFIk/6s=;
 b=IbzYueVkchf16alEubK0FLPdis47LemHrqDTX6dvhRMZPp7vEC9WNX80PHP6qVfQHf
 5qM4V1sIJRBA5CGtR9EzM+RESeVbNLTvFDprX6TooBJHleeA09SVyV40BbPW+W8QnJ1c
 d4EYIRvZmwptBgtj9rSB422BmWG637A9VAmEv/zMezb+B8Q6+7awg212fszodoGKpfSY
 mn38E0xGWnLA8fdhRfa6On0STXTf4z3xLwD5r+eLYNNfrcWppLtjWgCM7hqVhinFeUZI
 4H7EBLpMjGHixBK4MY5AXgSipUBTE0qrK+zRGdSwmXB+gYzCz4oDrTvVwOAPZ5we9zFu
 9KHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772608961; x=1773213761; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPCfb2FDxLMxN12huZjUgdujpqtuCf8kw0/k32NLDjM=;
 b=PxJAFuxuh7uTd9Wf+bOi4rmNGnrN4lqgcKdxbDaSW0SfFmZ6tjudk41b/jj4Df92sF
 6CGou099qCF2Rpd1GvwHdRZySlchRTIv3nfGtuUragmosbvnPlLt/B/amKHHJ6wkI92L
 rMdFO4TygHPXeCaoQ/2KXzh48ysdnEj3iV9K5nrdOfkrYcmXdzn2KUbXcDWRbaX9+CSE
 A5CubRuaoYhsaK3BSW2CFUBuG4d1UuZhaLsT+3cFKyr1Uvvx/35Jrby/9HJ9jTBbW5x8
 DTHzdLIJwT0MaI/Q0e2k7A9oeO3QGfdFOqMumNUTazFwRnSmet7nvXtfHlIOlAMM6mhP
 G+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772608961; x=1773213761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zPCfb2FDxLMxN12huZjUgdujpqtuCf8kw0/k32NLDjM=;
 b=WF8J36ItwdHsuHYf0Z4bq8/y8qmNhTXVYYH+hbhYbs6iqZwBIU9eGXqlevfe1/bH2L
 sgErRX8gqahEQNZHd8z7V9HwDB+mYpLDgi0ZAKX+ujXDo3pO5Za2yVCPeXRQGs5maLoG
 9AOOk+aaSihIll+U2VX7SXbz7Fg02Z5sDaek/pygJ+jGzyMJgDhhYuzKemSlgMH87whE
 1e/cheaCzSfpwkpcLGgsrBp42tUB7zDTy3pDd1yGAvW1wqq83Yk6+GrP+tJER6rqEN59
 tYNMHKe/bQ1ZlZiGEpQGFXz6P/G6zYkNau65QCa4M+0Y8Bcm4Aa32JMp1G4BfjqTalpN
 F2MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTwId1Oi01TKxnXAn/6nMMHU+trwHKrpxTZj5sUvL2qu+tGzvbcw2O8rAT0HGIqN1uktzLdMsWJnEF@nongnu.org
X-Gm-Message-State: AOJu0Yxtl1++95wS/uckTc11FXPLVT0xbprePM2Xna8ebO5zykKuAJ7v
 JGJ3Xl9oZdtyZFQkHVQahRJBEtQQNK0Le06qPjsniN4+M7/hnlB6wZZRyhNdBG3xWEBFficbuX1
 i/R/Hqs9jtONkHuvyT9T6m+TzOiUcNsktM9Jp4frO1iq8h1nnX4uRhnZSqz7ew35mQmOqNu65aS
 iauvOzMxTrF+hilG4gXQglzSjvMXD5lk4=
X-Gm-Gg: ATEYQzzQWqqCrZKfeeF9S15y0jvo9P/BHig8AOagacWcremo8KFax3RLjDE/dBLndRl
 qRTMXZvkM+cGp3d3m+PVPF1ZkZWgTF/k63DHNQ60rlNBzUbutWqc2202iqHqQV2ubKf/kW8c+xX
 GJN/ZCDQ+a6EOBb49mcsDyb9vCoEeHnxSVukEZKD2+80+ixmL4McsHLOs4Vmhl8eViHKbYZjcD6
 V5N8Ug=
X-Received: by 2002:a17:903:1508:b0:2ae:572a:9f19 with SMTP id
 d9443c01a7336-2ae6aa365b2mr10704245ad.21.1772608961622; 
 Tue, 03 Mar 2026 23:22:41 -0800 (PST)
X-Received: by 2002:a17:903:1508:b0:2ae:572a:9f19 with SMTP id
 d9443c01a7336-2ae6aa365b2mr10704045ad.21.1772608961148; Tue, 03 Mar 2026
 23:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20260213071042.3733239-1-lulu@redhat.com>
 <20260213071042.3733239-2-lulu@redhat.com>
In-Reply-To: <20260213071042.3733239-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 15:22:29 +0800
X-Gm-Features: AaiRm50paf47LG6BqQJjtbXKtkDk1oN3jSdcg3gB85vRVIa5TF9EJ3VTotRAN-A
Message-ID: <CACGkMEthjvROiDq4p7FyNOA0gHA-O6UpmEx_9nt9-zLh97pp8Q@mail.gmail.com>
Subject: Re: [RFC 1/5] net/filter: Allow redirector on vhost backends
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, zhangckid@gmail.com, lizhijian@fujitsu.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Feb 13, 2026 at 3:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Allow filter redirector on vhost backends

This can't work for all type of netfilter I believe unless we
implemeting a general shadow virtqueue etc.

>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  net/filter.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/filter.c b/net/filter.c
> index 76345c1a9d..bbede6b085 100644
> --- a/net/filter.c
> +++ b/net/filter.c
> @@ -255,8 +255,10 @@ static void netfilter_complete(UserCreatable *uc, Er=
ror **errp)
>      }
>
>      if (get_vhost_net(ncs[0])) {
> -        error_setg(errp, "Vhost is not supported");
> -        return;
> +        if (!object_dynamic_cast(OBJECT(uc), "filter-redirector")) {
> +            error_setg(errp, "Vhost is not supported");
> +            return;
> +        }
>      }
>
>      if (strcmp(nf->position, "head") && strcmp(nf->position, "tail")) {
> --
> 2.52.0

Thanks

>



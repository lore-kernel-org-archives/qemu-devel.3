Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D29BC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Dyt-0008S4-Pl; Mon, 14 Sep 2026 17:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1x6DyZ-0008RE-5Y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1x6DyX-00023U-MK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789420346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuySwFSRizvF8YCRLEqB+1Wlcx4ShRq1qw46imCxIzA=;
 b=dLKGgsOs3fEAuv5p2oNtXraCqeEFpiVY/vJpeT0wKI77UBhYUdvyBiaL7IDhb4FS+BeDdX
 cE5q5iigXgSTSt9MDj2SUIKN8qMEW3LCjhnCQH+RZkOscH+ZHqFbQISPnxDEAXuAh4h0oj
 dEXqCnQ94DUbtP9LiMi6U5spgZwGgp8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-3LvhCL7NOmiN1JWc4HpH2g-1; Mon, 14 Sep 2026 17:12:25 -0400
X-MC-Unique: 3LvhCL7NOmiN1JWc4HpH2g-1
X-Mimecast-MFC-AGG-ID: 3LvhCL7NOmiN1JWc4HpH2g_1789420344
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so30106005e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789420344; x=1790025144; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NuySwFSRizvF8YCRLEqB+1Wlcx4ShRq1qw46imCxIzA=;
 b=l1lQD13vMhoW35c7AXCPEhvrTVT1U4utBwad3bzd+BttdbMkrUkXQ66IdbtPkCC83L
 COWR13SC8LujaTRmooEAQulNQY8Qy7LwtbUrvpFHev6zX613UGjFK9hD1Adl2Danhye6
 eIyj2UUgZRatZt7FzPJ7gcUYzAXvBkJHsbPN91kSPYl6WAYAAatD8k+qwrqcxUR4gBQZ
 crcweG04n+mdTNed+f0YFWh/ukednbrl+G3ZG/EfgCUjEz9TtbOk+6xhKUoxku07owiJ
 hI5CGj/J4OE/VMTZRWpHEXq3W+rdeoYcvVW4MsCyvOf5coeTwTcyOsfwXk0m0JIqN0GM
 08dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420344; x=1790025144;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NuySwFSRizvF8YCRLEqB+1Wlcx4ShRq1qw46imCxIzA=;
 b=PW0tj7EAGmP5+dQFFKAUDp9Xhx2mLwvuiXbkmiLk5FRODXJPPs7mmZixWjnxjhwpjH
 W+3fyZ2tiygYGLUcltS99pv0fyTJhG9UzL/sYz1KFPzTQRhmlDZg6kwvLDCxpk6vXdRP
 O1RNzOZy+23Q2dVziYhE9Y9skTf2wrJCY7G9EWQiNLPwKrh0zgpf3uz/PtUUyuyLeHhl
 Eqq7LXt4CBs3FEs939yVFUsjNhyoi2H6a92EtySjx2ejgVU+jsRNBwzjXdL0iashiasj
 aV+3iT4DrKkPPZ83WXSg2LlEt2CGSbAFGNUAnoyVJMY3eHDIx7TtizLZe6QJgOEIhxCK
 L+Hw==
X-Gm-Message-State: AFuF++mrK27aZkaOcFwU8Rn0D0ijw4FkvctCyzFfrcCrDv0ZZjHruB1q
 +3K1vghO2bhrE0DxGSnoOZFpzuHFDtRPO9BMXPViysUDYi6AdI3Kbfpgnk1G2h4If706rS1fMVr
 vu0lIfawvNHIABVU1q/0Ofm/NU9wwqVOKG+RZjxiRAN4TkzCF5/qDzTzs
X-Gm-Gg: AYBFou1FuKNLeLK1YqH0Gs9i5PEgB0t+qwZA3dbiIHO+lCKMvs8PP62V/eUeTXl2ljJ
 SwuxOqVgSHhWGf28vo1Jg6l+fL+TBYAtIFLBVypduEchJFpiullIQZIJZYwwiSHsDnilTDQkPnJ
 aD+HEEDpvigMemRoh2cvMf5J9Rz8s9rr5kFbzCKbHH/vTL80aaTNaLOBcfFWr+HB/rOIghaoraO
 tjclPjQy9hO2U8Ew5qUZVx2+yCjOzg/NNOZij0TfO0VVEi6YChuuv7rH3fiw5SjsyKLXwJguM5r
 qoQSJzMiXv8aPXnOx06quIV1uyxStPRmElvkGwkd0BnWcDkDFt/NycjhZF5LzOjr1m0qoa1mZY9
 yw6cZPBBtPl/P+3U=
X-Received: by 2002:a05:600c:4e90:b0:49e:6e94:7cae with SMTP id
 5b1f17b1804b1-49e7a68bb2dmr59549535e9.28.1789420343972; 
 Mon, 14 Sep 2026 14:12:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e90:b0:49e:6e94:7cae with SMTP id
 5b1f17b1804b1-49e7a68bb2dmr59549305e9.28.1789420343624; 
 Mon, 14 Sep 2026 14:12:23 -0700 (PDT)
Received: from fedora (nat-88-212-16-72.antik.sk. [88.212.16.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d27c88fsm20444335e9.2.2026.09.14.14.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:12:22 -0700 (PDT)
Date: Mon, 14 Sep 2026 23:12:20 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] io: cork TLS writes to avoid small TLS records
Message-ID: <aqhiq5OBRqBNoMsm@fedora>
References: <20260909120033.1303511-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909120033.1303511-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Daniel,

On 2026-09-09 13:00, Daniel P. Berrangé wrote:
> The migration code caches vmstate/ram writes into an iovec and
> flushes this periodically. The total amount of data to sent
> may be 100's of KB, but split across many iovec, each of which
> is potentially quite small.
> 
> The QIOChannelTLS receives the iovec, but since GNUTLS cannot
> accept iovec data, it iterates calling send for each element.
> 
> As a result of the migration data pattern, this results in
> GNUTLS putting lots of small TLS records on the wire. This
> has shown writes alternate between about 4k and 30 bytes
> in some tests.
> 
> This is triggering the nagle algorithm on migration-test for
> many of the TLS test cases, resulting in a "go slow" for I/O
> that eventually hits the migration timeout configured by the
> test.
> 
> Not every contributor reports seeing the "go slow" but for
> those who do see it, it hits >= 95% of the time for at least
> one of the migration TLS test cases run by 'make check'.
> 
> While we could disable the nagle algorithm (and multifd
> channels already do this), that would stil result in lots
> of small TLS records hitting the wire which is not good for
> throughput. The migration code flushes in batches because
> it wants large writes for high throughput.
> 
> To achieve this we must tell GNUTLS to encrypt data but not
> immediately sent TLS records by "corking" its output. Once
> the complete iovec has been written to GNUTLS, it can be
> uncorked allowing it to hit the wire.
> 
> There is added complexity with uncorking on non-blocking
> channels as not all encrypted data can be sent at once.
> qio_channel_write() will return what was sent, but some
> data might remain pending inside GNUTLS buffers. A later
> call to qio_channel_write() will provide the same plain
> text data buffers that have already been cached. Thus the
> code must attempt to uncork GNUTLS again to clear pending
> data and then deduct the equivalent amount of plain text.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  crypto/tlssession.c         | 33 ++++++++++++++
>  include/crypto/tlssession.h | 25 +++++++++++
>  include/io/channel-tls.h    |  1 +
>  io/channel-tls.c            | 87 ++++++++++++++++++++++++++++++++++---
>  4 files changed, 140 insertions(+), 6 deletions(-)

I have tested the patch and after applying I could no longer reproduce
the "go slow" issue.

Thanks!

Tested-by: Juraj Marcin <jmarcin@redhat.com>



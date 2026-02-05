Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF1DECD983
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1xS-00009E-O6; Thu, 05 Feb 2026 11:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vo1xR-00008T-Cx
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:11:53 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vo1xQ-0002LK-0Q
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:11:53 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so1421454a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 08:11:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770307910; cv=none;
 d=google.com; s=arc-20240605;
 b=M+XOuTrPRYRaccD0UXkuRV6mMKxkCBDq5crqYJHPS0z1rNSYXuB9isLQ6ZhuNUu/WX
 cBZUggLzo5MucXqWJoJ6BeUud3AQ1tjjSPT14P54SXpmdULhK4q9Kkh+PSEkfgVHSHGR
 feP3BTB9BU1JtR6+7BOBmfz8OCMD5+Fuhv0Ij00shOsKXsqsO565NkNBB+We3WBIKuvv
 2d4lRBl+/cq7yrvDvmycee+U24MzjkSXZjEYIQXG6l33KkMwLSxsqn8gQgS1ybklSAgy
 1gg83ElC0rYcJ6jmsXr/EBIJr5BVozhq4cJXDivoNg2No/FB6S6v+s0YOq+Kqk703myd
 2j9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZEAulOogOB2cwa/01qJPOgaYVnbV9sDjLZZeVQzqNHA=;
 fh=I3hQHJzihTXf4lvxJEMrc9uVQd0Mjc8e1e5DbazHfZI=;
 b=JLMYbAvicW8le3+hVuTKF24ubYGYoc4nuXpRWhU7ra5tMQF82NdukLdm0AdHKU0x9e
 LvFHswHzlu8Adhg92VMgYevv6Gw1qb5yQ3dHbCUWy6g50vzNptva+JM6VPc+wrNZMU52
 5l1SHp37S1b8LWEN9QJZ/q4kYgfXaHE+AJwSPZyBFMnkmMeHVC0kluiY9KLE9jUBsnuw
 ohgaov+OqbzFqsIbly6y8qkSJ8eTnNqLt3mPQvTMxIRMFVsWJG+dvXND3oe8R7hQzkb+
 YfpHkVHlbIByvH2dDAbhf36IjkckrsKzCqQQXR/RkPCoA4zbFvXMz/ADi0f9tqKcsWJ9
 3Bmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770307910; x=1770912710; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEAulOogOB2cwa/01qJPOgaYVnbV9sDjLZZeVQzqNHA=;
 b=l7w4S5VhaJ5Qo4z7rFg2LyZIbREPz1/vfmH+Lu5cdFzxRf/Mm0yCip4px8EdvfM+wW
 rBalYb2T4OHK7xpF1js7FWBArxjt9wSkMYXqSja+FOKyp0RMVVIaXtj76/d3QR1iypSC
 hXzFQPDkbE0cJPRDurQG9J0HAnCnf4tYvw1Uihn1VqmHRv5C8UCKJNSC1L+Y0cHnAsA2
 7ALcrvL3v+1NbHXfPr/hTlqlRoyBY3K9QW6uO66vTqPPAELTdVSrnBkwRhYLHZ+fqQ7Y
 EHiQHnbpMyGifsfUn9Ne4JdM7e8iiyG8SEVaq6XM4lSthHWnAiGv3L8ufXv2K3fCCbZU
 BRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770307910; x=1770912710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEAulOogOB2cwa/01qJPOgaYVnbV9sDjLZZeVQzqNHA=;
 b=ctZ6mgJz3j5Hm7UUt1AaKLBQ1LPbmRq5NDD8NhjjpTRj3ir1+Wp9/HcKuuYh3Ee4sj
 ncnADA0Vys09wnKxHiYlubFCc2CYwEVYWdhNarjnFi+Tklr0pL+3mxi9Jl7R7IrifRSI
 CZmU3vt0SR1RJtt7kPDGA/ufPaYUSuzy0GJi2m8wvModO+fUyS/dDDVbBb2Yi0hskxlJ
 Lpqu8kKW7cNFt8RRBrEzIwDYCWKzwkyfAGg1SjGh5M7l+aFyfaml6ug8hYWBcplpB6dl
 i2+Ele2iyPhlJNA7YjGG1pnIbOgyHgP7cipqwotlfOz6d03cISkAiiLoM20LtZvw1pcc
 oCiA==
X-Gm-Message-State: AOJu0YzZ/RfWI/54i5xgp9AxaPWIY3DD4x09LRk7nSn8hXmsB0cG5Hz0
 QFoKzVcqWpMWLWg4ajjN337WeOFNTqD0CsChFByAF1prCZVIWQh7ccjgpdyYGSqFsmRBFV3HAwL
 48s2jm3zNteh47wG4fXgw1cSMrtytD04IRA==
X-Gm-Gg: AZuq6aIBJRBrz+DUW9/3tWjYKDh0rb/85k8CBwW2C2E++xJInUweynUJA2dzRUquVnv
 MJKmpCJ9/OQs1lC0sd+QYmgUnQ1sTJf06up4wmJTmyXfcX4cDbVhKBpVspvrozWmvtOKfWOwa8l
 t4jfUat6DrP+NePCxQKrXVaMIBee74eYqjFd1wt98IjjCdudlpFp2FfQglgrKco7OjhmVFGcLyH
 Ug0zVtXrZz/RlHhEiPV/7T64wGV3JoWxcTlbYM2GKdJeaowAOKKhicESTlt/dQ3cudISQ==
X-Received: by 2002:a05:6402:1e92:b0:659:3ddc:d04a with SMTP id
 4fb4d7f45d1cf-65949abb942mr4512964a12.11.1770307910277; Thu, 05 Feb 2026
 08:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20260126092854.20343-1-zhangckid@gmail.com>
In-Reply-To: <20260126092854.20343-1-zhangckid@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 5 Feb 2026 11:11:38 -0500
X-Gm-Features: AZwV_QgNA6toJYl3HHkOk-bRGltKHolxa0shZlD3rJldtIljjRYdYRuX4392EyE
Message-ID: <CAJSP0QXK81HLhdAA4KiwhwJbQzjzPtrqVVUO=C14kX=u2b8G3A@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] qapi/misc: Fix missed query-iothreads items
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jan 26, 2026 at 4:30=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> The example is incomplete: it misses members @poll-max-ns, @poll-grow,
> @poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
> (monitor: add poll-* properties into query-iothreads result) and
> commit 1793ad0247c (iothread: add aio-max-batch parameter).
>
> cc: qemu-stable@nongnu.org
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  qapi/misc.json | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 28c641fe2f..1f5062df2a 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -117,11 +117,19 @@
>  #     <- { "return": [
>  #              {
>  #                 "id":"iothread0",
> -#                 "thread-id":3134
> +#                 "thread-id":3134,
> +#                 "poll-max-ns":32768,
> +#                 "poll-grow":0,
> +#                 "poll-shrink":0,
> +#                 "aio-max-batch":0
>  #              },
>  #              {
>  #                 "id":"iothread1",
> -#                 "thread-id":3135
> +#                 "thread-id":3135,
> +#                 "poll-max-ns":32768,
> +#                 "poll-grow":0,
> +#                 "poll-shrink":0,
> +#                 "aio-max-batch":0
>  #              }
>  #           ]
>  #        }
> --
> 2.49.0
>
>


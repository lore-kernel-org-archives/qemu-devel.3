Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B65C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXAe-0005Ft-9H; Thu, 27 Aug 2026 06:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzXAb-0005FZ-QV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzXAa-0003mz-9J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787825828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D+aK8WAnJSSk6JBgSqQocyHNfItUsYfYzgJcZZ5743U=;
 b=J+AOAmXvhFRfr0zalv7L/GVbHtiR1N5jm4skdeD9VF13ycwC7ZPPKFl4qeH72g2P/CO9v5
 KluhYD3VvS69Lk1SCkxC80l+w97hUg0kMUoSZnEshBCIp/Kl39O2nntyaP0Ntu9FBPbFbO
 lQojNXwbguyHYIn0k/804fQW9LkBaRY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-cKxbqMkWM-2J9I4bG30pSA-1; Thu, 27 Aug 2026 06:17:05 -0400
X-MC-Unique: cKxbqMkWM-2J9I4bG30pSA-1
X-Mimecast-MFC-AGG-ID: cKxbqMkWM-2J9I4bG30pSA_1787825819
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49545071724so17656425e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787825819; x=1788430619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D+aK8WAnJSSk6JBgSqQocyHNfItUsYfYzgJcZZ5743U=;
 b=f8lmxVzHyM7fmsweY6OSPX2W57RJWITmsakd4swizq1arBkWixvKOYu89cEP1o/laD
 FnmGun5e3EZfu1fm4sBPHh9Os9CsuY5slm4S6GJwxB7H0M3WUdBGgcZYIrQLgxdwrZPq
 +WGOYmVeGP1gMgRUtIAd7uJKmMyHX6d2rFzKeGfJd8/c5zyjpwvax991DDPnkMgyHNHq
 6JxAJSC8rOYZHNs2dJGSqoBNJlQV/sF7LvYa/qAC3ihddlnXuKWIXx0u2OnWunOtDISe
 1x9A/G1uhDbfJeXMqwss+lGfdOz5eeQHdigdF3hHxyGefD2OQtkt07c8b0ycWIQkXSnb
 O6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787825819; x=1788430619;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D+aK8WAnJSSk6JBgSqQocyHNfItUsYfYzgJcZZ5743U=;
 b=I77U0qob+jkggwHI7PlU1/tL6WnDILWz5rcG/d7tndFyfa9gUQFr8FvctUpl24IkRH
 4VEnr1a5WNZXL1cUxPfGTxQ//+ZcE6Z6ENzjWfEvwxQwU8OrGXYX7gevCbZ3n2K4CfMO
 HPAIPBu6wlz/HtwY+BqNq0lp+gDcbe0aJxdfSSXD93YYxH0LPs9Bku81uIl0Dd4jlcC9
 dwE3ixvLiqTy0giOk4Ooh+yznxL+I8xTUuKt3QUUlS6lRSA70af/dUczuR+lqRBqWnpo
 +63Mhi4/WEFA29v/RAxPCiUQfh8o8BM7VwtV8TMvJhls4QCOKHHYBjzWavw+uGg3S7WS
 5FYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPDNTBVuY8WdDR+Ry2wDAhWU/pCH7FlmX/iSawsREknoPibW12h6SnicsGD8RXOfAPEVUIeMG7PScN@nongnu.org
X-Gm-Message-State: AFuF++n49wnWBY1JUcehyR2PGajWUMd/q9Anux+89mygQgRPjKNrWIrL
 fkQ2MCmopmouLezyLP2XHWrCU39nu+55IvhWQZjMJpDj5IURgsqVdgtZdRtH87XY9JOqCNYXVNh
 0a4XuEOQpd8VYendeJiiNvd6STIB2Xzv/qEZIVb8iwhcZflxGD1sO15rJ
X-Gm-Gg: AR+sD13VBCnv7D8SEEWIU41Vnu2O/vE/DOe/MykVitLd6M1YaVcTBB6BDjn65BGPl/a
 qUmYw5RRypapV8UFYS1Z8wUnJOzWc0urAMaH98+00Znvpk3xv4wtoPquKqA0lbmRURTqRNJklEx
 FQyknQGrYp/fQGBoReLgKIa+C9fbBmHte0LX2gLjsGLRfLAA2TkL2+DWY5F9hVnEe6ypoIk8Hzi
 17u+SqKSbUoyDbn2SKn6gjEOuKCw9ApOYRSbCM7WLmwGhRtJY6+4DoepKWb7XjuvVjr3d4VaXTJ
 WdqrjgUJmfeOPJ8pdV8lyRkwwdsue85EbOCeB63y/MfGNxDZRRePoBowEP2Evp56LBvXfoMqZQ=
 =
X-Received: by 2002:a05:600c:1d15:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49b0d4570b4mr88749135e9.8.1787825819261; 
 Thu, 27 Aug 2026 03:16:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1d15:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49b0d4570b4mr88748465e9.8.1787825818912; 
 Thu, 27 Aug 2026 03:16:58 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab569sm7819124f8f.16.2026.08.27.03.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 03:16:57 -0700 (PDT)
Message-ID: <a1a7cdc7-5458-4d1b-bf1e-9aa89502317b@redhat.com>
Date: Thu, 27 Aug 2026 12:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] tests/qtest: fix the disk tests on a host with a
 small /tmp
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Fabiano Rosas <farosas@suse.de>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
 <20260824200627.2180635-1-den@openvz.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260824200627.2180635-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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


  Hi Denis!

Please make sure to CC: the qtest maintainer (Fabiano Rosas) on series like 
this.

On 24/08/2026 22.06, Denis V. Lunev wrote:
> John reported ide-test dying at startup in the NetBSD VM:
> 
>    ERROR:../src/tests/qtest/ide-test.c:1260:main: assertion failed:
>    (ret == 0)
> 
> The hypothesys is that the ftruncate() of a 64 MiB scratch image. NetBSD
> mounts /tmp as a tmpfs sized at 25% of RAM and charges a file its full
> length themoment it is extended, so a sparse image is not free there and
> the call returns ENOSPC. The assert dates to 2013, nothing regressed.

Does NetBSD have another file like /var/tmp that might be friendlier to 
sparse files? If so, maybe that should be used instead?

OTOH, our NetBSD VM in tests/vm/ uses 4G of RAM, so a temporary file with 
just 64 MiB should really not be a problem...?

...> Hope this should help. John, can you give a try to this in the test?
> I do not have NetBSD handy and will start with this tomorrow if you
> will share guest config.
Simply type "make vm-build-netbsd" from your build folder, this should take 
care of everything automatically. No need to install NetBSD on your own.

  Thomas



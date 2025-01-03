Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACEAE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlmt-0007Ll-Rn; Fri, 03 Jan 2025 12:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTlmr-0007LJ-Sy
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:48:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTlmq-00086o-0l
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735926513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBCAePmrp4P1unv2+yRdMNlyOG79ceGY79ZwobaJ7Q8=;
 b=ZGllZPyLETH7+t/t+R8KnnwGZjNbyMfcMu/vp945fnO+81CKzvTud9lakhrgPBGvceh2GR
 nv/oE6DYjtMm8fZu6lqj4mJjTEp/+qi63wLdJE1/ObIXab6fYlLFiv4GmY4Z5PDIFwHjNd
 gM3qWY5RIhCd60zwX7OPVJC52gK37bY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-7zVIRXwHPyOIqRlLD1CV-g-1; Fri, 03 Jan 2025 12:48:32 -0500
X-MC-Unique: 7zVIRXwHPyOIqRlLD1CV-g-1
X-Mimecast-MFC-AGG-ID: 7zVIRXwHPyOIqRlLD1CV-g
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d89154adabso233662486d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735926511; x=1736531311;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBCAePmrp4P1unv2+yRdMNlyOG79ceGY79ZwobaJ7Q8=;
 b=kD+vMenes/yng6uRznAL+/zHXUDe4s44bXiyis4cQZFFZAdFw5cbdP16kE3HKJIiQs
 G9UsufsFFFbuQrr+v0eeoh3sTmSGTMjilTc1Q9rGuWS2d4fYMekXH8Uf7PQ+PAlHEhWS
 gbmaM0KaeA0issn0nn/CC5NgdJzMLhVSKJBeWMtpQrvxFM5xnXRFV0ylH2RQ45oRJDsM
 outJdkmIf8gW+cEPYDiW5rKLoNwNv3Mav0IAo14i+NjZn2YX1U2zgdAJ1qKrmb1s7lC3
 9nQKIL21qTDtG9V/uF4/pRwDr+POGbYFhiQOKkSMT6EKNy3oJB3s7ok1octLjxT4MS0Z
 S6Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUkdKRRDXba22TJQVR9rJADehlN68jm8hOLX4NkcM3M+GHU114vmZSQEdvTm/5ziuzv9Lbw/RJaiNF@nongnu.org
X-Gm-Message-State: AOJu0Yxv1ZDQ5osMimRpjSP/ONb+tYEbGJwkVOdt+Iabl/oLfNV1kXHG
 KnYKVZOXCp9QXQhEfqXZEqThZ+llrtu0YV/iE1KOhQl3AsodhLFP3Tct/iY1eH3FRC45eGyObjr
 IiLqlC0RObvyonPmHEOMmKqIhmoPkx3MbjO3Nwi1GXSPuKyaLNGVZ
X-Gm-Gg: ASbGncvW9kbstr9/lk5O8vPMPE5MtB/9IKqSk1CIIdSkcjlsRsHAXwHmW/hsjysoWkr
 0OXMkSLgJyb45AaCbCDJ1r5GPDdygn764QiSwLY6mNPc/mifryydym5QpE0xcbVZNx18QR5zGOp
 UFNS50UG3x6wU26wi3OjUm2Bbg5qi6+6l8fBhXJR5NyU9fWgMrd+jXwv+Jde+cplZTd//j1rZAd
 pt1HEoI89rqHTiaKSgxcsuf4ee/4YG5f/aiN5p+Vg5wtTPzoxIdjKHSxpMnTSZzzPtze31bw3u2
 8IrnTpm7xH2F0yB8xw==
X-Received: by 2002:a05:6214:5c46:b0:6d8:8480:27e with SMTP id
 6a1803df08f44-6dd2332f1c8mr766479826d6.11.1735926511618; 
 Fri, 03 Jan 2025 09:48:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL6X6ohDhYbrBpxY2dJRH28tJ5k7YA62V7HRv/FUi3SYfBqHXzjFRbQ6QwwdrbOoHg6aY3jg==
X-Received: by 2002:a05:6214:5c46:b0:6d8:8480:27e with SMTP id
 6a1803df08f44-6dd2332f1c8mr766479536d6.11.1735926511376; 
 Fri, 03 Jan 2025 09:48:31 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd31faa052sm120860756d6.9.2025.01.03.09.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 09:48:30 -0800 (PST)
Date: Fri, 3 Jan 2025 12:48:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] system: Try hardware accelerators (KVM, HVF) before
 software one (TCG)
Message-ID: <Z3gi7ANjATS7Hxyx@x1n>
References: <20250103150558.1473-1-philmd@linaro.org>
 <Z3f--qO8x45MpiXQ@redhat.com>
 <d06dd874-c6a5-49ba-89c1-60668ad639d4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d06dd874-c6a5-49ba-89c1-60668ad639d4@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 03, 2025 at 06:16:38PM +0100, Philippe Mathieu-Daudé wrote:
> On 3/1/25 16:15, Daniel P. Berrangé wrote:
> > On Fri, Jan 03, 2025 at 04:05:58PM +0100, Philippe Mathieu-Daudé wrote:
> > > As Daniel suggested [*]:
> > > 
> > > > We should consider to rank HVF above TCG, on the basis
> > > > that HW acceleration is faster and should provide a
> > > > host<->guest security boundary that we don't claim for TCG
> > > 
> > > [*] https://lore.kernel.org/qemu-devel/Z07YASl2Pd3CPtjE@redhat.com/
> > 
> > Note, my statement above was on the basis that HVF passes all our
> > functional tests, thus indicating a decent level of confidence
> > in the correctness of the HVF impl.
> 
> Indeed, I forgot about that, and only tested in my 'HVF-only'
> directory before posting, but ...
> 
> > If anyone knows any show stopper problems with HVF that would
> > justify blocking its promotion ahead of TCG.... say now.
> 
> ... here we go:
> 
>  3/15 qemu:qtest+qtest-aarch64 / qtest-aarch64/migration-test       ERROR
> 0.88s   killed by signal 11 SIGSEGV

Hmm.. I think migration-test specifies either kvm or tcg in all its tests,
so I don't yet know why this patch can affect it..

migrate_start():
    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                 "-machine %s,%s "
                                 ...);

May need a closer look on the crashed stack.

-- 
Peter Xu



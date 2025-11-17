Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4FFCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2JJ-00049T-91; Mon, 17 Nov 2025 11:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL2JG-00048c-JS
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL2JF-0000oH-0e
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763397751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UdwcF+zDcwdUStfpneb2VqZWSJyFJbq77zz4pO//Wrs=;
 b=KWuqXSmKgmBI/pP1f0sGUqiCqSt6PHbft9NDAmSfjuyxKfLCeZuLJtEAE1jysflQm/vCUx
 dUQXzxCFVimizcEdJ4DG1j7IixzSXunhF5qlo1S54xBTt0C3N0zKkkXTvvZoGXPAkKDSHF
 KegC19nIPtkVBjXodGbJRfeMOFkVaTg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-tBEU2s_qNPKxCphXtFzllw-1; Mon, 17 Nov 2025 11:42:29 -0500
X-MC-Unique: tBEU2s_qNPKxCphXtFzllw-1
X-Mimecast-MFC-AGG-ID: tBEU2s_qNPKxCphXtFzllw_1763397749
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee168a520bso65774351cf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763397748; x=1764002548; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UdwcF+zDcwdUStfpneb2VqZWSJyFJbq77zz4pO//Wrs=;
 b=Lo38NKjBY/Nx9WUuKIR+85E7DfYXlmkk+UM+fwd2MZJ/NJn7SweuCs5YgqWqSrJ4Ht
 WUPdRX1O+5Yt5pfPrASzjVRWLfnpdkgKthO91cx8GjNGH/6MiRdpIhTfKz6UY/TI8ash
 eacs+aAHF1nUOA4ratkYNv3ZCtmKs1brZMG8MVrQDn0hmbs28DqpcJwziSg3d8bQCeVy
 aqMUppYzW5WMrd0wOThmABkLzApHhqfoH+eFSvTxZE+96CUtlQmdY7C13CU9kLynqYwf
 zmkbiaky8XINvHxozFVUZ0bOiuUU0SUwDtfleDMrHzTuOlipOoTtxoK9pRBt3RdIZizK
 r6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763397748; x=1764002548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdwcF+zDcwdUStfpneb2VqZWSJyFJbq77zz4pO//Wrs=;
 b=LbplhDAz5rt5iQH2a2sBKXR6tEyjRNsGuganLUrpGsYh2JiBXPrs4EsGsibMkC0uBV
 ahXWBbjNAkSPIrKrPSoeBq3otUB+S2O8qQL60ra1BWdolDf7O4u13FyBoiVt/r5n7RU4
 EPeQOUjSArF9kwLpyGKn72h6u3T321+OfSgeStuJKqG7tvyK947GsarmuhxYnXUdMocJ
 VU+Vw2+XEuKCIyc288Vsimh5z8f1FkxTqUskguhdmqI1iZFDopUJrb9xQ29lmunWpAB4
 uO9EPnhS14kOOdJmIJDfkZfS3tIx48G5kJqoFvgmqQAgtudqhW2aiVX/f+Tlu29mou9J
 QlVg==
X-Gm-Message-State: AOJu0YxkL9ZpzuLacBypjX6f0QJYdbClLUnPIteSjaOxyvMYviYPsdjR
 iZhU4lpl5MWhRprWzZvOjYG1z3zyEqRgFXrR1a4FR4Bz8vDHyj6E72Y1o5bG/zztV17mn8SgAPt
 Ea5/WRfv/Z3rcJqQ+vb0H4wCKZ9hfLTy0WnLKGQlx6g6gnSggNKjyQN5L
X-Gm-Gg: ASbGncskloNR7+H0so0GkYReCg7GRtKJXllTOn59IMan4UlKlA8YAN4vVccN1k4F+wZ
 Qg6z3QgjEsGgnFimj+slYkKZuItXej1ChdA4tiqZJWUtlvCrjeaLfWAiJPDahHkxtkfg5VuDYks
 Sl6VKsogEnSjXoXkWINX0Jqd6nM8Xf3LTPuzwyQT9BqXvMjYygx23fpyOkeCsoMNVvuW0u8Ro2U
 a+YM2gigxyxAzOkUFxxZXKnVA2COEpeclGFmWjSOUeZRaox+gTpavj+eGZ2flwnMjkuMO6+71yF
 mBLIo2xKV5NjRtTcq4hjm7gysr1/uHR7T5E4VMkEQJfEsDqsVTt1tghL0m0ca6LyNMpWmJOxRav
 62Q==
X-Received: by 2002:ac8:5910:0:b0:4ee:1db1:a61b with SMTP id
 d75a77b69052e-4ee1db1b72cmr57178461cf.75.1763397748421; 
 Mon, 17 Nov 2025 08:42:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9dmRXrv0p8cU32kA0IYTpwHsfn/aRkAc4hbZweXKiPDYkjUYGX6GwQiYe2wnswc+aJa/E1w==
X-Received: by 2002:ac8:5910:0:b0:4ee:1db1:a61b with SMTP id
 d75a77b69052e-4ee1db1b72cmr57177901cf.75.1763397747846; 
 Mon, 17 Nov 2025 08:42:27 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aeecb087sm1014683985a.26.2025.11.17.08.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:42:27 -0800 (PST)
Date: Mon, 17 Nov 2025 11:42:23 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
Message-ID: <aRtQbzMifFW3BejM@x1.local>
References: <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <5279f15f-bf46-438e-9c1f-0873b08b59e7@rsg.ci.i.u-tokyo.ac.jp>
 <aQ37hd0fVJltYtt-@x1.local>
 <5002e5b4-0493-4dff-af11-402cebecbcc2@rsg.ci.i.u-tokyo.ac.jp>
 <aRYPXh_9m5ZvTi2w@x1.local>
 <ded7ef38-8c99-4d37-87b2-2f5ba1dc93fc@rsg.ci.i.u-tokyo.ac.jp>
 <aRdLFwxzJwjsXFpY@x1.local>
 <a8c03d1e-a3f4-40de-a633-7b15ec2288e3@rsg.ci.i.u-tokyo.ac.jp>
 <3c3ad5f1-37ac-4c4b-93c4-ca67b5a1edef@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c3ad5f1-37ac-4c4b-93c4-ca67b5a1edef@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Nov 15, 2025 at 11:59:01AM +0900, Akihiko Odaki wrote:
> This is wrong. The following can still happen:
> 
> call_rcu_thread()                |
>  qatomic_sub(&rcu_call_count, n) |
>  (sets rcu_call_count to 0)      |
>                                  | call_rcu1()
>                                  |  qatomic_fetch_inc(&rcu_call_count)
>  qatomic_read(&rcu_call_count)   |
>  qemu_event_reset(&sync_event)   |
>                                  |  qemu_event_set(&sync_event)
>  enter_qs(false)                 |
>   wait_for_readers(false)        |
>    qemu_sem_timedwait(           |
>     &sync_event, 10)             |
> 
> I'll fix it with the next version.

Please take this as an example of why I think these orderings are very hard
to make 100% accurate.  Consider when someone else who is less familiar
with the rcu code and may mess up with some of the orderings without being
noticed.

That's also why I personally liked a sem because the important thing here
is not missing an event, which sem always guarantees as it doesn't have
resetting at all.  Then we can be open to false positives on events as long
as keeping it as minimum as possible.

Thanks,

-- 
Peter Xu



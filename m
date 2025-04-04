Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607A3C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 09:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0dfM-00057s-6Y; Fri, 04 Apr 2025 05:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0dfK-00057d-PO
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 05:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0dfH-0003gZ-97
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 05:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743760120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D59tyoPDKVUjHeB05UQNPz72DDsx6Q4XmKvQ7LWDEGc=;
 b=H35q3Zi//lMs4V7DL1f+czKG/31rMur3I2kn0dywsUbjOhJBUE7zT0lCKXTQn6JLtZYwXj
 3ZRwh60Xb/1KJXHCJuHdt93zqLqq5qgUKI3Ty1P6ZZB+jeLQe/l5zWV1J3KFzqNsSwgBXR
 I4GtHOVvjueoakxS72k4LgtotI4ArnU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-W2Cwe3v0P429u3P1-n6xVw-1; Fri, 04 Apr 2025 05:48:38 -0400
X-MC-Unique: W2Cwe3v0P429u3P1-n6xVw-1
X-Mimecast-MFC-AGG-ID: W2Cwe3v0P429u3P1-n6xVw_1743760117
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso11352255e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 02:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743760117; x=1744364917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D59tyoPDKVUjHeB05UQNPz72DDsx6Q4XmKvQ7LWDEGc=;
 b=Ygu5+HBgsrCG/o5IVV6Ue+7Pwa6U5ZlRuZqF7Piyzh+ADFvmYUsL/nZZjOWwJzmT5H
 k1UUjuUAFi2xSxJkGTazl8envpmrhY7TYU9ye5Oyb0fYIMF5o0B1U7oaRngZ7CyZj++V
 SbzFp6tGQtt4HW4nhKFTl+7YDatjRV7MUs/FOFYtYH34ww7Amn3FJib89UQDVrKIes2k
 +I8l7CvRUXt0jTr8Ud3Uw8NFg1oo0UjR9R4ypC7JWTNVloUKncQatcmZeBAy3hP00EN+
 ZVfh4OWIDreq/kDqoKSwbmCwaJVKrdvtaVKRM5zX6ItSvo1prs+c1T7Zv5UqNVyaygwP
 e/XA==
X-Gm-Message-State: AOJu0Yzkq+nqQpfTMwaYj9RjjZBqMayAZTLOL10irtpSMniz+7JyySCL
 UreoH5lyK/YgNA2bQDI9EOvGZSzk/wXXwZJA75jkdZ8xJe8jkwZ0flWpZMJvQGv/oTqhZR40Pe2
 Ny5OU+MfCM5mtxTZnA8QRWFcvIcyN0ZF3LWUKNHyBne3jUvlQknXTfpnX8aiPE1Xk3wKz5WUBr8
 hiAyWaYZkLTMsDvmJyo9IFoSIquyo=
X-Gm-Gg: ASbGncvi/NU8fISqbG2qKKQul3kc8ziNiZ1GdF0DxJnY8jZMLcAb7l7kE/xtyFH8Vzy
 hfQohEGvQCFaBUkJlwwm9cfFvzFjUCcXcj7S0w74q5Y+MOMu9kFWFPUpXDA7BXgJiiTKLwzGD83
 I=
X-Received: by 2002:a05:600c:3c96:b0:43c:fb36:d296 with SMTP id
 5b1f17b1804b1-43ecf9c463dmr13151165e9.25.1743760116896; 
 Fri, 04 Apr 2025 02:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH7fhBBDWX7yAHPrYVqloJc19eEUtJUJ9ecuSsn03DTrUu8JbNjTQTU9LTQi/oT0ttR/MW6RaqaxtvKFkB8x8=
X-Received: by 2002:a05:600c:3c96:b0:43c:fb36:d296 with SMTP id
 5b1f17b1804b1-43ecf9c463dmr13151005e9.25.1743760116564; Fri, 04 Apr 2025
 02:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-3-ppandit@redhat.com>
 <87y0wlkzvs.fsf@suse.de>
 <CAE8KmOzASSXE9FRmiFQ6Q4fxaGFh_8VWKXgnugjEs+egFuQPpA@mail.gmail.com>
 <878qohl7t5.fsf@suse.de>
In-Reply-To: <878qohl7t5.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 4 Apr 2025 15:18:19 +0530
X-Gm-Features: ATxdqUHEsgElhbRgyTCQXrIhocOlx6ajwwlhm2yrIUQWppSOFLaS_v2CZVSD3Hc
Message-ID: <CAE8KmOznV5+jyQ1U8g4VMEcUp32HjAEXxnMaw2cs6cPS-yvsAQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] migration: Refactor channel discovery mechanism
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 3 Apr 2025 at 18:29, Fabiano Rosas <farosas@suse.de> wrote:
> Yes, there's no point. if we already have main and multifd channels,
> what's left must be postcopy.

* Okay.

> Well, but don't add it blindly if it doesn't make sense.

* Hmmn, okay. When I say/do things that seem reasonable to me, I'm
told - it's much easier to just do things than arguing over them. When
I do something because it's a minor change, I'm admonished with this.
Life is tricky. :)

> The point was to not end the conditional at 'else if' because that makes the reader
> have to go look around the code to see what was already assigned. Here
> we want just a plain:
>
> else {
>     channel = CH_POSTCOPY;
> }

* Okay.

> > * migration_incoming_setup uses the QEMUFile object only when
> > mis->from_src_file is not set. I'm wondering if we really need an
> > assert(!mis->from_src_file) check? Because it'll reach here only when
> > channel == CH_MAIN and channel is set to CH_MAIN only when
> > mis->from_src_file is NULL.
>
> Given the:
> if (!mis->from_src_file) {
>
> I think someone (back in 2017) thought it was possible to reach there
> with from_src_file already set. I don't know whether that applied to
> this path. In any case, for this function I believe the correct is
> assert because we shouldn't have two channels arriving as main.

* Okay.

* If we add assert(!mis->from_src_file), then the if
(!mis->from_src_file) check in migration_incoming_setup() is not
needed then.

> Maybe not, but we definitely cannot just ignore if it happens and we
> also should not have an empty check that is always known to be true. So
> either assert or remove the if entirely.

* Okay. I'll add an assert(migrate_multifd()). That should be
consistent with the other assert(!mis->from_src_file),
assert(migrate_postcopy_preempt()) and
assert(!mis->postcopy_qemufile_dst) calls in there.


Thank you.
---
  - Prasad



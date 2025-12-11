Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC57D41D65
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTj39-0006Gc-SY; Thu, 11 Dec 2025 10:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTj38-0006GS-EJ
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:57:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTj36-0003q1-LV
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765468667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GKd8X+HCs5PXStqDgIZCh/yYPV/sUnkWjaLNzj1eL64=;
 b=YqnNBy7IlkQ2jqPT+tR+uwibsn5NfRvwN9a9fLIcDP3zz5cS5GXpcpoj+UmykvcSVNzHmT
 FBPoRH5NcpsJDBFAApX0Crk4BpjZWztOysl59+ntNkDfVU1NEEF7kaosEum7Yeg0R9Tthh
 dxBwsOWqsu3Z9rdo4j3XysgV8zsQ4KQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-uGV4t8yvNBan2QaUHyQ0Pw-1; Thu, 11 Dec 2025 10:57:45 -0500
X-MC-Unique: uGV4t8yvNBan2QaUHyQ0Pw-1
X-Mimecast-MFC-AGG-ID: uGV4t8yvNBan2QaUHyQ0Pw_1765468665
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88686be1100so2921056d6.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765468665; x=1766073465; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GKd8X+HCs5PXStqDgIZCh/yYPV/sUnkWjaLNzj1eL64=;
 b=h8MuczWJnzC05vNPBFCoECErtoLAHOAxM1jM50sF1YkaJggXjpaiKBEPWqQCj2aNss
 5jGlqqXA1UAI51roAJzCrcg3yQhf1b14Nd2Jgv02O8L84LCCtQhmcoyVaatznCih7iE5
 YDt4yxNwt0tPvgXKgoTXDDc33glTuDVG5ssPqDIFasZcp+FtLM9ssBWqAMHwmno3s285
 Z0nYS3K860x9VS8HL5C4mYYscxRaIli2hqiMhWy4R3pn0pxFvLhLLR2kkmT7P9hjOFCg
 LT5FdENkw75kIcaPuPFQXFWfXF9wvn0ZM/G7frDbxZisXXdlQhxZNkvC3VHlRV2iYk+1
 DvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765468665; x=1766073465;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKd8X+HCs5PXStqDgIZCh/yYPV/sUnkWjaLNzj1eL64=;
 b=WYkKg8Jsco0ceW2ttijb0uq/QHaMPgrNrYekjYMzSiti8ggV4urYCLP2V1tm+M34NI
 soaONYg2W3XwYoFRXsroOfcy4vhVnpp6Gse3bnGCSuXsV8RtIaMVMyMFJMm8DjSqEn8r
 NSIwLZpwI10+fh1qoP4qx5SLPGVo6cg0UPYPGveTn+vtotH9IIH/uImKkSXMP7Kzlyfi
 eoM2Nb/CeUmknvfyvr15/u6Y9VJw5BW2z9/GIduX5CBEEzCcevzFHuz3+qCS5/8pUQCQ
 rgGM0DeRfgvUaCqmRqwGPkuq/2rNto/ktgMRFcB3edULSdrmatJtv/a9AcN8swnICfzb
 crog==
X-Gm-Message-State: AOJu0YyTeQrHHdXy1IB/FgOh/cxGk+dl+kUSAtWWtP5jJhCVfePnAshx
 Ew+knfHjvbTi1elK/AZbxQHJxa4XECKp9/+IwwlE0QExBiYyBudQfWHXXslaoVAAeaTG5IUWeTe
 Qgm7BJD0NI5qdB3XbNh1XJNPOR5/54ifYnlyGpi0iLhER+yALx1Z5578NGnQckMTD
X-Gm-Gg: AY/fxX61IX5VW5PZC71oMgQWNeEqhkthTfXIwcwrwPMtHaRcJbXb87h5Bn9Q9nBB5Xz
 msVkagSxTth9qtub15+tTFZErvqS64Dbv5CI+fw6EkvccyNmwMAppLxtlCxut8GgbqvaPrOcqDM
 pp7/0MFPXDythR0Er78CJh8AWJ1dNOXQpvs4xomkDK6t9w7dVjGPYMRtFI93UndJ5MEtWp2okFd
 s1N/kq2szzCa6czHmaGu9YgnTnrahdpGALmt9CuIfcMagRjY2C4Oav/r3c8gsQNxcgJJcyFGNLu
 VPSOb10KsjF2CCSE++BX+iO9IlfAdJkgQTHmFJiEXdDmN/x64nI2628FbBP6wTJh/vdTu/j7j6R
 HUz0=
X-Received: by 2002:a05:6214:f6a:b0:880:53da:fcbc with SMTP id
 6a1803df08f44-88863a28b84mr92602526d6.7.1765468664871; 
 Thu, 11 Dec 2025 07:57:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF75igVlSgGay1wQRf/SbK1BUr2LMx/k94Mn1VGKF6S2LrKc15R0A+BZK4/cf6dZBubY68LgQ==
X-Received: by 2002:a05:6214:f6a:b0:880:53da:fcbc with SMTP id
 6a1803df08f44-88863a28b84mr92602126d6.7.1765468664302; 
 Thu, 11 Dec 2025 07:57:44 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8886ef1a0f7sm27167406d6.49.2025.12.11.07.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 07:57:43 -0800 (PST)
Date: Thu, 11 Dec 2025 10:57:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Message-ID: <aTrp9o3d8pAapahL@x1.local>
References: <20251209162857.857593-1-peterx@redhat.com>
 <a3b5e158-adae-4c66-89f9-7f0af26c63da@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3b5e158-adae-4c66-89f9-7f0af26c63da@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Dec 12, 2025 at 12:28:21AM +0900, Akihiko Odaki wrote:
> I'm actually less sure if the first half makes sense than the second half.
> 
> Exporting Property from QDEV did make me think it may be polluting the
> codebase with QDEV-specifics, but its motivation (creating properties
> without defining accessors) is clear and it meets its requirement.
> 
> The motivation is less concrete for the first half. It says the current code
> is explicit, but it is a relative term. I'm not sure if specifying
> TYPE_OBJECT_COMPAT is less explicit (or more implicit) than calling
> object_apply_compat_props(). Also, having a class for compat props but not
> for global props makes the decision look arbitrary. It is nice to have some
> clarification on these.

Thanks for the comments, Akihiko.  I can explain.

I explicitly only included object_apply_compat_props() in the current
OBJECT_COMPAT class (rather than set_globals()) is almost two-fold:

  - Inclusion of qdev_prop_set_globals() makes the 1st half start to depend
    on the 2nd half, that I don't see it strictly necessary.  E.g., one
    immediate motivation of me looking at this problem is Vladimir's series
    on virtio-net/tap [1].

    That series should only need patch 1-6 of this series as minimum to
    enable machine compat properties for TAP (after QOMify, if that makes
    sense on its own).

  - qdev_prop_set_globals() itself has a trivial dependency currently
    against qdev hotpluggable or not:

    object_apply_global_props(OBJECT(dev), global_props(),
                              dev->hotplugged ? NULL : &error_fatal);

    There's way to decouple that I guess, however I just don't see it
    necessary yet.  The only real user will be migration object, which
    doesn't need to depend on this anyway, as long as Property APIs can be
    exported.

Do you think we should keep open-code object_apply_compat_props() instead?

In reality, that also works for me at least on figuring out the current
problem [1], and if Property API exported I can also open code it for
migration object.  It's just that IMHO it's cleaner we have the light class
to do this (so as to avoid providng post_init() hooks all over the places).

[1] https://lore.kernel.org/all/20251030203116.870742-1-vsementsov@yandex-team.ru/

-- 
Peter Xu



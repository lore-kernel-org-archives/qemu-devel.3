Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7834FD637A8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBIGW-0002Z4-Dn; Wed, 13 Nov 2024 13:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBIGV-0002Yw-Ia
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBIGT-000496-3e
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731523131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAFPOiHHFrOd8otSbV8pcYxP2SLQd6DQuE3W9RWP1H4=;
 b=NeapkGAbZAbM2vBMS/8d8M1ppyFBvlCM66/LNbLysZzrfTwrwDZ8f0epnSbu8Nas5pfndo
 ny9hCODRV9xGNUPBJ/ipl45hiEOqEuMXit/jiUaDLN+J52fNCAHV/lwg5eVVF3cDJhfvt4
 Hs/esi0spzWKLSXibl8GILAy7B332sk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-R1apYzAcNAyg3abCeQRuXw-1; Wed, 13 Nov 2024 13:38:47 -0500
X-MC-Unique: R1apYzAcNAyg3abCeQRuXw-1
X-Mimecast-MFC-AGG-ID: R1apYzAcNAyg3abCeQRuXw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315f48bd70so50106325e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731523126; x=1732127926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PAFPOiHHFrOd8otSbV8pcYxP2SLQd6DQuE3W9RWP1H4=;
 b=WnBZp3pLVYbBlUMIffjIgEKn5gz+OAbO3t2Te3K4Fc16eszsuJD/Ow/jLn/L4n0+QI
 NOU4GXtReMaAbzH1zCj0NSJRna5WfEZtBEuVtgbKt19KfcNcNjDfa50V2VjCUTVS/lku
 j/7e1iWXoVIl6wklMTQPbxgpR0mfjOxgMuDPa1TR23j9OBlVSMvsmsYJDej+U2uZx6dM
 VFYsJvvwVSg/yTm/J92DVPhxTnxNthxRDSIEu0ptpqmzAgik6vez4eSTeHZCQivCWQL4
 z4X/NnuHAT8apd8KSgxGOXcI3B6PcM56OhI6diEnMwUfb7CJ0Q10OywH802NvPESlV1/
 6qUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV28yIdVkk8EJWubon4VGkKAT6YLJL08c+01ZQUAvHmieJ7YnnPYKeTDAqWzeEXtNlnghSXDgL8s3EL@nongnu.org
X-Gm-Message-State: AOJu0YwwIOWrBUQKM4Y9zEWwz8zCv+KUPwdvLUZDZQCyL76QKIoviDOt
 69Nu56efE9DxCb6KX+0YIVtyJv7+rNQBvF5KohBB4Vhriev65jNMR7DoxdPo3pzctPUgHPO6mQD
 qQfdXu7WOqXPl0Km48JL++172mBz+3NAMtSrw+/xKv4IF4jH9NUVv7CRTOyeSWGfj3OVR6DXktu
 blFjus/byfwLpmrzOwp4VHFD4nfOs=
X-Received: by 2002:a05:6000:1566:b0:382:d79:7ce5 with SMTP id
 ffacd0b85a97d-3820df8373fmr2898165f8f.56.1731523126288; 
 Wed, 13 Nov 2024 10:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeE1C2D+HxysOzwOrqeQ2V/hSCHdB9ht/PGTYkaJw4/dKZ6lO8VCdFc1QSiRX2CrP5vhZKqls/MVxxA5E9KFQ=
X-Received: by 2002:a05:6000:1566:b0:382:d79:7ce5 with SMTP id
 ffacd0b85a97d-3820df8373fmr2898156f8f.56.1731523125960; Wed, 13 Nov 2024
 10:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20241113163800.355547-1-alxndr@bu.edu>
 <CABgObfZsesHr7gr8CVgW471hBkW6E5rfhpgtBTuM5owuPazPNw@mail.gmail.com>
 <xydqdaplcewxtjoz4r47zxfxospoa36vrmpmicm24wilkmdueh@x5qtvnty3nln>
In-Reply-To: <xydqdaplcewxtjoz4r47zxfxospoa36vrmpmicm24wilkmdueh@x5qtvnty3nln>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Nov 2024 19:38:34 +0100
Message-ID: <CABgObfaT0AdBpqM6ZgXgqPBHJZhXjspfUbEpvExPf8evF82Ejg@mail.gmail.com>
Subject: Re: [PATCH] fuzz: disable tcg for OSS-Fuzz builds
To: Alexander Bulekov <alxndr@bu.edu>
Cc: Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 13, 2024 at 7:35=E2=80=AFPM Alexander Bulekov <alxndr@bu.edu> w=
rote:
> > Where is the Dockerfile that's being used?
>
> https://github.com/google/oss-fuzz/blob/master/projects/qemu/Dockerfile
>
> Thanks for catching that... I will try to run the docker build locally.

You can add -Db_colorout=3Ddisabled to both glib's "meson setup" line
and scripts/oss-fuzz/build.sh if you can reproduce that.

> Probably makes sense to mimick what the glib people are doing:
> https://github.com/google/oss-fuzz/tree/30da5abe5cd004e8a2f8c92923375d43b=
4d8a5c7/projects/glib
> Their builds aren't failing. (I do still think it makes sense to build
> w/o tcg to reduce the fuzzing binary size).

Yes, that's true.

Paolo



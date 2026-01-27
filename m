Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD5ACA6C9D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 08:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkeXX-00011s-R8; Tue, 27 Jan 2026 03:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vkeXV-0000zm-Sb
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 03:35:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vkeXT-0001w1-MR
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 03:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769502905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWnIQ+8u9keQza1uQSBHYI5NOZAwUpFlIgr9fGbnIm4=;
 b=O1QiPS9XQMQJLfapnsEMO8QQExvnzmwADNDlYIXsiqWaC30TA2AfZWK5i/G953JUuDmlPX
 yTSAqsTWRZ9KNEMn/ZoaeewGNVIHKwQsuONrv5TtXvfKZd3THN56eR6bClQzjlSsXKfzRP
 qN61g3ubms32Za9xam5svTxGD3ZDjRw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-ULEPawIwMWOT3-ifK8muhA-1; Tue, 27 Jan 2026 03:35:02 -0500
X-MC-Unique: ULEPawIwMWOT3-ifK8muhA-1
X-Mimecast-MFC-AGG-ID: ULEPawIwMWOT3-ifK8muhA_1769502902
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79477dab067so7498917b3.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 00:35:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769502902; cv=none;
 d=google.com; s=arc-20240605;
 b=fNUumnLAniYl1VsuGqIx39RimkhPtK1EAsT4kLPjt/oGS/igsEwLVMWtbMPZT9G55G
 uq8eVcM8E2QWBNz1W+dKzY7q3S3x+1UmYO8CdgmFTEUr9dar0l9zgRjrz0xQ5fI9SFcG
 wFYMsAG4JYjS1O2KG3yxJuimdlcpMz8pcPADVbdA0cMXneimB1juEebjVO9f5KTgallH
 3859I7mdE1JIY2MSBNC3QJDlgGqYjWfhWPD4FuvSCAXKjfD9lNDdhgmEKiijIP5GuSgO
 CmczmEIK5bCHCPoxJCZD60UHTQWvvRRFCJ37hOARhFjJuxyrar/K8LA2NW50p6U7pPG+
 yIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kWnIQ+8u9keQza1uQSBHYI5NOZAwUpFlIgr9fGbnIm4=;
 fh=I+z6LOFVRxEFyT66qk8qQCGHYmwf7rvKGlcvlb5ew50=;
 b=hxHRqv0uex3Orw1Oacvf1RVn67XVgvcdTaHB3ZUuFuYeCA2MEqwt2eljNONMLNVjPX
 xTfpY0WyG4qLRFTVRySk9WHb/yoiOhFTqx46+iL4Hx7FVUPYJ7QUzpnYgxpXH3/Z61S2
 gDKFj0JTnhVJhBAH7C0AaV2w1Iunbt1HqRbErsE/sXfgAlONaa85oKp5oJpAVdkDwLVH
 xLeH8SRW0OxMbPNNoPnrr+2jGtZKso7Q9uLBXA7WDy0in1mIPZnPA6HY5itcjWRB8gQO
 EPMGhYPdKQSm0Q+a77W0WB4lcDR4U+6UlGoGqSjTEnzDTP7nzQdFymaO/cXz02MaopoK
 CNvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769502902; x=1770107702; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWnIQ+8u9keQza1uQSBHYI5NOZAwUpFlIgr9fGbnIm4=;
 b=oY3EY9cUPrZspt2EXAV5RFoVzoKQdlPZ19QBa0F2mSVjtdkV0XjCegZuz04pYEb6TV
 JJbtvjAMyEv4O3XDp1Hb/WmvMNJ2TrGe8FlMMFgyk32hsVqSFGIUu94jgo9Gm+K8OyPQ
 hU6PLBcqAXydaiMqavSKy0e13AqohCdM0BplC7Cuzt0HJcLZCeRnzN4mx5QE7AgvA2EC
 kL0nlQizh0uyIrWIw8iwT/GTyksjdmxU/l/fY/TmqYxt0zafqc02dFt1BqYhQ8xxhidz
 Vy3Eza/H1LXJ5Ngw1S7Am2zcOpfaMZgUx+WMpkbr9tA7oXfwVqXvAi+9YrrQbFOITGxL
 6RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769502902; x=1770107702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kWnIQ+8u9keQza1uQSBHYI5NOZAwUpFlIgr9fGbnIm4=;
 b=ohkOVJYZgOFIvNbi3jLsPFMbqXdY/6iyaRKaYhe+oFTahrhJFgtwYk4jDJ7eyuQOVA
 J6/bKY7gJaiwK0Z9USYpkQ/PE7O9Bf+aheh0fcTZsKgDEoHTq8X1WWT4l3SQbrSpaRls
 CQCavnIKNFw/WMIT5amlkSdAwKIyT/BQtjUQlRnLo08+l32Ru++2SYTKfeuhOBHaC2u4
 yCT9L3uzHBbhhtnfLVjDeYZArqoin9B01JBDIauqsWlwOlkBCXTUqKrZX6PkWTxuriw7
 yfV9X+OnN7DvZt1hmenZ7vLyjMZHc9TmH87xLjhLegQO7ktiyUYTxMM8MBWk49hr6SZ8
 QHaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPGPHHsQrWL9wQ+g9gK/dMJcq2cyKZ2dhadorMBT4NGNB5AZ9N4QLD19ndoaxNxv2EOljZSMYx7IAG@nongnu.org
X-Gm-Message-State: AOJu0Yza6Ru0P7WrWJ4P2UdOGVY0B2kY1e9WbfYpyZh4W9/JVbsSmskw
 BbvxOaB/f1HCnzHRbjLyoGK6mc7aop0R3/ORXDBj+PDxHfrSxmus1Caq+Mi+saf/rFUag4ThqHx
 0aKrjVqF4NJiXqBmHoh2yiDV1CjnPhZ/Wv2tyUczsm1LkKjNUrDcFBqMx8OCLTAYxwd5lnElVfz
 Ah5T9lpiPSaQfg9ACfsuKZjSlbkSrz0WQ=
X-Gm-Gg: AZuq6aIV9jzT3pu0AxpPxlN1YPhas/cOV7X/lxFg4lr8tBaB0wYP98q6U1NOlxjMTVB
 Jca1WRk5q3ITQOCmbbo2/tjS1XAW80RzM1An2C5sdcL3IG5o3Ki863gBljO2ugUN+2q47cIG+9e
 lrZ8Hlzu9dIVqEFqyDhUoSl3T3BElAChhbfKmjyA3Ug0tJC+RHLK9XXDM32jJrAT0T
X-Received: by 2002:a05:690e:bcf:b0:644:43f7:11aa with SMTP id
 956f58d0204a3-6498fbd599bmr495533d50.13.1769502901873; 
 Tue, 27 Jan 2026 00:35:01 -0800 (PST)
X-Received: by 2002:a05:690e:bcf:b0:644:43f7:11aa with SMTP id
 956f58d0204a3-6498fbd599bmr495519d50.13.1769502901431; Tue, 27 Jan 2026
 00:35:01 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
 <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
 <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
In-Reply-To: <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 27 Jan 2026 09:34:48 +0100
X-Gm-Features: AZwV_QhI0P3cRWPsJjKXrEZADOuDplxIF_8okSx2j0TBYh6xtcOwzzZxaSgroPQ
Message-ID: <CAGxU2F4K5mAhwKSLkCk+f17=1FA51WG_XEzhSr_hxNKJTAGi3Q@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 26 Jan 2026 at 23:29, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> Hi Marc-Andr=C3=A9,
> I would like to submit QEMU's GSoC application in the next day or two.
> A minimum of 4 project ideas is mentioned in the latest guidelines
> from Google and we're currently at 3 ideas. Do you want to update the
> project idea based on the feedback so we can add it to the list?
> https://wiki.qemu.org/Internships/ProjectIdeas/mkosiTestAssets

Hi Stefan,
FYI we are going to submit 2 projects for SVSM and 1 for rust-vmm
(virtio-rtc device) soon.

Sorry for the delay,
Stefano



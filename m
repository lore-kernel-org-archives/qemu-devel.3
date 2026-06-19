Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E55BCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX4v-0003qY-Hd; Fri, 19 Jun 2026 07:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1waX4u-0003pf-48
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1waX4s-0007sX-M7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781867281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Ftuz/YeU1BrVwtz+GOmCT6y76opWKn1nUdh59yxKwg=;
 b=hordkYLx4oJ8Sgod22JBsukjt2pEnvH0LLyX05ESoHGTiBisyzc7zQDUWemErPTmbWbsbO
 YJYZZ7ikfv4ho5Tzr6Bx+2ch66g1rdUr0+a62P8UPvsNtOeGes09lp/+deBSF8X8laP6Ll
 0OUd2bB2LTh2NerI/aFN/rQQ7Ixfw1Q=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-sb2JJOziMWaLmUiwCjo4aw-1; Fri, 19 Jun 2026 07:06:41 -0400
X-MC-Unique: sb2JJOziMWaLmUiwCjo4aw-1
X-Mimecast-MFC-AGG-ID: sb2JJOziMWaLmUiwCjo4aw_1781867200
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bc5f826f2so3718139eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 04:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781867200; cv=none;
 d=google.com; s=arc-20240605;
 b=M0gJHWL2ivZt5/NQLDb2/gLzl3r/WPVAyny0CDih1ZbPeFtXajRzVA9GStBZmjjZcV
 D1uQDTxPczdJYsMwNvFDMtmScnBsG9Vt+jliRhEjj201JdIUkc1LXu2iggGdt2PdgnI3
 FAsQ5orq4ZT10ad9K1BuvwjKUyGXUbIsgNu7r8jabQ1Tk39/N3cWMFd8Nnh0nyPLRtAt
 fgt0IbNsdE/rM8gy25Qc64tPLM+ytU0jkizwc2t9o9xn40MrmFjewZAvOyeqBxPf3nzb
 OgSnFU+CSADCMOCjaFc2c3/K18VdAJPAHk//K5M2B+A2kPmULwK7njHh4j1LKSmBuAQk
 H3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:dkim-signature;
 bh=6Ftuz/YeU1BrVwtz+GOmCT6y76opWKn1nUdh59yxKwg=;
 fh=p+TtVNE8BnszM6+G7Y69JvEyDoMj0rDrDF5oJZ/4I48=;
 b=j13hWNJlVKaN0WEKp1jrgQcMClZReacbYwayzfQF+/xeodCakdY2kreWTBLxDIUJN6
 zwnVp/b+FaWGtlrtjsArTSlsc87p3XjQdrAdaEheGtUjRNmq/kpdCij8NeqZvJsw9AG0
 d09IeYTQ0+9jO6iyzP54d4/8vuL6ib5+5esQ5F0mSHNoLmM4Y6ibrM2Lsyk/6g0cK/pN
 cuU1WHJCKtMbfGYMuEv7yd8PH5k2oxcYX1JXBOU04htUH6cEUHUdSqQcuU5wOabvSKY+
 2H5PybY68C0D6C4zKZGcBjv1lMsmnhBV7gcLvxZbcS6e2F+etjcj5UTPw66MBlYA01E5
 ORHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781867200; x=1782472000; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6Ftuz/YeU1BrVwtz+GOmCT6y76opWKn1nUdh59yxKwg=;
 b=ZGvd+j9L0f2GQqTpeYUaFqVq/sI0Nxp5jwAdVe/Q0EKqk1hLHC5UNvQ8rD9pnUKlmk
 v8VjvGgacseVqnmdDBSxkhkgzmMeZqLsIYq4dGU8fjB9SmdxD9QN2j2TmPzGJVvpWjR0
 ohD34EGCnQkZKJsfPbULvUMSeqepyjS96IoCeFTB/aTds4IkbSFUA3UNW/8PO+QVq2Fd
 FqnSfvQSwuK5bg/4evWfIfWqBJQuF6VHrjy8Qf7Jn6tazG8QyUiBi1+nOSuXM4KppHNE
 MWUlM5O1I4n4qEmwaSyA0ndwKjdJIBRkAKdtr+Fmd0sRzL6hagRFID4cHtg3EVUd4Wgx
 ebOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867200; x=1782472000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Ftuz/YeU1BrVwtz+GOmCT6y76opWKn1nUdh59yxKwg=;
 b=GzT2DpAVEHi+vn/k/impL7rARiCHZUa1asU/vnyT5zjv+5GotQ4eQu/mCu9ySRybly
 Juzke9wdD3au+B/RMltfA10f+4cAAiDBOwoVpHvUQrjdlIGfY1mYhmdc5nJ+V2c3B5Fs
 wpco2hBrGK6nNv6BZwUawpaCZ07l4WThMO+irt9ROwO7feyP/BJu1ujuQGm6LIwJoohZ
 dWdQoWNavDHzi6jpykizb4aRuvawbFXNDCxvTLDhi6+pt8qPcv8Jzwd/4i017iysnM07
 gAZLJ6jF4yScx09Z6vXoES4gDomomnKOFA9MTQbmHu0pPCoHSax0bkIC+cgQbVXZrmtX
 h7fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ryvrqHuKkAJss8vPZWbzaCGmtuGn7ooD5bXGX6vVK8e5l9IMVpK1//iJZpHT7K68R7C3ywpLMPYRD@nongnu.org
X-Gm-Message-State: AOJu0YyW8S41O9xtTNm0ooObtlJFLUIys/3d8JSM7BqEOJkvTp2gcjuE
 i8vczAphRSSfmf/ldvbyle53I8DhBXGIWQ/kSDTHx5q7iy+tJdYkoiKYHKf91WdFjkO1tt6G2Sj
 HDpVROxNnYD8KIymfvDp0bSvWj42uaiIaQKMY5aOI+T2vxYuf4MocRuB79LzfAY4Zgnu2Gi7RFK
 uyZLikS3J1GI+mt/VQGcH2a1VNqu7Kajg=
X-Gm-Gg: AfdE7cmV1ZFROQT/oiie1zAPYpaKUo4PZFUze+RxjQpePyEN1laAbBKv+qjSrACTeEl
 sujyjheaQrQLo6Pc8JrKwPTsDZhtfiUdOXMmieB3zeOj11mGehpXfLQ1sXtypZ7TG0ssb3Cfvqz
 MmeoNp8rMF/Vn+PW4kMJpitNwQKUwoZAOiWTKb+eQ7Ml1TloXE3J53A0dJF9xD3dF6
X-Received: by 2002:a05:7300:6c84:b0:304:e587:5063 with SMTP id
 5a478bee46e88-30c0cff485dmr989884eec.12.1781867200327; 
 Fri, 19 Jun 2026 04:06:40 -0700 (PDT)
X-Received: by 2002:a05:7300:6c84:b0:304:e587:5063 with SMTP id
 5a478bee46e88-30c0cff485dmr989854eec.12.1781867199837; Fri, 19 Jun 2026
 04:06:39 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 04:06:37 -0700
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jun 2026 04:06:37 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20260605083358.1320563-1-khushit.shah@nutanix.com>
 <20260605083358.1320563-24-khushit.shah@nutanix.com>
 <ajURCGaS94gwV_px@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ajURCGaS94gwV_px@redhat.com>
Date: Fri, 19 Jun 2026 04:06:37 -0700
X-Gm-Features: AVVi8CcvxopmE1LAhLJ_P5FoKxGosYvlKzKbEpZomnc1BklIe0Caltb9vqbh-Ec
Message-ID: <CABJz62PatHBE1pvgqw=asZgugOE3L5oMsEgj==Qp4ZnyHWhLkw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 23/29] target/arm/qmp: add query-arm-cpu-props-info
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, Eric Auger <eric.auger@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Jiri Denemark <jdenemar@redhat.com>, 
 Gavin Shan <gshan@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>, 
 Sebastian Ott <sebott@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jinqian Yang <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 19, 2026 at 10:51:04AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jun 05, 2026 at 08:33:52AM +0000, Khushit Shah wrote:
> > Introduce 'query-arm-cpu-props-info' QMP command. This command returns
> > information about ARM CPU model properties, including their name, type,
> > supported values on the given host, and composite parent if any.
>
> Do we have to make this ARM only ?
>
> x86 has named CPU properties too. They are all basically
> booleans so this API offers a superset of functionality
> needed for x86, and thus I'd expect x86 to be folded into
> this new API too.

riscv64 will certainly need something like this too in due time.
So +1 to making it architecture-agnostic.

--=20
Andrea Bolognani / Red Hat / Virtualization



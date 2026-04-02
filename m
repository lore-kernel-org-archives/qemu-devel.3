Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2019ED3940E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FSg-0000R8-Sx; Thu, 02 Apr 2026 06:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w8FSc-0000QE-Mq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w8FSa-0006a1-Lz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775126375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hk6ZZHnAo0uqbKllhg44lMNFIKMFWGlDAQfn/0AWrc0=;
 b=X2BzbFnMH36i2F6LU/xkSDh+B+E5A1Jedz9g59DQHLoDLWwRMaV2LhWuOlRKzC5dk/mU6m
 q0b8zvNi4B2g9mvUNIeJH+9Mgh6MB/vIxd2VA+RjCWUFwKR/mUQmG1QYMgg7UeEZmVuUve
 WLbmVHmXCbzQLpE5IMWc5Tjs0OBwmWI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-OhXj3iUXO7Ke0Oadxby1jg-1; Thu, 02 Apr 2026 06:39:33 -0400
X-MC-Unique: OhXj3iUXO7Ke0Oadxby1jg-1
X-Mimecast-MFC-AGG-ID: OhXj3iUXO7Ke0Oadxby1jg_1775126373
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b96365ea8so879638f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775126372; cv=none;
 d=google.com; s=arc-20240605;
 b=OCy84DdalXgG4uPpEeZntCgxC4dD8XK7vSVQPykqu1IZYor0qzl1CBm1r/cEc7KRbt
 QgjlNBPapvDeAOktE+G0vrvBgJa+ZOGobPbmirTgN2C9jhuOjfGNtUHDK5yOWrudbEka
 TzsSbQnzdMr66vrSU+CxGI80moTC94RPW+kMtzaUhn8LvDDTHbApAkLb8hqVGi3DHB/b
 d2qhpwaKQhDnRJTQlF7WzW5sQXWQslasRFSTzBfUzfkoSm0NlUxiNGr7CkJqh+xYMe7I
 BQNwsul4RQr5XbsJoBF39BUIy8OhUum0lTztE48YhFEGaP2Iw1OxTJaAcxgPwoY18zqS
 M4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hk6ZZHnAo0uqbKllhg44lMNFIKMFWGlDAQfn/0AWrc0=;
 fh=/8gB++1TZOi33lidPokoUONy3iR2nMIESGop2kgt58Q=;
 b=a1KotlvYHxFHK2t60r04ph/EYdTKnMMvB8ntudSqqW7Mucr4OPSmzVUOMpNAfjlrEW
 v654IVFk8KvGfK5qY93QZiGURI917CZVjezmo1yARDSExXKLRVr4DE4zLB8I5Bxz5QM9
 vZHwOB6gleUf/7gGSeL6ooGp+sxS/cRNYEDoAlPWOerzpq6MnSTmw7F5UzD3yvzfxtzQ
 zVjYgf2Z7/Q6hPeBx5eLZyUTKg14+Gw0iBqfJsbNctxbCXv6HfuUUTZNwYQ7rFR8gCnj
 AzbW5bcc6RVtKQy+NiTZ3W/LurGGiGoERX14zslmOXs27S0ts6hzzhjDl5yFgnOOG+DP
 r9mQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775126372; x=1775731172; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk6ZZHnAo0uqbKllhg44lMNFIKMFWGlDAQfn/0AWrc0=;
 b=lQGekknu87M/irq2NKgGrn5l2s51PrPN0/5MQc1Ci5tlGznKZv/mPo1BG/xTtKk0EE
 lPPJKllMgoMducXaDbCz5O/auN0H2JeS6Fur6ikMmXjyxvdJOBqRreg+VoX1JTNaN+ps
 w7DiVozZ9Sx3DHERrLgaJ1LJVW85cdW6IP96G+wvRw8xHRKJVQjWWFl4xCoMiCUbh5l1
 T93BCVbdSlV0hdM/fUl0dBNYExAbJRdifUs8QonZiUWcAIhYzLJr+8H5l+TrVSl434lr
 yDUAPetDZWQs/Mbo2zPQQyUw9FbtNVil7dqZ6Vld/GEY69NEd3PnMIGAqcNkvijZi8xc
 ftgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126372; x=1775731172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hk6ZZHnAo0uqbKllhg44lMNFIKMFWGlDAQfn/0AWrc0=;
 b=cwkVKd0Uawo9kKF8Me5+VxX6+NEQEYtV6NL1YRqAKFeWZPIHIS3JX5GP8Ulh8Adxc6
 1olMpZ71xPmQ7gIBS4tVxHkJ3YdQF+ZRErkwJLxswhppH2DuXD+Wq6mXI/61JiIFtuvN
 6xzP9NvoJhEehueHVEk3noqW7t6+qfIExifrmV83o9WTFSOJGN9+COxaqZ7gDtcFABrT
 aUqy9jD893faf8TuChe4Ab9JrKFVC2imN8VTY9BCuPtvJm5eNqMuY/QwzUWtCn3Xll3C
 jJNfQl2wIlNlY4HtSpy/VfOvQ/kxGuHQOTyUyDZ21K4YyPwR9QWRuF//b3S78XImQIXv
 QdZg==
X-Gm-Message-State: AOJu0YzSotoCk2GMeExrtX8rweXK12N/bw9b+RyDcKIWPmBgs6QgX+1+
 MMtFw6ewWHXXWfp2vaA3L0Qxe7KSW2KUBCXRLO0jwf61s07zRXM4ElueWKFuqXLI8xjeWMZHGOG
 JpahQYfDMLk3C6H/pzFec02WuYYpnM7yqtsUj9YYWyHZStToLB7ajR0mtrlS0JanJZYwmukMy6P
 EEiYikisgRoWuw62zb6FcfnEcyPMUIG932REAxPVU=
X-Gm-Gg: ATEYQzzIH5rkZ4QOrM6MOnD3qf0dYRsjrqAO7hDiaoSf7eUJv6BJPD8wK2qzsmp2aiq
 +9nLno1BqrDautAu4lOzQV06xs0fC+vLC+aZC6+xycUwlQ+szVBu6RzjjC0MbPMRTyi/46bfvqQ
 TrIZkUAYNE7BamzFT/Qvty6IaVHh6SOdTBA0OUCOMjDez9IuMeMr8ONbFCBEvj7y5/YOuWdBYlE
 V3avjm1/Jc1MlHrMJEdh/KcgkxmExMvEW/j+n0KsKl0Jxj6jDZsfHL75B+pr6XndLJ6ucBjnHzj
 QLTk
X-Received: by 2002:a5d:5d13:0:b0:43c:f1da:4880 with SMTP id
 ffacd0b85a97d-43d1f1e3051mr5060987f8f.22.1775126371662; 
 Thu, 02 Apr 2026 03:39:31 -0700 (PDT)
X-Received: by 2002:a5d:5d13:0:b0:43c:f1da:4880 with SMTP id
 ffacd0b85a97d-43d1f1e3051mr5060947f8f.22.1775126371277; Thu, 02 Apr 2026
 03:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260401171927.396672-1-stefanha@redhat.com>
 <20260401171927.396672-4-stefanha@redhat.com>
 <31ba8b4f-972c-4ec5-8366-8e668fef6a64@redhat.com>
 <20260401183057.GA400282@fedora>
In-Reply-To: <20260401183057.GA400282@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 2 Apr 2026 12:39:19 +0200
X-Gm-Features: AQROBzCtML1mtQCUHYytVnK-QzSmr3or9RdsALCIzFKgZvoCETy4LxPGoyaoi_I
Message-ID: <CABgObfbns7H-WB5TkQmCz6UaekfU0qXnCa=BTaLc59rbCpHh8Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] scsi: register again after PREEMPT without reservation
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-block@nongnu.org, 
 Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Apr 1, 2026 at 8:31=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
> The first patch gets LIO to process the PREEMPT. Before LIO would just
> fail the command.
>
> But once LIO processes the PREEMPT, we hit the next problem: PREEMPT
> completes but our registration has been removed. So now we need to
> register again after PREEMPT.
>
> > And for patch 2, is a RELEASE needed after issuing PREEMPT with an
> > artificial PR_TYPE_WRITE_EXCLUSIVE?
>
> No, because PREEMPT will not acquire a reservation when there is no
> reservation holder with the given key. PREEMPT will only remove
> registrations in that case.

Thanks for explaining all this. I didn't understand the behavior where
the source does not have a reservation. Series

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEDAEB48EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 10:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqTZw-0000UE-5O; Thu, 12 Feb 2026 05:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vqTZt-0000Sx-WE
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 05:05:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vqTZr-00008O-SV
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 05:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770890738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=evg6KQG7cR7Shh7gkq+/8mq53gSxY6rXD1fbSI+f62k=;
 b=DWXWp8F1Wbnks6OFcRQA5fPfVFHfuNC6KZL6VvwystLNJKqVDBCStP4lwqpWnjvaBd+XlJ
 Mm+td5TMJMVRUUi9ryui8cqpu0CTq/Ic8ETTpNdC1G9sD5PoKS12vIhNGTOlGRaVWFIhYG
 CxCsastRc9R5obBcGgk8Brdwt6cXKLE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-zYdiHjg0N-6Q-IhG-T9Ckw-1; Thu, 12 Feb 2026 05:05:36 -0500
X-MC-Unique: zYdiHjg0N-6Q-IhG-T9Ckw-1
X-Mimecast-MFC-AGG-ID: zYdiHjg0N-6Q-IhG-T9Ckw_1770890735
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so29898085e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 02:05:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770890735; cv=none;
 d=google.com; s=arc-20240605;
 b=ltz5UdECd4WPgshyTeK4cCj+0+LQ0/1uMgzQnvKunGvrrudGLq4X3Njw3DtvsVQLgG
 Dz8I0E+sFM71+JjfQwcM/AcijnPlO104p6CbDaLHtE7LxMoSVK+7015FQ1Dl3iytbwwL
 jZFvpLNVDQj6aMxn3i/m0QbXs+gcBqjerK6r+qq483mkHYkkVzok7Xn/NdSwsfTrwHUd
 Xa5v/5LZUJ7WcMm40J7VhxDBTgsz3rqUfhV33OsvhjF+mBnidPyOXZvVdazMwaNIcFSJ
 aRIxNKZ0WrP6sYz2FAXThWfNelipkY3QxSJtf/Km/aVMANepJ0pqrBZ1Zg97gGUy9hSk
 SUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=evg6KQG7cR7Shh7gkq+/8mq53gSxY6rXD1fbSI+f62k=;
 fh=OWKpi+EGv077TG1PJ6D0vpopsOg3tFlPo928HkoFGNw=;
 b=KFuo0qQNhdUrF1/iTVPYCNF0JG2CsfI52TX3UkUf2gjAFIu0yoTvb1vAzuuC/Co2je
 UHuWI6Kp4CddLRjwkHi144BOf2nnxq07wEaJgiHXbcDaekLFokToAp9f2loLPlzNObJS
 LmIUyi5jwEDjPNI1dyDU5nevK/gZVCPdUYMYdd+pWfI9Zo4Fiyj0hk4MCK2WdSl+0alL
 py2H1pNiukeOQrpjogCDVl9qwFC75mwtysqB1W1w28wQhYtZUmsXpgKenUvpG3OzIyDg
 dFRENgtnOxeekYjvLGkPTFWwGmVlRgTXe7nP5ZaSTDfiE4yt3g7tyXfms1sGeIr+9c7X
 Kpfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770890735; x=1771495535; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=evg6KQG7cR7Shh7gkq+/8mq53gSxY6rXD1fbSI+f62k=;
 b=UaM75Pe0wY1qYyfDT4D9pnyn5PixlIctw0FvpyqeqdewG6apkTyZl/Z/Fj2U0tKNnj
 aPZWJYnFFIaat3+wDUI9pb+EC9q2dCn8Cws1oycbYCik87LLjKe5aVD6FtfxNLfYKDBN
 M2PFBYHkLYPcQWl7Ue1IaLY/QZySt5KBhYSI5Ge9tegKXEv83LQhNiqSmPTN6FuviBST
 lZks8TnkwqInT/mr9lHi77qeyMmqhXwcg/hyE44ZnCYIUzWUKhNhk9c/08ceZ0fw4AKT
 4EkCaWYaBvxlRTMEL8Kz1pE75FXRkATLa5xdRk26SGVLqV2x3D88lHcSalcYjVl6t48I
 vJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770890735; x=1771495535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evg6KQG7cR7Shh7gkq+/8mq53gSxY6rXD1fbSI+f62k=;
 b=N5zVNPrERS96bBHRhxuZ0uOsXdFQwkWZSEBbMHHtoBPi2dxwh/3mVE8+0d+v17VEQt
 ZG4i2Vlqsoa3f9waXP8XQoBZWckcDMdlDdiVrbNzAqZ3m3IrGH5LEnHgRQEIpysJgdtw
 gu7JUB0a6VbS7poHjI2fNKp+PGS8SnBlye5uLZx6SJ49VUL3knqrX5NK+4beUcNNfQ2b
 Q7BR4f0oCu2A+hs3sgXZVbW1YhIjStWxrV+6CLlwGWZb6SQoI7YHzblCtuydqJu3FHLn
 dq9piMg0vyKPHGN8HcABQ8Mvpna67ZVYMuifI5SEhuDYLsZ9ZVHcEBp+rmCO7G3osoH8
 TFXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjttSf5QBQgfYJTFomVN9CvB8Nr8ULxYdga75F1KFYwIJ6e4uQul+0cSf17dMT58IyKTNNUazctfte@nongnu.org
X-Gm-Message-State: AOJu0YwOTIOnC3GkMFcoqx4RWkny1VgoABmsdg1WWrE3nWdDFR3vejv/
 BSs6vAKpl4WVGZXgZtC5hjBmDzzQ5/zQmf+bKvLpD0aR+ZbO3mkNxCu9u48c9EhX+QnnIqKSjx7
 TsDATCtRqVqDLuFlhs7fx/s0eVp6Ga+WJdnBBdSRw9jvNe8ssboBW0xLhfgB9zjhss+cKCPl9W3
 xzf2wGD4fdnbhpo9VSZkOdwoY7Tgj6P4I=
X-Gm-Gg: AZuq6aIh+0Xjhm5wer4Oo9zjahnRVokR351z5pyoU6v7PWL9/Ha3KTvfExymSkEasds
 nNogJey/fN0AqRKqBTZRXpZbpU5u2tjJpqFYttXfEtND1Av1eW95sQH18s3ELYSgySWgmQFVY5u
 zYQK52qBd0R7+NNcl7aEFOcbtGeZoamu1+9SUVgeL5NPQ3kjc71HsjzV0kfd3G/hpiSF4F2uJ2j
 AQawyh8wDjsQeRo8NAl+OxfujEOoOF3Ikb67HxzO910Bqei2o+M0hKpRtM2QdK4+MUT
X-Received: by 2002:a05:600c:870e:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-4836716c208mr20934075e9.32.1770890735299; 
 Thu, 12 Feb 2026 02:05:35 -0800 (PST)
X-Received: by 2002:a05:600c:870e:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-4836716c208mr20933705e9.32.1770890734867; Thu, 12 Feb 2026
 02:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20260212062522.99565-1-anisinha@redhat.com>
 <20260212062522.99565-18-anisinha@redhat.com>
 <CAE8KmOwa1M_F9Qfs-XXRhaJZx7jiwQDfwDk7U2shJi8SLa+y9Q@mail.gmail.com>
 <6C39045F-DF1E-4E9A-8ECB-AE24C766F002@redhat.com>
In-Reply-To: <6C39045F-DF1E-4E9A-8ECB-AE24C766F002@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 12 Feb 2026 15:35:17 +0530
X-Gm-Features: AZwV_QjL_URuAFSIF6IyyIsLh7ty4PiS5HnaLtdQKyX1AS6TAldCbnyOE3xJRbs
Message-ID: <CAE8KmOxmw3nthEXDh2zQQEtKyeNN0mPnFRhzM1ZgCUCkZpTefg@mail.gmail.com>
Subject: Re: [PATCH v4 17/31] i386/sev: add migration blockers only once
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 12 Feb 2026 at 14:07, Ani Sinha <anisinha@redhat.com> wrote:
> Maybe we could do something like this (I have not tested it) but perhaps outside the scope of this change set:
>
> diff --git a/migration/migration.c b/migration/migration.c
> index b103a82fc0..7d85821315 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1696,8 +1696,11 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
>  {
>      for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>          if (modes & BIT(mode)) {
> -            migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
> -                                                       *reasonp);
> +            if (g_slist_index(migration_blockers[mode],
> +                                 *reasonp) == -1) {
> +                migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
> +                                                           *reasonp);
> +            }
>          }
>      }
>      return 0;

* Yes, and when g_slist_index() returns >= 0,  return -1 OR an
indication that the blocker (address) already exists in the list. That
way other such instances where the same blocker is added multiple
times will be caught.

* But let's make it a separate patch. Restrict current patch to
removing add_clocker calls from sev_*_launch_finish() calls.

Thank you.
---
  - Prasad



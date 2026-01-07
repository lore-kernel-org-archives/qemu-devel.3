Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8F6CD5858
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 11:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdRRv-0006Rs-Nv; Wed, 07 Jan 2026 06:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdRRu-0006Ov-4f
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdRRs-0006bQ-81
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767784289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pIJr8XZetRiaQhjtU45+eLsR6u1F4r9ho6P+pDuRufQ=;
 b=VR3rcsVOMLhtUsrx0ym7HzdeanUrP8K5HKuOkaNjifOlILmz9fBZpm21yz0NmHwVkkW/30
 ybeINczIZKVwKAUc2rW7H4PwEnfJ6vYz79+qfagCVJkef5rX1Z6Zup6XM5yu8MNRJzjjFB
 ODzPd26ToTAd/uNl7m4hnemwQS8kNBA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-e01KwiijM9CzCLhH3mSy4w-1; Wed, 07 Jan 2026 06:11:28 -0500
X-MC-Unique: e01KwiijM9CzCLhH3mSy4w-1
X-Mimecast-MFC-AGG-ID: e01KwiijM9CzCLhH3mSy4w_1767784287
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47775585257so13584645e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 03:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767784286; x=1768389086; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pIJr8XZetRiaQhjtU45+eLsR6u1F4r9ho6P+pDuRufQ=;
 b=cxsfxKCcKK1XaEbmus+0ODsdXozEEfb4ZGQUlwq6/LaA9HBbXGagQzzcrdFmswVuMM
 0q6mv2xZ6xBZlBiHyVFzgzy9ZseauNhd12q7cEDu9/dpZmHvj9UQTyY+Q+JpfDSQ237I
 S6b1BoH2C39SkFlyP6loRxCkyYrqkQ9E7MjTBmcmrfqyGiWh5FKXM0I1MOEtsf7aK8qB
 Dhdo6vmVdRrKA6xW61g9E2T/mYg9nrqCZNgwflbe9uGc/CuNOjhveN1HI42mINQwHVaR
 diFI1B0QM0RXEK1uLNT2lhYNpK0csRsPI33PH02ViuuIrePmGd24DsCKflFvQ3x49ppK
 qSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767784286; x=1768389086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIJr8XZetRiaQhjtU45+eLsR6u1F4r9ho6P+pDuRufQ=;
 b=ha0E4eNgFqoa/Usbygjwho0/UMWA4HgwzPMHYjmjVEL++fbD1ZR0SPRWDJNoUmcV8f
 sz280kjiCZcnLahqOK3xps8kSJw+nTMnI6ZtrgUMGwCKl+VHV+iyriX6tNCCmSZu4KTA
 UKF/Qlu8x6vz+7BexQiwul+02qcu0WRjUumn/DUY0y9v6aE4RJZYWhQrEJW/bIuFVLvn
 W5l1XoUXIErSuL89LPNSbxKRj7i61LHa+vCNLCDWf/fJoO9vAvmP2/5ZsTe0kux6LJBL
 YTlJfFgCD693RG4ovUTy6fyZpSKci5iCXSOwDdtOOR5h9SV4bCstO6b0PW8OTGdGjXF3
 cUlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1LIqf3m1GtfJzCoZ7ikU8V7kgWjTTBT5xzJWTd2JeivUEEMHRj1os31IZZ1hUezOWMpEW4JwgnO1t@nongnu.org
X-Gm-Message-State: AOJu0Yxaz0WfvCBa5gYZcPnww9FnNtnPXDhjM66UXEMr+qY/C5QRU9Mf
 LmUlueAZdFXCWjjRxaMXekE8xRXwVaW8o8GKXARwjh/VWVISmWlIsODI/iK+2spLrG4SAmNls9i
 G1gFLWO1mpWwpdp/pl/+Z7qEFzUZE52dZNmHxQPJNdA+RPzZGDItVB+/RR7V3byV9u8OQxAYLCv
 ij3zLSTZTagTj1GWgujduilNOuP59xNI/xLwfI6oA=
X-Gm-Gg: AY/fxX6Ae1QBtL/793Q1a/St7kAp+I2On2OxM5b/ff6//RczY5FejLkX6ZpDCdTT6bb
 UvKz2mv7hIync8PTtqQSMKZus3e8QccrMIVWSQSmYola4/QCbev+vJ/tj9lYB9nLpVunYwDFSI2
 h6ReqZZiKTeipwWYw29X62s4F2vX90U7MP7mIcHkjgmdlOnrA8TBTHhjpV9pQRKcucx2c=
X-Received: by 2002:a05:600c:4f93:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-47d84b3bd91mr23994395e9.31.1767784286077; 
 Wed, 07 Jan 2026 03:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeFb03kuvidlsI263nqe5TO05Mm66qJvG7smACGgh6ZbiW9R9Gt8ei2Ep/F2SPkBalTaoH1M65S9X7MdocBiE=
X-Received: by 2002:a05:600c:4f93:b0:477:7b16:5f9f with SMTP id
 5b1f17b1804b1-47d84b3bd91mr23994075e9.31.1767784285727; Wed, 07 Jan 2026
 03:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
 <aV0lj8ShJufwRY8z@x1.local>
In-Reply-To: <aV0lj8ShJufwRY8z@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 7 Jan 2026 16:41:09 +0530
X-Gm-Features: AQt7F2oaDpS9SJEYxKOfIPoj9vpD1fPdfUtnWD7RvTEC7ik0XEJFK0Zn_jbG58Q
Message-ID: <CAE8KmOw+0dXcON1_VTBY2i6aE0So-MGDtxLmhvtLZWGM6TPxQA@mail.gmail.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jiri Denemark <jdenemar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 6 Jan 2026 at 20:39, Peter Xu <peterx@redhat.com> wrote:
> Copying Dan and Jiri in case ...

* Thank you for copying.

>>           } else if (s->current_state == ACTIVE && s->trigger == 'error-occurred') {
>>               s->current_state = STOP
>>               s->reason = "Error occurred, migration failed"
>
> We can't change status that were already used, like FAILED.  Libvirt and
> all mgmt may rely on it.

* True; If we decide to go in that direction, we'll have to tell
libvirtd(8) and others about new states.

> Personally I don't see much benefit on adding a new "trigger" internal API.
> If we want to forbid some state machine transitions, we can use a
> transition map.  Said that, IMHO it's separate from what we're discussing
> here.

* If we can reduce/rationalise the current 17-18 states and related
complexity, it'll help to simplify things.

Thank you.
---
  - Prasad



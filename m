Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB99C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 06:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAl53-0001VS-5g; Sat, 25 May 2024 02:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sAl4z-0001Ur-V9
 for qemu-devel@nongnu.org; Sat, 25 May 2024 02:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sAl4x-00026l-V3
 for qemu-devel@nongnu.org; Sat, 25 May 2024 02:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716619230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PWz0VPKivQgYMOAOLNnJBTfKryZ+OVimvV8uZMjbeiM=;
 b=eHhuYmw3FEVZ6SzFpBaMHozU+JzheQbLO0v0rtqDXQlHnxlrA8IRBPQKgobMeQS4n5wqYF
 j/w/ND53f2xXOX38g1Dg+RYMrLYVEDb0o4GwRXYbQxvse0h9+1WB8xaAbdmuVdMXCo/vRl
 1AibQETEvZsGgw4WnA0Hw3EIHd9oHPw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-6piba_jIOSCb2eRrinON9Q-1; Sat, 25 May 2024 02:40:28 -0400
X-MC-Unique: 6piba_jIOSCb2eRrinON9Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2e7bbbd9926so30282341fa.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 23:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716619227; x=1717224027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PWz0VPKivQgYMOAOLNnJBTfKryZ+OVimvV8uZMjbeiM=;
 b=iLDnT50255VKtmA4iLwmvt6C/IjkKxSJOtZd/N3vqyFnFSQE+viHwwnDPvEewX3o/j
 IkIM32cGT9KIOHlbk+tNZ6Fud8PEAUKLc3CMQidaN9h4h9dnax9dk5tE1WokUs962rq7
 jl4WFiEtV/etiZea61Q+WAU7EC2jBk5tuGEqhwO+NFNfNnOnIsqZzKQXMiqeeofvZ6g2
 MwX4QXzHlIvDwxYqrpZe8IpplWX0yF5Wg+BvA6jmpYi+UmNVve0SWmQHDBd+lghAWlVu
 quA0sLsEApPMas0kI1sT7TqYTrJnzCV8KRl4i/jF3H2DTdczYB1QQG2TYJEC+EqCpw35
 xWQA==
X-Gm-Message-State: AOJu0YwvaStF3IeRoTm3acurhardtPTHLwrTBgoj16UP3aiuxCqrCmPm
 ie4+nYkx/GbLpbhTBwWG+F5i/VH3gND4nls8OAOn1L0ihSMF9ykRZVDqp6QD8h7ZMEtDjxaZfut
 MGVZSwRusXh/hoKVH0ZtzN6KZEbSRyhNophcfml7ejm1Ftzjs8tTwgVMTelJ/81OjbzxXSt81PI
 05Btmfsa7wT/aimVGRY/RRzTnUWNA=
X-Received: by 2002:a2e:9899:0:b0:2e6:d1fb:4470 with SMTP id
 38308e7fff4ca-2e95b256316mr36599521fa.42.1716619227328; 
 Fri, 24 May 2024 23:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElIJ6fBMOmQxWryInng6jEBxkqBzY9fr2GkqEzJlJPZq+0fnMeXtU1r2xhnCWiWNpCXysTbSxElMrtL+thMWY=
X-Received: by 2002:a2e:9899:0:b0:2e6:d1fb:4470 with SMTP id
 38308e7fff4ca-2e95b256316mr36599391fa.42.1716619226840; Fri, 24 May 2024
 23:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716531409.git.yong.huang@smartx.com>
 <878c8f093f3fc2f584b5c31cb2490d9f6a12131a.1716531409.git.yong.huang@smartx.com>
 <CAE8KmOyXhvYHOw2MOSbwSetC7jyFNFsf0E81O0wQ1WEGGXY-TQ@mail.gmail.com>
 <CAK9dgmZOSTQhhJjXN32MupjW9o+3HTPnwNgYhx4Z-mY6kVYGHg@mail.gmail.com>
In-Reply-To: <CAK9dgmZOSTQhhJjXN32MupjW9o+3HTPnwNgYhx4Z-mY6kVYGHg@mail.gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Sat, 25 May 2024 12:10:10 +0530
Message-ID: <CAE8KmOyro4Bd3HWH=aNAZxnY3-x_Hd1tx+Chy+FrrdMJx96_nA@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi-disk: Fix crash for VM configured with USB CDROM
 after live migration
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On Fri, 24 May 2024 at 16:23, Yong Huang <yong.huang@smartx.com> wrote:
> I'm not testing the latest QEMU version while theoretically it is
> reproducible, I'll check it and give a conclusion.

* Yes, that'll help. Thank you.

> I'm not sure this usage is common but in our production environment, it is used.

* I see. If it's being used in a production environment and the crash
occurs there, then it's a reasonable change.

 > IMHO, resetting the CDROM device may be a work around because
> the request SHOULD not be lost. No requests are found may be
> caused by other reasons, resetting the CD ROM seems crude.
> The path that executes the scsi_get_buf() is in a USB mass storage
> device,  and it called by the UHCI controller originally, which just
> handles the Frame List blindly, reset solution is kind of complicated
> in implementation
>
> Migrating the requests may be a graceful solution.

* Yes, true. Migration should migrate guest's devices along with their
state and data. Resetting was suggested for the case if CDROM is not
used in production and so the migration was not required. But you are
using it in a production environment so migrating SCSI requests makes
sense.

Thank you.
---
  - Prasad



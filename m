Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10ED9CDB46B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 01:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJiyG-0006Up-HQ; Thu, 13 Nov 2025 20:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJiy6-0006Oj-M4
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 20:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJiy4-00026c-Dh
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 20:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763085074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFgB1I5EdDPflvLBdvRHWvpGkkCJZZeZwh1JH6ASIEU=;
 b=Xs1raVlxmo2sCTOp7IKqdy1aFtS+XrEQn3U7NKYe/EFPTYE0Bj3fkKM8xolonXFfwGEQML
 5KFEp3XAKh9RVu88cP8NQsbdMxAusO/3iGc5pLkVlIPyVBiuFkTMIc/mssihH+lfbCgLhU
 uqvX4wD1nU1jiN5zGSN4cjk/m/5f5Rg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-NtwwRh2DMyqwcFfMFN1F9w-1; Thu, 13 Nov 2025 20:51:13 -0500
X-MC-Unique: NtwwRh2DMyqwcFfMFN1F9w-1
X-Mimecast-MFC-AGG-ID: NtwwRh2DMyqwcFfMFN1F9w_1763085072
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-343bf6ded5cso3410101a91.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 17:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763085072; x=1763689872; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFgB1I5EdDPflvLBdvRHWvpGkkCJZZeZwh1JH6ASIEU=;
 b=TY5NQeitBsqghj4tI+Rsep2UtEG56PnojkQfjXUhvwupwHnpiH616AzbosPnjelCRJ
 pgWQjIuJaeQfx1ja3lkRlAnuO2a6oExuEbHE8UfwcKSlj7vGocII4vOsY+YejKBNmBVJ
 waWxxbcWazjglZTBJtD1U9WtIeqkO+GS7llF6/4HsNETLmoXrzBuLqPIHmyM7P8vPQJE
 gLR2/IoU3TneznY1QHXZJGIKLZa+v/zcTCdpPzFqmmyfW9AySSVs/NL6HaD9g7vXewWi
 vB2+zNg2Q+9tcIYXs/opK1nSVgr490flvjz+LKiKv6VqqZ06maie0aVY2iAX3vP9MQNs
 DgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763085072; x=1763689872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aFgB1I5EdDPflvLBdvRHWvpGkkCJZZeZwh1JH6ASIEU=;
 b=OjKJbupk9ePS/c+txgX3zVUZNj+gpHIeNeJrSkF3CeSVIjCnvyNnEaKYSJjQBJUTfd
 oElZlpIS+IwCWSFEr48n9lCB7Q3NoyWFXd/UsAIHPDMFsovFVPCEEc5fKbU42cLUw9Y8
 oFiiKGj3nfezeaV5dngbfi6vWMme3z0kTmBlS+t1KUc+C42wxG2FPE9bGZZYL+bg84Nj
 kWs7NsL+A9MvtQPIPwwZSBz9xj/tj1bHqj4uO8bumGAf6/7skedMTJymtTwHQA/Mkkk8
 +a2A8LpXq0DHQq6VQZiaiVn9qgiIR7Z9YNiyA8XgLklpiJElhxYCTlVXZXCZRiZUfBEU
 axRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAjrdaawrj4N6kA5EOJOSd9fqAR67w6a4GfC2+2sBZ0l5mbxN/kZz6n9E9MM/RrZSqziPihloTG7+w@nongnu.org
X-Gm-Message-State: AOJu0YxwHCr3RXvt+1JNdTcSxPiJ8ecVF7lX7wiTKM69Yie6jgjnM/wT
 MTTQEqfeaXMNOE5n0tLbp6Kn6bmGcOwESiicrTSdSFqVolL9EL6rYUKY7Wm/zkd8LUFB4WT/eq0
 EPB0Hip0dJsL8Bs00yWUqx9Iqeu0UvYMAj3ZtcokzqVMEDc/BVDif92jz8NYB4g1razoJ4lAEWT
 zyB0VyTnK2QGT+iWteh2NliBwFOUF5qso=
X-Gm-Gg: ASbGncso+7IdAA/HudF1LfNEsMcJWNbpDEMcWOFfaR8g0lDhB6L+dvdWtRaTZdqAqeK
 r0d6XRKqpRFTyeYbYzeElYVjP+HztB76votmv9qKV6UK5wTxJMZD+xsQgVd9Ls481FA72biKOQE
 +zs4qwCKIKJ5aRoXpKnl5u8NjsSyTfrjRqRuhQK0s5+2DIvByXiqsIOoL6iQuIBXMy
X-Received: by 2002:a17:90b:1649:b0:330:a454:c31a with SMTP id
 98e67ed59e1d1-343fa76079fmr1231948a91.32.1763085071955; 
 Thu, 13 Nov 2025 17:51:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHVu+j0E9PQ3VhKl5r/6O32O1B1E1NEvpiGFStpMAyImZUDF2lgZEFIwVrUxhC9xX6N8xAdvQHh6uhv9nhES4=
X-Received: by 2002:a17:90b:1649:b0:330:a454:c31a with SMTP id
 98e67ed59e1d1-343fa76079fmr1231914a91.32.1763085071494; Thu, 13 Nov 2025
 17:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local> <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local> <20251113124207-mutt-send-email-mst@kernel.org>
 <aRYyTeNNIPW_WIJW@x1.local>
In-Reply-To: <aRYyTeNNIPW_WIJW@x1.local>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Nov 2025 09:51:00 +0800
X-Gm-Features: AWmQ_bmx4HWnmPuoQ414x2z86AB5wIVIvyOIC5iHIyoLjCudVB5xZ2L0VZJfC3I
Message-ID: <CACGkMEsZtgmreUbd8BJQb9V7V2Pw-dafjLao1aVxPowuM3LHng@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 qemu-devel@nongnu.org, farosas@suse.de, jinpu.wang@ionos.com, 
 thuth@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Fri, Nov 14, 2025 at 3:32=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Nov 13, 2025 at 12:46:55PM -0500, Michael S. Tsirkin wrote:
> > failing to start a perfectly good qemu which used to work
> > because you changed kernels is better than failing to migrate how?
> >
>
> I agree this is not pretty.
>
> The very original proposal was having extra features to be OFF by default=
,
> only allow explicit selections to enable them when the mgmt / user is awa=
re
> of the possible hosts to run on top.  That'll guarantee:
>
> (1) explicit failure whenever some unsupported cap is chosen on boot,
>
> (2) default setup should always assume no kernel dependency hence booting
> should be all fine,
>
> (3) since all features will be by default OFF or selected by the user wit=
h
> explicit cmdlines, VM ABI is guaranteed so that migration will work.
>
> But unfortunately that proposal was rejected.
>
> >
> > graceful downgrade with old kernels is the basics of good userspace
> > behaviour and has been for decades.
> >
> >
> > sure, let's work on a solution, just erroring out is more about blaming
> > the user. what is the user supposed to do when qemu fails to start?
>
> This is indeed a good question.  If with strict checks maybe we would at
> least want to make sure we throw explicit messages to let user know what =
to
> turn off.
>
> >
> >
> > first, formulate what exactly do you want to enable.
> >
> >
> >
> > for example, you have a set of boxes and you want a set of flags
> > to supply to guarantee qemu can migrate between them. is that it?
>
> Yes I think that's the case.
>
> That's also why I think the very original proposal still makes sense
> (having all defaults OFF when dependent on kernel), because only the mgmt
> knows the details about the cluster, so it may make more sense to select
> from the top which has the full knowledge base, explicitly enable some se=
ts
> of features (not only network, but also CPU feature bits and else).  Then
> the mgmt boots the VM, also knows where it can migrate explicitly.
>
> If all things are hidden then the mgmt is almost out of control of this.

+1

>
> That was rejected because there's the need to by default enable new
> features if ever possible.  In that case, IMHO Jason's soluion is spot on
> where it sits in the middle ground of both, allowing both to happen
> (auto-enable of new feats, while keeping VM ABI stablility).

Yes.

>
> So IIUC there will be a cluster, it may contain different groups of hosts=
,
> each group should have similar setups so that VMs can freely migrate
> between each other within the same group (but may not easily migratable
> across groups?).  But I don't think I know well on that part in practise.

Towards this, we may need to develop tools somewhere to report TAP
capability. Or as replied in another thread, developing software
fallback for new features, but it seems a burden.

>
> Dan might be a great source of input from that level.
>
> Thanks,
>
> --
> Peter Xu
>

Thanks


